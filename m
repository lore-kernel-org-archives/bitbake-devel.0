Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 1881B7708E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Oct 2015 16:26:03 +0000 (UTC)
Received: by wicfx6 with SMTP id fx6so167354594wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Oct 2015 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel_com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=mV7voHvYloSQL2wDGI7DfAda9zqkAl/uZNOzx2G9enY=;
	b=RtWFG9sW6iSZEB0Vu1zF/7r030hf/Y60CnwAYZTKMIp/+3lRUp99KAiGkXCzeegKkN
	QNiVoNE0Bre9OSir5EFtartiD7DpD2ec8eiONYDwpzP0xc3pWf3t07uPBxyTTjuiAzaR
	OElrObPcEaTm7Rnz0Rdy2ffr58klRJtZDKKMQvEtoNztS0OhCaLuGb8+2GaOTrNYt5HB
	MJBSyLO7rjgXpCpJduScS7ck/o/wWtzHH188odxSAzsfKt6kZIg8MLVrPLSXp5vnmKd4
	EWJBKmfoLEkq2vqDxdt7LyqGe3vFr8vwMt+/O18Gl/PFKsn2JeXTEa2zTCJs0ke6m7V2
	NvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=mV7voHvYloSQL2wDGI7DfAda9zqkAl/uZNOzx2G9enY=;
	b=UdyYAASJGD3Be8MGhUX33oaMqOYzsgtuPhSPl3AQeWK427IX+nRiUegwPIdNqbO4wP
	+v1FbbAeS4t4PEzdT+RQzHYvmE/I1Ml6evAuyaViXnJXxUxDAOAmP+6a5B3arAKfmYCE
	J+Lo1VhLvVmWIDIZgiL07eVxBtUt2bUCvNWnOfD/0TMUjVvA1ZDYK8lU66yXWGHyCvrH
	T5rV1zSzA463skcZ3ei1QYzDu4UqndwZtqlFDMyvjAj0SB2waMjNz1FmDvrmZHvtJcG2
	xNxBx+EbN7uovjZ2qyUTBQuFg3nB7XVFuOrA26XCGwwBb7O/XI7N/N/MVLDC16QRbjCh
	VJfw==
X-Gm-Message-State: ALoCoQn3ASXbkDPgWYr79p4VSBzKhmWyyGQq+H43nryXGGXVOKQAmbB0x17d8LltfSKX5vSKGxvO
X-Received: by 10.180.82.70 with SMTP id g6mr28882896wiy.38.1445963163030;
	Tue, 27 Oct 2015 09:26:03 -0700 (PDT)
Received: from dorado.Home ([2.120.70.166])
	by smtp.gmail.com with ESMTPSA id fp6sm6779267wib.9.2015.10.27.09.26.01
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 27 Oct 2015 09:26:02 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Oct 2015 16:25:56 +0000
Message-Id: <1445963156-18084-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1445963156-18084-1-git-send-email-michael.g.wood@intel.com>
References: <1445963156-18084-1-git-send-email-michael.g.wood@intel.com>
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
X-List-Received-Date: Tue, 27 Oct 2015 16:26:03 -0000

From: Elliot Smith <elliot.smith@intel.com>

Rather than relying on bug 8411, which is conveniently creating
separate log files for each of our builds, create our own
log file for each build.

The log files are created in the same tmp directories that
bitbake users, but are timestamped to the millisecond to avoid
name collisions.

Each log file is opened on the ParseStarted event and closed
on the BuildCompleted event (or if when the build fails).

Because we start logging on ParseStarted, we're able to capture
the "Build Configuration" section output by bitbake.

