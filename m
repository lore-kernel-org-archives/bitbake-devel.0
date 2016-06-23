Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id A037F73285
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Jun 2016 11:00:06 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga101.jf.intel.com with ESMTP; 23 Jun 2016 04:00:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,516,1459839600"; d="scan'208";a="723879147"
Received: from clim19-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.149.148])
	by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2016 04:00:05 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Jun 2016 22:59:10 +1200
Message-Id: <16e5e6aabb7858181ff42048755e374ff2ba54c4.1466679280.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1466679280.git.paul.eggleton@linux.intel.com>
References: <cover.1466679280.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1466679280.git.paul.eggleton@linux.intel.com>
References: <cover.1466679280.git.paul.eggleton@linux.intel.com>
Subject: [PATCH v2 08/10] knotty: add quiet output mode
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
X-List-Received-Date: Thu, 23 Jun 2016 11:00:06 -0000

Quiet output mode disables printing most messages (below warnings) to
the console; however these messages still go to the console log file.
This is primarily for cases where bitbake is being launched
interactively from some other process, but where full console output is
not needed.

Because of the need to keep logging all normal events to the console
log, this functionality was implemented within the knotty UI rather
than in bb.msg (where verbose mode is implemented). We don't currently
have a means of registering command line options from the UI end, thus
the option actually has to be registered in main.py regardless of the
UI, however I didn't feel like it was worth setting up such a mechanism
just for this option.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/main.py      |  9 +++++++++
 lib/bb/msg.py       |  5 ++++-
 lib/bb/ui/knotty.py | 57 ++++++++++++++++++++++++++++++-----------------------
 3 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 283f29b..3fc3ff5 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -179,6 +179,9 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         parser.add_option("-D", "--debug", action="count", dest="debug", default=0,
                           help="Increase the debug level. You can specify this more than once.")
 
+        parser.add_option("-q", "--quiet", action="store_true", dest="quiet", default=False,
+                          help="Output less log message data to the terminal.")
+
         parser.add_option("-n", "--dry-run", action="store_true", dest="dry_run", default=False,
                           help="Don't execute, just go through the motions.")
 
@@ -279,6 +282,12 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
 
         options, targets = parser.parse_args(argv)
 
+        if options.quiet and options.verbose:
+            parser.error("options --quiet and --verbose are mutually exclusive")
+
+        if options.quiet and options.debug:
+            parser.error("options --quiet and --debug are mutually exclusive")
+
         # use configuration files from environment variables
         if "BBPRECONF" in os.environ:
             options.prefile.append(os.environ["BBPRECONF"])
diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index 8c3ab47..b7c39fa 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -182,9 +182,12 @@ def constructLogOptions():
         debug_domains["BitBake.%s" % domainarg] = logging.DEBUG - dlevel + 1
     return level, debug_domains
 
-def addDefaultlogFilter(handler, cls = BBLogFilter):
+def addDefaultlogFilter(handler, cls = BBLogFilter, forcelevel=None):
     level, debug_domains = constructLogOptions()
 
+    if forcelevel is not None:
+        level = forcelevel
+
     cls(handler, level, debug_domains)
 
 #
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index c245c22..dbcb9c4 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -161,7 +161,7 @@ class TerminalFilter(object):
                 cr = (25, 80)
         return cr
 
-    def __init__(self, main, helper, console, errconsole, format):
+    def __init__(self, main, helper, console, errconsole, format, quiet):
         self.main = main
         self.helper = helper
         self.cuu = None
@@ -169,6 +169,7 @@ class TerminalFilter(object):
         self.interactive = sys.stdout.isatty()
         self.footer_present = False
         self.lastpids = []
+        self.quiet = quiet
 
         if not self.interactive:
             return
@@ -267,25 +268,26 @@ class TerminalFilter(object):
             self.main_progress.update(self.helper.tasknumber_current)
             print('')
         lines = 1 + int(len(content) / (self.columns + 1))
