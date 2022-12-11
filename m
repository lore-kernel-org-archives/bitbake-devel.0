Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB52C4332F
	for <webhook@archiver.kernel.org>; Sun, 11 Dec 2022 17:26:04 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.21905.1670779563327661004
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 11 Dec 2022 09:26:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GEgU1t03;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id n9-20020a05600c3b8900b003d0944dba41so3260453wms.4
        for <bitbake-devel@lists.openembedded.org>; Sun, 11 Dec 2022 09:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ftSvgnyaLq6OcndXAExQdRETwVqPALdyLwr5skwjlCY=;
        b=GEgU1t03wFJmC33jRzfsVzZZNnwKWt87MyMI0JTwHHowYcqkXrpIz9cIm/98gMcDd3
         eVrfJNwPbkojFeQ208VEU/TJO9llVnzOB5ta/Ik5mq7TMP8rjVxKiQ4cMwDVRt0uuzOq
         xTUzmKhZwwiJwCs7au34+JXDhgaKmbFpUYA6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftSvgnyaLq6OcndXAExQdRETwVqPALdyLwr5skwjlCY=;
        b=mNLI644oqU+VXlNbfMR6+FQGr7pmkY1tm0yeB5391huAulVkOU9PuhcWPXxPKSzVCP
         KZUjHOQnGKlynwD7zaSLqvYNoRulXKowChIyj1LMusVyuC4SVEZ/PnKZEKAvWBv4lRKx
         PXAa1L9vb8KOTq1xJQOYkjguJlB82wzG+QuqmRXysjLl/Is4QeKjaN+FyFuwirKeEIx5
         FmuD86GhvMeyxxKBGKGCcAbpP6sKgh9mZZCAhOWydvKpH2ReN1hgyr6MT+K/AkDB9u3s
         FAP2GCCFVM+JarxqtakH3EmN4Da9ykLf883dVa6PoFlHrqB0W6tBXR0VS8dyRmetbuIJ
         goiw==
X-Gm-Message-State: ANoB5pk1aybIKhLc9q4kfyKLVzpcZfy2eC+en0tCwfesGIv1tttFpjqF
	F0mjaHdIfq4pxho2rElcQWFfkyyAY19ZIU8R
X-Google-Smtp-Source: AA0mqf6ES8AnqM7BxlLB8gRxbsrygMVNUBB8I7ezfyRZg+sJsWxCr4ueV5UnQ4A2PhwyC+CFQ0IH+A==
X-Received: by 2002:a05:600c:1e8f:b0:3cf:728e:c224 with SMTP id be15-20020a05600c1e8f00b003cf728ec224mr10159217wmb.6.1670779561617;
        Sun, 11 Dec 2022 09:26:01 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:db5:b2f0:a022:4502])
        by smtp.gmail.com with ESMTPSA id l6-20020a1c7906000000b003cf4eac8e80sm7592804wme.23.2022.12.11.09.26.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 09:26:01 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/4] siggen: Add dummy dataCaches from task context/datastore
Date: Sun, 11 Dec 2022 17:25:56 +0000
Message-Id: <20221211172557.21956-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221211172557.21956-1-richard.purdie@linuxfoundation.org>
References: <20221211172557.21956-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 11 Dec 2022 17:26:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14173

One of the challenges in maintaining the code is that it sometimes uses
a datacaches structure and sometimes a datastore. Rather than continue
the current dual API madness, have the worker contexts create a dummy
datacaches structure with the entries we need. Whilst this does need to
be kept in sync with the real structure, that doesn't change and this
allows the code to be simplified.

With this new approach, we can unify the stamps dependency code again.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker |  1 +
 lib/bb/cooker.py   |  2 ++
 lib/bb/siggen.py   | 77 ++++++++++++++++++++++++----------------------
 3 files changed, 43 insertions(+), 37 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 3cacdb0cec..ed266f0ac2 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -266,6 +266,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
                 the_data = databuilder.parseRecipe(fn, appends)
                 the_data.setVar('BB_TASKHASH', taskhash)
                 the_data.setVar('BB_UNIHASH', unihash)
+                bb.parse.siggen.setup_datacache_from_datastore(fn, the_data)
 
                 bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN"), taskname.replace("do_", "")))
 
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 728ef09675..ac7ac20c04 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1448,6 +1448,8 @@ class BBCooker:
         self.recipecaches[mc].rundeps[fn] = defaultdict(list)
         self.recipecaches[mc].runrecs[fn] = defaultdict(list)
 
+        bb.parse.siggen.setup_datacache(self.recipecaches)
+
         # Invalidate task for target if force mode active
         if self.configuration.force:
             logger.verbose("Invalidate task %s, %s", task, fn)
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 6b73843c67..a63e37d22f 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -14,6 +14,7 @@ import bb.data
 import difflib
 import simplediff
 import json
+import types
 import bb.compress.zstd
 from bb.checksum import FileChecksumCache
 from bb import runqueue
@@ -73,6 +74,24 @@ class SignatureGenerator(object):
     def setup_datacache(self, datacaches):
         self.datacaches = datacaches
 
+    def setup_datacache_from_datastore(self, mcfn, d):
+        # In task context we have no cache so setup internal data structures
+        # from the fully parsed data store provided
+
+        mc = d.getVar("__BBMULTICONFIG", False) or ""
+        tasks = d.getVar('__BBTASKS', False)
+
+        self.datacaches = {}
+        self.datacaches[mc] = types.SimpleNamespace()
+        setattr(self.datacaches[mc], "stamp", {})
+        self.datacaches[mc].stamp[mcfn] = d.getVar('STAMP')
+        setattr(self.datacaches[mc], "stamp_extrainfo", {})
+        self.datacaches[mc].stamp_extrainfo[mcfn] = {}
+        for t in tasks:
+            flag = d.getVarFlag(t, "stamp-extra-info")
+            if flag:
+                self.datacaches[mc].stamp_extrainfo[mcfn][t] = flag
+
     def get_unihash(self, tid):
         return self.taskhash[tid]
 
