Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1RlkeC-0006Wx-28
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Jan 2012 18:10:37 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 13 Jan 2012 09:01:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="98177343"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.110])
	by orsmga002.jf.intel.com with ESMTP; 13 Jan 2012 09:01:59 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Jan 2012 17:01:49 +0000
Message-Id: <d137b9a86cc7d1031d9fa04c4fd770bc8a411c68.1326473488.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1326473488.git.paul.eggleton@linux.intel.com>
References: <cover.1326473488.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1326473488.git.paul.eggleton@linux.intel.com>
References: <cover.1326473488.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 5/8] bitbake/knotty: avoid printing full task log when error already printed
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 13 Jan 2012 17:10:38 -0000

If a task has logged an ERROR then don't print the contents of the
task's log file in knotty (the default terminal UI).

As a side-effect we now also respect BBINCLUDELOGS in knotty; if it is
false we never print the log (but the pointer to the log file is always
printed).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/build.py     |   18 +++++++++++++++---
 bitbake/lib/bb/ui/knotty.py |    2 +-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 30e5497..1e041a2 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -91,8 +91,9 @@ class TaskSucceeded(TaskBase):
 class TaskFailed(TaskBase):
     """Task execution failed"""
 
-    def __init__(self, task, logfile, metadata):
+    def __init__(self, task, logfile, metadata, errprinted = False):
         self.logfile = logfile
+        self.errprinted = errprinted
         super(TaskFailed, self).__init__(task, metadata)
 
 class TaskInvalid(TaskBase):
@@ -286,6 +287,13 @@ def _exec_task(fn, task, d, quieterr):
     prefuncs = localdata.getVarFlag(task, 'prefuncs', expand=True)
     postfuncs = localdata.getVarFlag(task, 'postfuncs', expand=True)
 
+    class ErrorCheckHandler(logging.Handler):
+        def __init__(self):
+            self.triggered = False
+            logging.Handler.__init__(self, logging.ERROR)
+        def emit(self, record):
+            self.triggered = True
+
     # Handle logfiles
     si = file('/dev/null', 'r')
     try:
@@ -311,6 +319,9 @@ def _exec_task(fn, task, d, quieterr):
     handler.setLevel(logging.DEBUG - 2)
     bblogger.addHandler(handler)
 
+    errchk = ErrorCheckHandler()
+    bblogger.addHandler(errchk)
+
     localdata.setVar('BB_LOGFILE', logfn)
 
     event.fire(TaskStarted(task, localdata), localdata)
@@ -322,8 +333,9 @@ def _exec_task(fn, task, d, quieterr):
             exec_func(func, localdata)
     except FuncFailed as exc:
         if not quieterr:
+            errprinted = errchk.triggered
             logger.error(str(exc))
-            event.fire(TaskFailed(task, logfn, localdata), localdata)
+            event.fire(TaskFailed(task, logfn, localdata, errprinted), localdata)
         return 1
     finally:
         sys.stdout.flush()
@@ -366,7 +378,7 @@ def exec_task(fn, task, d):
         if not quieterr:
             logger.error("Build of %s failed" % (task))
             logger.error(format_exc())
-            failedevent = TaskFailed(task, None, d)
+            failedevent = TaskFailed(task, None, d, True)
             event.fire(failedevent, d)
         return 1
 
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 5366386..205a8d8 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -142,7 +142,7 @@ def main(server, eventHandler):
                 logfile = event.logfile
                 if logfile and os.path.exists(logfile):
                     print("ERROR: Logfile of failure stored in: %s" % logfile)
-                    if 1 or includelogs:
+                    if includelogs and not event.errprinted:
                         print("Log data follows:")
                         f = open(logfile, "r")
                         lines = []
-- 
1.7.5.4



