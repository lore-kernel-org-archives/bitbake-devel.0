Return-Path: <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 8B72478570
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Aug 2017 20:41:20 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	17 Aug 2017 13:41:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,389,1498546800"; d="scan'208";a="891183040"
Received: from jairdeje-mobl1.zpn.intel.com ([10.219.4.45])
	by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2017 13:41:21 -0700
From: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Aug 2017 15:40:50 -0500
Message-Id: <c4eab4956a74ded14ba316c9bcfe153d9a57930b.1503000752.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1503000752.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
References: <cover.1503000752.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Subject: [selftest][PATCH V1 1/5] bitbake: tests: Include tests for event filtering features
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 17 Aug 2017 20:41:20 -0000

This change includes unit tests for the following functions,
helper class and methods in bitbake.event:

- set_eventfilter(func)
- set_UIHmask(handlerNum, level, debug_domains, mask)
- getName(e)
- class UIEventFilter(object)
    def __init__(self, level, debug_domains)
    def update(self, eventmask, level, debug_domains)
    def filter(self, event)

[YOCTO #10773]

Signed-off-by: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
---
 lib/bb/tests/event.py | 120 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 111 insertions(+), 9 deletions(-)

diff --git a/lib/bb/tests/event.py b/lib/bb/tests/event.py
index c7eb1fe..1ddcb41 100644
--- a/lib/bb/tests/event.py
+++ b/lib/bb/tests/event.py
@@ -30,28 +30,45 @@ import time
 import pickle
 from unittest.mock import Mock
 from unittest.mock import call
+from bb.msg import BBLogFormatter
 
 
-class EventQueueStub():
-    """ Class used as specification for UI event handler queue stub objects """
+class EventQueueStubBase(object):
+    """ Base class for EventQueueStub classes """
     def __init__(self):
+        self.event_calls = []
         return
 
-    def send(self, event):
+    def _store_event_data_string(self, event):
+        if isinstance(event, logging.LogRecord):
+            formatter = BBLogFormatter("%(levelname)s: %(message)s")
+            self.event_calls.append(formatter.format(event))
+        else:
+            self.event_calls.append(bb.event.getName(event))
         return
 
 
-class PickleEventQueueStub():
+class EventQueueStub(EventQueueStubBase):
+    """ Class used as specification for UI event handler queue stub objects """
+    def __init__(self):
+        super(EventQueueStub, self).__init__()
+
+    def send(self, event):
+        super(EventQueueStub, self)._store_event_data_string(event)
+
+
+class PickleEventQueueStub(EventQueueStubBase):
     """ Class used as specification for UI event handler queue stub objects
         with sendpickle method """
     def __init__(self):
-        return
+        super(PickleEventQueueStub, self).__init__()
 
     def sendpickle(self, pickled_event):
-        return
+        event = pickle.loads(pickled_event)
+        super(PickleEventQueueStub, self)._store_event_data_string(event)
 
 
-class UIClientStub():
+class UIClientStub(object):
     """ Class used as specification for UI event handler stub objects """
     def __init__(self):
         self.event = None
@@ -59,7 +76,7 @@ class UIClientStub():
 
 class EventHandlingTest(unittest.TestCase):
     """ Event handling test class """
-    _threadlock_test_calls = []
+
 
     def setUp(self):
         self._test_process = Mock()
@@ -179,6 +196,33 @@ class EventHandlingTest(unittest.TestCase):
         self.assertEqual(self._test_process.event_handler2.call_args_list,
                          expected_event_handler2)
 
+    def test_class_handler_filters(self):
+        """ Test filters for class handlers """
+        mask = ["bb.event.OperationStarted"]
+        result = bb.event.register("event_handler1",
+                                   self._test_process.event_handler1,
+                                   mask)
+        self.assertEqual(result, bb.event.Registered)
+        result = bb.event.register("event_handler2",
+                                   self._test_process.event_handler2,
+                                   "*")
+        self.assertEqual(result, bb.event.Registered)
+        bb.event.set_eventfilter(
+            lambda name, handler, event, d :
+            name == 'event_handler2' and
+            bb.event.getName(event) == "OperationStarted")
+        event1 = bb.event.OperationStarted()
+        event2 = bb.event.OperationCompleted(total=123)
+        bb.event.fire_class_handlers(event1, None)
+        bb.event.fire_class_handlers(event2, None)
+        bb.event.fire_class_handlers(event2, None)
+        expected_event_handler1 = []
+        expected_event_handler2 = [call(event1)]
+        self.assertEqual(self._test_process.event_handler1.call_args_list,
+                         expected_event_handler1)
+        self.assertEqual(self._test_process.event_handler2.call_args_list,
+                         expected_event_handler2)
+
     def test_change_handler_event_mapping(self):
         """ Test changing the event mapping for class handlers """
         event1 = bb.event.OperationStarted()
@@ -259,6 +303,61 @@ class EventHandlingTest(unittest.TestCase):
         self.assertEqual(self._test_ui2.event.sendpickle.call_args_list,
                          expected)
 
+    def test_ui_handler_mask_filter(self):
+        """ Test filters for UI handlers """
+        mask = ["bb.event.OperationStarted"]
+        debug_domains = {}
+        self._test_ui1.event = Mock(spec_set=EventQueueStub)
+        result = bb.event.register_UIHhandler(self._test_ui1, mainui=True)
+        bb.event.set_UIHmask(result, logging.INFO, debug_domains, mask)
+        self._test_ui2.event = Mock(spec_set=PickleEventQueueStub)
+        result = bb.event.register_UIHhandler(self._test_ui2, mainui=True)
+        bb.event.set_UIHmask(result, logging.INFO, debug_domains, mask)
+
+        event1 = bb.event.OperationStarted()
+        event2 = bb.event.OperationCompleted(total=1)
+
+        bb.event.fire_ui_handlers(event1, None)
+        bb.event.fire_ui_handlers(event2, None)
+        expected = [call(event1)]
+        self.assertEqual(self._test_ui1.event.send.call_args_list,
+                         expected)
+        expected = [call(pickle.dumps(event1))]
+        self.assertEqual(self._test_ui2.event.sendpickle.call_args_list,
+                         expected)
+
+    def test_ui_handler_log_filter(self):
+        """ Test log filters for UI handlers """
+        mask = ["*"]
+        debug_domains = {'BitBake.Foo': logging.WARNING}
+
+        self._test_ui1.event = EventQueueStub()
+        result = bb.event.register_UIHhandler(self._test_ui1, mainui=True)
+        bb.event.set_UIHmask(result, logging.ERROR, debug_domains, mask)
+        self._test_ui2.event = PickleEventQueueStub()
+        result = bb.event.register_UIHhandler(self._test_ui2, mainui=True)
+        bb.event.set_UIHmask(result, logging.ERROR, debug_domains, mask)
+
+        event1 = bb.event.OperationStarted()
+        bb.event.fire_ui_handlers(event1, None)   # All events match
+
+        event_log_handler = bb.event.LogHandler()
+        logger = logging.getLogger("BitBake")
+        logger.addHandler(event_log_handler)
+        logger1 = logging.getLogger("BitBake.Foo")
+        logger1.warning("Test warning LogRecord1") # Matches debug_domains level
+        logger1.info("Test info LogRecord")        # Filtered out
+        logger2 = logging.getLogger("BitBake.Bar")
+        logger2.error("Test error LogRecord")      # Matches filter base level
+        logger2.warning("Test warning LogRecord2") # Filtered out
+        logger.removeHandler(event_log_handler)
+
+        expected = ['OperationStarted',
+                    'WARNING: Test warning LogRecord1',
+                    'ERROR: Test error LogRecord']
+        self.assertEqual(self._test_ui1.event.event_calls, expected)
+        self.assertEqual(self._test_ui2.event.event_calls, expected)
+
     def test_fire(self):
         """ Test fire method used to trigger class and ui event handlers """
         mask = ["bb.event.ConfigParsed"]
@@ -295,12 +394,14 @@ class EventHandlingTest(unittest.TestCase):
         event2 = bb.event.OperationCompleted(total=123)
         bb.event.fire(event1, None)
         bb.event.fire(event2, None)
+        event_log_handler = bb.event.LogHandler()
         logger = logging.getLogger("BitBake")
-        logger.addHandler(bb.event.LogHandler())
+        logger.addHandler(event_log_handler)
         logger.info("Test info LogRecord")
         logger.warning("Test warning LogRecord")
         with self.assertLogs("BitBake", level="INFO") as cm:
             bb.event.print_ui_queue()
+        logger.removeHandler(event_log_handler)
         self.assertEqual(cm.output,
                          ["INFO:BitBake:Test info LogRecord",
                           "WARNING:BitBake:Test warning LogRecord"])
@@ -364,6 +465,7 @@ class EventHandlingTest(unittest.TestCase):
         self.assertEqual(self._threadlock_test_calls,
                          ["w1_ui1", "w1_ui2", "w2_ui1", "w2_ui2"])
 
+
     def test_disable_threadlock(self):
         """ Test disable_threadlock method """
         self._set_threadlock_test_mockups()
-- 
2.7.4


