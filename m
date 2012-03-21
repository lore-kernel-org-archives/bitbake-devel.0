Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SACeU-0002wV-LP
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 04:55:58 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 20 Mar 2012 20:47:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="123228931"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 20 Mar 2012 20:47:04 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 12:05:36 +0800
Message-Id: <c8fcddd9600e5774e95ebb61a5698a81108aaae9.1332302662.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0217085648fc2b46bac296491a8af9b1a3363aca.1332302662.git.shane.wang@intel.com>
References: <0217085648fc2b46bac296491a8af9b1a3363aca.1332302662.git.shane.wang@intel.com>
In-Reply-To: <cover.1332302662.git.shane.wang@intel.com>
References: <cover.1332302662.git.shane.wang@intel.com>
Subject: [PATCH 5/5] Hob: Change the titles for recipe view and package view
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
X-List-Received-Date: Wed, 21 Mar 2012 03:55:59 -0000

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    2 +-
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 7f8c351..968d4a2 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -87,7 +87,7 @@ class PackageSelectionPage (HobPage):
     ]
 
     def __init__(self, builder):
-        super(PackageSelectionPage, self).__init__(builder, "Package Selection")
+        super(PackageSelectionPage, self).__init__(builder, "Packages")
 
         # set invisiable members
         self.package_model = self.builder.package_model
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index 409f446..b47e8d4 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -109,7 +109,7 @@ class RecipeSelectionPage (HobPage):
     ]
 
     def __init__(self, builder = None):
-        super(RecipeSelectionPage, self).__init__(builder, "Recipe Selection")
+        super(RecipeSelectionPage, self).__init__(builder, "Recipes")
 
         # set invisiable members
         self.recipe_model = self.builder.recipe_model
-- 
1.7.6



