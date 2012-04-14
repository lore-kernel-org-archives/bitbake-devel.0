Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SJ7rI-0008VI-UD
	for bitbake-devel@lists.openembedded.org;
	Sat, 14 Apr 2012 20:38:05 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 14 Apr 2012 11:28:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="132525451"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 14 Apr 2012 11:28:40 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 15 Apr 2012 02:58:58 +0800
Message-Id: <5aa3bc3f4cd72922ed3456eb995eb52cdff09beb.1334429179.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1334429179.git.shane.wang@intel.com>
References: <cover.1334429179.git.shane.wang@intel.com>
Subject: [PATCH 1/2] Hob: remember layers and settings between Hob sessions
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
X-List-Received-Date: Sat, 14 Apr 2012 18:38:05 -0000

This patch is to remember layers and settings between Hob sessions, which
includes:
 - Put some variables for the build details screen from Configuration to
   Parameters because they are not actually for build but for show
 - We create a dummy Configuration instance and a dummy Parameters instance
   in __init__ of builder
 - The two instances will be assigned the real values by
   update_configuration_parameters() after parsing (in the event callback)
 - When it is the first time to launch Hob in a build directory, nothing is
   remembered since everything is fresh.
 - The feature is implemented with templates, and based on the hook for Hob.
 - When the user changes the layers or the settings, a default template file
   is saved into ".hob/".
 - Later on, the layers and the settings are remembered by loading the default
   template automatically.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   16 ++--
 bitbake/lib/bb/ui/crumbs/builder.py          |  158 ++++++++++++++++----------
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py  |    1 -
 bitbake/lib/bb/ui/crumbs/template.py         |   24 ++++-
 4 files changed, 127 insertions(+), 72 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 23aaacd..6d8b509 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -81,16 +81,16 @@ class BuildConfigurationTreeView(gtk.TreeView):
         # renew the tree model after get the configuration messages
         self.set_model(listmodel)
 
-    def show(self, src_config_info):
+    def show(self, src_config_info, src_params):
         vars = []
-        vars.append(self.set_vars("BB version:", src_config_info.bb_version))
-        vars.append(self.set_vars("Target arch:", src_config_info.target_arch))
-        vars.append(self.set_vars("Target OS:", src_config_info.target_os))
+        vars.append(self.set_vars("BB version:", src_params.bb_version))
+        vars.append(self.set_vars("Target arch:", src_params.target_arch))
+        vars.append(self.set_vars("Target OS:", src_params.target_os))
         vars.append(self.set_vars("Machine:", src_config_info.curr_mach))
         vars.append(self.set_vars("Distro:", src_config_info.curr_distro))
-        vars.append(self.set_vars("Distro version:", src_config_info.distro_version))
+        vars.append(self.set_vars("Distro version:", src_params.distro_version))
         vars.append(self.set_vars("SDK machine:", src_config_info.curr_sdk_machine))
-        vars.append(self.set_vars("Tune feature:", src_config_info.tune_pkgarch))
+        vars.append(self.set_vars("Tune features:", src_params.tune_pkgarch))
         vars.append(self.set_vars("Layers:", src_config_info.layers))
 
         for path in src_config_info.layers:
@@ -248,5 +248,5 @@ class BuildDetailsPage (HobPage):
                 if (v_adj.upper <= v_adj.page_size) or (v_adj.value == v_adj.upper - v_adj.page_size):
                     treeview.scroll_to_cell(path)
 
-    def show_configurations(self, configurations):
-        self.config_tv.show(configurations)
+    def show_configurations(self, configurations, params):
+        self.config_tv.show(configurations, params)
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index de9685d..5dd2b13 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -42,28 +42,23 @@ import bb.ui.crumbs.utils
 class Configuration:
     '''Represents the data structure of configuration.'''
 
-    def __init__(self, params):
-        # Settings
+    def __init__(self):
         self.curr_mach = ""
