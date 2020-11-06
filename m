Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
 by mx.groups.io with SMTP id smtpd.web08.6965.1604634285345879116
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Nov 2020 19:44:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Z3/f0swD;
 spf=pass (domain: gmail.com, ip: 209.85.222.195, mailfrom: maxime.roussinbelanger@gmail.com)
Received: by mail-qk1-f195.google.com with SMTP id i21so3393286qka.12
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Nov 2020 19:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=igIkzRAdQMIgdrQOyxJzXJ6/360RytCK6rwHagkbmT8=;
        b=Z3/f0swDzXZAP4Ud+ZhcdwJ3fvftuRykkdvydYqvFsouxwlUsrKY9ro3cWs6FaBIg+
         EIu64wTw/fwvQ19lkUCKZQtzHoAS6xUwEbzxrb667N8H/M/IL0wN79ZQZFECaaZcp3ux
         raQzAF8OOK5qvQqUiqBwRSc7SsGGV88s9DVJQkQljIdlDA9R63FU/pj5f00T5iX40n8n
         fxN0VeIidXQHOAFaK61P2Qj8oMu0VMJOt54igjmJUpiAuIW2D1+MpLq4t7RD5pLGF+Wr
         7u/0yaZtBDdAT1kZpgSEbHUuaxMczYWCkzzppH2S9/6ReZ9SzLR4QSXTZKz1KD+Yvwts
         V31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=igIkzRAdQMIgdrQOyxJzXJ6/360RytCK6rwHagkbmT8=;
        b=bkOdlVXAVSorrRMiDOoFlyk/31lgZCCMFRUpi08oE9+TrNwxElZy4bJLLkbc2DmN8w
         N9+bk5EVFEujK8zrJ8ctL5QthcVTAJkSW9g6mNwsc13oIQ/745dehcvTeONWSXy5Cpj0
         O/Sn6ggoiOe5gzY/b6ENzIx7mMqX+o2cBLj5brfRXW2tzl4S9FhTUrBgM7GKlZaQwkCW
         Cmwaws2LJX5Aw0ymqwOhp720uqLK1lyBsa50bu4z16ZAIWsHJWNs9hpqqaQJqo5qv2gE
         GpwI2KYHe7MpgeFRnuIdKAy3mJGerEu14tRF8XhRG/nkvSNUBvzv15b1Oc+h/43Vduvy
         XwCA==
X-Gm-Message-State: AOAM533pq69gScbX6ml/Ih1891cbYg+c16er70qIBbP/NknEj+vJVIvt
	six/vBq5foyk+PWlxm6ceAQ+901ZwmM=
X-Google-Smtp-Source: ABdhPJzhyZh4eomehtPbq02DfXjk4xIoGut+RHVEVUI3mQkjwsdSOWwQD1UEIeBk4OIM1scoAlrmhQ==
X-Received: by 2002:a37:4c45:: with SMTP id z66mr5363692qka.341.1604634284165;
        Thu, 05 Nov 2020 19:44:44 -0800 (PST)
Return-Path: <maxime.roussinbelanger@gmail.com>
Received: from mbedesk.sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id c65sm2581018qkg.43.2020.11.05.19.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:44:43 -0800 (PST)
From: =?UTF-8?B?TWF4aW1lIFJvdXNzaW4tQsOpbGFuZ2Vy?= <maxime.roussinbelanger@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Maxime=20Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>
Subject: [PATCH] cache: extract method to remove default parameters
Date: Thu,  5 Nov 2020 22:44:24 -0500
Message-Id: <20201106034424.13004-1-maxime.roussinbelanger@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since the `virtonly` parameter is only used with true inside
loadDataFull we can extract.

By removing the virtonly parameter we can now remove the `mc` and used what was
passed as an argument before.

Signed-off-by: Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com>
---
 bitbake/lib/bb/cache.py | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index ebb2422496..ca12087455 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -324,26 +324,17 @@ class NoCache(object):
         To do this, we need to parse the file.
         """
         logger.debug(1, "Parsing %s (full)" % virtualfn)
-        (fn, virtual, mc) = virtualfn2realfn(virtualfn)
-        bb_data = self.load_bbfile(virtualfn, appends, virtonly=True)
-        return bb_data[virtual]
+        return self.load_virtual_bbfile(virtualfn, appends)
 
-    def load_bbfile(self, bbfile, appends, virtonly = False, mc=None):
+    def load_bbfile(self, bbfile, appends):
         """
         Load and parse one .bb build file
         Return the data and whether parsing resulted in the file being skipped
         """
 
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
+        if self.mc is not None:
+            bb_data = self.databuilder.mcdata[self.mc].createCopy()
+            return parse_recipe(bb_data, bbfile, appends, self.mc)
 
         bb_data = self.data.createCopy()
         datastores = parse_recipe(bb_data, bbfile, appends)
@@ -358,6 +349,13 @@ class NoCache(object):
 
         return datastores
 
+    def load_virtual_bbfile(self, virtualfn, appends):
+        (_, virtual, mc) = virtualfn2realfn(virtualfn)
+        bb_data = self.databuilder.mcdata[mc].createCopy()
+        bb_data.setVar("__ONLYFINALISE", virtual or "default")
+        datastores = parse_recipe(bb_data, virtualfn, appends, mc)
+        return datastores[virtual]
+
 class Cache(NoCache):
     """
     BitBake Cache implementation
@@ -502,7 +500,7 @@ class Cache(NoCache):
         """Parse the specified filename, returning the recipe information"""
         self.logger.debug(1, "Parsing %s", filename)
         infos = []
-        datastores = self.load_bbfile(filename, appends, mc=self.mc)
+        datastores = self.load_bbfile(filename, appends)
         depends = []
         variants = []
         # Process the "real" fn last so we can store variants list
-- 
2.28.0

