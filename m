Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157C4C77B75
	for <webhook@archiver.kernel.org>; Tue,  9 May 2023 14:12:53 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.33621.1683641564008790523
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 May 2023 07:12:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=iS+jXP0n;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3062b101ae1so3787469f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 May 2023 07:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683641562; x=1686233562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6iEgqXhWdGaKvW7sIzZynI0SqkEoQRAJCRNvGxSmZrA=;
        b=iS+jXP0n/ngRbH5+gXokyrn4ktgCp/7mI7w3PF+pg4293HQtFMtSVxHp79EDgelJwx
         QdB9C+uXkJu2eESqddG22ixdYyZh99xk8o7fM3CKmzqKbPUmhbzKaRT0W4eNX/Q7TwAN
         DQMDv+wM3RiLJZWijm+GAvisqGEB33l6Et/+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683641562; x=1686233562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6iEgqXhWdGaKvW7sIzZynI0SqkEoQRAJCRNvGxSmZrA=;
        b=OWhLPIgG62e4So8rOKOQ7Y2AU7g6cdaSxD1zhiXu/WkyHPSwC4oZyCiawyeHsIqNRV
         gAU+vphFn8rDCSv1aYBaDG/p5Kee70jz1EnnWA48mPSQ3c8qWaXsSbrs4ydW2q/RhOO0
         hILzao9btAStLM9fNcY+DYwAl6XZG9pDatu3fyrKYfRHImA5q6ZbqABD/77IgJIWwIR6
         Icg261F4zoXjFdra3t/kwXGUB4FSB5WXHzJzSUOC8Itp8Giw3XK4tBfRAvVqmfbbhN37
         +dAf5W7fYGuW0PP6zvQ35NzZDrI9mkWC2YZYqKc68Sa1s++7Ix7tcNIhPiL4da3P8Jhx
         BWTA==
X-Gm-Message-State: AC+VfDzetD4Nm2fYJjw3G12eK90vwh/zT65qwFLMgU35AJNDlmcUiqAr
	CZJ7oOAI873sm8FYR/JXhlIJGK3AhOAhV4bdXOs=
X-Google-Smtp-Source: ACHHUZ5b+9p8YWBNoaoZSXpFZas5gV0/8GcFuekxumIq3wIKagjkVWuaHihGVFWWf4rjX3upCg/I2A==
X-Received: by 2002:adf:e74b:0:b0:307:a8e8:ca80 with SMTP id c11-20020adfe74b000000b00307a8e8ca80mr939561wrn.18.1683641561874;
        Tue, 09 May 2023 07:12:41 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3fe4:180c:477:99f])
        by smtp.gmail.com with ESMTPSA id r12-20020a5d494c000000b003077f3dfcc8sm13806816wrs.32.2023.05.09.07.12.41
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 07:12:41 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Add FILE_LAYERNAME variable containing the layername for a recipe
Date: Tue,  9 May 2023 15:12:40 +0100
Message-Id: <20230509141240.1677532-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 May 2023 14:12:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14770

There are times when it would be useful for code to know which layer
(or collection in old bitbake terms) it is contained within.

Add support for FILE_LAYERNAME to be set by bitbake when parsing a recipe
so that it is possible to determine this. To do it, we need to pass data
from the cooker into the recipe endpoints, since only the top level cooker
information knows about the layer structure which makes the patch a bit
painful.

The idea is that this would make layer overrides possible:

OVERRIDES .= ":layer-${FILE_LAYERNAME}"

which then opens possibilities like:

WARN_QA:append:layer-core = " patch-fuzz"

as an example where OE-Core could enable specific QA tests only for that
specific layer.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker   |  3 ++-
 lib/bb/cache.py      |  4 ++--
 lib/bb/command.py    |  5 +++--
 lib/bb/cooker.py     | 32 ++++++++++++++++++--------------
 lib/bb/cookerdata.py | 17 +++++++++--------
 lib/bb/runqueue.py   |  2 ++
 6 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index d743ff5105..451e6926bf 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -151,6 +151,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
     taskhash = runtask['taskhash']
     unihash = runtask['unihash']
     appends = runtask['appends']
