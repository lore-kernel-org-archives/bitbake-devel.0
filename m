Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SWmwn-0006LF-Hf
	for bitbake-devel@lists.openembedded.org;
	Tue, 22 May 2012 13:08:14 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 22 May 2012 03:58:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="146872081"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 22 May 2012 03:58:03 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 22 May 2012 19:33:23 +0800
Message-Id: <bde495124949bd5da28f5667a7f622d712d52b90.1337686256.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1337686256.git.shane.wang@intel.com>
References: <cover.1337686256.git.shane.wang@intel.com>
Subject: [PATCH 1/1] Hob: reimplement the proxy page
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
X-List-Received-Date: Tue, 22 May 2012 11:08:14 -0000

This patch is to reimplement the proxy page in the "Advanced Settings" dialog
per the new design in https://bugzilla.yoctoproject.org/attachment.cgi?id=442
and https://bugzilla.yoctoproject.org/attachment.cgi?id=443.

[Yocto #2247]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py         |  143 +++++++++++----
 bitbake/lib/bb/ui/crumbs/hig.py             |  273 ++++++++++++++++++++-------
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    4 -
 3 files changed, 309 insertions(+), 111 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 42d0f2c..3282fdf 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -26,6 +26,7 @@ import copy
 import os
 import subprocess
 import shlex
+import re
 from bb.ui.crumbs.template import TemplateMgr
 from bb.ui.crumbs.imageconfigurationpage import ImageConfigurationPage
 from bb.ui.crumbs.recipeselectionpage import RecipeSelectionPage
@@ -42,6 +43,44 @@ import bb.ui.crumbs.utils
 class Configuration:
     '''Represents the data structure of configuration.'''
 
+    @classmethod
+    def parse_proxy_string(cls, proxy):
+        pattern = "^\s*((http|https|ftp|git|cvs)://)?((\S+):(\S+)@)?(\S+):(\d+)/?"
+        match = re.search(pattern, proxy)
+        if match:
+            return match.group(2), match.group(4), match.group(5), match.group(6), match.group(7)
+        else:
+            return None, None, None, "", ""
+
+    @classmethod
+    def make_host_string(cls, prot, user, passwd, host, default_prot=""):
+        if host == None or host == "":
+            return ""
+
+        passwd = passwd or ""
+
+        if user != None and user != "":
+            if prot == None or prot == "":
+                prot = default_prot
+            return prot + "://" + user + ":" + passwd + "@" + host
+        else:
+            if prot == None or prot == "":
+                return host
+            else:
+                return prot + "://" + host
+
+    @classmethod
+    def make_port_string(cls, port):
+        port = port or ""
+        return port
+
+    @classmethod
+    def make_proxy_string(cls, prot, user, passwd, host, port, default_prot=""):
+        if host == None or host == "" or port == None or port == "":
+            return ""
+
+        return Configuration.make_host_string(prot, user, passwd, host, default_prot) + ":" + Configuration.make_port_string(port)
+
     def __init__(self):
         self.curr_mach = ""
         # settings
@@ -67,15 +106,43 @@ class Configuration:
         self.default_task = "build"
 
         # proxy settings
-        self.all_proxy = self.http_proxy = self.ftp_proxy = self.https_proxy = ""
-        self.git_proxy_host = self.git_proxy_port = ""
-        self.cvs_proxy_host = self.cvs_proxy_port = ""
+        self.enable_proxy = None
+        self.same_proxy = False
+        self.proxies = {
+            "http"  : [None, None, None, "", ""],  # protocol : [prot, user, passwd, host, port]
+            "https" : [None, None, None, "", ""],
+            "ftp"   : [None, None, None, "", ""],
+            "git"   : [None, None, None, "", ""],
+            "cvs"   : [None, None, None, "", ""],
+        }
 
     def clear_selection(self):
         self.selected_image = None
         self.selected_recipes = []
         self.selected_packages = []
 
+    def split_proxy(self, protocol, proxy):
+        entry = []
+        prot, user, passwd, host, port = Configuration.parse_proxy_string(proxy)
+        entry.append(prot)
+        entry.append(user)
+        entry.append(passwd)
+        entry.append(host)
+        entry.append(port)
+        self.proxies[protocol] = entry
+
+    def combine_proxy(self, protocol):
+        entry = self.proxies[protocol]
+        return Configuration.make_proxy_string(entry[0], entry[1], entry[2], entry[3], entry[4], protocol)
+
+    def combine_host_only(self, protocol):
+        entry = self.proxies[protocol]
+        return Configuration.make_host_string(entry[0], entry[1], entry[2], entry[3], protocol)
+
+    def combine_port_only(self, protocol):
+        entry = self.proxies[protocol]
+        return Configuration.make_port_string(entry[4])
+
     def update(self, params):
         # settings
         self.curr_distro = params["distro"]
@@ -99,14 +166,14 @@ class Configuration:
         self.default_task = params["default_task"]
 
         # proxy settings
-        self.all_proxy = params["all_proxy"]
-        self.http_proxy = params["http_proxy"]
-        self.ftp_proxy = params["ftp_proxy"]
-        self.https_proxy = params["https_proxy"]
-        self.git_proxy_host = params["git_proxy_host"]
-        self.git_proxy_port = params["git_proxy_port"]
-        self.cvs_proxy_host = params["cvs_proxy_host"]
-        self.cvs_proxy_port = params["cvs_proxy_port"]
+        self.enable_proxy = params["http_proxy"] != "" or params["https_proxy"] != "" or params["ftp_proxy"] != "" \
+            or params["git_proxy_host"] != "" or params["git_proxy_port"] != ""                                    \
+            or params["cvs_proxy_host"] != "" or params["cvs_proxy_port"] != ""
+        self.split_proxy("http", params["http_proxy"])
+        self.split_proxy("https", params["https_proxy"])
+        self.split_proxy("ftp", params["ftp_proxy"])
+        self.split_proxy("git", params["git_proxy_host"] + ":" + params["git_proxy_port"])
+        self.split_proxy("cvs", params["cvs_proxy_host"] + ":" + params["cvs_proxy_port"])
 
     def load(self, template):
         self.curr_mach = template.getVar("MACHINE")
@@ -146,14 +213,13 @@ class Configuration:
         self.selected_recipes = template.getVar("DEPENDS").split()
         self.selected_packages = template.getVar("IMAGE_INSTALL").split()
         # proxy
-        self.all_proxy = template.getVar("all_proxy")
-        self.http_proxy = template.getVar("http_proxy")
-        self.ftp_proxy = template.getVar("ftp_proxy")
-        self.https_proxy = template.getVar("https_proxy")
-        self.git_proxy_host = template.getVar("GIT_PROXY_HOST")
-        self.git_proxy_port = template.getVar("GIT_PROXY_PORT")
-        self.cvs_proxy_host = template.getVar("CVS_PROXY_HOST")
-        self.cvs_proxy_port = template.getVar("CVS_PROXY_PORT")
+        self.enable_proxy = eval(template.getVar("enable_proxy"))
+        self.same_proxy = eval(template.getVar("use_same_proxy"))
+        self.split_proxy("http", template.getVar("http_proxy"))
+        self.split_proxy("https", template.getVar("https_proxy"))
+        self.split_proxy("ftp", template.getVar("ftp_proxy"))
+        self.split_proxy("git", template.getVar("GIT_PROXY_HOST") + ":" + template.getVar("GIT_PROXY_PORT"))
+        self.split_proxy("cvs", template.getVar("CVS_PROXY_HOST") + ":" + template.getVar("CVS_PROXY_PORT"))
 
     def save(self, template, defaults=False):
         # bblayers.conf
@@ -183,14 +249,15 @@ class Configuration:
             template.setVar("DEPENDS", self.selected_recipes)
             template.setVar("IMAGE_INSTALL", self.user_selected_packages)
         # proxy
-        template.setVar("all_proxy", self.all_proxy)
-        template.setVar("http_proxy", self.http_proxy)
-        template.setVar("ftp_proxy", self.ftp_proxy)
-        template.setVar("https_proxy", self.https_proxy)
-        template.setVar("GIT_PROXY_HOST", self.git_proxy_host)
-        template.setVar("GIT_PROXY_PORT", self.git_proxy_port)
-        template.setVar("CVS_PROXY_HOST", self.cvs_proxy_host)
-        template.setVar("CVS_PROXY_PORT", self.cvs_proxy_port)
+        template.setVar("enable_proxy", self.enable_proxy)
+        template.setVar("use_same_proxy", self.same_proxy)
+        template.setVar("http_proxy", self.combine_proxy("http"))
+        template.setVar("https_proxy", self.combine_proxy("https"))
+        template.setVar("ftp_proxy", self.combine_proxy("ftp"))
+        template.setVar("GIT_PROXY_HOST", self.combine_host_only("git"))
+        template.setVar("GIT_PROXY_PORT", self.combine_port_only("git"))
+        template.setVar("CVS_PROXY_HOST", self.combine_host_only("cvs"))
+        template.setVar("CVS_PROXY_PORT", self.combine_port_only("cvs"))
 
 class Parameters:
     '''Represents other variables like available machines, etc.'''
@@ -212,7 +279,6 @@ class Parameters:
         self.all_sdk_machines = []
         self.all_layers = []
         self.image_names = []
-        self.enable_proxy = False
 
         # for build log to show
         self.bb_version = ""
@@ -578,13 +644,18 @@ class Builder(gtk.Window):
         self.handler.set_extra_inherit("packageinfo")
         self.handler.set_extra_inherit("image_types")
         # set proxies
-        if self.parameters.enable_proxy:
-            self.handler.set_http_proxy(self.configuration.http_proxy)
-            self.handler.set_https_proxy(self.configuration.https_proxy)
-            self.handler.set_ftp_proxy(self.configuration.ftp_proxy)
-            self.handler.set_all_proxy(self.configuration.all_proxy)
-            self.handler.set_git_proxy(self.configuration.git_proxy_host, self.configuration.git_proxy_port)
-            self.handler.set_cvs_proxy(self.configuration.cvs_proxy_host, self.configuration.cvs_proxy_port)
+        if self.configuration.enable_proxy == True:
+            self.handler.set_http_proxy(self.configuration.combine_proxy("http"))
+            self.handler.set_https_proxy(self.configuration.combine_proxy("https"))
+            self.handler.set_ftp_proxy(self.configuration.combine_proxy("ftp"))
+            self.handler.set_git_proxy(self.configuration.combine_host_only("git"), self.configuration.combine_port_only("git"))
+            self.handler.set_cvs_proxy(self.configuration.combine_host_only("cvs"), self.configuration.combine_port_only("cvs"))
+        elif self.configuration.enable_proxy == False:
+            self.handler.set_http_proxy("")
+            self.handler.set_https_proxy("")
+            self.handler.set_ftp_proxy("")
+            self.handler.set_git_proxy("", "")
+            self.handler.set_cvs_proxy("", "")
 
     def update_recipe_model(self, selected_image, selected_recipes):
         self.recipe_model.set_selected_image(selected_image)
@@ -996,7 +1067,6 @@ class Builder(gtk.Window):
             all_distros = self.parameters.all_distros,
             all_sdk_machines = self.parameters.all_sdk_machines,
             max_threads = self.parameters.max_threads,
-            enable_proxy = self.parameters.enable_proxy,
             parent = self,
             flags = gtk.DIALOG_MODAL
                     | gtk.DIALOG_DESTROY_WITH_PARENT
@@ -1008,7 +1078,6 @@ class Builder(gtk.Window):
         response = dialog.run()
         settings_changed = False
         if response == gtk.RESPONSE_YES:
-            self.parameters.enable_proxy = dialog.enable_proxy
             self.configuration = dialog.configuration
             self.save_defaults() # remember settings
             settings_changed = dialog.settings_changed
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 721d145..1bc155d 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -172,6 +172,45 @@ class AdvancedSettingDialog (CrumbsDialog):
         hbox.show_all()
         return hbox, entry
 
+    def details_cb(self, button, parent, protocol):
+        dialog = ProxyDetailsDialog(title = protocol.upper() + " Proxy Details",
+            user = self.configuration.proxies[protocol][1],
+            passwd = self.configuration.proxies[protocol][2],
+            parent = parent,
+            flags = gtk.DIALOG_MODAL
+                    | gtk.DIALOG_DESTROY_WITH_PARENT
+                    | gtk.DIALOG_NO_SEPARATOR)
+        dialog.add_button(gtk.STOCK_CLOSE, gtk.RESPONSE_OK)
+        response = dialog.run()
+        if response == gtk.RESPONSE_OK:
+            self.configuration.proxies[protocol][1] = dialog.user
+            self.configuration.proxies[protocol][2] = dialog.passwd
+            self.refresh_proxy_components()
+        dialog.destroy()
+
+    def gen_proxy_entry_widget(self, protocol, parent, need_button=True):
+        hbox = gtk.HBox(False, 12)
+
+        label = gtk.Label(protocol.upper() + " proxy")
+        hbox.pack_start(label, expand=True, fill=False, padding=24)
+
+        proxy_entry = gtk.Entry()
+        proxy_entry.set_size_request(300, -1)
+        hbox.pack_start(proxy_entry, expand=False, fill=False)
+
+        hbox.pack_start(gtk.Label(":"), expand=False, fill=False)
+
+        port_entry = gtk.Entry()
+        port_entry.set_size_request(60, -1)
+        hbox.pack_start(port_entry, expand=False, fill=False)
+
+        details_button = HobAltButton("Details")
+        details_button.connect("clicked", self.details_cb, parent, protocol) 
+        hbox.pack_start(details_button, expand=False, fill=False)
+
+        hbox.show_all()
+        return hbox, proxy_entry, port_entry, details_button
+
     def rootfs_combo_changed_cb(self, rootfs_combo, all_package_format, check_hbox):
         combo_item = self.rootfs_combo.get_active_text()
         for child in check_hbox.get_children():
@@ -309,7 +348,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
     def __init__(self, title, configuration, all_image_types,
             all_package_formats, all_distros, all_sdk_machines,
-            max_threads, enable_proxy, parent, flags, buttons=None):
+            max_threads, parent, flags, buttons=None):
         super(AdvancedSettingDialog, self).__init__(title, parent, flags, buttons)
 
         # class members from other objects
