Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SAXcm-0000N8-0t
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 03:19:36 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 21 Mar 2012 19:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="131778620"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.222])
	by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2012 19:10:38 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 19:10:32 -0700
Message-Id: <c8a291fb07130e4fb08ea19f5b40b5c3bced4ecc.1332381654.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332381654.git.josh@linux.intel.com>
References: <cover.1332381654.git.josh@linux.intel.com>
In-Reply-To: <cover.1332381654.git.josh@linux.intel.com>
References: <cover.1332381654.git.josh@linux.intel.com>
Subject: [PATCH 07/10] lib/bb/ui/crumbs: replace HobXpmLabelButtonBox with HobImageButton
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
X-List-Received-Date: Thu, 22 Mar 2012 02:19:38 -0000

HobImageButton is an HobAltButton subclass, and therefore behaves like a
button.

Further the HobImageButton uses a new module method soften_color() to make
the secondary text of the button a ligher colour, per the design.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobwidget.py              |  103 ++++++++++++---------------
 lib/bb/ui/crumbs/imageconfigurationpage.py |   41 +++++------
 2 files changed, 65 insertions(+), 79 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index 189ffb4..df3f607 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -171,6 +171,27 @@ class HobViewTable (gtk.VBox):
         if not view_column.get_title() in self.toggle_columns:
             self.emit("row-activated", tree.get_model(), path)
 
