Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <constantinx.musca@intel.com>) id 1TF1Y4-0006lw-1L
	for bitbake-devel@lists.openembedded.org;
	Fri, 21 Sep 2012 13:37:32 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 21 Sep 2012 04:23:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,462,1344236400"; d="scan'208";a="224846546"
Received: from costin-desktop (HELO localhost.localdomain) ([10.237.105.66])
	by fmsmga001.fm.intel.com with ESMTP; 21 Sep 2012 04:23:19 -0700
From: Constantin Musca <constantinx.musca@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 21 Sep 2012 13:28:43 +0300
Message-Id: <1348223323-22195-1-git-send-email-constantinx.musca@intel.com>
X-Mailer: git-send-email 1.7.9.5
Cc: Constantin Musca <constantinx.musca@intel.com>
Subject: [PATCH] hob: The title of the packages screen depends on the screen you arrive from
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
X-List-Received-Date: Fri, 21 Sep 2012 11:37:32 -0000

- If you arrive to the packages screen from the recipes screen, the title
should say: 'Step 2 of 2: Edit packages'
- If you arrive to the packages screen from the image details screen, the
title should say: 'Edit packages'
- The title of the recipes screen should say 'Step 1 of 2: Edit recipes'

[YOCTO #2982]

Signed-off-by: Constantin Musca <constantinx.musca@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py             |    2 ++
 bitbake/lib/bb/ui/crumbs/hobpages.py            |    9 ++++++---
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py |    2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 9e9d040..0a551ff 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -653,6 +653,7 @@ class Builder(gtk.Window):
 
         elif next_step == self.PACKAGE_SELECTION:
             self.configuration.initial_selected_packages = self.configuration.selected_packages
+            self.package_details_page.set_title("Edit packages")
             if self.recipe_model.get_selected_image() == self.recipe_model.__custom_image__:
                 self.package_details_page.set_packages_curr_tab(self.package_details_page.ALL)
             else:
@@ -665,6 +666,7 @@ class Builder(gtk.Window):
             self.build_details_page.show_page(next_step)
 
         elif next_step == self.PACKAGE_GENERATED:
+            self.package_details_page.set_title("Step 2 of 2: Edit packages")
             if self.recipe_model.get_selected_image() == self.recipe_model.__custom_image__:
                 self.package_details_page.set_packages_curr_tab(self.package_details_page.ALL)
             else:
diff --git a/bitbake/lib/bb/ui/crumbs/hobpages.py b/bitbake/lib/bb/ui/crumbs/hobpages.py
index 5045ea2..5b49764 100755
--- a/bitbake/lib/bb/ui/crumbs/hobpages.py
+++ b/bitbake/lib/bb/ui/crumbs/hobpages.py
@@ -38,6 +38,7 @@ class HobPage (gtk.VBox):
             self.title = "Hob -- Image Creator"
         else:
             self.title = title
+        self.title_label = gtk.Label()
 
         self.box_group_area = gtk.VBox(False, 12)
         self.box_group_area.set_size_request(self.builder_width - 73 - 73, self.builder_height - 88 - 15 - 15)
@@ -46,6 +47,9 @@ class HobPage (gtk.VBox):
         self.group_align.add(self.box_group_area)
         self.box_group_area.set_homogeneous(False)
 
+    def set_title(self, title):
+        self.title = title
+        self.title_label.set_markup("<span size='x-large'>%s</span>" % self.title)
 
     def add_onto_top_bar(self, widget = None, padding = 0):
         # the top button occupies 1/7 of the page height
@@ -58,9 +62,8 @@ class HobPage (gtk.VBox):
 
         hbox = gtk.HBox()
 
-        label = gtk.Label()
-        label.set_markup("<span size='x-large'>%s</span>" % self.title)
-        hbox.pack_start(label, expand=False, fill=False, padding=20)
+        self.title_label.set_markup("<span size='x-large'>%s</span>" % self.title)
+        hbox.pack_start(self.title_label, expand=False, fill=False, padding=20)
 
         if widget:
             # add the widget in the event box
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index 0b159bb..f252202 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -123,7 +123,7 @@ class RecipeSelectionPage (HobPage):
      TASKS) = range(3)
 
     def __init__(self, builder = None):
-        super(RecipeSelectionPage, self).__init__(builder, "Edit recipes")
+        super(RecipeSelectionPage, self).__init__(builder, "Step 1 of 2: Edit recipes")
 
         # set invisible members
         self.recipe_model = self.builder.recipe_model
-- 
1.7.9.5