@@ -320,7 +359,6 @@ class AdvancedSettingDialog (CrumbsDialog):
         self.all_distros = all_distros
         self.all_sdk_machines = all_sdk_machines
         self.max_threads = max_threads
-        self.enable_proxy = enable_proxy
 
         # class members for internal use
         self.distro_combo = None
@@ -356,15 +394,10 @@ class AdvancedSettingDialog (CrumbsDialog):
         data += ("SDK_MACHINE: "          + self._get_sorted_value(self.configuration.curr_sdk_machine))
         data += ("TOOLCHAIN_BUILD: "      + self._get_sorted_value(self.configuration.toolchain_build))
         data += ("IMAGE_FSTYPES: "        + self._get_sorted_value(self.configuration.image_fstypes))
-        if self.enable_proxy:
-            data += ("ALL_PROXY: "            + self._get_sorted_value(self.configuration.all_proxy))
-            data += ("HTTP_PROXY: "           + self._get_sorted_value(self.configuration.http_proxy))
-            data += ("HTTPS_PROXY: "          + self._get_sorted_value(self.configuration.https_proxy))
-            data += ("FTP_PROXY: "            + self._get_sorted_value(self.configuration.ftp_proxy))
-            data += ("GIT_PROXY_HOST: "       + self._get_sorted_value(self.configuration.git_proxy_host))
-            data += ("GIT_PROXY_PORT: "       + self._get_sorted_value(self.configuration.git_proxy_port))
-            data += ("CVS_PROXY_HOST: "       + self._get_sorted_value(self.configuration.cvs_proxy_host))
-            data += ("CVS_PROXY_PORT: "       + self._get_sorted_value(self.configuration.cvs_proxy_port))
+        data += ("ENABLE_PROXY: "         + self._get_sorted_value(self.configuration.enable_proxy))
+        if self.configuration.enable_proxy:
+            for protocol in self.configuration.proxies.keys():
+                data += (protocol + ": " + self._get_sorted_value(self.configuration.combine_proxy(protocol)))
         for key in self.configuration.extra_setting.keys():
             data += (key + ": " + self._get_sorted_value(self.configuration.extra_setting[key]))
         return hashlib.md5(data).hexdigest()
