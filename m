Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SArc6-0001ys-PD
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Mar 2012 00:40:15 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 22 Mar 2012 16:31:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="124076806"
Received: from unknown (HELO shamshir.jf.intel.com) ([10.7.198.147])
	by orsmga002.jf.intel.com with ESMTP; 22 Mar 2012 16:31:16 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 22 Mar 2012 16:31:07 -0700
Message-Id: <c2c3fe31507838c9ac49ff0bd628b8d7d459722f.1332458487.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332458487.git.josh@linux.intel.com>
References: <cover.1332458487.git.josh@linux.intel.com>
In-Reply-To: <cover.1332458487.git.josh@linux.intel.com>
References: <cover.1332458487.git.josh@linux.intel.com>
Subject: [PATCH 2/9] lib/bb/ui/crumbs: replace HobXpmLabelButtonBox with HobImageButton
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
X-List-Received-Date: Thu, 22 Mar 2012 23:40:15 -0000

HobImageButton is an gtk.Button subclass, and therefore behaves like a
button with prelight and focus states, with an icon and two lines of text -
primary and secondary. The secondary text is displayed in a lighter colour
using a new module method, soften_color(), per the design.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobwidget.py              |  123 ++++++++++++++-------------
 lib/bb/ui/crumbs/imageconfigurationpage.py |   40 +++++----
 2 files changed, 85 insertions(+), 78 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index 9d00023..e8549a1 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -53,8 +53,10 @@ class hic:
     ICON_INFO_HOVER_FILE          = os.path.join(HOB_ICON_BASE_DIR, ('info/info_hover.png'))
     ICON_INDI_CONFIRM_FILE        = os.path.join(HOB_ICON_BASE_DIR, ('indicators/confirmation.png'))
     ICON_INDI_ERROR_FILE          = os.path.join(HOB_ICON_BASE_DIR, ('indicators/error.png'))
-    ICON_INDI_REMOVE              = os.path.join(HOB_ICON_BASE_DIR, ('indicators/remove.png'))
-    ICON_INDI_ADD                 = os.path.join(HOB_ICON_BASE_DIR, ('indicators/add.png'))
+    ICON_INDI_REMOVE_FILE         = os.path.join(HOB_ICON_BASE_DIR, ('indicators/remove.png'))
+    ICON_INDI_REMOVE_HOVER_FILE   = os.path.join(HOB_ICON_BASE_DIR, ('indicators/remove-hover.png'))
+    ICON_INDI_ADD_FILE            = os.path.join(HOB_ICON_BASE_DIR, ('indicators/add.png'))
+    ICON_INDI_ADD_HOVER_FILE      = os.path.join(HOB_ICON_BASE_DIR, ('indicators/add-hover.png'))
 
 class hcc:
 
@@ -173,6 +175,27 @@ class HobViewTable (gtk.VBox):
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
+    blend = 0.7
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
@@ -181,64 +204,46 @@ class HobAltButton(gtk.Button):
         gtk.Button.__init__(self, label)
         self.set_relief(gtk.RELIEF_NONE)
 
