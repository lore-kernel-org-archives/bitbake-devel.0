Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SaPPC-00063D-4R
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jun 2012 12:48:30 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 01 Jun 2012 03:38:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="159498952"
Received: from hp.sh.intel.com ([10.239.47.6])
	by fmsmga001.fm.intel.com with ESMTP; 01 Jun 2012 03:38:07 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Jun 2012 18:40:57 +0800
Message-Id: <57f497956749ad3a4c41051cb12f7a3b97f0254e.1338546445.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1338546445.git.limingx.l.an@intel.com>
References: <cover.1338546445.git.limingx.l.an@intel.com>
Subject: [PATCH 1/3] Hob: clear the repeated function get_kernel_file_name
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
X-List-Received-Date: Fri, 01 Jun 2012 10:48:30 -0000

there are a repeated function in builder.py and imagedetailspage.py,
so combine them to one.

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py          |    5 +++--
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |   19 +------------------
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 8d35ea9..899d0e0 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -1141,9 +1141,10 @@ class Builder(gtk.Window):
         response = dialog.run()
         dialog.destroy()
 
-    def get_kernel_file_name(self, image_path):
+    def get_kernel_file_name(self):
         name_list = []
         kernel_name = ""
+        image_path = self.parameters.image_addr
         if image_path:
             files = [f for f in os.listdir(image_path) if f[0] <> '.']
             for check_file in files:
@@ -1166,7 +1167,7 @@ class Builder(gtk.Window):
             dialog.destroy()
             return
 
-        kernel_name, kernels_number = self.get_kernel_file_name(self.parameters.image_addr)
+        kernel_name, kernels_number = self.get_kernel_file_name()
         if not kernel_name or kernels_number > 1:
             dialog = gtk.FileChooserDialog("Load Kernel Files", self,
                                            gtk.FILE_CHOOSER_ACTION_SAVE)
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index deb053c..1ab80f8 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -368,7 +368,7 @@ class ImageDetailsPage (HobPage):
         iter = model.get_iter(path)
         image_name = model[path][0]
         if iter and model[path][2] == 'runnable':
-            kernel_name, kernel_number = self.get_kernel_file_name(image_name)
+            kernel_name, kernel_number = self.builder.parameters.get_kernel_file_name()
             self.builder.runqemu_image(image_name, kernel_name, kernel_number)
 
     def create_bottom_buttons(self, buttonlist, image_name):
@@ -446,23 +446,6 @@ class ImageDetailsPage (HobPage):
             button_id = build_new_button.connect("clicked", self.build_new_button_clicked_cb)
             self.button_ids[button_id] = build_new_button
 
-    def get_kernel_file_name(self, image_name):
-        name_list = []
-        kernel_name = ""
-        if image_name:
-            image_path = os.path.join(self.builder.parameters.image_addr)
-            files = [f for f in os.listdir(image_path) if f[0] <> '.']
-            for check_file in files:
-                if check_file.endswith(".bin"):
-                    if  self.test_mach_runnable(check_file):
-                        selected_machine = self.builder.configuration.curr_mach
-                        if selected_machine in check_file:
-                            kernel_name = check_file
-                    if not os.path.islink(os.path.join(image_path, check_file)):
-                        name_list.append(check_file)
-
-        return kernel_name, len(name_list)
-
     def save_button_clicked_cb(self, button):
         self.builder.show_save_template_dialog()
 
-- 
1.7.5.4