@@ -529,60 +562,56 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        self.proxy_checkbox = gtk.CheckButton("Enable proxy")
+        label = self.gen_label_widget("<span weight=\"bold\">Set the proxies that will be used during fetching source code</span>")
+        tooltip = "Set the proxies that will be used during fetching source code or set none for direct the Internet connection"
+        info = HobInfoButton(tooltip, self)
+        hbox = gtk.HBox(False, 12)
+        hbox.pack_start(label, expand=True, fill=True)
+        hbox.pack_start(info, expand=False, fill=False)
+        sub_vbox.pack_start(hbox, expand=False, fill=False)
+
+        self.direct_checkbox = gtk.RadioButton(None, "Direct internet connection")
+        self.direct_checkbox.set_tooltip_text("Check this box to connect the Internet directly without any proxy")
+        self.direct_checkbox.set_active(not self.configuration.enable_proxy)
+        sub_vbox.pack_start(self.direct_checkbox, expand=False, fill=False)
+
+        self.proxy_checkbox = gtk.RadioButton(self.direct_checkbox, "Manual proxy configuration")
         self.proxy_checkbox.set_tooltip_text("Check this box to setup the proxy you specified")
-        self.proxy_checkbox.set_active(self.enable_proxy)
-        self.proxy_checkbox.connect("toggled", self.proxy_checkbox_toggled_cb)
+        self.proxy_checkbox.set_active(self.configuration.enable_proxy)
         sub_vbox.pack_start(self.proxy_checkbox, expand=False, fill=False)
 
