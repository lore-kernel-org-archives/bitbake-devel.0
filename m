Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SCRrC-0001Be-IM
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 10:34:23 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 27 Mar 2012 01:25:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="125522622"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 27 Mar 2012 01:25:23 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Mar 2012 16:51:42 +0800
Message-Id: <9c88b26cbfcdc7e08bf33dcdc2c26ce156d49698.1332838207.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1332838207.git.shane.wang@intel.com>
References: <cover.1332838207.git.shane.wang@intel.com>
Subject: [PATCH 1/1] Hob: allow users to setup the proxies
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
X-List-Received-Date: Tue, 27 Mar 2012 08:34:23 -0000

This patch is to read the proxy variables such as all_proxy, http_proxy, https_proxy, ftp_proxy, GIT_PROXY_HOST, GIT_PROXY_PORT, CVS_PROXY_HOST, and CVS_PROXY_PORT from the bitbake server, show them on the Settings dialog for users to change and set proxies for the build.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py         |   39 +++++++++
 bitbake/lib/bb/ui/crumbs/hig.py             |  111 ++++++++++++++++++++++++---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |   32 ++++++++
 3 files changed, 171 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index f32a066..40aa767 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -68,6 +68,16 @@ class Configuration:
         self.selected_recipes = []
         self.selected_packages = []
 
+        # proxy settings
+        self.all_proxy = params["all_proxy"]
+        self.http_proxy = params["http_proxy"]
+        self.ftp_proxy = params["ftp_proxy"]
+        self.https_proxy = params["https_proxy"]
+        self.git_proxy_host = params["git_proxy_host"]
+        self.git_proxy_port = params["git_proxy_port"]
+        self.cvs_proxy_host = params["cvs_proxy_host"]
+        self.cvs_proxy_port = params["cvs_proxy_port"]
+
     def load(self, template):
         self.curr_mach = template.getVar("MACHINE")
         self.curr_package_format = " ".join(template.getVar("PACKAGE_CLASSES").split("package_")).strip()
@@ -93,6 +103,15 @@ class Configuration:
         self.selected_image = template.getVar("__SELECTED_IMAGE__")
         self.selected_recipes = template.getVar("DEPENDS").split()
         self.selected_packages = template.getVar("IMAGE_INSTALL").split()
+        # proxy
+        self.all_proxy = template.getVar("all_proxy")
+        self.http_proxy = template.getVar("http_proxy")
+        self.ftp_proxy = template.getVar("ftp_proxy")
+        self.https_proxy = template.getVar("https_proxy")
+        self.git_proxy_host = template.getVar("GIT_PROXY_HOST")
+        self.git_proxy_port = template.getVar("GIT_PROXY_PORT")
+        self.cvs_proxy_host = template.getVar("CVS_PROXY_HOST")
+        self.cvs_proxy_port = template.getVar("CVS_PROXY_PORT")
 
     def save(self, template, filename):
         # bblayers.conf
@@ -120,6 +139,15 @@ class Configuration:
         template.setVar("__SELECTED_IMAGE__", self.selected_image)
         template.setVar("DEPENDS", self.selected_recipes)
         template.setVar("IMAGE_INSTALL", self.selected_packages)
+        # proxy
+        template.setVar("all_proxy", self.all_proxy)
+        template.setVar("http_proxy", self.http_proxy)
+        template.setVar("ftp_proxy", self.ftp_proxy)
+        template.setVar("https_proxy", self.https_proxy)
+        template.setVar("GIT_PROXY_HOST", self.git_proxy_host)
+        template.setVar("GIT_PROXY_PORT", self.git_proxy_port)
+        template.setVar("CVS_PROXY_HOST", self.cvs_proxy_host)
+        template.setVar("CVS_PROXY_PORT", self.cvs_proxy_port)
 
 class Parameters:
     '''Represents other variables like available machines, etc.'''
@@ -140,6 +168,7 @@ class Parameters:
         self.runnable_machine_patterns = params["runnable_machine_patterns"].split()
         self.deployable_image_types = params["deployable_image_types"].split()
         self.tmpdir = params["tmpdir"]
+        self.enable_proxy = False
 
 class Builder(gtk.Window):
 
@@ -367,6 +396,14 @@ class Builder(gtk.Window):
         self.handler.set_image_fstypes(self.configuration.image_fstypes)
         self.handler.set_extra_config(self.configuration.extra_setting)
         self.handler.set_extra_inherit("packageinfo")
