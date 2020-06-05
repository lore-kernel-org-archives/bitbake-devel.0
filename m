Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
 by mx.groups.io with SMTP id smtpd.web12.1090.1591381083803625907
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2020 11:18:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=SrhaZQy5;
 spf=pass (domain: gmail.com, ip: 209.85.214.196, mailfrom: jpewhacker@gmail.com)
Received: by mail-pl1-f196.google.com with SMTP id q16so4041363plr.2;
        Fri, 05 Jun 2020 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e2XQNOLdbQ810RAAwXBLlruecQeMehkYWrrdD81j1Cg=;
        b=SrhaZQy5R46CJNXNNccif8+rAFLdMyGe7Rximh8LyCRLVWeTOMwpaI8mFSWAUygH8+
         jT5DDSm3TIxdbSQiIaB+g9exxh/aAXUWqktM63gYGYWyFa3J07b6bVRPHOv4zSi99rfi
         niaMbvCk7sUn5T8GdCOd+hRN/fW+yFCXxTmutQX6SusWfpNCFXFQ9L0KgYUQIz4zU6Fy
         xI0IZyhxA9Khyrjkrh/1nDEIrUONaTuP/riUv4u3/uHPQnCNuVM8hxHcYy4nmUzCHAT8
         0cFq7tyPQsBZ4ih2UZkJYX2T1emf98YFizkUlw5bm+bNqQ2rZ5aIN38O6DxN5Rpee8pO
         9YCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e2XQNOLdbQ810RAAwXBLlruecQeMehkYWrrdD81j1Cg=;
        b=XeDsVVsoZb9zvff7pEamAFX1G3OeCip+i8YPDWzEwpTpL69YcFIrghg+G5GgGiRRGq
         UXmB016wE8Myzo3Xw24ohSR1Hy8lT91YKTtHlmeLEW+yZdtfaP86a2whLNrqY1TNHC8J
         bLyCgJLYgKAEXd8G23pH/Zr3wCeXFUIWHEpNLqTfJBrhgzCGjSl/C7R4XLs1jI7A3akg
         MWn4JrnpLUsDlgbAPFH4GNwKpfTZ6rIB6zX/RpircbpfV0VcLeNo4PhReFbUlaLfeOcq
         Gwm8YCGWaaDiWFEJQEDFFkWNirnFm6kIVoeqYmlvzHTN036ldNfpNeT9WFd6LlFoZrg+
         kZGg==
X-Gm-Message-State: AOAM533eZFzrPK0VtbukMeqU8tRPV5KGJk/aXIEIGNFJPawdKpR6wLiI
	BFKKUAVC5m7DsQxeJPE6hAVZTArr0oE=
X-Google-Smtp-Source: ABdhPJxgrpcUkmGaTbJiXwjY4DmalNFGXUlPbe7VBCpLOKVYY68xbr4oGYNkIugxFhxF+Rif0ZXZHw==
X-Received: by 2002:a17:902:b68d:: with SMTP id c13mr11015095pls.210.1591381082987;
        Fri, 05 Jun 2020 11:18:02 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:28:333f:5748:fb55])
        by smtp.gmail.com with ESMTPSA id g21sm246096pfh.134.2020.06.05.11.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:18:02 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [RFC PATCH 3/3] sstatesig: Account for all dataCaches being passed
Date: Fri,  5 Jun 2020 13:17:54 -0500
Message-Id: <20200605181754.32883-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605181754.32883-1-JPEWhacker@gmail.com>
References: <20200605181754.32883-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bitbake now passes all the dataCaches to the taskhash API, so use this
to correctly filter mcdepends.