-        label = self.gen_label_widget("<span weight=\"bold\">Set all proxy:</span>")
-        tooltip = "Set the all proxy that will be used if the proxy for a URL isn't specified."
-        proxy_widget, self.all_proxy_text = self.gen_entry_widget(self.configuration.all_proxy, self, tooltip, False)
-        self.all_proxy_text.set_editable(self.enable_proxy)
-        self.all_proxy_text.set_sensitive(self.enable_proxy)
-        sub_vbox.pack_start(label, expand=False, fill=False)
-        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+        self.same_checkbox = gtk.CheckButton("Use the same proxy for all protocols")
+        self.same_checkbox.set_tooltip_text("Use the same proxy as the first proxy i.e. http proxy for all protocols")
+        self.same_checkbox.set_active(self.configuration.same_proxy)
+        hbox = gtk.HBox(False, 12)
+        hbox.pack_start(self.same_checkbox, expand=False, fill=False, padding=24)
+        sub_vbox.pack_start(hbox, expand=False, fill=False)
 
-        label = self.gen_label_widget("<span weight=\"bold\">Set http proxy:</span>")
-        tooltip = "Set the http proxy that will be used in do_fetch() source code"
-        proxy_widget, self.http_proxy_text = self.gen_entry_widget(self.configuration.http_proxy, self, tooltip, False)
-        self.http_proxy_text.set_editable(self.enable_proxy)
-        self.http_proxy_text.set_sensitive(self.enable_proxy)
-        sub_vbox.pack_start(label, expand=False, fill=False)
+        proxy_widget, self.http_proxy, self.http_proxy_port, self.http_proxy_details = self.gen_proxy_entry_widget(
+            "http", self, True)
         sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
 
