Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1U8qoT-0006W6-J3
	for bitbake-devel@lists.openembedded.org;
	Fri, 22 Feb 2013 12:29:17 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 22 Feb 2013 03:11:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,715,1355126400"; d="scan'208";a="290542734"
Received: from adinu-vostro-460 (HELO localhost.localdomain) ([10.237.105.61])
	by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2013 03:11:28 -0800
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Feb 2013 13:12:14 +0200
Message-Id: <1361531534-30884-1-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] [HOB] replace tooltips with property windows
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
X-List-Received-Date: Fri, 22 Feb 2013 11:29:18 -0000

Yocto Bug #2248

 - extended cache_extra.py with the extra information needed in the
 property windows.
 - extended cooker.py so that the extra information in cache_extra.py could
 be used.
 - replaced in the builder.py the function that displayed the tooltips
 with two functions that display property windows for recipes and packages
 pages.
 - advancedsettingsdialog.py : added information so that it would display
 correctly in the information dialogs.
 - propertydialog.py : new class aded for the property windows.
   this covers functionality for : recipe selection page
                                   package selection page
                                   information dialogs
 - simplesettingsdialog.py : added information so that it would display
 correctly in the information dialogs.
 - hoblistmodel.py : added information columns needed in order to display
 the information in the property dialogs.
 - hobwidget.py : added functionality for the information dialogs.
 - imageconfigurationpage.py : added information so that it would display
 correctly in the information dialogs.
 - packageselectionpage.py : added event for the "All packages" tab and
 passing the information needed to the function created in the builder.
 - recipeselectionpage.py : added events for the "Package Groups" and "All
 recipes" tabs and passing the information needed to the function created
 in the builder.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/cache_extra.py                      |    9 +
 bitbake/lib/bb/cooker.py                           |    6 +
 bitbake/lib/bb/ui/crumbs/builder.py                |   36 +-
 .../lib/bb/ui/crumbs/hig/advancedsettingsdialog.py |   12 +-
 bitbake/lib/bb/ui/crumbs/hig/propertydialog.py     |  347 ++++++++++++++++++++
 .../lib/bb/ui/crumbs/hig/simplesettingsdialog.py   |   14 +-
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |   23 +-
 bitbake/lib/bb/ui/crumbs/hobwidget.py              |   26 +-
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    2 +-
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |   13 +-
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |   21 +-
 11 files changed, 473 insertions(+), 36 deletions(-)
 create mode 100644 bitbake/lib/bb/ui/crumbs/hig/propertydialog.py

diff --git a/bitbake/lib/bb/cache_extra.py b/bitbake/lib/bb/cache_extra.py
index 40ba304..bf02bb7 100644
--- a/bitbake/lib/bb/cache_extra.py
+++ b/bitbake/lib/bb/cache_extra.py
@@ -41,6 +41,9 @@ class HobRecipeInfo(RecipeInfoCommon):
         self.license = self.getvar('LICENSE', metadata)
         self.section = self.getvar('SECTION', metadata)
         self.description = self.getvar('DESCRIPTION', metadata)
+        self.homepage = self.getvar('HOMEPAGE', metadata)
+        self.bugtracker = self.getvar('BUGTRACKER', metadata)
+        self.prevision = self.getvar('PR', metadata)
 
     @classmethod
     def init_cacheData(cls, cachedata):
@@ -49,9 +52,15 @@ class HobRecipeInfo(RecipeInfoCommon):
         cachedata.license = {}
         cachedata.section = {}
         cachedata.description = {}
+        cachedata.homepage = {}
+        cachedata.bugtracker = {}
+        cachedata.prevision = {}
 
     def add_cacheData(self, cachedata, fn):
         cachedata.summary[fn] = self.summary
         cachedata.license[fn] = self.license
         cachedata.section[fn] = self.section
         cachedata.description[fn] = self.description
+        cachedata.homepage[fn] = self.homepage
+        cachedata.bugtracker[fn] = self.bugtracker
+        cachedata.prevision[fn] = self.prevision
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index f70a04f..f23eed0 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -571,8 +571,11 @@ class BBCooker:
             lic = self.status.license[fn]
             section = self.status.section[fn]
             description = self.status.description[fn]
+            homepage = self.status.homepage[fn]
+            bugtracker = self.status.bugtracker[fn]
             rdepends = self.status.rundeps[fn]
             rrecs = self.status.runrecs[fn]
+            prevision = self.status.prevision[fn]
             inherits = self.status.inherits.get(fn, None)
             if pn not in depend_tree["pn"]:
                 depend_tree["pn"][pn] = {}
@@ -583,6 +586,9 @@ class BBCooker:
                 depend_tree["pn"][pn]["section"] = section
                 depend_tree["pn"][pn]["description"] = description
                 depend_tree["pn"][pn]["inherits"] = inherits
