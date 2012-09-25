Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bogdan.a.marinescu@intel.com>) id 1TGQ2y-0003Dz-Ng
	for bitbake-devel@lists.openembedded.org;
	Tue, 25 Sep 2012 09:59:13 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 25 Sep 2012 00:46:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,479,1344236400"; d="scan'208";a="226338969"
Received: from bogdanm (HELO localhost.localdomain) ([10.237.105.62])
	by fmsmga002.fm.intel.com with ESMTP; 25 Sep 2012 00:46:21 -0700
From: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Sep 2012 10:48:49 +0300
Message-Id: <1348559329-30704-1-git-send-email-bogdan.a.marinescu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] [hob] Add sanity check progress screen
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
X-List-Received-Date: Tue, 25 Sep 2012 07:59:13 -0000

This patch adds a sanity check progress screen to hob. The screen
is displayed when Hob executes the sanity check procedure. The screen
is displayed for at least 5 seconds. If a network error is detected,
a special dialog is displayed which lets the user open the proxy
configuration page directly.
Note that currently bitbake triggers the network tests only when
the value of its TMPDIR variable changes, which happens fairly rare
on my system. This is the subject of another bug (#3026).

[YOCTO #3025]

Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
---
 bitbake/lib/bb/event.py                     |    3 +-
 bitbake/lib/bb/ui/crumbs/builder.py         |  124 ++++++++++++++++++++++++---
 bitbake/lib/bb/ui/crumbs/hig.py             |    5 ++
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    5 +-
 bitbake/lib/bb/ui/crumbs/sanitycheckpage.py |   85 ++++++++++++++++++
 meta/classes/sanity.bbclass                 |   17 ++--
 6 files changed, 215 insertions(+), 24 deletions(-)
 create mode 100644 bitbake/lib/bb/ui/crumbs/sanitycheckpage.py

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 7ee28fc..20e2f3f 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -553,6 +553,7 @@ class SanityCheckFailed(Event):
     """
     Event to indicate sanity check has failed
     """
-    def __init__(self, msg):
+    def __init__(self, msg, network_error=False):
         Event.__init__(self)
         self._msg = msg
+        self._network_error = network_error
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 9e9d040..2ea5bec 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -22,7 +22,7 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import glib
-import gtk
+import gtk, gobject
 import copy
 import os
 import subprocess
@@ -36,6 +36,7 @@ from bb.ui.crumbs.recipeselectionpage import RecipeSelectionPage
 from bb.ui.crumbs.packageselectionpage import PackageSelectionPage
 from bb.ui.crumbs.builddetailspage import BuildDetailsPage
 from bb.ui.crumbs.imagedetailspage import ImageDetailsPage
+from bb.ui.crumbs.sanitycheckpage import SanityCheckPage
 from bb.ui.crumbs.hobwidget import hwc, HobButton, HobAltButton
 from bb.ui.crumbs.hig import CrumbsMessageDialog, ImageSelectionDialog, \
                              AdvancedSettingDialog, SimpleSettingsDialog, \
@@ -266,6 +267,22 @@ class Configuration:
         template.setVar("CVS_PROXY_HOST", self.combine_host_only("cvs"))
         template.setVar("CVS_PROXY_PORT", self.combine_port_only("cvs"))
 
+    def __str__(self):
+        s = "VERSION: '%s', BBLAYERS: '%s', MACHINE: '%s', DISTRO: '%s', DL_DIR: '%s'," % \
+            (hobVer, " ".join(self.layers), self.curr_mach, self.curr_distro, self.dldir )
+        s += "SSTATE_DIR: '%s', SSTATE_MIRROR: '%s', PARALLEL_MAKE: '-j %s', BB_NUMBER_THREADS: '%s', PACKAGE_CLASSES: '%s', " % \
+            (self.sstatedir, self.sstatemirror, self.pmake, self.bbthread, " ".join(["package_" + i for i in self.curr_package_format.split()]))
+        s += "IMAGE_ROOTFS_SIZE: '%s', IMAGE_EXTRA_SPACE: '%s', INCOMPATIBLE_LICENSE: '%s', SDKMACHINE: '%s', CONF_VERSION: '%s', " % \
+            (self.image_rootfs_size, self.image_extra_size, self.incompat_license, self.curr_sdk_machine, self.conf_version)
+        s += "LCONF_VERSION: '%s', EXTRA_SETTING: '%s', TOOLCHAIN_BUILD: '%s', IMAGE_FSTYPES: '%s', __SELECTED_IMAGE__: '%s', " % \
+            (self.lconf_version, self.extra_setting, self.toolchain_build, self.image_fstypes, self.selected_image)
+        s += "DEPENDS: '%s', IMAGE_INSTALL: '%s', enable_proxy: '%s', use_same_proxy: '%s', http_proxy: '%s', " % \
+            (self.selected_recipes, self.user_selected_packages, self.enable_proxy, self.same_proxy, self.combine_proxy("http"))
+        s += "https_proxy: '%s', ftp_proxy: '%s', GIT_PROXY_HOST: '%s', GIT_PROXY_PORT: '%s', CVS_PROXY_HOST: '%s', CVS_PROXY_PORT: '%s'" % \
+            (self.combine_proxy("https"), self.combine_proxy("ftp"),self.combine_host_only("git"), self.combine_port_only("git"),
+             self.combine_host_only("cvs"), self.combine_port_only("cvs"))
+        return s
+
 class Parameters:
     '''Represents other variables like available machines, etc.'''
 
@@ -341,7 +358,8 @@ def hob_conf_filter(fn, data):
 
 class Builder(gtk.Window):
 
-    (MACHINE_SELECTION,
+    (INITIAL_CHECKS,
+     MACHINE_SELECTION,
      RCPPKGINFO_POPULATING,
      RCPPKGINFO_POPULATED,
      BASEIMG_SELECTED,
@@ -354,16 +372,18 @@ class Builder(gtk.Window):
      IMAGE_GENERATED,
      MY_IMAGE_OPENED,
      BACK,
-     END_NOOP) = range(14)
+     END_NOOP) = range(15)
 
-    (IMAGE_CONFIGURATION,
+    (SANITY_CHECK,
+     IMAGE_CONFIGURATION,
      RECIPE_DETAILS,
      BUILD_DETAILS,
      PACKAGE_DETAILS,
      IMAGE_DETAILS,
-     END_TAB) = range(6)
+     END_TAB) = range(7)
 
     __step2page__ = {
+        INITIAL_CHECKS        : SANITY_CHECK,
         MACHINE_SELECTION     : IMAGE_CONFIGURATION,
         RCPPKGINFO_POPULATING : IMAGE_CONFIGURATION,
         RCPPKGINFO_POPULATED  : IMAGE_CONFIGURATION,
@@ -379,6 +399,8 @@ class Builder(gtk.Window):
         END_NOOP              : None,
     }
 
+    SANITY_CHECK_MIN_DISPLAY_TIME = 5
+
     def __init__(self, hobHandler, recipe_model, package_model):
         super(Builder, self).__init__()
 
@@ -474,9 +496,14 @@ class Builder(gtk.Window):
         self.build_details_page       = BuildDetailsPage(self)
         self.package_details_page     = PackageSelectionPage(self)
         self.image_details_page       = ImageDetailsPage(self)
+        self.sanity_check_page        = SanityCheckPage(self)
+        self.display_sanity_check = False
+        self.sanity_check_post_func = False
+        self.had_network_error = False
 
         self.nb = gtk.Notebook()
         self.nb.set_show_tabs(False)
+        self.nb.insert_page(self.sanity_check_page,        None, self.SANITY_CHECK)
         self.nb.insert_page(self.image_configuration_page, None, self.IMAGE_CONFIGURATION)
         self.nb.insert_page(self.recipe_details_page,      None, self.RECIPE_DETAILS)
         self.nb.insert_page(self.build_details_page,       None, self.BUILD_DETAILS)
@@ -487,17 +514,46 @@ class Builder(gtk.Window):
         self.show_all()
         self.nb.set_current_page(0)
 
+    def sanity_check_timeout(self):
+        # The minimum time for showing the 'sanity check' page has passe
+        # If someone set the 'sanity_check_post_step' meanwhile, execute it now
+        self.display_sanity_check = False
+        if self.sanity_check_post_func:
+          temp = self.sanity_check_post_func
+          self.sanity_check_post_func = None
+          temp()
+        return False
+
+    def show_sanity_check_page(self):
+        # This window must stay on screen for at least 5 seconds, according to the design document
+        self.nb.set_current_page(self.SANITY_CHECK)
+        self.sanity_check_post_step = None
+        self.display_sanity_check = True
+        self.sanity_check_page.start()
+        gobject.timeout_add(self.SANITY_CHECK_MIN_DISPLAY_TIME * 1000, self.sanity_check_timeout)
+
+    def execute_after_sanity_check(self, func):
+        if not self.display_sanity_check:
+          func()
+        else:
+          sanity_check_post_func = func
+
+    def generate_configuration(self):
+        self.show_sanity_check_page()
+        self.handler.generate_configuration()
+
     def initiate_new_build_async(self):
         self.switch_page(self.MACHINE_SELECTION)
         if self.load_template(TemplateMgr.convert_to_template_pathfilename("default", ".hob/")) == False:
+            self.show_sanity_check_page()
             self.handler.init_cooker()
             self.handler.set_extra_inherit("image_types")
-            self.handler.generate_configuration()
+            self.generate_configuration()
 
     def update_config_async(self):
         self.switch_page(self.MACHINE_SELECTION)
         self.set_user_config()
-        self.handler.generate_configuration()
+        self.generate_configuration()
 
     def sanity_check(self):
         self.handler.trigger_sanity_check()
@@ -752,12 +808,27 @@ class Builder(gtk.Window):
     def handler_package_formats_updated_cb(self, handler, formats):
         self.parameters.all_package_formats = formats
 
+    def switch_to_image_configuration_helper(self):
+        self.sanity_check_page.stop()
+        self.switch_page(self.IMAGE_CONFIGURATION)
+        self.image_configuration_page.switch_machine_combo()
+
+    def show_network_error_dialog_helper(self):
+        self.sanity_check_page.stop()
+        self.show_network_error_dialog()
+
     def handler_command_succeeded_cb(self, handler, initcmd):
         if initcmd == self.handler.GENERATE_CONFIGURATION:
             self.update_configuration_parameters(self.get_parameters_sync())
             self.sanity_check()
         elif initcmd == self.handler.SANITY_CHECK:
-            self.image_configuration_page.switch_machine_combo()
+            if self.had_network_error:
+                self.had_network_error = False
+                self.execute_after_sanity_check(self.show_network_error_dialog_helper)
+            else:
+                # Switch to the 'image configuration' page now, but we might need
+                # to wait for the minimum display time of the sanity check page
+                self.execute_after_sanity_check(self.switch_to_image_configuration_helper)
         elif initcmd in [self.handler.GENERATE_RECIPES,
                          self.handler.GENERATE_PACKAGES,
                          self.handler.GENERATE_IMAGE]:
@@ -782,15 +853,40 @@ class Builder(gtk.Window):
         response = dialog.run()
         dialog.destroy()
 
+    def show_network_error_dialog(self):
+        lbl = "<b>Hob cannot connect to the network</b>\n"
+        msg = "Please check your network connection. If you are using a proxy server, please make sure it is configured correctly."
+        lbl = lbl + "%s\n\n" % glib.markup_escape_text(msg)
+        dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_ERROR)
+        button = dialog.add_button("Close", gtk.RESPONSE_OK)
+        HobButton.style_button(button)
+        button = dialog.add_button("Proxy settings", gtk.RESPONSE_CANCEL)
+        HobButton.style_button(button)
+        res = dialog.run()
+        dialog.destroy()
+        if res == gtk.RESPONSE_CANCEL:
+            res, settings_changed = self.show_simple_settings_dialog(SimpleSettingsDialog.PROXIES_PAGE_ID)
+            if not res:
+                return
+            if settings_changed:
+                self.reparse_post_adv_settings()
+
     def handler_command_failed_cb(self, handler, msg):
         if msg:
             self.show_error_dialog(msg)
         self.reset()
 
-    def handler_sanity_failed_cb(self, handler, msg):
-        msg = msg.replace("your local.conf", "Settings")
-        self.show_error_dialog(msg)
+    def handler_sanity_failed_cb(self, handler, msg, network_error):
         self.reset()
+        if network_error:
+            # Mark this in an internal field. The "network error" dialog will be
+            # shown later, when a SanityCheckPassed event will be handled
+            # (as sent by sanity.bbclass)
+            self.had_network_error = True
+        else:
+            msg = msg.replace("your local.conf", "Settings")
+            self.show_error_dialog(msg)
+            self.reset()
 
     def window_sensitive(self, sensitive):
         self.image_configuration_page.machine_combo.set_sensitive(sensitive)
@@ -1176,7 +1272,7 @@ class Builder(gtk.Window):
 
         dialog.destroy()
 
-    def show_adv_settings_dialog(self):
+    def show_adv_settings_dialog(self, tab=None):
         dialog = AdvancedSettingDialog(title = "Advanced configuration",
             configuration = copy.deepcopy(self.configuration),
             all_image_types = self.parameters.image_types,
@@ -1201,7 +1297,7 @@ class Builder(gtk.Window):
         dialog.destroy()
         return response == gtk.RESPONSE_YES, settings_changed
 
-    def show_simple_settings_dialog(self):
+    def show_simple_settings_dialog(self, tab=None):
         dialog = SimpleSettingsDialog(title = "Settings",
             configuration = copy.deepcopy(self.configuration),
             all_image_types = self.parameters.image_types,
@@ -1217,6 +1313,8 @@ class Builder(gtk.Window):
         HobAltButton.style_button(button)
         button = dialog.add_button("Save", gtk.RESPONSE_YES)
         HobButton.style_button(button)
+        if tab:
+            dialog.switch_to_page(tab)
         response = dialog.run()
         settings_changed = False
         if response == gtk.RESPONSE_YES:
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index f304a68..f4dd43c 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -180,6 +180,9 @@ class CrumbsMessageDialog(CrumbsDialog):
 #
 class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
 
+    (BUILD_ENV_PAGE_ID,
+     PROXIES_PAGE_ID) = range(2)
+
     def __init__(self, title, configuration, all_image_types,
             all_package_formats, all_distros, all_sdk_machines,
             max_threads, parent, flags, buttons=None):
@@ -470,6 +473,8 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
 
         self.show_all()
 
+    def switch_to_page(self, page_id):
+        self.nb.set_current_page(page_id)
 
 #
 # AdvancedSettings Dialog
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 8fc1732..62b8ed0 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -43,7 +43,7 @@ class HobHandler(gobject.GObject):
                                      (gobject.TYPE_STRING,)),
          "sanity-failed"           : (gobject.SIGNAL_RUN_LAST,
                                       gobject.TYPE_NONE,
-                                     (gobject.TYPE_STRING,)),
+                                     (gobject.TYPE_STRING, gobject.TYPE_INT)),
          "generating-data"         : (gobject.SIGNAL_RUN_LAST,
                                       gobject.TYPE_NONE,
                                      ()),
@@ -166,7 +166,6 @@ class HobHandler(gobject.GObject):
     def handle_event(self, event):
         if not event:
             return
-
         if self.building:
             self.current_phase = "building"
             self.build.handle_event(event)
@@ -180,7 +179,7 @@ class HobHandler(gobject.GObject):
             self.run_next_command()
 
         elif isinstance(event, bb.event.SanityCheckFailed):
-            self.emit("sanity-failed", event._msg)
+            self.emit("sanity-failed", event._msg, event._network_error)
 
         elif isinstance(event, logging.LogRecord):
             if event.levelno >= logging.ERROR:
diff --git a/bitbake/lib/bb/ui/crumbs/sanitycheckpage.py b/bitbake/lib/bb/ui/crumbs/sanitycheckpage.py
new file mode 100644
index 0000000..76ce2ec
--- /dev/null
+++ b/bitbake/lib/bb/ui/crumbs/sanitycheckpage.py
@@ -0,0 +1,85 @@
+#!/usr/bin/env python
+#
+# BitBake Graphical GTK User Interface
+#
+# Copyright (C) 2012        Intel Corporation
+#
+# Authored by Bogdan Marinescu <bogdan.a.marinescu@intel.com>
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
+import gtk, gobject
+from bb.ui.crumbs.progressbar import HobProgressBar
+from bb.ui.crumbs.hobwidget import hic
+from bb.ui.crumbs.hobpages import HobPage
+
+#
+# SanityCheckPage
+#
+class SanityCheckPage (HobPage):
+
+    def __init__(self, builder):
+        super(SanityCheckPage, self).__init__(builder)
+        self.running = False
+        self.create_visual_elements()
+        self.show_all()
+
+    def make_label(self, text, bold=True):
+        label = gtk.Label()
+        label.set_alignment(0.0, 0.5)
+        mark = "<span %s>%s</span>" % (self.span_tag('x-large', 'bold') if bold else self.span_tag('medium'), text)
+        label.set_markup(mark)
+        return label
+
+    def start(self):
+        if not self.running:
+          self.running = True
+          gobject.timeout_add(100, self.timer_func)
+
+    def stop(self):
+        self.running = False
+
+    def is_running(self):
+        return self.running
+
+    def timer_func(self):
+        self.progress_bar.pulse()
+        return self.running
+
+    def create_visual_elements(self):
+        # Table'd layout. 'rows' and 'cols' give the table size
+        rows, cols = 30, 50
+        self.table = gtk.Table(rows, cols, True)
+        self.pack_start(self.table, expand=False, fill=False)
+        sx, sy = 2, 2
+        # 'info' icon
+        image = gtk.Image()
+        image.set_from_file(hic.ICON_INFO_DISPLAY_FILE)
+        self.table.attach(image, sx, sx + 2, sy, sy + 3 )
+        image.show()
+        # 'Checking' message
+        label = self.make_label('Hob is checking for correct build system setup')
+        self.table.attach(label, sx + 2, cols, sy, sy + 3, xpadding=5 )
+        label.show()
+        # 'Shouldn't take long' message.
+        label = self.make_label("The check shouldn't take long.", False)
+        self.table.attach(label, sx + 2, cols, sy + 3, sy + 4, xpadding=5)
+        label.show()
+        # Progress bar
+        self.progress_bar = HobProgressBar()
+        self.table.attach(self.progress_bar, sx + 2, cols - 3, sy + 5, sy + 7, xpadding=5)
+        self.progress_bar.show()
+        # All done
+        self.table.show()
+
diff --git a/meta/classes/sanity.bbclass b/meta/classes/sanity.bbclass
index 385d733..634dac8 100644
--- a/meta/classes/sanity.bbclass
+++ b/meta/classes/sanity.bbclass
@@ -4,9 +4,9 @@
 
 SANITY_REQUIRED_UTILITIES ?= "patch diffstat makeinfo git bzip2 tar gzip gawk chrpath wget cpio"
 
-def raise_sanity_error(msg, d):
+def raise_sanity_error(msg, d, network_error=False):
     if d.getVar("SANITY_USE_EVENTS", True) == "1":
-        bb.event.fire(bb.event.SanityCheckFailed(msg), d)
+        bb.event.fire(bb.event.SanityCheckFailed(msg, network_error), d)
         return
 
     bb.fatal(""" OE-core's config sanity checker detected a potential misconfiguration.
@@ -119,8 +119,9 @@ def check_sanity_tmpdir_change(tmpdir, data):
     # Check that TMPDIR isn't on a filesystem with limited filename length (eg. eCryptFS)
     testmsg = check_create_long_filename(tmpdir, "TMPDIR")
     # Check that we can fetch from various network transports
+    errmsg = check_connectivity(data)
     testmsg = testmsg + check_connectivity(data)
-    return testmsg
+    return testmsg, errmsg == ""
         
 def check_sanity_version_change(data):
     # Sanity checks to be done when SANITY_VERSION changes
@@ -475,16 +476,18 @@ def check_sanity(sanity_data):
                 last_sstate_dir = line.split()[1]
     
     sanity_version = int(sanity_data.getVar('SANITY_VERSION', True) or 1)
+    network_error = False
     if last_sanity_version < sanity_version: 
         messages = messages + check_sanity_version_change(sanity_data)
-        messages = messages + check_sanity_tmpdir_change(tmpdir, sanity_data)
+        err, network_error = check_sanity_tmpdir_change(tmpdir, sanity_data)
+        messages = messages + err
         messages = messages + check_sanity_sstate_dir_change(sstate_dir, sanity_data)
     else: 
         if last_tmpdir != tmpdir:
-            messages = messages + check_sanity_tmpdir_change(tmpdir, sanity_data)
+            err, network_error = check_sanity_tmpdir_change(tmpdir, sanity_data)
+            messages = messages + err
         if last_sstate_dir != sstate_dir:
             messages = messages + check_sanity_sstate_dir_change(sstate_dir, sanity_data)
-
     if os.path.exists("conf") and not messages:
         f = file(sanityverfile, 'w')
         f.write("SANITY_VERSION %s\n" % sanity_version) 
@@ -555,7 +558,7 @@ def check_sanity(sanity_data):
         messages = messages + "Error, you have a space in your COREBASE directory path. Please move the installation to a directory which doesn't include a space."
 
     if messages != "":
-        raise_sanity_error(sanity_data.expand(messages), sanity_data)
+        raise_sanity_error(sanity_data.expand(messages), sanity_data, network_error)
 
 # Create a copy of the datastore and finalise it to ensure appends and 
 # overrides are set - the datastore has yet to be finalised at ConfigParsed
-- 
1.7.9.5



