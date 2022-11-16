Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C49C433FE
	for <webhook@archiver.kernel.org>; Wed, 16 Nov 2022 00:06:30 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.863.1668557187025157741
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Nov 2022 16:06:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PtU5GB36;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso361357wma.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 15 Nov 2022 16:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MSxEpPdNCubm0mPUrSh2wIPBD6OrNlgA8ok7zMxGzW0=;
        b=PtU5GB36we0p8RCvEj6Fn3eHJ+Ix2mwuiwSIBlnko4KIyv042zQbl8fc0JlAQu1BsB
         X2b+gLV5jXMxAmPBiTQWaZTqc2Yf0VBy3JsYYKZ+Zz9em0OSzkcFdml9N95jEv95mrwM
         tMN9VV0WZH4yKJdnfKDxWsNj5rPn8pQvu3/wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSxEpPdNCubm0mPUrSh2wIPBD6OrNlgA8ok7zMxGzW0=;
        b=zOPAPelhJHEV4q1iyqDpAaW5XMKzQ9AEGwX8H17/RIunXPAj8jcKzlgiVHpj2tuKC4
         402VlSEkbpNgbpNVBQjqaNvSyAMqmlyCkboqNcMbqIXU1Sn8RNRvVpKY+I24Fd7WadBS
         B1dFXeslTQd173y98YzQ/WnEhxZLgIfxGp7AihlZCXJ8nKbAzgCgSstMsybwFSlY7llo
         e/MmogFwdJnkSxTd58VOgLN8PLVmP5tchN6+/oD/wxkjRVWV2/G8R+ihA3g8xxLrEW1k
         NZ/ClDDfy/BbMN1ePTqL/oegOHC3pViUo9f7B2HWrxq5UiW9gk8vzyERKAvllFAGQ442
         Wr7A==
X-Gm-Message-State: ANoB5pka9RiTdptF0HukabR1n2TD68uvjcIg2PWQRO1Ie1TDsHvdF5P/
	pxHeaVhFBBEXNof3BQifgC3uO74uc3pb+w==
X-Google-Smtp-Source: AA0mqf5IZ9GDk0FCQ/CuiuzSmlI4OI2CLo03mu+HVoIzmgBNFesgllY6OY+jPzxanQULAwYsWjF24Q==
X-Received: by 2002:a05:600c:2e51:b0:3cf:8a3a:9996 with SMTP id q17-20020a05600c2e5100b003cf8a3a9996mr409051wmf.89.1668557184236;
        Tue, 15 Nov 2022 16:06:24 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:6779:84d:e47:6803])
        by smtp.gmail.com with ESMTPSA id h3-20020a05600c2ca300b003b49bd61b19sm297422wmc.15.2022.11.15.16.06.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 16:06:23 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] cache/cookerdata: Move recipe parsing functions from cache to databuilder
Date: Wed, 16 Nov 2022 00:06:22 +0000
Message-Id: <20221116000622.2480508-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Nov 2022 00:06:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14085

When 'NoCache' was written, databuilder/cookerdata didn't exist. It does
now and the recipe parsing functionality contained in NoCache clearly
belongs there, it isn't a cache function. Move those functions, renaming
to match the style in databuilder but otherwise not changing functionality
for now. Fix up the callers to match (which make it clear this is the right
move).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker   |  3 +-
 lib/bb/cache.py      | 71 ++++----------------------------------------
 lib/bb/command.py    |  3 +-
 lib/bb/cooker.py     |  3 +-
 lib/bb/cookerdata.py | 51 +++++++++++++++++++++++++++++++
 lib/bb/runqueue.py   |  3 +-
 6 files changed, 60 insertions(+), 74 deletions(-)

v2: Fix "bitbake -e <recipe>" reference to loadDataFull() in cooker.py

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 7be39370b3..d54044f361 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -238,7 +238,6 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
                 os.umask(umask)
 
             try:
-                bb_cache = bb.cache.NoCache(databuilder)
                 (realfn, virtual, mc) = bb.cache.virtualfn2realfn(fn)
                 the_data = databuilder.mcdata[mc]
                 the_data.setVar("BB_WORKERCONTEXT", "1")
