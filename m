Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S2NNd-0000SB-Ae
	for bitbake-devel@lists.openembedded.org;
	Tue, 28 Feb 2012 14:46:13 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 28 Feb 2012 05:37:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="130368927"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.68])
	by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2012 05:37:44 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Feb 2012 13:37:41 +0000
Message-Id: <476f2f92fd747eb947a71f3bf6100909c645b567.1330435914.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1330435914.git.paul.eggleton@linux.intel.com>
References: <cover.1330435914.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1330435914.git.paul.eggleton@linux.intel.com>
References: <cover.1330435914.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] bitbake: implement BB_VERBOSE_LOGS
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
X-List-Received-Date: Tue, 28 Feb 2012 13:46:13 -0000

Enable configuring whether "set +x" is added to all shell tasks rather
than forcing it; this is enabled by setting BB_VERBOSE_LOGS to 1.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/build.py  |    3 ++-
 bitbake/lib/bb/cooker.py |    4 ++++
 bitbake/lib/bb/msg.py    |    3 +++
 3 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index e85d7c4..d9079b2 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -223,7 +223,8 @@ def exec_func_shell(function, d, runfile, cwd=None):
         script.write('#!/bin/sh -e\n')
         data.emit_func(function, script, d)
 
-        script.write("set -x\n")
+        if bb.msg.loggerVerboseLogs:
+            script.write("set -x\n")
         if cwd:
             script.write("cd %s\n" % cwd)
         script.write("%s\n" % function)
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 12b526b..d3bdd17 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -206,6 +206,10 @@ class BBCooker:
 
     def parseConfiguration(self):
 
+        # Set log file verbosity
+        verboselogs = bb.utils.to_boolean(self.configuration.data.getVar("BB_VERBOSE_LOGS", "0"))
+        if verboselogs:
+            bb.msg.loggerVerboseLogs = True
 
         # Change nice level if we're asked to
         nice = self.configuration.data.getVar("BB_NICE_LEVEL", True)
diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
index 20d9bdd..9b39325 100644
--- a/bitbake/lib/bb/msg.py
+++ b/bitbake/lib/bb/msg.py
@@ -100,6 +100,7 @@ class BBLogFilter(object):
 
 loggerDefaultDebugLevel = 0
 loggerDefaultVerbose = False
+loggerVerboseLogs = False
 loggerDefaultDomains = []
 
 def init_msgconfig(verbose, debug, debug_domains = []):
@@ -108,6 +109,8 @@ def init_msgconfig(verbose, debug, debug_domains = []):
     """
     bb.msg.loggerDefaultDebugLevel = debug
     bb.msg.loggerDefaultVerbose = verbose
+    if verbose:
+        bb.msg.loggerVerboseLogs = True
     bb.msg.loggerDefaultDomains = debug_domains
 
 def addDefaultlogFilter(handler):
-- 
1.7.5.4



