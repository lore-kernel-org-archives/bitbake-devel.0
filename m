Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SDNy9-0002EZ-U5
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 Mar 2012 00:37:26 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 29 Mar 2012 15:28:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="123312764"
Received: from unknown (HELO shamshir.jf.intel.com) ([10.7.198.148])
	by orsmga001.jf.intel.com with ESMTP; 29 Mar 2012 15:28:13 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 15:28:08 -0700
Message-Id: <07b997d8891a60c912b9575923fd51470e230d34.1333060005.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1333060005.git.josh@linux.intel.com>
References: <cover.1333060005.git.josh@linux.intel.com>
In-Reply-To: <cover.1333060005.git.josh@linux.intel.com>
References: <cover.1333060005.git.josh@linux.intel.com>
Subject: [PATCH 1/3] Hob: tweak font sizes and layout
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
X-List-Received-Date: Thu, 29 Mar 2012 22:37:26 -0000

Switch to proportional font sizes and tweak padding and layout based on
feedback from design team.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobpages.py               |    6 ++--
 lib/bb/ui/crumbs/hobwidget.py              |    8 +++---
 lib/bb/ui/crumbs/imageconfigurationpage.py |   36 ++++++++++++++--------------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobpages.py b/lib/bb/ui/crumbs/hobpages.py
index 8ea39e7..024737d 100755
--- a/lib/bb/ui/crumbs/hobpages.py
+++ b/lib/bb/ui/crumbs/hobpages.py
@@ -59,7 +59,7 @@ class HobPage (gtk.VBox):
         hbox = gtk.HBox()
 
         label = gtk.Label()
-        label.set_markup("<span font_desc=\'14\'>%s</span>" % self.title)
+        label.set_markup("<span size='x-large'>%s</span>" % self.title)
         hbox.pack_start(label, expand=False, fill=False, padding=20)
 
         if widget:
@@ -69,8 +69,8 @@ class HobPage (gtk.VBox):
 
         return eventbox
 
-    def span_tag(self, px="12px", weight="normal", forground="#1c1c1c"):
-        span_tag = "weight=\'%s\' foreground=\'%s\' font_desc=\'%s\'" % (weight, forground, px)
+    def span_tag(self, size="medium", weight="normal", forground="#1c1c1c"):
+        span_tag = "weight='%s' foreground='%s' size='%s'" % (weight, forground, size)
         return span_tag
 
     def append_toolbar_button(self, toolbar, buttonname, icon_disp, icon_hovor, tip, cb):
diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index bcc44cc..9625c6d 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -254,7 +254,7 @@ class HobAltButton(gtk.Button):
             colour = HobColors.PALE_BLUE
         else:
             colour = HobColors.LIGHT_GRAY
-        button.set_label("<span color='%s'><b>%s</b></span>" % (colour, gobject.markup_escape_text(button.text)))
+        button.set_label("<span size='large' color='%s'><b>%s</b></span>" % (colour, gobject.markup_escape_text(button.text)))
         button.child.set_use_markup(True)
 
     @staticmethod
@@ -281,7 +281,7 @@ class HobImageButton(gtk.Button):
         self.icon_path = icon_path
         self.hover_icon_path = hover_icon_path
 
-        hbox = gtk.HBox(False, 6)
+        hbox = gtk.HBox(False, 10)
         hbox.show()
         self.add(hbox)
         self.icon = gtk.Image()
@@ -295,10 +295,10 @@ class HobImageButton(gtk.Button):
         label = gtk.Label()
         label.set_alignment(0.0, 0.5)
         colour = soften_color(label)
-        mark = "<span size='larger'>%s</span>\n<span fgcolor='%s'>%s</span>" % (primary_text, colour, secondary_text)
+        mark = "<span size='x-large'>%s</span>\n<span size='medium' fgcolor='%s' weight='ultralight'>%s</span>" % (primary_text, colour, secondary_text)
         label.set_markup(mark)
         label.show()
-        hbox.pack_start(label, True, True, 6)
+        hbox.pack_start(label, True, True, 0)
 
     def set_hover_icon_cb(self, widget, event):
         self.icon.set_from_file(self.hover_icon_path)
diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index 8914b1c..30f8979 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -133,13 +133,13 @@ class ImageConfigurationPage (HobPage):
     def create_config_machine(self):
         self.machine_title = gtk.Label()
         self.machine_title.set_alignment(0.0, 0.5)
-        mark = "<span %s>Select a machine</span>" % self.span_tag('24px', 'bold')
+        mark = "<span %s>Select a machine</span>" % self.span_tag('x-large', 'bold')
         self.machine_title.set_markup(mark)
 
         self.machine_title_desc = gtk.Label()
