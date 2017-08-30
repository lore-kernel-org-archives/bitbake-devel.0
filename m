Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id EDE7D7838B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Aug 2017 23:31:30 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	30 Aug 2017 16:31:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,450,1498546800"; d="scan'208";a="1189995048"
Received: from ekooi-mobl5.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.141.249])
	by fmsmga001.fm.intel.com with ESMTP; 30 Aug 2017 16:31:25 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Aug 2017 11:30:44 +1200
Message-Id: <89ff7937d36f48168f476ae39e60bfb6c86ee4c9.1504135776.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1504135776.git.paul.eggleton@linux.intel.com>
References: <cover.1504135776.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/5] tinfoil: ensure log lines get printed when tasks fail
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
X-List-Received-Date: Wed, 30 Aug 2017 23:31:31 -0000

If a task fails during build_targets(), we need to print out the log
lines as knotty does or the user will be missing information about the
failure.

(This should get some deeper refactoring, but now isn't the time for
that.)

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tinfoil.py   |  7 +++++++
 lib/bb/ui/knotty.py | 50 +++++++++++++++++++++++++++-----------------------
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index fd17edc..b50ed05 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -714,6 +714,9 @@ class Tinfoil:
                 eventmask.extend(extra_events)
             ret = self.set_event_mask(eventmask)
 
+        includelogs = self.config_data.getVar('BBINCLUDELOGS')
+        loglines = self.config_data.getVar('BBINCLUDELOGS_LINES')
+
         ret = self.run_command('buildTargets', targets, task)
         if handle_events:
             result = False
@@ -743,6 +746,10 @@ class Tinfoil:
                             if event_callback and event_callback(event):
                                 continue
                             if helper.eventHandler(event):
+                                if isinstance(event, bb.build.TaskFailedSilent):
+                                    logger.warning("Logfile for failed setscene task is %s" % event.logfile)
+                                elif isinstance(event, bb.build.TaskFailed):
+                                    bb.ui.knotty.print_event_log(event, includelogs, loglines, termfilter)
                                 continue
                             if isinstance(event, bb.event.ProcessStarted):
                                 if self.quiet > 1:
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index f3900bd..2edd0aa 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -312,6 +312,32 @@ class TerminalFilter(object):
             fd = sys.stdin.fileno()
             self.termios.tcsetattr(fd, self.termios.TCSADRAIN, self.stdinbackup)
 
+def print_event_log(event, includelogs, loglines, termfilter):
+    # FIXME refactor this out further
+    logfile = event.logfile
+    if logfile and os.path.exists(logfile):
+        termfilter.clearFooter()
+        bb.error("Logfile of failure stored in: %s" % logfile)
+        if includelogs and not event.errprinted:
+            print("Log data follows:")
+            f = open(logfile, "r")
+            lines = []
+            while True:
+                l = f.readline()
+                if l == '':
+                    break
+                l = l.rstrip()
+                if loglines:
+                    lines.append(' | %s' % l)
+                    if len(lines) > int(loglines):
+                        lines.pop(0)
+                else:
+                    print('| %s' % l)
+            f.close()
+            if lines:
+                for line in lines:
+                    print(line)
+
 def _log_settings_from_server(server, observe_only):
     # Get values of variables which control our output
     includelogs, error = server.runCommand(["getVariable", "BBINCLUDELOGS"])
@@ -487,29 +513,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 continue
             if isinstance(event, bb.build.TaskFailed):
                 return_value = 1
-                logfile = event.logfile
-                if logfile and os.path.exists(logfile):
-                    termfilter.clearFooter()
-                    bb.error("Logfile of failure stored in: %s" % logfile)
-                    if includelogs and not event.errprinted:
-                        print("Log data follows:")
-                        f = open(logfile, "r")
-                        lines = []
-                        while True:
-                            l = f.readline()
-                            if l == '':
-                                break
-                            l = l.rstrip()
-                            if loglines:
-                                lines.append(' | %s' % l)
-                                if len(lines) > int(loglines):
-                                    lines.pop(0)
-                            else:
-                                print('| %s' % l)
-                        f.close()
-                        if lines:
-                            for line in lines:
-                                print(line)
+                print_event_log(event, includelogs, loglines, termfilter)
             if isinstance(event, bb.build.TaskBase):
                 logger.info(event._message)
                 continue
-- 
2.9.5


