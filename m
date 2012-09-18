Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TDziP-0001I1-Qh
	for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 17:27:58 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 18 Sep 2012 08:15:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,442,1344236400"; d="scan'208";a="207050814"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by orsmga002.jf.intel.com with ESMTP; 18 Sep 2012 08:15:15 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Sep 2012 18:15:55 +0300
Message-Id: <1347981355-26261-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: add a top bar when building process is stopped
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
X-List-Received-Date: Tue, 18 Sep 2012 15:27:58 -0000

When a build was stopped, it wasn't obvious what to do next.
Now, on the page it appers a top bar with 3 buttons: "edit image",
"open log", "build new image"

[YOCTO #2537]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   76 ++++++++++++++++++++++++--
 bitbake/lib/bb/ui/crumbs/builder.py          |   28 +++++++---
 2 files changed, 92 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 8d76ade..85f65b7 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -238,7 +238,7 @@ class BuildDetailsPage (HobPage):
             open_log_button = HobAltButton("Open log")
             open_log_button.set_relief(gtk.RELIEF_HALF)
             open_log_button.set_tooltip_text("Open the build's log file")
-            open_log_button.connect('clicked', self.failure_open_log_button_clicked_cb, log_file)
+            open_log_button.connect('clicked', self.open_log_button_clicked_cb, log_file)
             build_fail_tab.attach(open_log_button, 14, 23, 9, 12)
 
         attach_pos = (24 if log_file else 14)
@@ -250,11 +250,11 @@ class BuildDetailsPage (HobPage):
 
         return build_fail_top
 
-    def show_fail_page(self, title, action_names):
+    def show_fail_page(self, title):
         self._remove_all_widget()
         self.title = "Hob cannot build your %s" % title
 
-        self.build_fail_bar = self.add_build_fail_top_bar(action_names, self.builder.current_logfile)
+        self.build_fail_bar = self.add_build_fail_top_bar(title, self.builder.current_logfile)
 
         self.pack_start(self.group_align, expand=True, fill=True)
         self.box_group_area.pack_start(self.build_fail_bar, expand=False, fill=False)
@@ -266,6 +266,63 @@ class BuildDetailsPage (HobPage):
         self.show_all()
         self.back_button.hide()
 
+    def add_build_stop_top_bar(self, action, log_file=None):
+        color = HobColors.LIGHT_GRAY
+        build_stop_top = gtk.EventBox()
+        build_stop_top.set_size_request(-1, 200)
+        build_stop_top.modify_bg(gtk.STATE_NORMAL, gtk.gdk.color_parse(color))
+        build_stop_top.set_flags(gtk.CAN_DEFAULT)
+        build_stop_top.grab_default()
+
+        build_stop_tab = gtk.Table(11, 46, True)
+        build_stop_top.add(build_stop_tab)
+
+        icon = gtk.Image()
+        icon_pix_buffer = gtk.gdk.pixbuf_new_from_file(hic.ICON_INFO_HOVER_FILE)
+        icon.set_from_pixbuf(icon_pix_buffer)
+        build_stop_tab.attach(icon, 1, 4, 0, 6)
+
+        label = gtk.Label()
+        label.set_alignment(0.0, 0.5)
+        label.set_markup("<span size='x-large'><b>%s</b></span>" % self.title)
+        build_stop_tab.attach(label, 4, 26, 0, 6)
+
+        action_button = HobButton("Edit %s" % action)
+        action_button.set_size_request(-1, 40)
+        action_button.set_tooltip_text("Edit the %s parameters" % action)
+        action_button.connect('clicked', self.stop_primary_action_button_clicked_cb, action)
+        build_stop_tab.attach(action_button, 4, 13, 6, 9)
+
+        if log_file:
+            open_log_button = HobAltButton("Open log")
+            open_log_button.set_relief(gtk.RELIEF_HALF)
+            open_log_button.set_tooltip_text("Open the build's log file")
+            open_log_button.connect('clicked', self.open_log_button_clicked_cb, log_file)
+            build_stop_tab.attach(open_log_button, 14, 23, 6, 9)
+
+        attach_pos = (24 if log_file else 14)
+        build_button = HobAltButton("Build new image")
+        build_button.set_size_request(-1, 40)
+        build_button.set_tooltip_text("Create a new image from scratch")
+        build_button.connect('clicked', self.new_image_button_clicked_cb)
+        build_stop_tab.attach(build_button, attach_pos, attach_pos + 9, 6, 9)
+
+        return build_stop_top, action_button
+
+    def show_stop_page(self, action):
+        self._remove_all_widget()
+        self.title = "Build stopped"
+        self.build_stop_bar, action_button = self.add_build_stop_top_bar(action, self.builder.current_logfile)
+
+        self.pack_start(self.group_align, expand=True, fill=True)
+        self.box_group_area.pack_start(self.build_stop_bar, expand=False, fill=False)
+        self.box_group_area.pack_start(self.vbox, expand=True, fill=True)
+
+        self.vbox.pack_start(self.notebook, expand=True, fill=True)
+        self.show_all()
+        self.back_button.hide()
+        return action_button
+
     def show_page(self, step):
         self._remove_all_widget()
         if step == self.builder.PACKAGE_GENERATING or step == self.builder.FAST_IMAGE_GENERATING:
@@ -299,6 +356,9 @@ class BuildDetailsPage (HobPage):
     def back_button_clicked_cb(self, button):
         self.builder.show_configuration()
 
+    def new_image_button_clicked_cb(self, button):
+        self.builder.reset()
+
     def show_back_button(self):
         self.back_button.show()
 
@@ -328,7 +388,15 @@ class BuildDetailsPage (HobPage):
         elif "Edit image configuration" in action:
             self.builder.show_configuration()
 
-    def failure_open_log_button_clicked_cb(self, button, log_file):
+    def stop_primary_action_button_clicked_cb(self, button, action):
+        if "recipes" in action:
+            self.builder.show_recipes()
+        elif "packages" in action:
+            self.builder.show_packages()
+        elif "image" in action:
+            self.builder.show_configuration()
+
+    def open_log_button_clicked_cb(self, button, log_file):
         if log_file:
             os.system("xdg-open /%s" % log_file)
 
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 6df1ca4..73d31f8 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -927,6 +927,18 @@ class Builder(gtk.Window):
             status = "stop"
             message = "Build stopped: "
             fraction = self.build_details_page.progress_bar.get_fraction()
+            stop_to_next_edit = ""
+            if self.current_step == self.FAST_IMAGE_GENERATING:
+                stop_to_next_edit = "image configuration"
+            elif self.current_step == self.IMAGE_GENERATING:
+                if self.previous_step == self.FAST_IMAGE_GENERATING:
+                    stop_to_next_edit = "image configuration"
+                else:
+                    stop_to_next_edit = "packages"
+            elif self.current_step == self.PACKAGE_GENERATING:
+                stop_to_next_edit = "recipes"
+            button = self.build_details_page.show_stop_page(stop_to_next_edit.split(' ')[0])
+            self.set_default(button)
         else:
             fail_to_next_edit = ""
             if self.current_step == self.FAST_IMAGE_GENERATING:
@@ -941,7 +953,7 @@ class Builder(gtk.Window):
             elif self.current_step == self.PACKAGE_GENERATING:
                 fail_to_next_edit = "recipes"
                 fraction = 1.0
-            self.build_details_page.show_fail_page(fail_to_next_edit.split(' ')[0], fail_to_next_edit)
+            self.build_details_page.show_fail_page(fail_to_next_edit.split(' ')[0])
             status = "fail"
             message = "Build failed: "
         self.build_details_page.update_progress_bar(message, fraction, status)
@@ -1349,19 +1361,19 @@ class Builder(gtk.Window):
             HobButton.style_button(button)
         else:
             lbl = "<b>Stop build?</b>\n\nAre you sure you want to stop this"
-            lbl = lbl + " build?\n\n'Force Stop' will stop the build as quickly as"
-            lbl = lbl + " possible but may well leave your build directory in an"
-            lbl = lbl + " unusable state that requires manual steps to fix.\n\n"
-            lbl = lbl + "'Stop' will stop the build as soon as all in"
+            lbl = lbl + " build?\n\n'Stop' will stop the build as soon as all in"
             lbl = lbl + " progress build tasks are finished. However if a"
             lbl = lbl + " lengthy compilation phase is in progress this may take"
-            lbl = lbl + " some time."
+            lbl = lbl + " some time.\n\n"
+            lbl = lbl + "'Force Stop' will stop the build as quickly as"
+            lbl = lbl + " possible but may well leave your build directory in an"
+            lbl = lbl + " unusable state that requires manual steps to fix."
             dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
             button = dialog.add_button("Cancel", gtk.RESPONSE_CANCEL)
             HobAltButton.style_button(button)
-            button = dialog.add_button("Stop", gtk.RESPONSE_OK)
+            button = dialog.add_button("Force stop", gtk.RESPONSE_YES)
             HobAltButton.style_button(button)
-            button = dialog.add_button("Force Stop", gtk.RESPONSE_YES)
+            button = dialog.add_button("Stop", gtk.RESPONSE_OK)
             HobButton.style_button(button)
         response = dialog.run()
         dialog.destroy()
-- 
1.7.9.5



