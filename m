Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
 by mx.groups.io with SMTP id smtpd.web11.5514.1591727660437683144
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jun 2020 11:34:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=tqaCECyL;
 spf=pass (domain: gmail.com, ip: 209.85.166.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f48.google.com with SMTP id p20so23854143iop.11
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Jun 2020 11:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rNEGXypyFGNjUEtimK/MVDI8CRcB9PeUsNt6tkouKPg=;
        b=tqaCECyLBezxiHYBkD4JRs9U0uThv9aq5Uftug9WzJWQBHYDWwqOJcVqEwBOiwI4BL
         WDYwQuAM8hjhVRlHeLPqzB+Hf6yIffp97Wy6gCeoK5nv291mY7E3qjaUBMhM67GOshmt
         AdXGpzjOJUxLTv8Ddpz4RmwIw2uu+uDE/Yn1KM1yXb6/RiKqIASwwGZm4+vimx9yyXqy
         GNOyhOcnWhJrhmlr+2wxaQ1f9EiaOFHM2QY4BZoE+zjsGUiOtFY8MMK9VnQqp0Pg4lr/
         wD8Hfpr5LfuPHrzKNCeUe0V8Oh0nDU+XJdQC9BD9+NvgnxQ48/p+/Wx/56oj9hfozBtP
         OWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rNEGXypyFGNjUEtimK/MVDI8CRcB9PeUsNt6tkouKPg=;
        b=J/nWvsvokYgz8K/CqVdLo9uYhFK+2FJzjQ1pn3T40GVyWIGyFTNEOu54UQMv+hO6Vu
         ltD0kWju0AChDa0vnEc07QEfBlOtzcefqJFdMyK7F/nlkPIaauJhfmLtTT890Y+QuO/h
         1acvjOe3mRBDIzxiz4rRAcxHB80IF41WnrN2dXpfsObcFquc41rpM8TIbf/e+fdhXP1I
         G/9MJKDkxuDwT0JAzVPjoKRJQnRyLBe/qQW7T8WJbKiN+b/YgBQgZw8EurIvsztL+VaR
         usi44MS9gs85+EZriqkSvyujJJJygPPe1egLmkfcd7C2wfERgzseY562HEzzmDtOy/sA
         pTXw==
X-Gm-Message-State: AOAM530M70Y69VPYo9p5+BnyS8/7tgH/TtSRowTFSlrv9a6G22zNmOVr
	UWAPzQ8NbIl+jCDmmpRCnQU4UWUO
X-Google-Smtp-Source: ABdhPJyJCIer4Azqsa51iyNcdBXu196p6TMd+npWrUMfbKZFQlgy0VgbodWbUCq9jPhPmZOlPhfDfw==
X-Received: by 2002:a02:390b:: with SMTP id l11mr28242087jaa.54.1591727659399;
        Tue, 09 Jun 2020 11:34:19 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:6cec:510:bc9:611])
        by smtp.gmail.com with ESMTPSA id p5sm9342260ilg.88.2020.06.09.11.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 11:34:18 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 1/2] bitbake: siggen: Pass all data caches to hash functions
Date: Tue,  9 Jun 2020 13:34:14 -0500
Message-Id: <20200609183415.21914-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200609183415.21914-1-JPEWhacker@gmail.com>
References: <20200605181754.32883-1-JPEWhacker@gmail.com>
 <20200609183415.21914-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Passing all the data caches to the task hashing functions allows them to
correctly account for mcdepends in task signatures. This allows tasks to
be correctly re-run when a mcdepends changes.

By default, the legacy behavior is maintained for derived signature
generators by passing a special proxy object that can either be used to
access all multiconfigs or the legacy behavior. If a derived signature
generator is updated, it can set the supports_multiconfig_datacaces
property to instruct bitbake it deals with multiconfigs properly.

