Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1Tugud-0001ms-La
	for bitbake-devel@lists.openembedded.org;
	Mon, 14 Jan 2013 11:05:06 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 14 Jan 2013 01:48:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,466,1355126400"; d="scan'208";a="243498044"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by azsmga001.ch.intel.com with ESMTP; 14 Jan 2013 01:48:38 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 14 Jan 2013 11:52:49 +0200
Message-Id: <1358157169-15577-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: Hob should display warnings generated during parsing
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
X-List-Received-Date: Mon, 14 Jan 2013 10:05:08 -0000

-now Hob catches the warnings generated during parsing, and after the parsing
is completed, if there are any warnings, it shows a bar that contains a message
with how many warnings has encountered, and a button "View warnings"
-when "View warnings" button is clicked, Hob shows a dialog with the warnings;
if there more than 1 warning, you can use "Previous" and "Next" button to see them

[YOCTO #3215]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py                |   19 ++-
 bitbake/lib/bb/ui/crumbs/hig.py                    |  133 +++++++++++++++++++-
 bitbake/lib/bb/ui/crumbs/hobcolor.py               |    1 +
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py        |   13 ++
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   55 +++++++-
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |    1 +
 6 files changed, 214 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 023ac93..3bb5e1b 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -40,7 +40,8 @@ from bb.ui.crumbs.sanitycheckpage import SanityCheckPage
 from bb.ui.crumbs.hobwidget import hwc, HobButton, HobAltButton
 from bb.ui.crumbs.hig import CrumbsMessageDialog, ImageSelectionDialog, \
                              AdvancedSettingDialog, SimpleSettingsDialog, \
-                             LayerSelectionDialog, DeployImageDialog
+                             LayerSelectionDialog, DeployImageDialog, \
+                             ViewWarningsDialog
 from bb.ui.crumbs.persistenttooltip import PersistentTooltip
 import bb.ui.crumbs.utils
 
@@ -443,6 +444,9 @@ class Builder(gtk.Window):
         # Indicate whether the sanity check ran
         self.sanity_checked = False
 
+        # save parsing warnings
+        self.parsing_warnings = []
+
         # create visual elements
         self.create_visual_elements()
 
@@ -469,6 +473,7 @@ class Builder(gtk.Window):
         self.handler.connect("data-generated",           self.handler_data_generated_cb)
         self.handler.connect("command-succeeded",        self.handler_command_succeeded_cb)
         self.handler.connect("command-failed",           self.handler_command_failed_cb)
+        self.handler.connect("parsing-warning",          self.handler_parsing_warning_cb)
         self.handler.connect("sanity-failed",            self.handler_sanity_failed_cb)
         self.handler.connect("recipe-populated",         self.handler_recipe_populated_cb)
         self.handler.connect("package-populated",        self.handler_package_populated_cb)
@@ -877,6 +882,15 @@ class Builder(gtk.Window):
         response = dialog.run()
         dialog.destroy()
 
+    def show_warning_dialog(self):
+        dialog = ViewWarningsDialog(title = "View warnings",
+                warnings = self.parsing_warnings,
+                parent = None,
+                flags = gtk.DIALOG_DESTROY_WITH_PARENT
+                       | gtk.DIALOG_NO_SEPARATOR)
+        response = dialog.run()
+        dialog.destroy()
+
     def show_network_error_dialog(self):
         lbl = "<b>Hob cannot connect to the network</b>\n"
         msg = "Please check your network connection. If you are using a proxy server, please make sure it is configured correctly."
@@ -900,6 +914,9 @@ class Builder(gtk.Window):
             self.show_error_dialog(msg)
         self.reset()
 
+    def handler_parsing_warning_cb(self, handler, warn_msg):
+        self.parsing_warnings.append(warn_msg)
+
     def handler_sanity_failed_cb(self, handler, msg, network_error):
         self.reset()
         if network_error:
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index e56cf2a..4b57f09 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -271,7 +271,7 @@ class CrumbsMessageDialog(CrumbsDialog):
         self.icon.set_property("yalign", 0.00)
         self.icon.show()
         first_column.pack_start(self.icon, expand=False, fill=True, padding=0)
-        
+
         if 0 <= len(msg) < 200:
             lbl = label + "%s" % glib.markup_escape_text(msg)
             self.label_short = gtk.Label()
@@ -1976,3 +1976,134 @@ class OpeningLogDialog (CrumbsDialog):
         button = self.add_button("Cancel", gtk.RESPONSE_CANCEL)
         HobAltButton.style_button(button)
         self.show_all()
+
+#
+# ViewWarningsDialog
+#
+class ViewWarningsDialog (CrumbsDialog):
+
+    def __init__(self, title, warnings, parent, flags, buttons=None):
+        super(ViewWarningsDialog, self).__init__(title, parent, flags, buttons)
+
+        self.warnings = warnings
+        self.warning_on = 0
+        self.warn_nb = len(warnings)
+
+        # create visual elements on the dialog
+        self.create_visual_elements()
+
+    def cancel_button_cb(self, button):
+        self.destroy()
+
+    def previous_button_cb(self, button):
+        self.warning_on = self.warning_on - 1
+        self.refresh_components()
+
+    def next_button_cb(self, button):
+        self.warning_on = self.warning_on + 1
+        self.refresh_components()
+
+    def refresh_components(self):
+        lbl = self.warnings[self.warning_on]
+        #when the warning text has more than 400 chars, it uses a scroll bar
+        if 0<= len(lbl) < 400:
+            self.warning_label.set_size_request(320, 230)
+            self.warning_label.set_use_markup(True)
+            self.warning_label.set_line_wrap(True)
+            self.warning_label.set_markup(lbl)
+            self.warning_label.set_property("yalign", 0.00)
+        else:
+            self.textWindow.set_shadow_type(gtk.SHADOW_IN)
+            self.textWindow.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
+            self.msgView = gtk.TextView()
+            self.msgView.set_editable(False)
+            self.msgView.set_wrap_mode(gtk.WRAP_WORD)
+            self.msgView.set_cursor_visible(False)
+            self.msgView.set_size_request(320, 230)
+            self.buf = gtk.TextBuffer()
+            self.buf.set_text(lbl)
+            self.msgView.set_buffer(self.buf)
+            self.textWindow.add(self.msgView)
+            self.msgView.show()
+
+        if self.warning_on==0:
+            self.previous_button.set_sensitive(False)
+        else:
+            self.previous_button.set_sensitive(True)
+
+        if self.warning_on==self.warn_nb-1:
+            self.next_button.set_sensitive(False)
+        else:
+            self.next_button.set_sensitive(True)
+
+        if self.warn_nb>1:
+            self.heading = "Warning " + str(self.warning_on + 1) + " of " + str(self.warn_nb)
+            self.heading_label.set_markup('<span weight="bold">%s</span>' % self.heading)
+        else:
+            self.heading = "Warning"
+            self.heading_label.set_markup('<span weight="bold">%s</span>' % self.heading)
+
+        self.show_all()
+
+        if 0<= len(lbl) < 400:
+            self.textWindow.hide()
+        else:
+            self.warning_label.hide()
+
+    def create_visual_elements(self):
+        self.set_size_request(350, 350)
+        self.heading_label = gtk.Label()
+        self.heading_label.set_alignment(0.1, 0)
+        self.warning_label = gtk.Label()
+        self.textWindow = gtk.ScrolledWindow()
+
+        table = gtk.Table(1, 10, False)
+
+        cancel_button = gtk.Button()
+        cancel_button.set_label("Close")
+        cancel_button.connect("clicked", self.cancel_button_cb)
+        cancel_button.set_size_request(110, 30)
+
+        self.previous_button = gtk.Button()
+        image1 = gtk.image_new_from_stock(gtk.STOCK_GO_BACK, gtk.ICON_SIZE_BUTTON)
+        image1.show()
+        box = gtk.HBox(False, 6)
+        box.show()
+        self.previous_button.add(box)
+        lbl = gtk.Label("Previous")
+        lbl.show()
+        box.pack_start(image1, expand=False, fill=False, padding=3)
+        box.pack_start(lbl, expand=True, fill=True, padding=3)
+        self.previous_button.connect("clicked", self.previous_button_cb)
+        self.previous_button.set_size_request(110, 30)
+
+        self.next_button = gtk.Button()
+        image2 = gtk.image_new_from_stock(gtk.STOCK_GO_FORWARD, gtk.ICON_SIZE_BUTTON)
+        image2.show()
+        box = gtk.HBox(False, 6)
+        box.show()
+        self.next_button.add(box)
+        lbl = gtk.Label("Next")
+        lbl.show()
+        box.pack_start(lbl, expand=True, fill=True, padding=3)
+        box.pack_start(image2, expand=False, fill=False, padding=3)
+        self.next_button.connect("clicked", self.next_button_cb)
+        self.next_button.set_size_request(110, 30)
+
+        #when there more than one warning, we need "previous" and "next" button
+        if self.warn_nb>1:
+            self.vbox.pack_start(self.heading_label, expand=False, fill=False)
+            self.vbox.pack_start(self.warning_label, expand=False, fill=False)
+            self.vbox.pack_start(self.textWindow, expand=False, fill=False)
+            table.attach(cancel_button, 6, 7, 0, 1, xoptions=gtk.SHRINK)
+            table.attach(self.previous_button, 7, 8, 0, 1, xoptions=gtk.SHRINK)
+            table.attach(self.next_button, 8, 9, 0, 1, xoptions=gtk.SHRINK)
+            self.vbox.pack_end(table, expand=False, fill=False)
+        else:
+            self.vbox.pack_start(self.heading_label, expand=False, fill=False)
+            self.vbox.pack_start(self.warning_label, expand=False, fill=False)
+            self.vbox.pack_start(self.textWindow, expand=False, fill=False)
+            cancel_button = self.add_button("Cancel", gtk.RESPONSE_CANCEL)
+            HobAltButton.style_button(cancel_button)
+
+        self.refresh_components()
diff --git a/bitbake/lib/bb/ui/crumbs/hobcolor.py b/bitbake/lib/bb/ui/crumbs/hobcolor.py
index e10f546..3316542 100644
--- a/bitbake/lib/bb/ui/crumbs/hobcolor.py
+++ b/bitbake/lib/bb/ui/crumbs/hobcolor.py
@@ -30,6 +30,7 @@ class HobColors:
     BLACK        = "#000000"
     PALE_BLUE    = "#53b8ff"
     DEEP_RED     = "#aa3e3e"
+    KHAKI        = "#fff68f"
 
     OK = WHITE
     RUNNING = PALE_GREEN
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index e690d4c..41022ef 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -41,6 +41,9 @@ class HobHandler(gobject.GObject):
          "command-failed"          : (gobject.SIGNAL_RUN_LAST,
                                       gobject.TYPE_NONE,
                                      (gobject.TYPE_STRING,)),
+         "parsing-warning"         : (gobject.SIGNAL_RUN_LAST,
+                                      gobject.TYPE_NONE,
+                                     (gobject.TYPE_STRING,)),
          "sanity-failed"           : (gobject.SIGNAL_RUN_LAST,
                                       gobject.TYPE_NONE,
                                      (gobject.TYPE_STRING, gobject.TYPE_INT)),
@@ -95,6 +98,7 @@ class HobHandler(gobject.GObject):
         self.server = server
         self.error_msg = ""
         self.initcmd = None
+        self.parsing = False
 
     def set_busy(self):
         if not self.generating:
@@ -207,6 +211,11 @@ class HobHandler(gobject.GObject):
                     formatter = bb.msg.BBLogFormatter()
                     msg = formatter.format(event)
                     self.error_msg += msg + '\n'
+                elif event.levelno >= logging.WARNING and self.parsing == True:
+                    formatter = bb.msg.BBLogFormatter()
+                    msg = formatter.format(event)
+                    warn_msg = msg + '\n'
+                    self.emit("parsing-warning", warn_msg)
 
         elif isinstance(event, bb.event.TargetsTreeGenerated):
             self.current_phase = "data generation"
@@ -249,6 +258,8 @@ class HobHandler(gobject.GObject):
             message["total"] = None
             message["title"] = "Parsing recipes"
             self.emit("parsing-started", message)
+            if isinstance(event, bb.event.ParseStarted):
+                self.parsing = True
         elif isinstance(event, (bb.event.ParseProgress,
                 bb.event.CacheLoadProgress,
                 bb.event.TreeDataPreparationProgress)):
@@ -267,6 +278,8 @@ class HobHandler(gobject.GObject):
             message["total"] = event.total
             message["title"] = "Parsing recipes"
             self.emit("parsing-completed", message)
+            if isinstance(event, bb.event.ParseCompleted):
+                self.parsing = False
         elif isinstance(event, bb.event.NetworkTestFailed):
             self.emit("network-failed")
             self.run_next_command()
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index b94f35c..4fabd02 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -46,6 +46,7 @@ class ImageConfigurationPage (HobPage):
         # cleared.
         self.machine_combo_changed_by_manual = True
         self.stopping = False
+        self.warning_shift = 0
         self.create_visual_elements()
 
     def create_visual_elements(self):
@@ -141,6 +142,38 @@ class ImageConfigurationPage (HobPage):
         if self.builder.recipe_model.get_selected_image() == self.builder.recipe_model.__custom_image__:
             self.just_bake_button.hide()
 
+    def add_warnings_bar(self):
+        #create the warnings bar shown when recipes parsing generates warnings
+        color = HobColors.KHAKI
+        warnings_bar = gtk.EventBox()
+        warnings_bar.modify_bg(gtk.STATE_NORMAL, gtk.gdk.color_parse(color))
+        warnings_bar.set_flags(gtk.CAN_DEFAULT)
+        warnings_bar.grab_default()
+
+        build_stop_tab = gtk.Table(10, 20, True)
+        warnings_bar.add(build_stop_tab)
+
+        icon = gtk.Image()
+        icon_pix_buffer = gtk.gdk.pixbuf_new_from_file(hic.ICON_INDI_ALERT_FILE)
+        icon.set_from_pixbuf(icon_pix_buffer)
+        build_stop_tab.attach(icon, 0, 2, 0, 10)
+
+        label = gtk.Label()
+        label.set_alignment(0.0, 0.5)
+        warnings_nb = len(self.builder.parsing_warnings)
+        if warnings_nb == 1:
+            label.set_markup("<span size='x-large'><b>1 recipe parsing warning</b></span>")
+        else:
+            label.set_markup("<span size='x-large'><b>%s recipe parsing warnings</b></span>" % warnings_nb)
+        build_stop_tab.attach(label, 2, 12, 0, 10)
+
+        view_warnings_button = HobButton("View warnings")
+        view_warnings_button.connect('clicked', self.view_warnings_button_clicked_cb)
+        build_stop_tab.attach(view_warnings_button, 15, 19, 1, 9)
+
+        return warnings_bar
+
+
     def create_config_machine(self):
         self.machine_title = gtk.Label()
         self.machine_title.set_alignment(0.0, 0.5)
@@ -187,6 +220,12 @@ class ImageConfigurationPage (HobPage):
             #self.gtable.attach(self.progress_box, 0, 40, 15, 18)
             self.gtable.attach(self.progress_bar, 0, 37, 15, 18)
             self.gtable.attach(self.stop_button, 37, 40, 15, 18, 0, 0)
+        if self.builder.parsing_warnings:
+            self.warnings_bar = self.add_warnings_bar()
+            self.gtable.attach(self.warnings_bar, 0, 40, 14, 18)
+            self.warning_shift = 4
+        else:
+            self.warning_shift = 0
         self.gtable.attach(self.machine_separator, 0, 40, 13, 14)
 
     def create_config_baseimg(self):
@@ -222,12 +261,12 @@ class ImageConfigurationPage (HobPage):
         self.image_separator = gtk.HSeparator()
 
     def set_config_baseimg_layout(self):
-        self.gtable.attach(self.image_title, 0, 40, 15, 17)
-        self.gtable.attach(self.image_title_desc, 0, 40, 18, 22)
-        self.gtable.attach(self.image_combo, 0, 12, 23, 26)
-        self.gtable.attach(self.image_desc, 0, 12, 27, 33)
-        self.gtable.attach(self.view_adv_configuration_button, 14, 36, 23, 28)
-        self.gtable.attach(self.image_separator, 0, 40, 35, 36)
+        self.gtable.attach(self.image_title, 0, 40, 15+self.warning_shift, 17+self.warning_shift)
+        self.gtable.attach(self.image_title_desc, 0, 40, 18+self.warning_shift, 22+self.warning_shift)
+        self.gtable.attach(self.image_combo, 0, 12, 23+self.warning_shift, 26+self.warning_shift)
+        self.gtable.attach(self.image_desc, 0, 12, 27+self.warning_shift, 33+self.warning_shift)
+        self.gtable.attach(self.view_adv_configuration_button, 14, 36, 23+self.warning_shift, 28+self.warning_shift)
+        self.gtable.attach(self.image_separator, 0, 40, 35+self.warning_shift, 36+self.warning_shift)
 
     def create_config_build_button(self):
         # Create the "Build packages" and "Build image" buttons at the bottom
@@ -255,6 +294,9 @@ class ImageConfigurationPage (HobPage):
         self.progress_bar.set_rcstyle("stop")
         self.builder.cancel_parse_sync()
 
+    def view_warnings_button_clicked_cb(self, button):
+        self.builder.show_warning_dialog()
+
     def machine_combo_changed_cb(self, machine_combo):
         self.stopping = False
         combo_item = machine_combo.get_active_text()
@@ -435,6 +477,7 @@ class ImageConfigurationPage (HobPage):
             self.builder.reparse_post_adv_settings()        
 
     def just_bake_button_clicked_cb(self, button):
+        self.builder.parsing_warnings = []
         self.builder.just_bake()
 
     def edit_image_button_clicked_cb(self, button):
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index ac9cc7e..43f691d 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -197,6 +197,7 @@ class PackageSelectionPage (HobPage):
         self.show_all()
 
     def build_image_clicked_cb(self, button):
+        self.builder.parsing_warnings = []
         self.builder.build_image()
 
     def back_button_clicked_cb(self, button):
-- 
1.7.9.5



