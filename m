Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id DB5F36BFA0
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Sep 2013 16:41:08 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga101.ch.intel.com with ESMTP; 09 Sep 2013 09:41:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,872,1371106800"; d="scan'208";a="393133544"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga001.fm.intel.com with ESMTP; 09 Sep 2013 09:41:09 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 7FC38560A7B; Mon,  9 Sep 2013 17:41:08 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon,  9 Sep 2013 17:40:58 +0100
Message-Id: <a1812224527bb7669488131821eb6989fcda6917.1378743829.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
References: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1378743829.git.alexandru.damian@intel.com>
References: <cover.1378743829.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 07/13] bitbake: cooker, command: add a command to return global data
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
X-List-Received-Date: Mon, 09 Sep 2013 16:41:09 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding the 'getDataDump' read-only command that will
return a dump of the global data state.

This will be used by the DSI to store the build configuration.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/command.py |  7 +++++++
 bitbake/lib/bb/cooker.py  | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 3527ad0..4d36c4b 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -145,6 +145,13 @@ class CommandsSync:
         """
         command.cooker.stop()
 
+    def getDataDump(self, command, params):
+        """
+        Returns a dump of the global state.
+        """
+        return command.cooker.getGlobalExpandedData()
+    getDataDump.readonly = True
+
     def getVariable(self, command, params):
         """
         Read the value of a variable from data
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 9fd3417..383c9c4 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1117,6 +1117,19 @@ class BBCooker:
 
         self.configuration.server_register_idlecallback(buildTargetsIdle, rq)
 
+
+    def getGlobalExpandedData(self):
+        dump = {}
+        for k in self.data.keys():
+            try:
+                v = self.data.getVar(k, True)
+                if not k.startswith("__") and not bool(self.data.getVarFlag(k, 'func')) and not isinstance(v, bb.data_smart.DataSmart):
+                    dump[k] = { 'v' : v, 'd' : self.data.getVarFlag(k, 'doc') }
+            except:
+                pass
+        return dump
+
+
     def generateNewImage(self, image, base_image, package_queue, timestamp, description):
         '''
         Create a new image with a "require"/"inherit" base_image statement
-- 
1.8.1.2


