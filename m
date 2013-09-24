Return-Path: <ddalex@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id DE6466CAFF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:05 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 24 Sep 2013 09:53:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="406511846"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2013 09:53:06 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 96A6C561146; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:43 +0100
Message-Id: <e024a90b6445fc30e62a43f3173a3000378cd754.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 14/94] bitbake: webhob: adds dsi support for observer mode
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:06 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding support in the DSI user interface to remain resident
and run in observer-only mode.

Modifies the webhob launch script to automatically lunch
the DSI as to log all builds run under webhob setup.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/bin/webhob       |  5 ++++-
 bitbake/lib/bb/ui/dsi.py | 47 ++++++++++++++---------------------------------
 2 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/bitbake/bin/webhob b/bitbake/bin/webhob
index ccaf91f..8513a3a 100755
--- a/bitbake/bin/webhob
+++ b/bitbake/bin/webhob
@@ -28,7 +28,7 @@ function webserverKillAllComponents()
 	for pidfile in ${BUILDDIR}/whbmain.pid; do
 		if [ -f ${pidfile} ]; then
 		while kill -0 $(< ${pidfile}) 2>/dev/null; do
-			kill -SIGTERM -`ps -p $(< ${pidfile}) -o "%r" --no-headers`	
+			kill -SIGTERM -$(< ${pidfile})
 			sleep 1;
 		done;
 		rm  ${pidfile}
@@ -84,9 +84,12 @@ case $CMD in
         python $BBBASEDIR/lib/webhob/manage.py syncdb || (echo "Failed db sync, stopping system start" 1>&2 && return 0)
         bitbake --server-only -t xmlrpc -B localhost:8200 
         export BBSERVER=localhost:8200
+        bitbake --observe-only -u dsi >/dev/null 2>&1 & echo $! >${BUILDDIR}/dsi.pid
         python $BBBASEDIR/lib/webhob/manage.py runserver </dev/null >${BUILDDIR}/whbmain.log 2>&1 & echo $! >${BUILDDIR}/whbmain.pid
     ;;
     stop )
+        kill $(< ${BUILDDIR}/dsi.pid )
+        rm ${BUILDDIR}/dsi.pid
         bitbake -m
         unset BBSERVER
         webserverKillAllComponents
diff --git a/bitbake/lib/bb/ui/dsi.py b/bitbake/lib/bb/ui/dsi.py
index fb3595b..5ff5696 100644
--- a/bitbake/lib/bb/ui/dsi.py
+++ b/bitbake/lib/bb/ui/dsi.py
@@ -217,22 +217,25 @@ class TerminalFilter(object):
             fd = sys.stdin.fileno()
             self.termios.tcsetattr(fd, self.termios.TCSADRAIN, self.stdinbackup)
 
-def main(server, eventHandler, params, tf = TerminalFilter):
-    print "DSI - Data Store Interface"
-
+def _log_settings_from_server(server):
     # Get values of variables which control our output
     includelogs, error = server.runCommand(["getVariable", "BBINCLUDELOGS"])
     if error:
         logger.error("Unable to get the value of BBINCLUDELOGS variable: %s" % error)
-        return 1
+        raise BaseException(error)
     loglines, error = server.runCommand(["getVariable", "BBINCLUDELOGS_LINES"])
     if error:
         logger.error("Unable to get the value of BBINCLUDELOGS_LINES variable: %s" % error)
-        return 1
+        raise BaseException(error)
     consolelogfile, error = server.runCommand(["getVariable", "BB_CONSOLELOG"])
     if error:
         logger.error("Unable to get the value of BB_CONSOLELOG variable: %s" % error)
-        return 1
+        raise BaseException(error)
+    return includelogs, loglines, consolelogfile
+
+def main(server, eventHandler, params, tf = TerminalFilter):
+
+    includelogs, loglines, consolelogfile = _log_settings_from_server(server)
 
     if sys.stdin.isatty() and sys.stdout.isatty():
         log_exec_tty = True
@@ -256,26 +259,6 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         consolelog.setFormatter(conlogformat)
         logger.addHandler(consolelog)
 
-    try:
-        params.updateFromServer(server)
-        cmdline = params.parseActions()
-        if not cmdline:
-            print("Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.")
-            return 1
-        if 'msg' in cmdline and cmdline['msg']:
-            logger.error(cmdline['msg'])
-            return 1
-
-        ret, error = server.runCommand(cmdline['action'])
-        if error:
-            logger.error("Command '%s' failed: %s" % (cmdline, error))
-            return 1
-        elif ret != True:
-            logger.error("Command '%s' failed: returned %s" % (cmdline, ret))
-            return 1
-    except xmlrpclib.Fault as x:
-        logger.error("XMLRPC Fault getting commandline:\n %s" % x)
-        return 1
 
     parseprogress = None
     cacheprogress = None
@@ -301,10 +284,6 @@ def main(server, eventHandler, params, tf = TerminalFilter):
 
             helper.eventHandler(event)
 
-            if isinstance(event, bb.runqueue.runQueueExitWait):
-                if not main.shutdown:
-                    main.shutdown = 1
-
             if isinstance(event, bb.event.BuildStarted):
                 buildinfohelper.store_started_build(event)
 
@@ -450,7 +429,6 @@ def main(server, eventHandler, params, tf = TerminalFilter):
 
             if isinstance(event, bb.event.BuildCompleted):
                 buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
-                main.shutdown = 2
 
             if isinstance(event, bb.event.ConfigParsed):
                 # timestamp should be added for this
@@ -496,12 +474,15 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 pass
         except KeyboardInterrupt:
             termfilter.clearFooter()
-            if main.shutdown == 1:
+            if params.observe_only:
+                print("\nKeyboard Interrupt, exiting observer...")
+                main.shutdown = 2
+            if not params.observe_only and main.shutdown == 1:
                 print("\nSecond Keyboard Interrupt, stopping...\n")
                 _, error = server.runCommand(["stateStop"])
                 if error:
                     logger.error("Unable to cleanly stop: %s" % error)
-            if main.shutdown == 0:
+            if not params.observe_only and main.shutdown == 0:
                 print("\nKeyboard Interrupt, closing down...\n")
                 interrupted = True
                 _, error = server.runCommand(["stateShutdown"])
-- 
1.8.1.2