-        label = self.gen_label_widget("<span weight=\"bold\">Set https proxy:</span>")
-        tooltip = "Set the https proxy that will be used in do_fetch() source code"
-        proxy_widget, self.https_proxy_text = self.gen_entry_widget(self.configuration.https_proxy, self, tooltip, False)
-        self.https_proxy_text.set_editable(self.enable_proxy)
-        self.https_proxy_text.set_sensitive(self.enable_proxy)
-        sub_vbox.pack_start(label, expand=False, fill=False)
+        proxy_widget, self.https_proxy, self.https_proxy_port, self.https_proxy_details = self.gen_proxy_entry_widget(
+            "https", self, True)
         sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
 
-        label = self.gen_label_widget("<span weight=\"bold\">Set ftp proxy:</span>")
-        tooltip = "Set the ftp proxy that will be used in do_fetch() source code"
-        proxy_widget, self.ftp_proxy_text = self.gen_entry_widget(self.configuration.ftp_proxy, self, tooltip, False)
-        self.ftp_proxy_text.set_editable(self.enable_proxy)
-        self.ftp_proxy_text.set_sensitive(self.enable_proxy)
-        sub_vbox.pack_start(label, expand=False, fill=False)
+        proxy_widget, self.ftp_proxy, self.ftp_proxy_port, self.ftp_proxy_details = self.gen_proxy_entry_widget(
+            "ftp", self, True)
         sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
 
