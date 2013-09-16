Return-Path: <ddalex@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 61FD76C7B4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 13:33:34 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 16 Sep 2013 06:33:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,915,1371106800"; d="scan'208";a="402395386"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 16 Sep 2013 06:33:18 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 4EB4156093A; Mon, 16 Sep 2013 14:33:19 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon, 16 Sep 2013 14:33:15 +0100
Message-Id: <6614ca8b4786486ae3a58e78ca0c40b131c6ff57.1379338189.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379338189.git.alexandru.damian@intel.com>
References: <cover.1379338189.git.alexandru.damian@intel.com>
	<3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379338189.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1379338189.git.alexandru.damian@intel.com>
References: <cover.1379338189.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 5/7] bitbake: cooker, command: add a command to return global data
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
X-List-Received-Date: Mon, 16 Sep 2013 13:33:34 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding the 'getAllKeysWithFlags' read-only command that will
return a dump of the global data state, together with specified
flags for each key. The flag list is passed in as the first
parameter to the command.

This will be used by UI clients to get the build configuration.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/command.py |  8 ++++++++
 bitbake/lib/bb/cooker.py  | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index f1abaf7..5d359e7 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -145,6 +145,14 @@ class CommandsSync:
         """
         command.cooker.shutdown(True)
 
+    def getAllKeysWithFlags(self, command, params):
+        """
+        Returns a dump of the global state. Call with
+        variable flags to be retrieved as params.
+        """
+        return command.cooker.getAllKeysWithFlags(params[0])
+    getAllKeysWithFlags.readonly = True
+
     def getVariable(self, command, params):
         """
         Read the value of a variable from data
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index cb0e3e5..981379b 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1134,6 +1134,21 @@ class BBCooker:
 
         self.configuration.server_register_idlecallback(buildTargetsIdle, rq)
 
+
+    def getAllKeysWithFlags(self, flaglist):
+        dump = {}
+        for k in self.data.keys():
+            try:
+                v = self.data.getVar(k, True)
+                if not k.startswith("__") and not bool(self.data.getVarFlag(k, 'func')) and not isinstance(v, bb.data_smart.DataSmart):
+                    dump[k] = { 'v' : v }
+                    for d in flaglist:
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


