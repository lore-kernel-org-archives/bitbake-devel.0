Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
 by mx.groups.io with SMTP id smtpd.web12.3684.1591413355209866885
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2020 20:15:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=WwCUy3yB;
 spf=pass (domain: gmail.com, ip: 209.85.166.196, mailfrom: jpewhacker@gmail.com)
Received: by mail-il1-f196.google.com with SMTP id a13so11587023ilh.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2020 20:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lqAmIo86Ed4JiIeOuhDNYAfD/xpaF28tHKUVH9i5PT0=;
        b=WwCUy3yB35FBssIaHFPsPPSzAQkhyAHG/8R95326/34Prk0Nc68ecW9p1VPGAk0kzn
         r/ZspXGA6IcBCvQ3lYL8Ql1AXk8UL7+v1t3GDiSQ+Cn08lcSj2l9xu4ezEgqWEBd+0PJ
         +KV7/Aa8R14aWeNRETFuR7JHR6IiPG86+CdG/HvTbhNylTUH0AHJbea6K+ZWjdkfS4Dd
         3E0s2bAGYjom/vB99WB8/Ii9E0B4OvRxLI6CwYOXNqk37s4lJPQM1s5r+Ribgsikb+BN
         bbOxRCSV8Cw4MtzgUVnWf6xpUHFHDBERjIafn9hPCXwL37wC1kvYNN5fLQvWLvzt7j59
         TkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lqAmIo86Ed4JiIeOuhDNYAfD/xpaF28tHKUVH9i5PT0=;
        b=qe/NMrpfv+UE8JY9g2ECxUZ+Nz4n9QrXDY8vprQi0dAMx4rLQSfkUGrD5TFPLakJMi
         8XSNnpSUM686R13IifS3pf4VZn6qq02zPLDOAtWT6g/srfl8bPufTzfHEJ9jDuAkOL2a
         G5J0VGR7Bnw3pp+sq7I83dZ5yX0V+eNEmZB5UxSgI55zXjL5LBtTJ214FJB3k7f1K3CB
         IlkL5N3vNWfYMXH1rWDptkcOdGQ5wqPfCnnISpoBGlJQFhFt9vocHU/e4zmfOv8r110L
         06Xu1TlDm2h548SBFFSMXJOrguib8dTjjOGjeEtikhva+3CXum1LKckJu1Tz6D01XFe6
         2IMw==
X-Gm-Message-State: AOAM530cbittaHuExOwIiGOMCP03FlZLcoVgfIo3zADpQo3ANDRwf6Pv
	6dgSiuec3es6/Q5bUkc7qD34Dbh9eMg=
X-Google-Smtp-Source: ABdhPJw+OeqdkIjrSs5wl0vs07krR3zc6WnhftNgK021QRUmxov+dtmlvXapDrx5X8EYqr5syM+XPA==
X-Received: by 2002:a05:6e02:4c4:: with SMTP id f4mr11761582ils.79.1591413354442;
        Fri, 05 Jun 2020 20:15:54 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:28:333f:5748:fb55])
        by smtp.gmail.com with ESMTPSA id p9sm2885221ile.87.2020.06.05.20.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 20:15:53 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 6/8] bitbake: cache: Cache size optimization
Date: Fri,  5 Jun 2020 22:15:34 -0500
Message-Id: <20200606031536.15956-7-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606031536.15956-1-JPEWhacker@gmail.com>
References: <20200605015325.35395-1-JPEWhacker@gmail.com>
 <20200606031536.15956-1-JPEWhacker@gmail.com>
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

