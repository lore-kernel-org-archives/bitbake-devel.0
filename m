Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1Sm1CG-0002yN-Fo
	for bitbake-devel@lists.openembedded.org;
	Tue, 03 Jul 2012 13:23:08 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 03 Jul 2012 04:12:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="166260363"
Received: from hp.sh.intel.com ([10.239.47.6])
	by orsmga002.jf.intel.com with ESMTP; 03 Jul 2012 04:12:05 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Jul 2012 19:15:55 +0800
Message-Id: <d835f663221a51d0d2bd82a91fdbcf8194f71875.1341313886.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1341313886.git.limingx.l.an@intel.com>
References: <cover.1341313886.git.limingx.l.an@intel.com>
Subject: [PATCH 1/1] Hob: fixed some variables not clean bug in detail page
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
X-List-Received-Date: Tue, 03 Jul 2012 11:23:08 -0000

[YOCTO #2679]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |   14 +++-----------
 1 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 07fc3a8..596fb85 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -232,7 +232,7 @@ class ImageDetailsPage (HobPage):
 
         is_runnable = self.create_bottom_buttons(self.buttonlist, self.toggled_image)
 
-        #if self.build_succeeded:
+        # Generated image files info
         varlist = ["Name: ", "FileCreated: ", "Directory: "]
         vallist = []
 
@@ -428,7 +428,7 @@ class ImageDetailsPage (HobPage):
             if fileitem['is_toggled']:
                 if fileitem['action_attr'] == 'run':
                     self.builder.runqemu_image(fileitem['name'], self.sel_kernel)
-                elif image_attr == 'deploy':
+                elif fileitem['action_attr'] == 'deploy':
                     self.builder.deploy_image(fileitem['name'])
 
     def table_selected_cb(self, tbutton, image):
@@ -445,14 +445,6 @@ class ImageDetailsPage (HobPage):
             label = ((self.kernel_detail.get_children()[0]).get_children()[0]).get_children()[0]
             label.set_markup(markup)
 
-    def row_activated_cb(self, table, model, path):
-        if not model:
-            return
-        iter = model.get_iter(path)
-        image_name = model[path][0]
-        if iter and model[path][2] == True:
-            self.builder.runqemu_image(image_name, self.sel_kernel)
-
     def create_bottom_buttons(self, buttonlist, image_name):
         # Create the buttons at the bottom
         created = False
@@ -536,7 +528,7 @@ class ImageDetailsPage (HobPage):
 
     def deploy_button_clicked_cb(self, button):
         if self.toggled_image:
-            if self.build_succeeded or self.num_toggled > 1:
+            if self.num_toggled > 1:
                 self.set_sensitive(False)
                 self.show_builded_images_dialog(None, "Deploy image")
                 self.set_sensitive(True)
-- 
1.7.5.4