+"""
+A method to calculate a softened value for the colour of widget when in the
+provided state.
+
+widget: the widget whose style to use
+state: the state of the widget to use the style for
+
+Returns a string value representing the softened colour
+"""
+def soften_color(widget, state=gtk.STATE_NORMAL):
+    # this colour munging routine is heavily inspired bu gdu_util_get_mix_color()
+    # from gnome-disk-utility:
+    # http://git.gnome.org/browse/gnome-disk-utility/tree/src/gdu-gtk/gdu-gtk.c?h=gnome-3-0
+    blend = 0.5
+    style = widget.get_style()
+    color = style.text[state]
+    color.red = color.red * blend + style.base[state].red * (1.0 - blend)
+    color.green = color.green * blend + style.base[state].green * (1.0 - blend)
+    color.blue = color.blue * blend + style.base[state].blue * (1.0 - blend)
+    return color.to_string()
+
 class HobAltButton(gtk.Button):
     """
     A gtk.Button subclass which has no relief, and so is more discrete
@@ -179,64 +200,32 @@ class HobAltButton(gtk.Button):
         gtk.Button.__init__(self, label)
         self.set_relief(gtk.RELIEF_NONE)
 
-class HobXpmLabelButtonBox(gtk.EventBox):
-    """ label: name of buttonbox
-        description: the simple  description
+class HobImageButton(HobAltButton):
     """
-    def __init__(self, display_file="", hover_file="", label="", description=""):
-        gtk.EventBox.__init__(self)
-        self._base_state_flags = gtk.STATE_NORMAL
-        self.set_events(gtk.gdk.MOTION_NOTIFY | gtk.gdk.BUTTON_PRESS | gtk.gdk.EXPOSE)
-
-        self.connect("expose-event", self.cb)
-        self.connect("enter-notify-event", self.pointer_enter_cb)
-        self.connect("leave-notify-event", self.pointer_leave_cb)
-
-        self.icon_hover = gtk.Image()
-        self.icon_hover.set_name("icon_image")
-        if type(hover_file) == str:
-            pixbuf = gtk.gdk.pixbuf_new_from_file(hover_file)
-            self.icon_hover.set_from_pixbuf(pixbuf)
-
-        self.icon_display = gtk.Image()
-        self.icon_display.set_name("icon_image")
-        if type(display_file) == str:
-            pixbuf = gtk.gdk.pixbuf_new_from_file(display_file)
-            self.icon_display.set_from_pixbuf(pixbuf)
-
-        self.tb = gtk.Table(2, 10, True)
-        self.tb.set_row_spacing(1, False)
-        self.tb.set_col_spacing(1, False)
-        self.add(self.tb)
-        self.tb.attach(self.icon_display, 0, 2, 0, 2, 0, 0)
-        self.tb.attach(self.icon_hover, 0, 2, 0, 2, 0, 0)
-
-        lbl = gtk.Label()
-        lbl.set_alignment(0.0, 0.5)
-        lbl.set_markup("<span foreground=\'#1C1C1C\' font_desc=\'18px\'>%s</span>" % label)
-        self.tb.attach(lbl, 2, 10, 0, 1)
-
-        lbl = gtk.Label()
-        lbl.set_alignment(0.0, 0.5)
-        lbl.set_markup("<span foreground=\'#1C1C1C\' font_desc=\'14px\'>%s</span>" % description)
-        self.tb.attach(lbl, 2, 10, 1, 2)
-
-    def pointer_enter_cb(self, *args):
-        #if not self.is_focus():
-        self.set_state(gtk.STATE_PRELIGHT)
-        self._base_state_flags = gtk.STATE_PRELIGHT
-        self.icon_hover.show()
-        self.icon_display.hide()
-
-    def pointer_leave_cb(self, *args):
-        self.set_state(gtk.STATE_NORMAL)
-        self._base_state_flags = gtk.STATE_NORMAL
-        self.icon_display.show()
-        self.icon_hover.hide()
-
-    def cb(self, w,e):
-        """ Hide items - first time """
-        pass
+    A HobAltButton with an icon and two rows of text, the second of which is
+    displayed in a blended colour.
+
+    primary_text: the main button label
+    secondary_text: optional second line of text
+    icon_path: path to the icon file to display on the button
+    """
+    def __init__(self, primary_text, secondary_text="", icon_path=""):
+        HobAltButton.__init__(self)
+        hbox = gtk.HBox(False, 3)
+        hbox.show()
+        self.add(hbox)
+        ic = gtk.Image()
+        ic.set_from_file(icon_path)
+        ic.set_alignment(0.5, 0.0)
+        ic.show()
+        hbox.pack_start(ic, False, False, 0)
+        label = gtk.Label()
+        label.set_alignment(0.0, 0.5)
+        colour = soften_color(label)
+        mark = "%s\n<span fgcolor='%s'><small>%s</small></span>" % (primary_text, colour, secondary_text)
+        label.set_markup(mark)
+        label.show()
+        hbox.pack_start(label, True, True, 0)
 
 class HobInfoButton(gtk.EventBox):
     """
diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index f327be2..408fde6 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -24,7 +24,7 @@ import gtk
 import glib
 from bb.ui.crumbs.progressbar import HobProgressBar
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobwidget import hic, HobXpmLabelButtonBox, HobInfoButton, HobAltButton
+from bb.ui.crumbs.hobwidget import hic, HobImageButton, HobInfoButton, HobAltButton
 from bb.ui.crumbs.hoblistmodel import RecipeListModel
 from bb.ui.crumbs.hobpages import HobPage
 
@@ -137,11 +137,10 @@ class ImageConfigurationPage (HobPage):
         self.machine_combo = gtk.combo_box_new_text()
         self.machine_combo.connect("changed", self.machine_combo_changed_cb)
 
-        icon_file = hic.ICON_LAYERS_DISPLAY_FILE
-        hover_file = hic.ICON_LAYERS_HOVER_FILE
-        self.layer_button = HobXpmLabelButtonBox(icon_file, hover_file,
-            "Layers", "Add support for machines, software, etc")
-        self.layer_button.connect("button-release-event", self.layer_button_clicked_cb)
+        self.layer_button = HobImageButton("Layers",
+                            "Add support for machines, software, etc.",
+                            icon_path=hic.ICON_LAYERS_DISPLAY_FILE)
+        self.layer_button.connect("clicked", self.layer_button_clicked_cb)
 
         markup = "Layers are a powerful mechanism to extend the Yocto Project "
         markup += "with your own functionality.\n"
@@ -162,9 +161,9 @@ class ImageConfigurationPage (HobPage):
     def set_config_machine_layout(self, show_progress_bar = False):
         self.gtable.attach(self.machine_title, 0, 40, 0, 4)
         self.gtable.attach(self.machine_title_desc, 0, 40, 4, 6)
-        self.gtable.attach(self.machine_combo, 0, 12, 6, 9)
-        self.gtable.attach(self.layer_button, 12, 36, 6, 10)
-        self.gtable.attach(self.layer_info_icon, 36, 40, 6, 9)
+        self.gtable.attach(self.machine_combo, 0, 12, 7, 10)
+        self.gtable.attach(self.layer_button, 12, 36, 6, 11)
+        self.gtable.attach(self.layer_info_icon, 36, 40, 6, 11)
         if show_progress_bar == True:
             self.gtable.attach(self.progress_box, 0, 40, 13, 17)
         self.gtable.attach(self.machine_separator, 0, 40, 12, 13)
@@ -186,22 +185,20 @@ class ImageConfigurationPage (HobPage):
         self.image_combo_id = self.image_combo.connect("changed", self.image_combo_changed_cb)
 
         self.image_desc = gtk.Label()
-        self.image_desc.set_alignment(0, 0)
+        self.image_desc.set_alignment(0, 0.5)
         self.image_desc.set_line_wrap(True)
 
         # button to view recipes
-        icon_file = hic.ICON_RCIPE_DISPLAY_FILE
-        hover_file = hic.ICON_RCIPE_HOVER_FILE
-        self.view_recipes_button = HobXpmLabelButtonBox(icon_file, hover_file,
-            "View Recipes", "Add/remove recipes and collections")
-        self.view_recipes_button.connect("button-release-event", self.view_recipes_button_clicked_cb)
+        self.view_recipes_button = HobImageButton("View Recipes",
+                                    "Add/remove recipes and collections",
+                                    icon_path=hic.ICON_RCIPE_DISPLAY_FILE)
+        self.view_recipes_button.connect("clicked", self.view_recipes_button_clicked_cb)
 
         # button to view packages
-        icon_file = hic.ICON_PACKAGES_DISPLAY_FILE
-        hover_file = hic.ICON_PACKAGES_HOVER_FILE
-        self.view_packages_button = HobXpmLabelButtonBox(icon_file, hover_file,
-            "View Packages", "Add/remove packages")
-        self.view_packages_button.connect("button-release-event", self.view_packages_button_clicked_cb)
+        self.view_packages_button = HobImageButton("View Packages",
+                                        "Add/remove packages",
+                                        icon_path=hic.ICON_PACKAGES_DISPLAY_FILE)
+        self.view_packages_button.connect("clicked", self.view_packages_button_clicked_cb)
 
         self.image_separator = gtk.HSeparator()
 
@@ -213,8 +210,8 @@ class ImageConfigurationPage (HobPage):
         self.gtable.attach(self.image_separator, 0, 40, 35, 36)
 
     def set_rcppkg_layout(self):
-        self.gtable.attach(self.view_recipes_button, 0, 20, 28, 32)
-        self.gtable.attach(self.view_packages_button, 20, 40, 28, 32)
+        self.gtable.attach(self.view_recipes_button, 0, 20, 27, 32)
+        self.gtable.attach(self.view_packages_button, 20, 40, 27, 32)
 
     def create_config_build_button(self):
         # Create the "Build packages" and "Just bake" buttons at the bottom
-- 
1.7.7.6



