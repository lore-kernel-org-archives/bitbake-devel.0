Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QuDeG-0005CB-1K
	for bitbake-devel@lists.openembedded.org;
	Fri, 19 Aug 2011 03:13:24 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 18 Aug 2011 18:08:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,248,1312182000"; d="scan'208";a="40058939"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.250])
	by azsmga001.ch.intel.com with ESMTP; 18 Aug 2011 18:08:40 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Aug 2011 18:08:21 -0700
Message-Id: <6ac94ffba9cd7dcec74a64b9cc0e66ce924e364d.1313715804.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313715804.git.josh@linux.intel.com>
References: <cover.1313715804.git.josh@linux.intel.com>
In-Reply-To: <cover.1313715804.git.josh@linux.intel.com>
References: <cover.1313715804.git.josh@linux.intel.com>
Subject: [PATCH 07/11] bb/ui/crumbs/tasklistmodel: track the PN for each entry in the model
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
X-List-Received-Date: Fri, 19 Aug 2011 01:13:24 -0000

Now that we've switched to packages in the model, rather than PN, it makes
sense to add an extra field to store the PN of the package.

This patch includes a convenience method to retrieve a list of selected PN's.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index d2f49d1..3921581 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -89,7 +89,7 @@ class TaskListModel(gtk.ListStore):
     providing convenience functions to access gtk.TreeModel subclasses which
     provide filtered views of the data.
     """
-    (COL_NAME, COL_DESC, COL_LIC, COL_GROUP, COL_DEPS, COL_BINB, COL_TYPE, COL_INC, COL_IMG, COL_PATH) = range(10)
+    (COL_NAME, COL_DESC, COL_LIC, COL_GROUP, COL_DEPS, COL_BINB, COL_TYPE, COL_INC, COL_IMG, COL_PATH, COL_PN) = range(11)
 
     __gsignals__ = {
         "tasklist-populated" : (gobject.SIGNAL_RUN_LAST,
@@ -122,6 +122,7 @@ class TaskListModel(gtk.ListStore):
                                 gobject.TYPE_STRING,
                                 gobject.TYPE_BOOLEAN,
                                 gobject.TYPE_BOOLEAN,
+                                gobject.TYPE_STRING,
                                 gobject.TYPE_STRING)
 
     """
@@ -265,7 +266,8 @@ class TaskListModel(gtk.ListStore):
                          self.COL_LIC, lic, self.COL_GROUP, group,
                          self.COL_DEPS, " ".join(packages[p]), self.COL_BINB, "",
                          self.COL_TYPE, atype, self.COL_INC, False,
-                         self.COL_IMG, False, self.COL_PATH, filename)
+                         self.COL_IMG, False, self.COL_PATH, filename,
+                         self.COL_PN, item)
 
 	self.emit("tasklist-populated")
 
@@ -527,6 +529,20 @@ class TaskListModel(gtk.ListStore):
             it = self.contents.iter_next(it)
         return userpkgs, allpkgs
 
+    """
+    Return a squished (uniquified) list of the PN's of all selected items
+    """
+    def get_selected_pn(self):
+        pns = []
+
+        it = self.contents.get_iter_first()
+        while it:
+            if self.contents.get_value(it, self.COL_BINB):
+                pns.append(self.contents.get_value(it, self.COL_PN))
+            it = self.contents.iter_next(it)
+
+        return self.squish(pns)
+
     def image_contents_removed(self):
         it = self.get_iter_first()
         while it:
-- 
1.7.6



