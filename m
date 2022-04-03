Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D810C3527B
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:41 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web12.21496.1648981311270855312
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 03 Apr 2022 03:21:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fXaMu5GW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id
 123-20020a1c1981000000b0038b3616a71aso3939189wmz.4
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 03 Apr 2022 03:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rVbiRmr/NbumgmhRLGfvurdQY1O0euEclrse/J2c8S4=;
        b=fXaMu5GWSbmOyXlFWMGyuIEVxIziw2a3T1tnynJXKn0gL0bXj+AzISAHWo+U+p7V4y
         la4FFyqik/KWyQRsB5MC2A47ngDs8DvXTvnteKBJZxi/JgCOy93vDOGlIqfLEXBPy9Ci
         aLI9ntVDiYjGodSv+VCCZkDwSyXUw4Wso7FIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rVbiRmr/NbumgmhRLGfvurdQY1O0euEclrse/J2c8S4=;
        b=0qdpfmRXxVLzyhWnzEDS0EXVMXsmxr5G5G1aYRMI3yr1M9p49OmXT8/hLI6rJzmGez
         9Zi40ZnmEQ9qjsnb+Spw1NEK8402VC27rTzlq3G2g26mIzqkU989zb8LYGhVl0Lufjre
         xdLxJT2CmmNCcoch8dlADnfm7GaEoSu0jhyWEFQDpaL/R/tbJMIqpH4RuKTlbmrBwbTZ
         ajFPUwDlpuantzErCcxEMjRtR0sy4IqYqn63dkcxNo3zO2YK63xhXzb5TyC1rbqpqQ1r
         oFA6AMpL+LCShlF4SRVaiF+5QpuMfpzcqJIji1tV5mnFqiipPn+qgKHTElfPNFheXdnu
         4WaQ==
X-Gm-Message-State: AOAM533TzerdFP81VailpAyW25eIUyF4TsJLgxLUN5LmwOikbKaszDOn
	40hB19yEc8CG2HnjI4KdpkppK1Z4HtSA9Wto
X-Google-Smtp-Source: 
 ABdhPJyeckJp9hKD7U87UjdhqJ0eZiDgvLXdPQA1TOOJp1j/FDibFNoq4T6I/0VDlftHoHlgKSCkSw==
X-Received: by 2002:a05:600c:154d:b0:38c:e9b8:d13f with SMTP id
 f13-20020a05600c154d00b0038ce9b8d13fmr15285354wmg.183.1648981309506;
        Sun, 03 Apr 2022 03:21:49 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:819:f853:3436:28c4])
        by smtp.gmail.com with ESMTPSA id
 z3-20020a1cf403000000b0037d1f4a2201sm6327981wma.21.2022.04.03.03.21.48
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 03:21:48 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/5] cooker: Reset and rebuild inotify watches
Date: Sun,  3 Apr 2022 11:21:43 +0100
Message-Id: <20220403102144.1679700-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220403102144.1679700-1-richard.purdie@linuxfoundation.org>
References: <20220403102144.1679700-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Apr 2022 18:46:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13574

The recent inotify changes can cause entire build trees to be monitored
which is suboptimal for performance.

Rather than trying increasingly convoluted tricks to try and handle add/removed
directories, rebuild the inotify watch when we reparse the configuration or
metadata.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 54 ++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 5a941f879f..7685db11f3 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -188,27 +188,15 @@ class BBCooker:
         bb.debug(1, "BBCooker starting %s" % time.time())
         sys.stdout.flush()
 
-        self.configwatcher = pyinotify.WatchManager()
-        bb.debug(1, "BBCooker pyinotify1 %s" % time.time())
-        sys.stdout.flush()
+        self.configwatcher = None
+        self.confignotifier = None
 
-        self.configwatcher.bbseen = set()
-        self.configwatcher.bbwatchedfiles = set()
-        self.confignotifier = pyinotify.Notifier(self.configwatcher, self.config_notifications)
-        bb.debug(1, "BBCooker pyinotify2 %s" % time.time())
-        sys.stdout.flush()
         self.watchmask = pyinotify.IN_CLOSE_WRITE | pyinotify.IN_CREATE | pyinotify.IN_DELETE | \
                          pyinotify.IN_DELETE_SELF | pyinotify.IN_MODIFY | pyinotify.IN_MOVE_SELF | \
                          pyinotify.IN_MOVED_FROM | pyinotify.IN_MOVED_TO
