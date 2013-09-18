Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id AD4216BDAF
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Sep 2013 12:16:22 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 18 Sep 2013 05:15:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,929,1371106800"; d="scan'208";a="362259681"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 18 Sep 2013 05:15:55 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id A57EC5608B2; Wed, 18 Sep 2013 13:15:56 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Wed, 18 Sep 2013 13:15:51 +0100
Message-Id: <92d9aeb7b5d08d488f151f020eb0dfee7a237669.1379505533.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <89c7b50367088573fecc0114c94f5fa9b5e761d7.1379505533.git.alexandru.damian@intel.com>
References: <cover.1379505533.git.alexandru.damian@intel.com>
	<89c7b50367088573fecc0114c94f5fa9b5e761d7.1379505533.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1379505533.git.alexandru.damian@intel.com>
References: <cover.1379505533.git.alexandru.damian@intel.com>
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
X-List-Received-Date: Wed, 18 Sep 2013 12:16:22 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding the 'getAllKeysWithFlags' read-only command that will
return a dump of the global data state, together with specified
flags for each key. The flag list is passed in as the first
parameter to the command.

This will be used by UI clients to get the build configuration.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/command.py |  9 +++++++++
 bitbake/lib/bb/cooker.py  | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index f1abaf7..21a6de0 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -145,6 +145,15 @@ class CommandsSync:
         """
         command.cooker.shutdown(True)
 
+    def getAllKeysWithFlags(self, command, params):
+        """
+        Returns a dump of the global state. Call with
+        variable flags to be retrieved as params.
+        """
+        flaglist = params[0]
+        return command.cooker.getAllKeysWithFlags(flaglist)
+    getAllKeysWithFlags.readonly = True
+
     def getVariable(self, command, params):
         """
         Read the value of a variable from data
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index fafa518..ff2af69 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1154,6 +1154,21 @@ class BBCooker:
 
         self.configuration.server_register_idlecallback(buildTargetsIdle, rq)
 
+
+    def getAllKeysWithFlags(self, flaglist):
+        dump = {}
+        for k in self.data.keys():
+            try:
+                v = self.data.getVar(k, True)
+                if not k.startswith("__") and not isinstance(v, bb.data_smart.DataSmart):
+                    dump[k] = { 'v' : v }
+                    for d in flaglist:
+                        dump[k][d] = self.data.getVarFlag(k, d)
+            except Exception as e:
+                print(e)
+        return dump
+
+
     def generateNewImage(self, image, base_image, package_queue, timestamp, description):
         '''
         Create a new image with a "require"/"inherit" base_image statement
-- 
1.8.1.2


