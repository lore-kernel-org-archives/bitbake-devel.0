Return-Path: <elliot.smith@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id E880075894
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Jan 2016 11:17:25 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga104.fm.intel.com with ESMTP; 08 Jan 2016 03:17:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,538,1444719600"; d="scan'208";a="722947301"
Received: from deryaeke-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.25.84])
	by orsmga003.jf.intel.com with ESMTP; 08 Jan 2016 03:17:25 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  8 Jan 2016 11:17:16 +0000
Message-Id: <9b913d4e52557aafc8d3ed56bd931f5e50ae1591.1452251694.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <d4ae58e68ced0a70b88430fca9aad786b113953b.1452251694.git.elliot.smith@intel.com>
References: <d4ae58e68ced0a70b88430fca9aad786b113953b.1452251694.git.elliot.smith@intel.com>
In-Reply-To: <cover.1452251694.git.elliot.smith@intel.com>
References: <cover.1452251694.git.elliot.smith@intel.com>
Subject: [PATCH 2/8] cooker: add providermap to dep_tree
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
X-List-Received-Date: Fri, 08 Jan 2016 11:17:26 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Added providermap information to the result of buildDependTree API.

This will be used by Toaster to map virtual dependencies to recipes.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/bb/cooker.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index edceca0..e957169 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -725,8 +725,15 @@ class BBCooker:
         depend_tree["packages"] = {}
         depend_tree["rdepends-pkg"] = {}
         depend_tree["rrecs-pkg"] = {}
+        depend_tree['providermap'] = {}
         depend_tree["layer-priorities"] = self.recipecache.bbfile_config_priorities
 
+        for name, fn in taskdata.get_providermap().iteritems():
+            pn = self.recipecache.pkg_fn[fn]
+            if name != pn:
+                version = "%s:%s-%s" % self.recipecache.pkg_pepvpr[fn]
+                depend_tree['providermap'][name] = (pn, version)
+
         for task in xrange(len(rq.rqdata.runq_fnid)):
             taskname = rq.rqdata.runq_task[task]
             fnid = rq.rqdata.runq_fnid[task]
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


