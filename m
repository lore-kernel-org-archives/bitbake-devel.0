Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SAjpp-0003Ld-VC
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 16:21:54 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 22 Mar 2012 08:12:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="123894960"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 22 Mar 2012 08:12:58 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 22 Mar 2012 23:38:07 +0800
Message-Id: <6799fbc2448df9001dc47466facd3f2b6d0bdba6.1332430442.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <994a3ff7aec35f01ad019ff455b699c86342945e.1332430442.git.shane.wang@intel.com>
References: <994a3ff7aec35f01ad019ff455b699c86342945e.1332430442.git.shane.wang@intel.com>
In-Reply-To: <cover.1332430442.git.shane.wang@intel.com>
References: <cover.1332430442.git.shane.wang@intel.com>
Subject: [PATCH 5/8] Hob: allow users to setup the proxies
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
X-List-Received-Date: Thu, 22 Mar 2012 15:21:54 -0000

This patch is to set os.environ to allow users to set the environment variables for all_proxy, http_proxy, https_proxy and ftp_proxy.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |   52 +++++++++++++++++++
 bitbake/lib/bb/ui/crumbs/hig.py     |   94 ++++++++++++++++++++++++++++++----
 2 files changed, 135 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 5a292e7..12bfc59 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -39,6 +39,7 @@ from bb.ui.crumbs.hig import CrumbsMessageDialog, BinbDialog, \
 
 class Configuration:
     '''Represents the data structure of configuration.'''
+    __dummy_proxy__ = "myproxy.example.com:8010"
 
     def __init__(self, params):
         # Settings
@@ -67,6 +68,25 @@ class Configuration:
         self.selected_recipes = []
         self.selected_packages = []
 
+        # proxy settings
+        self.all_proxy = self.get_os_proxy("all_proxy")
+        self.http_proxy = self.get_os_proxy("http_proxy")
+        self.ftp_proxy = self.get_os_proxy("ftp_proxy")
+        self.https_proxy = self.get_os_proxy("https_proxy")
+        self.enable_proxy = False
+
+    def get_os_proxy(self, proxy_key):
+        if proxy_key in os.environ.keys():
+            return os.environ[proxy_key]
+        return self.__dummy_proxy__
+
+    def set_os_proxy(self, proxy_key, proxy):
+        if (not proxy or proxy.lstrip() == "" or proxy == self.__dummy_proxy__) \
+            and proxy_key in os.environ.keys():
+            del os.environ[proxy_key]
+        else:
+            os.environ[proxy_key] = proxy
+
     def load(self, template):
         self.curr_mach = template.getVar("MACHINE")
         self.curr_package_format = " ".join(template.getVar("PACKAGE_CLASSES").split("package_")).strip()
@@ -92,6 +112,12 @@ class Configuration:
         self.selected_image = template.getVar("__SELECTED_IMAGE__")
         self.selected_recipes = template.getVar("DEPENDS").split()
         self.selected_packages = template.getVar("IMAGE_INSTALL").split()
+        # proxy
+        self.all_proxy = template.getVar("all_proxy")
+        self.http_proxy = template.getVar("http_proxy")
+        self.ftp_proxy = template.getVar("ftp_proxy")
+        self.https_proxy = template.getVar("https_proxy")
+        self.enable_proxy = (template.getVar("enable_proxy") == "True")
 
     def save(self, template, filename):
         # bblayers.conf
@@ -119,6 +145,12 @@ class Configuration:
         template.setVar("__SELECTED_IMAGE__", self.selected_image)
         template.setVar("DEPENDS", self.selected_recipes)
         template.setVar("IMAGE_INSTALL", self.selected_packages)
+        # proxy
+        template.setVar("all_proxy", self.all_proxy)
+        template.setVar("http_proxy", self.http_proxy)
+        template.setVar("ftp_proxy", self.ftp_proxy)
+        template.setVar("https_proxy", self.https_proxy)
+        template.setVar("enable_proxy", ("%s" % self.enable_proxy))
 
 class Parameters:
     '''Represents other variables like available machines, etc.'''
@@ -732,6 +764,13 @@ class Builder(gtk.Window):
 
         dialog.destroy()
 
