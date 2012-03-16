Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S8Yeq-0006js-Sd
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Mar 2012 16:01:33 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 16 Mar 2012 07:52:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="119802143"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by azsmga001.ch.intel.com with ESMTP; 16 Mar 2012 07:52:43 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Mar 2012 23:10:11 +0800
Message-Id: <1a7d9a990627f74a94712aa2ca9f4bece2ed6511.1331910234.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <8dafade95596191e9998acc05dcf7c34737d70c1.1331910234.git.shane.wang@intel.com>
References: <8dafade95596191e9998acc05dcf7c34737d70c1.1331910234.git.shane.wang@intel.com>
In-Reply-To: <cover.1331910234.git.shane.wang@intel.com>
References: <cover.1331910234.git.shane.wang@intel.com>
Subject: [PATCH 06/12] Hob: allow users to setup the proxies
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
X-List-Received-Date: Fri, 16 Mar 2012 15:01:33 -0000

This patch is to set os.environ to allow users to set the environment variables for http_proxy, https_proxy and ftp_proxy.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |   36 +++++++++++++++
 bitbake/lib/bb/ui/crumbs/hig.py     |   82 ++++++++++++++++++++++++++++++-----
 2 files changed, 107 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 318bcbf..7f3ae2a 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -116,6 +116,7 @@ class Configuration:
 
 class Parameters:
     '''Represents other variables like available machines, etc.'''
+    __dummy_proxy__ = "myproxy.example.com:8010"
 
     def __init__(self, params):
         # Variables
@@ -129,6 +130,8 @@ class Parameters:
         self.image_names = []
         self.image_addr = params["image_addr"]
         self.image_types = params["image_types"].split()
+        self.http_proxy = self.https_proxy = self.ftp_proxy = self.__dummy_proxy__
+        self.enable_proxy = False
 
 class Builder(gtk.Window):
 
@@ -734,6 +737,28 @@ class Builder(gtk.Window):
 
         dialog.destroy()
 
+    def _setup_proxy(self):
+        if (self.parameters.http_proxy == Parameters.__dummy_proxy__ \
+            or self.parameters.http_proxy.lstrip() == "")            \
+           and "http_proxy" in os.environ.keys():
+            del os.environ["http_proxy"]
+        else:
+            os.environ["http_proxy"] = self.parameters.http_proxy
+
+        if (self.parameters.https_proxy == Parameters.__dummy_proxy__ \
+            or self.parameters.https_proxy.lstrip() == "")            \
+           and "https_proxy" in os.environ.keys():
+            del os.environ["https_proxy"]
+        else:
+            os.environ["https_proxy"] = self.parameters.https_proxy
+
+        if (self.parameters.ftp_proxy == Parameters.__dummy_proxy__ \
+            or self.parameters.ftp_proxy.lstrip() == "")            \
+           and "ftp_proxy" in os.environ.keys():
+            del os.environ["ftp_proxy"]
+        else:
+            os.environ["ftp_proxy"] = self.parameters.ftp_proxy
+
     def show_adv_settings_dialog(self):
         dialog = AdvancedSettingDialog(title = "Settings",
             configuration = copy.deepcopy(self.configuration),
@@ -742,6 +767,10 @@ class Builder(gtk.Window):
             all_distros = self.parameters.all_distros,
             all_sdk_machines = self.parameters.all_sdk_machines,
             max_threads = self.parameters.max_threads,
+            http_proxy = self.parameters.http_proxy,
+            https_proxy = self.parameters.https_proxy,
+            ftp_proxy = self.parameters.ftp_proxy,
+            enable_proxy = self.parameters.enable_proxy,
             split_model = self.get_split_model(),
             parent = self,
             flags = gtk.DIALOG_MODAL
@@ -752,6 +781,13 @@ class Builder(gtk.Window):
         response = dialog.run()
         if response == gtk.RESPONSE_YES:
             self.configuration = dialog.configuration
+            # setup the proxy
+            self.parameters.enable_proxy = dialog.enable_proxy
+            if self.parameters.enable_proxy == True:
+                self.parameters.http_proxy = dialog.http_proxy
+                self.parameters.https_proxy = dialog.https_proxy
+                self.parameters.ftp_proxy = dialog.ftp_proxy
+                self._setup_proxy()
             # DO reparse recipes
             if dialog.settings_changed:
                 if self.configuration.curr_mach == "":
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 67cc94e..6122839 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -170,7 +170,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         dialog.destroy()
 
-    def gen_entry_widget(self, split_model, content, parent, tooltip=""):
+    def gen_entry_widget(self, split_model, content, parent, tooltip="", need_button=True):
         hbox = gtk.HBox(False, 12)
         entry = gtk.Entry()
         entry.set_text(content)
@@ -178,15 +178,18 @@ class AdvancedSettingDialog (CrumbsDialog):
         if split_model:
             hbox.pack_start(entry, expand=True, fill=True)
         else:
-            table = gtk.Table(1, 10, True)
-            hbox.pack_start(table, expand=True, fill=True)
-            table.attach(entry, 0, 9, 0, 1)
-            image = gtk.Image()
-            image.set_from_stock(gtk.STOCK_OPEN,gtk.ICON_SIZE_BUTTON)
-            open_button = gtk.Button()
-            open_button.set_image(image)
-            open_button.connect("clicked", self.entry_widget_select_path_cb, parent, entry)
-            table.attach(open_button, 9, 10, 0, 1)
+            if need_button:
+                table = gtk.Table(1, 10, True)
+                hbox.pack_start(table, expand=True, fill=True)
+                table.attach(entry, 0, 9, 0, 1)
+                image = gtk.Image()
+                image.set_from_stock(gtk.STOCK_OPEN,gtk.ICON_SIZE_BUTTON)
+                open_button = gtk.Button()
+                open_button.set_image(image)
+                open_button.connect("clicked", self.entry_widget_select_path_cb, parent, entry)
+                table.attach(open_button, 9, 10, 0, 1)
+            else:
+                hbox.pack_start(entry, expand=True, fill=True)
 
         info = HobInfoButton(tooltip, self)
         hbox.pack_start(info, expand=False, fill=False)
@@ -421,7 +424,8 @@ class AdvancedSettingDialog (CrumbsDialog):
 
     def __init__(self, title, configuration, all_image_types,
             all_package_formats, all_distros, all_sdk_machines,
-            max_threads, split_model, parent, flags, buttons):
+            max_threads, http_proxy, https_proxy, ftp_proxy,
+            enable_proxy, split_model, parent, flags, buttons):
         super(AdvancedSettingDialog, self).__init__(title, parent, flags, buttons)
 
         # class members from other objects
