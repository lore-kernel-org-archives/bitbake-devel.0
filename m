Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SALFQ-0003Qs-Oc
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 14:06:40 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 21 Mar 2012 05:57:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="79954294"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by AZSMGA002.ch.intel.com with ESMTP; 21 Mar 2012 05:57:48 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 20:55:19 +0800
Message-Id: <a569725795ffa74401953821c449bd48f6773087.1332334068.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
Subject: [PATCH 15/17] Hob: Change the titles for recipe view and package view
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
X-List-Received-Date: Wed, 21 Mar 2012 13:06:41 -0000

From: Shane Wang <shane.wang@intel.com>

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 lib/bb/ui/crumbs/packageselectionpage.py |    2 +-
 lib/bb/ui/crumbs/recipeselectionpage.py  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/packageselectionpage.py b/lib/bb/ui/crumbs/packageselectionpage.py
index 32e438c..e2c76cc 100755
--- a/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/lib/bb/ui/crumbs/packageselectionpage.py
@@ -87,7 +87,7 @@ class PackageSelectionPage (HobPage):
     ]
 
     def __init__(self, builder):
-        super(PackageSelectionPage, self).__init__(builder, "Package Selection")
+        super(PackageSelectionPage, self).__init__(builder, "Packages")
 
         # set invisiable members
         self.package_model = self.builder.package_model
diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py b/lib/bb/ui/crumbs/recipeselectionpage.py
index ceaf5f5..2e5b727 100755
--- a/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -109,7 +109,7 @@ class RecipeSelectionPage (HobPage):
     ]
 
     def __init__(self, builder = None):
-        super(RecipeSelectionPage, self).__init__(builder, "Recipe Selection")
+        super(RecipeSelectionPage, self).__init__(builder, "Recipes")
 
         # set invisiable members
         self.recipe_model = self.builder.recipe_model
-- 
1.7.4.1