+                depend_tree["pn"][pn]["homepage"] = homepage
+                depend_tree["pn"][pn]["bugtracker"] = bugtracker
+                depend_tree["pn"][pn]["revision"] = prevision
 
             if fnid not in seen_fnids:
                 seen_fnids.append(fnid)
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index e9cfa21..759628e 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -47,6 +47,7 @@ from bb.ui.crumbs.hig.deployimagedialog import DeployImageDialog
 from bb.ui.crumbs.hig.layerselectiondialog import LayerSelectionDialog
 from bb.ui.crumbs.hig.imageselectiondialog import ImageSelectionDialog
 from bb.ui.crumbs.hig.parsingwarningsdialog import ParsingWarningsDialog
+from bb.ui.crumbs.hig.propertydialog import PropertyDialog
 
 hobVer = 20120808
 
@@ -1203,11 +1204,38 @@ class Builder(gtk.Window):
 
         self.fast_generate_image_async(True)
 
-    def show_binb_dialog(self, binb):
-        markup = "<b>Brought in by:</b>\n%s" % binb
-        ptip = PersistentTooltip(markup, self)
+   
+    def show_recipe_property_dialog(self, properties):
+        information = {}
+        dialog = PropertyDialog(title = properties["name"] +' '+ "properties",
+                    parent = self,
+                    information = properties,
+                    flags = gtk.DIALOG_DESTROY_WITH_PARENT
+                        | gtk.DIALOG_NO_SEPARATOR)
+
+        dialog.set_modal(False)
+        
+        button = dialog.add_button("Close", gtk.RESPONSE_NO)
+        HobAltButton.style_button(button)
+        button.connect("clicked", lambda w: dialog.destroy())
+
+        dialog.run()
+
+    def show_packages_property_dialog(self, properties):
+        information = {}
+        dialog = PropertyDialog(title = properties["name"] +' '+ "properties",
+                    parent = self,
+                    information = properties,
+                    flags = gtk.DIALOG_DESTROY_WITH_PARENT
+                        | gtk.DIALOG_NO_SEPARATOR)
 
