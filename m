Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B28C3DA7D
	for <webhook@archiver.kernel.org>; Sat, 31 Dec 2022 16:59:02 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.45728.1672505938558996607
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 31 Dec 2022 08:58:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YfB1DVTi;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so17643295wms.4
        for <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 08:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3p/MVBSdcbrUUrfQr9fHHbqC++SMamPwWXQSwdSbVUg=;
        b=YfB1DVTiUtFe6Mhmx3QheBtlQxUMK6+7lZsuAxAeoR7WtWhEC1eplk9lYbZmqkhOgD
         AZUL6LM1DxJ/uXU6lyC/KVlbMFZjEOiPugY3FaOWSA9SzChIOtNSRl/asc1hUM5rTyL2
         idPw5uFbUJHMmzNfPnvUGlfoWXw3NZ54wPDcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3p/MVBSdcbrUUrfQr9fHHbqC++SMamPwWXQSwdSbVUg=;
        b=EKCT+5/5+Nokx6WwdTzIBY+PvJNzs709VGcciUb/Z4ZUSwqZjFVvpzpt4wq+Kchbs3
         8p7CHxexSRMvvrWBqZf8sVMpeP3UYVktZ7HHG7dYVv9P69tJ+aEafoSeKfU3YuK0A9TW
         Pp8UAAmYBgHPIGPV7ZbLFBh/pKiS+n6SAcwkwSSxMKbxPTpzWxEnFSo6Y/Eun60ZY1Xq
         R66tJ2o+d5ij3T39c6jG4xsLOcYE/VsId89ItCaL/V2uZ+Jrl29NE9wr14zaW8Vdk7rL
         8IrNAhHkjnQm/ZT5rGgNog4U03gG3maA2L5zH5cvQiwmRRfDbMdji+GHN2TBzFBT3K7Z
         vtJA==
X-Gm-Message-State: AFqh2krLSIw2wTndRHdQXbJKW4DWPwnMelUbBjJ8GHQdtQ8iwwh1CRwZ
	Jd9SEP7bW5Vl8evrk64TihIArsy5RI2rqjSk
X-Google-Smtp-Source: AMrXdXuaEtPPp34xTgvbVxsktUbop1PfFTvZ5BLq0LzpwVFf2QKPRZ6BUhQbtYTbedWExGIsTZkq9A==
X-Received: by 2002:a05:600c:3ca2:b0:3d9:a5a2:65fa with SMTP id bg34-20020a05600c3ca200b003d9a5a265famr3877782wmb.7.1672505936819;
        Sat, 31 Dec 2022 08:58:56 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1a1f:74ee:21ca:3bb])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003b47b80cec3sm36582812wmq.42.2022.12.31.08.58.56
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 08:58:56 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 10/11] server/process: Run idle commands in a separate idle thread
Date: Sat, 31 Dec 2022 16:58:48 +0000
Message-Id: <20221231165849.964169-11-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221231165849.964169-1-richard.purdie@linuxfoundation.org>
References: <20221231165849.964169-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 16:59:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14272

When bitbake is off running heavier "idle" commands, it doesn't service it's
command socket which means stopping/interrupting it is hard. It also means we
can't "ping" from the UI to know if it is still alive.

For those reasons, split idle command execution into it's own thread.

The commands are generally already self containted so this is easier than
expected. We do have to be careful to only handle inotify poll() from a single
thread at a time. It also means we always have to use a thread lock when sending
events since both the idle thread and the command thread may generate log messages
(and hence events). The patch depends on  previous fixes to the builtins locking
in event.py and the heartbeat enable/disable changes as well as other locking
additions.

We use a condition to signal from the idle thread when other sections of code
can continue, thanks to Joshua Watt for the review and tweaks squashed into this
patch. We do have some sync points where we need to ensure any currently executing
commands have finished before we can start a new async command for example.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py             |  11 ++--
 lib/bb/cooker.py              |  29 +++++++---
 lib/bb/server/process.py      | 105 ++++++++++++++++++++++------------
 lib/bb/server/xmlrpcserver.py |   2 +-
 4 files changed, 97 insertions(+), 50 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 732327d84d..0706b89271 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -60,7 +60,7 @@ class Command:
         # FIXME Add lock for this
         self.currentAsyncCommand = None
 
-    def runCommand(self, commandline, ro_only = False):
+    def runCommand(self, commandline, process_server, ro_only=False):
         command = commandline.pop(0)
 
         # Ensure cooker is ready for commands
@@ -84,7 +84,7 @@ class Command:
                 if not hasattr(command_method, 'readonly') or not getattr(command_method, 'readonly'):
                     return None, "Not able to execute not readonly commands in readonly mode"
             try:
-                self.cooker.process_inotify_updates()
+                self.cooker.process_inotify_updates_apply()
                 if getattr(command_method, 'needconfig', True):
                     self.cooker.updateCacheSync()
                 result = command_method(self, commandline)
@@ -100,7 +100,10 @@ class Command:
             else:
                 return result, None
         if self.currentAsyncCommand is not None:
-            return None, "Busy (%s in progress)" % self.currentAsyncCommand[0]
+            # Wait for the idle loop to have cleared (30s max)
+            process_server.wait_for_idle(timeout=30)
+            if self.currentAsyncCommand is not None:
+                return None, "Busy (%s in progress)" % self.currentAsyncCommand[0]
         if command not in CommandsAsync.__dict__:
             return None, "No such command"
         self.currentAsyncCommand = (command, commandline)
@@ -109,7 +112,7 @@ class Command:
 
     def runAsyncCommand(self):
         try:
-            self.cooker.process_inotify_updates()
+            self.cooker.process_inotify_updates_apply()
             if self.cooker.state in (bb.cooker.state.error, bb.cooker.state.shutdown, bb.cooker.state.forceshutdown):
                 # updateCache will trigger a shutdown of the parser
                 # and then raise BBHandledException triggering an exit
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index ded9369787..a5a635858c 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -149,7 +149,7 @@ class BBCooker:
     Manages one bitbake build run
     """
 
-    def __init__(self, featureSet=None, idleCallBackRegister=None):
+    def __init__(self, featureSet=None, idleCallBackRegister=None, waitIdle=None):
         self.recipecaches = None
         self.eventlog = None
         self.skiplist = {}
@@ -164,6 +164,7 @@ class BBCooker:
         self.configuration = bb.cookerdata.CookerConfiguration()
 
         self.idleCallBackRegister = idleCallBackRegister
+        self.waitIdle = waitIdle
 
         bb.debug(1, "BBCooker starting %s" % time.time())
         sys.stdout.flush()
@@ -220,6 +221,8 @@ class BBCooker:
         bb.debug(1, "BBCooker startup complete %s" % time.time())
         sys.stdout.flush()
 
+        self.inotify_threadlock = threading.Lock()
+
     def init_configdata(self):
         if not hasattr(self, "data"):
             self.initConfigurationData()
@@ -248,11 +251,18 @@ class BBCooker:
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
@@ -1744,7 +1754,7 @@ class BBCooker:
         return
 
     def post_serve(self):
-        self.shutdown(force=True)
+        self.shutdown(force=True, idle=False)
         prserv.serv.auto_shutdown()
         if hasattr(bb.parse, "siggen"):
             bb.parse.siggen.exit()
@@ -1754,12 +1764,15 @@ class BBCooker:
         if hasattr(self, "data"):
             bb.event.fire(CookerExit(), self.data)
 
-    def shutdown(self, force = False):
+    def shutdown(self, force=False, idle=True):
         if force:
             self.state = state.forceshutdown
         else:
             self.state = state.shutdown
 
+        if idle:
+            self.waitIdle(30)
+
         if self.parser:
             self.parser.shutdown(clean=not force)
             self.parser.final_cleanup()
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 2aee9ef051..ac7749d36c 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -92,8 +92,11 @@ class ProcessServer():
         self.maxuiwait = 30
         self.xmlrpc = False
 
+        self.idle = None
+        # Need a lock for _idlefuns changes
         self._idlefuns = {}
         self._idlefuncsLock = threading.Lock()
+        self.idle_cond = threading.Condition(self._idlefuncsLock)
 
         self.bitbake_lock = lock
         self.bitbake_lock_name = lockname
@@ -151,6 +154,12 @@ class ProcessServer():
 
         return ret
 
+    def wait_for_idle(self, timeout=30):
+        # Wait for the idle loop to have cleared
+        with self.idle_cond:
+            # FIXME - the 1 is the inotify processing in cooker which always runs
+            self.idle_cond.wait_for(lambda: len(self._idlefuns) <= 1, timeout)
+
     def main(self):
         self.cooker.pre_serve()
 
@@ -174,6 +183,12 @@ class ProcessServer():
                 self.controllersock.close()
                 self.controllersock = False
             if self.haveui:
+                # Wait for the idle loop to have cleared (30s max)
+                self.wait_for_idle(30)
+                if self.cooker.command.currentAsyncCommand is not None:
+                    serverlog("Idle loop didn't finish queued commands after 30s, exiting.")
+                    self.quit = True
+
                 fds.remove(self.command_channel)
                 bb.event.unregister_UIHhandler(self.event_handle, True)
                 self.command_channel_reply.writer.close()
@@ -185,7 +200,7 @@ class ProcessServer():
                 self.cooker.clientComplete()
                 self.haveui = False
             ready = select.select(fds,[],[],0)[0]
-            if newconnections:
+            if newconnections and not self.quit:
                 serverlog("Starting new client")
                 conn = newconnections.pop(-1)
                 fds.append(conn)
@@ -257,7 +272,7 @@ class ProcessServer():
                     continue
                 try:
                     serverlog("Running command %s" % command)
-                    self.command_channel_reply.send(self.cooker.command.runCommand(command))
+                    self.command_channel_reply.send(self.cooker.command.runCommand(command, self))
                     serverlog("Command Completed (socket: %s)" % os.path.exists(self.sockname))
                 except Exception as e:
                    stack = traceback.format_exc()
@@ -285,6 +300,9 @@ class ProcessServer():
 
             ready = self.idle_commands(.1, fds)
 
+        if self.idle:
+            self.idle.join()
+
         serverlog("Exiting (socket: %s)" % os.path.exists(self.sockname))
         # Remove the socket file so we don't get any more connections to avoid races
         # The build directory could have been renamed so if the file isn't the one we created
@@ -300,7 +318,7 @@ class ProcessServer():
         self.sock.close()
 
         try:
-            self.cooker.shutdown(True)
+            self.cooker.shutdown(True, idle=False)
             self.cooker.notifier.stop()
             self.cooker.confignotifier.stop()
         except:
@@ -359,47 +377,60 @@ class ProcessServer():
                     msg.append(":\n%s" % procs)
                 serverlog("".join(msg))
 
-    def idle_commands(self, delay, fds=None):
+    def idle_thread(self):
         def remove_idle_func(function):
             with self._idlefuncsLock:
                 del self._idlefuns[function]
+                self.idle_cond.notify_all()
 
-        nextsleep = delay
-        if not fds:
+        while not self.quit:
+            nextsleep = 0.1
             fds = []
 
-        with self._idlefuncsLock:
-            items = list(self._idlefuns.items())
+            with self._idlefuncsLock:
+                items = list(self._idlefuns.items())
 
-        for function, data in items:
-            try:
-                retval = function(self, data, False)
-                if isinstance(retval, idleFinish):
-                    serverlog("Removing idle function %s at idleFinish" % str(function))
-                    remove_idle_func(function)
-                    self.cooker.command.finishAsyncCommand(retval.msg)
-                    nextsleep = None
-                elif retval is False:
-                    serverlog("Removing idle function %s" % str(function))
+            for function, data in items:
+                try:
+                    retval = function(self, data, False)
+                    if isinstance(retval, idleFinish):
+                        serverlog("Removing idle function %s at idleFinish" % str(function))
+                        remove_idle_func(function)
+                        self.cooker.command.finishAsyncCommand(retval.msg)
+                        nextsleep = None
+                    elif retval is False:
+                        serverlog("Removing idle function %s" % str(function))
+                        remove_idle_func(function)
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
                     remove_idle_func(function)
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
-                remove_idle_func(function)
-                serverlog("Exception %s broke the idle_thread, exiting" % traceback.format_exc())
-                self.quit = True
+                    serverlog("Exception %s broke the idle_thread, exiting" % traceback.format_exc())
+                    self.quit = True
+
+            if nextsleep is not None:
+                select.select(fds,[],[],nextsleep)[0]
+
+    def idle_commands(self, delay, fds=None):
+        nextsleep = delay
+        if not fds:
+            fds = []
+
+        if not self.idle:
+            self.idle = threading.Thread(target=self.idle_thread)
+            self.idle.start()
 
         # Create new heartbeat event?
         now = time.time()
@@ -592,7 +623,7 @@ def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout, xmlrpc
         writer = ConnectionWriter(readypipeinfd)
         try:
             featureset = []
-            cooker = bb.cooker.BBCooker(featureset, server.register_idle_function)
+            cooker = bb.cooker.BBCooker(featureset, server.register_idle_function, server.wait_for_idle)
             cooker.configuration.profile = profile
         except bb.BBHandledException:
             return None
diff --git a/lib/bb/server/xmlrpcserver.py b/lib/bb/server/xmlrpcserver.py
index 01f55538ae..2e65dc34a9 100644
--- a/lib/bb/server/xmlrpcserver.py
+++ b/lib/bb/server/xmlrpcserver.py
@@ -118,7 +118,7 @@ class BitBakeXMLRPCServerCommands():
         """
         Run a cooker command on the server
         """
-        return self.server.cooker.command.runCommand(command, self.server.readonly)
+        return self.server.cooker.command.runCommand(command, self.server, self.server.readonly)
 
     def getEventHandle(self):
         return self.event_handle
-- 
2.37.2


