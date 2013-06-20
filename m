Return-Path: <cristiana.voicu@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id DBE036A49F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 14:19:36 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 20 Jun 2013 07:19:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,905,1363158000"; d="scan'208";a="320029258"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by azsmga001.ch.intel.com with ESMTP; 20 Jun 2013 07:19:35 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Jun 2013 17:21:15 +0300
Message-Id: <1371738077-13703-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH_V3 1/3] bitbake: call the initConfiguration when reparsing
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
X-List-Received-Date: Thu, 20 Jun 2013 14:19:37 -0000

As it is implemented now, when parsing the configuration files is
needed, it also needs an initialization.
Also, implemented a function to create an extra configuration files
which can be used as postfile/prefiles when parsing.

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/command.py |    2 +-
 bitbake/lib/bb/cooker.py  |    8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 43dd2f4..1727654 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -396,7 +396,7 @@ class CommandsAsync:
         postfiles = params[1].split()
         command.cooker.configuration.prefile = prefiles
         command.cooker.configuration.postfile = postfiles
-        command.cooker.loadConfigurationData(tracking=True)
+        command.cooker.loadConfigurationData()
         command.finishAsyncCommand()
     parseConfigurationFiles.needcache = False
 
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 9c9734f..2245f8e 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -109,7 +109,6 @@ class BBCooker:
                 sys.exit("FATAL: Failed to import extra cache class '%s'." % cache_name)
 
         self.data = None
-        self.initConfigurationData()
         self.loadConfigurationData()
 
         # Take a lock so only one copy of bitbake can run against a given build
@@ -158,6 +157,7 @@ class BBCooker:
         self.data.disableTracking()
 
     def loadConfigurationData(self):
+        self.initConfigurationData()
         self.databuilder.parseBaseConfiguration()
         self.data = self.databuilder.data
         self.data_hash = self.databuilder.data_hash
@@ -245,6 +245,11 @@ class BBCooker:
             loginfo = {"op":set, "file":default_file, "line":total.count("\n")}
             self.data.setVar(var, val, **loginfo)
 
+    def createConfigFile(self, name):
+        path = os.getcwd()
+        confpath = os.path.join(path, "conf", name)
+        open(confpath, 'w').close()
+
     def parseConfiguration(self):
 
         # Set log file verbosity
@@ -1200,7 +1205,6 @@ class BBCooker:
 
     def reset(self):
         self.state = state.initial
-        self.initConfigurationData()
         self.loadConfigurationData()
 
 def server_main(cooker, func, *args):
-- 
1.7.9.5


