Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bogdan.a.marinescu@intel.com>) id 1TB1d3-0007q3-5n
	for bitbake-devel@lists.openembedded.org;
	Mon, 10 Sep 2012 12:54:09 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 10 Sep 2012 03:40:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,396,1344236400"; d="scan'208";a="190832224"
Received: from bogdanm (HELO localhost.localdomain) ([10.237.105.62])
	by azsmga001.ch.intel.com with ESMTP; 10 Sep 2012 03:40:33 -0700
From: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Sep 2012 13:42:57 +0300
Message-Id: <1347273777-26676-1-git-send-email-bogdan.a.marinescu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] [for-denzil] Save proxy settings
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
X-List-Received-Date: Mon, 10 Sep 2012 10:54:10 -0000

Proxy settings were not properly saved between Hob runs. This
fix is mostly a backport of code in master.

[YOCTO #3024]

Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |   18 ++++++++---
 bitbake/lib/bb/ui/crumbs/hig.py     |   58 +++++++++++++++++------------------
 2 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index df85326..000a838 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -70,6 +70,7 @@ class Configuration:
         self.all_proxy = self.http_proxy = self.ftp_proxy = self.https_proxy = ""
         self.git_proxy_host = self.git_proxy_port = ""
         self.cvs_proxy_host = self.cvs_proxy_port = ""
+        self.enable_proxy = None
 
     def clear_selection(self):
         self.selected_image = None
@@ -99,6 +100,9 @@ class Configuration:
         self.default_task = params["default_task"]
 
         # proxy settings
+        self.enable_proxy = params["http_proxy"] != "" or params["https_proxy"] != "" or params["ftp_proxy"] != "" \
+            or params["git_proxy_host"] != "" or params["git_proxy_port"] != ""                                    \
+            or params["cvs_proxy_host"] != "" or params["cvs_proxy_port"] != "" or params["all_proxy"] != ""
         self.all_proxy = params["all_proxy"]
         self.http_proxy = params["http_proxy"]
         self.ftp_proxy = params["ftp_proxy"]
@@ -146,6 +150,7 @@ class Configuration:
         self.selected_recipes = template.getVar("DEPENDS").split()
         self.selected_packages = template.getVar("IMAGE_INSTALL").split()
         # proxy
+        self.enable_proxy = eval(template.getVar("enable_proxy"))
         self.all_proxy = template.getVar("all_proxy")
         self.http_proxy = template.getVar("http_proxy")
         self.ftp_proxy = template.getVar("ftp_proxy")
@@ -183,6 +188,7 @@ class Configuration:
             template.setVar("DEPENDS", self.selected_recipes)
             template.setVar("IMAGE_INSTALL", self.user_selected_packages)
         # proxy
+        template.setVar("enable_proxy", self.enable_proxy)
         template.setVar("all_proxy", self.all_proxy)
         template.setVar("http_proxy", self.http_proxy)
         template.setVar("ftp_proxy", self.ftp_proxy)
@@ -212,7 +218,6 @@ class Parameters:
         self.all_sdk_machines = []
         self.all_layers = []
         self.image_names = []
-        self.enable_proxy = False
 
         # for build log to show
         self.bb_version = ""
@@ -581,13 +586,20 @@ class Builder(gtk.Window):
         self.handler.set_extra_inherit("packageinfo")
         self.handler.set_extra_inherit("image_types")
         # set proxies
-        if self.parameters.enable_proxy:
+        if self.configuration.enable_proxy == True:
             self.handler.set_http_proxy(self.configuration.http_proxy)
             self.handler.set_https_proxy(self.configuration.https_proxy)
             self.handler.set_ftp_proxy(self.configuration.ftp_proxy)
             self.handler.set_all_proxy(self.configuration.all_proxy)
             self.handler.set_git_proxy(self.configuration.git_proxy_host, self.configuration.git_proxy_port)
             self.handler.set_cvs_proxy(self.configuration.cvs_proxy_host, self.configuration.cvs_proxy_port)
+        elif self.configuration.enable_proxy == False:
+            self.handler.set_http_proxy('')
+            self.handler.set_https_proxy('')
+            self.handler.set_ftp_proxy('')
+            self.handler.set_all_proxy('')
+            self.handler.set_git_proxy('', '')
+            self.handler.set_cvs_proxy('', '')
 
     def update_recipe_model(self, selected_image, selected_recipes):
         self.recipe_model.set_selected_image(selected_image)
@@ -1009,7 +1021,6 @@ class Builder(gtk.Window):
             all_distros = self.parameters.all_distros,
             all_sdk_machines = self.parameters.all_sdk_machines,
             max_threads = self.parameters.max_threads,
-            enable_proxy = self.parameters.enable_proxy,
             parent = self,
             flags = gtk.DIALOG_MODAL
                     | gtk.DIALOG_DESTROY_WITH_PARENT
@@ -1021,7 +1032,6 @@ class Builder(gtk.Window):
         response = dialog.run()
         settings_changed = False
         if response == gtk.RESPONSE_YES:
-            self.parameters.enable_proxy = dialog.enable_proxy
             self.configuration = dialog.configuration
             self.save_defaults() # remember settings
             settings_changed = dialog.settings_changed
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 4baf960..b6c970b 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -309,7 +309,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
     def __init__(self, title, configuration, all_image_types,
             all_package_formats, all_distros, all_sdk_machines,
-            max_threads, enable_proxy, parent, flags, buttons=None):
+            max_threads, parent, flags, buttons=None):
         super(AdvancedSettingDialog, self).__init__(title, parent, flags, buttons)
 
         # class members from other objects
