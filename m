Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885A6C4332F
	for <webhook@archiver.kernel.org>; Wed, 21 Dec 2022 15:36:24 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.21687.1671636981830323936
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Dec 2022 07:36:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hwHr0CMy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id y16so15347549wrm.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 07:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1FRIx7g3fVuuqqeQjrNxSrr6Uzp6yf64O6D5gga4q4E=;
        b=hwHr0CMyQCtQzO/PJwfiuyK1Xlqq3zhdkaK0bXZTJYl5lmBqS4QrScrJkixoUtt6vz
         liFom/Qjo83Y3xMx9Qh1L8Xtd3zOcMcmZMxMKe1RpwVdomxI/pSn745StEZFQ+TVd5Cw
         REv5jH7DURssAsDzATNQeCjvXN9HPw6fP5QXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FRIx7g3fVuuqqeQjrNxSrr6Uzp6yf64O6D5gga4q4E=;
        b=foktjf9PaZUVmhjhEG37n9vPMidQC/jWp+aw/1JVXFYDiZY9dQNdpjfmySCf8UXgLw
         HJ9+sMUE47gF6D+OQQTd77DjAPnO27JaAoa8dnzFoeJzHkUwxfMdV9m+LeH8TFzsfE4i
         wcEVRjlMdE4ZJtZ+mY5KD8XvRizQk6TnLzmNjUWOHPW9UPTtl2bGrYc3UHg4enLRcJPq
         MdyOhpV9Vd99tg7bfQWWmrhFis9uGkgJ4BpaE9qLQoMiGsazYnzWQflXXEduyEBolJ89
         LUZKEaPRvXvXM4FpxsejsJ6jrwN0APTRrSCA3p2YkxKis+hrLImf5U0Xh5x0XY7NcWPo
         cP/w==
X-Gm-Message-State: AFqh2kpwzvFGGx+tt1OSorqxOXuCxxxbW+FXSSCg9zJTjX2pIhq6BVL/
	i12/iP8shveme6KbKo0IUfQwjCVfkKWdEPnB
X-Google-Smtp-Source: AMrXdXvApl+wuKLEUqjzJIXAA1FRDCgSMB62tqGGCrPfiR+nDRCKLEj8e5rxY0SkgQIDud5ren9oUw==
X-Received: by 2002:a05:6000:5ca:b0:24f:11eb:2988 with SMTP id bh10-20020a05600005ca00b0024f11eb2988mr1345116wrb.71.1671636979713;
        Wed, 21 Dec 2022 07:36:19 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e749:b020:2cdb:af31])
        by smtp.gmail.com with ESMTPSA id k12-20020adff28c000000b0022e57e66824sm18035052wro.99.2022.12.21.07.36.19
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 07:36:19 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] event: Always use threadlock
Date: Wed, 21 Dec 2022 15:36:18 +0000
Message-Id: <20221221153618.504554-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 15:36:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14226

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
 lib/bb/tests/event.py    | 17 +-------------
 3 files changed, 23 insertions(+), 46 deletions(-)

v2: Fix testcases

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
diff --git a/lib/bb/tests/event.py b/lib/bb/tests/event.py
index 4de4cced5e..d959f2d95d 100644
--- a/lib/bb/tests/event.py
+++ b/lib/bb/tests/event.py
@@ -451,10 +451,9 @@ class EventHandlingTest(unittest.TestCase):
             and disable threadlocks tests """
         bb.event.fire(bb.event.OperationStarted(), None)
 
-    def test_enable_threadlock(self):
+    def test_event_threadlock(self):
         """ Test enable_threadlock method """
         self._set_threadlock_test_mockups()
-        bb.event.enable_threadlock()
         self._set_and_run_threadlock_test_workers()
         # Calls to UI handlers should be in order as all the registered
         # handlers for the event coming from the first worker should be
@@ -462,20 +461,6 @@ class EventHandlingTest(unittest.TestCase):
         self.assertEqual(self._threadlock_test_calls,
                          ["w1_ui1", "w1_ui2", "w2_ui1", "w2_ui2"])
 
-
-    def test_disable_threadlock(self):
-        """ Test disable_threadlock method """
-        self._set_threadlock_test_mockups()
-        bb.event.disable_threadlock()
-        self._set_and_run_threadlock_test_workers()
-        # Calls to UI handlers should be intertwined together. Thanks to the
-        # delay in the registered handlers for the event coming from the first
-        # worker, the event coming from the second worker starts being
-        # processed before finishing handling the first worker event.
-        self.assertEqual(self._threadlock_test_calls,
-                         ["w1_ui1", "w2_ui1", "w1_ui2", "w2_ui2"])
-
-
 class EventClassesTest(unittest.TestCase):
     """ Event classes test class """
 
-- 
2.37.2


