Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qlmis-0003hd-Si
	for bitbake-devel@lists.openembedded.org;
	Tue, 26 Jul 2011 20:51:19 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 26 Jul 2011 11:46:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,270,1309762800"; d="scan'208";a="30353997"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.155])
	by orsmga002.jf.intel.com with ESMTP; 26 Jul 2011 11:46:58 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2011 11:46:43 -0700
Message-Id: <79bdd501075ff5164a8ee673a6a2a0e402978ae5.1311705833.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311705833.git.josh@linux.intel.com>
References: <cover.1311705833.git.josh@linux.intel.com>
In-Reply-To: <cover.1311705833.git.josh@linux.intel.com>
References: <cover.1311705833.git.josh@linux.intel.com>
Subject: [PATCH 09/10] ui/crumbs/tasklistmodel: don't iterate whole model in find_alt_dependency()
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
X-List-Received-Date: Tue, 26 Jul 2011 18:51:19 -0000

The method needs to find an included item anyway so rather than iterating
the entire model and checking the included status of each entry iterate
over the contents gtk.TreeFilter.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index e6af74f..b9fde9d 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -369,22 +369,21 @@ class TaskListModel(gtk.ListStore):
 
     """
     Find the name of an item in the image contents which depends on the item
-    at contents_path returns either an item name (str) or None
-    NOTE:
-    contents_path must be a path in the self.contents gtk.TreeModel
+    name.
+    Returns either an item name (str) or None
     """
     def find_alt_dependency(self, name):
-        it = self.get_iter_first()
+        it = self.contents.get_iter_first()
         while it:
-            # iterate all items in the model
-            path = self.get_path(it)
-            deps = self[path][self.COL_DEPS]
-            itname = self[path][self.COL_NAME]
-            inc = self[path][self.COL_INC]
+            # iterate all items in the contents model
+            path = self.contents.get_path(it)
+            deps = self.contents[path][self.COL_DEPS]
+            itname = self.contents[path][self.COL_NAME]
+            inc = self.contents[path][self.COL_INC]
             if itname != name and inc and deps.count(name) > 0:
 		# if this item depends on the item, return this items name
 	        return itname
-	    it = self.iter_next(it)
+	    it = self.contents.iter_next(it)
 	return ""
 
     """
-- 
1.7.6



