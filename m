Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 125697822C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jul 2017 09:56:45 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Jul 2017 02:56:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,380,1496127600"; d="scan'208";a="880410414"
Received: from gsena-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.48.213])
	by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2017 02:56:46 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Jul 2017 11:56:03 +0200
Message-Id: <2dd320475df132a247f6de95263f4ddaf1947f6d.1500458081.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1500458081.git.paul.eggleton@linux.intel.com>
References: <cover.1500458081.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 04/12] lib/bb/event: refactor printing events
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
X-List-Received-Date: Wed, 19 Jul 2017 09:56:45 -0000

We really ought to have just one place where the string representation
of these events is produced. This doesn't take any real control away
from the UI - if an alternative representation is desired, that can
still be made.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/command.py      |  2 ++
 lib/bb/event.py        | 32 ++++++++++++++++++++++++++++++++
 lib/bb/runqueue.py     |  6 ++++++
 lib/bb/ui/knotty.py    | 37 ++++++-------------------------------
 lib/bb/ui/ncurses.py   |  2 +-
 lib/bb/ui/taskexp.py   | 20 ++------------------
 lib/bb/ui/toasterui.py | 25 ++++---------------------
 7 files changed, 53 insertions(+), 71 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 2c8223e..01a2c61 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -50,6 +50,8 @@ class CommandFailed(CommandExit):
     def __init__(self, message):
         self.error = message
         CommandExit.__init__(self, 1)
+    def __str__(self):
+        return "Command execution failed: %s" % self.error
 
 class CommandError(Exception):
     pass
diff --git a/lib/bb/event.py b/lib/bb/event.py
index d5c5ef3..b2d0d1a 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -516,6 +516,28 @@ class NoProvider(Event):
     def isRuntime(self):
         return self._runtime
 
+    def __str__(self):
+        msg = ''
+        if self._runtime:
+            r = "R"
+        else:
+            r = ""
+
+        extra = ''
+        if not self._reasons:
+            if self._close_matches:
+                extra = ". Close matches:\n  %s" % '\n  '.join(self._close_matches)
+
+        if self._dependees:
+            msg = "Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)%s" % (r, self._item, ", ".join(self._dependees), r, extra)
+        else:
+            msg = "Nothing %sPROVIDES '%s'%s" % (r, self._item, extra)
+        if self._reasons:
+            for reason in self._reasons:
+                msg += '\n' + reason
+        return msg
+
+
 class MultipleProviders(Event):
     """Multiple Providers"""
 
@@ -543,6 +565,16 @@ class MultipleProviders(Event):
         """
         return self._candidates
 
+    def __str__(self):
+        msg = "Multiple providers are available for %s%s (%s)" % (self._is_runtime and "runtime " or "",
+                            self._item,
+                            ", ".join(self._candidates))
+        rtime = ""
+        if self._is_runtime:
+            rtime = "R"
+        msg += "\nConsider defining a PREFERRED_%sPROVIDER entry to match %s" % (rtime, self._item)
+        return msg
+
 class ParseStarted(OperationStarted):
     """Recipe parsing for the runqueue has begun"""
     def __init__(self, total):
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 21520d3..7dd964d 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2488,6 +2488,9 @@ class runQueueTaskFailed(runQueueEvent):
         runQueueEvent.__init__(self, task, stats, rq)
         self.exitcode = exitcode
 
+    def __str__(self):
+        return "Task (%s) failed with exit code '%s'" % (self.taskstring, self.exitcode)
+
 class sceneQueueTaskFailed(sceneQueueEvent):
     """
     Event notifying a setscene task failed
@@ -2496,6 +2499,9 @@ class sceneQueueTaskFailed(sceneQueueEvent):
         sceneQueueEvent.__init__(self, task, stats, rq)
         self.exitcode = exitcode
 