[YOCTO #13724]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py |  8 ++--
 bitbake/lib/bb/siggen.py   | 78 ++++++++++++++++++++++++++++++--------
 2 files changed, 67 insertions(+), 19 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 5b7dab8d79..adb34a8cf2 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1190,8 +1190,9 @@ class RunQueueData:
         return len(self.runtaskentries)
 
     def prepare_task_hash(self, tid):
-        bb.parse.siggen.prep_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches[mc_from_tid(tid)])
-        self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches[mc_from_tid(tid)])
+        dc = bb.parse.siggen.get_data_caches(self.dataCaches, mc_from_tid(tid))
+        bb.parse.siggen.prep_taskhash(tid, self.runtaskentries[tid].depends, dc)
+        self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, self.runtaskentries[tid].depends, dc)
         self.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(tid)
 
     def dump_data(self):
@@ -2305,7 +2306,8 @@ class RunQueueExecute:
                 if len(self.rqdata.runtaskentries[p].depends) and not self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
                     continue
                 orighash = self.rqdata.runtaskentries[tid].hash
-                newhash = bb.parse.siggen.get_taskhash(tid, self.rqdata.runtaskentries[tid].depends, self.rqdata.dataCaches[mc_from_tid(tid)])
+                dc = bb.parse.siggen.get_data_caches(self.rqdata.dataCaches, mc_from_tid(tid))
+                newhash = bb.parse.siggen.get_taskhash(tid, self.rqdata.runtaskentries[tid].depends, dc)
                 origuni = self.rqdata.runtaskentries[tid].unihash
                 newuni = bb.parse.siggen.get_unihash(tid)
                 # FIXME, need to check it can come from sstate at all for determinism?
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 4c8d81c5da..872333d7fd 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -38,6 +38,11 @@ class SignatureGenerator(object):
     """
     name = "noop"
 
+    # If the derived class supports multiconfig datacaches, set this to True
+    # The default is False for backward compatibility with derived signature
+    # generators that do not understand multiconfig caches
+    supports_multiconfig_datacaches = False
+
     def __init__(self, data):
         self.basehash = {}
         self.taskhash = {}
@@ -58,10 +63,10 @@ class SignatureGenerator(object):
     def get_unihash(self, tid):
         return self.taskhash[tid]
 
-    def prep_taskhash(self, tid, deps, dataCache):
+    def prep_taskhash(self, tid, deps, dataCaches):
         return
 
-    def get_taskhash(self, tid, deps, dataCache):
+    def get_taskhash(self, tid, deps, dataCaches):
         self.taskhash[tid] = hashlib.sha256(tid.encode("utf-8")).hexdigest()
         return self.taskhash[tid]
 
@@ -105,6 +110,38 @@ class SignatureGenerator(object):
     def set_setscene_tasks(self, setscene_tasks):
         return
 
+    @classmethod
+    def get_data_caches(cls, dataCaches, mc):
+        """
+        This function returns the datacaches that should be passed to signature
+        generator functions. If the signature generator supports multiconfig
+        caches, the entire dictionary of data caches is sent, otherwise a
+        special proxy is sent that support both index access to all
+        multiconfigs, and also direct access for the default multiconfig.
+
+        The proxy class allows code in this class itself to always use
+        multiconfig aware code (to ease maintenance), but derived classes that
+        are unaware of multiconfig data caches can still access the default
+        multiconfig as expected.
+
+        Do not override this function in derived classes; it will be removed in
+        the future when support for multiconfig data caches is mandatory
+        """
+        class DataCacheProxy(object):
+            def __init__(self):
+                pass
+
+            def __getitem__(self, key):
+                return dataCaches[key]
+
+            def __getattr__(self, name):
+                return getattr(dataCaches[mc], name)
+
+        if cls.supports_multiconfig_datacaches:
+            return dataCaches
+
+        return DataCacheProxy()
+
 class SignatureGeneratorBasic(SignatureGenerator):
     """
     """
@@ -200,7 +237,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         self.lookupcache = {}
         self.taskdeps = {}
 
-    def rundep_check(self, fn, recipename, task, dep, depname, dataCache):
+    def rundep_check(self, fn, recipename, task, dep, depname, dataCaches):
         # Return True if we should keep the dependency, False to drop it
         # We only manipulate the dependencies for packages not in the whitelist
         if self.twl and not self.twl.search(recipename):
@@ -218,37 +255,40 @@ class SignatureGeneratorBasic(SignatureGenerator):
             pass
         return taint
 
-    def prep_taskhash(self, tid, deps, dataCache):
+    def prep_taskhash(self, tid, deps, dataCaches):
 
         (mc, _, task, fn) = bb.runqueue.split_tid_mcfn(tid)
 
-        self.basehash[tid] = dataCache.basetaskhash[tid]
+        self.basehash[tid] = dataCaches[mc].basetaskhash[tid]
         self.runtaskdeps[tid] = []
         self.file_checksum_values[tid] = []
-        recipename = dataCache.pkg_fn[fn]
+        recipename = dataCaches[mc].pkg_fn[fn]
 
         self.tidtopn[tid] = recipename
 
         for dep in sorted(deps, key=clean_basepath):
-            (depmc, _, deptaskname, depfn) = bb.runqueue.split_tid_mcfn(dep)
-            if mc != depmc:
+            (depmc, _, _, depmcfn) = bb.runqueue.split_tid_mcfn(dep)
+            depname = dataCaches[depmc].pkg_fn[depmcfn]
+            if not self.supports_multiconfig_datacaches and mc != depmc:
+                # If the signature generator doesn't understand multiconfig
+                # data caches, any dependency not in the same multiconfig must
+                # be skipped for backward compatibility
                 continue
-            depname = dataCache.pkg_fn[depfn]
-            if not self.rundep_check(fn, recipename, task, dep, depname, dataCache):
+            if not self.rundep_check(fn, recipename, task, dep, depname, dataCaches):
                 continue
             if dep not in self.taskhash:
                 bb.fatal("%s is not in taskhash, caller isn't calling in dependency order?" % dep)
             self.runtaskdeps[tid].append(dep)
 
-        if task in dataCache.file_checksums[fn]:
+        if task in dataCaches[mc].file_checksums[fn]:
             if self.checksum_cache:
-                checksums = self.checksum_cache.get_checksums(dataCache.file_checksums[fn][task], recipename, self.localdirsexclude)
+                checksums = self.checksum_cache.get_checksums(dataCaches[mc].file_checksums[fn][task], recipename, self.localdirsexclude)
             else:
-                checksums = bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename, self.localdirsexclude)
+                checksums = bb.fetch2.get_file_checksums(dataCaches[mc].file_checksums[fn][task], recipename, self.localdirsexclude)
             for (f,cs) in checksums:
                 self.file_checksum_values[tid].append((f,cs))
 
-        taskdep = dataCache.task_deps[fn]
+        taskdep = dataCaches[mc].task_deps[fn]
         if 'nostamp' in taskdep and task in taskdep['nostamp']:
             # Nostamp tasks need an implicit taint so that they force any dependent tasks to run
             if tid in self.taints and self.taints[tid].startswith("nostamp:"):
@@ -259,14 +299,14 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 taint = str(uuid.uuid4())
                 self.taints[tid] = "nostamp:" + taint
 
-        taint = self.read_taint(fn, task, dataCache.stamp[fn])
+        taint = self.read_taint(fn, task, dataCaches[mc].stamp[fn])
         if taint:
             self.taints[tid] = taint
             logger.warning("%s is tainted from a forced run" % tid)
 
         return
 
-    def get_taskhash(self, tid, deps, dataCache):
+    def get_taskhash(self, tid, deps, dataCaches):
 
         data = self.basehash[tid]
         for dep in self.runtaskdeps[tid]:
@@ -640,6 +680,12 @@ class SignatureGeneratorTestEquivHash(SignatureGeneratorUniHashMixIn, SignatureG
         self.server = data.getVar('BB_HASHSERVE')
         self.method = "sstate_output_hash"
 
+#
+# Dummy class used for bitbake-selftest
+#
+class SignatureGeneratorTestMulticonfigDepends(SignatureGeneratorBasicHash):
+    name = "TestMulticonfigDepends"
+    supports_multiconfig_datacaches = True
 
 def dump_this_task(outfile, d):
     import bb.parse
-- 
2.26.2

