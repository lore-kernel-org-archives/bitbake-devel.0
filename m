Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AC3C4708D
	for <webhook@archiver.kernel.org>; Thu, 22 Dec 2022 23:47:34 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.60901.1671752850665460756
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Dec 2022 15:47:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hJynPUNK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id o15so2564662wmr.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Dec 2022 15:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHHlILX9B2Dcb3I3IxVcze1ZIeSnGaT/zwJmYdZTp9I=;
        b=hJynPUNKBJjdhgZ6eYj+FfJT6/vzyoVgW+ZGoUhEkwxJZt5Cp2SejXbrxJMq568AO1
         jUvyapEnbppagpn5zGoM2FlSx6Dx7pKFbJzQSV+uwqcx2N8qOd+ak8iGO171sieOrEGX
         Jur0xhS6TutqYFdc+cowtXV5q9WNmWe4n+QQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHHlILX9B2Dcb3I3IxVcze1ZIeSnGaT/zwJmYdZTp9I=;
        b=CNo94XALtrDPpeL9W8uTjXEtDDxJARLm6zI2b0yETzDX6UYxRgNXNRh8jyS/EdeNk1
         beAS/eQ55IVIhre37s4nnZyw7uFertwZ+KuS/Dn1Oi/0guPBFpuO0lIc1KzIzp8n2LEm
         cF2dKPnO5o4hZOeeWapLDqiqAH9o+HEfO+iALi6CtnmU3kftzp4H6//517fDbAODrhHG
         TL0qavOk6Hxf92UugF4Oa6akAnmphS9lSYolMlTHz79B9dawbeS6hWRFQry2Lwb940tW
         JOCNjbsJvSMTH/Oe0MJPfwzYest1/cGfbl819FbhPDWys4YaiGJPWsQyEl34Fp9FxB3L
         6hgA==
X-Gm-Message-State: AFqh2kotMUe12MIh6Z5dBXeHvb0EddRZ7XVJ4YX5/aRjOPoiFAHnUpYl
	BJRlVs1sLIQc8g1lO9rQRtZCMXVmp7xzB5WX
X-Google-Smtp-Source: AMrXdXtIlNXwQDE22k4pcl4ysnJvSyReXtKPHpYQBCmrize1BWZ0EwUJ1WG7zcKW1zMcgDBZHqTfMA==
X-Received: by 2002:a7b:c4d3:0:b0:3d3:5cd6:760 with SMTP id g19-20020a7bc4d3000000b003d35cd60760mr6403557wmk.20.1671752848941;
        Thu, 22 Dec 2022 15:47:28 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:bc21:fec7:83cf:e0c3])
        by smtp.gmail.com with ESMTPSA id bd25-20020a05600c1f1900b003cfd4cf0761sm7322189wmb.1.2022.12.22.15.47.28
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 15:47:28 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 03/10] event: builtins fix for 'd' deletion
Date: Thu, 22 Dec 2022 23:47:19 +0000
Message-Id: <20221222234726.579702-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221222234726.579702-1-richard.purdie@linuxfoundation.org>
References: <20221222234726.579702-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Dec 2022 23:47:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14232

I've been seeing event handlers where 'd' seems to disappear half way through
event handler execution. This is problematic when multiple threads are active
since this code assumes single threading.

The easiest fix is to change the handler function calls to contain d as a
parameter as we do elsewhere for other functions. This will break any non-text
handlers but I was only able to spot one of those in runqueue. It will also
break handlers than call functions that assume 'd' is in the global namespace
but those failures should be obvious and we can fix those to pass d around.

This solution avoids manipulating builtins which was always a horrible thing
to do anyway and solves the issue without needing locking, thankfully.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/event.py       | 18 ++++--------------
 lib/bb/runqueue.py    |  2 +-
 lib/bb/tests/color.py |  2 +-
 lib/bb/tests/event.py | 21 +++++++++++----------
 4 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 21e9a1b025..db90724444 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -71,11 +71,6 @@ _thread_lock = threading.Lock()
 _thread_lock_enabled = False
 _heartbeat_enabled = False
 
-if hasattr(__builtins__, '__setitem__'):
-    builtins = __builtins__
-else:
-    builtins = __builtins__.__dict__
-
 def enable_threadlock():
     global _thread_lock_enabled
     _thread_lock_enabled = True
@@ -94,12 +89,8 @@ def disable_heartbeat():
 
 def execute_handler(name, handler, event, d):
     event.data = d
-    addedd = False
-    if 'd' not in builtins:
-        builtins['d'] = d
-        addedd = True
     try:
-        ret = handler(event)
+        ret = handler(event, d)
     except (bb.parse.SkipRecipe, bb.BBHandledException):
         raise
     except Exception:
@@ -113,8 +104,7 @@ def execute_handler(name, handler, event, d):
         raise
     finally:
         del event.data
-        if addedd:
-            del builtins['d']
+
 
 def fire_class_handlers(event, d):
     if isinstance(event, logging.LogRecord):
@@ -262,12 +252,12 @@ def register(name, handler, mask=None, filename=None, lineno=None, data=None):
     if handler is not None:
         # handle string containing python code
         if isinstance(handler, str):
