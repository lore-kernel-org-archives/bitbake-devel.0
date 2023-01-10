Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B07C54EBC
	for <webhook@archiver.kernel.org>; Tue, 10 Jan 2023 16:12:06 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web10.107711.1673367119818712642
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Jan 2023 08:12:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=nyp6ZiqB;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: jpewhacker@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id fy8so29894892ejc.13
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Jan 2023 08:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZxvFJ8vplvDGPJt6csEulpOQH0sjgC9PBkVWErccdQ=;
        b=nyp6ZiqBGu1GzzVp4KRCYau+GfwO1S2CqZoKiD0yyaV1bOyja0xxsChMhKkUNI1P8t
         VO9EVIKTaYFAoLtAReDbAJg+TjQfXrmW1qlBnI40fCagAZerR/jd10v1DdO/Uj1AVg1p
         pFmAoVyMJzL9P3hznl31wPi+qdTNi6SvQt5UT7Ym4zThsjwfUe+Jk5ua0WsjELBtk1Ob
         wyzBSqr2RQ4q/YHnUnbI+o84PVt2HrqzvjKRSy4u5ib+mjjJPjILJlLrs4ft9DHtFhBs
         2JBGCVEqo2kq2SV31JIKQgu8eCssAuumc07hxpwScgKi8Q1aY0BHR/MUw+j4IsACxW2v
         U9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZxvFJ8vplvDGPJt6csEulpOQH0sjgC9PBkVWErccdQ=;
        b=IlFbZpYQQTuWvcERjBHkqKoiJoVNDmwOcWeFrJSjIjpmN1SOI7IL8cXGrvsiwCqCnE
         psaPxHMmvZG4Ty7Uc0mW7jq03PmbvjHu/qjRej6WanDE8akHWdwjwJgWLJ5KcBsKpvT0
         VtTQu3Fh18+6DVPNsPUu9/nC7ql6O6QWj5SElxo4cWrXe65TPZZ+bV6z18tSx8kESf0R
         h6NGxzKBgbe06XA8Wva/Yep8yg/sfu1QSgBEIDlk/YGBeBorfQWblB5WJI4MYf5q3mI7
         AIWIP9rCOfpw+cTv1zcvA2T+bRWAldliSqLpHaP/ezrQbK7XasGjEeX/+38JqpbD1nsH
         pdgA==
X-Gm-Message-State: AFqh2kpqhY/SOffowii9hpcqRvFbVjKlz+MYeeahB6rDPwYCjT1hBNOE
	NEuBkOyWuT4oONdrIQweOKNlKmTExViFvYSlAktAEHUv
X-Google-Smtp-Source: AMrXdXvt4wQ8hUojgwypKdeqRzGpEVcvHLVntKHR+SDaVukCnUSUqBAGYmspvMLTFjZYGB8wG8ElryI1/LCcC5YU6Sg=
X-Received: by 2002:a17:907:6746:b0:7c1:4c59:6349 with SMTP id
 qm6-20020a170907674600b007c14c596349mr6415686ejc.187.1673367118075; Tue, 10
 Jan 2023 08:11:58 -0800 (PST)
MIME-Version: 1.0
References: <20230110160302.1470163-1-richard.purdie@linuxfoundation.org> <20230110160302.1470163-2-richard.purdie@linuxfoundation.org>
In-Reply-To: <20230110160302.1470163-2-richard.purdie@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 10 Jan 2023 10:11:46 -0600
Message-ID: <CAJdd5Gbd5YCE1AFMsiRh7NkDWBzB60jubdVJEMPbaNdrdKddrA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] process/cooker/command: Fix
 currentAsyncCommand locking/races
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Jan 2023 16:12:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14298

