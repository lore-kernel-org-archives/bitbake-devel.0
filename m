Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QySoD-00068A-1S
	for bitbake-devel@lists.openembedded.org;
	Tue, 30 Aug 2011 20:13:13 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 30 Aug 2011 11:08:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,303,1312182000"; d="scan'208";a="43987484"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.52])
	by azsmga001.ch.intel.com with ESMTP; 30 Aug 2011 11:08:15 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Aug 2011 11:08:05 -0700
Message-Id: <82845569c37591f6b097b9db071484f8171a39ea.1314727299.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1314727299.git.josh@linux.intel.com>
References: <cover.1314727299.git.josh@linux.intel.com>
In-Reply-To: <cover.1314727299.git.josh@linux.intel.com>
References: <cover.1314727299.git.josh@linux.intel.com>
Subject: [PATCH 5/6] ui/crumbs/tasklistmodel: loop optimisation in include_item()
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
X-List-Received-Date: Tue, 30 Aug 2011 18:13:13 -0000

Rather than trying to iterate the model to find whether the item is already
included and then iterate the model again to find the items path attempt to
find the path first and if the path is found test whether the COL_INC of
the row is set.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |   20 +++++++-------------
 1 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index 790631f..518232d 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -417,18 +417,10 @@ class TaskListModel(gtk.ListStore):
                 it = self.contents.iter_next(it)
 
     """
-    Check the self.contents gtk.TreeModel for an item
-    where COL_NAME matches item_name
-    Returns True if a match is found, False otherwise
+    Check whether the item at item_path is included or not
     """
-    def contents_includes_name(self, item_name):
-        it = self.contents.get_iter_first()
-        while it:
-            path = self.contents.get_path(it)
-            if self.contents[path][self.COL_NAME] == item_name:
-                return True
-            it = self.contents.iter_next(it)
-        return False
+    def contents_includes_path(self, item_path):
+        return self[item_path][self.COL_INC]
 
     """
     Add this item, and any of its dependencies, to the image contents
@@ -452,13 +444,15 @@ class TaskListModel(gtk.ListStore):
                 self.selected_image = item_name
 
         if item_deps:
-            # add all of the deps and set their binb to this item
+            # Ensure all of the items deps are included and, where appropriate,
+            # add this item to their COL_BINB
             for dep in item_deps.split(" "):
                 # If the contents model doesn't already contain dep, add it
-                dep_included = self.contents_includes_name(dep)
                 dep_path = self.find_path_for_item(dep)
                 if not dep_path:
                     continue
+                dep_included = self.contents_includes_path(dep_path)
+
                 if dep_included and not dep in item_bin:
                     # don't set the COL_BINB to this item if the target is an
                     # item in our own COL_BINB
-- 
1.7.6



