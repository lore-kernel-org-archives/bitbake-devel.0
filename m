Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SBEts-0001JU-Lj
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 01:32:08 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 23 Mar 2012 17:23:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="121096258"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.82])
	by orsmga001.jf.intel.com with ESMTP; 23 Mar 2012 17:23:09 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Mar 2012 17:23:01 -0700
Message-Id: <0873c2b5ad4810eb019ec860760b46c917dc6d68.1332545580.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332545580.git.josh@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
In-Reply-To: <cover.1332545580.git.josh@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
Subject: [PATCH 3/9] lib/bb/ui/crumbs/recipeselectionpage: add 'Build image' button per design
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
X-List-Received-Date: Sat, 24 Mar 2012 00:32:08 -0000

The design calls for the 'Build packages' button to be a secondary action
and a 'Build image' primary action to exist on the recipe selection page.

Fixes [YOCTO #2165]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/recipeselectionpage.py |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py b/lib/bb/ui/crumbs/recipeselectionpage.py
index 881b2ec..e77e79b 100755
--- a/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -151,11 +151,16 @@ class RecipeSelectionPage (HobPage):
         button_box = gtk.HBox(False, 6)
         self.box_group_area.pack_end(button_box, expand=False, fill=False)
 
-        self.build_packages_button = HobButton('Build packages')
-        self.build_packages_button.set_size_request(205, 49)
-        self.build_packages_button.set_tooltip_text("Build packages for customization")
-        self.build_packages_button.set_flags(gtk.CAN_DEFAULT)
-        self.build_packages_button.grab_default()
+        self.build_image_button = HobButton('Build image')
+        self.build_image_button.connect("clicked", self.build_image_clicked_cb)
+        button_box.pack_end(self.build_image_button, expand=False, fill=False)
+        self.build_image_button.set_size_request(205, 49)
+        self.build_image_button.set_tooltip_text("Build packages for customization")
+        self.build_image_button.set_flags(gtk.CAN_DEFAULT)
+        self.build_image_button.grab_default()
+        label = gtk.Label("or")
+        button_box.pack_end(label, expand=False, fill=False)
+        self.build_packages_button = HobAltButton('Build packages')
         self.build_packages_button.connect("clicked", self.build_packages_clicked_cb)
         button_box.pack_end(self.build_packages_button, expand=False, fill=False)
 
@@ -174,6 +179,9 @@ class RecipeSelectionPage (HobPage):
     def back_button_clicked_cb(self, button):
         self.builder.show_configuration()
 
+    def build_image_clicked_cb(self, button):
+        self.builder.build_image()
+
     def refresh_selection(self):
         self.builder.configuration.selected_image = self.recipe_model.get_selected_image()
         _, self.builder.configuration.selected_recipes = self.recipe_model.get_selected_recipes()
-- 
1.7.7.6