@@ -257,7 +256,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
                     bb.parse.siggen.set_taskhashes(workerdata["newhashes"])
                 ret = 0
 
-                the_data = bb_cache.loadDataFull(fn, appends)
+                the_data = databuilder.parseRecipe(fn, appends)
                 the_data.setVar('BB_TASKHASH', taskhash)
                 the_data.setVar('BB_UNIHASH', unihash)
 
diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 988c596c39..4d715e911d 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -280,75 +280,14 @@ def variant2virtual(realfn, variant):
         return "mc:" + elems[1] + ":" + realfn
     return "virtual:" + variant + ":" + realfn
 
-def parse_recipe(bb_data, bbfile, appends, mc=''):
-    """
-    Parse a recipe
-    """
-
-    bb_data.setVar("__BBMULTICONFIG", mc)
-
-    bbfile_loc = os.path.abspath(os.path.dirname(bbfile))
-    bb.parse.cached_mtime_noerror(bbfile_loc)
-
-    if appends:
-        bb_data.setVar('__BBAPPEND', " ".join(appends))
-    bb_data = bb.parse.handle(bbfile, bb_data)
-    return bb_data
-
-
-class NoCache(object):
-
-    def __init__(self, databuilder):
-        self.databuilder = databuilder
-        self.data = databuilder.data
-
-    def loadDataFull(self, virtualfn, appends):
-        """
-        Return a complete set of data for fn.
-        To do this, we need to parse the file.
-        """
-        logger.debug("Parsing %s (full)" % virtualfn)
-        (fn, virtual, mc) = virtualfn2realfn(virtualfn)
-        bb_data = self.load_bbfile(virtualfn, appends, virtonly=True)
-        return bb_data[virtual]
-
-    def load_bbfile(self, bbfile, appends, virtonly = False, mc=None):
-        """
-        Load and parse one .bb build file
-        Return the data and whether parsing resulted in the file being skipped
-        """
-
-        if virtonly:
-            (bbfile, virtual, mc) = virtualfn2realfn(bbfile)
-            bb_data = self.databuilder.mcdata[mc].createCopy()
-            bb_data.setVar("__ONLYFINALISE", virtual or "default")
-            datastores = parse_recipe(bb_data, bbfile, appends, mc)
-            return datastores
-
-        if mc is not None:
-            bb_data = self.databuilder.mcdata[mc].createCopy()
-            return parse_recipe(bb_data, bbfile, appends, mc)
 
-        bb_data = self.data.createCopy()
-        datastores = parse_recipe(bb_data, bbfile, appends)
-
-        for mc in self.databuilder.mcdata:
-            if not mc:
-                continue
-            bb_data = self.databuilder.mcdata[mc].createCopy()
-            newstores = parse_recipe(bb_data, bbfile, appends, mc)
-            for ns in newstores:
-                datastores["mc:%s:%s" % (mc, ns)] = newstores[ns]
-
-        return datastores
-
-class Cache(NoCache):
+class Cache(object):
     """
     BitBake Cache implementation
     """
     def __init__(self, databuilder, mc, data_hash, caches_array):
-        super().__init__(databuilder)
-        data = databuilder.data
+        self.databuilder = databuilder
+        self.data = databuilder.data
 
         # Pass caches_array information into Cache Constructor
         # It will be used later for deciding whether we
@@ -356,7 +295,7 @@ class Cache(NoCache):
         self.mc = mc
         self.logger = PrefixLoggerAdapter("Cache: %s: " % (mc if mc else "default"), logger)
         self.caches_array = caches_array
-        self.cachedir = data.getVar("CACHE")
+        self.cachedir = self.data.getVar("CACHE")
         self.clean = set()
         self.checked = set()
         self.depends_cache = {}
@@ -486,7 +425,7 @@ class Cache(NoCache):
         """Parse the specified filename, returning the recipe information"""
         self.logger.debug("Parsing %s", filename)
         infos = []
-        datastores = self.load_bbfile(filename, appends, mc=self.mc)
+        datastores = self.databuilder.parseRecipeVariants(filename, appends, mc=self.mc)
         depends = []
         variants = []
         # Process the "real" fn last so we can store variants list
