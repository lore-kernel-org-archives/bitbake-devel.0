Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.1090.1598288022173353598
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2020 09:53:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bcej4xho;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id c15so9438177wrs.11
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2020 09:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zKowEldysu7Vy1BVDAiuXOnnnBtjY+jI/dKQ3uKAkn8=;
        b=bcej4xhoNAZR0DVWk3oswe5oxuZfIl1tDIEtF4Fad/Ei+/lJCIeWE7TLhx2Z7zSZua
         rnKV8KXYtbXUMV+TO4ituQLIwNB3QdGp6veYEC9j1AGWpt2MiX1qb6rNm43yvuy4EaYC
         TPhIyuiZblqf4IulZWsZ6oeQS9KluSzoE0iU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zKowEldysu7Vy1BVDAiuXOnnnBtjY+jI/dKQ3uKAkn8=;
        b=DJ6zuByOaumKuE9pdZu54CYe9lZBDuF//d0xtvDihGQmtOdhU1rbpuqX4AV6jC1wtE
         MknNBWXTdK16wFMrspE13Wcb3/ILdZdScp7hVADrIp1qvDhsBLjvabTngNshKP+TwZOZ
         zHKNGC8IRMK4qgmNW7JXzUgiY/OmPe+HwkAFJfv3WHSPx+q4b7LgEmPKSFERbgGim5fX
         ksV8FbiHUy6OsMbuNKUqUSkWO01Hh8cZwoCqAlbCYLnbvZfEUGEk3/o/W4FCrr7t4RSq
         on1tiL5cAS8lHKbu8LJmGYc0gzXYCa3cMZwuEPVEVzmjHWw3YpL3GBfRiCs/x5A2nUhv
         YUzg==
X-Gm-Message-State: AOAM531ajqfIpLa3sllOYdMN64NWn6VYgdMXfIpXFamnTRpNMrYv00d6
	z2hAP15ZnAZ7WTp65k2aKmhLjhBEKrjjKQJB
X-Google-Smtp-Source: ABdhPJxGOhF4VTsBJbYoGKTU0fdhZM4um5pmD6IZHvYOZvoKZAMsroimN71AEfFqcPA4ZVXpOGCLqw==
X-Received: by 2002:adf:d4c6:: with SMTP id w6mr6670669wrk.314.1598288016260;
        Mon, 24 Aug 2020 09:53:36 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id f19sm182127wmh.44.2020.08.24.09.53.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 09:53:35 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 05/10] cooker: Defer configuration init to after UI connection
Date: Mon, 24 Aug 2020 17:53:26 +0100
Message-Id: <20200824165331.1373725-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org>
References: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we end up parsing the base configuration multiple times as
initially, the right settings haven't come from the UI. We can defer
this until later in startup using runCommand as a trigger.

The advantage to doing this is improved startup times and ultimately
we should be able to avoid the double parse of the base configuration.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py        |  9 ++++++++-
 lib/bb/cooker.py         | 17 ++++++++---------
 lib/bb/server/process.py | 38 +++++++++++++++++++++-----------------
 3 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 4d152ff4c0..d4dcc653a0 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -54,13 +54,20 @@ class Command:
         self.cooker = cooker
         self.cmds_sync = CommandsSync()
         self.cmds_async = CommandsAsync()
-        self.remotedatastores = bb.remotedata.RemoteDatastores(cooker)
+        self.remotedatastores = None
 
         # FIXME Add lock for this
         self.currentAsyncCommand = None
 
     def runCommand(self, commandline, ro_only = False):
         command = commandline.pop(0)
+
+        # Ensure cooker is ready for commands
+        if command != "updateConfig" and command != "setFeatures":
+            self.cooker.init_configdata()
+            if not self.remotedatastores:
+                self.remotedatastores = bb.remotedata.RemoteDatastores(self.cooker)
+
         if hasattr(CommandsSync, command):
             # Can run synchronous commands straight away
             command_method = getattr(self.cmds_sync, command)
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 3f351cbea6..3f9cb75434 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -195,11 +195,6 @@ class BBCooker:
         self.hashserv = None
         self.hashservaddr = None
 
-        self.initConfigurationData()
-
-        bb.debug(1, "BBCooker parsed base configuration %s" % time.time())
-        sys.stdout.flush()
-
         self.inotify_modified_files = []
 
         def _process_inotify_updates(server, cooker, abort):
@@ -233,6 +228,13 @@ class BBCooker:
         bb.debug(1, "BBCooker startup complete %s" % time.time())
         sys.stdout.flush()
 