@@ -320,7 +320,6 @@ class AdvancedSettingDialog (CrumbsDialog):
         self.all_distros = all_distros
         self.all_sdk_machines = all_sdk_machines
         self.max_threads = max_threads
-        self.enable_proxy = enable_proxy
 
         # class members for internal use
         self.distro_combo = None
@@ -356,7 +355,8 @@ class AdvancedSettingDialog (CrumbsDialog):
         data += ("SDK_MACHINE: "          + self._get_sorted_value(self.configuration.curr_sdk_machine))
         data += ("TOOLCHAIN_BUILD: "      + self._get_sorted_value(self.configuration.toolchain_build))
         data += ("IMAGE_FSTYPES: "        + self._get_sorted_value(self.configuration.image_fstypes))
-        if self.enable_proxy:
+        data += ("ENABLE_PROXY: "         + self._get_sorted_value(self.configuration.enable_proxy))
+        if self.configuration.enable_proxy:
             data += ("ALL_PROXY: "            + self._get_sorted_value(self.configuration.all_proxy))
             data += ("HTTP_PROXY: "           + self._get_sorted_value(self.configuration.http_proxy))
             data += ("HTTPS_PROXY: "          + self._get_sorted_value(self.configuration.https_proxy))
@@ -531,55 +531,55 @@ class AdvancedSettingDialog (CrumbsDialog):
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         self.proxy_checkbox = gtk.CheckButton("Enable proxy")
         self.proxy_checkbox.set_tooltip_text("Check this box to setup the proxy you specified")
-        self.proxy_checkbox.set_active(self.enable_proxy)
+        self.proxy_checkbox.set_active(self.configuration.enable_proxy)
         self.proxy_checkbox.connect("toggled", self.proxy_checkbox_toggled_cb)
         sub_vbox.pack_start(self.proxy_checkbox, expand=False, fill=False)
 
         label = self.gen_label_widget("<span weight=\"bold\">Set all proxy:</span>")
         tooltip = "Set the all proxy that will be used if the proxy for a URL isn't specified."
         proxy_widget, self.all_proxy_text = self.gen_entry_widget(self.configuration.all_proxy, self, tooltip, False)
-        self.all_proxy_text.set_editable(self.enable_proxy)
-        self.all_proxy_text.set_sensitive(self.enable_proxy)
+        self.all_proxy_text.set_editable(self.configuration.enable_proxy)
+        self.all_proxy_text.set_sensitive(self.configuration.enable_proxy)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
 
         label = self.gen_label_widget("<span weight=\"bold\">Set http proxy:</span>")
         tooltip = "Set the http proxy that will be used in do_fetch() source code"
         proxy_widget, self.http_proxy_text = self.gen_entry_widget(self.configuration.http_proxy, self, tooltip, False)
-        self.http_proxy_text.set_editable(self.enable_proxy)
-        self.http_proxy_text.set_sensitive(self.enable_proxy)
+        self.http_proxy_text.set_editable(self.configuration.enable_proxy)
+        self.http_proxy_text.set_sensitive(self.configuration.enable_proxy)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
 
         label = self.gen_label_widget("<span weight=\"bold\">Set https proxy:</span>")
         tooltip = "Set the https proxy that will be used in do_fetch() source code"
         proxy_widget, self.https_proxy_text = self.gen_entry_widget(self.configuration.https_proxy, self, tooltip, False)
