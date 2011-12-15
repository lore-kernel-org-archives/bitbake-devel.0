Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rb5d2-0001Ft-Gz
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Dec 2011 08:21:20 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 14 Dec 2011 23:14:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="86773844"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by orsmga001.jf.intel.com with ESMTP; 14 Dec 2011 23:14:21 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Dec 2011 15:14:55 +0800
Message-Id: <9b438bb7b3c614151cf2026f16bd62177083e0c5.1323933009.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1323933009.git.dongxiao.xu@intel.com>
References: <cover.1323933009.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1323933009.git.dongxiao.xu@intel.com>
References: <cover.1323933009.git.dongxiao.xu@intel.com>
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
X-List-Received-Date: Thu, 15 Dec 2011 07:21:20 -0000

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



