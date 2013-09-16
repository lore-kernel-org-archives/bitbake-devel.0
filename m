Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 439B86C800
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 11:57:00 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 16 Sep 2013 04:57:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,914,1371106800"; d="scan'208";a="396295397"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga001.fm.intel.com with ESMTP; 16 Sep 2013 04:57:01 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id C0EA85609BA; Mon, 16 Sep 2013 12:57:00 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon, 16 Sep 2013 12:56:56 +0100
Message-Id: <b26fb58fcbdece4c7f36407045c1100a0d3fd8fb.1379332511.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379332511.git.alexandru.damian@intel.com>
References: <cover.1379332511.git.alexandru.damian@intel.com>
	<3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379332511.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1379332511.git.alexandru.damian@intel.com>
References: <cover.1379332511.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 6/8] bitbake: cooker, command: add a command to return global data
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
X-List-Received-Date: Mon, 16 Sep 2013 11:57:00 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding the 'getDataDump' read-only command that will
return a dump of the global data state.

This will be used by UI clients to get the build configuration.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/command.py |  8 ++++++++
 bitbake/lib/bb/cooker.py  | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index f1abaf7..84136f1 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -145,6 +145,14 @@ class CommandsSync:
         """
         command.cooker.shutdown(True)
 
+    def getDataDump(self, command, params):
+        """
+        Returns a dump of the global state. Call with
+        variable flags to be retrieved as params.
+        """
+        return command.cooker.getGlobalExpandedData(params)
+    getDataDump.readonly = True
+
     def getVariable(self, command, params):
         """
         Read the value of a variable from data
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index cb0e3e5..12155b9 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1134,6 +1134,21 @@ class BBCooker:
 
         self.configuration.server_register_idlecallback(buildTargetsIdle, rq)
 
+
+    def getGlobalExpandedData(self, flags):
+        dump = {}
+        for k in self.data.keys():
+            try:
+                v = self.data.getVar(k, True)
+                if not k.startswith("__") and not bool(self.data.getVarFlag(k, 'func')) and not isinstance(v, bb.data_smart.DataSmart):
+                    dump[k] = { 'v' : v }
+                    for d in flags:
+                        dump[k][d] = self.data.getVarFlag(k, d)
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


