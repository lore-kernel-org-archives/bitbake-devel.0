Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1UF2d0-0005gQ-LE
	for bitbake-devel@lists.openembedded.org;
	Mon, 11 Mar 2013 14:19:02 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 11 Mar 2013 06:02:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,822,1355126400"; d="scan'208";a="268518864"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by azsmga001.ch.intel.com with ESMTP; 11 Mar 2013 06:02:12 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 11 Mar 2013 15:06:58 +0200
Message-Id: <1363007218-19052-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: some settings in Hob are not remembered
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
X-List-Received-Date: Mon, 11 Mar 2013 13:19:12 -0000

Some settings in Hob were not saved in Bitbake and they were not displayed
correcty in Hob, because Hob used some other variables with the extension "_HOB".
I have removed this, in order to have a consistency for the variables.
ALso, I called a function to load the extra variables saved in .hob/template_default.hob.

[YOCTO #3957]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/command.py                   |    7 -------
 bitbake/lib/bb/ui/crumbs/builder.py         |   27 ++++++++++++++-------------
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |   25 +++++++++++--------------
 3 files changed, 25 insertions(+), 34 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 59336bb..3abdd0c 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -205,13 +205,6 @@ class CommandsSync:
         """
         return bb.utils.cpu_count()
 
-    def setConfFilter(self, command, params):
-        """
-        Set the configuration file parsing filter
-        """
-        filterfunc = params[0]
-        bb.parse.parse_py.ConfHandler.confFilters.append(filterfunc)
-
     def matchFile(self, command, params):
         fMatch = params[0]
         return command.cooker.matchFile(fMatch)
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index f6adabe..38478b3 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -469,8 +469,6 @@ class Builder(gtk.Window):
         self.handler.connect("recipe-populated",         self.handler_recipe_populated_cb)
         self.handler.connect("package-populated",        self.handler_package_populated_cb)
 
-        self.handler.set_config_filter(hob_conf_filter)
-
         self.initiate_new_build_async()
 
     def create_visual_elements(self):
@@ -552,6 +550,7 @@ class Builder(gtk.Window):
         self.handler.init_cooker()
         self.handler.set_extra_inherit("image_types")
         self.generate_configuration()
+        self.load_template(TemplateMgr.convert_to_template_pathfilename("default", ".hob/"))
 
     def update_config_async(self):
         self.switch_page(self.MACHINE_SELECTION)
@@ -660,8 +659,7 @@ class Builder(gtk.Window):
             if not os.path.exists(layer+'/conf/layer.conf'):
                 return False
 
-        self.save_defaults() # remember layers and settings
-        self.update_config_async()
+        self.set_user_config_extra()
         return True
 
     def save_template(self, path, defaults=False):
@@ -765,6 +763,17 @@ class Builder(gtk.Window):
             self.handler.set_git_proxy("", "")
             self.handler.set_cvs_proxy("", "")
 
+    def set_user_config_extra(self):
+        self.handler.set_rootfs_size(self.configuration.image_rootfs_size)
+        self.handler.set_extra_size(self.configuration.image_extra_size)
+        self.handler.set_incompatible_license(self.configuration.incompat_license)
+        self.handler.set_sdk_machine(self.configuration.curr_sdk_machine)
+        self.handler.set_image_fstypes(self.configuration.image_fstypes)
+        self.handler.set_extra_config(self.configuration.extra_setting)
+        self.handler.set_extra_inherit("packageinfo")
+        self.handler.set_extra_inherit("image_types")
+        self.set_user_config_proxies()
+
     def set_user_config(self):
         self.handler.init_cooker()
         # set bb layers
@@ -778,15 +787,7 @@ class Builder(gtk.Window):
         self.handler.set_sstate_mirrors(self.configuration.sstatemirror)
         self.handler.set_pmake(self.configuration.pmake)
         self.handler.set_bbthreads(self.configuration.bbthread)
-        self.handler.set_rootfs_size(self.configuration.image_rootfs_size)
-        self.handler.set_extra_size(self.configuration.image_extra_size)
-        self.handler.set_incompatible_license(self.configuration.incompat_license)
-        self.handler.set_sdk_machine(self.configuration.curr_sdk_machine)
-        self.handler.set_image_fstypes(self.configuration.image_fstypes)
-        self.handler.set_extra_config(self.configuration.extra_setting)
-        self.handler.set_extra_inherit("packageinfo")
-        self.handler.set_extra_inherit("image_types")
-        self.set_user_config_proxies()
+        self.set_user_config_extra()
 
     def update_recipe_model(self, selected_image, selected_recipes):
         self.recipe_model.set_selected_image(selected_image)
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 15d28d9..c33fb74 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -307,42 +307,42 @@ class HobHandler(gobject.GObject):
         self.runCommand(["setVariable", "INHERIT", inherits])
 
     def set_bblayers(self, bblayers):
-        self.runCommand(["setVariable", "BBLAYERS_HOB", " ".join(bblayers)])
+        self.runCommand(["setVariable", "BBLAYERS", " ".join(bblayers)])
 
     def set_machine(self, machine):
         if machine:
-            self.runCommand(["setVariable", "MACHINE_HOB", machine])
+            self.runCommand(["setVariable", "MACHINE", machine])
 
     def set_sdk_machine(self, sdk_machine):
-        self.runCommand(["setVariable", "SDKMACHINE_HOB", sdk_machine])
+        self.runCommand(["setVariable", "SDKMACHINE", sdk_machine])
 
     def set_image_fstypes(self, image_fstypes):
         self.runCommand(["setVariable", "IMAGE_FSTYPES", image_fstypes])
 
     def set_distro(self, distro):
-        self.runCommand(["setVariable", "DISTRO_HOB", distro])
+        self.runCommand(["setVariable", "DISTRO", distro])
 
     def set_package_format(self, format):
         package_classes = ""
         for pkgfmt in format.split():
             package_classes += ("package_%s" % pkgfmt + " ")
-        self.runCommand(["setVariable", "PACKAGE_CLASSES_HOB", package_classes])
+        self.runCommand(["setVariable", "PACKAGE_CLASSES", package_classes])
 
     def set_bbthreads(self, threads):
-        self.runCommand(["setVariable", "BB_NUMBER_THREADS_HOB", threads])
+        self.runCommand(["setVariable", "BB_NUMBER_THREADS", threads])
 
     def set_pmake(self, threads):
         pmake = "-j %s" % threads
-        self.runCommand(["setVariable", "PARALLEL_MAKE_HOB", pmake])
+        self.runCommand(["setVariable", "PARALLEL_MAKE", pmake])
 
     def set_dl_dir(self, directory):
-        self.runCommand(["setVariable", "DL_DIR_HOB", directory])
+        self.runCommand(["setVariable", "DL_DIR", directory])
 
     def set_sstate_dir(self, directory):
-        self.runCommand(["setVariable", "SSTATE_DIR_HOB", directory])
+        self.runCommand(["setVariable", "SSTATE_DIR", directory])
 
     def set_sstate_mirrors(self, url):
-        self.runCommand(["setVariable", "SSTATE_MIRRORS_HOB", url])
+        self.runCommand(["setVariable", "SSTATE_MIRRORS", url])
 
     def set_extra_size(self, image_extra_size):
         self.runCommand(["setVariable", "IMAGE_ROOTFS_EXTRA_SPACE", str(image_extra_size)])
@@ -351,16 +351,13 @@ class HobHandler(gobject.GObject):
         self.runCommand(["setVariable", "IMAGE_ROOTFS_SIZE", str(image_rootfs_size)])
 
     def set_incompatible_license(self, incompat_license):
-        self.runCommand(["setVariable", "INCOMPATIBLE_LICENSE_HOB", incompat_license])
+        self.runCommand(["setVariable", "INCOMPATIBLE_LICENSE", incompat_license])
 
     def set_extra_config(self, extra_setting):
         for key in extra_setting.keys():
             value = extra_setting[key]
             self.runCommand(["setVariable", key, value])
 
-    def set_config_filter(self, config_filter):
-        self.runCommand(["setConfFilter", config_filter])
-
     def set_http_proxy(self, http_proxy):
         self.runCommand(["setVariable", "http_proxy", http_proxy])
 
-- 
1.7.9.5