-            tmp = "def %s(e):\n%s" % (name, handler)
+            tmp = "def %s(e, d):\n%s" % (name, handler)
             try:
                 code = bb.methodpool.compile_cache(tmp)
                 if not code:
                     if filename is None:
-                        filename = "%s(e)" % name
+                        filename = "%s(e, d)" % name
                     code = compile(tmp, filename, "exec", ast.PyCF_ONLY_AST)
                     if lineno is not None:
                         ast.increment_lineno(code, lineno-1)
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index b9dd830b31..ce711b6252 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1511,7 +1511,7 @@ class RunQueue:
 
             if not self.dm_event_handler_registered:
                  res = bb.event.register(self.dm_event_handler_name,
-                                         lambda x: self.dm.check(self) if self.state in [runQueueRunning, runQueueCleanUp] else False,
+                                         lambda x, y: self.dm.check(self) if self.state in [runQueueRunning, runQueueCleanUp] else False,
                                          ('bb.event.HeartbeatEvent',), data=self.cfgData)
                  self.dm_event_handler_registered = True
 
diff --git a/lib/bb/tests/color.py b/lib/bb/tests/color.py
index 88dd278006..bb70cb393d 100644
--- a/lib/bb/tests/color.py
+++ b/lib/bb/tests/color.py
@@ -20,7 +20,7 @@ class ProgressWatcher:
     def __init__(self):
         self._reports = []
 
-    def handle_event(self, event):
+    def handle_event(self, event, d):
         self._reports.append((event.progress, event.rate))
 
     def reports(self):
diff --git a/lib/bb/tests/event.py b/lib/bb/tests/event.py
index 9ca7e9bc8e..4de4cced5e 100644
--- a/lib/bb/tests/event.py
+++ b/lib/bb/tests/event.py
@@ -157,7 +157,7 @@ class EventHandlingTest(unittest.TestCase):
                                  self._test_process.event_handler,
                                  event,
                                  None)
-        self._test_process.event_handler.assert_called_once_with(event)
+        self._test_process.event_handler.assert_called_once_with(event, None)
 
     def test_fire_class_handlers(self):
         """ Test fire_class_handlers method """
@@ -175,10 +175,10 @@ class EventHandlingTest(unittest.TestCase):
         bb.event.fire_class_handlers(event1, None)
         bb.event.fire_class_handlers(event2, None)
         bb.event.fire_class_handlers(event2, None)
-        expected_event_handler1 = [call(event1)]
-        expected_event_handler2 = [call(event1),
-                                   call(event2),
-                                   call(event2)]
+        expected_event_handler1 = [call(event1, None)]
+        expected_event_handler2 = [call(event1, None),
+                                   call(event2, None),
+                                   call(event2, None)]
         self.assertEqual(self._test_process.event_handler1.call_args_list,
                          expected_event_handler1)
         self.assertEqual(self._test_process.event_handler2.call_args_list,
@@ -205,7 +205,7 @@ class EventHandlingTest(unittest.TestCase):
         bb.event.fire_class_handlers(event2, None)
         bb.event.fire_class_handlers(event2, None)
         expected_event_handler1 = []
-        expected_event_handler2 = [call(event1)]
+        expected_event_handler2 = [call(event1, None)]
         self.assertEqual(self._test_process.event_handler1.call_args_list,
                          expected_event_handler1)
         self.assertEqual(self._test_process.event_handler2.call_args_list,
@@ -223,7 +223,7 @@ class EventHandlingTest(unittest.TestCase):
         self.assertEqual(result, bb.event.Registered)
         bb.event.fire_class_handlers(event1, None)
         bb.event.fire_class_handlers(event2, None)
-        expected = [call(event1), call(event2)]
+        expected = [call(event1, None), call(event2, None)]
         self.assertEqual(self._test_process.event_handler1.call_args_list,
                          expected)
 
@@ -237,7 +237,7 @@ class EventHandlingTest(unittest.TestCase):
         self.assertEqual(result, bb.event.Registered)
         bb.event.fire_class_handlers(event1, None)
         bb.event.fire_class_handlers(event2, None)
-        expected = [call(event1), call(event2), call(event1)]
+        expected = [call(event1, None), call(event2, None), call(event1, None)]
         self.assertEqual(self._test_process.event_handler1.call_args_list,
                          expected)
 
@@ -251,7 +251,7 @@ class EventHandlingTest(unittest.TestCase):
         self.assertEqual(result, bb.event.Registered)
         bb.event.fire_class_handlers(event1, None)
         bb.event.fire_class_handlers(event2, None)
-        expected = [call(event1), call(event2), call(event1), call(event2)]
+        expected = [call(event1,None), call(event2, None), call(event1, None), call(event2, None)]
         self.assertEqual(self._test_process.event_handler1.call_args_list,
                          expected)
 
@@ -359,9 +359,10 @@ class EventHandlingTest(unittest.TestCase):
 
         event1 = bb.event.ConfigParsed()
         bb.event.fire(event1, None)
-        expected = [call(event1)]
+        expected = [call(event1, None)]
         self.assertEqual(self._test_process.event_handler1.call_args_list,
                          expected)
+        expected = [call(event1)]
         self.assertEqual(self._test_ui1.event.send.call_args_list,
                          expected)
 
-- 
2.37.2


