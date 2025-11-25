Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C0ED0E6E5
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 13:42:49 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17246.1764078165123659317
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Nov 2025 05:42:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=E9jWEynn;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b39d51dcfso3321898f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Nov 2025 05:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764078163; x=1764682963; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=X/BfgHZxYlkVl8SOD0mnfvHRh6A0ZCb2x2B/JLuQ+z4=;
        b=E9jWEynnamCp8vAdlNA8GRFag42aLfndMX7OAvppTwlMlLQ6nXefQvQMLoBBS9cPOC
         TN0c4BHQw2RqOsG5HYpxuV4kExNRwioSo8+Ky38THQrLHcaXg2BvhFRDvFlqRMXXhMud
         E0b+uT2m7JGjmGJyWRo/gAzz3FtQ/DXtIRoY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764078163; x=1764682963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/BfgHZxYlkVl8SOD0mnfvHRh6A0ZCb2x2B/JLuQ+z4=;
        b=Pz2xSBcF/IeVPMYcsHXb4eZUM77V9y5CKnghQ1LpYW9pKRNhm8cnRAhW61+Nf/oa6I
         cXNWF/CTlq+SUhDBt4QVFuziFmE9YZk3CDwsRolIGnPHhHY5wiagWxh926yupkwLdvMe
         e+FM84XzkzDvGJ+w07jlND2oocbX7yrsAUuwAYDjEeiA/4Nm5snOy+81f/z8gNoODbr4
         1m3btF5jwERhXmn6mqAlAUZOzxrp16UnIYNP0aGpl3gerhEQ4IMFr0uptxhPi9q0Me1h
         vWxYE+6MHNoKGCCjtpY3CYj/pPLtlVtsJt56UwUl3Aa6pa9/CkSrrWMfXhz4riS7FxVQ
         4lsQ==
X-Gm-Message-State: AOJu0YwZq3vcoNtwS/aRyWronEJL9S4GzX+sZYCX9wjKRXD03LJHX0i6
	+g9H/X87/7wjJtY1ou4uT87014Tfibz4mpNCaE3L+h2MxHMqKuh95f6Mbna2jfeATCDwaW/YgiI
	qXbz/
X-Gm-Gg: ASbGncthO0pwWVZzD1ugKmd/9HTiKtw6gSI6QJY3ZQ/ABOOo3N4+nmZlevjS3iwGX2i
	Ga0FUnze9EqOUcFBWPj3LTs3ldl3HsLdv9sN4T/oVESpp2ctSK/o6SwSVAiVHbhux2fIERGjcVv
	asWp2n8Y2/MBskKi1f8UiJyK2sIQ3CvcmojQG1+glzX6zeEr39l6rKxC3RT+Ctg9FwGSraDmsli
	p+DuRZI8yVwvKNyVV4b83+OsAUKVKtWfJxBR4Y2iMTiA+gIEGz4Atm1LAooMJ0Nu/nuEJ0f/ykU
	HKyu9euvqkixmJjhmrbYd52stltj4e8HFycdQ7n5ySm8T9lt7bjjnBbE/qt9hdCsNYSW2BBQ+gT
	pdKeIBf8MoHDqy87WtUUBu1D7AN8wUslFiIAy7J1hdaIb/hD3T1J7rbolSNyWGO4V9CPItzHfTJ
	Ax97WOW8Ti3K/ebzwtGe4KNe4xPBRmSINPF/P9XrM=
X-Google-Smtp-Source: AGHT+IGujBUpBMsmrzlhWHDCdXrzZWxTDoAXJLQDuN8LA0VzepqY5m+lVkahZYRgEfMzlI3qbduwBw==
X-Received: by 2002:adf:f3c3:0:b0:42b:41dc:1b5f with SMTP id ffacd0b85a97d-42cc1cf4535mr12362948f8f.32.1764078162616;
        Tue, 25 Nov 2025 05:42:42 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:c8cd:1015:2ce5:f243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba201sm34385192f8f.32.2025.11.25.05.42.41
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 05:42:42 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker/cookerdata: Ensure clean cache parsing/correctness with memres bitbake
Date: Tue, 25 Nov 2025 13:42:41 +0000
Message-ID: <20251125134241.401158-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Nov 2025 13:42:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18491