-class HobXpmLabelButtonBox(gtk.EventBox):
-    """ label: name of buttonbox
-        description: the simple  description
+class HobImageButton(gtk.Button):
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
+    A gtk.Button with an icon and two rows of text, the second of which is
+    displayed in a blended colour.
+
+    primary_text: the main button label
+    secondary_text: optional second line of text
+    icon_path: path to the icon file to display on the button
+    """
+    def __init__(self, primary_text, secondary_text="", icon_path="", hover_icon_path=""):
+        gtk.Button.__init__(self)
+        self.set_relief(gtk.RELIEF_NONE)
+
+        self.icon_path = icon_path
+        self.hover_icon_path = hover_icon_path
+
+        hbox = gtk.HBox(False, 3)
+        hbox.show()
+        self.add(hbox)
+        self.icon = gtk.Image()
+        self.icon.set_from_file(self.icon_path)
+        self.icon.set_alignment(0.5, 0.0)
+        self.icon.show()
+        if self.hover_icon_path and len(self.hover_icon_path):
+            self.connect("enter-notify-event", self.set_hover_icon_cb)
+            self.connect("leave-notify-event", self.set_icon_cb)
+        hbox.pack_start(self.icon, False, False, 0)
+        label = gtk.Label()
+        label.set_alignment(0.0, 0.5)
+        colour = soften_color(label)
+        mark = "%s\n<span fgcolor='%s'><small>%s</small></span>" % (primary_text, colour, secondary_text)
+        label.set_markup(mark)
+        label.show()
+        hbox.pack_start(label, True, True, 0)
+
+    def set_hover_icon_cb(self, widget, event):
+        self.icon.set_from_file(self.hover_icon_path)
+
+    def set_icon_cb(self, widget, event):
+        self.icon.set_from_file(self.icon_path)
 
 class HobInfoButton(gtk.EventBox):
     """
diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index c358a97..836bd0a 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -24,7 +24,7 @@ import gtk
 import glib
 from bb.ui.crumbs.progressbar import HobProgressBar
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobwidget import hic, HobXpmLabelButtonBox, HobInfoButton, HobAltButton
+from bb.ui.crumbs.hobwidget import hic, HobImageButton, HobInfoButton, HobAltButton, HobButton
 from bb.ui.crumbs.hoblistmodel import RecipeListModel
 from bb.ui.crumbs.hobpages import HobPage
 
@@ -139,9 +139,9 @@ class ImageConfigurationPage (HobPage):
 
         icon_file = hic.ICON_LAYERS_DISPLAY_FILE
         hover_file = hic.ICON_LAYERS_HOVER_FILE
-        self.layer_button = HobXpmLabelButtonBox(icon_file, hover_file,
-            "Layers", "Add support for machines, software, etc")
-        self.layer_button.connect("button-release-event", self.layer_button_clicked_cb)
+        self.layer_button = HobImageButton("Layers", "Add support for machines, software, etc.",
+                                icon_file, hover_file)
+        self.layer_button.connect("clicked", self.layer_button_clicked_cb)
 
         markup = "Layers are a powerful mechanism to extend the Yocto Project "
         markup += "with your own functionality.\n"
@@ -163,9 +163,9 @@ class ImageConfigurationPage (HobPage):
         self.gtable.attach(self.machine_title, 0, 40, 0, 4)
         self.gtable.attach(self.machine_title_desc, 0, 40, 4, 6)
         self.gtable.attach(self.machine_combo, 0, 12, 6, 9)
-        self.gtable.attach(self.layer_button, 12, 36, 6, 10)
-        self.gtable.attach(self.layer_info_icon, 36, 40, 6, 9)
-        if show_progress_bar == True:
+        self.gtable.attach(self.layer_button, 12, 36, 6, 11)
+        self.gtable.attach(self.layer_info_icon, 36, 40, 6, 10)
+        if show_progress_bar:
             self.gtable.attach(self.progress_box, 0, 40, 13, 17)
         self.gtable.attach(self.machine_separator, 0, 40, 12, 13)
 
@@ -186,22 +186,24 @@ class ImageConfigurationPage (HobPage):
         self.image_combo_id = self.image_combo.connect("changed", self.image_combo_changed_cb)
 
         self.image_desc = gtk.Label()
-        self.image_desc.set_alignment(0, 0)
+        self.image_desc.set_alignment(0, 0.5)
         self.image_desc.set_line_wrap(True)
 
         # button to view recipes
         icon_file = hic.ICON_RCIPE_DISPLAY_FILE
         hover_file = hic.ICON_RCIPE_HOVER_FILE
-        self.view_recipes_button = HobXpmLabelButtonBox(icon_file, hover_file,
-            "View Recipes", "Add/remove recipes and collections")
-        self.view_recipes_button.connect("button-release-event", self.view_recipes_button_clicked_cb)
+        self.view_recipes_button = HobImageButton("View Recipes",
+                                        "Add/remove recipes and collections",
+                                        icon_file, hover_file)
+        self.view_recipes_button.connect("clicked", self.view_recipes_button_clicked_cb)
 
         # button to view packages
         icon_file = hic.ICON_PACKAGES_DISPLAY_FILE
         hover_file = hic.ICON_PACKAGES_HOVER_FILE
-        self.view_packages_button = HobXpmLabelButtonBox(icon_file, hover_file,
-            "View Packages", "Add/remove previously built packages to/from your image")
-        self.view_packages_button.connect("button-release-event", self.view_packages_button_clicked_cb)
+        self.view_packages_button = HobImageButton("View Packages",
+                                        "Add/remove previously built packages to/from your image",
+                                        icon_file, hover_file)
+        self.view_packages_button.connect("clicked", self.view_packages_button_clicked_cb)
 
         self.image_separator = gtk.HSeparator()
 
@@ -213,8 +215,8 @@ class ImageConfigurationPage (HobPage):
         self.gtable.attach(self.image_separator, 0, 40, 35, 36)
 
     def set_rcppkg_layout(self):
-        self.gtable.attach(self.view_recipes_button, 0, 18, 28, 32)
-        self.gtable.attach(self.view_packages_button, 18, 40, 28, 32)
+        self.gtable.attach(self.view_recipes_button, 0, 20, 27, 32)
+        self.gtable.attach(self.view_packages_button, 20, 40, 27, 32)
 
     def create_config_build_button(self):
         # Create the "Build packages" and "Just bake" buttons at the bottom
@@ -343,14 +345,14 @@ class ImageConfigurationPage (HobPage):
         self.image_combo.set_active(-1)
         self.image_combo.set_active(active)
 
-    def layer_button_clicked_cb(self, event, data):
+    def layer_button_clicked_cb(self, button):
         # Create a layer selection dialog
         self.builder.show_layer_selection_dialog()
 
-    def view_recipes_button_clicked_cb(self, event, data):
+    def view_recipes_button_clicked_cb(self, button):
         self.builder.show_recipes()
 
-    def view_packages_button_clicked_cb(self, event, data):
+    def view_packages_button_clicked_cb(self, button):
         self.builder.show_packages()
 
     def just_bake_button_clicked_cb(self, button):
-- 
1.7.7.6



