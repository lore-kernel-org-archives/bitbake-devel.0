Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SAjpq-0003Ld-SY
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 16:21:58 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 22 Mar 2012 08:13:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="123894966"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 22 Mar 2012 08:12:59 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 22 Mar 2012 23:38:08 +0800
Message-Id: <09f4dd59adb400073f21dcff12c99f1559d34b70.1332430442.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <994a3ff7aec35f01ad019ff455b699c86342945e.1332430442.git.shane.wang@intel.com>
References: <994a3ff7aec35f01ad019ff455b699c86342945e.1332430442.git.shane.wang@intel.com>
In-Reply-To: <cover.1332430442.git.shane.wang@intel.com>
References: <cover.1332430442.git.shane.wang@intel.com>
Subject: [PATCH 6/8] Hob: remember the settings between Hob sessions
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
X-List-Received-Date: Thu, 22 Mar 2012 15:21:58 -0000

This patch is to add support to remember and restore the settings between different Hob sessions.
The settings include:
 - Layers
 - Settings including proxies

[Yocto #2113]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py         |  125 ++++++++++++++++++++-------
 bitbake/lib/bb/ui/crumbs/hig.py             |    8 +-
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    5 +-
 bitbake/lib/bb/ui/crumbs/template.py        |   55 ++++++++----
 4 files changed, 141 insertions(+), 52 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 12bfc59..9c6392a 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -87,8 +87,27 @@ class Configuration:
         else:
             os.environ[proxy_key] = proxy
 
+    def _setup_proxy(self):
+        if self.enable_proxy:
+            self.set_os_proxy("all_proxy", self.all_proxy)
+            self.set_os_proxy("http_proxy", self.http_proxy)
+            self.set_os_proxy("https_proxy", self.https_proxy)
+            self.set_os_proxy("ftp_proxy", self.ftp_proxy)
+
     def load(self, template):
+        self.load_machine(template)
+        self.load_configuration(template)
+        self.load_layers(template)
+        self.load_image(template)
+
+    def load_settings_only(self, template):
+        self.load_configuration(template)
+        self.load_layers(template)
+
+    def load_machine(self, template):
         self.curr_mach = template.getVar("MACHINE")
+
+    def load_configuration(self, template):
         self.curr_package_format = " ".join(template.getVar("PACKAGE_CLASSES").split("package_")).strip()
         self.curr_distro = template.getVar("DISTRO")
         self.dldir = template.getVar("DL_DIR")
@@ -98,7 +117,7 @@ class Configuration:
         self.bbthread = int(template.getVar("BB_NUMBER_THREAD"))
         self.image_rootfs_size = int(template.getVar("IMAGE_ROOTFS_SIZE"))
         self.image_extra_size = int(template.getVar("IMAGE_EXTRA_SPACE"))
-        # image_overhead_factor is read-only.
+            # image_overhead_factor is read-only.
         self.incompat_license = template.getVar("INCOMPATIBLE_LICENSE")
         self.curr_sdk_machine = template.getVar("SDKMACHINE")
         self.conf_version = template.getVar("CONF_VERSION")
@@ -106,24 +125,43 @@ class Configuration:
         self.extra_setting = eval(template.getVar("EXTRA_SETTING"))
         self.toolchain_build = eval(template.getVar("TOOLCHAIN_BUILD"))
         self.image_fstypes = template.getVar("IMAGE_FSTYPES").split()
-        # bblayers.conf
-        self.layers = template.getVar("BBLAYERS").split()
-        # image/recipes/packages
-        self.selected_image = template.getVar("__SELECTED_IMAGE__")
-        self.selected_recipes = template.getVar("DEPENDS").split()
-        self.selected_packages = template.getVar("IMAGE_INSTALL").split()
         # proxy
         self.all_proxy = template.getVar("all_proxy")
         self.http_proxy = template.getVar("http_proxy")
         self.ftp_proxy = template.getVar("ftp_proxy")
         self.https_proxy = template.getVar("https_proxy")
         self.enable_proxy = (template.getVar("enable_proxy") == "True")
+        self._setup_proxy()
+
+    def load_layers(self, template):
+        # bblayers.conf
+        self.layers = template.getVar("BBLAYERS").split()
+
+    def load_image(self, template):
+        # image/recipes/packages
+        self.selected_image = template.getVar("__SELECTED_IMAGE__")
+        self.selected_recipes = template.getVar("DEPENDS").split()
+        self.selected_packages = template.getVar("IMAGE_INSTALL").split()
 
     def save(self, template, filename):
+        self.save_machine(template)
+        self.save_configuration(template)
+        self.save_layers(template)
+        self.save_image(template)
+
+    def save_settings_only(self, template):
+        self.save_configuration(template)
+        self.save_layers(template)
+
+    def save_layers(self, template):
         # bblayers.conf
         template.setVar("BBLAYERS", " ".join(self.layers))
+
+    def save_machine(self, template):
         # local.conf
         template.setVar("MACHINE", self.curr_mach)
+
+    def save_configuration(self, template):
         template.setVar("DISTRO", self.curr_distro)
         template.setVar("DL_DIR", self.dldir)
         template.setVar("SSTATE_DIR", self.sstatedir)
@@ -140,11 +178,6 @@ class Configuration:
         template.setVar("EXTRA_SETTING", self.extra_setting)
         template.setVar("TOOLCHAIN_BUILD", self.toolchain_build)
         template.setVar("IMAGE_FSTYPES", " ".join(self.image_fstypes).lstrip(" "))
-        # image/recipes/packages
-        self.selected_image = filename
-        template.setVar("__SELECTED_IMAGE__", self.selected_image)
-        template.setVar("DEPENDS", self.selected_recipes)
-        template.setVar("IMAGE_INSTALL", self.selected_packages)
         # proxy
         template.setVar("all_proxy", self.all_proxy)
         template.setVar("http_proxy", self.http_proxy)
@@ -152,6 +185,13 @@ class Configuration:
         template.setVar("https_proxy", self.https_proxy)
         template.setVar("enable_proxy", ("%s" % self.enable_proxy))
 
+    def save_image(self, template, filename):
+        # image/recipes/packages
+        self.selected_image = filename
+        template.setVar("__SELECTED_IMAGE__", self.selected_image)
+        template.setVar("DEPENDS", self.selected_recipes)
+        template.setVar("IMAGE_INSTALL", self.selected_packages)
+
 class Parameters:
     '''Represents other variables like available machines, etc.'''
 
@@ -256,6 +296,10 @@ class Builder(gtk.Window):
         self.handler.connect("command-succeeded",        self.handler_command_succeeded_cb)
         self.handler.connect("command-failed",           self.handler_command_failed_cb)
 
+        # restore the settings from the last Hob session
+        self.load_default_settings()
+        self.handler.parse_layers(self.configuration.layers)
+
         self.switch_page(self.MACHINE_SELECTION)
 
     def create_visual_elements(self):
@@ -292,21 +336,32 @@ class Builder(gtk.Window):
         self.show_all()
         self.nb.set_current_page(0)
 
-    def load_template(self, path):
+    def load_template(self, path, load_settings_only=False):
         self.template = TemplateMgr()
-        self.template.load(path)
-        self.configuration.load(self.template)
-
-        for layer in self.configuration.layers:
-            if not os.path.exists(layer+'/conf/layer.conf'):
-                return False
+        ret = True
+        if not self.template.exists(path):
+            ret = False
+        else:
+            self.template.load(path)
+            if not load_settings_only:
+                self.configuration.load(self.template)
+            else:
+                self.configuration.load_settings_only(self.template)
 
-        self.switch_page(self.LAYER_CHANGED)
+            for layer in self.configuration.layers:
+                if not os.path.exists(layer+'/conf/layer.conf'):
+                    ret = False
+            if ret:
+                self.switch_page(self.LAYER_CHANGED)
 
         self.template.destroy()
         self.template = None
+        return ret
 
-    def save_template(self, path):
+    def load_default_settings(self):
+        self.load_template(TemplateMgr.convert_to_template_pathfilename("default", ".hob/"), load_settings_only=True)
+
+    def save_template(self, path, save_settings_only=False):
         if path.rfind("/") == -1:
             filename = "default"
             path = "."
@@ -314,14 +369,27 @@ class Builder(gtk.Window):
             filename = path[path.rfind("/") + 1:len(path)]
             path = path[0:path.rfind("/")]
 
-        self.template = TemplateMgr()
+        if not save_settings_only:
+            self.template = TemplateMgr()
+        else:
+            self.template = TemplateMgr(save_template_only=True)
+
         self.template.open(filename, path)
-        self.configuration.save(self.template, filename)
+
+        if not save_settings_only:
+            self.configuration.save(self.template, filename)
+        else:
+            self.configuration.save_settings_only(self.template)
 
         self.template.save()
         self.template.destroy()
         self.template = None
 
+    def save_default_settings(self):
+        if not os.path.exists(".hob/"):
+            os.mkdir(".hob/")
+        self.save_template(".hob/default", save_settings_only=True)
+
     def switch_page(self, next_step):
         # Main Workflow (Business Logic)
         self.nb.set_current_page(self.__step2page__[next_step])
@@ -645,6 +713,8 @@ class Builder(gtk.Window):
         response = dialog.run()
         dialog.destroy()
         if response == gtk.RESPONSE_YES:
+            # save the settings from the next Hob session
+            self.save_default_settings()
             gtk.main_quit()
             return False
         else:
@@ -764,13 +834,6 @@ class Builder(gtk.Window):
 
         dialog.destroy()
 
-    def _setup_proxy(self):
-        if self.configuration.enable_proxy:
-            self.configuration.set_os_proxy("all_proxy", self.configuration.all_proxy)
-            self.configuration.set_os_proxy("http_proxy", self.configuration.http_proxy)
-            self.configuration.set_os_proxy("https_proxy", self.configuration.https_proxy)
-            self.configuration.set_os_proxy("ftp_proxy", self.configuration.ftp_proxy)
-
     def show_adv_settings_dialog(self):
         dialog = AdvancedSettingDialog(title = "Settings",
             configuration = copy.deepcopy(self.configuration),
@@ -800,7 +863,7 @@ class Builder(gtk.Window):
                 self.configuration.http_proxy = dialog.http_proxy
                 self.configuration.https_proxy = dialog.https_proxy
                 self.configuration.ftp_proxy = dialog.ftp_proxy
-                self._setup_proxy()
+                self.configuration._setup_proxy()
             # DO reparse recipes
             if dialog.settings_changed:
                 if self.configuration.curr_mach == "":
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index b555196..4cc3019 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -539,7 +539,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         label = self.gen_label_widget("<span weight=\"bold\">Set all proxy:</span>")
         tooltip = "Set the all proxy that will be used if the proxy for a URL isn't specified."
-        proxy_widget, self.all_proxy_text = self.gen_entry_widget(self.split_model, self.all_proxy, self, tooltip, False)
+        proxy_widget, self.all_proxy_text = self.gen_entry_widget(self.all_proxy, self, tooltip, False)
         self.all_proxy_text.set_editable(self.enable_proxy)
         self.all_proxy_text.set_sensitive(self.enable_proxy)
         sub_vbox.pack_start(label, expand=False, fill=False)
@@ -547,7 +547,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         label = self.gen_label_widget("<span weight=\"bold\">Set http proxy:</span>")
         tooltip = "Set the http proxy that will be used in do_fetch() source code"
-        proxy_widget, self.http_proxy_text = self.gen_entry_widget(self.split_model, self.http_proxy, self, tooltip, False)
+        proxy_widget, self.http_proxy_text = self.gen_entry_widget(self.http_proxy, self, tooltip, False)
         self.http_proxy_text.set_editable(self.enable_proxy)
         self.http_proxy_text.set_sensitive(self.enable_proxy)
         sub_vbox.pack_start(label, expand=False, fill=False)
@@ -555,7 +555,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         label = self.gen_label_widget("<span weight=\"bold\">Set https proxy:</span>")
         tooltip = "Set the https proxy that will be used in do_fetch() source code"
-        proxy_widget, self.https_proxy_text = self.gen_entry_widget(self.split_model, self.https_proxy, self, tooltip, False)
+        proxy_widget, self.https_proxy_text = self.gen_entry_widget(self.https_proxy, self, tooltip, False)
         self.https_proxy_text.set_editable(self.enable_proxy)
         self.https_proxy_text.set_sensitive(self.enable_proxy)
         sub_vbox.pack_start(label, expand=False, fill=False)
@@ -563,7 +563,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         label = self.gen_label_widget("<span weight=\"bold\">Set ftp proxy:</span>")
         tooltip = "Set the ftp proxy that will be used in do_fetch() source code"
-        proxy_widget, self.ftp_proxy_text = self.gen_entry_widget(self.split_model, self.ftp_proxy, self, tooltip, False)
+        proxy_widget, self.ftp_proxy_text = self.gen_entry_widget(self.ftp_proxy, self, tooltip, False)
         self.ftp_proxy_text.set_editable(self.enable_proxy)
         self.ftp_proxy_text.set_sensitive(self.enable_proxy)
         sub_vbox.pack_start(label, expand=False, fill=False)
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index fe7b5d5..f56b6f9 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -266,10 +266,13 @@ class HobHandler(gobject.GObject):
     def parse_config(self):
         self.server.runCommand(["parseConfigurationFiles", "", ""])
 
-    def refresh_layers(self, bblayers):
+    def parse_layers(self, bblayers):
         self.server.runCommand(["initCooker"])
         self.server.runCommand(["setVariable", "BBLAYERS", " ".join(bblayers)])
         self.parse_config()
+
+    def refresh_layers(self, bblayers):
+        self.parse_layers(bblayers)
         self.commands_async.append(self.CFG_FILES_DISTRO)
         self.commands_async.append(self.CFG_FILES_MACH)
         self.commands_async.append(self.CFG_FILES_SDKMACH)
diff --git a/bitbake/lib/bb/ui/crumbs/template.py b/bitbake/lib/bb/ui/crumbs/template.py
index a03063c..2e9d2d1 100644
--- a/bitbake/lib/bb/ui/crumbs/template.py
+++ b/bitbake/lib/bb/ui/crumbs/template.py
@@ -129,37 +129,60 @@ class TemplateMgr(gobject.GObject):
     __gBBLayersVars__ = ["BBLAYERS", "LCONF_VERSION"]
     __gRecipeVars__ = ["DEPENDS", "IMAGE_INSTALL"]
 
-    def __init__(self):
+    def __init__(self, save_template_only = False):
         gobject.GObject.__init__(self)
         self.template_hob = None
         self.bblayers_conf = None
         self.local_conf = None
         self.image_bb = None
+        self.save_template_only = save_template_only
+
+    @classmethod
+    def convert_to_template_pathfilename(cls, filename, path):
+        return "%s/%s%s%s" % (path, "template-", filename, ".hob")
+
+    @classmethod
+    def convert_to_bblayers_pathfilename(cls, filename, path):
+        return "%s/%s%s%s" % (path, "bblayers-", filename, ".conf")
+
+    @classmethod
+    def convert_to_local_pathfilename(cls, filename, path):
+        return "%s/%s%s%s" % (path, "local-", filename, ".conf")
+
+    @classmethod
+    def convert_to_image_pathfilename(cls, filename, path):
+        return "%s/%s%s%s" % (path, "hob-image-", filename, ".bb")
 
     def open(self, filename, path):
-        self.template_hob = HobTemplateFile("%s/%s%s%s" % (path, "template-", filename, ".hob"))
-        self.bblayers_conf = ConfigFile("%s/%s%s%s" % (path, "bblayers-", filename, ".conf"))
-        self.local_conf = ConfigFile("%s/%s%s%s" % (path, "local-", filename, ".conf"))
-        self.image_bb = RecipeFile("%s/%s%s%s" % (path, "hob-image-", filename, ".bb"))
+        self.template_hob = HobTemplateFile(TemplateMgr.convert_to_template_pathfilename(filename, path))
+        if not self.save_template_only:
+            self.bblayers_conf = ConfigFile(TemplateMgr.convert_to_bblayers_pathfilename(filename, path))
+            self.local_conf = ConfigFile(TemplateMgr.convert_to_local_pathfilename(filename, path))
+            self.image_bb = RecipeFile(TemplateMgr.convert_to_image_pathfilename(filename, path))
 
     def setVar(self, var, val):
-        if var in TemplateMgr.__gLocalVars__:
-            self.local_conf.setVar(var, val)
-        if var in TemplateMgr.__gBBLayersVars__:
-            self.bblayers_conf.setVar(var, val)
-        if var in TemplateMgr.__gRecipeVars__:
-            self.image_bb.setVar(var, val)
+        if not self.save_template_only:
+            if var in TemplateMgr.__gLocalVars__:
+                self.local_conf.setVar(var, val)
+            if var in TemplateMgr.__gBBLayersVars__:
+                self.bblayers_conf.setVar(var, val)
+            if var in TemplateMgr.__gRecipeVars__:
+                self.image_bb.setVar(var, val)
 
         self.template_hob.setVar(var, val)
 
     def save(self):
-        self.local_conf.save()
-        self.bblayers_conf.save()
-        self.image_bb.save()
+        if not self.save_template_only:
+            self.local_conf.save()
+            self.bblayers_conf.save()
+            self.image_bb.save()
         self.template_hob.save()
 
-    def load(self, path):
-        self.template_hob = HobTemplateFile(path)
+    def exists(self, pathfilename):
+        return os.path.isfile(pathfilename)
+
+    def load(self, pathfilename):
+        self.template_hob = HobTemplateFile(pathfilename)
         self.dictionary = self.template_hob.load()
 
     def getVar(self, var):
-- 
1.7.6



