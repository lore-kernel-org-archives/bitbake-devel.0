Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C540C4332F
	for <webhook@archiver.kernel.org>; Wed, 21 Dec 2022 14:47:04 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.20242.1671634015268371634
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Dec 2022 06:46:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aDWXxedu;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so2698054wml.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 06:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ow6He/0Ea880HRW42wzo9Pl2PtNjkCItTgbPjbcKHlo=;
        b=aDWXxeduws/OVlKdVIA7qL2GZVIj/u/BFMza5VJ808cd2RWIUB9LyDTGhiqVi8VnY8
         /A3859YanXZ6PlcTmOAuVhllzaSyoy0NUNlA9+rI0pEQj5LCe07VX+PgRvFdkFR/9lV7
         ghTkJDCjQU0uiVtYHjNEkGBdHcpvrQ6QHOx1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ow6He/0Ea880HRW42wzo9Pl2PtNjkCItTgbPjbcKHlo=;
        b=PlYYvzS2fEkyr0dCFMbdd4aK4fsrMdHbxs7cHSSlAK6OoBE97GtnsHjgCV3sEbOtPI
         8/nzPb9//rXajHfn21/RSJazYr1UNf1getTv1M/oOQutVTV/SE2UEP6A8GdfLQKL2d9z
         UqJTZ4C0Cq2rxnVE+evJzmcJr0ldwjjAnDw13CL6KzlbwmRFS1oNix4DrZPbbMs4hcIb
         b5hAmuerItNo8dz8EUY9gO4R/bUl4AYNwKlvcjHI3qn9x2TD3dmVcgF5ZF2IRUrKGwCu
         GB566IqNrD3Hpgb8pnjW8v9Fvz3/Et6RXlO7ZLvd3PHyoozqrdZqV471YCe0cC88Xk2K
         Ueug==
X-Gm-Message-State: AFqh2koNmgBLmM/EGlf2L4xRGMTlWuZEsZLf45G6oIzaZobAEcpwI5Zx
	UQN9kwt2CmDOa44vSGomhLKN6MoFxUrtGu/V
X-Google-Smtp-Source: AMrXdXsY0SQIMjZb34Tfu1z64rmD6Z5p3JmZZvNacj0n1QHJAh/CXEHtoLsPEWjD2Knu8A2bEEk6fQ==
X-Received: by 2002:a1c:720e:0:b0:3d1:f629:6b56 with SMTP id n14-20020a1c720e000000b003d1f6296b56mr1836442wmc.20.1671634013067;
        Wed, 21 Dec 2022 06:46:53 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e749:b020:2cdb:af31])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c1d8300b003d1e4f3ac8esm2506891wms.33.2022.12.21.06.46.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 06:46:52 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] event: Always use threadlock
Date: Wed, 21 Dec 2022 14:46:52 +0000
Message-Id: <20221221144652.498694-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 14:47:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14225

With the move to a server idle thread, we always need threading. The
existing accessor functions could end up turning this off!

I was going to hold the lock whilst changing it, check if the value
was already set, cache the result and also fix the event code to always
release the lock with a try/finally.

Instead, disable the existing functions and use a with: block
to handle the lock, keeping things much simpler.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/event.py          | 51 +++++++++++++++++-----------------------
 lib/bb/server/process.py |  1 -
 2 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index db90724444..603fcd7aee 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -68,16 +68,15 @@ _catchall_handlers = {}
 _eventfilter = None
 _uiready = False
 _thread_lock = threading.Lock()
-_thread_lock_enabled = False
 _heartbeat_enabled = False
 
 def enable_threadlock():
-    global _thread_lock_enabled
-    _thread_lock_enabled = True
+    # Always needed now
+    return
 
 def disable_threadlock():
-    global _thread_lock_enabled
-    _thread_lock_enabled = False
+    # Always needed now
+    return
 
 def enable_heartbeat():
     global _heartbeat_enabled
@@ -179,36 +178,30 @@ def print_ui_queue():
 
 def fire_ui_handlers(event, d):
     global _thread_lock
-    global _thread_lock_enabled
 
     if not _uiready:
         # No UI handlers registered yet, queue up the messages
         ui_queue.append(event)
         return
 
-    if _thread_lock_enabled:
-        _thread_lock.acquire()
-
-    errors = []
-    for h in _ui_handlers:
-        #print "Sending event %s" % event
-        try:
-             if not _ui_logfilters[h].filter(event):
-                 continue
-             # We use pickle here since it better handles object instances
-             # which xmlrpc's marshaller does not. Events *must* be serializable
-             # by pickle.
-             if hasattr(_ui_handlers[h].event, "sendpickle"):
-                _ui_handlers[h].event.sendpickle((pickle.dumps(event)))
-             else:
-                _ui_handlers[h].event.send(event)
-        except:
-            errors.append(h)
-    for h in errors:
-        del _ui_handlers[h]
-
-    if _thread_lock_enabled:
-        _thread_lock.release()
+    with _thread_lock:
+        errors = []
+        for h in _ui_handlers:
+            #print "Sending event %s" % event
+            try:
+                 if not _ui_logfilters[h].filter(event):
+                     continue
+                 # We use pickle here since it better handles object instances
+                 # which xmlrpc's marshaller does not. Events *must* be serializable
+                 # by pickle.
+                 if hasattr(_ui_handlers[h].event, "sendpickle"):
+                    _ui_handlers[h].event.sendpickle((pickle.dumps(event)))
+                 else:
+                    _ui_handlers[h].event.send(event)
+            except:
+                errors.append(h)
+        for h in errors:
+            del _ui_handlers[h]
 
 def fire(event, d):
     """Fire off an Event"""
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 12dfb6ea19..51eb882092 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -150,7 +150,6 @@ class ProcessServer():
         self.cooker.pre_serve()
 
         bb.utils.set_process_name("Cooker")
-        bb.event.enable_threadlock()
 
         ready = []
         newconnections = []
-- 
2.37.2