After the changes which meant cooker features were changing more often, it
highlighted a caching bug in bitbake where files would change and we would
reparse but old versions of the file contents would be used from
cached_statements.

A second issue was observed where we'd try and rehash the configuration data
stores even if the cache was invalid, causing a backtrace.

To fix both issues, ensure revalidateCaches is called from the datastore init
function and ensure calc_datastore_hashes handles the case where caches are
invalid.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py     | 23 +++++++++++++++++------
 lib/bb/cookerdata.py |  6 +++++-
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index b896c233ec9..e4e927b7974 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -247,6 +247,7 @@ class BBCooker:
                 self.featureset.delFeature(orig_feature)
         bb.debug(1, "Features set %s (was %s)" % (list(self.featureset), original_featureset))
         if (original_featureset != list(self.featureset)) and self.state != State.ERROR and hasattr(self, "data"):
+            bb.server.process.serverlog("Reseting due to feature chanages")
             self.reset()
 
     def initConfigurationData(self):
@@ -258,7 +259,11 @@ class BBCooker:
             if mod not in self.orig_sysmodules:
                 del sys.modules[mod]
 
+        self._baseconfig_set(False)
+        self._parsecache_set(False)
+
         self.configwatched = {}
+        self.revalidateCaches()
 
         # Need to preserve BB_CONSOLELOG over resets
         consolelog = None
@@ -312,7 +317,6 @@ class BBCooker:
             self.add_filewatch(mc.getVar("__base_depends", False), configwatcher=True)
 
         self._baseconfig_set(True)
-        self._parsecache_set(False)
 
     def handlePRServ(self):
         # Setup a PR Server based on the new configuration
@@ -377,6 +381,12 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in si
     def revalidateCaches(self):
         bb.parse.clear_cache()
 
+        if not self.baseconfig_valid:
+            bb.parse.BBHandler.cached_statements = {}
+            if hasattr(self, "databuilder"):
+                self.databuilder.calc_datastore_hashes(clean=False)
+            return
+
         clean = True
         for f in self.configwatched:
             if not bb.parse.check_mtime(f, self.configwatched[f]):
@@ -384,7 +394,10 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in si
                 self._baseconfig_set(False)
                 self._parsecache_set(False)
                 clean = False
-                break
+                bb.parse.BBHandler.cached_statements = {}
+                if hasattr(self, "databuilder"):
+                    self.databuilder.calc_datastore_hashes(clean=False)
+                return
 
         if clean:
             for f in self.parsewatched:
@@ -392,15 +405,13 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in si
                     bb.server.process.serverlog("Found %s changed, invalid cache" % f)
                     self._parsecache_set(False)
                     clean = False
+                    bb.parse.BBHandler.cached_statements = {}
                     break
 
-        if not clean:
-            bb.parse.BBHandler.cached_statements = {}
-
         # If writes were made to any of the data stores, we need to recalculate the data
         # store cache
         if hasattr(self, "databuilder"):
-            self.databuilder.calc_datastore_hashes()
+            self.databuilder.calc_datastore_hashes(clean=clean)
 
     def parseConfiguration(self):
         self.updateCacheSync()
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index b6dca7af702..22ac95eac9f 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -259,7 +259,11 @@ class CookerDataBuilder(object):
         self.data = self.basedata
         self.mcdata = {}
 
-    def calc_datastore_hashes(self):
+    def calc_datastore_hashes(self, clean=True):
+        if not clean:
+            self.data_hash = None
+            return
+
         data_hash = hashlib.sha256()
         data_hash.update(self.data.get_hash().encode('utf-8'))
         multiconfig = (self.data.getVar("BBMULTICONFIG") or "").split()

