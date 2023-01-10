Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABB1C46467
	for <webhook@archiver.kernel.org>; Tue, 10 Jan 2023 23:52:16 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.10070.1673394731805703734
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Jan 2023 15:52:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cjrIsC6B;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id co23so13417170wrb.4
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Jan 2023 15:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QzPpkZ027Q8SznDaDYxffNbNx/EgA5o5/ly3sFsMcGQ=;
        b=cjrIsC6BzjtyrmF3839tJAuQhJSMwGNbySaFw9bZYvbRK9rtsLszRNBG3GAReCuOaq
         E4gMbfXDkUz/t9YHvpGFfKJETfjgqnTv/d82Ke6DPIRl9m743jUFd5PkLXB0Ti+DtO80
         ugXsHkW0BtJXWXEbuV7GDNZi7LfNjhyCvA0Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QzPpkZ027Q8SznDaDYxffNbNx/EgA5o5/ly3sFsMcGQ=;
        b=fdtMiI6IP9wZog0n8Ra0toTXiGlnNoEG5BL64Ap0u4NnG/A3wSJLitHXO2iDm/0A5H
         kntOjcnyaj84LExWx0iN+CmlyHnj+/OuNygNiju5g7xyTi1m0tqvyoEfuZc24vS8xAmo
         mxeFpDmGwG08Ls5FajoheAC/8ID6Ymlj3uVFjda6ER4y9jnS9C0Fv6X+VoZNJYqUUuQh
         aCeqF3Z41SAzWJOjHITN7oax+xGANLcg3psNkH8R9C4QJkvk8EOohdcNfsGHAgtpKsZ4
         DmizMrcIlIakSUvy966cxTEnjk+80djlf6G8kNltDYI/QlFBX3CzqYdvIqQ6i9hXMAyZ
         JMNw==
X-Gm-Message-State: AFqh2kogKAq/Saoahrg1OE+L0FxT42wEy+33OuUitQLFypm8Dg5C+QcJ
	Wx8tqqlN392MQ92+YMyaw5I0/WdgqnJ07Gfr
X-Google-Smtp-Source: AMrXdXsIhPx+0lM3/fFBP06SrEJ6Zv9Ve9rqKU4LeFqqjgBKPG9Ubl+FsO/Xn19wZnGcQJ0AslaG+Q==
X-Received: by 2002:adf:fc08:0:b0:2bb:1d9c:e13a with SMTP id i8-20020adffc08000000b002bb1d9ce13amr11005475wrr.19.1673394729677;
        Tue, 10 Jan 2023 15:52:09 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a11f:4d56:748b:c178])
        by smtp.gmail.com with ESMTPSA id d18-20020adfe852000000b002426d0a4048sm12760997wrn.49.2023.01.10.15.52.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 15:52:09 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] process/cooker/command: Fix currentAsyncCommand locking/races
Date: Tue, 10 Jan 2023 23:52:08 +0000
Message-Id: <20230110235208.1488270-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Jan 2023 23:52:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14300

currentAsyncCommand currently doesn't have any locking and we have
a conflict in "idle" conditions since the idle functions count needs
to be zero *and* there needs to be no active command.

Move the changes/checks of currentAsyncCommand to within the lock
and then we can add it to the condition for idle, simplifying some
of the code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py        | 26 ++++++++++++--------------
 lib/bb/cooker.py         | 12 ++++++++----
 lib/bb/server/process.py | 30 ++++++++++++++++++++++++------
 3 files changed, 44 insertions(+), 24 deletions(-)

v2 - add fix for potential race suggested by Joshua Watt

diff --git a/lib/bb/command.py b/lib/bb/command.py
index c325abbcda..bc4e5927dc 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -51,13 +51,14 @@ class Command:
     """
     A queue of asynchronous commands for bitbake
     """
-    def __init__(self, cooker):
+    def __init__(self, cooker, process_server):
         self.cooker = cooker
         self.cmds_sync = CommandsSync()
         self.cmds_async = CommandsAsync()
         self.remotedatastores = None
 
-        # FIXME Add lock for this
+        self.process_server = process_server
+        # Access with locking using process_server.{get/set/clear}_async_cmd()
         self.currentAsyncCommand = None
         self.lastEvent = None
 
@@ -100,18 +101,14 @@ class Command:
                 return None, traceback.format_exc()
             else:
                 return result, None
-        if self.currentAsyncCommand is not None:
-            # Wait for the idle loop to have cleared (30s max)
-            process_server.wait_for_idle(timeout=30)
-            if self.currentAsyncCommand is not None:
-                return None, "Busy (%s in progress)" % self.currentAsyncCommand[0]
         if command not in CommandsAsync.__dict__:
             return None, "No such command"
-        self.currentAsyncCommand = (command, commandline)
-        self.cooker.idleCallBackRegister(self.runAsyncCommand, None)
+        if not process_server.set_async_cmd((command, commandline)):
+            return None, "Busy (%s in progress)" % self.process_server.get_async_cmd()[0]
+        self.cooker.idleCallBackRegister(self.runAsyncCommand, process_server)
         return True, None
 
-    def runAsyncCommand(self, _, _2, halt):
+    def runAsyncCommand(self, _, process_server, halt):
         try:
             self.cooker.process_inotify_updates_apply()
             if self.cooker.state in (bb.cooker.state.error, bb.cooker.state.shutdown, bb.cooker.state.forceshutdown):