diff --git a/lib/bb/command.py b/lib/bb/command.py
index ec86885220..fa9fd054c2 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -567,8 +567,7 @@ class CommandsSync:
             envdata = bb.cache.parse_recipe(config_data, fn, appendfiles, mc)['']
         else:
             # Use the standard path
-            parser = bb.cache.NoCache(command.cooker.databuilder)
-            envdata = parser.loadDataFull(fn, appendfiles)
+            envdata = command.cooker.databuilder.parseRecipe(fn, appendfiles)
         idx = command.remotedatastores.store(envdata)
         return DataStoreConnectionHandle(idx)
     parseRecipeFile.readonly = True
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1da2f03197..1af29f217d 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -617,8 +617,7 @@ class BBCooker:
 
         if fn:
             try:
-                bb_caches = bb.cache.MulticonfigCache(self.databuilder, self.data_hash, self.caches_array)
-                envdata = bb_caches[mc].loadDataFull(fn, self.collections[mc].get_file_appends(fn))
+                envdata = self.databuilder.parseRecipe(fn, self.collections[mc].get_file_appends(fn))
             except Exception as e:
                 parselog.exception("Unable to read %s", fn)
                 raise
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 8a354fed7c..c322ab2ffb 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -466,3 +466,54 @@ class CookerDataBuilder(object):
 
         return data
 
+    @staticmethod
+    def _parse_recipe(bb_data, bbfile, appends, mc=''):
+        bb_data.setVar("__BBMULTICONFIG", mc)
+
+        bbfile_loc = os.path.abspath(os.path.dirname(bbfile))
+        bb.parse.cached_mtime_noerror(bbfile_loc)
+
+        if appends:
+            bb_data.setVar('__BBAPPEND', " ".join(appends))
+        bb_data = bb.parse.handle(bbfile, bb_data)
+        return bb_data
+
+    def parseRecipeVariants(self, bbfile, appends, virtonly=False, mc=None):
+        """
+        Load and parse one .bb build file
+        Return the data and whether parsing resulted in the file being skipped
+        """
+
+        if virtonly:
+            (bbfile, virtual, mc) = bb.cache.virtualfn2realfn(bbfile)
+            bb_data = self.mcdata[mc].createCopy()
+            bb_data.setVar("__ONLYFINALISE", virtual or "default")
+            datastores = self._parse_recipe(bb_data, bbfile, appends, mc)
+            return datastores
+
+        if mc is not None:
+            bb_data = self.mcdata[mc].createCopy()
+            return self._parse_recipe(bb_data, bbfile, appends, mc)
+
+        bb_data = self.data.createCopy()
+        datastores = self._parse_recipe(bb_data, bbfile, appends)
+
+        for mc in self.mcdata:
+            if not mc:
+                continue
+            bb_data = self.mcdata[mc].createCopy()
+            newstores = self._parse_recipe(bb_data, bbfile, appends, mc)
+            for ns in newstores:
+                datastores["mc:%s:%s" % (mc, ns)] = newstores[ns]
+
+        return datastores
+
+    def parseRecipe(self, virtualfn, appends):
+        """
+        Return a complete set of data for fn.
+        To do this, we need to parse the file.
+        """
+        logger.debug("Parsing %s (full)" % virtualfn)
+        (fn, virtual, mc) = bb.cache.virtualfn2realfn(virtualfn)
+        bb_data = self.parseRecipeVariants(virtualfn, appends, virtonly=True)
+        return bb_data[virtual]
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 338d1fe36f..437f4a185c 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1610,9 +1610,8 @@ class RunQueue:
             self.rqexe.finish()
 
     def rq_dump_sigfn(self, fn, options):
-        bb_cache = bb.cache.NoCache(self.cooker.databuilder)
         mc = bb.runqueue.mc_from_tid(fn)
-        the_data = bb_cache.loadDataFull(fn, self.cooker.collections[mc].get_file_appends(fn))
+        the_data = self.cooker.databuilder.parseRecipe(fn, self.cooker.collections[mc].get_file_appends(fn))
         siggen = bb.parse.siggen
         dataCaches = self.rqdata.dataCaches
         siggen.dump_sigfn(fn, dataCaches, options)
-- 
2.34.1


