Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DD1C54EBC
	for <webhook@archiver.kernel.org>; Tue, 10 Jan 2023 16:03:16 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web10.107482.1673366586189686163
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Jan 2023 08:03:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Y3sUJDKT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ed1-f47.google.com with SMTP id v6so18217058edd.6
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Jan 2023 08:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eTZwctSZgPq7FVTT9BHmD2t7hblw13o3d5oaFCWzEaI=;
        b=Y3sUJDKTi33VCTzuxF1g4wfRvCgkv7VpVTSMxIA41gHZOawb4NzN+ZTb5XYDa4PS9C
         G4D/lwmgB5bgOnQa0eEVfkqSiC991BjqvPbGb61CfPj2xCPgdckoQLLyGGF/vf5jgQ23
         uRXqvHs954jSvhRkQbqatncVDXAB5yW2QRDAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTZwctSZgPq7FVTT9BHmD2t7hblw13o3d5oaFCWzEaI=;
        b=shsMAz0C/5H+tJh/OZmHQtHNzGnI+RbpuSG2tO/u3mB6AX7w4aBvgq1J099oPPMbmQ
         e/PcX5toBvk4JsRBHUAWs52tcMJ2kJpUylXnK3r+8hjP6Kxf5Yp2lidysurNlkUWePzI
         LLW48LHEGUtbIFFZwzngPyi6Hj0I/I6/yr5gbxYnbp6JJb8PNEZF8Ik0A+dR7ewG/bZm
         IawsS8qslDbr9RXf79DJADdSRz2Hw1ddD8PTz9H69QjqTw9j0eAeFWVcb7/kdklCCA5v
         cNIV0gepoiGYy8fzJG4pxmYss88UJKcWK8NEELRXIViKV64qsQDADx0ntCHjiF5EHiRr
         3UMg==
X-Gm-Message-State: AFqh2kpDpWohNZXidETRgDHErhcvwIM1kjWfqGJHCqP7x1ShnMLbt1lI
	37AUPIIY8g3qJ2Jl7CXo0KN903AJ9me7dIuJ
X-Google-Smtp-Source: AMrXdXu6hU7BTtlLivNovxbfeiwHNRWfBs4JOBuAgqBC0YDu5px8FQW+lJz84aA0COTXoTf46n/ijA==
X-Received: by 2002:a05:6402:685:b0:479:ab7d:1dad with SMTP id f5-20020a056402068500b00479ab7d1dadmr74499034edy.32.1673366584378;
        Tue, 10 Jan 2023 08:03:04 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ef35:464f:aac3:7a])
        by smtp.gmail.com with ESMTPSA id j14-20020adff00e000000b0024cb961b6aesm11429379wro.104.2023.01.10.08.03.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 08:03:04 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] process/cooker/command: Fix currentAsyncCommand locking/races
Date: Tue, 10 Jan 2023 16:03:02 +0000
Message-Id: <20230110160302.1470163-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230110160302.1470163-1-richard.purdie@linuxfoundation.org>
References: <20230110160302.1470163-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Jan 2023 16:03:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14296

currentAsyncCommand currently doesn't have any locking and we have
a conflict in "idle" conditions since the idle functions count needs
to be zero *and* there needs to be no active command.

Move the changes/checks of currentAsyncCommand to within the lock
and then we can add it to the condition for idle, simplifying some
of the code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py        | 28 ++++++++++++++--------------
 lib/bb/cooker.py         | 12 ++++++++----
 lib/bb/server/process.py | 19 +++++++++++++------
 3 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index c325abbcda..c3dc872d0d 100644
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
+        # Access with locking using process_server.get_async_cmd()/set_async_cmd()
         self.currentAsyncCommand = None
         self.lastEvent = None
 
@@ -100,18 +101,16 @@ class Command:
                 return None, traceback.format_exc()
             else:
                 return result, None
-        if self.currentAsyncCommand is not None:
-            # Wait for the idle loop to have cleared (30s max)
-            process_server.wait_for_idle(timeout=30)
-            if self.currentAsyncCommand is not None:
-                return None, "Busy (%s in progress)" % self.currentAsyncCommand[0]
+        # Wait for the idle loop to have cleared (30s max)
+        if not self.process_server.wait_for_idle(timeout=30):
+            return None, "Busy (%s in progress)" % self.process_server.get_async_cmd()[0]
         if command not in CommandsAsync.__dict__:
             return None, "No such command"
-        self.currentAsyncCommand = (command, commandline)
-        self.cooker.idleCallBackRegister(self.runAsyncCommand, None)
+        process_server.set_async_cmd((command, commandline))
+        self.cooker.idleCallBackRegister(self.runAsyncCommand, process_server)
         return True, None
 
-    def runAsyncCommand(self, _, _2, halt):
+    def runAsyncCommand(self, _, process_server, halt):
         try:
             self.cooker.process_inotify_updates_apply()
             if self.cooker.state in (bb.cooker.state.error, bb.cooker.state.shutdown, bb.cooker.state.forceshutdown):
@@ -119,8 +118,9 @@ class Command:
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
@@ -156,7 +156,7 @@ class Command:
         bb.event.fire(event, self.cooker.data)
         self.lastEvent = event
         self.cooker.finishcommand()
-        self.currentAsyncCommand = None
+        self.process_server.set_async_cmd(None)
 
     def reset(self):
         if self.remotedatastores:
@@ -749,7 +749,7 @@ class CommandsAsync:
         """
         event = params[0]
         bb.event.fire(eval(event), command.cooker.data)
-        command.currentAsyncCommand = None
+        process_server.set_async_cmd(None)
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
index 4422fd7311..36c109ffd3 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -158,7 +158,7 @@ class ProcessServer():
     def wait_for_idle(self, timeout=30):
         # Wait for the idle loop to have cleared
         with self.idle_cond:
-            self.idle_cond.wait_for(lambda: len(self._idlefuns) == 0, timeout)
+            return self.idle_cond.wait_for(lambda: len(self._idlefuns) == 0 and self.cooker.command.currentAsyncCommand is None, timeout) is not False
 
     def main(self):
         self.cooker.pre_serve()
@@ -184,11 +184,9 @@ class ProcessServer():
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
@@ -377,6 +375,15 @@ class ProcessServer():
                     msg.append(":\n%s" % procs)
                 serverlog("".join(msg))
 
+    def get_async_cmd(self):
+        with bb.utils.lock_timeout(self._idlefuncsLock):
+            return self.cooker.command.currentAsyncCommand
+
+    def set_async_cmd(self, cmd):
+        with bb.utils.lock_timeout(self._idlefuncsLock):
+            self.cooker.command.currentAsyncCommand = cmd
+            self.idle_cond.notify_all()
+
     def idle_thread(self):
         def remove_idle_func(function):
             with bb.utils.lock_timeout(self._idlefuncsLock):
@@ -427,7 +434,7 @@ class ProcessServer():
                 lastdebug = time.time()
                 with bb.utils.lock_timeout(self._idlefuncsLock):
                     num_funcs = len(self._idlefuns)
-                serverlog("Current command %s, idle functions %s, last exit event %s, state %s" % (self.cooker.command.currentAsyncCommand, num_funcs, self.cooker.command.lastEvent, self.cooker.state))
+                serverlog("Current command %s, idle functions %s, last exit event %s, state %s" % (self.get_async_cmd(), num_funcs, self.cooker.command.lastEvent, self.cooker.state))
 
             if nextsleep is not None:
                 select.select(fds,[],[],nextsleep)[0]
@@ -632,7 +639,7 @@ def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout, xmlrpc
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