+    def init_configdata(self):
+        if not hasattr(self, "data"):
+            self.initConfigurationData()
+            bb.debug(1, "BBCooker parsed base configuration %s" % time.time())
+            sys.stdout.flush()
+            self.handlePRServ()
+
     def process_inotify_updates(self):
         for n in [self.confignotifier, self.notifier]:
             if n.check_events(timeout=0):
@@ -318,7 +320,7 @@ class BBCooker:
         for feature in features:
             self.featureset.setFeature(feature)
         bb.debug(1, "Features set %s (was %s)" % (original_featureset, list(self.featureset)))
-        if (original_featureset != list(self.featureset)) and self.state != state.error:
+        if (original_featureset != list(self.featureset)) and self.state != state.error and hasattr(self, "data"):
             self.reset()
 
     def initConfigurationData(self):
@@ -1658,9 +1660,6 @@ class BBCooker:
         return pkgs_to_build
 
     def pre_serve(self):
-        # We now are in our own process so we can call this here.
-        # PRServ exits if its parent process exits
-        self.handlePRServ()
         return
 
     def post_serve(self):
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 65e1eab527..b037e0fb6c 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -58,6 +58,7 @@ class ProcessServer():
         self.sockname = sockname
 
         self.server_timeout = server_timeout
+        self.timeout = self.server_timeout
         self.xmlrpcinterface = xmlrpcinterface
 
     def register_idle_function(self, function, data):
@@ -72,21 +73,6 @@ class ProcessServer():
 
             print("Bitbake XMLRPC server address: %s, server port: %s" % (self.xmlrpc.host, self.xmlrpc.port))
 
-        heartbeat_event = self.cooker.data.getVar('BB_HEARTBEAT_EVENT')
-        if heartbeat_event:
-            try:
-                self.heartbeat_seconds = float(heartbeat_event)
-            except:
-                bb.warn('Ignoring invalid BB_HEARTBEAT_EVENT=%s, must be a float specifying seconds.' % heartbeat_event)
-
-        self.timeout = self.server_timeout or self.cooker.data.getVar('BB_SERVER_TIMEOUT')
-        try:
-            if self.timeout:
-                self.timeout = float(self.timeout)
-        except:
-            bb.warn('Ignoring invalid BB_SERVER_TIMEOUT=%s, must be a float specifying seconds.' % self.timeout)
-
-
         try:
             self.bitbake_lock.seek(0)
             self.bitbake_lock.truncate()
@@ -129,6 +115,7 @@ class ProcessServer():
         fds = [self.sock]
         if self.xmlrpc:
             fds.append(self.xmlrpc)
+        seendata = False
         print("Entering server connection loop")
 
         def disconnect_client(self, fds):
@@ -228,6 +215,22 @@ class ProcessServer():
             if self.xmlrpc in ready:
                 self.xmlrpc.handle_requests()
 
+            if not seendata and hasattr(self.cooker, "data"):
+                heartbeat_event = self.cooker.data.getVar('BB_HEARTBEAT_EVENT')
+                if heartbeat_event:
+                    try:
+                        self.heartbeat_seconds = float(heartbeat_event)
+                    except:
+                        bb.warn('Ignoring invalid BB_HEARTBEAT_EVENT=%s, must be a float specifying seconds.' % heartbeat_event)
+
+                self.timeout = self.server_timeout or self.cooker.data.getVar('BB_SERVER_TIMEOUT')
+                try:
+                    if self.timeout:
+                        self.timeout = float(self.timeout)
+                except:
+                    bb.warn('Ignoring invalid BB_SERVER_TIMEOUT=%s, must be a float specifying seconds.' % self.timeout)
+                seendata = True
+
             ready = self.idle_commands(.1, fds)
 
         print("Exiting")
@@ -323,8 +326,9 @@ class ProcessServer():
             self.next_heartbeat += self.heartbeat_seconds
             if self.next_heartbeat <= now:
                 self.next_heartbeat = now + self.heartbeat_seconds
-            heartbeat = bb.event.HeartbeatEvent(now)
-            bb.event.fire(heartbeat, self.cooker.data)
+            if hasattr(self.cooker, "data"):
+                heartbeat = bb.event.HeartbeatEvent(now)
+                bb.event.fire(heartbeat, self.cooker.data)
         if nextsleep and now + nextsleep > self.next_heartbeat:
             # Shorten timeout so that we we wake up in time for
             # the heartbeat.
-- 
2.25.1