@@ -119,8 +116,9 @@ class Command:
                 # and then raise BBHandledException triggering an exit
                 self.cooker.updateCache()
                 return bb.server.process.idleFinish("Cooker in error state")
-            if self.currentAsyncCommand is not None:
-                (command, options) = self.currentAsyncCommand
+            cmd = process_server.get_async_cmd()
+            if cmd is not None:
+                (command, options) = cmd
                 commandmethod = getattr(CommandsAsync, command)
                 needcache = getattr( commandmethod, "needcache" )
                 if needcache and self.cooker.state != bb.cooker.state.running:
@@ -156,7 +154,7 @@ class Command:
         bb.event.fire(event, self.cooker.data)
         self.lastEvent = event
         self.cooker.finishcommand()
-        self.currentAsyncCommand = None
+        self.process_server.clear_async_cmd()
 
     def reset(self):
         if self.remotedatastores:
@@ -749,7 +747,7 @@ class CommandsAsync:
         """
         event = params[0]
         bb.event.fire(eval(event), command.cooker.data)
-        command.currentAsyncCommand = None
+        process_server.clear_async_cmd()
     triggerEvent.needcache = False
 
     def resetCooker(self, command, params):
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 13d6e9d847..5a0e675b44 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -149,7 +149,7 @@ class BBCooker:
     Manages one bitbake build run
     """
 
-    def __init__(self, featureSet=None, idleCallBackRegister=None, waitIdle=None):
+    def __init__(self, featureSet=None, server=None):
         self.recipecaches = None
         self.eventlog = None
         self.skiplist = {}
@@ -163,8 +163,12 @@ class BBCooker:
 
         self.configuration = bb.cookerdata.CookerConfiguration()
 
-        self.idleCallBackRegister = idleCallBackRegister
-        self.waitIdle = waitIdle
+        self.process_server = server
+        self.idleCallBackRegister = None
+        self.waitIdle = None
+        if server:
+            self.idleCallBackRegister = server.register_idle_function
+            self.waitIdle = server.wait_for_idle
 
         bb.debug(1, "BBCooker starting %s" % time.time())
         sys.stdout.flush()
@@ -203,7 +207,7 @@ class BBCooker:
         except UnsupportedOperation:
             pass
 
-        self.command = bb.command.Command(self)
+        self.command = bb.command.Command(self, self.process_server)
         self.state = state.initial
 
         self.parser = None
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 4422fd7311..1f56fa1762 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -155,10 +155,30 @@ class ProcessServer():
 
         return ret
 
+    def _idle_check(self):
+        return len(self._idlefuns) == 0 and self.cooker.command.currentAsyncCommand is None
+
     def wait_for_idle(self, timeout=30):
         # Wait for the idle loop to have cleared
         with self.idle_cond:
-            self.idle_cond.wait_for(lambda: len(self._idlefuns) == 0, timeout)
+            return self.idle_cond.wait_for(self._idle_check, timeout) is not False
+
+    def set_async_cmd(self, cmd):
+        with self.idle_cond:
+            ret = self.idle_cond.wait_for(self._idle_check, 30)
+            if ret is False:
+                return False
+            self.cooker.command.currentAsyncCommand = cmd
+            return True
+
+    def clear_async_cmd(self):
+        with bb.utils.lock_timeout(self._idlefuncsLock):
+            self.cooker.command.currentAsyncCommand = None
+            self.idle_cond.notify_all()
+
+    def get_async_cmd(self):
+        with bb.utils.lock_timeout(self._idlefuncsLock):
+            return self.cooker.command.currentAsyncCommand
 
     def main(self):
         self.cooker.pre_serve()
@@ -184,11 +204,9 @@ class ProcessServer():
                 self.controllersock = False
             if self.haveui:
                 # Wait for the idle loop to have cleared (30s max)
-                self.wait_for_idle(30)
-                if self.cooker.command.currentAsyncCommand is not None:
+                if not self.wait_for_idle(30):
                     serverlog("Idle loop didn't finish queued commands after 30s, exiting.")
                     self.quit = True
-
                 fds.remove(self.command_channel)
                 bb.event.unregister_UIHhandler(self.event_handle, True)
                 self.command_channel_reply.writer.close()
@@ -427,7 +445,7 @@ class ProcessServer():
                 lastdebug = time.time()
                 with bb.utils.lock_timeout(self._idlefuncsLock):
                     num_funcs = len(self._idlefuns)
-                serverlog("Current command %s, idle functions %s, last exit event %s, state %s" % (self.cooker.command.currentAsyncCommand, num_funcs, self.cooker.command.lastEvent, self.cooker.state))
+                serverlog("Current command %s, idle functions %s, last exit event %s, state %s" % (self.get_async_cmd(), num_funcs, self.cooker.command.lastEvent, self.cooker.state))
 
             if nextsleep is not None:
                 select.select(fds,[],[],nextsleep)[0]
@@ -632,7 +650,7 @@ def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout, xmlrpc
         writer = ConnectionWriter(readypipeinfd)
         try:
             featureset = []
-            cooker = bb.cooker.BBCooker(featureset, server.register_idle_function, server.wait_for_idle)
+            cooker = bb.cooker.BBCooker(featureset, server)
             cooker.configuration.profile = profile
         except bb.BBHandledException:
             return None
-- 
2.37.2


