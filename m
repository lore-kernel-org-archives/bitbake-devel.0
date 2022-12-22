Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92479C3DA7D
	for <webhook@archiver.kernel.org>; Thu, 22 Dec 2022 23:47:34 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.60902.1671752851328459093
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Dec 2022 15:47:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AgT/NRyg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso2453560wmp.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Dec 2022 15:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=758nh+IjW+PDtVxDuFX7FJkJ6XmbtKXSkAdsuA5dm5M=;
        b=AgT/NRyggBnXNMnlSm6DqjSYg4KR2O7yt6INUDboWud5MFzth2uVaHlcsGCKsAg9wD
         DFgFWhOc5JrbEwRw4GxDadujPG/gPgq6WRGaT9f/nqVDnJqRDyhXQymDC8ErYDF3hbjA
         PD8YI0JhoPYS1S1QmDijUbrG7yjtCY+uzYI+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=758nh+IjW+PDtVxDuFX7FJkJ6XmbtKXSkAdsuA5dm5M=;
        b=I9YX8wavaofP4qCK5SSPUn/DyxZ3DzmvCzAu9LHukVTfmcSj6LqwP4H/Oa5r9okMoR
         PEqG2FCPVICYOF1anVnKwFTc5K7biNLcvWLA5j1Ki/PLV4c43IImABrmkIhAnbiHbiRS
         KC3reMMV613KMtagu8iTx+Wjhx0JG3egzf0u4In2xkfCCHU1/ugW8osMTArjgQYj7/k6
         gRMn+e1sBFqBnzKJqN+cV/DqL3VMj5i+8DMIMVYSmq3iR15SY9CTtgIxxVKVBifGBoeG
         iE0clINllvoPiVCbtIVvNt3f+BuHWQDW1bEykMAWPoFrtcn8r6LNPpIXzKygyb+N8Fex
         ql9Q==
X-Gm-Message-State: AFqh2kpvG9Iw8ojwttSeLdoSzpZMkStGIpFxw5Avb45V/9K2qKk8v6lm
	otO9KKhaN71+d50bukzojgGwx/X5tGnK5GW3
X-Google-Smtp-Source: AMrXdXtCTcwSMjul1A0pRtx4ASVz1XvnbeiVryayu952/h82kRB5L5Vg7K98/sfc00ju/DicZqHXzg==
X-Received: by 2002:a7b:c3c9:0:b0:3d2:e28:647f with SMTP id t9-20020a7bc3c9000000b003d20e28647fmr6336037wmj.15.1671752849607;
        Thu, 22 Dec 2022 15:47:29 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:bc21:fec7:83cf:e0c3])
        by smtp.gmail.com with ESMTPSA id bd25-20020a05600c1f1900b003cfd4cf0761sm7322189wmb.1.2022.12.22.15.47.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 15:47:29 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 04/10] server/process: Run idle commands in a separate idle thread
Date: Thu, 22 Dec 2022 23:47:20 +0000
Message-Id: <20221222234726.579702-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221222234726.579702-1-richard.purdie@linuxfoundation.org>
References: <20221222234726.579702-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Dec 2022 23:47:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14233

When bitbake is off running heavier "idle" commands, it doesn't service it's
command socket which means stopping/interrupting it is hard. It also means we
can't "ping" from the UI to know if it is still alive.

For those reasons, split idle command execution into it's own thread.

The commands are generally already self containted so this is easier than
expected. We do have to be careful to only handle inotify poll() from a single
thread at a time. It also means we always have to use a thread lock when sending
events since both the idle thread and the command thread may generate log messages
(and hence events). The patch does depend on a couple of previous fixes to the
builtins locking in event.py and the heartbeat enable/disable changes.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py        |  4 +--
 lib/bb/cooker.py         | 19 +++++++++----
 lib/bb/server/process.py | 60 +++++++++++++++++++++++++---------------
 3 files changed, 54 insertions(+), 29 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 0208e30ec4..20a8b86653 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -84,7 +84,7 @@ class Command:
                 if not hasattr(command_method, 'readonly') or not getattr(command_method, 'readonly'):
                     return None, "Not able to execute not readonly commands in readonly mode"
             try:
-                self.cooker.process_inotify_updates()
+                self.cooker.process_inotify_updates_apply()
                 if getattr(command_method, 'needconfig', True):
                     self.cooker.updateCacheSync()
                 result = command_method(self, commandline)
@@ -109,7 +109,7 @@ class Command:
 
     def runAsyncCommand(self):
         try:
-            self.cooker.process_inotify_updates()
+            self.cooker.process_inotify_updates_apply()
             if self.cooker.state in (bb.cooker.state.error, bb.cooker.state.shutdown, bb.cooker.state.forceshutdown):
                 # updateCache will trigger a shutdown of the parser
                 # and then raise BBHandledException triggering an exit
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 815610ff82..1daa587ac5 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -220,6 +220,8 @@ class BBCooker:
         bb.debug(1, "BBCooker startup complete %s" % time.time())
         sys.stdout.flush()
 
+        self.inotify_threadlock = threading.Lock()
+
     def init_configdata(self):
         if not hasattr(self, "data"):
             self.initConfigurationData()
@@ -248,11 +250,18 @@ class BBCooker:
         self.notifier = pyinotify.Notifier(self.watcher, self.notifications)
 
     def process_inotify_updates(self):
-        for n in [self.confignotifier, self.notifier]:
-            if n and n.check_events(timeout=0):
-                # read notified events and enqueue them
-                n.read_events()
-                n.process_events()
+        with self.inotify_threadlock:
+            for n in [self.confignotifier, self.notifier]:
+                if n and n.check_events(timeout=0):
+                    # read notified events and enqueue them
+                    n.read_events()
+
+    def process_inotify_updates_apply(self):
+        with self.inotify_threadlock:
+            for n in [self.confignotifier, self.notifier]:
+                if n and n.check_events(timeout=0):
+                    n.read_events()
+                    n.process_events()
 
     def config_notifications(self, event):
         if event.maskname == "IN_Q_OVERFLOW":
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 91eb6e0ad9..6f43330fae 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -88,6 +88,7 @@ class ProcessServer():
         self.maxuiwait = 30
         self.xmlrpc = False
 
+        self.idle = None
         self._idlefuns = {}
 
         self.bitbake_lock = lock
@@ -148,6 +149,7 @@ class ProcessServer():
         self.cooker.pre_serve()
 
         bb.utils.set_process_name("Cooker")
+        bb.event.enable_threadlock()
 
         ready = []
         newconnections = []
@@ -278,6 +280,9 @@ class ProcessServer():
 
             ready = self.idle_commands(.1, fds)
 
+        if self.idle:
+            self.idle.join()
+
         serverlog("Exiting (socket: %s)" % os.path.exists(self.sockname))
         # Remove the socket file so we don't get any more connections to avoid races
         # The build directory could have been renamed so if the file isn't the one we created
@@ -352,33 +357,44 @@ class ProcessServer():
                     msg.append(":\n%s" % procs)
                 serverlog("".join(msg))
 
+    def idle_thread(self):
+        while not self.quit:
+            nextsleep = 0.1
+            fds = []
+            for function, data in list(self._idlefuns.items()):
+                try:
+                    retval = function(self, data, False)
+                    if retval is False:
+                        del self._idlefuns[function]
+                        nextsleep = None
+                    elif retval is True:
+                        nextsleep = None
+                    elif isinstance(retval, float) and nextsleep:
+                        if (retval < nextsleep):
+                            nextsleep = retval
+                    elif nextsleep is None:
+                        continue
+                    else:
+                        fds = fds + retval
+                except SystemExit:
+                    raise
+                except Exception as exc:
+                    if not isinstance(exc, bb.BBHandledException):
+                        logger.exception('Running idle function')
+                    del self._idlefuns[function]
+                    self.quit = True
+
+            if nextsleep is not None:
+                select.select(fds,[],[],nextsleep)[0]
+
     def idle_commands(self, delay, fds=None):
         nextsleep = delay
         if not fds:
             fds = []
 
-        for function, data in list(self._idlefuns.items()):
-            try:
-                retval = function(self, data, False)
-                if retval is False:
-                    del self._idlefuns[function]
-                    nextsleep = None
-                elif retval is True:
-                    nextsleep = None
-                elif isinstance(retval, float) and nextsleep:
-                    if (retval < nextsleep):
-                        nextsleep = retval
-                elif nextsleep is None:
-                    continue
-                else:
-                    fds = fds + retval
-            except SystemExit:
-                raise
-            except Exception as exc:
-                if not isinstance(exc, bb.BBHandledException):
-                    logger.exception('Running idle function')
-                del self._idlefuns[function]
-                self.quit = True
+        if not self.idle:
+            self.idle = threading.Thread(target=self.idle_thread)
+            self.idle.start()
 
         # Create new heartbeat event?
         now = time.time()
-- 
2.37.2


