Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51EBC4332F
	for <webhook@archiver.kernel.org>; Tue, 20 Dec 2022 15:16:13 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.52463.1671549369341410535
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Dec 2022 07:16:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hOquWpNu;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso9057807wmp.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Dec 2022 07:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/QkP+R7JzhaP4NO32Ri8AK0ASIbzYTO8+Qrkj6UJp8=;
        b=hOquWpNuhozB36VlZN/rYtBmoJ7UGa4YzLQW7jLtEFbUPcakAVGRrDLOhZXbToTKH8
         wcVkD0VVqtbgJ9wU4QELGo4w0RUlpASOK/St3VF5uohUqYFL+z822SGcSDQULuiwMgik
         1A7jrRebhsvtGLf5aQb5+bleqgyWuGo0IIzwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/QkP+R7JzhaP4NO32Ri8AK0ASIbzYTO8+Qrkj6UJp8=;
        b=FOdTEd1HXSxnUhzgpuAkFc4xmgUJNJR345WfSHlinwHfBKlTSEetCnRJIcKv2xMrL/
         6PuXmCxFZwE3kbxyhl+W7J8sSpZ6jFX1s5SpxX3qNziGdLuJZuikFKM1aj5Q9qOcMZS7
         z6vgKiFhvvroZUgA9MPetYnUcwBSLWac7I4StjhPH1ZB3A+BdJkh94OK7chfv92Ec8p/
         MnP78ubMtJzg2jw6lzwcej5XDz0Zpli7TxNareGXO4nbUDWq6VbcXDwDUu/3iqYdYW3p
         NhkFOZv7brOqZ7sGs1W43iHNv0fM+4riT4sdzPyUu6cSGcTaOLAhRKbGfV6JwADlF4iz
         z/gA==
X-Gm-Message-State: ANoB5pke9zhE0njMaTqBhWkq0t2kwyfvJjP26bRTkn9cffsxGlx9TCUz
	hVq9bg+Ox7Isj17aP30vtOcwZYTBrubPQYJM
X-Google-Smtp-Source: AA0mqf4UReaiqq8g6dUY4ZVG1hl2HPu4qEBPRpU2MYPkwDLgmKp9HArplMbXZeGkAgGomYpHtO5jsg==
X-Received: by 2002:a05:600c:3b1b:b0:3d1:fe12:fe34 with SMTP id m27-20020a05600c3b1b00b003d1fe12fe34mr35443199wms.39.1671549367518;
        Tue, 20 Dec 2022 07:16:07 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1273:dbb7:632c:a9de])
        by smtp.gmail.com with ESMTPSA id k12-20020adff28c000000b0022e57e66824sm14896439wro.99.2022.12.20.07.16.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 07:16:07 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 5/6] server/process: Run idle commands in a separate idle thread
Date: Tue, 20 Dec 2022 15:16:03 +0000
Message-Id: <20221220151604.415637-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221220151604.415637-1-richard.purdie@linuxfoundation.org>
References: <20221220151604.415637-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Dec 2022 15:16:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14213

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
 lib/bb/cooker.py         | 13 +++++----
 lib/bb/server/process.py | 60 +++++++++++++++++++++++++---------------
 2 files changed, 46 insertions(+), 27 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 815610ff82..f578d2ceea 100644
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
@@ -248,11 +250,12 @@ class BBCooker:
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
+                    n.process_events()
 
     def config_notifications(self, event):
         if event.maskname == "IN_Q_OVERFLOW":
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 826f6f52cc..95e2968742 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -87,6 +87,7 @@ class ProcessServer():
         self.maxuiwait = 30
         self.xmlrpc = False
 
+        self.idle = None
         self._idlefuns = {}
 
         self.bitbake_lock = lock
@@ -144,6 +145,7 @@ class ProcessServer():
         self.cooker.pre_serve()
 
         bb.utils.set_process_name("Cooker")
+        bb.event.enable_threadlock()
 
         ready = []
         newconnections = []
@@ -274,6 +276,9 @@ class ProcessServer():
 
             ready = self.idle_commands(.1, fds)
 
+        if self.idle:
+            self.idle.join()
+
         serverlog("Exiting (socket: %s)" % os.path.exists(self.sockname))
         # Remove the socket file so we don't get any more connections to avoid races
         try:
@@ -342,33 +347,44 @@ class ProcessServer():
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


