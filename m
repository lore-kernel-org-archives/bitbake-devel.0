Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S2kNp-0005ci-GN
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 15:19:57 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 29 Feb 2012 06:11:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="116106428"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 29 Feb 2012 06:11:14 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Feb 2012 22:15:18 +0800
Message-Id: <83dbb646ca0fd8e565633e06c477e19c498c7f8d.1330523904.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
In-Reply-To: <cover.1330523904.git.shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
Subject: [PATCH 21/32] cooker.py: Fix a bug due to variable name
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
X-List-Received-Date: Wed, 29 Feb 2012 14:19:57 -0000

From: Dongxiao Xu <dongxiao.xu@intel.com>

fnid is an outer variable and shouldn't be overrided, change the inner variable
name from 'fnid' to 'id'.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 bitbake/lib/bb/cooker.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 2e4a1ba..b23b569 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -501,8 +501,8 @@ class BBCooker:
                     pn_provider = ""
                     targetid = taskdata.getbuild_id(item)
                     if targetid in taskdata.build_targets and taskdata.build_targets[targetid]:
-                        fnid = taskdata.build_targets[targetid][0]
-                        fn_provider = taskdata.fn_index[fnid]
+                        id = taskdata.build_targets[targetid][0]
+                        fn_provider = taskdata.fn_index[id]
                         pn_provider = self.status.pkg_fn[fn_provider]
                     else:
                         pn_provider = item
-- 
1.7.6



