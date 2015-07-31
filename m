Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 2611676230
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 09:17:05 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 31 Jul 2015 02:16:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,583,1432623600"; d="scan'208";a="533594751"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.252.23.101])
	by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2015 02:16:43 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 10:16:33 +0100
Message-Id: <58f012fc743698126b2aa22934382dfef07c1c88.1438334127.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1438334127.git.paul.eggleton@linux.intel.com>
References: <cover.1438334127.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1438334127.git.paul.eggleton@linux.intel.com>
References: <cover.1438334127.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] cooker: properly fix bitbake.lock handling
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
X-List-Received-Date: Fri, 31 Jul 2015 09:17:05 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If the PR server or indeed any other child process takes some time to
exit (which it sometimes does when saving its database), it can end up
holding bitbake.lock after the UI exits, which led to errors if you ran
bitbake commands successively - we saw this when running the PR server
oe-selftest tests in OE-Core. The recent attempt to fix this wasn't
quite right and ended up breaking memory resident bitbake. This time we
close the lock file when cooker shuts down (inside the UI process)
instead of unlocking it, and this is done in the cooker code rather than
the actual UI code so it doesn't matter which UI is in use. Additionally
we report that we're waiting for the lock to be released, using lsof or
fuser if available to list the processes with the lock open.

(The reproducer for the problem is to set PRSERV_HOST = "localhost:0"
and add a call to time.sleep(20) after self.server_close() in
lib/prserv/serv.py, then run bitbake -p ).

Cleanup work done by Paul Eggleton <paul.eggleton@linux.intel.com>.

This reverts bitbake commit 69ecd15aece54753154950c55d7af42f85ad8606 and
e97a9f1528d77503b5c93e48e3de9933fbb9f3cd.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/command.py   |  6 ------
 lib/bb/cooker.py    | 30 ++++++++++++++++++++++++++++++
 lib/bb/main.py      |  1 +
 lib/bb/tinfoil.py   |  1 +
 lib/bb/ui/knotty.py | 20 --------------------
 lib/bb/utils.py     | 29 +++++++++++++++++++++++++----
 6 files changed, 57 insertions(+), 30 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 2b02584..24ff341 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -267,12 +267,6 @@ class CommandsSync:
         features = params[0]
         command.cooker.setFeatures(features)
 
-    def unlockBitbake(self, command, params):
-        """
-        Unlock bitbake.lock file
-        """
-        command.cooker.unlockBitbake()
-
     # although we change the internal state of the cooker, this is transparent since
     # we always take and leave the cooker in state.initial
     setFeatures.readonly = True
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 46e5560..52b81be 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -38,6 +38,8 @@ import bb, bb.exceptions, bb.command
 from bb import utils, data, parse, event, cache, providers, taskdata, runqueue, build
 import Queue
 import signal
+import subprocess
+import errno
 import prserv.serv
 import pyinotify
 
@@ -1532,6 +1534,34 @@ class BBCooker:
     def post_serve(self):
         prserv.serv.auto_shutdown(self.data)
         bb.event.fire(CookerExit(), self.expanded_data)
+        lockfile = self.lock.name
+        self.lock.close()
+        self.lock = None
+
+        while not self.lock:
+            with bb.utils.timeout(3):
+                self.lock = bb.utils.lockfile(lockfile, shared=False, retry=False, block=True)
+                if not self.lock:
+                    # Some systems may not have lsof available
+                    procs = None
+                    try:
+                        procs = subprocess.check_output(["lsof", '-w', lockfile], stderr=subprocess.STDOUT)
+                    except OSError as e:
+                        if e.errno != errno.ENOENT:
+                            raise
+                    if procs is None:
+                        # Fall back to fuser if lsof is unavailable
+                        try:
+                            procs = subprocess.check_output(["fuser", '-v', lockfile], stderr=subprocess.STDOUT)
+                        except OSError as e:
+                            if e.errno != errno.ENOENT:
+                                raise
+
+                    msg = "Delaying shutdown due to active processes which appear to be holding bitbake.lock"
+                    if procs:
+                        msg += ":\n%s" % str(procs)
+                    print(msg)
+
 
     def shutdown(self, force = False):
         if force:
diff --git a/lib/bb/main.py b/lib/bb/main.py
index ee72328..f08a8ef 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -257,6 +257,7 @@ def start_server(servermodule, configParams, configuration, features):
                 logger.handle(event)
         raise exc_info[1], None, exc_info[2]
     server.detach()
+    cooker.lock.close()
     return server
 
 
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 3095c20..1ea46d8 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -86,6 +86,7 @@ class Tinfoil:
 
     def shutdown(self):
         self.cooker.shutdown(force=True)
+        self.cooker.post_serve()
         self.cooker.unlockBitbake()
 
 class TinfoilConfigParameters(ConfigParameters):
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 9788a92..2bee242 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -310,7 +310,6 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     errors = 0
     warnings = 0
     taskfailures = []
-    locktries = 10
 
     termfilter = tf(main, helper, console, errconsole, format)
     atexit.register(termfilter.finish)
@@ -538,25 +537,6 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 _, error = server.runCommand(["stateForceShutdown"])
             main.shutdown = 2
     try:
-        topdir, error = server.runCommand(["getVariable", "TOPDIR"])
-        if error:
-            logger.warn("Unable to get the value of TOPDIR variable: %s" % error)
-        else:
-            lockfile = "%s/bitbake.lock" % topdir
-            _, error = server.runCommand(["unlockBitbake"])
-            if error:
-                logger.warn("Unable to unlock the file %s" % lockfile)
-            else:
-                while locktries:
-                    lf = bb.utils.lockfile(lockfile, False, False)
-                    if not lf:
-                        time.sleep(1)
-                        locktries -=1
-                    else:
-                        bb.utils.unlockfile(lf)
-                        break
-                if not locktries:
-                    logger.warn("Knotty could not lock the file ${TOPDIR}/bitbake.lock, probably locked by cooker and not unlocked yet. Immediate bitbake commands may failed")
         summary = ""
         if taskfailures:
             summary += pluralise("\nSummary: %s task failed:",
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 857f5bc..607ffc5 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -31,6 +31,7 @@ import subprocess
 import glob
 import traceback
 import errno
+import signal
 from commands import getstatusoutput
 from contextlib import contextmanager
 
@@ -412,10 +413,30 @@ def fileslocked(files):
     for lock in locks:
         bb.utils.unlockfile(lock)
 
-def lockfile(name, shared=False, retry=True):
+@contextmanager
+def timeout(seconds):
+    def timeout_handler(signum, frame):
+        pass
+
+    original_handler = signal.signal(signal.SIGALRM, timeout_handler)
+
+    try:
+        signal.alarm(seconds)
+        yield
+    finally:
+        signal.alarm(0)
+        signal.signal(signal.SIGALRM, original_handler)
+
+def lockfile(name, shared=False, retry=True, block=False):
     """
-    Use the file fn as a lock file, return when the lock has been acquired.
-    Returns a variable to pass to unlockfile().
+    Use the specified file as a lock file, return when the lock has
+    been acquired. Returns a variable to pass to unlockfile().
+    Parameters:
+        retry: True to re-try locking if it fails, False otherwise
+        block: True to block until the lock succeeds, False otherwise
+    The retry and block parameters are kind of equivalent unless you
+    consider the possibility of sending a signal to the process to break
+    out - at which point you want block=True rather than retry=True.
     """
     dirname = os.path.dirname(name)
     mkdirhier(dirname)
@@ -428,7 +449,7 @@ def lockfile(name, shared=False, retry=True):
     op = fcntl.LOCK_EX
     if shared:
         op = fcntl.LOCK_SH
-    if not retry:
+    if not retry and not block:
         op = op | fcntl.LOCK_NB
 
     while True:
-- 
2.1.0