-        self.machine_title_desc.set_alignment(0, 0.5)
+        self.machine_title_desc.set_alignment(0.0, 0.5)
         mark = ("<span %s>This is the profile of the target machine for which you"
-        " are building the image.\n</span>") % (self.span_tag(px='14px'))
+        " are building the image.\n</span>") % (self.span_tag('medium'))
         self.machine_title_desc.set_markup(mark)
 
         self.machine_combo = gtk.combo_box_new_text()
@@ -170,31 +170,31 @@ class ImageConfigurationPage (HobPage):
     def set_config_machine_layout(self, show_progress_bar = False):
         self.gtable.attach(self.machine_title, 0, 40, 0, 4)
         self.gtable.attach(self.machine_title_desc, 0, 40, 4, 6)
-        self.gtable.attach(self.machine_combo, 0, 12, 6, 9)
-        self.gtable.attach(self.layer_button, 15, 36, 6, 11)
-        self.gtable.attach(self.layer_info_icon, 36, 40, 6, 10)
+        self.gtable.attach(self.machine_combo, 0, 12, 7, 10)
+        self.gtable.attach(self.layer_button, 14, 36, 7, 12)
+        self.gtable.attach(self.layer_info_icon, 36, 40, 7, 11)
         if show_progress_bar:
-            self.gtable.attach(self.progress_box, 0, 40, 13, 17)
-        self.gtable.attach(self.machine_separator, 0, 40, 12, 13)
+            self.gtable.attach(self.progress_box, 0, 40, 15, 19)
+        self.gtable.attach(self.machine_separator, 0, 40, 13, 14)
 
     def create_config_baseimg(self):
         self.image_title = gtk.Label()
         self.image_title.set_alignment(0, 1.0)
-        mark = "<span %s>Select a base image</span>" % self.span_tag('24px', 'bold')
+        mark = "<span %s>Select a base image</span>" % self.span_tag('x-large', 'bold')
         self.image_title.set_markup(mark)
 
         self.image_title_desc = gtk.Label()
         self.image_title_desc.set_alignment(0, 0.5)
         mark = ("<span %s>Base images are a starting point for the type of image you want. "
                 "You can build them as \n"
-                "they are or customize them to your specific needs.\n</span>") % self.span_tag('14px')
+                "they are or customize them to your specific needs.\n</span>") % self.span_tag('medium')
         self.image_title_desc.set_markup(mark)
 
         self.image_combo = gtk.combo_box_new_text()
         self.image_combo_id = self.image_combo.connect("changed", self.image_combo_changed_cb)
 
         self.image_desc = gtk.Label()
-        self.image_desc.set_alignment(0, 0.5)
+        self.image_desc.set_alignment(0.0, 0.5)
         self.image_desc.set_line_wrap(True)
 
         # button to view recipes
@@ -216,15 +216,15 @@ class ImageConfigurationPage (HobPage):
         self.image_separator = gtk.HSeparator()
 
     def set_config_baseimg_layout(self):
-        self.gtable.attach(self.image_title, 0, 40, 13, 17)
-        self.gtable.attach(self.image_title_desc, 0, 40, 18, 23)
-        self.gtable.attach(self.image_combo, 0, 12, 24, 27)
-        self.gtable.attach(self.image_desc, 14, 38, 24, 29)
+        self.gtable.attach(self.image_title, 0, 40, 15, 17)
+        self.gtable.attach(self.image_title_desc, 0, 40, 18, 22)
+        self.gtable.attach(self.image_combo, 0, 12, 23, 26)
+        self.gtable.attach(self.image_desc, 13, 38, 23, 28)
         self.gtable.attach(self.image_separator, 0, 40, 35, 36)
 
     def set_rcppkg_layout(self):
-        self.gtable.attach(self.view_recipes_button, 0, 20, 30, 35)
-        self.gtable.attach(self.view_packages_button, 20, 40, 30, 35)
+        self.gtable.attach(self.view_recipes_button, 0, 20, 28, 33)
+        self.gtable.attach(self.view_packages_button, 20, 40, 28, 33)
 
     def create_config_build_button(self):
         # Create the "Build packages" and "Build image" buttons at the bottom
@@ -295,7 +295,7 @@ class ImageConfigurationPage (HobPage):
         image_iter = self.builder.recipe_model.get_iter(image_path)
         selected_packages = self.builder.recipe_model.get_value(image_iter, self.builder.recipe_model.COL_INSTALL).split()
 
-        mark = ("<span %s>%s</span>\n") % (self.span_tag('14px'), self.builder.recipe_model.get_value(image_iter, self.builder.recipe_model.COL_DESC))
+        mark = ("<span %s>%s</span>\n") % (self.span_tag('small'), self.builder.recipe_model.get_value(image_iter, self.builder.recipe_model.COL_DESC))
         self.image_desc.set_markup(mark)
 
         self.builder.recipe_model.reset()
-- 
1.7.7.6



