Return-Path: <sgw@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 4C9DC76A4B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Aug 2015 16:07:50 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 28 Aug 2015 09:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,425,1437462000"; d="scan'208";a="777573784"
Received: from araghun3-mobl.amr.corp.intel.com (HELO
	swold-mobl.amr.corp.intel.com) ([10.254.110.91])
	by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2015 09:07:50 -0700
From: Saul Wold <sgw@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Aug 2015 09:07:49 -0700
Message-Id: <1440778069-16934-1-git-send-email-sgw@linux.intel.com>
X-Mailer: git-send-email 2.1.0
Cc: paul.eggleton@linux.intel.com
Subject: [PATCH][1.26/fido] cooker: properly fix bitbake.lock handling
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
X-List-Received-Date: Fri, 28 Aug 2015 16:07:50 -0000

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

The 'magic' in the locking is due to all spawned subprocesses of bitbake
holding an open file descriptor to the bitbake.lock. It is automatically
unlocked when all those fds close the file (as all the processes terminate).
We close the UI copy of the lock explicitly, then close the server process
copy, any remaining open copy is therefore some proess exiting.

(The reproducer for the problem is to set PRSERV_HOST = "localhost:0"
and add a call to time.sleep(20) after self.server_close() in
lib/prserv/serv.py, then run "bitbake -p; bitbake -p" ).

Cleanup work done by Paul Eggleton <paul.eggleton@linux.intel.com>.

This reverts bitbake commit 69ecd15aece54753154950c55d7af42f85ad8606 and
e97a9f1528d77503b5c93e48e3de9933fbb9f3cd.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a29780bd43f74b7326fe788dbd65177b86806fcf)
Signed-off-by: Saul Wold <sgw@linux.intel.com>

Conflicts:
	lib/bb/tinfoil.py
---
 lib/bb/cooker.py  | 30 ++++++++++++++++++++++++++++++
 lib/bb/main.py    |  1 +
 lib/bb/tinfoil.py |  5 +++++
 lib/bb/utils.py   | 29 +++++++++++++++++++++++++----
 4 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index f32dae0..d9bffc3 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -38,6 +38,8 @@ import bb, bb.exceptions, bb.command
 from bb import utils, data, parse, event, cache, providers, taskdata, runqueue
 import Queue
 import signal
+import subprocess
+import errno
 import prserv.serv
 import pyinotify
 
@@ -1525,6 +1527,34 @@ class BBCooker:
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
index 1f19cc5..fea754f 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -258,6 +258,7 @@ def start_server(servermodule, configParams, configuration, features):
                 logger.handle(event)
         raise exc_info[1], None, exc_info[2]
     server.detach()
+    cooker.lock.close()
     return server
 
 
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 8fc9be3..1ea46d8 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -84,6 +84,11 @@ class Tinfoil:
             else:
                 self.parseRecipes()
 
+    def shutdown(self):
+        self.cooker.shutdown(force=True)
+        self.cooker.post_serve()
+        self.cooker.unlockBitbake()
+
 class TinfoilConfigParameters(ConfigParameters):
 
     def __init__(self, **options):
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 0db7e56..d380a37 100644
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