[YOCTO #13724]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 meta/lib/oe/sstatesig.py | 77 +++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/meta/lib/oe/sstatesig.py b/meta/lib/oe/sstatesig.py
index d24e3738ae..55f305c3a9 100644
--- a/meta/lib/oe/sstatesig.py
+++ b/meta/lib/oe/sstatesig.py
@@ -2,9 +2,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 import bb.siggen
+import bb.runqueue
 import oe
 
-def sstate_rundepfilter(siggen, fn, recipename, task, dep, depname, dataCache):
+def sstate_rundepfilter(siggen, fn, recipename, task, dep, depname, dataCaches):
     # Return True if we should keep the dependency, False to drop it
     def isNative(x):
         return x.endswith("-native")
@@ -12,23 +13,26 @@ def sstate_rundepfilter(siggen, fn, recipename, task, dep, depname, dataCache):
         return "-cross-" in x
     def isNativeSDK(x):
         return x.startswith("nativesdk-")
-    def isKernel(fn):
-        inherits = " ".join(dataCache.inherits[fn])
+    def isKernel(mc, fn):
+        inherits = " ".join(dataCaches[mc].inherits[fn])
         return inherits.find("/module-base.bbclass") != -1 or inherits.find("/linux-kernel-base.bbclass") != -1
-    def isPackageGroup(fn):
-        inherits = " ".join(dataCache.inherits[fn])
+    def isPackageGroup(mc, fn):
+        inherits = " ".join(dataCaches[mc].inherits[fn])
         return "/packagegroup.bbclass" in inherits
-    def isAllArch(fn):
-        inherits = " ".join(dataCache.inherits[fn])
+    def isAllArch(mc, fn):
+        inherits = " ".join(dataCaches[mc].inherits[fn])
         return "/allarch.bbclass" in inherits
-    def isImage(fn):
-        return "/image.bbclass" in " ".join(dataCache.inherits[fn])
-
-    # (Almost) always include our own inter-task dependencies.
-    # The exception is the special do_kernel_configme->do_unpack_and_patch
-    # dependency from archiver.bbclass.
-    if recipename == depname:
-        if task == "do_kernel_configme" and dep.endswith(".do_unpack_and_patch"):
+    def isImage(mc, fn):
+        return "/image.bbclass" in " ".join(dataCaches[mc].inherits[fn])
+
+    depmc, _, deptaskname, depmcfn = bb.runqueue.split_tid_mcfn(dep)
+    mc, _ = bb.runqueue.split_mc(fn)
+
+    # (Almost) always include our own inter-task dependencies (unless it comes
+    # from a mcdepends). The exception is the special
+    # do_kernel_configme->do_unpack_and_patch dependency from archiver.bbclass.
+    if recipename == depname and depmc == mc:
+        if task == "do_kernel_configme" and deptaskname == "do_unpack_and_patch":
             return False
         return True
 
@@ -47,11 +51,11 @@ def sstate_rundepfilter(siggen, fn, recipename, task, dep, depname, dataCache):
     # Only target packages beyond here
 
     # allarch packagegroups are assumed to have well behaved names which don't change between architecures/tunes
-    if isPackageGroup(fn) and isAllArch(fn) and not isNative(depname):
+    if isPackageGroup(mc, fn) and isAllArch(mc, fn) and not isNative(depname):
         return False
 
     # Exclude well defined machine specific configurations which don't change ABI
-    if depname in siggen.abisaferecipes and not isImage(fn):
+    if depname in siggen.abisaferecipes and not isImage(mc, fn):
         return False
 
     # Kernel modules are well namespaced. We don't want to depend on the kernel's checksum
@@ -59,10 +63,9 @@ def sstate_rundepfilter(siggen, fn, recipename, task, dep, depname, dataCache):
     # is machine specific.
     # Therefore if we're not a kernel or a module recipe (inheriting the kernel classes)
     # and we reccomend a kernel-module, we exclude the dependency.
-    depfn = dep.rsplit(":", 1)[0]
-    if dataCache and isKernel(depfn) and not isKernel(fn):
-        for pkg in dataCache.runrecs[fn]:
-            if " ".join(dataCache.runrecs[fn][pkg]).find("kernel-module-") != -1:
+    if dataCaches and isKernel(depmc, depmcfn) and not isKernel(mc, fn):
+        for pkg in dataCaches[mc].runrecs[fn]:
+            if " ".join(dataCaches[mc].runrecs[fn][pkg]).find("kernel-module-") != -1:
                 return False
 
     # Default to keep dependencies
@@ -87,8 +90,8 @@ class SignatureGeneratorOEBasic(bb.siggen.SignatureGeneratorBasic):
         self.abisaferecipes = (data.getVar("SIGGEN_EXCLUDERECIPES_ABISAFE") or "").split()
         self.saferecipedeps = (data.getVar("SIGGEN_EXCLUDE_SAFE_RECIPE_DEPS") or "").split()
         pass
-    def rundep_check(self, fn, recipename, task, dep, depname, dataCache = None):
-        return sstate_rundepfilter(self, fn, recipename, task, dep, depname, dataCache)
+    def rundep_check(self, fn, recipename, task, dep, depname, dataCaches = None):
+        return sstate_rundepfilter(self, fn, recipename, task, dep, depname, dataCaches)
 
 class SignatureGeneratorOEBasicHashMixIn(object):
     def init_rundepcheck(self, data):
@@ -126,8 +129,8 @@ class SignatureGeneratorOEBasicHashMixIn(object):
             newsafedeps.append(a1 + "->" + a2)
         self.saferecipedeps = newsafedeps
 
-    def rundep_check(self, fn, recipename, task, dep, depname, dataCache = None):
-        return sstate_rundepfilter(self, fn, recipename, task, dep, depname, dataCache)
+    def rundep_check(self, fn, recipename, task, dep, depname, dataCaches = None):
+        return sstate_rundepfilter(self, fn, recipename, task, dep, depname, dataCaches)
 
     def get_taskdata(self):
         return (self.lockedpnmap, self.lockedhashfn, self.lockedhashes) + super().get_taskdata()
@@ -142,41 +145,41 @@ class SignatureGeneratorOEBasicHashMixIn(object):
         self.dump_lockedsigs(sigfile)
         return super(bb.siggen.SignatureGeneratorBasicHash, self).dump_sigs(dataCache, options)
 
-    def prep_taskhash(self, tid, deps, dataCache):
-        super().prep_taskhash(tid, deps, dataCache)
+    def prep_taskhash(self, tid, deps, dataCaches):
+        super().prep_taskhash(tid, deps, dataCaches)
         if hasattr(self, "extramethod"):
-            (_, _, _, fn) = bb.runqueue.split_tid_mcfn(tid)
-            inherits = " ".join(dataCache.inherits[fn])    
+            (mc, _, _, fn) = bb.runqueue.split_tid_mcfn(tid)
+            inherits = " ".join(dataCaches[mc].inherits[fn])
             if inherits.find("/native.bbclass") != -1 or inherits.find("/cross.bbclass") != -1:
                 self.extramethod[tid] = ":" + self.buildarch
 
-    def get_taskhash(self, tid, deps, dataCache):
+    def get_taskhash(self, tid, deps, dataCaches):
         if tid in self.lockedhashes:
             if self.lockedhashes[tid]:
                 return self.lockedhashes[tid]
             else:
-                return super().get_taskhash(tid, deps, dataCache)
+                return super().get_taskhash(tid, deps, dataCaches)
 
-        # get_taskhash will call get_unihash internally in the parent class, we 
+        # get_taskhash will call get_unihash internally in the parent class, we
         # need to disable our filter of it whilst this runs else
         # incorrect hashes can be calculated.
         self._internal = True
-        h = super().get_taskhash(tid, deps, dataCache)
+        h = super().get_taskhash(tid, deps, dataCaches)
         self._internal = False
 
         (mc, _, task, fn) = bb.runqueue.split_tid_mcfn(tid)
 
-        recipename = dataCache.pkg_fn[fn]
+        recipename = dataCaches[mc].pkg_fn[fn]
         self.lockedpnmap[fn] = recipename
-        self.lockedhashfn[fn] = dataCache.hashfn[fn]
+        self.lockedhashfn[fn] = dataCaches[mc].hashfn[fn]
 
         unlocked = False
         if recipename in self.unlockedrecipes:
             unlocked = True
         else:
             def recipename_from_dep(dep):
-                fn = bb.runqueue.fn_from_tid(dep)
-                return dataCache.pkg_fn[fn]
+                (depmc, _, _, depfn) = bb.runqueue.split_tid_mcfn(dep)
+                return dataCaches[depmc].pkg_fn[depfn]
 
             # If any unlocked recipe is in the direct dependencies then the
             # current recipe should be unlocked as well.
-- 
2.26.2

