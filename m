Return-Path: <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id E2FB2785A6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Aug 2017 20:41:25 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	17 Aug 2017 13:41:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,389,1498546800"; d="scan'208";a="891183053"
Received: from jairdeje-mobl1.zpn.intel.com ([10.219.4.45])
	by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2017 13:41:27 -0700
From: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Aug 2017 15:40:54 -0500
Message-Id: <d69c3dca4642ab9bb86c3297a2a4c3e2ef93c3b2.1503000752.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1503000752.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
References: <cover.1503000752.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Subject: [selftest][PATCH V1 5/5] bitbake: tests: Add event classes test class
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
X-List-Received-Date: Thu, 17 Aug 2017 20:41:26 -0000

This change adds EventClassesTest class to bb/tests/event.py,
including 47 new test cases for the public interfaces of the
bitbake event and related helper classes.

[YOCTO #10773]

Signed-off-by: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
---
 lib/bb/tests/event.py | 510 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 510 insertions(+)

diff --git a/lib/bb/tests/event.py b/lib/bb/tests/event.py
index 036fd7e..2a08f4e 100644
--- a/lib/bb/tests/event.py
+++ b/lib/bb/tests/event.py
@@ -485,3 +485,513 @@ class EventHandlingTest(unittest.TestCase):
         # processed before finishing handling the first worker event.
         self.assertEqual(self._threadlock_test_calls,
                          ["w1_ui1", "w2_ui1", "w1_ui2", "w2_ui2"])
+
+
+class EventClassesTest(unittest.TestCase):
+    """ Event classes test class """
+
+    _worker_pid = 54321
+
+    def setUp(self):
+        bb.event.worker_pid = EventClassesTest._worker_pid
+
+    def test_Event(self):
+        """ Test the Event base class """
+        event = bb.event.Event()
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_HeartbeatEvent(self):
+        """ Test the HeartbeatEvent class """
+        time = 10
+        event = bb.event.HeartbeatEvent(time)
+        self.assertEqual(event.time, time)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_OperationStarted(self):
+        """ Test OperationStarted event class """
+        msg = "Foo Bar"
+        event = bb.event.OperationStarted(msg)
+        self.assertEqual(event.msg, msg)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_OperationCompleted(self):
+        """ Test OperationCompleted event class """
+        msg = "Foo Bar"
+        total = 123
+        event = bb.event.OperationCompleted(total, msg)
+        self.assertEqual(event.msg, msg)
+        self.assertEqual(event.total, total)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_OperationProgress(self):
+        """ Test OperationProgress event class """
+        msg = "Foo Bar"
+        total = 123
+        current = 111
+        event = bb.event.OperationProgress(current, total, msg)
+        self.assertEqual(event.msg, msg + ": %s/%s" % (current, total))
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_ConfigParsed(self):
+        """ Test the ConfigParsed class """
+        event = bb.event.ConfigParsed()
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_MultiConfigParsed(self):
+        """ Test MultiConfigParsed event class """
+        mcdata = {"foobar": "Foo Bar"}
+        event = bb.event.MultiConfigParsed(mcdata)
+        self.assertEqual(event.mcdata, mcdata)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_RecipeEvent(self):
+        """ Test RecipeEvent event base class """
+        callback = lambda a: 2 * a
+        event = bb.event.RecipeEvent(callback)
+        self.assertEqual(event.fn(1), callback(1))
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_RecipePreFinalise(self):
+        """ Test RecipePreFinalise event class """
+        callback = lambda a: 2 * a
+        event = bb.event.RecipePreFinalise(callback)
+        self.assertEqual(event.fn(1), callback(1))
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_RecipeTaskPreProcess(self):
+        """ Test RecipeTaskPreProcess event class """
+        callback = lambda a: 2 * a
+        tasklist = [("foobar", callback)]
+        event = bb.event.RecipeTaskPreProcess(callback, tasklist)
+        self.assertEqual(event.fn(1), callback(1))
+        self.assertEqual(event.tasklist, tasklist)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_RecipeParsed(self):
+        """ Test RecipeParsed event base class """
+        callback = lambda a: 2 * a
+        event = bb.event.RecipeParsed(callback)
+        self.assertEqual(event.fn(1), callback(1))
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_StampUpdate(self):
+        targets = ["foo", "bar"]
+        stampfns = [lambda:"foobar"]
+        event = bb.event.StampUpdate(targets, stampfns)
+        self.assertEqual(event.targets, targets)
+        self.assertEqual(event.stampPrefix, stampfns)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_BuildBase(self):
+        """ Test base class for bitbake build events """
+        name = "foo"
+        pkgs = ["bar"]
+        failures = 123
+        event = bb.event.BuildBase(name, pkgs, failures)
+        self.assertEqual(event.name, name)
+        self.assertEqual(event.pkgs, pkgs)
+        self.assertEqual(event.cfg, None)
+        self.assertEqual(event.getFailures(), failures)
+        name = event.name = "bar"
+        pkgs = event.pkgs = ["foo"]
+        cfg = event.cfg = {"foo":"bar"}
+        self.assertEqual(event.name, name)
+        self.assertEqual(event.pkgs, pkgs)
+        self.assertEqual(event.cfg, cfg)
+        self.assertEqual(event.getFailures(), failures)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_BuildInit(self):
+        """ Test class for bitbake build invocation events """
+        event = bb.event.BuildInit()
+        self.assertEqual(event.name, None)
+        self.assertEqual(event.pkgs, [])
+        self.assertEqual(event.cfg, None)
+        self.assertEqual(event.getFailures(), 0)
+        name = event.name = "bar"
+        pkgs = event.pkgs = ["foo"]
+        cfg = event.cfg = {"foo":"bar"}
+        self.assertEqual(event.name, name)
+        self.assertEqual(event.pkgs, pkgs)
+        self.assertEqual(event.cfg, cfg)
+        self.assertEqual(event.getFailures(), 0)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_BuildStarted(self):
+        """ Test class for build started events """
+        name = "foo"
+        pkgs = ["bar"]
+        failures = 123
+        event = bb.event.BuildStarted(name, pkgs, failures)
+        self.assertEqual(event.name, name)
+        self.assertEqual(event.pkgs, pkgs)
+        self.assertEqual(event.cfg, None)
+        self.assertEqual(event.getFailures(), failures)
+        self.assertEqual(event.msg, "Building Started")
+        name = event.name = "bar"
+        pkgs = event.pkgs = ["foo"]
+        cfg = event.cfg = {"foo":"bar"}
+        msg = event.msg = "foobar"
+        self.assertEqual(event.name, name)
+        self.assertEqual(event.pkgs, pkgs)
+        self.assertEqual(event.cfg, cfg)
+        self.assertEqual(event.getFailures(), failures)
+        self.assertEqual(event.msg, msg)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_BuildCompleted(self):
+        """ Test class for build completed events """
+        total = 1000
+        name = "foo"
+        pkgs = ["bar"]
+        failures = 123
+        interrupted = 1
+        event = bb.event.BuildCompleted(total, name, pkgs, failures,
+                                        interrupted)
+        self.assertEqual(event.name, name)
+        self.assertEqual(event.pkgs, pkgs)
+        self.assertEqual(event.cfg, None)
+        self.assertEqual(event.getFailures(), failures)
+        self.assertEqual(event.msg, "Building Failed")
+        event2 = bb.event.BuildCompleted(total, name, pkgs)
+        self.assertEqual(event2.name, name)
+        self.assertEqual(event2.pkgs, pkgs)
+        self.assertEqual(event2.cfg, None)
+        self.assertEqual(event2.getFailures(), 0)
+        self.assertEqual(event2.msg, "Building Succeeded")
+        self.assertEqual(event2.pid, EventClassesTest._worker_pid)
+
+    def test_DiskFull(self):
+        """ Test DiskFull event class """
+        dev = "/dev/foo"
+        type = "ext4"
+        freespace = "104M"
+        mountpoint = "/"
+        event = bb.event.DiskFull(dev, type, freespace, mountpoint)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_MonitorDiskEvent(self):
+        """ Test MonitorDiskEvent class """
+        available_bytes = 10000000
+        free_bytes = 90000000
+        total_bytes = 1000000000
+        du = bb.event.DiskUsageSample(available_bytes, free_bytes,
+                                      total_bytes)
+        event = bb.event.MonitorDiskEvent(du)
+        self.assertEqual(event.disk_usage.available_bytes, available_bytes)
+        self.assertEqual(event.disk_usage.free_bytes, free_bytes)
+        self.assertEqual(event.disk_usage.total_bytes, total_bytes)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_NoProvider(self):
+        """ Test NoProvider event class """
+        item = "foobar"
+        event1 = bb.event.NoProvider(item)
+        self.assertEqual(event1.getItem(), item)
+        self.assertEqual(event1.isRuntime(), False)
+        self.assertEqual(str(event1), "Nothing PROVIDES 'foobar'")
+        runtime = True
+        dependees = ["foo", "bar"]
+        reasons = None
+        close_matches = ["foibar", "footbar"]
+        event2 = bb.event.NoProvider(item, runtime, dependees, reasons,
+                                     close_matches)
+        self.assertEqual(event2.isRuntime(), True)
+        expected = ("Nothing RPROVIDES 'foobar' (but foo, bar RDEPENDS"
+                    " on or otherwise requires it). Close matches:\n"
+                    "  foibar\n"
+                    "  footbar")
+        self.assertEqual(str(event2), expected)
+        reasons = ["Item does not exist on database"]
+        close_matches = ["foibar", "footbar"]
+        event3 = bb.event.NoProvider(item, runtime, dependees, reasons,
+                                     close_matches)
+        expected = ("Nothing RPROVIDES 'foobar' (but foo, bar RDEPENDS"
+                    " on or otherwise requires it)\n"
+                    "Item does not exist on database")
+        self.assertEqual(str(event3), expected)
+        self.assertEqual(event3.pid, EventClassesTest._worker_pid)
+
+    def test_MultipleProviders(self):
+        """ Test MultipleProviders event class """
+        item = "foobar"
+        candidates = ["foobarv1", "foobars"]
+        event1 = bb.event.MultipleProviders(item, candidates)
+        self.assertEqual(event1.isRuntime(), False)
+        self.assertEqual(event1.getItem(), item)
+        self.assertEqual(event1.getCandidates(), candidates)
+        expected = ("Multiple providers are available for foobar (foobarv1,"
+                    " foobars)\n"
+                    "Consider defining a PREFERRED_PROVIDER entry to match "
+                    "foobar")
+        self.assertEqual(str(event1), expected)
+        runtime = True
+        event2 = bb.event.MultipleProviders(item, candidates, runtime)
+        self.assertEqual(event2.isRuntime(), runtime)
+        expected = ("Multiple providers are available for runtime foobar "
+                    "(foobarv1, foobars)\n"
+                    "Consider defining a PREFERRED_RPROVIDER entry to match "
+                    "foobar")
+        self.assertEqual(str(event2), expected)
+        self.assertEqual(event2.pid, EventClassesTest._worker_pid)
+
+    def test_ParseStarted(self):
+        """ Test ParseStarted event class """
+        total = 123
+        event = bb.event.ParseStarted(total)
+        self.assertEqual(event.msg, "Recipe parsing Started")
+        self.assertEqual(event.total, total)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_ParseCompleted(self):
+        """ Test ParseCompleted event class """
+        cached = 10
+        parsed = 13
+        skipped = 7
+        virtuals = 2
+        masked = 1
+        errors = 0
+        total = 23
+        event = bb.event.ParseCompleted(cached, parsed, skipped, masked,
+                                        virtuals, errors, total)
+        self.assertEqual(event.msg, "Recipe parsing Completed")
+        expected = [cached, parsed, skipped, virtuals, masked, errors,
+                    cached + parsed, total]
+        actual = [event.cached, event.parsed, event.skipped, event.virtuals,
+                  event.masked, event.errors, event.sofar, event.total]
+        self.assertEqual(str(actual), str(expected))
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_ParseProgress(self):
+        """ Test ParseProgress event class """
+        current = 10
+        total = 100
+        event = bb.event.ParseProgress(current, total)
+        self.assertEqual(event.msg,
+                         "Recipe parsing" + ": %s/%s" % (current, total))
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_CacheLoadStarted(self):
+        """ Test CacheLoadStarted event class """
+        total = 123
+        event = bb.event.CacheLoadStarted(total)
+        self.assertEqual(event.msg, "Loading cache Started")
+        self.assertEqual(event.total, total)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_CacheLoadProgress(self):
+        """ Test CacheLoadProgress event class """
+        current = 10
+        total = 100
+        event = bb.event.CacheLoadProgress(current, total)
+        self.assertEqual(event.msg,
+                         "Loading cache" + ": %s/%s" % (current, total))
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_CacheLoadCompleted(self):
+        """ Test CacheLoadCompleted event class """
+        total = 23
+        num_entries = 12
+        event = bb.event.CacheLoadCompleted(total, num_entries)
+        self.assertEqual(event.msg, "Loading cache Completed")
+        expected = [total, num_entries]
+        actual = [event.total, event.num_entries]
+        self.assertEqual(str(actual), str(expected))
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_TreeDataPreparationStarted(self):
+        """ Test TreeDataPreparationStarted event class """
+        event = bb.event.TreeDataPreparationStarted()
+        self.assertEqual(event.msg, "Preparing tree data Started")
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_TreeDataPreparationProgress(self):
+        """ Test TreeDataPreparationProgress event class """
+        current = 10
+        total = 100
+        event = bb.event.TreeDataPreparationProgress(current, total)
+        self.assertEqual(event.msg,
+                         "Preparing tree data" + ": %s/%s" % (current, total))
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_TreeDataPreparationCompleted(self):
+        """ Test TreeDataPreparationCompleted event class """
+        total = 23
+        event = bb.event.TreeDataPreparationCompleted(total)
+        self.assertEqual(event.msg, "Preparing tree data Completed")
+        self.assertEqual(event.total, total)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_DepTreeGenerated(self):
+        """ Test DepTreeGenerated event class """
+        depgraph = Mock()
+        event = bb.event.DepTreeGenerated(depgraph)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_TargetsTreeGenerated(self):
+        """ Test TargetsTreeGenerated event class """
+        model = Mock()
+        event = bb.event.TargetsTreeGenerated(model)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_ReachableStamps(self):
+        """ Test ReachableStamps event class """
+        stamps = [Mock(), Mock()]
+        event = bb.event.ReachableStamps(stamps)
+        self.assertEqual(event.stamps, stamps)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_FilesMatchingFound(self):
+        """ Test FilesMatchingFound event class """
+        pattern = "foo.*bar"
+        matches = ["foobar"]
+        event = bb.event.FilesMatchingFound(pattern, matches)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_ConfigFilesFound(self):
+        """ Test ConfigFilesFound event class """
+        variable = "FOO_BAR"
+        values = ["foo", "bar"]
+        event = bb.event.ConfigFilesFound(variable, values)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_ConfigFilePathFound(self):
+        """ Test ConfigFilePathFound event class """
+        path = "/foo/bar"
+        event = bb.event.ConfigFilePathFound(path)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_message_classes(self):
+        """ Test message event classes """
+        msg = "foobar foo bar"
+        event = bb.event.MsgBase(msg)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+        event = bb.event.MsgDebug(msg)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+        event = bb.event.MsgNote(msg)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+        event = bb.event.MsgWarn(msg)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+        event = bb.event.MsgError(msg)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+        event = bb.event.MsgFatal(msg)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+        event = bb.event.MsgPlain(msg)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_LogExecTTY(self):
+        """ Test LogExecTTY event class """
+        msg = "foo bar"
+        prog = "foo.sh"
+        sleep_delay = 10
+        retries = 3
+        event = bb.event.LogExecTTY(msg, prog, sleep_delay, retries)
+        self.assertEqual(event.msg, msg)
+        self.assertEqual(event.prog, prog)
+        self.assertEqual(event.sleep_delay, sleep_delay)
+        self.assertEqual(event.retries, retries)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def _throw_zero_division_exception(self):
+        a = 1 / 0
+        return
+
+    def _worker_handler(self, event, d):
+        self._returned_event = event
+        return
+
+    def test_LogHandler(self):
+        """ Test LogHandler class """
+        logger = logging.getLogger("TestEventClasses")
+        logger.propagate = False
+        handler = bb.event.LogHandler(logging.INFO)
+        logger.addHandler(handler)
+        bb.event.worker_fire = self._worker_handler
+        try:
+            self._throw_zero_division_exception()
+        except ZeroDivisionError as ex:
+            logger.exception(ex)
+        event = self._returned_event
+        try:
+            pe = pickle.dumps(event)
+            newevent = pickle.loads(pe)
+        except:
+            self.fail('Logged event is not serializable')
+        self.assertEqual(event.taskpid, EventClassesTest._worker_pid)
+
+    def test_MetadataEvent(self):
+        """ Test MetadataEvent class """
+        eventtype = "footype"
+        eventdata = {"foo": "bar"}
+        event = bb.event.MetadataEvent(eventtype, eventdata)
+        self.assertEqual(event.type, eventtype)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_ProcessStarted(self):
+        """ Test ProcessStarted class """
+        processname = "foo"
+        total = 9783128974
+        event = bb.event.ProcessStarted(processname, total)
+        self.assertEqual(event.processname, processname)
+        self.assertEqual(event.total, total)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_ProcessProgress(self):
+        """ Test ProcessProgress class """
+        processname = "foo"
+        progress = 243224
+        event = bb.event.ProcessProgress(processname, progress)
+        self.assertEqual(event.processname, processname)
+        self.assertEqual(event.progress, progress)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_ProcessFinished(self):
+        """ Test ProcessFinished class """
+        processname = "foo"
+        total = 1242342344
+        event = bb.event.ProcessFinished(processname)
+        self.assertEqual(event.processname, processname)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_SanityCheck(self):
+        """ Test SanityCheck class """
+        event1 = bb.event.SanityCheck()
+        self.assertEqual(event1.generateevents, True)
+        self.assertEqual(event1.pid, EventClassesTest._worker_pid)
+        generateevents = False
+        event2 = bb.event.SanityCheck(generateevents)
+        self.assertEqual(event2.generateevents, generateevents)
+        self.assertEqual(event2.pid, EventClassesTest._worker_pid)
+
+    def test_SanityCheckPassed(self):
+        """ Test SanityCheckPassed class """
+        event = bb.event.SanityCheckPassed()
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_SanityCheckFailed(self):
+        """ Test SanityCheckFailed class """
+        msg = "The sanity test failed."
+        event1 = bb.event.SanityCheckFailed(msg)
+        self.assertEqual(event1.pid, EventClassesTest._worker_pid)
+        network_error = True
+        event2 = bb.event.SanityCheckFailed(msg, network_error)
+        self.assertEqual(event2.pid, EventClassesTest._worker_pid)
+
+    def test_network_event_classes(self):
+        """ Test network event classes """
+        event1 = bb.event.NetworkTest()
+        generateevents = False
+        self.assertEqual(event1.pid, EventClassesTest._worker_pid)
+        event2 = bb.event.NetworkTest(generateevents)
+        self.assertEqual(event2.pid, EventClassesTest._worker_pid)
+        event3 = bb.event.NetworkTestPassed()
+        self.assertEqual(event3.pid, EventClassesTest._worker_pid)
+        event4 = bb.event.NetworkTestFailed()
+        self.assertEqual(event4.pid, EventClassesTest._worker_pid)
+
+    def test_FindSigInfoResult(self):
+        """ Test FindSigInfoResult event class """
+        result = [Mock()]
+        event = bb.event.FindSigInfoResult(result)
+        self.assertEqual(event.result, result)
+        self.assertEqual(event.pid, EventClassesTest._worker_pid)
-- 
2.7.4


