Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id E4D5571A86
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Dec 2016 07:08:37 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 12 Dec 2016 23:08:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,340,1477983600"; d="scan'208";a="201961404"
Received: from mauric9x-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.158.7])
	by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2016 23:08:25 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Dec 2016 20:07:01 +1300
Message-Id: <e999fc0611f5e048953ade03cd2522b4d9d6c830.1481611138.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1481611138.git.paul.eggleton@linux.intel.com>
References: <cover.1481611138.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 02/15] knotty: make quiet option a level option
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
X-List-Received-Date: Tue, 13 Dec 2016 07:08:38 -0000

Allow you to specify -q / --quiet more than once to reduce the messages
even further. It will now operate as follows:

 Level  Option  Result
 -----  ------  ----------------------------------------
 0              Print usual output
 1      -q      Only show progress and warnings or above
 2      -qq     Only show warnings or above
 3+     -qqq    Only show errors

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/main.py      |  4 ++--
 lib/bb/ui/knotty.py | 35 ++++++++++++++++++++++++++++-------
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index f2f59f6..a544c0a 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -179,8 +179,8 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         parser.add_option("-D", "--debug", action="count", dest="debug", default=0,
                           help="Increase the debug level. You can specify this more than once.")
 
-        parser.add_option("-q", "--quiet", action="store_true", dest="quiet", default=False,
-                          help="Output less log message data to the terminal.")
+        parser.add_option("-q", "--quiet", action="count", dest="quiet", default=0,
+                          help="Output less log message data to the terminal. You can specify this more than once.")
 
         parser.add_option("-n", "--dry-run", action="store_true", dest="dry_run", default=False,
                           help="Don't execute, just go through the motions.")
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 48e1223..3390eb7 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -284,7 +284,7 @@ class TerminalFilter(object):
             content = self.main_progress.update(progress)
             print('')
         lines = 1 + int(len(content) / (self.columns + 1))
-        if not self.quiet:
+        if self.quiet == 0:
             for tasknum, task in enumerate(tasks[:(self.rows - 2)]):
                 if isinstance(task, tuple):
                     pbar, progress, rate, start_time = task
@@ -353,10 +353,13 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     errconsole = logging.StreamHandler(sys.stderr)
     format_str = "%(levelname)s: %(message)s"
     format = bb.msg.BBLogFormatter(format_str)
-    if params.options.quiet:
-        bb.msg.addDefaultlogFilter(console, bb.msg.BBLogFilterStdOut, bb.msg.BBLogFormatter.WARNING)
+    if params.options.quiet == 0:
+        forcelevel = None
+    elif params.options.quiet > 2:
+        forcelevel = bb.msg.BBLogFormatter.ERROR
     else:
-        bb.msg.addDefaultlogFilter(console, bb.msg.BBLogFilterStdOut)
+        forcelevel = bb.msg.BBLogFormatter.WARNING
+    bb.msg.addDefaultlogFilter(console, bb.msg.BBLogFilterStdOut, forcelevel)
     bb.msg.addDefaultlogFilter(errconsole, bb.msg.BBLogFilterStdErr)
     console.setFormatter(format)
     errconsole.setFormatter(format)
@@ -506,35 +509,47 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 logger.info(event._message)
                 continue
             if isinstance(event, bb.event.ParseStarted):
+                if params.options.quiet > 1:
+                    continue
                 if event.total == 0:
                     continue
                 parseprogress = new_progress("Parsing recipes", event.total).start()
                 continue
             if isinstance(event, bb.event.ParseProgress):
+                if params.options.quiet > 1:
+                    continue
                 if parseprogress:
                     parseprogress.update(event.current)
                 else:
                     bb.warn("Got ParseProgress event for parsing that never started?")
                 continue
             if isinstance(event, bb.event.ParseCompleted):
+                if params.options.quiet > 1:
+                    continue
                 if not parseprogress:
                     continue
                 parseprogress.finish()
                 pasreprogress = None
-                if not params.options.quiet:
+                if params.options.quiet == 0:
                     print(("Parsing of %d .bb files complete (%d cached, %d parsed). %d targets, %d skipped, %d masked, %d errors."
                         % ( event.total, event.cached, event.parsed, event.virtuals, event.skipped, event.masked, event.errors)))
                 continue
 
             if isinstance(event, bb.event.CacheLoadStarted):
+                if params.options.quiet > 1:
+                    continue
                 cacheprogress = new_progress("Loading cache", event.total).start()
                 continue
             if isinstance(event, bb.event.CacheLoadProgress):
+                if params.options.quiet > 1:
+                    continue
                 cacheprogress.update(event.current)
                 continue
             if isinstance(event, bb.event.CacheLoadCompleted):
+                if params.options.quiet > 1:
+                    continue
                 cacheprogress.finish()
-                if not params.options.quiet:
+                if params.options.quiet == 0:
                     print("Loaded %d entries from dependency cache." % event.num_entries)
                 continue
 
@@ -620,16 +635,22 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 continue
 
             if isinstance(event, bb.event.ProcessStarted):
+                if params.options.quiet > 1:
+                    continue
                 parseprogress = new_progress(event.processname, event.total)
                 parseprogress.start(False)
                 continue
             if isinstance(event, bb.event.ProcessProgress):
+                if params.options.quiet > 1:
+                    continue
                 if parseprogress:
                     parseprogress.update(event.progress)
                 else:
                     bb.warn("Got ProcessProgress event for someting that never started?")
                 continue
             if isinstance(event, bb.event.ProcessFinished):
+                if params.options.quiet > 1:
+                    continue
                 if parseprogress:
                     parseprogress.finish()
                 parseprogress = None
@@ -701,7 +722,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         if return_value and errors:
             summary += pluralise("\nSummary: There was %s ERROR message shown, returning a non-zero exit code.",
                                  "\nSummary: There were %s ERROR messages shown, returning a non-zero exit code.", errors)
-        if summary and not params.options.quiet:
+        if summary and params.options.quiet == 0:
             print(summary)
 
         if interrupted:
-- 
2.5.5


