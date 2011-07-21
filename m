Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qk1wp-00034c-0E
	for bitbake-devel@lists.openembedded.org;
	Fri, 22 Jul 2011 00:42:27 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 21 Jul 2011 15:38:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,244,1309762800"; d="scan'208";a="30545299"
Received: from vorpal.jf.intel.com ([10.7.199.57])
	by orsmga001.jf.intel.com with ESMTP; 21 Jul 2011 15:38:10 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2011 15:42:37 -0700
Message-Id: <928870af26317fce79d38e58b590b7236557b8e1.1311287980.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311287980.git.josh@linux.intel.com>
References: <cover.1311287980.git.josh@linux.intel.com>
In-Reply-To: <cover.1311287980.git.josh@linux.intel.com>
References: <cover.1311287980.git.josh@linux.intel.com>
Subject: [RFC PATCH 1/1] bitbake|cooker: save a copy of the environment when BitBake is started
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
X-List-Received-Date: Thu, 21 Jul 2011 22:42:27 -0000

Keep a saved copy of the environment from when BitBake is launched in the
cooker such that child processes can replicate (and/or use values from) the
host environment, rather than the cleaned up environment that the main
BitBake process uses.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 bin/bitbake      |    5 ++++-
 lib/bb/cooker.py |    7 ++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 206d97b..a9dd67e 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -197,6 +197,9 @@ Default BBFILES are the .bb files in the current directory.""")
     handler = bb.event.LogHandler()
     logger.addHandler(handler)
 
+    # Before we start modifying the environment we should take a pristine
+    # copy for possible later use
+    initialenv = os.environ.copy()
     # Clear away any spurious environment variables. But don't wipe the
     # environment totally. This is necessary to ensure the correct operation
     # of the UIs (e.g. for DISPLAY, etc.)
@@ -207,7 +210,7 @@ Default BBFILES are the .bb files in the current directory.""")
     server.initServer()
     idle = server.getServerIdleCB()
 
-    cooker = bb.cooker.BBCooker(configuration, idle)
+    cooker = bb.cooker.BBCooker(configuration, idle, initialenv)
     cooker.parseCommandLine()
 
     server.addcooker(cooker)
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 0326b8c..30a1039 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -78,7 +78,7 @@ class BBCooker:
     Manages one bitbake build run
     """
 
-    def __init__(self, configuration, server_registration_cb):
+    def __init__(self, configuration, server_registration_cb, savedenv=None):
         self.status = None
         self.appendlist = {}
         self.skiplist = {}
@@ -87,6 +87,11 @@ class BBCooker:
 
         self.configuration = configuration
 
+        # A copy of the mapping representing the environment when BitBake was
+        # launched is saved to enable child processes to use environment
+        # variables which have been cleaned from the BitBake processes env
+        self.savedenv = savedenv
+
         self.caches_array = []
         # Currently, only Image Creator hob ui needs extra cache.
         # So, we save Extra Cache class name and container file
-- 
1.7.6