-        label = self.gen_label_widget("<span weight=\"bold\">Set git proxy:</span>")
-        tooltip = "Set the git proxy that will be used in do_fetch() source code"
-        proxy_widget, self.git_proxy_text = self.gen_entry_widget(self.configuration.git_proxy_host + ':' + self.configuration.git_proxy_port, self, tooltip, False)
-        self.git_proxy_text.set_editable(self.enable_proxy)
-        self.git_proxy_text.set_sensitive(self.enable_proxy)
-        sub_vbox.pack_start(label, expand=False, fill=False)
+        proxy_widget, self.git_proxy, self.git_proxy_port, self.git_proxy_details = self.gen_proxy_entry_widget(
+            "git", self, True)
         sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
 
-        label = self.gen_label_widget("<span weight=\"bold\">Set cvs proxy:</span>")
-        tooltip = "Set the cvs proxy that will be used in do_fetch() source code"
-        proxy_widget, self.cvs_proxy_text = self.gen_entry_widget(self.configuration.cvs_proxy_host + ':' + self.configuration.cvs_proxy_port, self, tooltip, False)
-        self.cvs_proxy_text.set_editable(self.enable_proxy)
-        self.cvs_proxy_text.set_sensitive(self.enable_proxy)
-        sub_vbox.pack_start(label, expand=False, fill=False)
+        proxy_widget, self.cvs_proxy, self.cvs_proxy_port, self.cvs_proxy_details = self.gen_proxy_entry_widget(
+            "cvs", self, True)
         sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
 
+        self.direct_checkbox.connect("toggled", self.proxy_checkbox_toggled_cb)
+        self.proxy_checkbox.connect("toggled", self.proxy_checkbox_toggled_cb)
+        self.same_checkbox.connect("toggled", self.same_checkbox_toggled_cb)
+
+        self.refresh_proxy_components()
         return advanced_vbox
 
     def create_others_page(self):
@@ -599,20 +628,59 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         return advanced_vbox
 
