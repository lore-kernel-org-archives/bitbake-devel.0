Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristian.iorga@intel.com>) id 1Si6NE-0006kD-HF
	for bitbake-devel@lists.openembedded.org;
	Fri, 22 Jun 2012 18:06:16 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 22 Jun 2012 08:54:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="115071680"
Received: from sentry (HELO localhost.localdomain) ([10.237.105.53])
	by AZSMGA002.ch.intel.com with ESMTP; 22 Jun 2012 08:54:22 -0700
From: Cristian Iorga <cristian.iorga@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Jun 2012 18:54:47 +0300
Message-Id: <1340380487-20446-1-git-send-email-cristian.iorga@intel.com>
X-Mailer: git-send-email 1.7.9.5
X-Mailman-Approved-At: Thu, 28 Jun 2012 11:02:45 +0200
Subject: [PATCH] Fix for Hob bug #2323
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
X-List-Received-Date: Fri, 22 Jun 2012 16:06:16 -0000

Removed unnecessary button from Recipes screen and
replaced the button that diplayed packages size and total image size
from Packages screen with a label.

Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>
---
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    7 ++-----
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |    9 ++-------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 9895835..1b832eb 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -113,15 +113,12 @@ class PackageSelectionPage (HobPage):
         self.ins.set_current_page(0)
 
     def create_visual_elements(self):
-        self.label = gtk.Button("Packages included: 0\nSelected packages size: 0 MB")
-        self.label.set_can_default(False)
-        self.label.set_relief(gtk.RELIEF_HALF)
-        self.label.connect("clicked", self.included_clicked_cb)
+        self.label = gtk.Label("Packages included: 0\nSelected packages size: 0 MB")
         self.eventbox = self.add_onto_top_bar(self.label, 73)
         self.pack_start(self.eventbox, expand=False, fill=False)
         self.pack_start(self.group_align, expand=True, fill=True)
 
-        # set visiable members
+        # set visible members
         self.ins = HobNotebook()
         self.tables = [] # we need to modify table when the dialog is shown
         # append the tab
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index ece37e0..af68f2a 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -138,15 +138,11 @@ class RecipeSelectionPage (HobPage):
         self.ins.set_current_page(0)
 
     def create_visual_elements(self):
-        self.label = gtk.Button('Recipes included: 0')
-        self.label.set_can_default(False)
-        self.label.set_relief(gtk.RELIEF_HALF)
-        self.label.connect("clicked", self.included_clicked_cb)
-        self.eventbox = self.add_onto_top_bar(self.label, 73)
+        self.eventbox = self.add_onto_top_bar(None, 73)
         self.pack_start(self.eventbox, expand=False, fill=False)
         self.pack_start(self.group_align, expand=True, fill=True)
 
-        # set visiable members
+        # set visible members
         self.ins = HobNotebook()
         self.tables = [] # we need modify table when the dialog is shown
         # append the tabs in order
@@ -205,7 +201,6 @@ class RecipeSelectionPage (HobPage):
     def refresh_selection(self):
         self.builder.configuration.selected_image = self.recipe_model.get_selected_image()
         _, self.builder.configuration.selected_recipes = self.recipe_model.get_selected_recipes()
-        self.label.set_label("Recipes included: %s" % len(self.builder.configuration.selected_recipes))
         self.ins.show_indicator_icon("Included", len(self.builder.configuration.selected_recipes))
 
     def toggle_item_idle_cb(self, path, view_tree, cell, pagename):
-- 
1.7.9.5



