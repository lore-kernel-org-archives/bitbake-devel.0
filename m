Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116DEC10F1B
	for <webhook@archiver.kernel.org>; Wed, 21 Dec 2022 14:15:54 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.19680.1671632147316626987
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Dec 2022 06:15:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TdmZ3eX8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id y8so2060834wrl.13
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 06:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHHlILX9B2Dcb3I3IxVcze1ZIeSnGaT/zwJmYdZTp9I=;
        b=TdmZ3eX84LYdLV7YOOMOKwBvJjAlzqLCN0aTGRlIszfi5lWdxIaG77CisISrBZR8/d
         9Yc4XGARvEM27DHrYNF5s+ho8sjxgV4HxhRw6i31OaAc2DVayKAFxzaASFz1d+pEDjPO
         no9VLfHXTwJiEOBJ4+5X+7G148BABX8shs8kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHHlILX9B2Dcb3I3IxVcze1ZIeSnGaT/zwJmYdZTp9I=;
        b=JJcL/RFo2GFY+8HAY52rqAirfqyA7nVGGtD2RVJowwxCY/E8P9B+zKMAyGWFJ1Bf6T
         0aOEMd4sqZElIFwjKVv4alK9y5NWC08fyQbH++6mJIUVW0qAy/cpy06OEJ9roU7CXaN7
         MzwdJEUuQaOVEsMklDHE1OSKrDZf5z8mtgpnL2VZHygPjruGMCN4HfoqskBLvrWty45X
         Ts687dqrGMDpNWKvov0QkqwuODbpfATXX1bUUwPUVyNuSAxUCEpHP48+JPHMTSXKwWsq
         Qnj0GQiNDJ4AcgFtpCmj/k0nowpcv7Felw8kKxxO3qViB+ol7VHyjy8a5XPcL4yJQdS0
         46Lg==
X-Gm-Message-State: AFqh2koCk95YGvlgGVQmBeILyHQcl60ND8wxLRNfpmD5/maH/wEZtgbE
	BAsn29OnSHbJ/ZhBNNN05/VVOqx7jc97a2z2
X-Google-Smtp-Source: AMrXdXs+pNjy8xJ7wDwVjmI5/vDwHdNwP27W0du/dC9X/JhPXDwR6WdwWfc+r4+ben9QElv3opL9nA==
X-Received: by 2002:a5d:50c9:0:b0:236:770a:665a with SMTP id f9-20020a5d50c9000000b00236770a665amr1051436wrt.66.1671632145641;
        Wed, 21 Dec 2022 06:15:45 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e749:b020:2cdb:af31])
        by smtp.gmail.com with ESMTPSA id k12-20020adff28c000000b0022e57e66824sm17839412wro.99.2022.12.21.06.15.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 06:15:45 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/7] event: builtins fix for 'd' deletion
Date: Wed, 21 Dec 2022 14:15:39 +0000
Message-Id: <20221221141543.497904-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221221141543.497904-1-richard.purdie@linuxfoundation.org>
References: <20221221141543.497904-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 14:15:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14220

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