[YOCTO #8373]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/buildinfohelper.py |   8 ++--
 lib/bb/ui/toasterui.py       | 105 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 84 insertions(+), 29 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 286fb6a..41e4643 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -778,7 +778,7 @@ class BuildInfoHelper(object):
     ## methods to convert event/external info into objects that the ORM layer uses
 
 
-    def _get_build_information(self, consolelogfile):
+    def _get_build_information(self, build_log_path):
         build_info = {}
         # Generate an identifier for each new build
 
@@ -787,7 +787,7 @@ class BuildInfoHelper(object):
         build_info['distro_version'] = self.server.runCommand(["getVariable", "DISTRO_VERSION"])[0]
         build_info['started_on'] = timezone.now()
         build_info['completed_on'] = timezone.now()
-        build_info['cooker_log_path'] = consolelogfile
+        build_info['cooker_log_path'] = build_log_path
         build_info['build_name'] = self.server.runCommand(["getVariable", "BUILDNAME"])[0]
         build_info['bitbake_version'] = self.server.runCommand(["getVariable", "BB_VERSION"])[0]
 
@@ -928,9 +928,9 @@ class BuildInfoHelper(object):
                 logger.warn("buildinfohelper: cannot identify layer exception:%s ", nee)
 
 
-    def store_started_build(self, event, consolelogfile):
+    def store_started_build(self, event, build_log_path):
         assert '_pkgs' in vars(event)
-        build_information = self._get_build_information(consolelogfile)
+        build_information = self._get_build_information(build_log_path)
 
         build_obj = self.orm_wrapper.create_build_object(build_information, self.brbe, self.project)
 
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 0ed774e..e594196 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
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
@@ -59,12 +58,53 @@ def _log_settings_from_server(server):
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
 
+    logformat = bb.msg.BBLogFormatter(format_str)
+    build_log.setFormatter(logformat)
+
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
@@ -73,8 +113,6 @@ def main(server, eventHandler, params ):
     logger.addHandler(console)
     logger.setLevel(logging.INFO)
 
-    _, _, consolelogfile = _log_settings_from_server(server)
-
     # verify and warn
     build_history_enabled = True
     inheritlist, _ = server.runCommand(["getVariable", "INHERIT"])
@@ -87,8 +125,9 @@ def main(server, eventHandler, params ):
         logger.error("ToasterUI can only work in observer mode")
         return 1
 
-
+    # set to 1 when toasterui needs to shut down
     main.shutdown = 0
+
     interrupted = False
     return_value = 0
     errors = 0
@@ -98,25 +137,31 @@ def main(server, eventHandler, params ):
 
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
 
@@ -125,8 +170,15 @@ def main(server, eventHandler, params ):
             # pylint: disable=protected-access
             # the code will look into the protected variables of the event; no easy way around this
 
+            # we treat ParseStarted as the first event of the build;
+            # that way we get the Build Configuration included in the log
+            # and any errors that occur before BuildStarted is fired
+            if isinstance(event, bb.event.ParseStarted):
+                build_log, build_log_file_path = _open_build_log(log_dir)
+                continue
+
             if isinstance(event, bb.event.BuildStarted):
-                buildinfohelper.store_started_build(event, consolelogfile)
+                buildinfohelper.store_started_build(event, build_log_file_path)
 
             if isinstance(event, (bb.build.TaskStarted, bb.build.TaskSucceeded, bb.build.TaskFailedSilent)):
                 buildinfohelper.update_and_store_task(event)
@@ -171,8 +223,6 @@ def main(server, eventHandler, params ):
             # timing and error informations from the parsing phase in Toaster
             if isinstance(event, (bb.event.SanityCheckPassed, bb.event.SanityCheck)):
                 continue
-            if isinstance(event, bb.event.ParseStarted):
-                continue
             if isinstance(event, bb.event.ParseProgress):
                 continue
             if isinstance(event, bb.event.ParseCompleted):
@@ -248,6 +298,12 @@ def main(server, eventHandler, params ):
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
@@ -256,7 +312,6 @@ def main(server, eventHandler, params ):
 
                 # we start a new build info
                 if buildinfohelper.brbe is not None:
-
                     logger.debug("ToasterUI under BuildEnvironment management - exiting after the build")
                     server.terminateServer()
                 else:
@@ -298,8 +353,9 @@ def main(server, eventHandler, params ):
                 continue
 
             if isinstance(event, bb.cooker.CookerExit):
-                # exit when the server exits
-                break
+                # shutdown when bitbake server shuts down
+                main.shutdown = 1
+                continue
 
             # ignore
             if isinstance(event, (bb.event.BuildBase,
@@ -350,9 +406,8 @@ def main(server, eventHandler, params ):
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


