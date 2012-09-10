Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TB7xA-0003gC-2P
	for bitbake-devel@lists.openembedded.org;
	Mon, 10 Sep 2012 19:39:20 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 10 Sep 2012 10:26:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,398,1344236400"; d="scan'208";a="200894883"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.193])
	by orsmga002.jf.intel.com with ESMTP; 10 Sep 2012 10:26:48 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Sep 2012 18:26:46 +0100
Message-Id: <1347298006-29868-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: rename task -> packagegroup in recipe selection
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
X-List-Received-Date: Mon, 10 Sep 2012 17:39:20 -0000

This changes the filtering to use the inheritance of
packagegroup.bbclass to determine if a recipe is a package group.

Also makes the tab tooltip text generic; these recipes could come from
any enabled layer, not just the default ones.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py        |    4 ++--
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py |   14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 66b0efa..15894d3 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -595,8 +595,8 @@ class RecipeListModel(gtk.ListStore):
 
             depends = event_model["depends"].get(item, []) + event_model["rdepends-pn"].get(item, [])
 
-            if ('task-' in name):
-                atype = 'task'
+            if ('packagegroup.bbclass' in " ".join(inherits)):
+                atype = 'packagegroup'
             elif ('image.bbclass' in " ".join(inherits)):
                 if name != "hob-image":
                     atype = 'image'
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index 693a449..0b159bb 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -36,7 +36,7 @@ class RecipeSelectionPage (HobPage):
          'name'    : 'Included recipes',
          'tooltip' : 'The recipes currently included for your image',
          'filter'  : { RecipeListModel.COL_INC  : [True],
-                       RecipeListModel.COL_TYPE : ['recipe', 'task'] },
+                       RecipeListModel.COL_TYPE : ['recipe', 'packagegroup'] },
          'columns' : [{
                        'col_name' : 'Recipe name',
                        'col_id'   : RecipeListModel.COL_NAME,
@@ -67,7 +67,7 @@ class RecipeSelectionPage (HobPage):
                       }]
         }, {
          'name'    : 'All recipes',
-         'tooltip' : 'All recipes available in the Yocto Project',
+         'tooltip' : 'All recipes in your configured layers',
          'filter'  : { RecipeListModel.COL_TYPE : ['recipe'] },
          'columns' : [{
                        'col_name' : 'Recipe name',
@@ -98,11 +98,11 @@ class RecipeSelectionPage (HobPage):
                        'col_max'  : 100
                       }]
         }, {
-         'name'    : 'Tasks',
-         'tooltip' : 'All tasks available in the Yocto Project',
-         'filter'  : { RecipeListModel.COL_TYPE : ['task'] },
+         'name'    : 'Package Groups',
+         'tooltip' : 'All package groups in your configured layers',
+         'filter'  : { RecipeListModel.COL_TYPE : ['packagegroup'] },
          'columns' : [{
-                       'col_name' : 'Task name',
+                       'col_name' : 'Package group name',
                        'col_id'   : RecipeListModel.COL_NAME,
                        'col_style': 'text',
                        'col_min'  : 100,
@@ -236,7 +236,7 @@ class RecipeSelectionPage (HobPage):
         # Check out a model which base on the column COL_FADE_INC,
         # it's save the prev state of column COL_INC before do exclude_item
         filter = { RecipeListModel.COL_FADE_INC  : [True],
-                   RecipeListModel.COL_TYPE      : ['recipe', 'task'] }
+                   RecipeListModel.COL_TYPE      : ['recipe', 'packagegroup'] }
         new_model = self.recipe_model.tree_model(filter, excluded_items_ahead=True)
         tree.set_model(new_model)
 
-- 
1.7.9.5



