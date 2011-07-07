Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QexHo-00015h-HQ
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jul 2011 00:43:08 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 07 Jul 2011 15:39:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,496,1304319600"; d="scan'208";a="24664404"
Received: from vorpal.jf.intel.com ([10.7.199.170])
	by orsmga001.jf.intel.com with ESMTP; 07 Jul 2011 15:39:13 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  7 Jul 2011 15:43:25 -0700
Message-Id: <fb8315fd49f9c5ed9bcf9642b88d98475bd1430c.1310078501.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1310078501.git.josh@linux.intel.com>
References: <cover.1310078501.git.josh@linux.intel.com>
In-Reply-To: <cover.1310078501.git.josh@linux.intel.com>
References: <cover.1310078501.git.josh@linux.intel.com>
Subject: [PATCH 1/3] ui/crumbs/tasklistmodel: fix reset method
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
X-List-Received-Date: Thu, 07 Jul 2011 22:43:08 -0000

The reset() method only touched the contents sub-model, which does not
include the selected image(s). This patch ensures that reset correctly unsets
any image selection when called.

Further we re-initialise the COL_IMG column when resetting packages.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index d982986..5e979b7 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -429,12 +429,24 @@ class TaskListModel(gtk.ListStore):
     Empty self.contents by setting the include of each entry to None
     """
     def reset(self):
+        # Deselect images - slightly more complex logic so that we don't
+        # have to iterate all of the contents of the main model, instead
+        # just iterate the images model.
+        if self.selected_image:
+            iit = self.images.get_iter_first()
+            while iit:
+                pit = self.images.convert_iter_to_child_iter(iit)
+                self.set(pit, self.COL_INC, False)
+                iit = self.images.iter_next(iit)
+            self.selected_image = None
+
         it = self.contents.get_iter_first()
         while it:
-            path = self.contents.get_path(it)
-            opath = self.contents.convert_path_to_child_path(path)
-            self[opath][self.COL_INC] = False
-            self[opath][self.COL_BINB] = ""
+            oit = self.contents.convert_iter_to_child_iter(it)
+            self.set(oit,
+                     self.COL_INC, False,
+                     self.COL_BINB, "",
+                     self.COL_IMG, False)
             # As we've just removed the first item...
             it = self.contents.get_iter_first()
 
-- 
1.7.6