-        self.curr_distro = params["distro"]
-        self.dldir = params["dldir"]
-        self.sstatedir = params["sstatedir"]
-        self.sstatemirror = params["sstatemirror"]
-        self.pmake = int(params["pmake"].split()[1])
-        self.bbthread = params["bbthread"]
-        self.curr_package_format = " ".join(params["pclass"].split("package_")).strip()
-        self.image_rootfs_size = params["image_rootfs_size"]
-        self.image_extra_size = params["image_extra_size"]
-        self.image_overhead_factor = params['image_overhead_factor']
-        self.incompat_license = params["incompat_license"]
-        self.curr_sdk_machine = params["sdk_machine"]
-        self.conf_version = params["conf_version"]
-        self.lconf_version = params["lconf_version"]
+        # settings
+        self.curr_distro = ""
+        self.dldir = self.sstatedir = self.sstatemirror = ""
+        self.pmake = self.bbthread = 0
+        self.curr_package_format = ""
+        self.image_rootfs_size = self.image_extra_size = 0
+        self.image_overhead_factor = 1
+        self.incompat_license = ""
+        self.curr_sdk_machine = ""
+        self.conf_version = self.lconf_version = ""
         self.extra_setting = {}
         self.toolchain_build = False
-        self.image_fstypes = params["image_fstypes"]
+        self.image_fstypes = ""
         # bblayers.conf
-        self.layers = params["layer"].split()
+        self.layers = []
         # image/recipes/packages
         self.selected_image = None
         self.selected_recipes = []
@@ -71,19 +66,15 @@ class Configuration:
 
         self.user_selected_packages = []
 
-        self.default_task = params["default_task"]
+        self.default_task = "build"
 
         # proxy settings
-        self.all_proxy = params["all_proxy"]
-        self.http_proxy = params["http_proxy"]
-        self.ftp_proxy = params["ftp_proxy"]
-        self.https_proxy = params["https_proxy"]
-        self.git_proxy_host = params["git_proxy_host"]
-        self.git_proxy_port = params["git_proxy_port"]
-        self.cvs_proxy_host = params["cvs_proxy_host"]
-        self.cvs_proxy_port = params["cvs_proxy_port"]
+        self.all_proxy = self.http_proxy = self.ftp_proxy = self.https_proxy = ""
+        self.git_proxy_host = self.git_proxy_port = ""
+        self.cvs_proxy_host = self.cvs_proxy_port = ""
 
     def update(self, params):
+        # settings
         self.curr_distro = params["distro"]
         self.dldir = params["dldir"]
         self.sstatedir = params["sstatedir"]
@@ -99,16 +90,21 @@ class Configuration:
         self.conf_version = params["conf_version"]
         self.lconf_version = params["lconf_version"]
         self.image_fstypes = params["image_fstypes"]
-        self.tune_arch = params["tune_arch"]
-        self.bb_version = params["bb_version"]
-        self.target_arch = params["target_arch"]
-        self.target_os = params["target_os"]
-        self.distro_version = params["distro_version"]
-        self.tune_pkgarch = params["tune_pkgarch"]
+        # self.extra_setting/self.toolchain_build
         # bblayers.conf
         self.layers = params["layer"].split()
         self.default_task = params["default_task"]
 
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
@@ -156,11 +152,12 @@ class Configuration:
         self.cvs_proxy_host = template.getVar("CVS_PROXY_HOST")
         self.cvs_proxy_port = template.getVar("CVS_PROXY_PORT")
 
-    def save(self, template):
+    def save(self, template, defaults=False):
         # bblayers.conf
         template.setVar("BBLAYERS", " ".join(self.layers))
         # local.conf
-        template.setVar("MACHINE", self.curr_mach)
+        if not defaults:
+            template.setVar("MACHINE", self.curr_mach)
         template.setVar("DISTRO", self.curr_distro)
         template.setVar("DL_DIR", self.dldir)
         template.setVar("SSTATE_DIR", self.sstatedir)
@@ -177,10 +174,11 @@ class Configuration:
         template.setVar("EXTRA_SETTING", self.extra_setting)
         template.setVar("TOOLCHAIN_BUILD", self.toolchain_build)
         template.setVar("IMAGE_FSTYPES", self.image_fstypes)
-        # image/recipes/packages
-        template.setVar("__SELECTED_IMAGE__", self.selected_image)
-        template.setVar("DEPENDS", self.selected_recipes)
-        template.setVar("IMAGE_INSTALL", self.user_selected_packages)
+        if not defaults:
+            # image/recipes/packages
+            template.setVar("__SELECTED_IMAGE__", self.selected_image)
+            template.setVar("DEPENDS", self.selected_recipes)
+            template.setVar("IMAGE_INSTALL", self.user_selected_packages)
         # proxy
         template.setVar("all_proxy", self.all_proxy)
         template.setVar("http_proxy", self.http_proxy)
@@ -194,23 +192,47 @@ class Configuration:
 class Parameters:
     '''Represents other variables like available machines, etc.'''
 