@@ -138,12 +157,9 @@ class SignatureGeneratorBasic(SignatureGenerator):
         self.basehash = {}
         self.taskhash = {}
         self.unihash = {}
-        self.taskdeps = {}
         self.runtaskdeps = {}
         self.file_checksum_values = {}
         self.taints = {}
-        self.gendeps = {}
-        self.lookupcache = {}
         self.setscenetasks = set()
         self.basehash_ignore_vars = set((data.getVar("BB_BASEHASH_IGNORE_VARS") or "").split())
         self.taskhash_ignore_tasks = None
@@ -186,11 +202,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 bb.error("%s -Sprintdiff\n" % cmd)
             self.basehash[tid] = basehash[tid]
 
-        self.taskdeps[fn] = taskdeps
-        self.gendeps[fn] = gendeps
-        self.lookupcache[fn] = lookupcache
-
-        return taskdeps
+        return taskdeps, gendeps, lookupcache
 
     def set_setscene_tasks(self, setscene_tasks):
         self.setscenetasks = set(setscene_tasks)
@@ -202,7 +214,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             fn = bb.cache.realfn2virtual(fn, variant, mc)
 
         try:
-            taskdeps = self._build_data(fn, d)
+            taskdeps, gendeps, lookupcache = self._build_data(fn, d)
         except bb.parse.SkipRecipe:
             raise
         except:
@@ -218,18 +230,20 @@ class SignatureGeneratorBasic(SignatureGenerator):
             basehashes[task] = self.basehash[fn + ":" + task]
 
         d.setVar("__siggen_basehashes", basehashes)
-        d.setVar("__siggen_gendeps", self.gendeps[fn])
-        d.setVar("__siggen_varvals", self.lookupcache[fn])
-        d.setVar("__siggen_taskdeps", self.taskdeps[fn])
+        d.setVar("__siggen_gendeps", gendeps)
+        d.setVar("__siggen_varvals", lookupcache)
+        d.setVar("__siggen_taskdeps", taskdeps)
 
+    def setup_datacache_from_datastore(self, mcfn, d):
+        super().setup_datacache_from_datastore(mcfn, d)
 
-    def postparsing_clean_cache(self):
-        #
-        # After parsing we can remove some things from memory to reduce our memory footprint
-        #
-        self.gendeps = {}
-        self.lookupcache = {}
-        self.taskdeps = {}
+        mc = bb.runqueue.mc_from_tid(mcfn)
+        setattr(self.datacaches[mc], "siggen_varvals", {})
+        self.datacaches[mc].siggen_varvals[mcfn] = d.getVar("__siggen_varvals")
+        setattr(self.datacaches[mc], "siggen_taskdeps", {})
+        self.datacaches[mc].siggen_taskdeps[mcfn] = d.getVar("__siggen_taskdeps")
+        setattr(self.datacaches[mc], "siggen_gendeps", {})
+        self.datacaches[mc].siggen_gendeps[mcfn] = d.getVar("__siggen_gendeps")
 
     def rundep_check(self, fn, recipename, task, dep, depname, dataCaches):
         # Return True if we should keep the dependency, False to drop it
@@ -353,27 +367,16 @@ class SignatureGeneratorBasic(SignatureGenerator):
         data['task'] = task
         data['basehash_ignore_vars'] = self.basehash_ignore_vars
         data['taskhash_ignore_tasks'] = self.taskhash_ignore_tasks
-        if hasattr(self, "datacaches"):
-            data['taskdeps'] = self.datacaches[mc].siggen_taskdeps[fn][task]
-        else:
-            data['taskdeps'] = self.taskdeps[fn][task]
+        data['taskdeps'] = self.datacaches[mc].siggen_taskdeps[fn][task]
         data['basehash'] = self.basehash[tid]
         data['gendeps'] = {}
         data['varvals'] = {}
-        if hasattr(self, "datacaches"):
-            data['varvals'][task] = self.datacaches[mc].siggen_varvals[fn][task]
-            for dep in self.datacaches[mc].siggen_taskdeps[fn][task]:
-                if dep in self.basehash_ignore_vars:
-                   continue
-                data['gendeps'][dep] = self.datacaches[mc].siggen_gendeps[fn][dep]
-                data['varvals'][dep] = self.datacaches[mc].siggen_varvals[fn][dep]
-        else:
-            data['varvals'][task] = self.lookupcache[fn][task]
-            for dep in self.taskdeps[fn][task]:
-                if dep in self.basehash_ignore_vars:
-                    continue
-                data['gendeps'][dep] = self.gendeps[fn][dep]
-                data['varvals'][dep] = self.lookupcache[fn][dep]
+        data['varvals'][task] = self.datacaches[mc].siggen_varvals[fn][task]
+        for dep in self.datacaches[mc].siggen_taskdeps[fn][task]:
+            if dep in self.basehash_ignore_vars:
+               continue
+            data['gendeps'][dep] = self.datacaches[mc].siggen_gendeps[fn][dep]
+            data['varvals'][dep] = self.datacaches[mc].siggen_varvals[fn][dep]
 
         if runtime and tid in self.taskhash:
             data['runtaskdeps'] = self.runtaskdeps[tid]
-- 
2.37.2


