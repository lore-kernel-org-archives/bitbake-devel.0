Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SALFN-0003UK-52
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 14:06:37 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 21 Mar 2012 05:57:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="131476480"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2012 05:57:42 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 20:55:14 +0800
Message-Id: <d2a65ad0fca7a89f273057872aadbd372a9f9c4b.1332334068.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
Subject: [PATCH 10/17] Hob: Change recipe selection tab order
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
X-List-Received-Date: Wed, 21 Mar 2012 13:06:37 -0000

In the recipe screen, change the tab order to be:
"Included", "All recipes", and "Tasks".

Also change some description name in tab.

This fixes [YOCTO #2110]

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 lib/bb/ui/crumbs/recipeselectionpage.py |   48 +++++++++++++++---------------
 1 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py b/lib/bb/ui/crumbs/recipeselectionpage.py
index 6dd7c1e..ceaf5f5 100755
--- a/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -33,26 +33,21 @@ from bb.ui.crumbs.hobpages import HobPage
 class RecipeSelectionPage (HobPage):
     pages = [
         {
-         'name'    : 'Recipe',
-         'filter'  : { RecipeListModel.COL_TYPE : ['recipe'] },
+         'name'    : 'Included',
+         'filter'  : { RecipeListModel.COL_INC  : [True],
+                       RecipeListModel.COL_TYPE : ['recipe', 'task'] },
          'columns' : [{
-                       'col_name' : 'Recipe',
+                       'col_name' : 'Recipe Name',
                        'col_id'   : RecipeListModel.COL_NAME,
                        'col_style': 'text',
                        'col_min'  : 100,
                        'col_max'  : 400
                       }, {
-                       'col_name' : 'License',
-                       'col_id'   : RecipeListModel.COL_LIC,
-                       'col_style': 'text',
-                       'col_min'  : 100,
-                       'col_max'  : 400
-                      }, {
-                       'col_name' : 'Group',
-                       'col_id'   : RecipeListModel.COL_GROUP,
+                       'col_name' : 'Brought in by',
+                       'col_id'   : RecipeListModel.COL_BINB,
                        'col_style': 'text',
                        'col_min'  : 100,
-                       'col_max'  : 400
+                       'col_max'  : 500
                       }, {
                        'col_name' : 'Included',
                        'col_id'   : RecipeListModel.COL_INC,
@@ -61,17 +56,23 @@ class RecipeSelectionPage (HobPage):
                        'col_max'  : 50
                       }]
         }, {
-         'name'    : 'Recipe Collection',
-         'filter'  : { RecipeListModel.COL_TYPE : ['task'] },
+         'name'    : 'All recipes',
+         'filter'  : { RecipeListModel.COL_TYPE : ['recipe'] },
          'columns' : [{
-                       'col_name' : 'Recipe Collection',
+                       'col_name' : 'Recipe Name',
                        'col_id'   : RecipeListModel.COL_NAME,
                        'col_style': 'text',
                        'col_min'  : 100,
                        'col_max'  : 400
                       }, {
-                       'col_name' : 'Description',
-                       'col_id'   : RecipeListModel.COL_DESC,
+                       'col_name' : 'License',
+                       'col_id'   : RecipeListModel.COL_LIC,
+                       'col_style': 'text',
+                       'col_min'  : 100,
+                       'col_max'  : 400
+                      }, {
+                       'col_name' : 'Group',
+                       'col_id'   : RecipeListModel.COL_GROUP,
                        'col_style': 'text',
                        'col_min'  : 100,
                        'col_max'  : 400
@@ -83,21 +84,20 @@ class RecipeSelectionPage (HobPage):
                        'col_max'  : 50
                       }]
         }, {
-         'name'    : 'Included',
-         'filter'  : { RecipeListModel.COL_INC  : [True],
-                       RecipeListModel.COL_TYPE : ['recipe', 'task'] },
+         'name'    : 'Tasks',
+         'filter'  : { RecipeListModel.COL_TYPE : ['task'] },
          'columns' : [{
-                       'col_name' : 'Recipe',
+                       'col_name' : 'Task Name',
                        'col_id'   : RecipeListModel.COL_NAME,
                        'col_style': 'text',
                        'col_min'  : 100,
                        'col_max'  : 400
                       }, {
-                       'col_name' : 'Brought by',
-                       'col_id'   : RecipeListModel.COL_BINB,
+                       'col_name' : 'Description',
+                       'col_id'   : RecipeListModel.COL_DESC,
                        'col_style': 'text',
                        'col_min'  : 100,
-                       'col_max'  : 500
+                       'col_max'  : 400
                       }, {
                        'col_name' : 'Included',
                        'col_id'   : RecipeListModel.COL_INC,
-- 
1.7.4.1