-        self.https_proxy_text.set_editable(self.enable_proxy)
-        self.https_proxy_text.set_sensitive(self.enable_proxy)
+        self.https_proxy_text.set_editable(self.configuration.enable_proxy)
+        self.https_proxy_text.set_sensitive(self.configuration.enable_proxy)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
 
         label = self.gen_label_widget("<span weight=\"bold\">Set ftp proxy:</span>")
         tooltip = "Set the ftp proxy that will be used in do_fetch() source code"
         proxy_widget, self.ftp_proxy_text = self.gen_entry_widget(self.configuration.ftp_proxy, self, tooltip, False)
-        self.ftp_proxy_text.set_editable(self.enable_proxy)
-        self.ftp_proxy_text.set_sensitive(self.enable_proxy)
+        self.ftp_proxy_text.set_editable(self.configuration.enable_proxy)
+        self.ftp_proxy_text.set_sensitive(self.configuration.enable_proxy)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
 
         label = self.gen_label_widget("<span weight=\"bold\">Set git proxy:</span>")
         tooltip = "Set the git proxy that will be used in do_fetch() source code"
         proxy_widget, self.git_proxy_text = self.gen_entry_widget(self.configuration.git_proxy_host + ':' + self.configuration.git_proxy_port, self, tooltip, False)
-        self.git_proxy_text.set_editable(self.enable_proxy)
-        self.git_proxy_text.set_sensitive(self.enable_proxy)
+        self.git_proxy_text.set_editable(self.configuration.enable_proxy)
+        self.git_proxy_text.set_sensitive(self.configuration.enable_proxy)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
 
         label = self.gen_label_widget("<span weight=\"bold\">Set cvs proxy:</span>")
         tooltip = "Set the cvs proxy that will be used in do_fetch() source code"
         proxy_widget, self.cvs_proxy_text = self.gen_entry_widget(self.configuration.cvs_proxy_host + ':' + self.configuration.cvs_proxy_port, self, tooltip, False)
-        self.cvs_proxy_text.set_editable(self.enable_proxy)
-        self.cvs_proxy_text.set_sensitive(self.enable_proxy)
+        self.cvs_proxy_text.set_editable(self.configuration.enable_proxy)
+        self.cvs_proxy_text.set_sensitive(self.configuration.enable_proxy)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
 
@@ -600,19 +600,19 @@ class AdvancedSettingDialog (CrumbsDialog):
         return advanced_vbox
 
     def proxy_checkbox_toggled_cb(self, button):
-        self.enable_proxy = self.proxy_checkbox.get_active()
-        self.all_proxy_text.set_editable(self.enable_proxy)
-        self.all_proxy_text.set_sensitive(self.enable_proxy)
-        self.http_proxy_text.set_editable(self.enable_proxy)
-        self.http_proxy_text.set_sensitive(self.enable_proxy)
-        self.https_proxy_text.set_editable(self.enable_proxy)
-        self.https_proxy_text.set_sensitive(self.enable_proxy)
-        self.ftp_proxy_text.set_editable(self.enable_proxy)
-        self.ftp_proxy_text.set_sensitive(self.enable_proxy)
-        self.git_proxy_text.set_editable(self.enable_proxy)
-        self.git_proxy_text.set_sensitive(self.enable_proxy)
-        self.cvs_proxy_text.set_editable(self.enable_proxy)
-        self.cvs_proxy_text.set_sensitive(self.enable_proxy)
+        self.configuration.enable_proxy = self.proxy_checkbox.get_active()
+        self.all_proxy_text.set_editable(self.configuration.enable_proxy)
+        self.all_proxy_text.set_sensitive(self.configuration.enable_proxy)
+        self.http_proxy_text.set_editable(self.configuration.enable_proxy)
+        self.http_proxy_text.set_sensitive(self.configuration.enable_proxy)
+        self.https_proxy_text.set_editable(self.configuration.enable_proxy)
+        self.https_proxy_text.set_sensitive(self.configuration.enable_proxy)
+        self.ftp_proxy_text.set_editable(self.configuration.enable_proxy)
+        self.ftp_proxy_text.set_sensitive(self.configuration.enable_proxy)
+        self.git_proxy_text.set_editable(self.configuration.enable_proxy)
+        self.git_proxy_text.set_sensitive(self.configuration.enable_proxy)
+        self.cvs_proxy_text.set_editable(self.configuration.enable_proxy)
+        self.cvs_proxy_text.set_sensitive(self.configuration.enable_proxy)
 
     def response_cb(self, dialog, response_id):
         package_format = []
-- 
1.7.9.5



