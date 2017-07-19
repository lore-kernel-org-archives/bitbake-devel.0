Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 1E16B78202
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jul 2017 09:56:48 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Jul 2017 02:56:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,380,1496127600"; d="scan'208";a="880410423"
Received: from gsena-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.48.213])
	by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2017 02:56:49 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Jul 2017 11:56:06 +0200
Message-Id: <7d8d0c74468e0cddb17b600442d610baf869ef07.1500458081.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1500458081.git.paul.eggleton@linux.intel.com>
References: <cover.1500458081.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 07/12] tinfoil: add functionality for running full builds
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
X-List-Received-Date: Wed, 19 Jul 2017 09:56:48 -0000

Up to this point, if you wanted to run build tasks in the normal way
they get run from a python script, there was no other way than to shell
out to bitbake. Worse than that, you couldn't have tinfoil active during
that because only one bitbake instance could be running at once. As long
as we're prepared to handle the events produced, we can create a wrapper
around calling the buildTargets command. Borrow code from knotty to do
this in such a way that we get the expected running task display
(courtesy of TermFilter) and Ctrl+C handling.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tinfoil.py | 154 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index cba157c..580ce8d 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -2,6 +2,7 @@
 #
 # Copyright (C) 2012-2017 Intel Corporation
 # Copyright (C) 2011 Mentor Graphics Corporation
+# Copyright (C) 2006-2012 Richard Purdie
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
@@ -218,6 +219,7 @@ class Tinfoil:
         self.ui_module = None
         self.server_connection = None
         self.recipes_parsed = False
+        self.quiet = 0
         if setup_logging:
             # This is the *client-side* logger, nothing to do with
             # logging messages from the server
@@ -230,6 +232,8 @@ class Tinfoil:
         self.shutdown()
 
     def prepare(self, config_only=False, config_params=None, quiet=0, extra_features=None):
+        self.quiet = quiet
+
         if self.tracking:
             extrafeatures = [bb.cooker.CookerFeatures.BASEDATASTORE_TRACKING]
         else:
@@ -434,6 +438,156 @@ class Tinfoil:
         """
         return self.run_command('buildFile', buildfile, task, internal)
 
+    def build_targets(self, targets, task=None, handle_events=True, extra_events=None, event_callback=None):
+        """
+        Builds the specified targets. This is equivalent to a normal invocation
+        of bitbake. Has built-in event handling which is enabled by default and
+        can be extended if needed.
+        Parameters:
+            targets:
+                One or more targets to build. Can be a list or a
+                space-separated string.
+            task:
+                The task to run; if None then the value of BB_DEFAULT_TASK
+                will be used. Default None.
+            handle_events:
+                True to handle events in a similar way to normal bitbake
+                invocation with knotty; False to return immediately (on the
+                assumption that the caller will handle the events instead).
+                Default True.
+            extra_events:
+                An optional list of events to add to the event mask (if
+                handle_events=True). If you add events here you also need
+                to specify a callback function in event_callback that will
+                handle the additional events. Default None.
+            event_callback:
+                An optional function taking a single parameter which
+                will be called first upon receiving any event (if
+                handle_events=True) so that the caller can override or
+                extend the event handling. Default None.
+        """
+        if isinstance(targets, str):
+            targets = targets.split()
+        if not task:
+            task = self.config_data.getVar('BB_DEFAULT_TASK')
+
+        if handle_events:
+            # A reasonable set of default events matching up with those we handle below
+            eventmask = [
+                        'bb.event.BuildStarted',
+                        'bb.event.BuildCompleted',
+                        'logging.LogRecord',
+                        'bb.event.NoProvider',
+                        'bb.command.CommandCompleted',
+                        'bb.command.CommandFailed',
+                        'bb.build.TaskStarted',
+                        'bb.build.TaskFailed',
+                        'bb.build.TaskSucceeded',
+                        'bb.build.TaskFailedSilent',
+                        'bb.build.TaskProgress',
+                        'bb.runqueue.runQueueTaskStarted',
+                        'bb.runqueue.sceneQueueTaskStarted',
+                        'bb.event.ProcessStarted',
+                        'bb.event.ProcessProgress',
+                        'bb.event.ProcessFinished',
+                        ]
+            if extra_events:
+                eventmask.extend(extra_events)
+            ret = self.set_event_mask(eventmask)
+
+        ret = self.run_command('buildTargets', targets, task)
+        if handle_events:
+            result = False
+            # Borrowed from knotty, instead somewhat hackily we use the helper
+            # as the object to store "shutdown" on
+            helper = bb.ui.uihelper.BBUIHelper()
+            # We set up logging optionally in the constructor so now we need to
+            # grab the handlers to pass to TerminalFilter
+            console = None
+            errconsole = None
+            for handler in self.logger.handlers:
+                if isinstance(handler, logging.StreamHandler):
+                    if handler.stream == sys.stdout:
+                        console = handler
+                    elif handler.stream == sys.stderr:
+                        errconsole = handler
+            format_str = "%(levelname)s: %(message)s"
+            format = bb.msg.BBLogFormatter(format_str)
+            helper.shutdown = 0
+            parseprogress = None
+            termfilter = bb.ui.knotty.TerminalFilter(helper, helper, console, errconsole, format, quiet=self.quiet)
+            try:
+                while True:
+                    try:
+                        event = self.wait_event(0.25)
+                        if event:
+                            if event_callback and event_callback(event):
+                                continue
+                            if helper.eventHandler(event):
+                                continue
+                            if isinstance(event, bb.event.ProcessStarted):
+                                if self.quiet > 1:
+                                    continue
+                                parseprogress = bb.ui.knotty.new_progress(event.processname, event.total)
+                                parseprogress.start(False)
+                                continue
+                            if isinstance(event, bb.event.ProcessProgress):
+                                if self.quiet > 1:
+                                    continue
+                                if parseprogress:
+                                    parseprogress.update(event.progress)
+                                else:
+                                    bb.warn("Got ProcessProgress event for someting that never started?")
+                                continue
+                            if isinstance(event, bb.event.ProcessFinished):
+                                if self.quiet > 1:
+                                    continue
+                                if parseprogress:
+                                    parseprogress.finish()
+                                parseprogress = None
+                                continue
+                            if isinstance(event, bb.command.CommandCompleted):
+                                result = True
+                                break
+                            if isinstance(event, bb.command.CommandFailed):
+                                self.logger.error(str(event))
+                                result = False
+                                break
+                            if isinstance(event, logging.LogRecord):
+                                if event.taskpid == 0 or event.levelno > logging.INFO:
+                                    self.logger.handle(event)
+                                continue
+                            if isinstance(event, bb.event.NoProvider):
+                                self.logger.error(str(event))
+                                result = False
+                                break
+
+                        elif helper.shutdown > 1:
+                            break
+                        termfilter.updateFooter()
+                    except KeyboardInterrupt:
+                        termfilter.clearFooter()
+                        if helper.shutdown == 1:
+                            print("\nSecond Keyboard Interrupt, stopping...\n")
+                            ret = self.run_command("stateForceShutdown")
+                            if ret and ret[2]:
+                                self.logger.error("Unable to cleanly stop: %s" % ret[2])
+                        elif helper.shutdown == 0:
+                            print("\nKeyboard Interrupt, closing down...\n")
+                            interrupted = True
+                            ret = self.run_command("stateShutdown")
+                            if ret and ret[2]:
+                                self.logger.error("Unable to cleanly shutdown: %s" % ret[2])
+                        helper.shutdown = helper.shutdown + 1
+                termfilter.clearFooter()
+            finally:
+                termfilter.finish()
+            if helper.failed_tasks:
+                result = False
+            return result
+        else:
+            return ret
+
     def shutdown(self):
         if self.server_connection:
             self.run_command('clientComplete')
-- 
2.9.4


