Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UCuBU-0003eG-3Q
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Mar 2013 16:53:44 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 05 Mar 2013 07:34:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,787,1355126400"; d="scan'208";a="271343584"
Received: from adinu-vostro-460 (HELO localhost.localdomain) ([10.237.105.45])
	by orsmga001.jf.intel.com with ESMTP; 05 Mar 2013 07:36:07 -0800
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Mar 2013 17:36:22 +0200
Message-Id: <1362497791-30020-3-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
Subject: [PATCH 02/11] extended cooker.py variables
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
X-List-Received-Date: Tue, 05 Mar 2013 15:53:46 -0000

-extended cooker.py so that the extra information in cache_extra.py could
 be used

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/cooker.py |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 1b84e86..8485b70 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -471,6 +471,8 @@ class BBCooker:
         taskdata.add_unresolved(localdata, self.status)
         bb.event.fire(bb.event.TreeDataPreparationCompleted(len(pkgs_to_build)), self.configuration.data)
         return runlist, taskdata
+    
+    ######## WARNING : this function requires cache_extra to be enabled ########
 
     def generateTaskDepTreeData(self, pkgs_to_build, task):
         """
@@ -544,6 +546,7 @@ class BBCooker:
 
         return depend_tree
 
+    ######## WARNING : this function requires cache_extra to be enabled ########
     def generatePkgDepTreeData(self, pkgs_to_build, task):
         """
         Create a dependency tree of pkgs_to_build, returning the data.
@@ -571,8 +574,11 @@ class BBCooker:
             lic = self.status.license[fn]
             section = self.status.section[fn]
             description = self.status.description[fn]
+            homepage = self.status.homepage[fn]
+            bugtracker = self.status.bugtracker[fn]
             rdepends = self.status.rundeps[fn]
             rrecs = self.status.runrecs[fn]
+            prevision = self.status.prevision[fn]
             inherits = self.status.inherits.get(fn, None)
             if pn not in depend_tree["pn"]:
                 depend_tree["pn"][pn] = {}
@@ -583,6 +589,9 @@ class BBCooker:
                 depend_tree["pn"][pn]["section"] = section
                 depend_tree["pn"][pn]["description"] = description
                 depend_tree["pn"][pn]["inherits"] = inherits
+                depend_tree["pn"][pn]["homepage"] = homepage
+                depend_tree["pn"][pn]["bugtracker"] = bugtracker
+                depend_tree["pn"][pn]["revision"] = prevision
 
             if fnid not in seen_fnids:
                 seen_fnids.append(fnid)
-- 
1.7.9.5



