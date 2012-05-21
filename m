Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SWTuy-0000IU-4R
	for bitbake-devel@lists.openembedded.org;
	Mon, 21 May 2012 16:49:04 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 21 May 2012 07:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="146430780"
Received: from hp.sh.intel.com ([10.239.47.6])
	by orsmga002.jf.intel.com with ESMTP; 21 May 2012 07:38:57 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 May 2012 22:41:22 +0800
Message-Id: <11adbf48d15cf7b82689c02b20bd2d56e6bb70d6.1337610738.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <be9df903825ec31825cd12c0d5d20d0ca0e8d88a.1337610738.git.limingx.l.an@intel.com>
References: <be9df903825ec31825cd12c0d5d20d0ca0e8d88a.1337610738.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1337610738.git.limingx.l.an@intel.com>
References: <cover.1337610738.git.limingx.l.an@intel.com>
Subject: [PATCH 3/5] Hob: fixed the issue about bug 'running image' workflow and related view
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
X-List-Received-Date: Mon, 21 May 2012 14:49:04 -0000

[YOCTO #2155]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |   75 ++++++++++++++++++--------
 1 files changed, 53 insertions(+), 22 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 1cfef80..f517544 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -32,23 +32,23 @@ from bb.ui.crumbs.hobpages import HobPage
 class ImageDetailsPage (HobPage):
 
     __columns__ = [{
-            'col_name' : 'Selected',
-            'col_id'   : 2,
-            'col_style': 'radio toggle',
-            'col_min'  : 100,
-            'col_max'  : 100
-        },{
             'col_name' : 'Image name',
             'col_id'   : 0,
             'col_style': 'text',
             'col_min'  : 500,
             'col_max'  : 500
-        }, {
+        },{
             'col_name' : 'Image size',
             'col_id'   : 1,
             'col_style': 'text',
             'col_min'  : 100,
             'col_max'  : 100
+        },{
+            'col_name' : 'Select',
+            'col_id'   : 2,
+            'col_style': 'radio toggle',
+            'col_min'  : 100,
+            'col_max'  : 100
         }]
 
     class DetailBox (gtk.EventBox):
@@ -201,46 +201,42 @@ class ImageDetailsPage (HobPage):
             self.buttonlist = ["Build new image", "Run image", "Deploy image"]
 
         # Name
-        varlist = [""]
-        vallist = ["Listed generated image and package files."]
-        t = ''
         self.image_store.clear()
         default_toggled = False
         default_image_size = 0
+        num_toggled = 0
         i = 0
         for image_name in image_names:
             image_size = HobPage._size_to_string(os.stat(os.path.join(image_addr, image_name)).st_size)
+            is_toggled = (self.test_type_runnable(image_name) and self.test_mach_runnable(image_name)) \
+                or self.test_deployable(image_name)
+
             if not default_toggled:
-                default_toggled = (self.test_type_runnable(image_name) and self.test_mach_runnable(image_name)) \
-                    or self.test_deployable(image_name)
+                default_toggled = is_toggled
                 if i == (len(image_names) - 1):
                     default_toggled = True
                 self.image_store.set(self.image_store.append(), 0, image_name, 1, image_size, 2, default_toggled)
                 if default_toggled:
                     default_image_size = image_size
                     self.create_bottom_buttons(self.buttonlist, image_name)
-                    if 'qemu' in image_name:
-                        t = ' (Selected QEMU items to be as runnable image)'
-                    else:
-                        t = ' (Selected Targeted item to be deploy)'
             else:
                 self.image_store.set(self.image_store.append(), 0, image_name, 1, image_size, 2, False)
             i = i + 1
+            num_toggled += is_toggled
 
-        if build_succeeded:
-            varlist = ["Name: ", "Directory: ", ". "]
+        if build_succeeded and (num_toggled < 2):
+            varlist = ["Name: ", "Directory: "]
             vallist = []
             vallist.append(image_name.split('.')[0])
             vallist.append(image_addr)
-            vallist.append(t)
             image_table = None
         else:
+            varlist = None
+            vallist = None
             image_table = HobViewTable(self.__columns__)
             image_table.set_model(self.image_store)
             image_table.connect("row-activated", self.row_activated_cb)
-            if default_image_size and ('qemu' in image_name):
-                t = '\n(Selected QEMU items to be as runnable image, so you need to select prompted kernel to run)'
-            vallist[0] += t
+            image_table.connect_group_selection(self.table_selected_cb)
 
         view_files_button = HobAltButton("View files")
         view_files_button.connect("clicked", self.view_files_clicked_cb, image_addr)
@@ -328,6 +324,41 @@ class ImageDetailsPage (HobPage):
                 break
         return deployable
 
+    def table_selected_cb(self, selection):
+        model, paths = selection.get_selected_rows()
+        if (not model) or (not paths):
+            return
+
+        path = paths[0]
+        columnid = 2
+        iter = model.get_iter_first()
+        while iter:
+            rowpath = model.get_path(iter)
+            model[rowpath][columnid] = False
+            iter = model.iter_next(iter)
+
+        model[path][columnid] = True
+        self.refresh_package_detail_box(model[path][1])
+
+        image_name = model[path][0]
+
+        # remove
+        for button_id, button in self.button_ids.items():
+            button.disconnect(button_id)
+        self._remove_all_widget()
+        # repack
+        self.pack_start(self.details_top_buttons, expand=False, fill=False)
+        self.pack_start(self.group_align, expand=True, fill=True)
+        if self.build_result:
+            self.box_group_area.pack_start(self.build_result, expand=False, fill=False)
+        self.box_group_area.pack_start(self.image_detail, expand=True, fill=True)
+        if self.setting_detail:
+            self.box_group_area.pack_start(self.setting_detail, expand=False, fill=False)
+        self.box_group_area.pack_start(self.package_detail, expand=False, fill=False)
+        self.create_bottom_buttons(self.buttonlist, image_name)
+        self.box_group_area.pack_end(self.details_bottom_buttons, expand=False, fill=False)
+        self.show_all()
+
     def row_activated_cb(self, table, model, path):
         if not model:
             return
-- 
1.7.5.4



