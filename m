Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S86Ex-0006BC-JF
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 09:40:55 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 15 Mar 2012 01:32:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="119200587"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 15 Mar 2012 01:32:03 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Mar 2012 16:29:54 +0800
Message-Id: <ac36d218ed6793d6fbf3edfadaf193629ea1e46d.1331796806.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1331796806.git.dongxiao.xu@intel.com>
References: <cover.1331796806.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1331796806.git.dongxiao.xu@intel.com>
References: <cover.1331796806.git.dongxiao.xu@intel.com>
Subject: [PATCH 06/12] Hob: Remove the indication in machine/base image combobox
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
X-List-Received-Date: Thu, 15 Mar 2012 08:40:55 -0000

Remove the "--select a machine--" prompt in machine selection.
Also change "--select a base image--" to "Start from scratch" for
base image selection.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hoblistmodel.py           |    2 +-
 lib/bb/ui/crumbs/imageconfigurationpage.py |   20 +++++++-------------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
index 0378828..c19aaa8 100644
--- a/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/lib/bb/ui/crumbs/hoblistmodel.py
@@ -422,7 +422,7 @@ class RecipeListModel(gtk.ListStore):
     """
     (COL_NAME, COL_DESC, COL_LIC, COL_GROUP, COL_DEPS, COL_BINB, COL_TYPE, COL_INC, COL_IMG, COL_INSTALL, COL_PN) = range(11)
 
-    __dummy_image__ = "--select a base image--"
+    __dummy_image__ = "Start from scratch"
 
     __gsignals__ = {
         "recipelist-populated" : (gobject.SIGNAL_RUN_LAST,
diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index f029bf8..3b1201e 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -33,8 +33,6 @@ from bb.ui.crumbs.hobpages import HobPage
 #
 class ImageConfigurationPage (HobPage):
 
-    __dummy_machine__ = "--select a machine--"
-
     def __init__(self, builder):
         super(ImageConfigurationPage, self).__init__(builder, "Image configuration")
 
@@ -236,22 +234,18 @@ class ImageConfigurationPage (HobPage):
 
     def machine_combo_changed_cb(self, machine_combo):
         combo_item = machine_combo.get_active_text()
-        if not combo_item or combo_item == self.__dummy_machine__:
-            self.builder.configuration.curr_mach = ""
-            self.builder.switch_page(self.builder.MACHINE_SELECTION)
-        else:
-            self.builder.configuration.curr_mach = combo_item
-            # Do reparse recipes
-            self.builder.switch_page(self.builder.RCPPKGINFO_POPULATING)
+        self.builder.configuration.curr_mach = combo_item
+        # Do reparse recipes
+        self.builder.switch_page(self.builder.RCPPKGINFO_POPULATING)
 
     def update_machine_combo(self):
-        all_machines = [self.__dummy_machine__] + self.builder.parameters.all_machines
+        all_machines = self.builder.parameters.all_machines
 
         model = self.machine_combo.get_model()
         model.clear()
         for machine in all_machines:
             self.machine_combo.append_text(machine)
-        self.machine_combo.set_active(0)
+        self.machine_combo.set_active(-1)
 
     def switch_machine_combo(self):
         model = self.machine_combo.get_model()
@@ -261,7 +255,7 @@ class ImageConfigurationPage (HobPage):
                 self.machine_combo.set_active(active)
                 return
             active += 1
-        self.machine_combo.set_active(0)
+        self.machine_combo.set_active(-1)
 
     def image_combo_changed_idle_cb(self, selected_image, selected_recipes, selected_packages):
         self.builder.update_recipe_model(selected_image, selected_recipes)
@@ -302,7 +296,7 @@ class ImageConfigurationPage (HobPage):
         # populate image combo
         filter = {RecipeListModel.COL_TYPE : ['image']}
         image_model = recipe_model.tree_model(filter)
-        active = 0
+        active = -1
         cnt = 0
 
         it = image_model.get_iter_first()
-- 
1.7.4.1



