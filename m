Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140D8C3DA7C
	for <webhook@archiver.kernel.org>; Wed, 21 Dec 2022 14:15:54 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.19442.1671632148136336177
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Dec 2022 06:15:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hmlz2tNw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id h10so15071805wrx.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 06:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=758nh+IjW+PDtVxDuFX7FJkJ6XmbtKXSkAdsuA5dm5M=;
        b=hmlz2tNwjzTJ1AHd5B0EGA/jQLoVOgez7gW2CPAuMf40qI1Q2PxHrB2dSj6v4PWhbP
         xUXvlGa1GKG5Aiui4fxJf53tvLloag2Q/7mr36Rg4ARnhNf42ACre6eUXQa8OabAItwR
         xcTsZZqqybC5cj/TntZ6GYB2V8aqNVQ26WIYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=758nh+IjW+PDtVxDuFX7FJkJ6XmbtKXSkAdsuA5dm5M=;
        b=EmbqfT9pVP2tk0VbYUkonsk0JSD5X1z9mbG8Q8CvE8NKepf9xqyuv72hRv0TW2ceEO
         0qA31Ks2DLqH3gK4GGbRHp7ECVGMZKrg9pMOBKlcxcsUf0HFdn0iMg7Xd32aNX4ILu9Z
         TGX69Kiy+4Zpvkz93jxtsX0ucYwOg1trQdB2KKeUzvEeHQE/o+eQd5sRP8E0cZ1Dhair
         QYd0Jy1otwn7powLzmZ+aNIvGLxRY8t344XLL3dXXkgFfFrIArOKyX0JwDdgJQHvG4W5
         T1C3+EhuLdBT4tNfnXe/O0Dl8i8L9xkrnvqbg9dls34e9XI4uQ0MxA+D+varPlbPs+id
         hrTA==
X-Gm-Message-State: AFqh2kqYnrWtx1yU6nhJvm2DPPgXyyhqE5gjVygsv5eswPJQNIxZULXo
	KIF3WO9eYreGOEhDDn1Ygl1r1vpQrgizZwS3
X-Google-Smtp-Source: AMrXdXu2MlammNyWkF5XRnhag3OIxWoAP4L1/Lz/xozLRxR1io+1bOQinnOhvs+9arsAlcDK9yZUPw==
X-Received: by 2002:a5d:43c7:0:b0:236:50d4:c0a6 with SMTP id v7-20020a5d43c7000000b0023650d4c0a6mr1114135wrr.47.1671632146284;
        Wed, 21 Dec 2022 06:15:46 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e749:b020:2cdb:af31])
        by smtp.gmail.com with ESMTPSA id k12-20020adff28c000000b0022e57e66824sm17839412wro.99.2022.12.21.06.15.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 06:15:45 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/7] server/process: Run idle commands in a separate idle thread
Date: Wed, 21 Dec 2022 14:15:40 +0000
Message-Id: <20221221141543.497904-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221221141543.497904-1-richard.purdie@linuxfoundation.org>
References: <20221221141543.497904-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 14:15:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14221

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


