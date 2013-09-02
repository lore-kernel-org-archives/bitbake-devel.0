Return-Path: <cristiana.voicu@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 296DC605F2
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Sep 2013 11:15:31 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 02 Sep 2013 04:15:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,1006,1367996400"; d="scan'208";a="397008380"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by orsmga002.jf.intel.com with ESMTP; 02 Sep 2013 04:14:56 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Sep 2013 14:18:25 +0300
Message-Id: <1378120705-13544-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] bitbake/cooker: fix some calls of cookerdata.findConfigFile method
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
X-List-Received-Date: Mon, 02 Sep 2013 11:15:31 -0000

Cookerdata.findconfigFile method has a new parameter. Changed some calls.

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/cooker.py |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 5a84804..f03f16b 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -170,7 +170,7 @@ class BBCooker:
 
     def appendConfigurationVar(self, var, val, default_file):
         #add append var operation to the end of default_file
-        default_file = bb.cookerdata.findConfigFile(default_file)
+        default_file = bb.cookerdata.findConfigFile(default_file, self.data)
 
         with open(default_file, 'r') as f:
             contents = f.readlines()
@@ -252,7 +252,7 @@ class BBCooker:
             self.data.varhistory.del_var_history(var)
 
             #add var to the end of default_file
-            default_file = bb.cookerdata.findConfigFile(default_file)
+            default_file = bb.cookerdata.findConfigFile(default_file, self.data)
 
             with open(default_file, 'r') as f:
                 contents = f.readlines()
@@ -697,7 +697,7 @@ class BBCooker:
         Find the location on disk of configfile and if it exists and was parsed by BitBake
         emit the ConfigFilePathFound event with the path to the file.
         """
-        path = bb.cookerdata.findConfigFile(configfile)
+        path = bb.cookerdata.findConfigFile(configfile, self.data)
         if not path:
             return
 
-- 
1.7.9.5


