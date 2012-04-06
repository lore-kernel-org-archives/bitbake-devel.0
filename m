Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SGIZO-0003Lc-PM
	for bitbake-devel@lists.openembedded.org;
	Sat, 07 Apr 2012 01:27:55 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 06 Apr 2012 16:18:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="129596285"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.176])
	by orsmga002.jf.intel.com with ESMTP; 06 Apr 2012 16:18:38 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Apr 2012 16:18:35 -0700
Message-Id: <27d192c63cf813a7daa3ab2d1ea4ddb8dbc63ffe.1333754145.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1333754145.git.josh@linux.intel.com>
References: <cover.1333754145.git.josh@linux.intel.com>
In-Reply-To: <cover.1333754145.git.josh@linux.intel.com>
References: <cover.1333754145.git.josh@linux.intel.com>
Subject: [PATCH 3/4] lib/bb/ui/crumbs/[recipe|package]selectionpage: fixed width Included col
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
X-List-Received-Date: Fri, 06 Apr 2012 23:27:55 -0000

Set the expand property on all columns other than the 'Included' column
so that the included column remains at the max size set.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobwidget.py            |    2 +
 lib/bb/ui/crumbs/packageselectionpage.py |   23 +++++++++++-------
 lib/bb/ui/crumbs/recipeselectionpage.py  |   36 ++++++++++++++++++-----------
 3 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index 3f6dd34..9ea70ad 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -127,6 +127,8 @@ class HobViewTable (gtk.VBox):
                 col.set_min_width(column['col_min'])
             if 'col_max' in column.keys():
                 col.set_max_width(column['col_max'])
+            if 'expand' in column.keys():
+                col.set_expand(True)
             self.table_tree.append_column(col)
 
             if (not 'col_style' in column.keys()) or column['col_style'] == 'text':
diff --git a/lib/bb/ui/crumbs/packageselectionpage.py b/lib/bb/ui/crumbs/packageselectionpage.py
index 78963f6..b1a199c 100755
--- a/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/lib/bb/ui/crumbs/packageselectionpage.py
@@ -41,25 +41,28 @@ class PackageSelectionPage (HobPage):
                        'col_id'   : PackageListModel.COL_NAME,
                        'col_style': 'text',
                        'col_min'  : 100,
-                       'col_max'  : 300
+                       'col_max'  : 300,
+                       'expand'   : 'True'
                       }, {
                        'col_name' : 'Brought in by',
                        'col_id'   : PackageListModel.COL_BINB,
                        'col_style': 'binb',
                        'col_min'  : 100,
-                       'col_max'  : 350
+                       'col_max'  : 350,
+                       'expand'   : 'True'
                       }, {
                        'col_name' : 'Size',
                        'col_id'   : PackageListModel.COL_SIZE,
                        'col_style': 'text',
                        'col_min'  : 100,
-                       'col_max'  : 300
+                       'col_max'  : 300,
+                       'expand'   : 'True'
                       }, {
                        'col_name' : 'Included',
                        'col_id'   : PackageListModel.COL_INC,
                        'col_style': 'check toggle',
-                       'col_min'  : 50,
-                       'col_max'  : 50
+                       'col_min'  : 100,
+                       'col_max'  : 100
                      }]
         }, {
          'name'    : 'All packages',
@@ -69,19 +72,21 @@ class PackageSelectionPage (HobPage):
                        'col_id'   : PackageListModel.COL_NAME,
                        'col_style': 'text',
                        'col_min'  : 100,
-                       'col_max'  : 400
+                       'col_max'  : 400,
+                       'expand'   : 'True'
                       }, {
                        'col_name' : 'Size',
                        'col_id'   : PackageListModel.COL_SIZE,
                        'col_style': 'text',
                        'col_min'  : 100,
-                       'col_max'  : 500
+                       'col_max'  : 500,
+                       'expand'   : 'True'
                       }, {
                        'col_name' : 'Included',
                        'col_id'   : PackageListModel.COL_INC,
                        'col_style': 'check toggle',
-                       'col_min'  : 50,
-                       'col_max'  : 50
+                       'col_min'  : 100,
+                       'col_max'  : 100
                       }]
         }
     ]
diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py b/lib/bb/ui/crumbs/recipeselectionpage.py
index 8314449..d70fe52 100755
--- a/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -41,25 +41,28 @@ class RecipeSelectionPage (HobPage):
                        'col_id'   : RecipeListModel.COL_NAME,
                        'col_style': 'text',
                        'col_min'  : 100,
-                       'col_max'  : 400
+                       'col_max'  : 400,
+                       'expand'   : 'True'
                       }, {
                        'col_name' : 'Brought in by',
                        'col_id'   : RecipeListModel.COL_BINB,
                        'col_style': 'binb',
                        'col_min'  : 100,
-                       'col_max'  : 500
+                       'col_max'  : 500,
+                       'expand'   : 'True'
                       }, {
                        'col_name' : 'Group',
                        'col_id'   : RecipeListModel.COL_GROUP,
                        'col_style': 'text',
                        'col_min'  : 100,
-                       'col_max'  : 300
+                       'col_max'  : 300,
+                       'expand'   : 'True'
                       }, {
                        'col_name' : 'Included',
                        'col_id'   : RecipeListModel.COL_INC,
                        'col_style': 'check toggle',
-                       'col_min'  : 50,
-                       'col_max'  : 50
+                       'col_min'  : 100,
+                       'col_max'  : 100
                       }]
         }, {
          'name'    : 'All recipes',
@@ -69,25 +72,28 @@ class RecipeSelectionPage (HobPage):
                        'col_id'   : RecipeListModel.COL_NAME,
                        'col_style': 'text',
                        'col_min'  : 100,
-                       'col_max'  : 400
+                       'col_max'  : 400,
+                       'expand'   : 'True'
                       }, {
                        'col_name' : 'License',
                        'col_id'   : RecipeListModel.COL_LIC,
                        'col_style': 'text',
                        'col_min'  : 100,
-                       'col_max'  : 400
+                       'col_max'  : 400,
+                       'expand'   : 'True'
                       }, {
                        'col_name' : 'Group',
                        'col_id'   : RecipeListModel.COL_GROUP,
                        'col_style': 'text',
                        'col_min'  : 100,
-                       'col_max'  : 400
+                       'col_max'  : 400,
+                       'expand'   : 'True'
                       }, {
                        'col_name' : 'Included',
                        'col_id'   : RecipeListModel.COL_INC,
                        'col_style': 'check toggle',
-                       'col_min'  : 50,
-                       'col_max'  : 50
+                       'col_min'  : 100,
+                       'col_max'  : 100
                       }]
         }, {
          'name'    : 'Tasks',
@@ -97,19 +103,21 @@ class RecipeSelectionPage (HobPage):
                        'col_id'   : RecipeListModel.COL_NAME,
                        'col_style': 'text',
                        'col_min'  : 100,
-                       'col_max'  : 400
+                       'col_max'  : 400,
+                       'expand'   : 'True'
                       }, {
                        'col_name' : 'Description',
                        'col_id'   : RecipeListModel.COL_DESC,
                        'col_style': 'text',
                        'col_min'  : 100,
-                       'col_max'  : 400
+                       'col_max'  : 400,
+                       'expand'   : 'True'
                       }, {
                        'col_name' : 'Included',
                        'col_id'   : RecipeListModel.COL_INC,
                        'col_style': 'check toggle',
-                       'col_min'  : 50,
-                       'col_max'  : 50
+                       'col_min'  : 100,
+                       'col_max'  : 100
                       }]
         }
     ]
-- 
1.7.7.6



