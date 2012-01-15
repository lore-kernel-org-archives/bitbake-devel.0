Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RmN5w-00084t-TT
	for bitbake-devel@lists.openembedded.org;
	Sun, 15 Jan 2012 11:13:49 +0100
Received: by opal (Postfix, from userid 111)
	id 151B41033F; Sun, 15 Jan 2012 10:15:11 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120115101511.151B41033F@opal>
Date: Sun, 15 Jan 2012 10:15:11 +0000 (UTC)
From: git@git.openembedded.org
Subject: Paul Eggleton : bitbake/knotty: avoid printing full task log when error already printed
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
X-List-Received-Date: Sun, 15 Jan 2012 10:13:49 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: b9746b7e4d7aa5c34eba15a61427bfc6949af123
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=b9746b7e4d7aa5c34eba15a61427bfc6949af123

Author: Paul Eggleton <paul.eggleton@linux.intel.com>
Date:   Fri Jan 13 17:01:49 2012 +0000

bitbake/knotty: avoid printing full task log when error already printed

If a task has logged an ERROR then don't print the contents of the
task's log file in knotty (the default terminal UI).

As a side-effect we now also respect BBINCLUDELOGS in knotty; if it is
false we never print the log (but the pointer to the log file is always
printed).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/build.py     |   18 +++++++++++++++---
 lib/bb/ui/knotty.py |    2 +-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 39f075d..e85d7c4 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -91,8 +91,9 @@ class TaskSucceeded(TaskBase):
 class TaskFailed(TaskBase):
     """Task execution failed"""
 
-    def __init__(self, task, logfile, metadata):
+    def __init__(self, task, logfile, metadata, errprinted = False):
         self.logfile = logfile
+        self.errprinted = errprinted
         super(TaskFailed, self).__init__(task, metadata)
 
 class TaskInvalid(TaskBase):
@@ -288,6 +289,13 @@ def _exec_task(fn, task, d, quieterr):
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
@@ -313,6 +321,9 @@ def _exec_task(fn, task, d, quieterr):
     handler.setLevel(logging.DEBUG - 2)
     bblogger.addHandler(handler)
 
+    errchk = ErrorCheckHandler()
+    bblogger.addHandler(errchk)
+
     localdata.setVar('BB_LOGFILE', logfn)
 
     event.fire(TaskStarted(task, localdata), localdata)
@@ -324,8 +335,9 @@ def _exec_task(fn, task, d, quieterr):
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
@@ -368,7 +380,7 @@ def exec_task(fn, task, d):
         if not quieterr:
             logger.error("Build of %s failed" % (task))
             logger.error(format_exc())
-            failedevent = TaskFailed(task, None, d)
+            failedevent = TaskFailed(task, None, d, True)
             event.fire(failedevent, d)
         return 1
 
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 5366386..205a8d8 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -142,7 +142,7 @@ def main(server, eventHandler):
                 logfile = event.logfile
                 if logfile and os.path.exists(logfile):
                     print("ERROR: Logfile of failure stored in: %s" % logfile)
-                    if 1 or includelogs:
+                    if includelogs and not event.errprinted:
                         print("Log data follows:")
                         f = open(logfile, "r")
                         lines = []