On Tue, Jan 10, 2023 at 10:03 AM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> currentAsyncCommand currently doesn't have any locking and we have
> a conflict in "idle" conditions since the idle functions count needs
> to be zero *and* there needs to be no active command.
>
> Move the changes/checks of currentAsyncCommand to within the lock
> and then we can add it to the condition for idle, simplifying some
> of the code.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/command.py        | 28 ++++++++++++++--------------
>  lib/bb/cooker.py         | 12 ++++++++----
>  lib/bb/server/process.py | 19 +++++++++++++------
>  3 files changed, 35 insertions(+), 24 deletions(-)
>
> diff --git a/lib/bb/command.py b/lib/bb/command.py
> index c325abbcda..c3dc872d0d 100644
> --- a/lib/bb/command.py
> +++ b/lib/bb/command.py
> @@ -51,13 +51,14 @@ class Command:
>      """
>      A queue of asynchronous commands for bitbake
>      """
> -    def __init__(self, cooker):
> +    def __init__(self, cooker, process_server):
>          self.cooker = cooker
>          self.cmds_sync = CommandsSync()
>          self.cmds_async = CommandsAsync()
>          self.remotedatastores = None
>
> -        # FIXME Add lock for this
> +        self.process_server = process_server
> +        # Access with locking using process_server.get_async_cmd()/set_async_cmd()
>          self.currentAsyncCommand = None
>          self.lastEvent = None
>
> @@ -100,18 +101,16 @@ class Command:
>                  return None, traceback.format_exc()
>              else:
>                  return result, None
> -        if self.currentAsyncCommand is not None:
> -            # Wait for the idle loop to have cleared (30s max)
> -            process_server.wait_for_idle(timeout=30)
> -            if self.currentAsyncCommand is not None:
> -                return None, "Busy (%s in progress)" % self.currentAsyncCommand[0]
> +        # Wait for the idle loop to have cleared (30s max)
> +        if not self.process_server.wait_for_idle(timeout=30):
> +            return None, "Busy (%s in progress)" % self.process_server.get_async_cmd()[0]
>          if command not in CommandsAsync.__dict__:
>              return None, "No such command"
> -        self.currentAsyncCommand = (command, commandline)
> -        self.cooker.idleCallBackRegister(self.runAsyncCommand, None)
> +        process_server.set_async_cmd((command, commandline))

You have a TOCTOU bug here; your wait_for_idle() should be atomic with
the set_async_cmd().

In my PoC, I split apart set_async_cmd() from clear_async_cmd():

 def set_async_cmd(self, cmd):
   with self.idle_cond:
     self.idle_cond.wait_for(self._idle_check)
     self.cooker.command.currentAsynCommand = cmd

 def clear_async_cmd(self):
   with bb.utils.lock_timeout(self._idlefuncsLock):
     self.cooker.command.currentAsyncCommand = None
     self.idle_cond.notify_all()