-    def __init__(self, params):
+    def __init__(self):
         # Variables
+        self.max_threads = 65535
+        self.core_base = ""
+        self.image_addr = ""
+        self.image_types = []
+        self.runnable_image_types = []
+        self.runnable_machine_patterns = []
+        self.deployable_image_types = []
+        self.tmpdir = ""
+
         self.all_machines = []
         self.all_package_formats = []
         self.all_distros = []
         self.all_sdk_machines = []
-        self.max_threads = params["max_threads"]
         self.all_layers = []
-        self.core_base = params["core_base"]
         self.image_names = []
+        self.enable_proxy = False
+
+        # for build log to show
+        self.bb_version = ""
+        self.target_arch = ""
+        self.target_os = ""
+        self.distro_version = ""
+        self.tune_pkgarch = ""
+
+    def update(self, params):
+        self.max_threads = params["max_threads"]
+        self.core_base = params["core_base"]
         self.image_addr = params["image_addr"]
         self.image_types = params["image_types"].split()
         self.runnable_image_types = params["runnable_image_types"].split()
         self.runnable_machine_patterns = params["runnable_machine_patterns"].split()
         self.deployable_image_types = params["deployable_image_types"].split()
         self.tmpdir = params["tmpdir"]
-        self.enable_proxy = False
+        # for build log to show
+        self.bb_version = params["bb_version"]
+        self.target_arch = params["target_arch"]
+        self.target_os = params["target_os"]
+        self.distro_version = params["distro_version"]
+        self.tune_pkgarch = params["tune_pkgarch"]
 
 def hob_conf_filter(fn, data):
     if fn.endswith("/local.conf"):
@@ -287,6 +309,10 @@ class Builder(gtk.Window):
 
         self.template = None
 
+        # configuration and parameters
+        self.configuration = Configuration()
+        self.parameters = Parameters()
+
         # build step
         self.current_step = None
         self.previous_step = None
@@ -365,9 +391,10 @@ class Builder(gtk.Window):
 
     def initiate_new_build_async(self):
         self.switch_page(self.MACHINE_SELECTION)
-        self.handler.init_cooker()
-        self.handler.set_extra_inherit("image_types")
-        self.handler.parse_config()
+        if self.load_template(TemplateMgr.convert_to_template_pathfilename("default", ".hob/")) == None:
+            self.handler.init_cooker()
+            self.handler.set_extra_inherit("image_types")
+            self.handler.parse_config()
 
     def update_config_async(self):
         self.switch_page(self.MACHINE_SELECTION)
@@ -432,20 +459,25 @@ class Builder(gtk.Window):
         self.handler.cancel_parse()
 
     def load_template(self, path):
+        if not os.path.isfile(path):
+            return None
+
         self.template = TemplateMgr()
         self.template.load(path)
         self.configuration.load(self.template)
 
+        self.template.destroy()
+        self.template = None
+
         for layer in self.configuration.layers:
             if not os.path.exists(layer+'/conf/layer.conf'):
                 return False
 
+        self.save_defaults() # remember layers and settings
         self.update_config_async()
+        return True
 
-        self.template.destroy()
-        self.template = None
-
-    def save_template(self, path):
+    def save_template(self, path, defaults=False):
         if path.rfind("/") == -1:
             filename = "default"
             path = "."
@@ -455,12 +487,17 @@ class Builder(gtk.Window):
 
         self.template = TemplateMgr()
         self.template.open(filename, path)
-        self.configuration.save(self.template)
+        self.configuration.save(self.template, defaults)
 
         self.template.save()
         self.template.destroy()
         self.template = None
 
+    def save_defaults(self):
+        if not os.path.exists(".hob/"):
+            os.mkdir(".hob/")
+        self.save_template(".hob/default", True)
+
     def switch_page(self, next_step):
         # Main Workflow (Business Logic)
         self.nb.set_current_page(self.__step2page__[next_step])
@@ -544,6 +581,11 @@ class Builder(gtk.Window):
         left = self.package_model.set_selected_packages(selected_packages)
         self.configuration.selected_packages += left
 
+    def update_configuration_parameters(self, params):
+        if params:
+            self.configuration.update(params)
+            self.parameters.update(params)
+
     # Callback Functions
     def handler_config_updated_cb(self, handler, which, values):
         if which == "distro":
@@ -560,19 +602,15 @@ class Builder(gtk.Window):
     def handler_command_succeeded_cb(self, handler, initcmd):
         if initcmd == self.handler.PARSE_CONFIG:
             # settings
