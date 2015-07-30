Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 31F95764AA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jul 2015 16:25:37 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 30 Jul 2015 09:25:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,577,1432623600"; d="scan'208";a="738931551"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 30 Jul 2015 09:25:37 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 0E5746A4005;
	Thu, 30 Jul 2015 09:24:51 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jul 2015 19:25:14 +0300
Message-Id: <b27aa011df68db9685a343e9120a727b3944d30d.1438271912.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <89ab50af017d1c1d78b263b16ee50be955db2cb2.1438271912.git.ed.bartosh@linux.intel.com>
References: <89ab50af017d1c1d78b263b16ee50be955db2cb2.1438271912.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438271912.git.ed.bartosh@linux.intel.com>
References: <cover.1438271912.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 06/11] toaster: tts: fix startup and cleanup for managed mode
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
X-List-Received-Date: Thu, 30 Jul 2015 16:25:37 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes the toaster startup and database cleanup
for managed mode. It is needed because the toaster script
thinks it has been called with "source" instead of being
executed as independent script if not called through bash.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/contrib/tts/runner.py | 1 +
 lib/toaster/contrib/tts/tests.py  | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/contrib/tts/runner.py b/lib/toaster/contrib/tts/runner.py
index dac632c..3fd1b66 100755
--- a/lib/toaster/contrib/tts/runner.py
+++ b/lib/toaster/contrib/tts/runner.py
@@ -122,6 +122,7 @@ def execute_tests(dir_under_test, testname):
     # we disable the broad-except because we want to actually catch all possible exceptions
     try:
         config.logger.debug("Discovered test clases: %s", pprint.pformat(tests))
+        unittest.installHandler()
         suite = unittest.TestSuite()
         loader = unittest.TestLoader()
         result = unittest.TestResult()
diff --git a/lib/toaster/contrib/tts/tests.py b/lib/toaster/contrib/tts/tests.py
index eb91947..fd6aa3b 100644
--- a/lib/toaster/contrib/tts/tests.py
+++ b/lib/toaster/contrib/tts/tests.py
@@ -76,7 +76,7 @@ class TestHTML5Compliance(unittest.TestCase):
             setup.expect(r"Enter your option: ")
             setup.sendline('0')
 
-        self.child = pexpect.spawn("%s/bitbake/bin/toaster webport=%d nobrowser" % (config.TESTDIR, config.TOASTER_PORT))
+        self.child = pexpect.spawn("bash", ["%s/bitbake/bin/toaster" % config.TESTDIR, "webport=%d" % config.TOASTER_PORT, "nobrowser"], cwd=self.crtdir)
         self.child.logfile = sys.stdout
         self.child.expect("Toaster is now running. You can stop it with Ctrl-C")
 
@@ -101,5 +101,6 @@ class TestHTML5Compliance(unittest.TestCase):
             self.child.kill(signal.SIGINT)
             time.sleep(1)
         os.chdir(self.origdir)
-#        if os.path.exists(os.path.join(self.crtdir, "toaster.sqlite")):
-#            os.remove(os.path.join(self.crtdir, "toaster.sqlite"))
+        toaster_sqlite_path = os.path.join(self.crtdir, "toaster.sqlite")
+        if os.path.exists(toaster_sqlite_path):
+            os.remove(toaster_sqlite_path)
-- 
2.1.4