+    layername = runtask['layername']
     taskdepdata = runtask['taskdepdata']
     quieterrors = runtask['quieterrors']
     # We need to setup the environment BEFORE the fork, since
@@ -262,7 +263,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
                     bb.parse.siggen.set_taskhashes(workerdata["newhashes"])
                 ret = 0
 
-                the_data = databuilder.parseRecipe(fn, appends)
+                the_data = databuilder.parseRecipe(fn, appends, layername)
                 the_data.setVar('BB_TASKHASH', taskhash)
                 the_data.setVar('BB_UNIHASH', unihash)
                 bb.parse.siggen.setup_datacache_from_datastore(fn, the_data)
diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 10910a6809..5ea41c5de0 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -514,11 +514,11 @@ class Cache(object):
 
         return len(self.depends_cache)
 
-    def parse(self, filename, appends):
+    def parse(self, filename, appends, layername):
         """Parse the specified filename, returning the recipe information"""
         self.logger.debug("Parsing %s", filename)
         infos = []
-        datastores = self.databuilder.parseRecipeVariants(filename, appends, mc=self.mc)
+        datastores = self.databuilder.parseRecipeVariants(filename, appends, mc=self.mc, layername=layername)
         depends = []
         variants = []
         # Process the "real" fn last so we can store variants list
diff --git a/lib/bb/command.py b/lib/bb/command.py
index 9e2cdc5c75..a355f56c60 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -561,6 +561,7 @@ class CommandsSync:
                 appendfiles = command.cooker.collections[mc].get_file_appends(fn)
         else:
             appendfiles = []
+        layername = command.cooker.collections[mc].calc_bbfile_priority(fn)[2]
         # We are calling bb.cache locally here rather than on the server,
         # but that's OK because it doesn't actually need anything from
         # the server barring the global datastore (which we have a remote
@@ -568,10 +569,10 @@ class CommandsSync:
         if config_data:
             # We have to use a different function here if we're passing in a datastore
             # NOTE: we took a copy above, so we don't do it here again
-            envdata = command.cooker.databuilder._parse_recipe(config_data, fn, appendfiles, mc)['']
+            envdata = command.cooker.databuilder._parse_recipe(config_data, fn, appendfiles, mc, layername)['']
         else:
             # Use the standard path
-            envdata = command.cooker.databuilder.parseRecipe(fn, appendfiles)
+            envdata = command.cooker.databuilder.parseRecipe(fn, appendfiles, layername)
         idx = command.remotedatastores.store(envdata)
         return DataStoreConnectionHandle(idx)
     parseRecipeFile.readonly = True
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 554c7f10a5..3e298c478b 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -640,7 +640,8 @@ class BBCooker:
 
         if fn:
             try:
-                envdata = self.databuilder.parseRecipe(fn, self.collections[mc].get_file_appends(fn))
+                layername = self.collections[mc].calc_bbfile_priority(fn)[2]
+                envdata = self.databuilder.parseRecipe(fn, self.collections[mc].get_file_appends(fn), layername)
             except Exception as e:
                 parselog.exception("Unable to read %s", fn)
                 raise
@@ -1445,7 +1446,8 @@ class BBCooker:
 
         bb_caches = bb.cache.MulticonfigCache(self.databuilder, self.data_hash, self.caches_array)
 
-        infos = bb_caches[mc].parse(fn, self.collections[mc].get_file_appends(fn))
+        layername = self.collections[mc].calc_bbfile_priority(fn)[2]
+        infos = bb_caches[mc].parse(fn, self.collections[mc].get_file_appends(fn), layername)
         infos = dict(infos)
 
         fn = bb.cache.realfn2virtual(fn, cls, mc)
