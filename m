Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C27C7EE21
	for <webhook@archiver.kernel.org>; Mon,  1 May 2023 22:08:36 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.108978.1682978911610584420
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 May 2023 15:08:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=hdgP9wmm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f18dacd392so17278445e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 May 2023 15:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1682978910; x=1685570910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LJHIClP2N06TY5iU3qIdA5mlj/LgoW1hFx/cD5bPPQc=;
        b=hdgP9wmmuZm3U5tbya1xBOlgGNmrsGB5xCVVSgjpb20H5kpDFrS/GeyC6rsqR1dq2B
         9Uw+TiKlmcv8If909KXYzCyLzcBKjsGC9whJnDywd6jvHZ5GInAeYhh+ZB10c+43Mh6k
         k5oEHQUbbUtPB4Oj6ENLCzIq6au/p0MCtjzyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682978910; x=1685570910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJHIClP2N06TY5iU3qIdA5mlj/LgoW1hFx/cD5bPPQc=;
        b=Y997tz9n28Rrr/PKncLk6WrFTh9r+XS+CWMZIM/ph45eD2QIRMZqDXkIGyfHFxtGJD
         8fGOxK8CkJAKebhZphjIz8I5CezQFmx0H+HOdRxMwyioRmDWF/OLuxz/hIsx78eaMWem
         LcG3pOoCEI3drBzDwlqoGF+qbFV8BO+J7RXBWW+QcDlrcZkk8WWJW12L0/eDbXKJLEOC
         KE1KSpBtREQed4lJCNUtPBjPspu5unwII0kVt0oXZ7nctMKk+4UFKewganjLYaEFatWd
         7C9x3WQfjDdRrJgzLxYavWXF/VFsxSUgMlrpA/Z/lSGuxPu+GtVOlu6h+IUJSAUWyVmz
         gxuw==
X-Gm-Message-State: AC+VfDwK64LbDY3P51XOg0o0lZTodUBTG3Qe74AoLI/vnFJR81iDQl2y
	ITICjusRJSauNr6vg4eTa9tsMN6WlVRJDkFIKg8=
X-Google-Smtp-Source: ACHHUZ6LB3UrN5btsa9AZr78ZfpcaQa1VF0by5wB8c5HxPFY2/VaGev5ezpPraddpB9Z9QNESgDTug==
X-Received: by 2002:a1c:f717:0:b0:3f1:7972:429d with SMTP id v23-20020a1cf717000000b003f17972429dmr10136642wmh.18.1682978909819;
        Mon, 01 May 2023 15:08:29 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9417:e142:e786:9868])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c021000b003f339b2d06fsm5078428wmi.4.2023.05.01.15.08.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 15:08:29 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Log config and parse cache status changes
Date: Mon,  1 May 2023 23:08:28 +0100
Message-Id: <20230501220828.2781291-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 May 2023 22:08:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14764

It can be hard to tell why bitbake does some things slowly. Log the changes
to the base configuration and parse cache status so that it becomes clear
from the logs when the cache invalidation causes a slowdown.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index f33bca4f86..554c7f10a5 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -151,6 +151,8 @@ class BBCooker:
 
     def __init__(self, featureSet=None, server=None):
         self.recipecaches = None
+        self.baseconfig_valid = False
+        self.parsecache_valid = False
         self.eventlog = None
         self.skiplist = {}
         self.featureset = CookerFeatures()
@@ -264,11 +266,25 @@ class BBCooker:
                     n.read_events()
                     n.process_events()
 
+    def _baseconfig_set(self, value):
+        if value and not self.baseconfig_valid:
+            bb.server.process.serverlog("Base config valid")
+        elif not value and self.baseconfig_valid:
+            bb.server.process.serverlog("Base config invalidated")
+        self.baseconfig_valid = value
+
+    def _parsecache_set(self, value):
+        if value and not self.parsecache_valid:
+            bb.server.process.serverlog("Parse cache valid")
+        elif not value and self.parsecache_valid:
+            bb.server.process.serverlog("Parse cache invalidated")
+        self.parsecache_valid = value
+
     def config_notifications(self, event):
         if event.maskname == "IN_Q_OVERFLOW":
             bb.warn("inotify event queue overflowed, invalidating caches.")
-            self.parsecache_valid = False
-            self.baseconfig_valid = False
+            self._parsecache_set(False)
+            self._baseconfig_set(False)
             bb.parse.clear_cache()
             return
         if not event.pathname in self.configwatcher.bbwatchedfiles:
@@ -281,12 +297,12 @@ class BBCooker:
                 bb.parse.clear_cache()
         if not event.pathname in self.inotify_modified_files:
             self.inotify_modified_files.append(event.pathname)
-        self.baseconfig_valid = False
+        self._baseconfig_set(False)
 
     def notifications(self, event):
         if event.maskname == "IN_Q_OVERFLOW":
             bb.warn("inotify event queue overflowed, invalidating caches.")
-            self.parsecache_valid = False
+            self._parsecache_set(False)
             bb.parse.clear_cache()
             return
         if event.pathname.endswith("bitbake-cookerdaemon.log") \
@@ -300,7 +316,7 @@ class BBCooker:
                 bb.parse.clear_cache()
         if not event.pathname in self.inotify_modified_files:
             self.inotify_modified_files.append(event.pathname)
-        self.parsecache_valid = False
+        self._parsecache_set(False)
 
     def add_filewatch(self, deps, watcher=None, dirs=False):
         if not watcher:
@@ -422,8 +438,8 @@ class BBCooker:
         for mc in self.databuilder.mcdata.values():
             self.add_filewatch(mc.getVar("__base_depends", False), self.configwatcher)
 
-        self.baseconfig_valid = True
-        self.parsecache_valid = False
+        self._baseconfig_set(True)
+        self._parsecache_set(False)
 
     def handlePRServ(self):
         # Setup a PR Server based on the new configuration
@@ -489,7 +505,7 @@ class BBCooker:
 
         self.handleCollections(self.data.getVar("BBFILE_COLLECTIONS"))
 
-        self.parsecache_valid = False
+        self._parsecache_set(False)
 
     def updateConfigOpts(self, options, environment, cmdline):
         self.ui_cmdline = cmdline
@@ -1509,7 +1525,7 @@ class BBCooker:
                     bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runtaskentries), buildname, item, failures, interrupted), self.databuilder.mcdata[mc])
                     bb.event.disable_heartbeat()
                 # We trashed self.recipecaches above
-                self.parsecache_valid = False
+                self._parsecache_set(False)
                 self.configuration.limited_deps = False
                 bb.parse.siggen.reset(self.data)
                 if quietlog:
@@ -1678,7 +1694,7 @@ class BBCooker:
                 self.add_filewatch([[dirent]], dirs=True)
 
             self.parser = CookerParser(self, mcfilelist, total_masked)
-            self.parsecache_valid = True
+            self._parsecache_set(True)
 
         self.state = state.parsing
 
@@ -1796,8 +1812,7 @@ class BBCooker:
            self.data = self.databuilder.data
         # In theory tinfoil could have modified the base data before parsing,
         # ideally need to track if anything did modify the datastore
-        self.parsecache_valid = False
-
+        self._parsecache_set(False)
 
 class CookerExit(bb.event.Event):
     """
-- 
2.39.2