+    def refresh_proxy_components(self):
+        self.same_checkbox.set_sensitive(self.configuration.enable_proxy)
+
+        self.http_proxy.set_text(self.configuration.combine_host_only("http"))
+        self.http_proxy.set_editable(self.configuration.enable_proxy)
+        self.http_proxy.set_sensitive(self.configuration.enable_proxy)
+        self.http_proxy_port.set_text(self.configuration.combine_port_only("http"))
+        self.http_proxy_port.set_editable(self.configuration.enable_proxy)
+        self.http_proxy_port.set_sensitive(self.configuration.enable_proxy)
+        self.http_proxy_details.set_sensitive(self.configuration.enable_proxy)
+
+        self.https_proxy.set_text(self.configuration.combine_host_only("https"))
+        self.https_proxy.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.https_proxy.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.https_proxy_port.set_text(self.configuration.combine_port_only("https"))
+        self.https_proxy_port.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.https_proxy_port.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.https_proxy_details.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+
+        self.ftp_proxy.set_text(self.configuration.combine_host_only("ftp"))
+        self.ftp_proxy.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.ftp_proxy.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.ftp_proxy_port.set_text(self.configuration.combine_port_only("ftp"))
+        self.ftp_proxy_port.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.ftp_proxy_port.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.ftp_proxy_details.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+
+        self.git_proxy.set_text(self.configuration.combine_host_only("git"))
+        self.git_proxy.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.git_proxy.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.git_proxy_port.set_text(self.configuration.combine_port_only("git"))
+        self.git_proxy_port.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.git_proxy_port.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.git_proxy_details.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+
+        self.cvs_proxy.set_text(self.configuration.combine_host_only("cvs"))
+        self.cvs_proxy.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.cvs_proxy.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.cvs_proxy_port.set_text(self.configuration.combine_port_only("cvs"))
+        self.cvs_proxy_port.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.cvs_proxy_port.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.cvs_proxy_details.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+
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
+        if not self.configuration.enable_proxy:
+            self.configuration.same_proxy = False
+            self.same_checkbox.set_active(self.configuration.same_proxy)
+        self.refresh_proxy_components()
+
+    def same_checkbox_toggled_cb(self, button):
+        self.configuration.same_proxy = self.same_checkbox.get_active()
+        self.refresh_proxy_components()
 
     def response_cb(self, dialog, response_id):
         package_format = []
@@ -656,12 +724,17 @@ class AdvancedSettingDialog (CrumbsDialog):
             self.configuration.extra_setting[key] = value
             it = self.setting_store.iter_next(it)
 