-            params = self.get_parameters_sync()
-            self.configuration = Configuration(params)
-            self.parameters = Parameters(params)
+            self.update_configuration_parameters(self.get_parameters_sync())
             self.generate_configuration_async()
         elif initcmd == self.handler.GENERATE_CONFIGURATION:
-            params = self.get_parameters_sync()
-            self.configuration.update(params)
+            self.update_configuration_parameters(self.get_parameters_sync())
             self.image_configuration_page.switch_machine_combo()
         elif initcmd in [self.handler.GENERATE_RECIPES,
                          self.handler.GENERATE_PACKAGES,
                          self.handler.GENERATE_IMAGE]:
-            params = self.get_parameters_sync()
-            self.configuration.update(params)
+            self.update_configuration_parameters(self.get_parameters_sync())
             self.request_package_info_async()
         elif initcmd == self.handler.POPULATE_PACKAGEINFO:
             if self.current_step == self.RCPPKGINFO_POPULATING:
@@ -691,7 +729,7 @@ class Builder(gtk.Window):
         elif self.current_step == self.PACKAGE_GENERATING:
             fraction = 0
         self.build_details_page.update_progress_bar("Build Started: ", fraction)
-        self.build_details_page.show_configurations(self.configuration)
+        self.build_details_page.show_configurations(self.configuration, self.parameters)
 
     def build_succeeded(self):
         if self.current_step == self.FAST_IMAGE_GENERATING:
@@ -857,6 +895,7 @@ class Builder(gtk.Window):
         response = dialog.run()
         if response == gtk.RESPONSE_YES:
             self.configuration.layers = dialog.layers
+            self.save_defaults() # remember layers
             # DO refresh layers
             if dialog.layers_changed:
                 self.update_config_async()
@@ -943,6 +982,7 @@ class Builder(gtk.Window):
         if response == gtk.RESPONSE_YES:
             self.parameters.enable_proxy = dialog.enable_proxy
             self.configuration = dialog.configuration
+            self.save_defaults() # remember settings
             settings_changed = dialog.settings_changed
         dialog.destroy()
         return response == gtk.RESPONSE_YES, settings_changed
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 17d3fe4..7a3cc6b 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -495,7 +495,6 @@ class HobHandler(gobject.GObject):
         params["target_arch"] = self.server.runCommand(["getVariable", "TARGET_ARCH"]) or ""
         params["tune_pkgarch"] = self.server.runCommand(["getVariable", "TUNE_PKGARCH"])  or ""
         params["bb_version"] = self.server.runCommand(["getVariable", "BB_MIN_VERSION"]) or ""
-        params["tune_arch"] = self.server.runCommand(["getVariable", "TUNE_ARCH"]) or ""
 
         params["default_task"] = self.server.runCommand(["getVariable", "BB_DEFAULT_TASK"]) or "build"
 
diff --git a/bitbake/lib/bb/ui/crumbs/template.py b/bitbake/lib/bb/ui/crumbs/template.py
index 5679c18..cbed270 100644
--- a/bitbake/lib/bb/ui/crumbs/template.py
+++ b/bitbake/lib/bb/ui/crumbs/template.py
@@ -136,11 +136,27 @@ class TemplateMgr(gobject.GObject):
         self.local_conf = None
         self.image_bb = None
 
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
+
     def open(self, filename, path):
-        self.template_hob = HobTemplateFile("%s/%s%s%s" % (path, "template-", filename, ".hob"))
-        self.bblayers_conf = ConfigFile("%s/%s%s%s" % (path, "bblayers-", filename, ".conf"))
-        self.local_conf = ConfigFile("%s/%s%s%s" % (path, "local-", filename, ".conf"))
-        self.image_bb = RecipeFile("%s/%s%s%s" % (path, "hob-image-", filename, ".bb"))
+        self.template_hob = HobTemplateFile(TemplateMgr.convert_to_template_pathfilename(filename, path))
+        self.bblayers_conf = ConfigFile(TemplateMgr.convert_to_bblayers_pathfilename(filename, path))
+        self.local_conf = ConfigFile(TemplateMgr.convert_to_local_pathfilename(filename, path))
+        self.image_bb = RecipeFile(TemplateMgr.convert_to_image_pathfilename(filename, path))
 
     def setVar(self, var, val):
         if var in TemplateMgr.__gLocalVars__:
-- 
1.7.6