@@ -1833,10 +1835,10 @@ class CookerCollectFiles(object):
         self.bbfile_config_priorities = sorted(priorities, key=lambda tup: tup[1], reverse=True)
 
     def calc_bbfile_priority(self, filename):
-        for _, _, regex, pri in self.bbfile_config_priorities:
+        for layername, _, regex, pri in self.bbfile_config_priorities:
             if regex.match(filename):
-                return pri, regex
-        return 0, None
+                return pri, regex, layername
+        return 0, None, None
 
     def get_bbfiles(self):
         """Get list of default .bb files by reading out the current directory"""
@@ -2009,7 +2011,7 @@ class CookerCollectFiles(object):
         # Calculate priorities for each file
         for p in pkgfns:
             realfn, cls, mc = bb.cache.virtualfn2realfn(p)
-            priorities[p], regex = self.calc_bbfile_priority(realfn)
+            priorities[p], regex, _ = self.calc_bbfile_priority(realfn)
             if regex in unmatched_regex:
                 matched_regex.add(regex)
                 unmatched_regex.remove(regex)
@@ -2146,7 +2148,7 @@ class Parser(multiprocessing.Process):
             self.results.close()
             self.results.join_thread()
 
-    def parse(self, mc, cache, filename, appends):
+    def parse(self, mc, cache, filename, appends, layername):
         try:
             origfilter = bb.event.LogHandler.filter
             # Record the filename we're parsing into any events generated
@@ -2160,7 +2162,7 @@ class Parser(multiprocessing.Process):
             bb.event.set_class_handlers(self.handlers.copy())
             bb.event.LogHandler.filter = parse_filter
 
-            return True, mc, cache.parse(filename, appends)
+            return True, mc, cache.parse(filename, appends, layername)
         except Exception as exc:
             tb = sys.exc_info()[2]
             exc.recipe = filename
@@ -2200,10 +2202,11 @@ class CookerParser(object):
         for mc in self.cooker.multiconfigs:
             for filename in self.mcfilelist[mc]:
                 appends = self.cooker.collections[mc].get_file_appends(filename)
+                layername = self.cooker.collections[mc].calc_bbfile_priority(filename)[2]
                 if not self.bb_caches[mc].cacheValid(filename, appends):
-                    self.willparse.add((mc, self.bb_caches[mc], filename, appends))
+                    self.willparse.add((mc, self.bb_caches[mc], filename, appends, layername))
                 else:
-                    self.fromcache.add((mc, self.bb_caches[mc], filename, appends))
+                    self.fromcache.add((mc, self.bb_caches[mc], filename, appends, layername))
 
         self.total = len(self.fromcache) + len(self.willparse)
         self.toparse = len(self.willparse)
@@ -2314,7 +2317,7 @@ class CookerParser(object):
             self.syncthread.join()
 
     def load_cached(self):
-        for mc, cache, filename, appends in self.fromcache:
+        for mc, cache, filename, appends, layername in self.fromcache:
             infos = cache.loadCached(filename, appends)
             yield False, mc, infos
 
@@ -2417,9 +2420,10 @@ class CookerParser(object):
         bb.cache.SiggenRecipeInfo.reset()
         to_reparse = set()
         for mc in self.cooker.multiconfigs:
-            to_reparse.add((mc, filename, self.cooker.collections[mc].get_file_appends(filename)))
+            layername = self.cooker.collections[mc].calc_bbfile_priority(filename)[2]
+            to_reparse.add((mc, filename, self.cooker.collections[mc].get_file_appends(filename), layername))
 
-        for mc, filename, appends in to_reparse:
-            infos = self.bb_caches[mc].parse(filename, appends)
+        for mc, filename, appends, layername in to_reparse:
+            infos = self.bb_caches[mc].parse(filename, appends, layername)
             for vfn, info_array in infos:
                 self.cooker.recipecaches[mc].add_from_recipeinfo(vfn, info_array)
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index adde0e7444..42b8d64685 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -494,8 +494,9 @@ class CookerDataBuilder(object):
         return data
 
     @staticmethod
