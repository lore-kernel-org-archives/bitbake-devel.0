Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1STusI-0002Rt-UX
	for bitbake-devel@lists.openembedded.org;
	Mon, 14 May 2012 14:59:43 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 14 May 2012 05:49:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="152687721"
Received: from hp.sh.intel.com ([10.239.47.6])
	by fmsmga001.fm.intel.com with ESMTP; 14 May 2012 05:49:34 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 14 May 2012 20:51:50 +0800
Message-Id: <265361c0df39f47a3c315e0fa987f15223c09d0d.1336999687.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <24e188a8e9cf555798370b7f6151a37ed0973497.1336999687.git.limingx.l.an@intel.com>
References: <24e188a8e9cf555798370b7f6151a37ed0973497.1336999687.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1336999687.git.limingx.l.an@intel.com>
References: <cover.1336999687.git.limingx.l.an@intel.com>
Subject: [PATCH 3/3] Hob:add function about clicked a row to load image file for 'my images' page
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
X-List-Received-Date: Mon, 14 May 2012 12:59:43 -0000

[YOCTO #2238]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 4baf960..721d145 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -1073,12 +1073,13 @@ class ImageSelectionDialog (CrumbsDialog):
         self.image_table = HobViewTable(self.__columns__)
         self.image_table.set_size_request(-1, 300)
         self.image_table.connect("toggled", self.toggled_cb)
+        self.image_table.connect_group_selection(self.table_selected_cb)
+        self.image_table.connect("row-activated", self.row_actived_cb)
         self.vbox.pack_start(self.image_table, expand=True, fill=True)
 
         self.show_all()
 
-    def toggled_cb(self, table, cell, path, columnid, tree):
-        model = tree.get_model()
+    def change_image_cb(self, model, path, columnid):
         if not model:
             return
         iter = model.get_iter_first()
@@ -1089,6 +1090,19 @@ class ImageSelectionDialog (CrumbsDialog):
 
         model[path][columnid] = True
 
+    def toggled_cb(self, table, cell, path, columnid, tree):
+        model = tree.get_model()
+        self.change_image_cb(model, path, columnid)
+
+    def table_selected_cb(self, selection):
+        model, paths = selection.get_selected_rows()
+        if paths:
+            self.change_image_cb(model, paths[0], 1)
+
+    def row_actived_cb(self, tab, model, path):
+        self.change_image_cb(model, path, 1)
+        self.emit('response', gtk.RESPONSE_YES)
+
     def select_path_cb(self, action, parent, entry):
         dialog = gtk.FileChooserDialog("", parent,
                                        gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER)
-- 
1.7.5.4



