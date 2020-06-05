Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
 by mx.groups.io with SMTP id smtpd.web11.2277.1591322020063851518
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jun 2020 18:53:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=aWHjY3Wq;
 spf=pass (domain: gmail.com, ip: 209.85.210.193, mailfrom: jpewhacker@gmail.com)
Received: by mail-pf1-f193.google.com with SMTP id a127so4142624pfa.12
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2020 18:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lqAmIo86Ed4JiIeOuhDNYAfD/xpaF28tHKUVH9i5PT0=;
        b=aWHjY3WqYeQ18DYO7AT9vyJWmplE3yWzgEnTRs7mVwcG7OfzpTR+pCnuA5eKOgfge+
         QG8qqnvYmLlrc04AcyavWKlgttnEcRCXO6RCbfoeJq2rLgbJwSYI6iN1ICxvHypzsDDM
         CqQ73Ybg1NP5+bP4DGhG1jUq0zDxi6c7lo1tE7rwu+WAQddKZMM4MJ1+OABzARGBxkHC
         d9JjTDxd/ZhKd0qYzasRr6zemlcaDZgTNrRV2/vOPmRUH7sDDxZCLAAWw/u8ID4YnoZ1
         g8UJpMz34Qnoa1HrNHgsdmVl2oLSGVtw5RnimKrJ59sgEjT+yXIukNJA4Zaa6w6mOK3b
         rT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lqAmIo86Ed4JiIeOuhDNYAfD/xpaF28tHKUVH9i5PT0=;
        b=jBMQRmyZm2Xz7WXg1UGabEb01ADftI025HZW0Mt3kvzHO3Y0K9jZYNQ79jb9Xf/K6q
         z9EKu0Vu9fn7uAdmLU8CT58gx//FMUYA12BmLAKxVeyEEo+s9URWQLHgsssgCJC7c4m/
         /DuJM8Ep+/P3kLCbzJD5lW3zRNwuxOLkAHIxlUE1Qsc+OSokZVdfXihkp1se4ZOfXX72
         InlCYa27OMzSpmPu8Gk6zltCNHTyA8ZN9HH9F/Q9U6nDaIddM02djsxdJvukTGHbWzaM
         qCUJH3r3AUnVyzWUf0PAZX77VKToNCr3uUsSufFKyyLtMwT+jXpe6NAYH2WwBGAOnnA+
         VvZg==
X-Gm-Message-State: AOAM532cIetn+7mnqTcwhVDbn8Q9YWt5BoztOOAi5sMfiA7QAW3qJ/uG
	tD5QuJDzIixdYoxk8BmhcVOU0yX8mNM=
X-Google-Smtp-Source: ABdhPJxo9FZBtbQ/pSUXoQK9jTPWkUq21rhetr/hJC+FpyFycrbrQzOB/K6fd/T0N05VpsdLvELbOA==
X-Received: by 2002:aa7:96b0:: with SMTP id g16mr7266675pfk.126.1591322019328;
        Thu, 04 Jun 2020 18:53:39 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:bdc6:d557:64ed:7ccf])
        by smtp.gmail.com with ESMTPSA id x12sm5673516pfo.72.2020.06.04.18.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 18:53:38 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 6/8] bitbake: cache: Cache size optimization
Date: Thu,  4 Jun 2020 20:53:23 -0500
Message-Id: <20200605015325.35395-7-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605015325.35395-1-JPEWhacker@gmail.com>
References: <20200603025405.26885-1-JPEWhacker@gmail.com>
 <20200605015325.35395-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that there is a cache object per multiconfig, it is not necessary
for each cache object to parse all other multiconfigs. Instead, each
cache now only parses the files for it's multiconfig.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cache.py  | 22 ++++++++++++++++++----
 bitbake/lib/bb/cooker.py |  8 +-------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index b34bfa9b5a..df78d5b701 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -328,7 +328,7 @@ class NoCache(object):
         bb_data = self.load_bbfile(virtualfn, appends, virtonly=True)
         return bb_data[virtual]
 
-    def load_bbfile(self, bbfile, appends, virtonly = False):
+    def load_bbfile(self, bbfile, appends, virtonly = False, mc=None):
         """
         Load and parse one .bb build file
         Return the data and whether parsing resulted in the file being skipped
@@ -341,6 +341,10 @@ class NoCache(object):
             datastores = parse_recipe(bb_data, bbfile, appends, mc)
             return datastores
 
+        if mc is not None:
+            bb_data = self.databuilder.mcdata[mc].createCopy()
+            return parse_recipe(bb_data, bbfile, appends, mc)
+
         bb_data = self.data.createCopy()
         datastores = parse_recipe(bb_data, bbfile, appends)
 
@@ -500,7 +504,7 @@ class Cache(NoCache):
         """Parse the specified filename, returning the recipe information"""
         self.logger.debug(1, "Parsing %s", filename)
         infos = []
-        datastores = self.load_bbfile(filename, appends)
+        datastores = self.load_bbfile(filename, appends, mc=self.mc)
         depends = []
         variants = []
         # Process the "real" fn last so we can store variants list
@@ -720,8 +724,18 @@ class Cache(NoCache):
         return bb.parse.cached_mtime_noerror(cachefile)
 
     def add_info(self, filename, info_array, cacheData, parsed=None, watcher=None):
-        if cacheData is not None and isinstance(info_array[0], CoreRecipeInfo) and (not info_array[0].skipped):
-            cacheData.add_from_recipeinfo(filename, info_array)
+        if self.mc is not None:
+            (fn, cls, mc) = virtualfn2realfn(filename)
+            if mc:
+                self.logger.error("Unexpected multiconfig %s", virtualfn)
+                return
+
+            vfn = realfn2virtual(fn, cls, self.mc)
+        else:
+            vfn = filename
+
+        if isinstance(info_array[0], CoreRecipeInfo) and (not info_array[0].skipped):
+            cacheData.add_from_recipeinfo(vfn, info_array)
 
             if watcher:
                 watcher(info_array[0].file_depends)
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 50526d52b2..effd02442c 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -2199,13 +2199,7 @@ class CookerParser(object):
             if info_array[0].skipped:
                 self.skipped += 1
                 self.cooker.skiplist[virtualfn] = SkippedPackage(info_array[0])
-            (fn, cls, fnmc) = bb.cache.virtualfn2realfn(virtualfn)
-
-            if fnmc == mc:
-                cache = self.cooker.recipecaches[mc]
-            else:
-                cache = None
-            self.bb_caches[mc].add_info(virtualfn, info_array, cache,
+            self.bb_caches[mc].add_info(virtualfn, info_array, self.cooker.recipecaches[mc],
                                         parsed=parsed, watcher = self.cooker.add_filewatch)
         return True
 
-- 
2.26.2

