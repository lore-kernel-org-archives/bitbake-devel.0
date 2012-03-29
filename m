Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SDNyB-0002EZ-6e
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 Mar 2012 00:37:27 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 29 Mar 2012 15:28:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="123312766"
Received: from unknown (HELO shamshir.jf.intel.com) ([10.7.198.148])
	by orsmga001.jf.intel.com with ESMTP; 29 Mar 2012 15:28:13 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 15:28:10 -0700
Message-Id: <22a7a00f83a01b5e224b28fe147b62c33e14b5e4.1333060005.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1333060005.git.josh@linux.intel.com>
References: <cover.1333060005.git.josh@linux.intel.com>
In-Reply-To: <cover.1333060005.git.josh@linux.intel.com>
References: <cover.1333060005.git.josh@linux.intel.com>
Subject: [PATCH 3/3] lib/bb/ui/crumbs/hoblistmodel: fix sorting of RecipeListModel
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
X-List-Received-Date: Thu, 29 Mar 2012 22:37:28 -0000

Sort in ascending order on the recipe name (A-Z) and unset the default sort
function so that there's no third (unsorted) state.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hoblistmodel.py |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
index bfd49bd..a09c7c7 100644
--- a/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/lib/bb/ui/crumbs/hoblistmodel.py
@@ -471,11 +471,6 @@ class RecipeListModel(gtk.ListStore):
 
         return True
 
-    def sort_func(self, model, iter1, iter2):
-        val1 = model.get_value(iter1, RecipeListModel.COL_NAME)
-        val2 = model.get_value(iter2, RecipeListModel.COL_NAME)
-        return val1 > val2
-
     """
     Create, if required, and return a filtered gtk.TreeModelSort
     containing only the items which are items specified by filter
@@ -485,7 +480,8 @@ class RecipeListModel(gtk.ListStore):
         model.set_visible_func(self.tree_model_filter, filter)
 
         sort = gtk.TreeModelSort(model)
-        sort.set_default_sort_func(self.sort_func)
+        sort.set_sort_column_id(RecipeListModel.COL_NAME, gtk.SORT_ASCENDING)
+        sort.set_default_sort_func(None)
         return sort
 
     def convert_vpath_to_path(self, view_model, view_path):
-- 
1.7.7.6



