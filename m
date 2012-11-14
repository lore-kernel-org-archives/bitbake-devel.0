Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TYbKx-00020n-DH
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Nov 2012 12:40:55 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 14 Nov 2012 03:26:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.83,250,1352102400"; d="scan'208";a="217557336"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by azsmga001.ch.intel.com with ESMTP; 14 Nov 2012 03:26:57 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Nov 2012 13:29:20 +0200
Message-Id: <1352892560-23542-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: saving any customizations into the project's configuration
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
X-List-Received-Date: Wed, 14 Nov 2012 11:40:56 -0000

-hob uses and saves the variables from local.conf and bblayers.conf into
the files with the same name from "conf/" directory; till now they were
saved in ".hob" directory
-this patch assures the consistency between the configuration files from
"conf/" directory and hob

[YOCTO #2934]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py  |   42 ++++++---------
 bitbake/lib/bb/ui/crumbs/hig.py      |   11 ++--
 bitbake/lib/bb/ui/crumbs/template.py |   96 ++++++++++++++++++++++++++++------
 3 files changed, 102 insertions(+), 47 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index e5222da..5aa88a2 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -185,20 +185,6 @@ class Configuration:
         self.split_proxy("cvs", params["cvs_proxy_host"] + ":" + params["cvs_proxy_port"])
 
     def load(self, template):
-        self.curr_mach = template.getVar("MACHINE")
-        self.curr_package_format = " ".join(template.getVar("PACKAGE_CLASSES").split("package_")).strip()
-        self.curr_distro = template.getVar("DISTRO")
-        self.dldir = template.getVar("DL_DIR")
-        self.sstatedir = template.getVar("SSTATE_DIR")
-        self.sstatemirror = template.getVar("SSTATE_MIRRORS")
-        try:
-            self.pmake = int(template.getVar("PARALLEL_MAKE").split()[1])
-        except:
-            pass
-        try:
-            self.bbthread = int(template.getVar("BB_NUMBER_THREADS"))
-        except:
-            pass
         try:
             self.image_rootfs_size = int(template.getVar("IMAGE_ROOTFS_SIZE"))
         except:
@@ -210,13 +196,9 @@ class Configuration:
         # image_overhead_factor is read-only.
         self.incompat_license = template.getVar("INCOMPATIBLE_LICENSE")
         self.curr_sdk_machine = template.getVar("SDKMACHINE")
-        self.conf_version = template.getVar("CONF_VERSION")
-        self.lconf_version = template.getVar("LCONF_VERSION")
         self.extra_setting = eval(template.getVar("EXTRA_SETTING"))
         self.toolchain_build = eval(template.getVar("TOOLCHAIN_BUILD"))
         self.image_fstypes = template.getVar("IMAGE_FSTYPES")
-        # bblayers.conf
-        self.layers = template.getVar("BBLAYERS").split()
         # image/recipes/packages
         self.selected_image = template.getVar("__SELECTED_IMAGE__")
         self.selected_recipes = template.getVar("DEPENDS").split()
@@ -233,14 +215,20 @@ class Configuration:
     def save(self, template, defaults=False):
         template.setVar("VERSION", "%s" % hobVer)
         # bblayers.conf
-        template.setVar("BBLAYERS", " ".join(self.layers))
+        template.setVar("BBLAYERS", self.layers)
         # local.conf
         if not defaults:
             template.setVar("MACHINE", self.curr_mach)
         template.setVar("DISTRO", self.curr_distro)
         template.setVar("DL_DIR", self.dldir)
         template.setVar("SSTATE_DIR", self.sstatedir)
-        template.setVar("SSTATE_MIRRORS", self.sstatemirror)
+        sstate_mirror_list = self.sstatemirror.split("\\n ")
+        sstate_mirror_list_modified = []
+        for mirror in sstate_mirror_list:
+            if mirror != "":
+                mirror = mirror + "\\n"
+                sstate_mirror_list_modified.append(mirror)
+        template.setVar("SSTATE_MIRRORS", sstate_mirror_list_modified)
         template.setVar("PARALLEL_MAKE", "-j %s" % self.pmake)
         template.setVar("BB_NUMBER_THREADS", self.bbthread)
         template.setVar("PACKAGE_CLASSES", " ".join(["package_" + i for i in self.curr_package_format.split()]))
@@ -546,11 +534,11 @@ class Builder(gtk.Window):
 
     def initiate_new_build_async(self):
         self.switch_page(self.MACHINE_SELECTION)
-        if self.load_template(TemplateMgr.convert_to_template_pathfilename("default", ".hob/")) == False:
-            self.show_sanity_check_page()
-            self.handler.init_cooker()
-            self.handler.set_extra_inherit("image_types")
-            self.generate_configuration()
+        self.show_sanity_check_page()
+        self.handler.init_cooker()
+        self.handler.set_extra_inherit("image_types")
+        self.generate_configuration()
+        self.load_template(TemplateMgr.convert_to_template_pathfilename("default", ".hob/"))
 
     def update_config_async(self):
         self.switch_page(self.MACHINE_SELECTION)
@@ -656,8 +644,8 @@ class Builder(gtk.Window):
             if not os.path.exists(layer+'/conf/layer.conf'):
                 return False
 
-        self.save_defaults() # remember layers and settings
-        self.update_config_async()
+        #self.save_defaults() # remember layers and settings
+        #self.update_config_async()
         return True
 
     def save_template(self, path, defaults=False):
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index d973086..fc7a786 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -599,11 +599,12 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
                         sstatemirrors = sstatemirrors[1:]
 
                     sstatemirror_fields = [x for x in sstatemirror.split(' ') if x.strip()]
-                    if sstatemirror_fields[0] == "file://(.*)":
-                        sm_list = [ 0, sstatemirror_fields[1], "file://(.*)"]
-                    else:
-                        sm_list = [ 1, sstatemirror_fields[1], sstatemirror_fields[0]]
-                    self.sstatemirrors_list.append(sm_list)
+                    if len(sstatemirror_fields):
+                        if sstatemirror_fields[0] == "file://(.*)":
+                            sm_list = [ 0, sstatemirror_fields[1], "file://(.*)"]
+                        else:
+                            sm_list = [ 1, sstatemirror_fields[1], sstatemirror_fields[0]]
+                        self.sstatemirrors_list.append(sm_list)
 
         index = 0
         for mirror in self.sstatemirrors_list:
diff --git a/bitbake/lib/bb/ui/crumbs/template.py b/bitbake/lib/bb/ui/crumbs/template.py
index e303c3a..bd3c12d 100644
--- a/bitbake/lib/bb/ui/crumbs/template.py
+++ b/bitbake/lib/bb/ui/crumbs/template.py
@@ -42,8 +42,8 @@ class File(gobject.GObject):
 
         return contents
 
-    def writeFile(self, contents):
-        if os.path.exists(self.pathfilename):
+    def writeFile(self, contents, keep_orig=False):
+        if keep_orig == True and os.path.exists(self.pathfilename):
             orig = "%s.orig" % self.pathfilename
             if os.path.exists(orig):
                 os.remove(orig)
@@ -87,7 +87,69 @@ class ConfigFile(File):
         contents = self.header
         for var, val in self.dictionary.items():
             contents += "%s = \"%s\"\n" % (var, val)
-        File.writeFile(self, contents)
+        File.writeFile(self, contents, keep_orig=True)
+
+class UserConfigFile(File):
+    """
+    This object does save different variables into bitbake config file.
+    """
+    def __init__(self, pathfilename):
+        File.__init__(self, pathfilename, ".conf")
+        self.dictionary = {}
+
+    def setVar(self, var, val):
+        if isinstance(val, list):
+            liststr = " \\\n  "
+            if val:
+                for value in val:
+                    liststr += "%s \\\n  " % value
+            self.dictionary[var] = liststr
+        else:
+            self.dictionary[var] = val
+
+    def save(self):
+        contents = File.readFile(self)
+        total = ""
+        for line in contents:
+            total += line
+
+        for var, val in self.dictionary.items():
+            #search in contents where "var" is, to replace the "val" of the "var"
+            exist = True;
+            index_var = total.find(var)
+            if index_var != -1:
+                while self.check_if_commented(total, index_var):
+                    index_var = total.find(var, index_var+1)
+                if index_var == -1:
+                    exist = False
+                else:
+                    index_val_begin = total.find("\"",index_var)
+                    index_val_begin = index_val_begin + 1
+                    index_val_end = total.find("\"",index_val_begin)
+                    total_begin = total[:index_val_begin]
+                    total_end = total[index_val_end:]
+                    total = total_begin + str(val) + total_end
+            else:
+                exist = False
+
+            if exist is False:
+                #the variable isn't defined in the file
+                #add it to the end of the file
+                total += "\n%s = \"%s\"\n" % (var, val)
+
+        File.writeFile(self, total)
+
+    def check_if_commented(self, content, index):
+        commented = False
+
+        new_line = content.rfind("\n", 0, index)
+        if new_line != -1:
+            after_new_line = content[new_line:]
+            first_word = after_new_line.split()
+            if first_word[0][0] == "#":
+                commented = True
+
+        return commented
 
 class HobTemplateFile(ConfigFile):
     """
@@ -153,29 +215,33 @@ class TemplateMgr(gobject.GObject):
         return "%s/%s%s%s" % (path, "template-", filename, ".hob")
 
     @classmethod
-    def convert_to_bblayers_pathfilename(cls, filename, path):
-        return "%s/%s%s%s" % (path, "bblayers-", filename, ".conf")
-
-    @classmethod
-    def convert_to_local_pathfilename(cls, filename, path):
-        return "%s/%s%s%s" % (path, "local-", filename, ".conf")
-
-    @classmethod
     def convert_to_image_pathfilename(cls, filename, path):
         return "%s/%s%s%s" % (path, "hob-image-", filename, ".bb")
 
     def open(self, filename, path):
         self.template_hob = HobTemplateFile(TemplateMgr.convert_to_template_pathfilename(filename, path))
-        self.bblayers_conf = ConfigFile(TemplateMgr.convert_to_bblayers_pathfilename(filename, path))
-        self.local_conf = ConfigFile(TemplateMgr.convert_to_local_pathfilename(filename, path))
+        bblayers_conf = self.findConfigFile("bblayers.conf")
+        self.bblayers_conf = UserConfigFile(bblayers_conf)
+        local_conf = self.findConfigFile("local.conf")
+        self.local_conf = UserConfigFile(local_conf)
         self.image_bb = RecipeFile(TemplateMgr.convert_to_image_pathfilename(filename, path))
 
+    def findConfigFile(self, configfile):
+        path = os.getcwd()
+        while path != "/":
+            confpath = os.path.join(path, "conf", configfile)
+            if os.path.exists(confpath):
+                return confpath
+
+            path, _ = os.path.split(path)
+        return path
+
     def setVar(self, var, val):
         if var in TemplateMgr.__gLocalVars__:
             self.local_conf.setVar(var, val)
-        if var in TemplateMgr.__gBBLayersVars__:
+        elif var in TemplateMgr.__gBBLayersVars__:
             self.bblayers_conf.setVar(var, val)
-        if var in TemplateMgr.__gRecipeVars__:
+        elif var in TemplateMgr.__gRecipeVars__:
             self.image_bb.setVar(var, val)
 
         self.template_hob.setVar(var, val)
-- 
1.7.9.5