+    def _setup_proxy(self):
+        if self.configuration.enable_proxy:
+            self.configuration.set_os_proxy("all_proxy", self.configuration.all_proxy)
+            self.configuration.set_os_proxy("http_proxy", self.configuration.http_proxy)
+            self.configuration.set_os_proxy("https_proxy", self.configuration.https_proxy)
+            self.configuration.set_os_proxy("ftp_proxy", self.configuration.ftp_proxy)
+
     def show_adv_settings_dialog(self):
         dialog = AdvancedSettingDialog(title = "Settings",
             configuration = copy.deepcopy(self.configuration),
@@ -740,6 +779,11 @@ class Builder(gtk.Window):
             all_distros = self.parameters.all_distros,
             all_sdk_machines = self.parameters.all_sdk_machines,
             max_threads = self.parameters.max_threads,
+            all_proxy = self.configuration.all_proxy,
+            http_proxy = self.configuration.http_proxy,
+            https_proxy = self.configuration.https_proxy,
+            ftp_proxy = self.configuration.ftp_proxy,
+            enable_proxy = self.configuration.enable_proxy,
             parent = self,
             flags = gtk.DIALOG_MODAL
                     | gtk.DIALOG_DESTROY_WITH_PARENT
@@ -749,6 +793,14 @@ class Builder(gtk.Window):
         response = dialog.run()
         if response == gtk.RESPONSE_YES:
             self.configuration = dialog.configuration
+            # setup the proxy
+            self.configuration.enable_proxy = dialog.enable_proxy
+            if self.configuration.enable_proxy:
+                self.configuration.all_proxy = dialog.all_proxy
+                self.configuration.http_proxy = dialog.http_proxy
+                self.configuration.https_proxy = dialog.https_proxy
+                self.configuration.ftp_proxy = dialog.ftp_proxy
+                self._setup_proxy()
             # DO reparse recipes
             if dialog.settings_changed:
                 if self.configuration.curr_mach == "":
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 652226c..b555196 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -170,20 +170,23 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         dialog.destroy()
 
-    def gen_entry_widget(self, content, parent, tooltip=""):
+    def gen_entry_widget(self, content, parent, tooltip="", need_button=True):
         hbox = gtk.HBox(False, 12)
         entry = gtk.Entry()
         entry.set_text(content)
 
-        table = gtk.Table(1, 10, True)
-        hbox.pack_start(table, expand=True, fill=True)
-        table.attach(entry, 0, 9, 0, 1)
-        image = gtk.Image()
-        image.set_from_stock(gtk.STOCK_OPEN,gtk.ICON_SIZE_BUTTON)
-        open_button = gtk.Button()
-        open_button.set_image(image)
-        open_button.connect("clicked", self.entry_widget_select_path_cb, parent, entry)
-        table.attach(open_button, 9, 10, 0, 1)
+        if need_button:
+            table = gtk.Table(1, 10, True)
+            hbox.pack_start(table, expand=True, fill=True)
+            table.attach(entry, 0, 9, 0, 1)
+            image = gtk.Image()
+            image.set_from_stock(gtk.STOCK_OPEN,gtk.ICON_SIZE_BUTTON)
+            open_button = gtk.Button()
+            open_button.set_image(image)
+            open_button.connect("clicked", self.entry_widget_select_path_cb, parent, entry)
+            table.attach(open_button, 9, 10, 0, 1)
+        else:
+            hbox.pack_start(entry, expand=True, fill=True)
 
         info = HobInfoButton(tooltip, self)
         hbox.pack_start(info, expand=False, fill=False)
@@ -330,7 +333,8 @@ class AdvancedSettingDialog (CrumbsDialog):
 
     def __init__(self, title, configuration, all_image_types,
             all_package_formats, all_distros, all_sdk_machines,
-            max_threads, parent, flags, buttons):
+            max_threads, all_proxy, http_proxy, https_proxy, ftp_proxy,
+            enable_proxy, parent, flags, buttons):
         super(AdvancedSettingDialog, self).__init__(title, parent, flags, buttons)
 
         # class members from other objects
@@ -341,6 +345,11 @@ class AdvancedSettingDialog (CrumbsDialog):
         self.all_distros = all_distros
         self.all_sdk_machines = all_sdk_machines
         self.max_threads = max_threads
+        self.all_proxy = all_proxy
+        self.http_proxy = http_proxy
+        self.https_proxy = https_proxy
+        self.ftp_proxy = ftp_proxy
+        self.enable_proxy = enable_proxy
 
         # class members for internal use
         self.distro_combo = None
@@ -375,6 +384,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         self.nb.append_page(self.create_image_types_page(), gtk.Label("Image types"))
         self.nb.append_page(self.create_output_page(), gtk.Label("Output"))
         self.nb.append_page(self.create_build_environment_page(), gtk.Label("Build environment"))