-    def _parse_recipe(bb_data, bbfile, appends, mc=''):
+    def _parse_recipe(bb_data, bbfile, appends, mc, layername):
         bb_data.setVar("__BBMULTICONFIG", mc)
+        bb_data.setVar("FILE_LAYERNAME", layername)
 
         bbfile_loc = os.path.abspath(os.path.dirname(bbfile))
         bb.parse.cached_mtime_noerror(bbfile_loc)
@@ -505,7 +506,7 @@ class CookerDataBuilder(object):
         bb_data = bb.parse.handle(bbfile, bb_data)
         return bb_data
 
-    def parseRecipeVariants(self, bbfile, appends, virtonly=False, mc=None):
+    def parseRecipeVariants(self, bbfile, appends, virtonly=False, mc=None, layername=None):
         """
         Load and parse one .bb build file
         Return the data and whether parsing resulted in the file being skipped
@@ -515,32 +516,32 @@ class CookerDataBuilder(object):
             (bbfile, virtual, mc) = bb.cache.virtualfn2realfn(bbfile)
             bb_data = self.mcdata[mc].createCopy()
             bb_data.setVar("__ONLYFINALISE", virtual or "default")
-            datastores = self._parse_recipe(bb_data, bbfile, appends, mc)
+            datastores = self._parse_recipe(bb_data, bbfile, appends, mc, layername)
             return datastores
 
         if mc is not None:
             bb_data = self.mcdata[mc].createCopy()
-            return self._parse_recipe(bb_data, bbfile, appends, mc)
+            return self._parse_recipe(bb_data, bbfile, appends, mc, layername)
 
         bb_data = self.data.createCopy()
-        datastores = self._parse_recipe(bb_data, bbfile, appends)
+        datastores = self._parse_recipe(bb_data, bbfile, appends, '', layername)
 
         for mc in self.mcdata:
             if not mc:
                 continue
             bb_data = self.mcdata[mc].createCopy()
-            newstores = self._parse_recipe(bb_data, bbfile, appends, mc)
+            newstores = self._parse_recipe(bb_data, bbfile, appends, mc, layername)
             for ns in newstores:
                 datastores["mc:%s:%s" % (mc, ns)] = newstores[ns]
 
         return datastores
 
-    def parseRecipe(self, virtualfn, appends):
+    def parseRecipe(self, virtualfn, appends, layername):
         """
         Return a complete set of data for fn.
         To do this, we need to parse the file.
         """
         logger.debug("Parsing %s (full)" % virtualfn)
         (fn, virtual, mc) = bb.cache.virtualfn2realfn(virtualfn)
-        bb_data = self.parseRecipeVariants(virtualfn, appends, virtonly=True)
+        bb_data = self.parseRecipeVariants(virtualfn, appends, virtonly=True, layername=layername)
         return bb_data[virtual]
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 02f1474540..1eac2da5e8 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2166,6 +2166,7 @@ class RunQueueExecute:
                 'unihash' : self.rqdata.get_task_unihash(task),
                 'quieterrors' : True,
                 'appends' : self.cooker.collections[mc].get_file_appends(taskfn),
+                'layername' : self.cooker.collections[mc].calc_bbfile_priority(taskfn)[2],
                 'taskdepdata' : self.sq_build_taskdepdata(task),
                 'dry_run' : False,
                 'taskdep': taskdep,
@@ -2259,6 +2260,7 @@ class RunQueueExecute:
                 'unihash' : self.rqdata.get_task_unihash(task),
                 'quieterrors' : False,
                 'appends' : self.cooker.collections[mc].get_file_appends(taskfn),
+                'layername' : self.cooker.collections[mc].calc_bbfile_priority(taskfn)[2],
                 'taskdepdata' : self.build_taskdepdata(task),
                 'dry_run' : self.rqdata.setscene_enforce,
                 'taskdep': taskdep,
-- 
2.39.2