@@ -432,6 +436,10 @@ class AdvancedSettingDialog (CrumbsDialog):
         self.all_distros = all_distros
         self.all_sdk_machines = all_sdk_machines
         self.max_threads = max_threads
+        self.http_proxy = http_proxy
+        self.https_proxy = https_proxy
+        self.ftp_proxy = ftp_proxy
+        self.enable_proxy = enable_proxy
         self.split_model = split_model 
 
         # class members for internal use
@@ -466,6 +474,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         self.nb.append_page(self.create_image_types_page(), gtk.Label("Image types"))
         self.nb.append_page(self.create_output_page(), gtk.Label("Output"))
         self.nb.append_page(self.create_build_environment_page(), gtk.Label("Build environment"))
+        self.nb.append_page(self.create_proxy_page(), gtk.Label("Proxies"))
         self.nb.append_page(self.create_others_page(), gtk.Label("Others"))
         self.nb.set_current_page(0)
         self.vbox.pack_start(self.nb, expand=True, fill=True)
@@ -606,6 +615,44 @@ class AdvancedSettingDialog (CrumbsDialog):
 
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
+        label = self.gen_label_widget("<span weight=\"bold\">Select HTTP Proxy:</span>")
+        tooltip = "Select the HTTP proxy that will be used in do_fetch() source code"
+        proxy_widget, self.http_proxy_text = self.gen_entry_widget(self.split_model, self.http_proxy, self, tooltip, False)
+        self.http_proxy_text.set_editable(self.enable_proxy)
+        self.http_proxy_text.set_sensitive(self.enable_proxy)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+
+        label = self.gen_label_widget("<span weight=\"bold\">Select HTTPS Proxy:</span>")
+        tooltip = "Select the HTTPS proxy that will be used in do_fetch() source code"
+        proxy_widget, self.https_proxy_text = self.gen_entry_widget(self.split_model, self.https_proxy, self, tooltip, False)
+        self.https_proxy_text.set_editable(self.enable_proxy)
+        self.https_proxy_text.set_sensitive(self.enable_proxy)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+
+        label = self.gen_label_widget("<span weight=\"bold\">Select FTP Proxy:</span>")
+        tooltip = "Select the FTP proxy that will be used in do_fetch() source code"
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
@@ -620,6 +667,15 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         return advanced_vbox
 
+    def proxy_checkbox_toggled_cb(self, button):
+        self.enable_proxy = self.proxy_checkbox.get_active()
+        self.http_proxy_text.set_editable(self.enable_proxy)
+        self.http_proxy_text.set_sensitive(self.enable_proxy)
+        self.https_proxy_text.set_editable(self.enable_proxy)
+        self.https_proxy_text.set_sensitive(self.enable_proxy)
+        self.ftp_proxy_text.set_editable(self.enable_proxy)
+        self.ftp_proxy_text.set_sensitive(self.enable_proxy)
+
     def response_cb(self, dialog, response_id):
         self.variables = {}
 
@@ -669,6 +725,10 @@ class AdvancedSettingDialog (CrumbsDialog):
             self.variables[key] = value
             it = self.setting_store.iter_next(it)
 
+        self.http_proxy = self.http_proxy_text.get_text()
+        self.https_proxy = self.https_proxy_text.get_text()
+        self.ftp_proxy = self.ftp_proxy_text.get_text()
+
         md5 = hashlib.md5(str(sorted(self.variables.items()))).hexdigest()
         self.settings_changed = (self.md5 != md5)
 
-- 
1.7.6



