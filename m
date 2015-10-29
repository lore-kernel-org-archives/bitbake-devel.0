Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 822BC77087
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Oct 2015 12:00:10 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga102.fm.intel.com with ESMTP; 29 Oct 2015 04:59:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,214,1444719600"; d="scan'208";a="806435609"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 29 Oct 2015 04:59:55 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 0201F6A4005;
	Thu, 29 Oct 2015 04:58:52 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Oct 2015 13:59:44 +0200
Message-Id: <1446119984-9222-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] toasterui: Create per-build logs
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
X-List-Received-Date: Thu, 29 Oct 2015 12:00:11 -0000

From: Elliot Smith <elliot.smith@intel.com>

Rather than relying on bug 8411, which is conveniently creating
separate log files for each of our builds, create our own
log file for each build.

The log files are created in the same tmp directories that
bitbake users, but are timestamped to the millisecond to avoid
name collisions.

Each log file is opened on a ParseStarted event (for builds
triggered by Toaster) or BuildStarted event (for builds on the
command line: Toaster doesn't get the ParseStarted event
for command-line builds).

The log file is closed on the BuildCompleted event, or if the
build fails.

Because we start logging on ParseStarted for Toaster builds,
we're able to capture the "Build Configuration" section which
bitbake writes to output.

[YOCTO #8373]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py |   8 +--
 bitbake/lib/bb/ui/toasterui.py       | 116 +++++++++++++++++++++++++++--------
 2 files changed, 94 insertions(+), 30 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 2fc1a43..78f1e92 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -784,7 +784,7 @@ class BuildInfoHelper(object):
     ## methods to convert event/external info into objects that the ORM layer uses
 
 
-    def _get_build_information(self, consolelogfile):
+    def _get_build_information(self, build_log_path):
         build_info = {}
         # Generate an identifier for each new build
 
@@ -793,7 +793,7 @@ class BuildInfoHelper(object):
         build_info['distro_version'] = self.server.runCommand(["getVariable", "DISTRO_VERSION"])[0]
         build_info['started_on'] = timezone.now()
         build_info['completed_on'] = timezone.now()
-        build_info['cooker_log_path'] = consolelogfile
+        build_info['cooker_log_path'] = build_log_path
         build_info['build_name'] = self.server.runCommand(["getVariable", "BUILDNAME"])[0]
         build_info['bitbake_version'] = self.server.runCommand(["getVariable", "BB_VERSION"])[0]
 
@@ -934,9 +934,9 @@ class BuildInfoHelper(object):
                 logger.warn("buildinfohelper: cannot identify layer exception:%s ", nee)
 
 
-    def store_started_build(self, event, consolelogfile):
+    def store_started_build(self, event, build_log_path):
         assert '_pkgs' in vars(event)
-        build_information = self._get_build_information(consolelogfile)
+        build_information = self._get_build_information(build_log_path)
 
         build_obj = self.orm_wrapper.create_build_object(build_information, self.brbe, self.project)
 
diff --git a/bitbake/lib/bb/ui/toasterui.py b/bitbake/lib/bb/ui/toasterui.py
index 2b3bc3f..3d26150 100644
--- a/bitbake/lib/bb/ui/toasterui.py
+++ b/bitbake/lib/bb/ui/toasterui.py
@@ -21,6 +21,7 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from __future__ import division
+import time
 import sys
 try:
     import bb
@@ -43,8 +44,6 @@ featureSet = [bb.cooker.CookerFeatures.HOB_EXTRA_CACHES, bb.cooker.CookerFeature
 logger = logging.getLogger("ToasterLogger")
 interactive = sys.stdout.isatty()
 
-
-
 def _log_settings_from_server(server):
     # Get values of variables which control our output
     includelogs, error = server.runCommand(["getVariable", "BBINCLUDELOGS"])
@@ -55,16 +54,60 @@ def _log_settings_from_server(server):
     if error:
         logger.error("Unable to get the value of BBINCLUDELOGS_LINES variable: %s", error)
         raise BaseException(error)
-    consolelogfile, error = server.runCommand(["getSetVariable", "BB_CONSOLELOG"])
+    consolelogfile, error = server.runCommand(["getVariable", "BB_CONSOLELOG"])
     if error:
         logger.error("Unable to get the value of BB_CONSOLELOG variable: %s", error)
         raise BaseException(error)
-    return includelogs, loglines, consolelogfile
+    return consolelogfile
+
+# create a log file for a single build and direct the logger at it;
+# log file name is timestamped to the millisecond (depending
+# on system clock accuracy) to ensure it doesn't overlap with
+# other log file names
+#
+# returns (log file, path to log file) for a build
+def _open_build_log(log_dir):
+    format_str = "%(levelname)s: %(message)s"
+
+    now = time.time()
+    now_ms = int((now - int(now)) * 1000)
+    time_str = time.strftime('build_%Y%m%d_%H%M%S', time.localtime(now))
+    log_file_name = time_str + ('.%d.log' % now_ms)
+    build_log_file_path = os.path.join(log_dir, log_file_name)
+
+    build_log = logging.FileHandler(build_log_file_path)
+
+    logformat = bb.msg.BBLogFormatter(format_str)
+    build_log.setFormatter(logformat)
 
+    bb.msg.addDefaultlogFilter(build_log)
+    logger.addHandler(build_log)
+
+    return (build_log, build_log_file_path)
+
+# stop logging to the build log if it exists
+def _close_build_log(build_log):
+    if build_log:
+        build_log.flush()
+        build_log.close()
+        logger.removeHandler(build_log)
+
+def main(server, eventHandler, params):
+    # set to a logging.FileHandler instance when a build starts;
+    # see _open_build_log()
+    build_log = None
+
+    # set to the log path when a build starts
+    build_log_file_path = None
 
-def main(server, eventHandler, params ):
     helper = uihelper.BBUIHelper()
 
+    # TODO don't use log output to determine when bitbake has started
+    #
+    # WARNING: this log handler cannot be removed, as localhostbecontroller
+    # relies on output in the toaster_ui.log file to determine whether
+    # the bitbake server has started, which only happens if
+    # this logger is setup here (see the TODO in the loop below)
     console = logging.StreamHandler(sys.stdout)
     format_str = "%(levelname)s: %(message)s"
     formatter = bb.msg.BBLogFormatter(format_str)
@@ -73,8 +116,6 @@ def main(server, eventHandler, params ):
     logger.addHandler(console)
     logger.setLevel(logging.INFO)
 
-    _, _, consolelogfile = _log_settings_from_server(server)
-
     # verify and warn
     build_history_enabled = True
     inheritlist, _ = server.runCommand(["getVariable", "INHERIT"])
@@ -87,8 +128,9 @@ def main(server, eventHandler, params ):
         logger.error("ToasterUI can only work in observer mode")
         return 1
 
-
+    # set to 1 when toasterui needs to shut down
     main.shutdown = 0
+
     interrupted = False
     return_value = 0
     errors = 0
@@ -98,25 +140,31 @@ def main(server, eventHandler, params ):
 
     buildinfohelper = BuildInfoHelper(server, build_history_enabled)
 
-    if buildinfohelper.brbe is not None and consolelogfile:
-        # if we are under managed mode we have no other UI and we need to write our own file
-        bb.utils.mkdirhier(os.path.dirname(consolelogfile))
-        conlogformat = bb.msg.BBLogFormatter(format_str)
-        consolelog = logging.FileHandler(consolelogfile)
-        bb.msg.addDefaultlogFilter(consolelog)
-        consolelog.setFormatter(conlogformat)
-        logger.addHandler(consolelog)
-
+    # write our own log files into bitbake's log directory;
+    # we're only interested in the path to the parent directory of
+    # this file, as we're writing our own logs into the same directory
+    consolelogfile = _log_settings_from_server(server)
+    log_dir = os.path.dirname(consolelogfile)
+    bb.utils.mkdirhier(log_dir)
 
     while True:
         try:
             event = eventHandler.waitEvent(0.25)
             if first:
                 first = False
+
+                # TODO don't use log output to determine when bitbake has started
+                #
+                # this is the line localhostbecontroller needs to
+                # see in toaster_ui.log which it uses to decide whether
+                # the bitbake server has started...
                 logger.info("ToasterUI waiting for events")
 
             if event is None:
                 if main.shutdown > 0:
+                    # if shutting down, close any open build log first
+                    _close_build_log(build_log)
+
                     break
                 continue
 
@@ -125,8 +173,21 @@ def main(server, eventHandler, params ):
             # pylint: disable=protected-access
             # the code will look into the protected variables of the event; no easy way around this
 
+            # we treat ParseStarted as the first event of toaster-triggered
+            # builds; that way we get the Build Configuration included in the log
+            # and any errors that occur before BuildStarted is fired
+            if isinstance(event, bb.event.ParseStarted):
+                if not (build_log and build_log_file_path):
+                    build_log, build_log_file_path = _open_build_log(log_dir)
+                continue
+
             if isinstance(event, bb.event.BuildStarted):
-                buildinfohelper.store_started_build(event, consolelogfile)
+                # command-line builds don't fire a ParseStarted event,
+                # so we have to start the log file for those on BuildStarted instead
+                if not (build_log and build_log_file_path):
+                    build_log, build_log_file_path = _open_build_log(log_dir)
+
+                buildinfohelper.store_started_build(event, build_log_file_path)
 
             if isinstance(event, (bb.build.TaskStarted, bb.build.TaskSucceeded, bb.build.TaskFailedSilent)):
                 buildinfohelper.update_and_store_task(event)
@@ -171,8 +232,6 @@ def main(server, eventHandler, params ):
             # timing and error informations from the parsing phase in Toaster
             if isinstance(event, (bb.event.SanityCheckPassed, bb.event.SanityCheck)):
                 continue
-            if isinstance(event, bb.event.ParseStarted):
-                continue
             if isinstance(event, bb.event.ParseProgress):
                 continue
             if isinstance(event, bb.event.ParseCompleted):
@@ -248,6 +307,12 @@ def main(server, eventHandler, params ):
                     errorcode = 1
                     logger.error("Command execution failed: %s", event.error)
 
+                # turn off logging to the current build log
+                _close_build_log(build_log)
+
+                # reset ready for next BuildStarted
+                build_log = None
+
                 # update the build info helper on BuildCompleted, not on CommandXXX
                 buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
                 buildinfohelper.close(errorcode)
@@ -256,7 +321,6 @@ def main(server, eventHandler, params ):
 
                 # we start a new build info
                 if buildinfohelper.brbe is not None:
-
                     logger.debug("ToasterUI under BuildEnvironment management - exiting after the build")
                     server.terminateServer()
                 else:
@@ -298,8 +362,9 @@ def main(server, eventHandler, params ):
                 continue
 
             if isinstance(event, bb.cooker.CookerExit):
-                # exit when the server exits
-                break
+                # shutdown when bitbake server shuts down
+                main.shutdown = 1
+                continue
 
             # ignore
             if isinstance(event, (bb.event.BuildBase,
@@ -350,9 +415,8 @@ def main(server, eventHandler, params ):
             # make sure we return with an error
             return_value += 1
 
-    if interrupted:
-        if return_value == 0:
-            return_value += 1
+    if interrupted and return_value == 0:
+        return_value += 1
 
     logger.warn("Return value is %d", return_value)
     return return_value
-- 
2.1.4


