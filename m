Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RmN5w-00084w-Tr
	for bitbake-devel@lists.openembedded.org;
	Sun, 15 Jan 2012 11:13:49 +0100
Received: by opal (Postfix, from userid 111)
	id EF6E01033D; Sun, 15 Jan 2012 10:15:10 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120115101510.EF6E01033D@opal>
Date: Sun, 15 Jan 2012 10:15:10 +0000 (UTC)
From: git@git.openembedded.org
Subject: Paul Eggleton : bitbake/fetch2: correctly decode exit signal/status
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
Commit: 50aea9a76e40cf71cc3f1462c88298e4846a031c
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=50aea9a76e40cf71cc3f1462c88298e4846a031c

Author: Paul Eggleton <paul.eggleton@linux.intel.com>
Date:   Fri Jan 13 17:01:48 2012 +0000

bitbake/fetch2: correctly decode exit signal/status

The termination signal and exit code of the fetch process were not being
decoded correctly, resulting in bitbake reporting that the process
terminated with a signal of the exit code (if it was under 255). There
are functions in the Python os module to do this decoding correctly (for
Unix at least), so let's use them.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/fetch2/__init__.py |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 21abb13..771f72e 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -422,8 +422,11 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
         output += line
 
     status = stdout_handle.close() or 0
-    signal = status >> 8
-    exitstatus = status & 0xff
+    signal = os.WTERMSIG(status)
+    if os.WIFEXITED(status):
+        exitstatus = os.WEXITSTATUS(status)
+    else:
+        exitstatus = 0
 
     if (signal or status != 0):
         for f in cleanup:
@@ -434,8 +437,8 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
 
         if signal:
             raise FetchError("Fetch command %s failed with signal %s, output:\n%s" % (cmd, signal, output))
-        elif status != 0:
-            raise FetchError("Fetch command %s failed with exit code %s, output:\n%s" % (cmd, status, output))
+        elif exitstatus:
+            raise FetchError("Fetch command %s failed with exit code %s, output:\n%s" % (cmd, exitstatus, output))
 
     return output
 