-        for tasknum, task in enumerate(tasks[:(self.rows - 2)]):
-            if isinstance(task, tuple):
-                pbar, progress, rate, start_time = task
-                if not pbar.start_time:
-                    pbar.start(False)
-                    if start_time:
-                        pbar.start_time = start_time
-                pbar.setmessage('%s:%s' % (tasknum, pbar.msg.split(':', 1)[1]))
-                if progress > -1:
-                    pbar.setextra(rate)
-                    output = pbar.update(progress)
+        if not self.quiet:
+            for tasknum, task in enumerate(tasks[:(self.rows - 2)]):
+                if isinstance(task, tuple):
+                    pbar, progress, rate, start_time = task
+                    if not pbar.start_time:
+                        pbar.start(False)
+                        if start_time:
+                            pbar.start_time = start_time
+                    pbar.setmessage('%s:%s' % (tasknum, pbar.msg.split(':', 1)[1]))
+                    if progress > -1:
+                        pbar.setextra(rate)
+                        output = pbar.update(progress)
+                    else:
+                        output = pbar.update(1)
+                    if not output or (len(output) <= pbar.term_width):
+                        print('')
                 else:
-                    output = pbar.update(1)
-                if not output or (len(output) <= pbar.term_width):
-                    print('')
-            else:
-                content = "%s: %s" % (tasknum, task)
-                print(content)
-            lines = lines + 1 + int(len(content) / (self.columns + 1))
+                    content = "%s: %s" % (tasknum, task)
+                    print(content)
+                lines = lines + 1 + int(len(content) / (self.columns + 1))
         self.footer_present = lines
         self.lastpids = runningpids[:]
         self.lastcount = self.helper.tasknumber_current
@@ -336,7 +338,10 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     errconsole = logging.StreamHandler(sys.stderr)
     format_str = "%(levelname)s: %(message)s"
     format = bb.msg.BBLogFormatter(format_str)
-    bb.msg.addDefaultlogFilter(console, bb.msg.BBLogFilterStdOut)
+    if params.options.quiet:
+        bb.msg.addDefaultlogFilter(console, bb.msg.BBLogFilterStdOut, bb.msg.BBLogFormatter.WARNING)
+    else:
+        bb.msg.addDefaultlogFilter(console, bb.msg.BBLogFilterStdOut)
     bb.msg.addDefaultlogFilter(errconsole, bb.msg.BBLogFilterStdErr)
     console.setFormatter(format)
     errconsole.setFormatter(format)
@@ -399,7 +404,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     warnings = 0
     taskfailures = []
 
-    termfilter = tf(main, helper, console, errconsole, format)
+    termfilter = tf(main, helper, console, errconsole, format, params.options.quiet)
     atexit.register(termfilter.finish)
 
     while True:
@@ -498,8 +503,9 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                     continue
 
                 parseprogress.finish()
-                print(("Parsing of %d .bb files complete (%d cached, %d parsed). %d targets, %d skipped, %d masked, %d errors."
-                    % ( event.total, event.cached, event.parsed, event.virtuals, event.skipped, event.masked, event.errors)))
+                if not params.options.quiet:
+                    print(("Parsing of %d .bb files complete (%d cached, %d parsed). %d targets, %d skipped, %d masked, %d errors."
+                        % ( event.total, event.cached, event.parsed, event.virtuals, event.skipped, event.masked, event.errors)))
                 continue
 
             if isinstance(event, bb.event.CacheLoadStarted):
@@ -510,7 +516,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 continue
             if isinstance(event, bb.event.CacheLoadCompleted):
                 cacheprogress.finish()
-                print("Loaded %d entries from dependency cache." % event.num_entries)
+                if not params.options.quiet:
+                    print("Loaded %d entries from dependency cache." % event.num_entries)
                 continue
 
             if isinstance(event, bb.command.CommandFailed):
@@ -670,7 +677,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         if return_value and errors:
             summary += pluralise("\nSummary: There was %s ERROR message shown, returning a non-zero exit code.",
                                  "\nSummary: There were %s ERROR messages shown, returning a non-zero exit code.", errors)
-        if summary:
+        if summary and not params.options.quiet:
             print(summary)
 
         if interrupted:
-- 
2.5.5