+        # set proxies
+        if self.parameters.enable_proxy:
+            self.handler.set_http_proxy(self.configuration.http_proxy)
+            self.handler.set_https_proxy(self.configuration.https_proxy)
+            self.handler.set_ftp_proxy(self.configuration.ftp_proxy)
+            self.handler.set_all_proxy(self.configuration.all_proxy)
+            self.handler.set_git_proxy(self.configuration.git_proxy_host, self.configuration.git_proxy_port)
+            self.handler.set_cvs_proxy(self.configuration.cvs_proxy_host, self.configuration.cvs_proxy_port)
 
     def update_recipe_model(self, selected_image, selected_recipes):
         self.recipe_model.set_selected_image(selected_image)
@@ -753,6 +790,7 @@ class Builder(gtk.Window):
             all_distros = self.parameters.all_distros,
             all_sdk_machines = self.parameters.all_sdk_machines,
             max_threads = self.parameters.max_threads,
+            enable_proxy = self.parameters.enable_proxy,
             parent = self,
             flags = gtk.DIALOG_MODAL
                     | gtk.DIALOG_DESTROY_WITH_PARENT
@@ -761,6 +799,7 @@ class Builder(gtk.Window):
                        "Save", gtk.RESPONSE_YES))
         response = dialog.run()
         if response == gtk.RESPONSE_YES:
+            self.parameters.enable_proxy = dialog.enable_proxy
             self.configuration = dialog.configuration
             # DO reparse recipes
             if dialog.settings_changed:
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 6ae682b..6f7cba8 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -147,20 +147,23 @@ class AdvancedSettingDialog (CrumbsDialog):
 
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
@@ -307,7 +310,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
     def __init__(self, title, configuration, all_image_types,
             all_package_formats, all_distros, all_sdk_machines,
-            max_threads, parent, flags, buttons):
+            max_threads, enable_proxy, parent, flags, buttons):
         super(AdvancedSettingDialog, self).__init__(title, parent, flags, buttons)
 
         # class members from other objects
@@ -318,6 +321,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         self.all_distros = all_distros
         self.all_sdk_machines = all_sdk_machines
         self.max_threads = max_threads
+        self.enable_proxy = enable_proxy
 
         # class members for internal use
         self.distro_combo = None
@@ -352,6 +356,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         self.nb.append_page(self.create_image_types_page(), gtk.Label("Image types"))
         self.nb.append_page(self.create_output_page(), gtk.Label("Output"))
         self.nb.append_page(self.create_build_environment_page(), gtk.Label("Build environment"))
+        self.nb.append_page(self.create_proxy_page(), gtk.Label("Proxies"))
         self.nb.append_page(self.create_others_page(), gtk.Label("Others"))
         self.nb.set_current_page(0)
         self.vbox.pack_start(self.nb, expand=True, fill=True)
@@ -492,6 +497,68 @@ class AdvancedSettingDialog (CrumbsDialog):
 
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
+        proxy_widget, self.all_proxy_text = self.gen_entry_widget(self.configuration.all_proxy, self, tooltip, False)
+        self.all_proxy_text.set_editable(self.enable_proxy)
+        self.all_proxy_text.set_sensitive(self.enable_proxy)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+
+        label = self.gen_label_widget("<span weight=\"bold\">Set http proxy:</span>")
+        tooltip = "Set the http proxy that will be used in do_fetch() source code"
+        proxy_widget, self.http_proxy_text = self.gen_entry_widget(self.configuration.http_proxy, self, tooltip, False)
+        self.http_proxy_text.set_editable(self.enable_proxy)
+        self.http_proxy_text.set_sensitive(self.enable_proxy)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+
+        label = self.gen_label_widget("<span weight=\"bold\">Set https proxy:</span>")
+        tooltip = "Set the https proxy that will be used in do_fetch() source code"
+        proxy_widget, self.https_proxy_text = self.gen_entry_widget(self.configuration.https_proxy, self, tooltip, False)
+        self.https_proxy_text.set_editable(self.enable_proxy)
+        self.https_proxy_text.set_sensitive(self.enable_proxy)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+
+        label = self.gen_label_widget("<span weight=\"bold\">Set ftp proxy:</span>")
+        tooltip = "Set the ftp proxy that will be used in do_fetch() source code"
+        proxy_widget, self.ftp_proxy_text = self.gen_entry_widget(self.configuration.ftp_proxy, self, tooltip, False)
+        self.ftp_proxy_text.set_editable(self.enable_proxy)
+        self.ftp_proxy_text.set_sensitive(self.enable_proxy)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+
+        label = self.gen_label_widget("<span weight=\"bold\">Set git proxy:</span>")
+        tooltip = "Set the git proxy that will be used in do_fetch() source code"
+        proxy_widget, self.git_proxy_text = self.gen_entry_widget(self.configuration.git_proxy_host + ':' + self.configuration.git_proxy_port, self, tooltip, False)
+        self.git_proxy_text.set_editable(self.enable_proxy)
+        self.git_proxy_text.set_sensitive(self.enable_proxy)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+
+        label = self.gen_label_widget("<span weight=\"bold\">Set cvs proxy:</span>")
+        tooltip = "Set the cvs proxy that will be used in do_fetch() source code"
+        proxy_widget, self.cvs_proxy_text = self.gen_entry_widget(self.configuration.cvs_proxy_host + ':' + self.configuration.cvs_proxy_port, self, tooltip, False)
+        self.cvs_proxy_text.set_editable(self.enable_proxy)
+        self.cvs_proxy_text.set_sensitive(self.enable_proxy)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+
+        return advanced_vbox
+
     def create_others_page(self):
         advanced_vbox = gtk.VBox(False, 6)
         advanced_vbox.set_border_width(6)