-        self.configuration.all_proxy = self.all_proxy_text.get_text()
-        self.configuration.http_proxy = self.http_proxy_text.get_text()
-        self.configuration.https_proxy = self.https_proxy_text.get_text()
-        self.configuration.ftp_proxy = self.ftp_proxy_text.get_text()
-        self.configuration.git_proxy_host, self.configuration.git_proxy_port = self.git_proxy_text.get_text().split(':')
-        self.configuration.cvs_proxy_host, self.configuration.cvs_proxy_port = self.cvs_proxy_text.get_text().split(':')
+        self.configuration.split_proxy("http", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
+        if self.configuration.same_proxy:
+            self.configuration.split_proxy("https", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
+            self.configuration.split_proxy("ftp", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
+            self.configuration.split_proxy("git", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
+            self.configuration.split_proxy("cvs", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
+        else:
+            self.configuration.split_proxy("https", self.https_proxy.get_text() + ":" + self.https_proxy_port.get_text())
+            self.configuration.split_proxy("ftp", self.ftp_proxy.get_text() + ":" + self.ftp_proxy_port.get_text())
+            self.configuration.split_proxy("git", self.git_proxy.get_text() + ":" + self.git_proxy_port.get_text())
+            self.configuration.split_proxy("cvs", self.cvs_proxy.get_text() + ":" + self.cvs_proxy_port.get_text())
 
         md5 = self.config_md5()
         self.settings_changed = (self.md5 != md5)
@@ -1150,3 +1223,63 @@ class ImageSelectionDialog (CrumbsDialog):
                             self.image_names.append(f)
                     break            
                 iter = self.image_store.iter_next(iter)
+
+class ProxyDetailsDialog (CrumbsDialog):
+
+    def __init__(self, title, user, passwd, parent, flags, buttons=None):
+        super(ProxyDetailsDialog, self).__init__(title, parent, flags, buttons)
+        self.connect("response", self.response_cb)
+
+        self.auth = not (user == None or passwd == None or user == "")
+        self.user = user or ""
+        self.passwd = passwd or ""
+
+        # create visual elements on the dialog
+        self.create_visual_elements()
+
+    def create_visual_elements(self):
+        self.auth_checkbox = gtk.CheckButton("Use authentication")
+        self.auth_checkbox.set_tooltip_text("Check this box to set the username and the password")
+        self.auth_checkbox.set_active(self.auth)
+        self.auth_checkbox.connect("toggled", self.auth_checkbox_toggled_cb)
+        self.vbox.pack_start(self.auth_checkbox, expand=False, fill=False)
+
+        hbox = gtk.HBox(False, 6)
+        self.user_label = gtk.Label("Username:")
+        self.user_text = gtk.Entry()
+        self.user_text.set_text(self.user)
+        hbox.pack_start(self.user_label, expand=False, fill=False)
+        hbox.pack_end(self.user_text, expand=False, fill=False)
+        self.vbox.pack_start(hbox, expand=False, fill=False)
+
+        hbox = gtk.HBox(False, 6)
+        self.passwd_label = gtk.Label("Password:")
+        self.passwd_text = gtk.Entry()
+        self.passwd_text.set_text(self.passwd)
+        hbox.pack_start(self.passwd_label, expand=False, fill=False)
+        hbox.pack_end(self.passwd_text, expand=False, fill=False)
+        self.vbox.pack_start(hbox, expand=False, fill=False)
+
+        self.refresh_auth_components()
+        self.show_all()
+
+    def refresh_auth_components(self):
+        self.user_label.set_sensitive(self.auth)
+        self.user_text.set_editable(self.auth)
+        self.user_text.set_sensitive(self.auth)
+        self.passwd_label.set_sensitive(self.auth)
+        self.passwd_text.set_editable(self.auth)
+        self.passwd_text.set_sensitive(self.auth)
+
+    def auth_checkbox_toggled_cb(self, button):
+        self.auth = self.auth_checkbox.get_active()
+        self.refresh_auth_components()
+
+    def response_cb(self, dialog, response_id):
+        if response_id == gtk.RESPONSE_OK:
+            if self.auth:
+                self.user = self.user_text.get_text()
+                self.passwd = self.passwd_text.get_text()
+            else:
+                self.user = None
+                self.passwd = None
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 624d7b5..d2f4589 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -304,9 +304,6 @@ class HobHandler(gobject.GObject):
     def set_ftp_proxy(self, ftp_proxy):
         self.runCommand(["setVariable", "ftp_proxy", ftp_proxy])
 
-    def set_all_proxy(self, all_proxy):
-        self.runCommand(["setVariable", "all_proxy", all_proxy])
-
     def set_git_proxy(self, host, port):
         self.runCommand(["setVariable", "GIT_PROXY_HOST", host])
         self.runCommand(["setVariable", "GIT_PROXY_PORT", port])
@@ -496,7 +493,6 @@ class HobHandler(gobject.GObject):
         params["http_proxy"] = self.runCommand(["getVariable", "http_proxy"]) or ""
         params["ftp_proxy"] = self.runCommand(["getVariable", "ftp_proxy"]) or ""
         params["https_proxy"] = self.runCommand(["getVariable", "https_proxy"]) or ""
-        params["all_proxy"] = self.runCommand(["getVariable", "all_proxy"]) or ""
 
         params["cvs_proxy_host"] = self.runCommand(["getVariable", "CVS_PROXY_HOST"]) or ""
         params["cvs_proxy_port"] = self.runCommand(["getVariable", "CVS_PROXY_PORT"]) or ""
-- 
1.7.6



