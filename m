Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S7ke5-0008CI-Tv
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Mar 2012 10:37:26 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 14 Mar 2012 02:28:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="138571872"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga002.fm.intel.com with ESMTP; 14 Mar 2012 02:28:42 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Mar 2012 17:26:35 +0800
Message-Id: <c30b412003be68dd9c060e2d227f85232e4492ff.1331716896.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1331716896.git.dongxiao.xu@intel.com>
References: <cover.1331716896.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1331716896.git.dongxiao.xu@intel.com>
References: <cover.1331716896.git.dongxiao.xu@intel.com>
Subject: [PATCH 04/11] Hob: Fix the image installation dependency
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
X-List-Received-Date: Wed, 14 Mar 2012 09:37:26 -0000

Get the image installation content from rdepends and rrecommends
variables.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hoblistmodel.py |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
index 0b7c0cb..0378828 100644
--- a/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/lib/bb/ui/crumbs/hoblistmodel.py
@@ -546,9 +546,7 @@ class RecipeListModel(gtk.ListStore):
             group = event_model["pn"][item]["section"]
             install = []
 
-            depends = event_model["depends"].get(item, [])
-            rdepends = event_model["rdepends-pn"].get(item, [])
-            depends = depends + rdepends
+            depends = event_model["depends"].get(item, []) + event_model["rdepends-pn"].get(item, [])
 
             if ('task-' in name):
                 if ('lib32-' in name or 'lib64-' in name):
@@ -557,7 +555,7 @@ class RecipeListModel(gtk.ListStore):
                     atype = 'task'
             elif ('-image-' in name):
                 atype = 'image'
-                install = rdepends
+                install = event_model["rdepends-pkg"].get(item, []) + event_model["rrecs-pkg"].get(item, [])
             elif ('meta-' in name):
                 atype = 'toolchain'
             elif (name == 'dummy-image' or name == 'dummy-toolchain'):
-- 
1.7.4.1



