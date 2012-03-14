Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S7ke7-0008CK-32
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Mar 2012 10:37:27 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 14 Mar 2012 02:28:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="118699611"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 14 Mar 2012 02:28:40 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Mar 2012 17:26:34 +0800
Message-Id: <fc84bca12f1b86e02f2f956803ed448747442517.1331716896.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1331716896.git.dongxiao.xu@intel.com>
References: <cover.1331716896.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1331716896.git.dongxiao.xu@intel.com>
References: <cover.1331716896.git.dongxiao.xu@intel.com>
Subject: [PATCH 03/11] cooker: add package rdepends and rrecommends info
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
X-List-Received-Date: Wed, 14 Mar 2012 09:37:27 -0000

When calculating the image installation dependency, we need the
rdepends and rrecommends information of certain packages.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/cooker.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 78d8754..eada435 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -479,7 +479,6 @@ class BBCooker:
                 depend_tree["pn"][pn]["license"] = lic
                 depend_tree["pn"][pn]["section"] = section
                 depend_tree["pn"][pn]["description"] = description
-                depend_tree["pn"][pn]["packages"] = rdepends.keys()
 
             if fnid not in seen_fnids:
                 seen_fnids.append(fnid)
@@ -510,6 +509,9 @@ class BBCooker:
                         pn_rprovider = item
                     depend_tree["rdepends-pn"][pn].append(pn_rprovider)
 
+                depend_tree["rdepends-pkg"].update(rdepends)
+                depend_tree["rrecs-pkg"].update(rrecs)
+
         return depend_tree
 
     def generateDepTreeEvent(self, pkgs_to_build, task):
-- 
1.7.4.1



