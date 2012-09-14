Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bogdan.a.marinescu@intel.com>) id 1TCWrd-0001r6-TD
	for bitbake-devel@lists.openembedded.org;
	Fri, 14 Sep 2012 16:27:27 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 14 Sep 2012 07:14:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,423,1344236400"; d="scan'208";a="222066451"
Received: from bogdanm (HELO localhost.localdomain) ([10.237.105.62])
	by fmsmga002.fm.intel.com with ESMTP; 14 Sep 2012 07:14:49 -0700
From: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Sep 2012 17:17:13 +0300
Message-Id: <1347632233-22080-1-git-send-email-bogdan.a.marinescu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] [hob] Fix settings
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
X-List-Received-Date: Fri, 14 Sep 2012 14:27:27 -0000

Fix some issues with the settings dialog that were introduced as
a result of merging the fix for #2162.

[YOCTO #3117]

Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py              |  234 +++++++++++++-------------
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |    2 +-
 2 files changed, 118 insertions(+), 118 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index ff0ad17..e043f93 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -352,6 +352,123 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         md5 = self.config_md5()
         self.settings_changed = (self.md5 != md5)
 
+    def create_build_environment_page(self):
+        advanced_vbox = gtk.VBox(False, 6)
+        advanced_vbox.set_border_width(6)
+
+        sub_vbox = gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
+        label = self.gen_label_widget("<span weight=\"bold\">Select distro:</span>")
+        tooltip = "Selects the Yocto Project distribution you want"
+        distro_widget, self.distro_combo = self.gen_combo_widget(self.configuration.curr_distro, self.all_distros, tooltip)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(distro_widget, expand=False, fill=False)
+
+        sub_vbox = gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
+        label = self.gen_label_widget("<span weight=\"bold\">BB number threads:</span>")
+        tooltip = "Sets the number of threads that BitBake tasks can simultaneously run. See the <a href=\""
+        tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
+        tooltip += "poky-ref-manual.html#var-BB_NUMBER_THREADS\">Poky reference manual</a> for information"
+        bbthread_widget, self.bb_spinner = self.gen_spinner_widget(self.configuration.bbthread, 1, self.max_threads, tooltip)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(bbthread_widget, expand=False, fill=False)
+
+        sub_vbox = gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
+        label = self.gen_label_widget("<span weight=\"bold\">Parallel make:</span>")
+        tooltip = "Sets the maximum number of threads the host can use during the build. See the <a href=\""
+        tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
+        tooltip += "poky-ref-manual.html#var-PARALLEL_MAKE\">Poky reference manual</a> for information"
+        pmake_widget, self.pmake_spinner = self.gen_spinner_widget(self.configuration.pmake, 1, self.max_threads, tooltip)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(pmake_widget, expand=False, fill=False)
+
+        sub_vbox = gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
+        label = self.gen_label_widget("<span weight=\"bold\">Select download directory:</span>")
+        tooltip = "Select a folder that caches the upstream project source code"
+        dldir_widget, self.dldir_text = self.gen_entry_widget(self.configuration.dldir, self, tooltip)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(dldir_widget, expand=False, fill=False)
+
+        sub_vbox = gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
+        label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE directory:</span>")
+        tooltip = "Select a folder that caches your prebuilt results"
+        sstatedir_widget, self.sstatedir_text = self.gen_entry_widget(self.configuration.sstatedir, self, tooltip)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(sstatedir_widget, expand=False, fill=False)
+
+        sub_vbox = gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
+        label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE mirror:</span>")
+        tooltip = "Select the pre-built mirror that will speed your build"
+        sstatemirror_widget, self.sstatemirror_text = self.gen_entry_widget(self.configuration.sstatemirror, self, tooltip)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(sstatemirror_widget, expand=False, fill=False)
+
+        return advanced_vbox
+
+    def create_proxy_page(self):
+        advanced_vbox = gtk.VBox(False, 6)
+        advanced_vbox.set_border_width(6)
+
+        sub_vbox = gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
+        label = self.gen_label_widget("<span weight=\"bold\">Set the proxies used when fetching source code</span>")
+        tooltip = "Set the proxies used when fetching source code.  A blank field uses a direct internet connection."
+        info = HobInfoButton(tooltip, self)
+        hbox = gtk.HBox(False, 12)
+        hbox.pack_start(label, expand=True, fill=True)
+        hbox.pack_start(info, expand=False, fill=False)
+        sub_vbox.pack_start(hbox, expand=False, fill=False)
+
+        self.direct_checkbox = gtk.RadioButton(None, "Direct internet connection")
+        self.direct_checkbox.set_tooltip_text("Check this box to use a direct internet connection with no proxy")
+        self.direct_checkbox.set_active(not self.configuration.enable_proxy)
+        sub_vbox.pack_start(self.direct_checkbox, expand=False, fill=False)
+
+        self.proxy_checkbox = gtk.RadioButton(self.direct_checkbox, "Manual proxy configuration")
+        self.proxy_checkbox.set_tooltip_text("Check this box to manually set up a specific proxy")
+        self.proxy_checkbox.set_active(self.configuration.enable_proxy)
+        sub_vbox.pack_start(self.proxy_checkbox, expand=False, fill=False)
+
+        self.same_checkbox = gtk.CheckButton("Use the same proxy for all protocols")
+        self.same_checkbox.set_tooltip_text("Check this box to use the HTTP proxy for all five proxies")
+        self.same_checkbox.set_active(self.configuration.same_proxy)
+        hbox = gtk.HBox(False, 12)
+        hbox.pack_start(self.same_checkbox, expand=False, fill=False, padding=24)
+        sub_vbox.pack_start(hbox, expand=False, fill=False)
+
+        proxy_widget, self.http_proxy, self.http_proxy_port, self.http_proxy_details = self.gen_proxy_entry_widget(
+            "http", self, True)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+
+        proxy_widget, self.https_proxy, self.https_proxy_port, self.https_proxy_details = self.gen_proxy_entry_widget(
+            "https", self, True)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+
+        proxy_widget, self.ftp_proxy, self.ftp_proxy_port, self.ftp_proxy_details = self.gen_proxy_entry_widget(
+            "ftp", self, True)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+
+        proxy_widget, self.git_proxy, self.git_proxy_port, self.git_proxy_details = self.gen_proxy_entry_widget(
+            "git", self, True)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+
+        proxy_widget, self.cvs_proxy, self.cvs_proxy_port, self.cvs_proxy_details = self.gen_proxy_entry_widget(
+            "cvs", self, True)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+
+        self.direct_checkbox.connect("toggled", self.proxy_checkbox_toggled_cb)
+        self.proxy_checkbox.connect("toggled", self.proxy_checkbox_toggled_cb)
+        self.same_checkbox.connect("toggled", self.same_checkbox_toggled_cb)
+
+        self.refresh_proxy_components()
+        return advanced_vbox
+
+
     def create_visual_elements(self):
         self.nb = gtk.Notebook()
         self.nb.set_show_tabs(True)        
@@ -364,7 +481,6 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         self.show_all()
 
 
-
 #
 # AdvancedSettings Dialog
 #
@@ -685,122 +801,6 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
 
         return advanced_vbox
 
-    def create_build_environment_page(self):
-        advanced_vbox = gtk.VBox(False, 6)
-        advanced_vbox.set_border_width(6)
-
-        sub_vbox = gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Select distro:</span>")
-        tooltip = "Selects the Yocto Project distribution you want"
-        distro_widget, self.distro_combo = self.gen_combo_widget(self.configuration.curr_distro, self.all_distros, tooltip)
-        sub_vbox.pack_start(label, expand=False, fill=False)
-        sub_vbox.pack_start(distro_widget, expand=False, fill=False)
-
-        sub_vbox = gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">BB number threads:</span>")
-        tooltip = "Sets the number of threads that BitBake tasks can simultaneously run. See the <a href=\""
-        tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
-        tooltip += "poky-ref-manual.html#var-BB_NUMBER_THREADS\">Poky reference manual</a> for information"
-        bbthread_widget, self.bb_spinner = self.gen_spinner_widget(self.configuration.bbthread, 1, self.max_threads, tooltip)
-        sub_vbox.pack_start(label, expand=False, fill=False)
-        sub_vbox.pack_start(bbthread_widget, expand=False, fill=False)
-
-        sub_vbox = gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Parallel make:</span>")
-        tooltip = "Sets the maximum number of threads the host can use during the build. See the <a href=\""
-        tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
-        tooltip += "poky-ref-manual.html#var-PARALLEL_MAKE\">Poky reference manual</a> for information"
-        pmake_widget, self.pmake_spinner = self.gen_spinner_widget(self.configuration.pmake, 1, self.max_threads, tooltip)
-        sub_vbox.pack_start(label, expand=False, fill=False)
-        sub_vbox.pack_start(pmake_widget, expand=False, fill=False)
-
-        sub_vbox = gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Select download directory:</span>")
-        tooltip = "Select a folder that caches the upstream project source code"
-        dldir_widget, self.dldir_text = self.gen_entry_widget(self.configuration.dldir, self, tooltip)
-        sub_vbox.pack_start(label, expand=False, fill=False)
-        sub_vbox.pack_start(dldir_widget, expand=False, fill=False)
-
-        sub_vbox = gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE directory:</span>")
-        tooltip = "Select a folder that caches your prebuilt results"
-        sstatedir_widget, self.sstatedir_text = self.gen_entry_widget(self.configuration.sstatedir, self, tooltip)
-        sub_vbox.pack_start(label, expand=False, fill=False)
-        sub_vbox.pack_start(sstatedir_widget, expand=False, fill=False)
-
-        sub_vbox = gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE mirror:</span>")
-        tooltip = "Select the pre-built mirror that will speed your build"
-        sstatemirror_widget, self.sstatemirror_text = self.gen_entry_widget(self.configuration.sstatemirror, self, tooltip)
-        sub_vbox.pack_start(label, expand=False, fill=False)
-        sub_vbox.pack_start(sstatemirror_widget, expand=False, fill=False)
-
-        return advanced_vbox
-
-    def create_proxy_page(self):
-        advanced_vbox = gtk.VBox(False, 6)
-        advanced_vbox.set_border_width(6)
-
-        sub_vbox = gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Set the proxies used when fetching source code</span>")
-        tooltip = "Set the proxies used when fetching source code.  A blank field uses a direct internet connection."
-        info = HobInfoButton(tooltip, self)
-        hbox = gtk.HBox(False, 12)
-        hbox.pack_start(label, expand=True, fill=True)
-        hbox.pack_start(info, expand=False, fill=False)
-        sub_vbox.pack_start(hbox, expand=False, fill=False)
-
-        self.direct_checkbox = gtk.RadioButton(None, "Direct internet connection")
-        self.direct_checkbox.set_tooltip_text("Check this box to use a direct internet connection with no proxy")
-        self.direct_checkbox.set_active(not self.configuration.enable_proxy)
-        sub_vbox.pack_start(self.direct_checkbox, expand=False, fill=False)
-
-        self.proxy_checkbox = gtk.RadioButton(self.direct_checkbox, "Manual proxy configuration")
-        self.proxy_checkbox.set_tooltip_text("Check this box to manually set up a specific proxy")
-        self.proxy_checkbox.set_active(self.configuration.enable_proxy)
-        sub_vbox.pack_start(self.proxy_checkbox, expand=False, fill=False)
-
-        self.same_checkbox = gtk.CheckButton("Use the same proxy for all protocols")
-        self.same_checkbox.set_tooltip_text("Check this box to use the HTTP proxy for all five proxies")
-        self.same_checkbox.set_active(self.configuration.same_proxy)
-        hbox = gtk.HBox(False, 12)
-        hbox.pack_start(self.same_checkbox, expand=False, fill=False, padding=24)
-        sub_vbox.pack_start(hbox, expand=False, fill=False)
-
-        proxy_widget, self.http_proxy, self.http_proxy_port, self.http_proxy_details = self.gen_proxy_entry_widget(
-            "http", self, True)
-        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
-
-        proxy_widget, self.https_proxy, self.https_proxy_port, self.https_proxy_details = self.gen_proxy_entry_widget(
-            "https", self, True)
-        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
-
-        proxy_widget, self.ftp_proxy, self.ftp_proxy_port, self.ftp_proxy_details = self.gen_proxy_entry_widget(
-            "ftp", self, True)
-        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
-
-        proxy_widget, self.git_proxy, self.git_proxy_port, self.git_proxy_details = self.gen_proxy_entry_widget(
-            "git", self, True)
-        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
-
-        proxy_widget, self.cvs_proxy, self.cvs_proxy_port, self.cvs_proxy_details = self.gen_proxy_entry_widget(
-            "cvs", self, True)
-        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
-
-        self.direct_checkbox.connect("toggled", self.proxy_checkbox_toggled_cb)
-        self.proxy_checkbox.connect("toggled", self.proxy_checkbox_toggled_cb)
-        self.same_checkbox.connect("toggled", self.same_checkbox_toggled_cb)
-
-        self.refresh_proxy_components()
-        return advanced_vbox
-
     def create_others_page(self):
         advanced_vbox = gtk.VBox(False, 6)
         advanced_vbox.set_border_width(6)
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index ed8c7ac..5a6cb21 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -587,7 +587,7 @@ class ImageDetailsPage (HobPage):
 
     def settings_button_clicked_cb(self, button):
         # Create an advanced settings dialog
-        response, settings_changed = self.builder.show_adv_settings_dialog()
+        response, settings_changed = self.builder.show_simple_settings_dialog()
         if not response:
             return
         if settings_changed:
-- 
1.7.9.5



