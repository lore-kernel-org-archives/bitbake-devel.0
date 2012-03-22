Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SArcA-0001yz-Id
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Mar 2012 00:40:18 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 22 Mar 2012 16:31:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="124076812"
Received: from unknown (HELO shamshir.jf.intel.com) ([10.7.198.147])
	by orsmga002.jf.intel.com with ESMTP; 22 Mar 2012 16:31:16 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 22 Mar 2012 16:31:13 -0700
Message-Id: <e3d36acdee68f37cfd19cc6bb260434c6dc7597a.1332458487.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332458487.git.josh@linux.intel.com>
References: <cover.1332458487.git.josh@linux.intel.com>
In-Reply-To: <cover.1332458487.git.josh@linux.intel.com>
References: <cover.1332458487.git.josh@linux.intel.com>
Subject: [PATCH 8/9] lib/bb/ui/crumbs: make use of HobButton for existing primary action buttons
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
X-List-Received-Date: Thu, 22 Mar 2012 23:40:18 -0000

Replace all gtk.Button instances that have the orange style applied with
HobButton.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/imageconfigurationpage.py |   12 +-----------
 lib/bb/ui/crumbs/imagedetailspage.py       |   11 ++---------
 lib/bb/ui/crumbs/packageselectionpage.py   |   11 ++---------
 lib/bb/ui/crumbs/recipeselectionpage.py    |   11 ++---------
 4 files changed, 7 insertions(+), 38 deletions(-)

diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index 836bd0a..da758a3 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -223,19 +223,9 @@ class ImageConfigurationPage (HobPage):
         button_box = gtk.HBox(False, 6)
 
         # create button "Just bake"
-        just_bake_button = gtk.Button()
-        label = gtk.Label()
-        mark = "<span %s>Just bake</span>" % self.span_tag('24px', 'bold')
-        label.set_markup(mark)
-
-        just_bake_button.set_image(label)
+        just_bake_button = HobButton("Just bake")
         just_bake_button.set_size_request(205, 49)
-        just_bake_button.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(HobColors.ORANGE))
-        just_bake_button.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(HobColors.ORANGE))
-        just_bake_button.modify_bg(gtk.STATE_SELECTED, gtk.gdk.Color(HobColors.ORANGE))
         just_bake_button.set_tooltip_text("Build image to get your target image")
-        just_bake_button.set_flags(gtk.CAN_DEFAULT)
-        just_bake_button.grab_default()
         just_bake_button.connect("clicked", self.just_bake_button_clicked_cb)
         button_box.pack_end(just_bake_button, expand=False, fill=False)
 
diff --git a/lib/bb/ui/crumbs/imagedetailspage.py b/lib/bb/ui/crumbs/imagedetailspage.py
index 9213255..07a6eb0 100755
--- a/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/lib/bb/ui/crumbs/imagedetailspage.py
@@ -23,7 +23,7 @@
 import gobject
 import gtk
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobwidget import hic, HobViewTable, HobAltButton
+from bb.ui.crumbs.hobwidget import hic, HobViewTable, HobAltButton, HobButton
 from bb.ui.crumbs.hobpages import HobPage
 
 #
@@ -264,15 +264,8 @@ class ImageDetailsPage (HobPage):
         # create button "Deploy image"
         name = "Deploy image"
         if name in buttonlist:
-            deploy_button = gtk.Button()
-            label = gtk.Label()
-            mark = "<span %s>Deploy image</span>" % self.span_tag('24px', 'bold')
-            label.set_markup(mark)
-            deploy_button.set_image(label)
+            deploy_button = HobButton('Deploy image')
             deploy_button.set_size_request(205, 49)
-            deploy_button.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(HobColors.ORANGE))
-            deploy_button.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(HobColors.ORANGE))
-            deploy_button.modify_bg(gtk.STATE_SELECTED, gtk.gdk.Color(HobColors.ORANGE))
             deploy_button.set_tooltip_text("Deploy image to get your target board")
             deploy_button.set_flags(gtk.CAN_DEFAULT)
             deploy_button.grab_default()
diff --git a/lib/bb/ui/crumbs/packageselectionpage.py b/lib/bb/ui/crumbs/packageselectionpage.py
index cfec6d4..67ae5d1 100755
--- a/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/lib/bb/ui/crumbs/packageselectionpage.py
@@ -23,7 +23,7 @@
 import gtk
 import glib
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobwidget import HobViewTable, HobNotebook, HobAltButton
+from bb.ui.crumbs.hobwidget import HobViewTable, HobNotebook, HobAltButton, HobButton
 from bb.ui.crumbs.hoblistmodel import PackageListModel
 from bb.ui.crumbs.hobpages import HobPage
 
@@ -129,15 +129,8 @@ class PackageSelectionPage (HobPage):
         button_box = gtk.HBox(False, 6)
         self.box_group_area.pack_start(button_box, expand=False, fill=False)
 
-        self.build_image_button = gtk.Button()
-        label = gtk.Label()
-        mark = "<span %s>Build image</span>" % self.span_tag('24px', 'bold')
-        label.set_markup(mark)
-        self.build_image_button.set_image(label)
+        self.build_image_button = HobButton('Build image')
         self.build_image_button.set_size_request(205, 49)
-        self.build_image_button.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(HobColors.ORANGE))
-        self.build_image_button.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(HobColors.ORANGE))
-        self.build_image_button.modify_bg(gtk.STATE_SELECTED, gtk.gdk.Color(HobColors.ORANGE))
         self.build_image_button.set_tooltip_text("Build image to get your target image")
         self.build_image_button.set_flags(gtk.CAN_DEFAULT)
         self.build_image_button.grab_default()
diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py b/lib/bb/ui/crumbs/recipeselectionpage.py
index 348dfec..881b2ec 100755
--- a/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -23,7 +23,7 @@
 import gtk
 import glib
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobwidget import HobViewTable, HobNotebook, HobAltButton
+from bb.ui.crumbs.hobwidget import HobViewTable, HobNotebook, HobAltButton, HobButton
 from bb.ui.crumbs.hoblistmodel import RecipeListModel
 from bb.ui.crumbs.hobpages import HobPage
 
@@ -151,15 +151,8 @@ class RecipeSelectionPage (HobPage):
         button_box = gtk.HBox(False, 6)
         self.box_group_area.pack_end(button_box, expand=False, fill=False)
 
-        self.build_packages_button = gtk.Button()
-        label = gtk.Label()
-        mark = "<span %s>Build packages</span>" % self.span_tag('24px', 'bold')
-        label.set_markup(mark)
-        self.build_packages_button.set_image(label)
+        self.build_packages_button = HobButton('Build packages')
         self.build_packages_button.set_size_request(205, 49)
-        self.build_packages_button.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(HobColors.ORANGE))
-        self.build_packages_button.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(HobColors.ORANGE))
-        self.build_packages_button.modify_bg(gtk.STATE_SELECTED, gtk.gdk.Color(HobColors.ORANGE))
         self.build_packages_button.set_tooltip_text("Build packages for customization")
         self.build_packages_button.set_flags(gtk.CAN_DEFAULT)
         self.build_packages_button.grab_default()
-- 
1.7.7.6



