Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SCvan-0005xU-RC
	for bitbake-devel@lists.openembedded.org;
	Wed, 28 Mar 2012 18:19:26 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 28 Mar 2012 09:10:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="122715044"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 28 Mar 2012 09:10:24 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 00:36:57 +0800
Message-Id: <d929602109695850654fe0a9c19b109435dd52d6.1332952559.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <ba0cac313670c2e9f5c77d04e1eb07ef3aec9352.1332952559.git.shane.wang@intel.com>
References: <ba0cac313670c2e9f5c77d04e1eb07ef3aec9352.1332952559.git.shane.wang@intel.com>
In-Reply-To: <cover.1332952559.git.shane.wang@intel.com>
References: <cover.1332952559.git.shane.wang@intel.com>
Subject: [PATCH 4/5] Hob: change some words on recipes screen and package screen to make them consistent
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
X-List-Received-Date: Wed, 28 Mar 2012 16:19:26 -0000

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    4 ++--
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 67ae5d1..d855e58 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -37,7 +37,7 @@ class PackageSelectionPage (HobPage):
          'name'    : 'Included',
          'filter'  : { PackageListModel.COL_INC : [True] },
          'columns' : [{
-                       'col_name' : 'Package Name',
+                       'col_name' : 'Package name',
                        'col_id'   : PackageListModel.COL_NAME,
                        'col_style': 'text',
                        'col_min'  : 100,
@@ -65,7 +65,7 @@ class PackageSelectionPage (HobPage):
          'name'    : 'All packages',
          'filter'  : {},
          'columns' : [{
-                       'col_name' : 'Package Name',
+                       'col_name' : 'Package name',
                        'col_id'   : PackageListModel.COL_NAME,
                        'col_style': 'text',
                        'col_min'  : 100,
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index ebdb7c1..e4616a8 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -37,7 +37,7 @@ class RecipeSelectionPage (HobPage):
          'filter'  : { RecipeListModel.COL_INC  : [True],
                        RecipeListModel.COL_TYPE : ['recipe', 'task'] },
          'columns' : [{
-                       'col_name' : 'Recipe Name',
+                       'col_name' : 'Recipe name',
                        'col_id'   : RecipeListModel.COL_NAME,
                        'col_style': 'text',
                        'col_min'  : 100,
@@ -59,7 +59,7 @@ class RecipeSelectionPage (HobPage):
          'name'    : 'All recipes',
          'filter'  : { RecipeListModel.COL_TYPE : ['recipe'] },
          'columns' : [{
-                       'col_name' : 'Recipe Name',
+                       'col_name' : 'Recipe name',
                        'col_id'   : RecipeListModel.COL_NAME,
                        'col_style': 'text',
                        'col_min'  : 100,
@@ -87,7 +87,7 @@ class RecipeSelectionPage (HobPage):
          'name'    : 'Tasks',
          'filter'  : { RecipeListModel.COL_TYPE : ['task'] },
          'columns' : [{
-                       'col_name' : 'Task Name',
+                       'col_name' : 'Task name',
                        'col_id'   : RecipeListModel.COL_NAME,
                        'col_style': 'text',
                        'col_min'  : 100,
-- 
1.7.6