+        self.nb.append_page(self.create_proxy_page(), gtk.Label("Proxies"))
         self.nb.append_page(self.create_others_page(), gtk.Label("Others"))
         self.nb.set_current_page(0)
         self.vbox.pack_start(self.nb, expand=True, fill=True)
@@ -515,6 +525,52 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         return advanced_vbox
 
+    def create_proxy_page(self):
+        advanced_vbox = gtk.VBox(False, 6)
+        advanced_vbox.set_border_width(6)
+
+        sub_vbox = gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
+        self.proxy_checkbox = gtk.CheckButton("Enable Proxy")
+        self.proxy_checkbox.set_tooltip_text("Check this box to setup the proxy you specified")
+        self.proxy_checkbox.set_active(self.enable_proxy)
+        self.proxy_checkbox.connect("toggled", self.proxy_checkbox_toggled_cb)
+        sub_vbox.pack_start(self.proxy_checkbox, expand=False, fill=False)
+
+        label = self.gen_label_widget("<span weight=\"bold\">Set all proxy:</span>")
+        tooltip = "Set the all proxy that will be used if the proxy for a URL isn't specified."
+        proxy_widget, self.all_proxy_text = self.gen_entry_widget(self.split_model, self.all_proxy, self, tooltip, False)
+        self.all_proxy_text.set_editable(self.enable_proxy)
+        self.all_proxy_text.set_sensitive(self.enable_proxy)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+
+        label = self.gen_label_widget("<span weight=\"bold\">Set http proxy:</span>")
+        tooltip = "Set the http proxy that will be used in do_fetch() source code"
+        proxy_widget, self.http_proxy_text = self.gen_entry_widget(self.split_model, self.http_proxy, self, tooltip, False)
+        self.http_proxy_text.set_editable(self.enable_proxy)
+        self.http_proxy_text.set_sensitive(self.enable_proxy)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+
+        label = self.gen_label_widget("<span weight=\"bold\">Set https proxy:</span>")
+        tooltip = "Set the https proxy that will be used in do_fetch() source code"
+        proxy_widget, self.https_proxy_text = self.gen_entry_widget(self.split_model, self.https_proxy, self, tooltip, False)
+        self.https_proxy_text.set_editable(self.enable_proxy)
+        self.https_proxy_text.set_sensitive(self.enable_proxy)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+
+        label = self.gen_label_widget("<span weight=\"bold\">Set ftp proxy:</span>")
+        tooltip = "Set the ftp proxy that will be used in do_fetch() source code"
+        proxy_widget, self.ftp_proxy_text = self.gen_entry_widget(self.split_model, self.ftp_proxy, self, tooltip, False)
+        self.ftp_proxy_text.set_editable(self.enable_proxy)
+        self.ftp_proxy_text.set_sensitive(self.enable_proxy)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+
+        return advanced_vbox
+
     def create_others_page(self):
         advanced_vbox = gtk.VBox(False, 6)
         advanced_vbox.set_border_width(6)
@@ -529,6 +585,17 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         return advanced_vbox
 
+    def proxy_checkbox_toggled_cb(self, button):
+        self.enable_proxy = self.proxy_checkbox.get_active()
+        self.all_proxy_text.set_editable(self.enable_proxy)
+        self.all_proxy_text.set_sensitive(self.enable_proxy)
+        self.http_proxy_text.set_editable(self.enable_proxy)
+        self.http_proxy_text.set_sensitive(self.enable_proxy)
+        self.https_proxy_text.set_editable(self.enable_proxy)
+        self.https_proxy_text.set_sensitive(self.enable_proxy)
+        self.ftp_proxy_text.set_editable(self.enable_proxy)
+        self.ftp_proxy_text.set_sensitive(self.enable_proxy)
+
     def response_cb(self, dialog, response_id):
         self.variables = {}
 
@@ -576,6 +643,11 @@ class AdvancedSettingDialog (CrumbsDialog):
             self.variables[key] = value
             it = self.setting_store.iter_next(it)
 
+        self.all_proxy = self.all_proxy_text.get_text()
+        self.http_proxy = self.http_proxy_text.get_text()
+        self.https_proxy = self.https_proxy_text.get_text()
+        self.ftp_proxy = self.ftp_proxy_text.get_text()
+
         md5 = hashlib.md5(str(sorted(self.variables.items()))).hexdigest()
         self.settings_changed = (self.md5 != md5)
 
-- 
1.7.6