> +        self.cooker.idleCallBackRegister(self.runAsyncCommand, process_server)
>          return True, None
>
> -    def runAsyncCommand(self, _, _2, halt):
> +    def runAsyncCommand(self, _, process_server, halt):
>          try:
>              self.cooker.process_inotify_updates_apply()
>              if self.cooker.state in (bb.cooker.state.error, bb.cooker.state.shutdown, bb.cooker.state.forceshutdown):
> @@ -119,8 +118,9 @@ class Command:
>                  # and then raise BBHandledException triggering an exit
>                  self.cooker.updateCache()
>                  return bb.server.process.idleFinish("Cooker in error state")
> -            if self.currentAsyncCommand is not None:
> -                (command, options) = self.currentAsyncCommand
> +            cmd = process_server.get_async_cmd()
> +            if cmd is not None:
> +                (command, options) = cmd
>                  commandmethod = getattr(CommandsAsync, command)
>                  needcache = getattr( commandmethod, "needcache" )
>                  if needcache and self.cooker.state != bb.cooker.state.running:
> @@ -156,7 +156,7 @@ class Command:
>          bb.event.fire(event, self.cooker.data)
>          self.lastEvent = event
>          self.cooker.finishcommand()
> -        self.currentAsyncCommand = None
> +        self.process_server.set_async_cmd(None)
>
>      def reset(self):
>          if self.remotedatastores:
> @@ -749,7 +749,7 @@ class CommandsAsync:
>          """
>          event = params[0]
>          bb.event.fire(eval(event), command.cooker.data)
> -        command.currentAsyncCommand = None
> +        process_server.set_async_cmd(None)
>      triggerEvent.needcache = False
>
>      def resetCooker(self, command, params):
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 13d6e9d847..5a0e675b44 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -149,7 +149,7 @@ class BBCooker:
>      Manages one bitbake build run
>      """
>
> -    def __init__(self, featureSet=None, idleCallBackRegister=None, waitIdle=None):
> +    def __init__(self, featureSet=None, server=None):
>          self.recipecaches = None
>          self.eventlog = None
>          self.skiplist = {}
> @@ -163,8 +163,12 @@ class BBCooker:
>
>          self.configuration = bb.cookerdata.CookerConfiguration()
>
> -        self.idleCallBackRegister = idleCallBackRegister
> -        self.waitIdle = waitIdle
> +        self.process_server = server
> +        self.idleCallBackRegister = None
> +        self.waitIdle = None
> +        if server:
> +            self.idleCallBackRegister = server.register_idle_function
> +            self.waitIdle = server.wait_for_idle
>
>          bb.debug(1, "BBCooker starting %s" % time.time())
>          sys.stdout.flush()
> @@ -203,7 +207,7 @@ class BBCooker:
>          except UnsupportedOperation:
>              pass
>
> -        self.command = bb.command.Command(self)
> +        self.command = bb.command.Command(self, self.process_server)
>          self.state = state.initial
>
>          self.parser = None
> diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
> index 4422fd7311..36c109ffd3 100644
> --- a/lib/bb/server/process.py
> +++ b/lib/bb/server/process.py
> @@ -158,7 +158,7 @@ class ProcessServer():
>      def wait_for_idle(self, timeout=30):
>          # Wait for the idle loop to have cleared
>          with self.idle_cond:
> -            self.idle_cond.wait_for(lambda: len(self._idlefuns) == 0, timeout)
> +            return self.idle_cond.wait_for(lambda: len(self._idlefuns) == 0 and self.cooker.command.currentAsyncCommand is None, timeout) is not False
>
>      def main(self):
>          self.cooker.pre_serve()
> @@ -184,11 +184,9 @@ class ProcessServer():
>                  self.controllersock = False
>              if self.haveui:
>                  # Wait for the idle loop to have cleared (30s max)
> -                self.wait_for_idle(30)
> -                if self.cooker.command.currentAsyncCommand is not None:
> +                if not self.wait_for_idle(30):
>                      serverlog("Idle loop didn't finish queued commands after 30s, exiting.")
>                      self.quit = True
> -
>                  fds.remove(self.command_channel)
>                  bb.event.unregister_UIHhandler(self.event_handle, True)
>                  self.command_channel_reply.writer.close()
> @@ -377,6 +375,15 @@ class ProcessServer():
>                      msg.append(":\n%s" % procs)
>                  serverlog("".join(msg))
>
> +    def get_async_cmd(self):
> +        with bb.utils.lock_timeout(self._idlefuncsLock):
> +            return self.cooker.command.currentAsyncCommand
> +
> +    def set_async_cmd(self, cmd):
> +        with bb.utils.lock_timeout(self._idlefuncsLock):
> +            self.cooker.command.currentAsyncCommand = cmd
> +            self.idle_cond.notify_all()
> +
>      def idle_thread(self):
>          def remove_idle_func(function):
>              with bb.utils.lock_timeout(self._idlefuncsLock):
> @@ -427,7 +434,7 @@ class ProcessServer():
>                  lastdebug = time.time()
>                  with bb.utils.lock_timeout(self._idlefuncsLock):
>                      num_funcs = len(self._idlefuns)
> -                serverlog("Current command %s, idle functions %s, last exit event %s, state %s" % (self.cooker.command.currentAsyncCommand, num_funcs, self.cooker.command.lastEvent, self.cooker.state))
> +                serverlog("Current command %s, idle functions %s, last exit event %s, state %s" % (self.get_async_cmd(), num_funcs, self.cooker.command.lastEvent, self.cooker.state))
>
>              if nextsleep is not None:
>                  select.select(fds,[],[],nextsleep)[0]
> @@ -632,7 +639,7 @@ def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout, xmlrpc
>          writer = ConnectionWriter(readypipeinfd)
>          try:
>              featureset = []
> -            cooker = bb.cooker.BBCooker(featureset, server.register_idle_function, server.wait_for_idle)
> +            cooker = bb.cooker.BBCooker(featureset, server)
>              cooker.configuration.profile = profile
>          except bb.BBHandledException:
>              return None
> --
> 2.37.2
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14296): https://lists.openembedded.org/g/bitbake-devel/message/14296
> Mute This Topic: https://lists.openembedded.org/mt/96179934/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWhacker@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

