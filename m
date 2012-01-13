Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1RlkeB-0006Wv-Ny
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Jan 2012 18:10:37 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 13 Jan 2012 09:01:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="98177340"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.110])
	by orsmga002.jf.intel.com with ESMTP; 13 Jan 2012 09:01:58 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Jan 2012 17:01:48 +0000
Message-Id: <7f7a7011cf7cd614be4488d40a21ac6b27ed1b83.1326473488.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1326473488.git.paul.eggleton@linux.intel.com>
References: <cover.1326473488.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1326473488.git.paul.eggleton@linux.intel.com>
References: <cover.1326473488.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 4/8] bitbake/fetch2: correctly decode exit signal/status
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

The termination signal and exit code of the fetch process were not being
decoded correctly, resulting in bitbake reporting that the process
terminated with a signal of the exit code (if it was under 255). There
are functions in the Python os module to do this decoding correctly (for
Unix at least), so let's use them.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 21abb13..771f72e 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
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
 
-- 
1.7.5.4