-        self.watcher = pyinotify.WatchManager()
-        bb.debug(1, "BBCooker pyinotify3 %s" % time.time())
-        sys.stdout.flush()
-        self.watcher.bbseen = set()
-        self.watcher.bbwatchedfiles = set()
-        self.notifier = pyinotify.Notifier(self.watcher, self.notifications)
 
-        bb.debug(1, "BBCooker pyinotify complete %s" % time.time())
-        sys.stdout.flush()
+        self.watcher = None
+        self.notifier = None
 
         # If being called by something like tinfoil, we need to clean cached data
         # which may now be invalid
@@ -259,9 +247,29 @@ class BBCooker:
             sys.stdout.flush()
             self.handlePRServ()
 
+    def setupConfigWatcher(self):
+        if self.configwatcher:
+            self.configwatcher.close()
+            self.confignotifier = None
+            self.configwatcher = None
+        self.configwatcher = pyinotify.WatchManager()
+        self.configwatcher.bbseen = set()
+        self.configwatcher.bbwatchedfiles = set()
+        self.confignotifier = pyinotify.Notifier(self.configwatcher, self.config_notifications)
+
+    def setupParserWatcher(self):
+        if self.watcher:
+            self.watcher.close()
+            self.notifier = None
+            self.watcher = None
+        self.watcher = pyinotify.WatchManager()
+        self.watcher.bbseen = set()
+        self.watcher.bbwatchedfiles = set()
+        self.notifier = pyinotify.Notifier(self.watcher, self.notifications)
+
     def process_inotify_updates(self):
         for n in [self.confignotifier, self.notifier]:
-            if n.check_events(timeout=0):
+            if n and n.check_events(timeout=0):
                 # read notified events and enqeue them
                 n.read_events()
                 n.process_events()
@@ -281,10 +289,6 @@ class BBCooker:
                     self.configwatcher.bbseen.remove(event.pathname)
                 # Could remove all entries starting with the directory but for now...
                 bb.parse.clear_cache()
-            if "IN_CREATE" in event.maskname:
-                self.add_filewatch([[event.pathname]], watcher=self.configwatcher, dirs=True)
-            elif "IN_DELETE" in event.maskname and event.pathname in self.configwatcher.bbseen:
-                self.configwatcher.bbseen.remove(event.pathname)
         if not event.pathname in self.inotify_modified_files:
             self.inotify_modified_files.append(event.pathname)
         self.baseconfig_valid = False
@@ -304,10 +308,6 @@ class BBCooker:
                     self.watcher.bbseen.remove(event.pathname)
                 # Could remove all entries starting with the directory but for now...
                 bb.parse.clear_cache()
-            if "IN_CREATE" in event.maskname:
-                self.add_filewatch([[event.pathname]], dirs=True)
-            elif "IN_DELETE" in event.maskname and event.pathname in self.watcher.bbseen:
-                self.watcher.bbseen.remove(event.pathname)
         if not event.pathname in self.inotify_modified_files:
             self.inotify_modified_files.append(event.pathname)
         self.parsecache_valid = False
@@ -377,6 +377,8 @@ class BBCooker:
             if mod not in self.orig_sysmodules:
                 del sys.modules[mod]
 
+        self.setupConfigWatcher()
+
         # Need to preserve BB_CONSOLELOG over resets
         consolelog = None
         if hasattr(self, "data"):
@@ -1658,6 +1660,8 @@ class BBCooker:
             self.updateCacheSync()
 
         if self.state != state.parsing and not self.parsecache_valid:
+            self.setupParserWatcher()
+
             bb.parse.siggen.reset(self.data)
             self.parseConfiguration ()
             if CookerFeatures.SEND_SANITYEVENTS in self.featureset:
-- 
2.32.0