@@ -506,6 +573,21 @@ class AdvancedSettingDialog (CrumbsDialog):
 
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
+        self.git_proxy_text.set_editable(self.enable_proxy)
+        self.git_proxy_text.set_sensitive(self.enable_proxy)
+        self.cvs_proxy_text.set_editable(self.enable_proxy)
+        self.cvs_proxy_text.set_sensitive(self.enable_proxy)
+
     def response_cb(self, dialog, response_id):
         self.variables = {}
 
@@ -553,6 +635,13 @@ class AdvancedSettingDialog (CrumbsDialog):
             self.variables[key] = value
             it = self.setting_store.iter_next(it)
 
+        self.configuration.all_proxy = self.all_proxy_text.get_text()
+        self.configuration.http_proxy = self.http_proxy_text.get_text()
+        self.configuration.https_proxy = self.https_proxy_text.get_text()
+        self.configuration.ftp_proxy = self.ftp_proxy_text.get_text()
+        self.configuration.git_proxy_host, self.configuration.git_proxy_port = self.git_proxy_text.get_text().split(':')
+        self.configuration.cvs_proxy_host, self.configuration.cvs_proxy_port = self.cvs_proxy_text.get_text().split(':')
+
         md5 = hashlib.md5(str(sorted(self.variables.items()))).hexdigest()
         self.settings_changed = (self.md5 != md5)
 
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 8042fbd..8330b00 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -313,6 +313,26 @@ class HobHandler(gobject.GObject):
             value = extra_setting[key]
             self.server.runCommand(["setVariable", key, value])
 
+    def set_http_proxy(self, http_proxy):
+        self.server.runCommand(["setVariable", "http_proxy", http_proxy])
+
+    def set_https_proxy(self, https_proxy):
+        self.server.runCommand(["setVariable", "https_proxy", https_proxy])
+
+    def set_ftp_proxy(self, ftp_proxy):
+        self.server.runCommand(["setVariable", "ftp_proxy", ftp_proxy])
+
+    def set_all_proxy(self, all_proxy):
+        self.server.runCommand(["setVariable", "all_proxy", all_proxy])
+
+    def set_git_proxy(self, host, port):
+        self.server.runCommand(["setVariable", "GIT_PROXY_HOST", host])
+        self.server.runCommand(["setVariable", "GIT_PROXY_PORT", port])
+
+    def set_cvs_proxy(self, host, port):
+        self.server.runCommand(["setVariable", "CVS_PROXY_HOST", host])
+        self.server.runCommand(["setVariable", "CVS_PROXY_PORT", port])
+
     def request_package_info_async(self):
         self.commands_async.append(self.SUB_GENERATE_PKGINFO)
         self.run_next_command(self.POPULATE_PACKAGEINFO)
@@ -440,4 +460,16 @@ class HobHandler(gobject.GObject):
         params["runnable_machine_patterns"] = self.server.runCommand(["getVariable", "RUNNABLE_MACHINE_PATTERNS"]) or ""
         params["deployable_image_types"] = self.server.runCommand(["getVariable", "DEPLOYABLE_IMAGE_TYPES"]) or ""
         params["tmpdir"] = self.server.runCommand(["getVariable", "TMPDIR"]) or ""
+
+        params["git_proxy_host"] = self.server.runCommand(["getVariable", "GIT_PROXY_HOST"]) or ""
+        params["git_proxy_port"] = self.server.runCommand(["getVariable", "GIT_PROXY_PORT"]) or ""
+
+        params["http_proxy"] = self.server.runCommand(["getVariable", "http_proxy"]) or ""
+        params["ftp_proxy"] = self.server.runCommand(["getVariable", "ftp_proxy"]) or ""
+        params["https_proxy"] = self.server.runCommand(["getVariable", "https_proxy"]) or ""
+        params["all_proxy"] = self.server.runCommand(["getVariable", "all_proxy"]) or ""
+
+        params["cvs_proxy_host"] = self.server.runCommand(["getVariable", "CVS_PROXY_HOST"]) or ""
+        params["cvs_proxy_port"] = self.server.runCommand(["getVariable", "CVS_PROXY_PORT"]) or ""
+
         return params
-- 
1.7.6



