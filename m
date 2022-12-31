Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4CCC54E76
	for <webhook@archiver.kernel.org>; Sat, 31 Dec 2022 16:59:02 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.45615.1672505937283650852
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 31 Dec 2022 08:58:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=P7nz+ZRE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id o15so17507728wmr.4
        for <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 08:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsTD4xHKFfe8PPl0pYTf+UUQ2w5qyHP00COIBsaItA8=;
        b=P7nz+ZRE1UXAVj3fP9RpulUR1UuY+Pr9iqdUeOoP80z+Y/xUmfuVxTg6DYJCux6Q26
         6I8z3b5EWjjawZPAznTT0b9C3ylT+B+yaDTDLjVKAPMLxkEU/OCCFUMORpGqoVjv6i6l
         ymLfpeoMQ0P2WsCRd9HvrfQVexvIs62XFKUUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsTD4xHKFfe8PPl0pYTf+UUQ2w5qyHP00COIBsaItA8=;
        b=JjlFcdkQXuRJR/dYzK1rfb+j6rNwATZ+4HwNuqEUHM5DTFZl023TgMbleBEM+j8fCM
         R/LXMxo0clbv2WprvGI3iNwHAygmrTX/Btt8cNYJv/SbFbPvgPffytktKebFhGMZXiSF
         /GMsLnA6axJga9q3K9fSydMxy5w1KmJ0qhFZZl8mpgRCBaLi7o8SnmY/yL4d9bIlgjMl
         x6L3cV1HrnzmURrRvd+wbmm/aY8gNmuc66B5xNMYvyh6QV96ndGeNQxf5G8qXlonL/Ru
         Wn2w0TJnjV3jHCFwvv/pOpK2uALLuEtV+v4DT9y2rHzqrZfX/fWnPiozpEb1WjnK9ukC
         CZVA==
X-Gm-Message-State: AFqh2kqq4TxKMFOTsYYTynDOJyXETFDHA0iYsXbe8DmdWBvHwBQAiw5N
	lRO+UCvrPp1F4+y6kwLRWg3ccwMh0enXIpqk
X-Google-Smtp-Source: AMrXdXvFenwAnk687RWfIuvhBkHoCcf3WWZXbLQ/rE93x/wmQ3gA9nSRpVslo/Xr5y+UbmQETZSLZQ==
X-Received: by 2002:a05:600c:35ca:b0:3d1:f2de:195a with SMTP id r10-20020a05600c35ca00b003d1f2de195amr28281707wmq.32.1672505935552;
        Sat, 31 Dec 2022 08:58:55 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1a1f:74ee:21ca:3bb])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003b47b80cec3sm36582812wmq.42.2022.12.31.08.58.55
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 08:58:55 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 08/11] event: Always use threadlock
Date: Sat, 31 Dec 2022 16:58:46 +0000
Message-Id: <20221231165849.964169-9-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221231165849.964169-1-richard.purdie@linuxfoundation.org>
References: <20221231165849.964169-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 16:59:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14269

With the move to a server idle thread, we always need threading. The
existing accessor functions could end up turning this off!

I was going to hold the lock whilst changing it, check if the value
was already set, cache the result and also fix the event code to always
release the lock with a try/finally.

Instead, disable the existing functions and use a with: block
to handle the lock, keeping things much simpler.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/event.py       | 73 ++++++++++++++++++++-----------------------
 lib/bb/tests/event.py | 17 +---------
 2 files changed, 35 insertions(+), 55 deletions(-)

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


