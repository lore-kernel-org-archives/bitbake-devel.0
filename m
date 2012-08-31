Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1T7S6z-0001VD-Fm
	for bitbake-devel@lists.openembedded.org;
	Fri, 31 Aug 2012 16:22:17 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 31 Aug 2012 07:09:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,347,1344236400"; d="scan'208";a="194155621"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by orsmga002.jf.intel.com with ESMTP; 31 Aug 2012 07:09:58 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Aug 2012 17:10:11 +0300
Message-Id: <1346422211-11966-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/recipe&packageselectionpage: Change "Back" button to "Cancel" button
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
X-List-Received-Date: Fri, 31 Aug 2012 14:22:17 -0000

"Back" button placed on RecipeSelectionPage and PackageSelectionPage
was changed to "Cancel" button to avoid any confusion.
Also, it was placed next to the other buttons on the page.

[YOCTO #3012]

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    7 +++----
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |    4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 3576ed5..ce05f9b 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -157,9 +157,9 @@ class PackageSelectionPage (HobPage):
         self.build_image_button.connect("clicked", self.build_image_clicked_cb)
         self.button_box.pack_end(self.build_image_button, expand=False, fill=False)
 
-        self.back_button = HobAltButton('<< Back')
+        self.back_button = HobAltButton('Cancel')
         self.back_button.connect("clicked", self.back_button_clicked_cb)
-        self.button_box.pack_start(self.back_button, expand=False, fill=False)
+        self.button_box.pack_end(self.back_button, expand=False, fill=False)
 
     def button_click_cb(self, widget, event):
         path, col = widget.table_tree.get_cursor()
@@ -178,14 +178,13 @@ class PackageSelectionPage (HobPage):
         for child in children:
             self.button_box.remove(child)
         # re-packed the buttons as request, add the 'view log' button if build success
-        self.button_box.pack_start(self.back_button, expand=False, fill=False)
         self.button_box.pack_end(self.build_image_button, expand=False, fill=False)
         if log_file:
             view_log_button = HobAltButton("View log")
             view_log_button.connect("clicked", self.view_log_clicked_cb, log_file)
             view_log_button.set_tooltip_text("Open the building log files")
             self.button_box.pack_end(view_log_button, expand=False, fill=False)
-
+        self.button_box.pack_end(self.back_button, expand=False, fill=False)
         self.show_all()
 
     def build_image_clicked_cb(self, button):
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index d8e71b0..1869007 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -184,9 +184,9 @@ class RecipeSelectionPage (HobPage):
         self.build_packages_button.connect("clicked", self.build_packages_clicked_cb)
         button_box.pack_end(self.build_packages_button, expand=False, fill=False)
 
-        self.back_button = HobAltButton('<< Back')
+        self.back_button = HobAltButton('Cancel')
         self.back_button.connect("clicked", self.back_button_clicked_cb)
-        button_box.pack_start(self.back_button, expand=False, fill=False)
+        button_box.pack_end(self.back_button, expand=False, fill=False)
 
     def button_click_cb(self, widget, event):
         path, col = widget.table_tree.get_cursor()
-- 
1.7.9.5