-        ptip.show()
+        dialog.set_modal(False)
+        
+        button = dialog.add_button("Close", gtk.RESPONSE_NO)
+        HobAltButton.style_button(button)
+        button.connect("clicked", lambda w: dialog.destroy())
+
+        dialog.run()
 
     def show_layer_selection_dialog(self):
         dialog = LayerSelectionDialog(title = "Layers",
diff --git a/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py b/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
index f5397c3..2911906 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
@@ -208,7 +208,7 @@ class AdvancedSettingsDialog (CrumbsDialog, SettingsUIHelper):
             self.all_distros[ i ] = "Default"
             if self.configuration.curr_distro == "defaultsetup":
                 self.configuration.curr_distro = "Default"
-        distro_widget, self.distro_combo = self.gen_combo_widget(self.configuration.curr_distro, self.all_distros, tooltip)
+        distro_widget, self.distro_combo = self.gen_combo_widget(self.configuration.curr_distro, self.all_distros,"<b>Distro</b>" + "*" + tooltip)
         distro_vbox.pack_start(label, expand=False, fill=False)
         distro_vbox.pack_start(distro_widget, expand=False, fill=False)
         main_vbox.pack_start(distro_vbox, expand=False, fill=False)
@@ -219,7 +219,7 @@ class AdvancedSettingsDialog (CrumbsDialog, SettingsUIHelper):
         advanced_vbox.pack_start(table, expand=False, fill=False)
 
         tooltip = "Image file system types you want."
-        info = HobInfoButton(tooltip, self)
+        info = HobInfoButton("<b>Image types</b>" + "*" + tooltip, self)
         label = self.gen_label_widget("Image types:")
         align = gtk.Alignment(0, 0.5, 0, 0)
         table.attach(align, 0, 4, 0, 1)
@@ -257,7 +257,7 @@ class AdvancedSettingsDialog (CrumbsDialog, SettingsUIHelper):
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         tooltip_combo = "Selects the package format used to generate rootfs."
         tooltip_extra = "Selects extra package formats to build"
-        pkgfmt_widget, self.rootfs_combo, self.check_hbox = self.gen_pkgfmt_widget(self.configuration.curr_package_format, self.all_package_formats, tooltip_combo, tooltip_extra)
+        pkgfmt_widget, self.rootfs_combo, self.check_hbox = self.gen_pkgfmt_widget(self.configuration.curr_package_format, self.all_package_formats,"<b>Root file system package format</b>" + "*" + tooltip_combo,"<b>Additional package formats</b>" + "*" + tooltip_extra)
         sub_vbox.pack_start(pkgfmt_widget, expand=False, fill=False)
 
         advanced_vbox.pack_start(self.gen_label_widget('<span weight="bold">Image size</span>'), expand=False, fill=False)
@@ -265,7 +265,7 @@ class AdvancedSettingsDialog (CrumbsDialog, SettingsUIHelper):
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("Image basic size (in MB)")
         tooltip = "Sets the basic size of your target image.\nThis is the basic size of your target image unless your selected package size exceeds this value or you select \'Image Extra Size\'."
-        rootfs_size_widget, self.rootfs_size_spinner = self.gen_spinner_widget(int(self.configuration.image_rootfs_size*1.0/1024), 0, 65536, tooltip)
+        rootfs_size_widget, self.rootfs_size_spinner = self.gen_spinner_widget(int(self.configuration.image_rootfs_size*1.0/1024), 0, 65536,"<b>Image basic size</b>" + "*" + tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(rootfs_size_widget, expand=False, fill=False)
 
@@ -273,7 +273,7 @@ class AdvancedSettingsDialog (CrumbsDialog, SettingsUIHelper):
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("Additional free space (in MB)")
         tooltip = "Sets the extra free space of your target image.\nBy default, the system reserves 30% of your image size as free space. If your image contains zypper, it brings in 50MB more space. The maximum free space is 64GB."
-        extra_size_widget, self.extra_size_spinner = self.gen_spinner_widget(int(self.configuration.image_extra_size*1.0/1024), 0, 65536, tooltip)
+        extra_size_widget, self.extra_size_spinner = self.gen_spinner_widget(int(self.configuration.image_extra_size*1.0/1024), 0, 65536,"<b>Additional free space</b>" + "*" + tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(extra_size_widget, expand=False, fill=False)
 
@@ -295,7 +295,7 @@ class AdvancedSettingsDialog (CrumbsDialog, SettingsUIHelper):
         sub_hbox.pack_start(self.toolchain_checkbox, expand=False, fill=False)
 
         tooltip = "Selects the host platform for which you want to run the toolchain"
-        sdk_machine_widget, self.sdk_machine_combo = self.gen_combo_widget(self.configuration.curr_sdk_machine, self.all_sdk_machines, tooltip)
+        sdk_machine_widget, self.sdk_machine_combo = self.gen_combo_widget(self.configuration.curr_sdk_machine, self.all_sdk_machines,"<b>Build toolchain</b>" + "*" + tooltip)
         sub_hbox.pack_start(sdk_machine_widget, expand=False, fill=False)
 
         return advanced_vbox
diff --git a/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py b/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py
new file mode 100644
index 0000000..d68ef3a
--- /dev/null
+++ b/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py
@@ -0,0 +1,347 @@
+#
+# BitBake Graphical GTK User Interface
+#
+# Copyright (C) 2011-2013   Intel Corporation
+#
+# Authored by Andrei Dinu <andrei.adrianx.dinu@intel.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import string
+import gtk
+import gobject
+import os
+import tempfile
+import glib
+from bb.ui.crumbs.hig.crumbsdialog import CrumbsDialog
+from bb.ui.crumbs.hig.settingsuihelper import SettingsUIHelper
+from bb.ui.crumbs.hig.crumbsmessagedialog import CrumbsMessageDialog
+from bb.ui.crumbs.hig.layerselectiondialog import LayerSelectionDialog
+
+"""
+The following are convenience classes for implementing GNOME HIG compliant
+BitBake GUI's
+In summary: spacing = 12px, border-width = 6px
+"""
+
+class PropertyDialog(CrumbsDialog):
+	
+	def __init__(self, title, parent, information, flags, buttons=None):
+		
+		super(PropertyDialog, self).__init__(title, parent, flags, buttons)
+                
+                self.properties = information		
+
+                if len(self.properties) == 10:
+		        self.create_recipe_visual_elements()
+                elif len(self.properties) == 4:
+                        self.create_package_visual_elements()
+                else:
+                        self.create_information_visual_elements()
+
+
+        def create_information_visual_elements(self):
+
+                HOB_ICON_BASE_DIR = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), ("icons/"))
+                ICON_PACKAGES_DISPLAY_FILE    = os.path.join(HOB_ICON_BASE_DIR, ('info/info_display.png'))
+
+                self.table = gtk.Table(2,2,False)
+                self.table.set_row_spacings(0)
+                self.table.set_col_spacings(0)
+
+                self.image = gtk.Image()
+                self.image.set_from_file(ICON_PACKAGES_DISPLAY_FILE)
+                self.image.set_property("xalign",0)
+                #self.vbox.add(self.image)
+
+                image_info = self.properties.split("*")[0]
+                info = self.properties.split("*")[1]
+                
+                vbox = gtk.VBox(True, spacing=0)        
+                
+                self.label_short = gtk.Label()
+                self.label_short.set_line_wrap(False)
+                self.label_short.set_markup("          " + image_info)
+                self.label_short.set_property("xalign", 0)
+
+                self.info_label = gtk.Label()
+                self.info_label.set_line_wrap(True)
+                self.info_label.set_markup(info)
+                self.info_label.set_property("xalign", 1)
+
+                self.table.attach(self.image, 0,1,0,1, xoptions=gtk.FILL|gtk.EXPAND, yoptions=gtk.FILL)
+                self.table.attach(self.label_short, 0,1,0,1, xoptions=gtk.FILL|gtk.EXPAND, yoptions=gtk.FILL)
+                self.table.attach(self.info_label, 0,1,1,2, xoptions=gtk.FILL|gtk.EXPAND, yoptions=gtk.FILL)
+        
+                self.vbox.add(self.table)
+
+                
+        def create_package_visual_elements(self):
+
+                name = self.properties['name']
+                binb = self.properties['binb']
+                size = self.properties['size']
+                recipe = self.properties['recipe']
+
+                #cleaning out the recipe variable
+                recipe = recipe.split("+")[0]
+
+                vbox = gtk.VBox(True,spacing = 0)
+
+                ###################################### NAME ROW + COL #################################
+
+                self.label_short = gtk.Label()
+                self.label_short.set_size_request(300,-1)
+                self.label_short.set_selectable(True)
+                self.label_short.set_line_wrap(True)
+                self.label_short.set_markup("<span weight=\"bold\">Name: </span>" + name)
+                self.label_short.set_property("xalign", 0)
+                                
+                self.vbox.add(self.label_short)
+
+                ###################################### SIZE ROW + COL ######################################
+
+                self.label_short = gtk.Label()
+                self.label_short.set_size_request(300,-1)
+                self.label_short.set_selectable(True)
+                self.label_short.set_line_wrap(True)
+                self.label_short.set_markup("<span weight=\"bold\">Size: </span>" + size)
+                self.label_short.set_property("xalign", 0)
+                
+                self.vbox.add(self.label_short)
+
+                ##################################### RECIPE ROW + COL #########################################
+
+                self.label_short = gtk.Label()
+                self.label_short.set_size_request(300,-1)
+                self.label_short.set_selectable(True)
+                self.label_short.set_line_wrap(True)
+                self.label_short.set_markup("<span weight=\"bold\">Recipe: </span>" + recipe)
+                self.label_short.set_property("xalign", 0)
+
+                self.vbox.add(self.label_short)
+
+                ##################################### BINB ROW + COL #######################################
+                
+                if binb != '':
+                        self.label_short = gtk.Label()
+                        self.label_short.set_selectable(True)
+                        self.label_short.set_line_wrap(True)
+                        self.label_short.set_markup("<span weight=\"bold\">Brought in by: </span>")
+                        self.label_short.set_property("xalign", 0)                
+
+                        self.label_info = gtk.Label()
+                        self.label_info.set_size_request(300,-1)
+                        self.label_info.set_selectable(True)
+                        self.label_info.set_line_wrap(True)
+                        self.label_info.set_markup(binb)
+                        self.label_info.set_property("xalign", 0)               
+                                                        
+                        self.vbox.add(self.label_short)
+                        self.vbox.add(self.label_info)
+
+                self.vbox.show_all()
+
+
+	def create_recipe_visual_elements(self):
+
+                summary = self.properties['summary']
+		name = self.properties['name']
+		version = self.properties['version']
+		revision = self.properties['revision']
+		binb = self.properties['binb']
+		group = self.properties['group']
+		license = self.properties['license']
+		homepage = self.properties['homepage']
+		bugtracker = self.properties['bugtracker']
+		description = self.properties['description']
+		
+                #cleaning out the version variable and also the summary
+                version = version.split(":")[1]
+                if len(version) > 30:
+                        version = version.split("+")[0]
+                else:
+                        version = version.split("-")[0]
+                license = license.replace("&" , "and")
+                if (homepage == ''):
+                        homepage = 'unknown'
+                if (bugtracker == ''):
+                        bugtracker = 'unknown'
+                summary = summary.split("+")[0]
+                
+                #calculating the rows needed for the table
+                binb_items_count = len(binb.split(','))
+                binb_items = binb.split(',')
+                               		
+		vbox = gtk.VBox(True,spacing = 0)
+                
+                ######################################## SUMMARY LABEL #########################################                	                
+                
+                if summary != '':                
+                        self.label_short = gtk.Label()
+                        self.label_short.set_size_request(300,-1)
+                        self.label_short.set_selectable(True)                
+                        self.label_short.set_line_wrap(True)
+                        self.label_short.set_markup("<b>" + summary + "</b>")
+                        self.label_short.set_property("xalign", 0)
+                        
+                        self.vbox.pack_start(self.label_short, expand=False, fill=False, padding=0)
+                
+                ########################################## NAME ROW + COL #######################################
+                                
+                self.label_short = gtk.Label()
+                self.label_short.set_size_request(300,-1)
+                self.label_short.set_selectable(True)
+                self.label_short.set_line_wrap(True)
+                self.label_short.set_markup("<span weight=\"bold\">Name: </span>" + name)
+                self.label_short.set_property("xalign", 0)
+                                
+                self.vbox.add(self.label_short)
+
+                ####################################### VERSION ROW + COL ####################################
+                
+                self.label_short = gtk.Label()
+                self.label_short.set_size_request(300,-1)
+                self.label_short.set_selectable(True)
+                self.label_short.set_line_wrap(True)
+                self.label_short.set_markup("<span weight=\"bold\">Version: </span>" + version)
+                self.label_short.set_property("xalign", 0)
+                
+                self.vbox.add(self.label_short)
+
+                ##################################### REVISION ROW + COL #####################################
+
+                self.label_short = gtk.Label()
+                self.label_short.set_size_request(300,-1)
+                self.label_short.set_line_wrap(True)
+                self.label_short.set_selectable(True)
+                self.label_short.set_markup("<span weight=\"bold\">Revision: </span>" + revision)
+                self.label_short.set_property("xalign", 0)                
+                
+                self.vbox.add(self.label_short)
+
+                ################################## GROUP ROW + COL ############################################
+               
+                self.label_short = gtk.Label()
+                self.label_short.set_size_request(300,-1)  
+                self.label_short.set_selectable(True)              
+                self.label_short.set_line_wrap(True)                                
+                self.label_short.set_markup("<span weight=\"bold\">Group: </span>" + group)
+                self.label_short.set_property("xalign", 0)
+                                
+                self.vbox.add(self.label_short)
+
+                ################################# HOMEPAGE ROW + COL ############################################
+                
+                if homepage != 'unknown':
+                        self.label_info = gtk.Label()
+                        self.label_info.set_selectable(True)
+                        self.label_info.set_line_wrap(True)
+                        if len(homepage) > 35:
+                                self.label_info.set_markup("<a href=\"" + homepage + "\">" + homepage[0:35] + "..." + "</a>")
+                        else:
+                                self.label_info.set_markup("<a href=\"" + homepage + "\">" + homepage[0:60] + "</a>")
+
+                        self.label_info.set_property("xalign", 0)
+                       
+                        self.label_short = gtk.Label()
+                        self.label_short.set_size_request(300,-1)   
+                        self.label_short.set_selectable(True)                     
+                        self.label_short.set_line_wrap(True)                        
+                        self.label_short.set_markup("<b>Homepage: </b>")                      
+                        self.label_short.set_property("xalign", 0)
+                        
+                        self.vbox.add(self.label_short)
+                        self.vbox.add(self.label_info)
+               
+                ################################# BUGTRACKER ROW + COL ###########################################
+                
+                if bugtracker != 'unknown':
+                        self.label_info = gtk.Label()
+                        self.label_info.set_selectable(True)
+                        self.label_info.set_line_wrap(True)
+                        if len(bugtracker) > 35:
+                                self.label_info.set_markup("<a href=\"" + bugtracker + "\">" + bugtracker[0:35] + "..." + "</a>")
+                        else:
+                                self.label_info.set_markup("<a href=\"" + bugtracker + "\">" + bugtracker[0:60] + "</a>")
+                        self.label_info.set_property("xalign", 0)  
+
+                        self.label_short = gtk.Label()
+                        self.label_short.set_size_request(300,-1)    
+                        self.label_short.set_selectable(True)                    
+                        self.label_short.set_line_wrap(True)
+                        self.label_short.set_markup("<b>Bugtracker: </b>")                   
+                        self.label_short.set_property("xalign", 0)
+                        
+                        self.vbox.add(self.label_short)
+                        self.vbox.add(self.label_info)
+
+                ################################# LICENSE ROW + COL ############################################
+                
+                self.label_info = gtk.Label()
+                self.label_info.set_size_request(300,-1)
+                self.label_info.set_selectable(True)
+                self.label_info.set_line_wrap(True)
+                self.label_info.set_markup(license)
+                self.label_info.set_property("xalign", 0)
+
+                self.label_short = gtk.Label()
+                self.label_short.set_selectable(True)                
+                self.label_short.set_line_wrap(True)                
+                self.label_short.set_markup("<span weight=\"bold\">License: </span>")
+                self.label_short.set_property("xalign", 0)
+                
+                self.vbox.add(self.label_short)
+                self.vbox.add(self.label_info)
+
+                ################################### BINB ROW+COL #############################################
+                
+                if binb != '':
+                        self.label_short = gtk.Label()
+                        self.label_short.set_selectable(True)
+                        self.label_short.set_line_wrap(True)
+                        self.label_short.set_markup("<span weight=\"bold\">Brought in by: </span>")
+                        self.label_short.set_property("xalign", 0)
+
+                        self.label_info = gtk.Label()
+                        self.label_info.set_size_request(300,-1)
+                        self.label_info.set_selectable(True)
+                        self.label_info.set_markup(binb)
+                        self.label_info.set_property("xalign", 0)
+                        self.label_info.set_line_wrap(True)
+                        
+                        self.vbox.add(self.label_short)
+                        self.vbox.add(self.label_info)
+
+                ################################ DESCRIPTION TAG ROW #################################################
+                
+                self.label_short = gtk.Label()
+                self.label_short.set_line_wrap(True)
+                self.label_short.set_markup("<span weight=\"bold\">Description </span>")
+                self.label_short.set_property("xalign", 0)
+                self.vbox.add(self.label_short)
+                
+                ################################ DESCRIPTION INFORMATION ROW ##########################################
+                
+                hbox = gtk.HBox(True,spacing = 0)
+
+                self.label_short = gtk.Label()
+                self.label_short.set_size_request(300,-1)
+                self.label_short.set_selectable(True)                
+                self.label_short.set_text(description)
+                self.label_short.set_line_wrap(True)
+                self.label_short.set_property("xalign", 0)
+                self.vbox.add(self.label_short)
+
+                self.vbox.show_all()
diff --git a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
index 5f316ae..e0fbdca 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
@@ -260,7 +260,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         tooltip = "Sets the number of threads that BitBake tasks can simultaneously run. See the <a href=\""
         tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
         tooltip += "poky-ref-manual.html#var-BB_NUMBER_THREADS\">Poky reference manual</a> for information"
-        bbthread_widget, self.bb_spinner = self.gen_spinner_widget(self.configuration.bbthread, 1, self.max_threads, tooltip)
+        bbthread_widget, self.bb_spinner = self.gen_spinner_widget(self.configuration.bbthread, 1, self.max_threads,"<b>BitBake prallalel threads</b>" + "*" + tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(bbthread_widget, expand=False, fill=False)
 
@@ -270,7 +270,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         tooltip = "Sets the maximum number of threads the host can use during the build. See the <a href=\""
         tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
         tooltip += "poky-ref-manual.html#var-PARALLEL_MAKE\">Poky reference manual</a> for information"
-        pmake_widget, self.pmake_spinner = self.gen_spinner_widget(self.configuration.pmake, 1, self.max_threads, tooltip)
+        pmake_widget, self.pmake_spinner = self.gen_spinner_widget(self.configuration.pmake, 1, self.max_threads,"<b>Make parallel threads</b>" + "*" + tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(pmake_widget, expand=False, fill=False)
 
@@ -279,7 +279,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("Downloads directory")
         tooltip = "Select a folder that caches the upstream project source code"
-        dldir_widget, self.dldir_text = self.gen_entry_widget(self.configuration.dldir, self, tooltip)
+        dldir_widget, self.dldir_text = self.gen_entry_widget(self.configuration.dldir, self,"<b>Downloaded source code</b>" + "*" + tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(dldir_widget, expand=False, fill=False)
 
@@ -293,7 +293,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False, padding=24)
         content = "<span>Shared state directory</span>"
         tooltip = "Select a folder that caches your prebuilt results"
-        label = self.gen_label_info_widget(content, tooltip)
+        label = self.gen_label_info_widget(content,"<b>Shared state directory</b>" + "*" + tooltip)
         sstatedir_widget, self.sstatedir_text = self.gen_entry_widget(self.configuration.sstatedir, self)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(sstatedir_widget, expand=False, fill=False, padding=6)
@@ -305,7 +305,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         tooltip += "For more information on shared state mirrors, check the <a href=\""
         tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
         tooltip += "poky-ref-manual.html#shared-state\">Yocto Project Reference Manual</a>."
-        table = self.gen_label_info_widget(content, tooltip)
+        table = self.gen_label_info_widget(content,"Shared state mirrors" + "*" + tooltip)
         advanced_vbox.pack_start(table, expand=False, fill=False, padding=6)
 
         sub_vbox = gtk.VBox(False)
@@ -627,7 +627,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">Set the proxies used when fetching source code</span>")
         tooltip = "Set the proxies used when fetching source code.  A blank field uses a direct internet connection."
-        info = HobInfoButton(tooltip, self)
+        info = HobInfoButton("<span weight=\"bold\">Set the proxies used when fetching source code</span>" + "*" + tooltip, self)
         hbox = gtk.HBox(False, 12)
         hbox.pack_start(label, expand=True, fill=True)
         hbox.pack_start(info, expand=False, fill=False)
@@ -875,7 +875,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         advanced_vbox.pack_start(sub_vbox, expand=True, fill=True)
         label = self.gen_label_widget("<span weight=\"bold\">Add your own variables:</span>")
         tooltip = "These are key/value pairs for your extra settings. Click \'Add\' and then directly edit the key and the value"
-        setting_widget, self.setting_store = self.gen_editable_settings(self.configuration.extra_setting, tooltip)
+        setting_widget, self.setting_store = self.gen_editable_settings(self.configuration.extra_setting,"<b>Add your own variables</b>" + "*" + tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(setting_widget, expand=True, fill=True)
 
diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 06c90d3..2f4cfc4 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -381,7 +381,8 @@ class RecipeListModel(gtk.ListStore):
     providing convenience functions to access gtk.TreeModel subclasses which
     provide filtered views of the data.
     """
-    (COL_NAME, COL_DESC, COL_LIC, COL_GROUP, COL_DEPS, COL_BINB, COL_TYPE, COL_INC, COL_IMG, COL_INSTALL, COL_PN, COL_FADE_INC) = range(12)
+    (COL_NAME, COL_DESC, COL_LIC, COL_GROUP, COL_DEPS, COL_BINB, COL_TYPE, COL_INC, COL_IMG, COL_INSTALL, COL_PN, COL_FADE_INC, COL_SUMMARY, COL_VERSION,
+        COL_REVISION, COL_HOMEPAGE, COL_BUGTRACKER) = range(17)
 
     __custom_image__ = "Create your own image"
 
@@ -406,7 +407,12 @@ class RecipeListModel(gtk.ListStore):
                                 gobject.TYPE_BOOLEAN,
                                 gobject.TYPE_STRING,
                                 gobject.TYPE_STRING,
-                                gobject.TYPE_BOOLEAN)
+                                gobject.TYPE_BOOLEAN,
+                                gobject.TYPE_STRING,
+                                gobject.TYPE_STRING,
+                                gobject.TYPE_STRING,
+                                gobject.TYPE_STRING,
+                                gobject.TYPE_STRING)
 
     """
     Find the model path for the item_name
@@ -505,7 +511,9 @@ class RecipeListModel(gtk.ListStore):
                  self.COL_LIC, "", self.COL_GROUP, "",
                  self.COL_DEPS, "", self.COL_BINB, "",
                  self.COL_TYPE, "image", self.COL_INC, False,
-                 self.COL_IMG, False, self.COL_INSTALL, "", self.COL_PN, self.__custom_image__)
+                 self.COL_IMG, False, self.COL_INSTALL, "", self.COL_PN, self.__custom_image__,
+                 self.COL_SUMMARY, "", self.COL_VERSION, "", self.COL_REVISION, "",
+                 self.COL_HOMEPAGE, "", self.COL_BUGTRACKER, "")
 
         for item in event_model["pn"]:
             name = item
@@ -513,6 +521,11 @@ class RecipeListModel(gtk.ListStore):
             lic = event_model["pn"][item]["license"]
             group = event_model["pn"][item]["section"]
             inherits = event_model["pn"][item]["inherits"]
+            summary = event_model["pn"][item]["summary"]
+            version = event_model["pn"][item]["version"]
+            revision = event_model["pn"][item]["revision"]
+            homepage = event_model["pn"][item]["homepage"]
+            bugtracker = event_model["pn"][item]["bugtracker"]
             install = []
 
             depends = event_model["depends"].get(item, []) + event_model["rdepends-pn"].get(item, [])
@@ -534,7 +547,9 @@ class RecipeListModel(gtk.ListStore):
                      self.COL_LIC, lic, self.COL_GROUP, group,
                      self.COL_DEPS, " ".join(depends), self.COL_BINB, "",
                      self.COL_TYPE, atype, self.COL_INC, False,
-                     self.COL_IMG, False, self.COL_INSTALL, " ".join(install), self.COL_PN, item)
+                     self.COL_IMG, False, self.COL_INSTALL, " ".join(install), self.COL_PN, item,
+                     self.COL_SUMMARY, summary, self.COL_VERSION, version, self.COL_REVISION, revision,
+                     self.COL_HOMEPAGE, homepage, self.COL_BUGTRACKER, bugtracker)
 
         self.pn_path = {}
         it = self.get_iter_first()
diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 3ca9066..3f46a4b 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -347,17 +347,13 @@ class HobInfoButton(gtk.EventBox):
         hic.ICON_INFO_DISPLAY_FILE)
         self.image.show()
         self.add(self.image)
+        self.tip_markup = tip_markup
+        self.my_parent = parent
 
         self.set_events(gtk.gdk.BUTTON_RELEASE |
                         gtk.gdk.ENTER_NOTIFY_MASK |
                         gtk.gdk.LEAVE_NOTIFY_MASK)
 
-        self.ptip = PersistentTooltip(tip_markup)
-
-        if parent:
-            self.ptip.set_parent(parent)
-            self.ptip.set_transient_for(parent)
-            self.ptip.set_destroy_with_parent(True)
 
         self.connect("button-release-event", self.button_release_cb)
         self.connect("enter-notify-event", self.mouse_in_cb)
@@ -368,8 +364,22 @@ class HobInfoButton(gtk.EventBox):
     PersistentTooltip
     """
     def button_release_cb(self, widget, event):
-        self.ptip.show()
-
+        from bb.ui.crumbs.hig.propertydialog import PropertyDialog
+        self.dialog = PropertyDialog(title = '',
+                    parent = self.my_parent,
+                    information = self.tip_markup,
+                    flags = gtk.DIALOG_DESTROY_WITH_PARENT
+                        | gtk.DIALOG_NO_SEPARATOR)
+
+        #self.dialog.set_modal(False)
+        
+        button = self.dialog.add_button("Close", gtk.RESPONSE_CANCEL)
+        HobAltButton.style_button(button)
+        button.connect("clicked", lambda w: self.dialog.destroy())
+
+        self.dialog.show_all() 
+        self.dialog.run()
+        
     """
     Change to the prelight image when the mouse enters the widget
     """
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index df7a017..3ea9c86 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -199,7 +199,7 @@ class ImageConfigurationPage (HobPage):
         markup += "For more on layers, check the <a href=\""
         markup += "http://www.yoctoproject.org/docs/current/dev-manual/"
         markup += "dev-manual.html#understanding-and-using-layers\">reference manual</a>."
-        self.layer_info_icon = HobInfoButton(markup, self.get_parent())
+        self.layer_info_icon = HobInfoButton("<b>Layers</b>" + "*" + markup, self.get_parent())
 
 #        self.progress_box = gtk.HBox(False, 6)
         self.progress_bar = HobProgressBar()
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 4544543..ddf3e27 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -142,6 +142,9 @@ class PackageSelectionPage (HobPage):
             if page['name'] == "Included packages":
                 tab.connect("button-release-event", self.button_click_cb)
                 tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
+            if page['name'] == "All packages":
+                tab.connect("button-release-event", self.button_click_cb)
+                tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
             self.ins.append_page(tab, page['name'], page['tooltip'])
             self.tables.append(tab)
 
@@ -175,9 +178,13 @@ class PackageSelectionPage (HobPage):
         path, col = widget.table_tree.get_cursor()
         tree_model = widget.table_tree.get_model()
         if path: # else activation is likely a removal
-            binb = tree_model.get_value(tree_model.get_iter(path), PackageListModel.COL_BINB)
-            if binb:
-                self.builder.show_binb_dialog(binb)
+            properties = {'binb': '' , 'name': '', 'size':'', 'recipe':''}
+            properties['binb'] = tree_model.get_value(tree_model.get_iter(path), PackageListModel.COL_BINB)
+            properties['name'] = tree_model.get_value(tree_model.get_iter(path), PackageListModel.COL_NAME)
+            properties['size'] = tree_model.get_value(tree_model.get_iter(path), PackageListModel.COL_SIZE)
+            properties['recipe'] = tree_model.get_value(tree_model.get_iter(path), PackageListModel.COL_RCP)      
+       
+            self.builder.show_recipe_property_dialog(properties)
 
     def open_log_clicked_cb(self, button, log_file):
         if log_file:
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index fea92b5..92ddcf3 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -152,6 +152,12 @@ class RecipeSelectionPage (HobPage):
             if page['name'] == "Included recipes":
                 tab.connect("button-release-event", self.button_click_cb)
                 tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
+            if page['name'] == "Package Groups":
+                tab.connect("button-release-event", self.button_click_cb)
+                tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
+            if page['name'] == "All recipes":
+                tab.connect("button-release-event", self.button_click_cb)
+                tab.connect("cell-fadeinout-stopped", self.button_click_cb)
             self.ins.append_page(tab, page['name'], page['tooltip'])
             self.tables.append(tab)
 
@@ -185,9 +191,18 @@ class RecipeSelectionPage (HobPage):
         path, col = widget.table_tree.get_cursor()
         tree_model = widget.table_tree.get_model()
         if path: # else activation is likely a removal
-            binb = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_BINB)
-            if binb:
-                self.builder.show_binb_dialog(binb)
+            properties = {'summary': '', 'name': '', 'version': '', 'revision': '', 'binb': '', 'group': '', 'license': '', 'homepage': '', 'bugtracker': '', 'description': ''}
+            properties['summary'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_SUMMARY)
+            properties['name'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_NAME)
+            properties['version'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_VERSION)
+            properties['revision'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_REVISION)
+            properties['binb'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_BINB)
+            properties['group'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_GROUP)
+            properties['license'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_LIC)
+            properties['homepage'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_HOMEPAGE)
+            properties['bugtracker'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_BUGTRACKER)
+            properties['description'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_DESC)
+            self.builder.show_recipe_property_dialog(properties)
 
     def build_packages_clicked_cb(self, button):
         self.builder.build_packages()
-- 
1.7.9.5



