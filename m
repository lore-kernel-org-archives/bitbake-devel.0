Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QkIeT-0007hj-FI
	for bitbake-devel@lists.openembedded.org;
	Fri, 22 Jul 2011 18:32:37 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 22 Jul 2011 09:27:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,248,1309762800"; d="scan'208";a="30389115"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.51])
	by azsmga001.ch.intel.com with ESMTP; 22 Jul 2011 09:27:18 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Jul 2011 09:27:11 -0700
Message-Id: <e4f33dab9ad77edd3ae123ea2dc6d2f70a5be037.1311351396.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311351396.git.josh@linux.intel.com>
References: <cover.1311351396.git.josh@linux.intel.com>
In-Reply-To: <cover.1311351396.git.josh@linux.intel.com>
References: <cover.1311351396.git.josh@linux.intel.com>
Subject: [PATCH 1/1] bitbake|cooker: save a copy of the environment when BitBake is started
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
X-List-Received-Date: Fri, 22 Jul 2011 16:32:37 -0000

Create a data store in the cooker containing the values of the environment
from when BitBake is launched such that child processes can replicate
(and/or use values from) the host environment, rather than the cleaned up
environment that the main BitBake process uses.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 bin/bitbake      |    5 ++++-
 lib/bb/cooker.py |   11 ++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

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
index 0326b8c..079b6d3 100644
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
@@ -87,6 +87,15 @@ class BBCooker:
 
         self.configuration = configuration
 
+        # Keep a datastore of the initial environment variables and their
+        # values from when BitBake was launched to enable child processes
+        # to use environment variables which have been cleaned from the
+        # BitBake processes env
+        if savedenv:
+            self.savedenv = bb.data.init()
+            for k in savedenv:
+                self.savedenv.setVar(k, savedenv[k])
+
         self.caches_array = []
         # Currently, only Image Creator hob ui needs extra cache.
         # So, we save Extra Cache class name and container file
-- 
1.7.6