+    def __str__(self):
+        return "Setscene task (%s) failed with exit code '%s' - real task will be run instead" % (self.taskstring, self.exitcode)
+
 class sceneQueueComplete(sceneQueueEvent):
     """
     Event when all the sceneQueue tasks are complete
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 1aa5ebb..c301982 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -560,7 +560,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 return_value = event.exitcode
                 if event.error:
                     errors = errors + 1
-                    logger.error("Command execution failed: %s", event.error)
+                    logger.error(str(event))
                 main.shutdown = 2
                 continue
             if isinstance(event, bb.command.CommandExit):
@@ -571,39 +571,16 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 main.shutdown = 2
                 continue
             if isinstance(event, bb.event.MultipleProviders):
-                logger.info("multiple providers are available for %s%s (%s)", event._is_runtime and "runtime " or "",
-                            event._item,
-                            ", ".join(event._candidates))
-                rtime = ""
-                if event._is_runtime:
-                    rtime = "R"
-                logger.info("consider defining a PREFERRED_%sPROVIDER entry to match %s" % (rtime, event._item))
+                logger.info(str(event))
                 continue
             if isinstance(event, bb.event.NoProvider):
-                if event._runtime:
-                    r = "R"
-                else:
-                    r = ""
-
-                extra = ''
-                if not event._reasons:
-                    if event._close_matches:
-                        extra = ". Close matches:\n  %s" % '\n  '.join(event._close_matches)
-
                 # For universe builds, only show these as warnings, not errors
-                h = logger.warning
                 if not universe:
                     return_value = 1
                     errors = errors + 1
-                    h = logger.error
-
-                if event._dependees:
-                    h("Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)%s", r, event._item, ", ".join(event._dependees), r, extra)
+                    logger.error(str(event))
                 else:
-                    h("Nothing %sPROVIDES '%s'%s", r, event._item, extra)
-                if event._reasons:
-                    for reason in event._reasons:
-                        h("%s", reason)
+                    logger.warning(str(event))
                 continue
 
             if isinstance(event, bb.runqueue.sceneQueueTaskStarted):
@@ -625,13 +602,11 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             if isinstance(event, bb.runqueue.runQueueTaskFailed):
                 return_value = 1
                 taskfailures.append(event.taskstring)
-                logger.error("Task (%s) failed with exit code '%s'",
-                             event.taskstring, event.exitcode)
+                logger.error(str(event))
                 continue
 
             if isinstance(event, bb.runqueue.sceneQueueTaskFailed):
-                logger.warning("Setscene task (%s) failed with exit code '%s' - real task will be run instead",
-                               event.taskstring, event.exitcode)
+                logger.warning(str(event))
                 continue
 
             if isinstance(event, bb.event.DepTreeGenerated):
diff --git a/lib/bb/ui/ncurses.py b/lib/bb/ui/ncurses.py
index ca845a3..8690c52 100644
--- a/lib/bb/ui/ncurses.py
+++ b/lib/bb/ui/ncurses.py
@@ -315,7 +315,7 @@ class NCursesUI:
                     # also allow them to now exit with a single ^C
                     shutdown = 2
                 if isinstance(event, bb.command.CommandFailed):
-                    mw.appendText("Command execution failed: %s" % event.error)
+                    mw.appendText(str(event))
                     time.sleep(2)
                     exitflag = True
                 if isinstance(event, bb.command.CommandExit):
diff --git a/lib/bb/ui/taskexp.py b/lib/bb/ui/taskexp.py
index 9d14ece..0d0f9f5 100644
--- a/lib/bb/ui/taskexp.py
+++ b/lib/bb/ui/taskexp.py
@@ -286,23 +286,7 @@ def main(server, eventHandler, params):
                 continue
 
             if isinstance(event, bb.event.NoProvider):
-                if event._runtime:
-                    r = "R"
-                else:
-                    r = ""
-
-                extra = ''
-                if not event._reasons:
-                    if event._close_matches:
-                        extra = ". Close matches:\n  %s" % '\n  '.join(event._close_matches)
-
-                if event._dependees:
-                    print("Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)%s" % (r, event._item, ", ".join(event._dependees), r, extra))
-                else:
-                    print("Nothing %sPROVIDES '%s'%s" % (r, event._item, extra))
-                if event._reasons:
-                    for reason in event._reasons:
-                        print(reason)
+                print(str(event))
 
                 _, error = server.runCommand(["stateShutdown"])
                 if error:
@@ -310,7 +294,7 @@ def main(server, eventHandler, params):
                 break
 
             if isinstance(event, bb.command.CommandFailed):
-                print("Command execution failed: %s" % event.error)
+                print(str(event))
                 return event.exitcode
 
             if isinstance(event, bb.command.CommandExit):
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 71f04fa..88cec37 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -320,29 +320,13 @@ def main(server, eventHandler, params):
             if isinstance(event, bb.event.CacheLoadCompleted):
                 continue
             if isinstance(event, bb.event.MultipleProviders):
-                logger.info("multiple providers are available for %s%s (%s)", event._is_runtime and "runtime " or "",
-                            event._item,
-                            ", ".join(event._candidates))
-                logger.info("consider defining a PREFERRED_PROVIDER entry to match %s", event._item)
+                logger.info(str(event))
                 continue
 
             if isinstance(event, bb.event.NoProvider):
                 errors = errors + 1
-                if event._runtime:
-                    r = "R"
-                else:
-                    r = ""
-
-                if event._dependees:
-                    text = "Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)" % (r, event._item, ", ".join(event._dependees), r)
-                else:
-                    text = "Nothing %sPROVIDES '%s'" % (r, event._item)
-
+                text = str(event)
                 logger.error(text)
-                if event._reasons:
-                    for reason in event._reasons:
-                        logger.error("%s", reason)
-                        text += reason
                 buildinfohelper.store_log_error(text)
                 continue
 
@@ -364,8 +348,7 @@ def main(server, eventHandler, params):
             if isinstance(event, bb.runqueue.runQueueTaskFailed):
                 buildinfohelper.update_and_store_task(event)
                 taskfailures.append(event.taskstring)
-                logger.error("Task (%s) failed with exit code '%s'",
-                             event.taskstring, event.exitcode)
+                logger.error(str(event))
                 continue
 
             if isinstance(event, (bb.runqueue.sceneQueueTaskCompleted, bb.runqueue.sceneQueueTaskFailed)):
@@ -382,7 +365,7 @@ def main(server, eventHandler, params):
                 if isinstance(event, bb.command.CommandFailed):
                     errors += 1
                     errorcode = 1
-                    logger.error("Command execution failed: %s", event.error)
+                    logger.error(str(event))
                 elif isinstance(event, bb.event.BuildCompleted):
                     buildinfohelper.scan_image_artifacts()
                     buildinfohelper.clone_required_sdk_artifacts()
-- 
2.9.4


