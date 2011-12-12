Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1RZvyy-0002e3-RJ
	for bitbake-devel@lists.openembedded.org;
	Mon, 12 Dec 2011 03:51:13 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 11 Dec 2011 18:43:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="86091110"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.46])
	by orsmga002.jf.intel.com with ESMTP; 11 Dec 2011 18:43:12 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 12 Dec 2011 10:20:23 +0800
Message-Id: <36c71915f2d0d6e568a6452bc759be6b94d377a1.1323656120.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1323656120.git.dongxiao.xu@intel.com>
References: <cover.1323656120.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1323656120.git.dongxiao.xu@intel.com>
References: <cover.1323656120.git.dongxiao.xu@intel.com>
Subject: [PATCH 04/10] command.py: add initCooker API
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
X-List-Received-Date: Mon, 12 Dec 2011 02:51:13 -0000

initCooker is to set the cooker to the initial state with nothing
parsed.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/command.py |    6 ++++++
 lib/bb/cooker.py  |   13 +++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 5dec6a9..701b286 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -157,6 +157,12 @@ class CommandsSync:
         value = params[1]
         command.cooker.configuration.data.setVar(varname, value)
 
+    def initCooker(self, command, params):
+        """
+        Init the cooker to initial state with nothing parsed
+        """
+        command.cooker.initialize()
+
     def resetCooker(self, command, params):
         """
         Reset the cooker to its initial state, thus forcing a reparse for
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 6ddb38e..666242f 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -167,6 +167,15 @@ class BBCooker:
 
         self.parser = None
 
+    def initConfigurationData(self):
+        self.configuration.data = bb.data.init()
+
+        if not self.server_registration_cb:
+            bb.data.setVar("BB_WORKERCONTEXT", "1", self.configuration.data)
+
+        filtered_keys = bb.utils.approved_variables()
+        bb.data.inheritFromOS(self.configuration.data, self.savedenv, filtered_keys)
+
     def loadConfigurationData(self):
         self.configuration.data = bb.data.init()
 
@@ -1301,6 +1310,10 @@ class BBCooker:
     def reparseFiles(self):
         return
 
+    def initialize(self):
+        self.state = state.initial
+        self.initConfigurationData()
+
     def reset(self):
         self.state = state.initial
         self.loadConfigurationData()
-- 
1.7.0.4



