Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE03C4332F
	for <webhook@archiver.kernel.org>; Wed, 21 Dec 2022 23:35:17 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.33951.1671665710298879048
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Dec 2022 15:35:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dOUxTtYW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so102295wmb.5
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 15:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M17YPV9+LXFC21btQGaTy1+O0Rg0A/VlmpfX4t3Vehs=;
        b=dOUxTtYWrwqbaiuJzeTvNayADRXz9pyKkvf+hR3yvMqW36Ad/uptHHrV6wenLVB2mP
         fkrh55OthR1MPTXsS/olgc1x5EccWI6+l3RQlsgZMknG9koKeD9FiE9jAlVZ9FbUMeKp
         KODUxRVcVRGxEXBLG1dHERB9SxSrfc8r3lTl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M17YPV9+LXFC21btQGaTy1+O0Rg0A/VlmpfX4t3Vehs=;
        b=bGVFPAHHpmZBvUGqCTZvqDIKYyZUMNnIgBCZmVUjSmW5FiDHVobQSdhzv64dqNC9zS
         m/LrQ9Q8mQ/rIHttJUG//xIT0CulUG07zoQSqaIFPhz25YeHSME6apZqgweqcxqoi6rS
         80L2wWGrTuvtud+E+m4euzKkwexWWbiYxZfq3SrSRedXAhQdaV+z/B5AHNLAYZTOIQzp
         IvgfuUVXWko8uy4NAA/RbX7TJ8Vtl31oCVd5o/cEJf3gvfducwvo/APMHPWuQuL93j8t
         UX7Lexr9rFIPpu38zDWZv0gsgW8OXXURXOsLpKLlN+YSwRvW9aSMsRlPXFPV9YiMfOhN
         NAcw==
X-Gm-Message-State: AFqh2kr6fEO1EebExEgkajOuz/Eoe4+QqL21yOmzU7fn6reeqNMUFyBF
	preiNLheHqBAE/DZ17QUZaS0rrifubidjQEW
X-Google-Smtp-Source: AMrXdXvSpCifX5t2Ch+NBcqbHKJC+J17ik1w/lLDqEP/lkbAcIVXk5+K1ZlmWONIifjSa3v6zAY9nA==
X-Received: by 2002:a7b:c3c6:0:b0:3d2:3376:6f37 with SMTP id t6-20020a7bc3c6000000b003d233766f37mr2815280wmj.10.1671665708503;
        Wed, 21 Dec 2022 15:35:08 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a8db:6d5d:f54f:c6b2])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c310f00b003b47e75b401sm4063967wmo.37.2022.12.21.15.35.07
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 15:35:08 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] event: Always use threadlock
Date: Wed, 21 Dec 2022 23:35:05 +0000
Message-Id: <20221221233507.519249-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 23:35:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14227

With the move to a server idle thread, we always need threading. The
existing accessor functions could end up turning this off!

I was going to hold the lock whilst changing it, check if the value
was already set, cache the result and also fix the event code to always
release the lock with a try/finally.

Instead, disable the existing functions and use a with: block
to handle the lock, keeping things much simpler.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/event.py          | 73 +++++++++++++++++++---------------------
 lib/bb/server/process.py |  1 -
 lib/bb/tests/event.py    | 17 +---------
 3 files changed, 35 insertions(+), 56 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index db90724444..7826541a64 100644
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
@@ -322,21 +315,23 @@ def set_eventfilter(func):
     _eventfilter = func
 
 def register_UIHhandler(handler, mainui=False):
-    bb.event._ui_handler_seq = bb.event._ui_handler_seq + 1
-    _ui_handlers[_ui_handler_seq] = handler
-    level, debug_domains = bb.msg.constructLogOptions()
-    _ui_logfilters[_ui_handler_seq] = UIEventFilter(level, debug_domains)
-    if mainui:
-        global _uiready
-        _uiready = _ui_handler_seq
-    return _ui_handler_seq
+    with _thread_lock:
+        bb.event._ui_handler_seq = bb.event._ui_handler_seq + 1
+        _ui_handlers[_ui_handler_seq] = handler
+        level, debug_domains = bb.msg.constructLogOptions()
+        _ui_logfilters[_ui_handler_seq] = UIEventFilter(level, debug_domains)
+        if mainui:
+            global _uiready
+            _uiready = _ui_handler_seq
+        return _ui_handler_seq
 
 def unregister_UIHhandler(handlerNum, mainui=False):
     if mainui:
         global _uiready
         _uiready = False
-    if handlerNum in _ui_handlers:
-        del _ui_handlers[handlerNum]
+    with _thread_lock:
+        if handlerNum in _ui_handlers:
+            del _ui_handlers[handlerNum]
     return
 
 def get_uihandler():
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


