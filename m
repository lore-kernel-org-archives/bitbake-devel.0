Return-Path: <cristiana.voicu@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 39FF26AD30
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 10:18:07 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 20 Jun 2013 03:19:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,903,1363158000"; d="scan'208";a="356656122"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga002.fm.intel.com with ESMTP; 20 Jun 2013 03:18:07 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Jun 2013 13:19:43 +0300
Message-Id: <1371723585-27966-4-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1371723585-27966-1-git-send-email-cristiana.voicu@intel.com>
References: <1371723585-27966-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH_V2 3/5] bitbake: call the initConfiguration when reparsing
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 20 Jun 2013 10:18:07 -0000

As it is implemented now, when parsing the configuration files is
needed, it also needs an initialization.
Also, implemented a function to create an extra configuration files
which can be used as postfile/prefiles when parsing.

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/cooker.py |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index f375a6f..e1b33f1 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -109,7 +109,6 @@ class BBCooker:
                 sys.exit("FATAL: Failed to import extra cache class '%s'." % cache_name)
 
         self.data = None
-        self.initConfigurationData()
         self.loadConfigurationData()
 
         # Take a lock so only one copy of bitbake can run against a given build
@@ -155,7 +154,10 @@ class BBCooker:
     def disableDataTracking(self):
         self.data.disableTracking()
 
-    def loadConfigurationData(self):
+    def loadConfigurationData(self, tracking = False):
+        self.initConfigurationData()
+        if tracking:
+            self.enableDataTracking()
         self.databuilder.parseBaseConfiguration()
         self.data = self.databuilder.data
         self.data_hash = self.databuilder.data_hash
@@ -243,6 +245,11 @@ class BBCooker:
             loginfo = {"op":set, "file":default_file, "line":total.count("\n")}
             self.data.setVar(var, val, **loginfo)
 
+    def createConfigFile(self, name):
+        path = os.getcwd()
+        confpath = os.path.join(path, "conf", name)
+        open(confpath, 'w').close()
+
     def parseConfiguration(self):
 
         # Set log file verbosity
@@ -1201,8 +1208,7 @@ class BBCooker:
 
     def reset(self):
         self.state = state.initial
-        self.initConfigurationData()
-        self.loadConfigurationData()
+        self.loadConfigurationData(tracking=True)
 
 def server_main(cooker, func, *args):
     cooker.pre_serve()
-- 
1.7.9.5


