Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SACbP-0002sq-0G
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 04:52:47 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 20 Mar 2012 20:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="119835217"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 20 Mar 2012 20:43:52 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 12:05:34 +0800
Message-Id: <3fc286920e38c3b6224e6f1bbd5fef557d71dd33.1332302662.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0217085648fc2b46bac296491a8af9b1a3363aca.1332302662.git.shane.wang@intel.com>
References: <0217085648fc2b46bac296491a8af9b1a3363aca.1332302662.git.shane.wang@intel.com>
In-Reply-To: <cover.1332302662.git.shane.wang@intel.com>
References: <cover.1332302662.git.shane.wang@intel.com>
Subject: [PATCH 3/5] Hob: In the recipe view, change the headings
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
X-List-Received-Date: Wed, 21 Mar 2012 03:52:47 -0000

In 'Recipe' table, change 'Recipe' to 'Recipe Name'
In 'Included' table, change 'Recipe' to 'Recipe (Recipe Collection) Name', and 'Brought by' to 'Brought in by'.

[Yocto #2145]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index 6dd7c1e..409f446 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -36,7 +36,7 @@ class RecipeSelectionPage (HobPage):
          'name'    : 'Recipe',
          'filter'  : { RecipeListModel.COL_TYPE : ['recipe'] },
          'columns' : [{
-                       'col_name' : 'Recipe',
+                       'col_name' : 'Recipe Name',
                        'col_id'   : RecipeListModel.COL_NAME,
                        'col_style': 'text',
                        'col_min'  : 100,
@@ -87,13 +87,13 @@ class RecipeSelectionPage (HobPage):
          'filter'  : { RecipeListModel.COL_INC  : [True],
                        RecipeListModel.COL_TYPE : ['recipe', 'task'] },
          'columns' : [{
-                       'col_name' : 'Recipe',
+                       'col_name' : 'Recipe (Recipe Collection) Name',
                        'col_id'   : RecipeListModel.COL_NAME,
                        'col_style': 'text',
                        'col_min'  : 100,
                        'col_max'  : 400
                       }, {
-                       'col_name' : 'Brought by',
+                       'col_name' : 'Brought in by',
                        'col_id'   : RecipeListModel.COL_BINB,
                        'col_style': 'text',
                        'col_min'  : 100,
-- 
1.7.6



