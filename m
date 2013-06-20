Return-Path: <cristiana.voicu@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 26036608BE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 10:18:05 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 20 Jun 2013 03:19:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,903,1363158000"; d="scan'208";a="356656096"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga002.fm.intel.com with ESMTP; 20 Jun 2013 03:18:03 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Jun 2013 13:19:41 +0300
Message-Id: <1371723585-27966-2-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1371723585-27966-1-git-send-email-cristiana.voicu@intel.com>
References: <1371723585-27966-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH_V2 1/5] hob: remove the rest of the old template functionality
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 20 Jun 2013 10:18:05 -0000

Until now, some configuration settings was saved in a hob specific
directory. From now on, it will be saved in conf directory through bitbake.

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py  |  125 ++++-------------------
 bitbake/lib/bb/ui/crumbs/template.py |  187 ----------------------------------
 2 files changed, 18 insertions(+), 294 deletions(-)
 delete mode 100644 bitbake/lib/bb/ui/crumbs/template.py

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index b5cfd9e..2f7c496 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -30,7 +30,6 @@ import shlex
 import re
 import logging
 import sys
-from bb.ui.crumbs.template import TemplateMgr
 from bb.ui.crumbs.imageconfigurationpage import ImageConfigurationPage
 from bb.ui.crumbs.recipeselectionpage import RecipeSelectionPage
 from bb.ui.crumbs.packageselectionpage import PackageSelectionPage
@@ -192,36 +191,7 @@ class Configuration:
         self.split_proxy("socks", params["socks_proxy"])
         self.split_proxy("cvs", params["cvs_proxy_host"] + ":" + params["cvs_proxy_port"])
 
-    def load(self, template):
-        try:
-            self.image_rootfs_size = int(template.getVar("IMAGE_ROOTFS_SIZE"))
-        except:
-            pass
-        try:
-            self.image_extra_size = int(template.getVar("IMAGE_EXTRA_SPACE"))
-        except:
-            pass
-        # image_overhead_factor is read-only.
-        self.incompat_license = template.getVar("INCOMPATIBLE_LICENSE")
-        self.curr_sdk_machine = template.getVar("SDKMACHINE")
-        self.extra_setting = eval(template.getVar("EXTRA_SETTING"))
-        self.toolchain_build = eval(template.getVar("TOOLCHAIN_BUILD"))
-        self.image_fstypes = template.getVar("IMAGE_FSTYPES")
-        # image/recipes/packages
-        self.selected_image = template.getVar("__SELECTED_IMAGE__")
-        self.selected_recipes = template.getVar("DEPENDS").split()
-        self.selected_packages = template.getVar("IMAGE_INSTALL").split()
-        # proxy
-        self.enable_proxy = eval(template.getVar("enable_proxy"))
-        self.same_proxy = eval(template.getVar("use_same_proxy"))
-        self.split_proxy("http", template.getVar("http_proxy"))
-        self.split_proxy("https", template.getVar("https_proxy"))
-        self.split_proxy("ftp", template.getVar("ftp_proxy"))
-        self.split_proxy("socks", template.getVar("all_proxy"))
-        self.split_proxy("cvs", template.getVar("CVS_PROXY_HOST") + ":" + template.getVar("CVS_PROXY_PORT"))
-
     def save(self, handler, template, defaults=False):
-        template.setVar("VERSION", "%s" % hobVer)
         # bblayers.conf
         handler.set_var_in_file("BBLAYERS", self.layers, "bblayers.conf")
         # local.conf
@@ -240,29 +210,29 @@ class Configuration:
         handler.set_var_in_file("PARALLEL_MAKE", "-j %s" % self.pmake, "local.conf")
         handler.set_var_in_file("BB_NUMBER_THREADS", self.bbthread, "local.conf")
         handler.set_var_in_file("PACKAGE_CLASSES", " ".join(["package_" + i for i in self.curr_package_format.split()]), "local.conf")
-        template.setVar("IMAGE_ROOTFS_SIZE", self.image_rootfs_size)
-        template.setVar("IMAGE_EXTRA_SPACE", self.image_extra_size)
-        template.setVar("INCOMPATIBLE_LICENSE", self.incompat_license)
-        template.setVar("SDKMACHINE", self.curr_sdk_machine)
+        handler.set_var_in_file("IMAGE_ROOTFS_SIZE", self.image_rootfs_size, "local.conf")
+        handler.set_var_in_file("IMAGE_EXTRA_SPACE", self.image_extra_size, "local.conf")
+        handler.set_var_in_file("INCOMPATIBLE_LICENSE", self.incompat_license, "local.conf")
+        handler.set_var_in_file("SDKMACHINE", self.curr_sdk_machine, "local.conf")
         handler.set_var_in_file("CONF_VERSION", self.conf_version, "local.conf")
         handler.set_var_in_file("LCONF_VERSION", self.lconf_version, "bblayers.conf")
-        template.setVar("EXTRA_SETTING", self.extra_setting)
-        template.setVar("TOOLCHAIN_BUILD", self.toolchain_build)
-        template.setVar("IMAGE_FSTYPES", self.image_fstypes)
+        handler.set_var_in_file("EXTRA_SETTING", self.extra_setting, "local.conf")
+        handler.set_var_in_file("TOOLCHAIN_BUILD", self.toolchain_build, "local.conf")
+        handler.set_var_in_file("IMAGE_FSTYPES", self.image_fstypes, "local.conf")
         if not defaults:
             # image/recipes/packages
-            template.setVar("__SELECTED_IMAGE__", self.selected_image)
-            template.setVar("DEPENDS", self.selected_recipes)
-            template.setVar("IMAGE_INSTALL", self.user_selected_packages)
+            handler.set_var_in_file("__SELECTED_IMAGE__", self.selected_image, "local.conf")
+            handler.set_var_in_file("DEPENDS", self.selected_recipes, "local.conf")
+            handler.set_var_in_file("IMAGE_INSTALL", self.user_selected_packages, "local.conf")
         # proxy
-        template.setVar("enable_proxy", self.enable_proxy)
-        template.setVar("use_same_proxy", self.same_proxy)
-        template.setVar("http_proxy", self.combine_proxy("http"))
-        template.setVar("https_proxy", self.combine_proxy("https"))
-        template.setVar("ftp_proxy", self.combine_proxy("ftp"))
-        template.setVar("all_proxy", self.combine_proxy("socks"))
-        template.setVar("CVS_PROXY_HOST", self.combine_host_only("cvs"))
-        template.setVar("CVS_PROXY_PORT", self.combine_port_only("cvs"))
+        handler.set_var_in_file("enable_proxy", self.enable_proxy, "local.conf")
+        handler.set_var_in_file("use_same_proxy", self.same_proxy, "local.conf")
+        handler.set_var_in_file("http_proxy", self.combine_proxy("http"), "local.conf")
+        handler.set_var_in_file("https_proxy", self.combine_proxy("https"), "local.conf")
+        handler.set_var_in_file("ftp_proxy", self.combine_proxy("ftp"), "local.conf")
+        handler.set_var_in_file("all_proxy", self.combine_proxy("socks"), "local.conf")
+        handler.set_var_in_file("CVS_PROXY_HOST", self.combine_host_only("cvs"), "local.conf")
+        handler.set_var_in_file("CVS_PROXY_PORT", self.combine_port_only("cvs"), "local.conf")
 
     def __str__(self):
         s = "VERSION: '%s', BBLAYERS: '%s', MACHINE: '%s', DISTRO: '%s', DL_DIR: '%s'," % \
@@ -407,8 +377,6 @@ class Builder(gtk.Window):
         # handler
         self.handler = hobHandler
 
-        self.template = None
-
         # logger
         self.logger = logging.getLogger("BitBake")
         self.consolelog = None
@@ -552,7 +520,6 @@ class Builder(gtk.Window):
         self.handler.init_cooker()
         self.handler.set_extra_inherit("image_types")
         self.generate_configuration()
-        self.load_template(TemplateMgr.convert_to_template_pathfilename("default", ".hob/"))
 
     def update_config_async(self):
         self.switch_page(self.MACHINE_SELECTION)
@@ -635,61 +602,6 @@ class Builder(gtk.Window):
     def cancel_parse_sync(self):
         self.handler.cancel_parse()
 
-    def load_template(self, path):
-        if not os.path.isfile(path):
-            return False
-
-        self.template = TemplateMgr()
-        # check compatibility
-        tempVer = self.template.getVersion(path)
-        if not tempVer or int(tempVer) < hobVer:
-            self.template.destroy()
-            self.template = None
-            return False
-
-        try:
-            self.template.load(path)
-            self.configuration.load(self.template)
-        except Exception as e:
-            self.show_error_dialog("Hob Exception - %s" % (str(e)))
-            self.reset()
-        finally:
-            self.template.destroy()
-            self.template = None
-
-        for layer in self.configuration.layers:
-            if not os.path.exists(layer+'/conf/layer.conf'):
-                return False
-
-        self.set_user_config_extra()
-        return True
-
-    def save_template(self, path, defaults=False):
-        if path.rfind("/") == -1:
-            filename = "default"
-            path = "."
-        else:
-            filename = path[path.rfind("/") + 1:len(path)]
-            path = path[0:path.rfind("/")]
-
-        self.template = TemplateMgr()
-        try:
-            self.template.open(filename, path)
-            self.configuration.save(self.handler, self.template, defaults)
-
-            self.template.save()
-        except Exception as e:
-            self.show_error_dialog("Hob Exception - %s" % (str(e)))
-            self.reset()
-        finally:
-            self.template.destroy()
-            self.template = None
-
-    def save_defaults(self):
-        if not os.path.exists(".hob/"):
-            os.mkdir(".hob/")
-        self.save_template(".hob/default", True)
-
     def switch_page(self, next_step):
         # Main Workflow (Business Logic)
         self.nb.set_current_page(self.__step2page__[next_step])
@@ -1255,7 +1167,6 @@ class Builder(gtk.Window):
         response = dialog.run()
         if response == gtk.RESPONSE_YES:
             self.configuration.layers = dialog.layers
-            self.save_defaults() # remember layers
             # DO refresh layers
             if dialog.layers_changed:
                 self.update_config_async()
diff --git a/bitbake/lib/bb/ui/crumbs/template.py b/bitbake/lib/bb/ui/crumbs/template.py
deleted file mode 100644
index 92c438f..0000000
--- a/bitbake/lib/bb/ui/crumbs/template.py
+++ /dev/null
@@ -1,187 +0,0 @@
-#
-# BitBake Graphical GTK User Interface
-#
-# Copyright (C) 2011        Intel Corporation
-#
-# Authored by Shane Wang <shane.wang@intel.com>
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
-import gobject
-import os
-import re
-
-class File(gobject.GObject):
-
-    def __init__(self, pathfilename, suffix):
-        if not pathfilename.endswith(suffix):
-            pathfilename = "%s%s" % (pathfilename, suffix)
-        gobject.GObject.__init__(self)
-        self.pathfilename = pathfilename
-
-    def readFile(self):
-        if not os.path.isfile(self.pathfilename):
-            return None
-        if not os.path.exists(self.pathfilename):
-            return None
-
-        with open(self.pathfilename, 'r') as f:
-            contents = f.readlines()
-        f.close()
-
-        return contents
-
-    def writeFile(self, contents):
-        if os.path.exists(self.pathfilename):
-            orig = "%s.orig" % self.pathfilename
-            if os.path.exists(orig):
-                os.remove(orig)
-            os.rename(self.pathfilename, orig)
-
-        with open(self.pathfilename, 'w') as f:
-            f.write(contents)
-        f.close()
-
-class ConfigFile(File):
-    """
-    This object does save general config file. (say bblayers.conf, or local.conf). Again, it is the base class for other template files and image bb files.
-    """
-    def __init__(self, pathfilename, suffix = None, header = None):
-        if suffix:
-            File.__init__(self, pathfilename, suffix)
-        else:
-            File.__init__(self, pathfilename, ".conf")
-        if header:
-            self.header = header
-        else:
-            self.header = "# Config generated by Hob\n\n"
-        self.dictionary = {}
-
-    def setVar(self, var, val):
-        if isinstance(val, list):
-            liststr = ""
-            if val:
-                i = 0
-                for value in val:
-                    if i < len(val) - 1:
-                        liststr += "%s " % value
-                    else:
-                        liststr += "%s" % value
-                    i += 1
-            self.dictionary[var] = liststr
-        else:
-            self.dictionary[var] = val
-
-    def save(self):
-        contents = self.header
-        for var, val in self.dictionary.items():
-            contents += "%s = \"%s\"\n" % (var, val)
-        File.writeFile(self, contents)
-
-class HobTemplateFile(ConfigFile):
-    """
-    This object does save or load hob specific file.
-    """
-    def __init__(self, pathfilename):
-        ConfigFile.__init__(self, pathfilename, ".hob", "# Hob Template generated by Hob\n\n")
-
-    def getVar(self, var):
-        if var in self.dictionary: 
-            return self.dictionary[var]
-        else:
-            return ""
-
-    def getVersion(self):
-        contents = ConfigFile.readFile(self)
-
-        pattern = "^\s*(\S+)\s*=\s*(\".*?\")"
-
-        for line in contents:
-            match = re.search(pattern, line)
-            if match:
-                if match.group(1) == "VERSION":
-                    return match.group(2).strip('"')
-        return None
-
-    def load(self):
-        contents = ConfigFile.readFile(self)
-        self.dictionary.clear()
-
-        pattern = "^\s*(\S+)\s*=\s*(\".*?\")"
-
-        for line in contents:
-            match = re.search(pattern, line)
-            if match:
-                var = match.group(1)
-                val = match.group(2).strip('"')
-                self.dictionary[var] = val
-        return self.dictionary
-
-class RecipeFile(ConfigFile):
-    """
-    This object is for image bb file.
-    """
-    def __init__(self, pathfilename):
-        ConfigFile.__init__(self, pathfilename, ".bb", "# Recipe generated by Hob\n\ninherit core-image\n")
-
-class TemplateMgr(gobject.GObject):
-
-    __gRecipeVars__ = ["DEPENDS", "IMAGE_INSTALL"]
-
-    def __init__(self):
-        gobject.GObject.__init__(self)
-        self.template_hob = None
-        self.bblayers_conf = None
-        self.local_conf = None
-        self.image_bb = None
-
-    @classmethod
-    def convert_to_template_pathfilename(cls, filename, path):
-        return "%s/%s%s%s" % (path, "template-", filename, ".hob")
-
-    @classmethod
-    def convert_to_image_pathfilename(cls, filename, path):
-        return "%s/%s%s%s" % (path, "hob-image-", filename, ".bb")
-
-    def open(self, filename, path):
-        self.template_hob = HobTemplateFile(TemplateMgr.convert_to_template_pathfilename(filename, path))
-        self.image_bb = RecipeFile(TemplateMgr.convert_to_image_pathfilename(filename, path))
-
-    def setVar(self, var, val):
-        if var in TemplateMgr.__gRecipeVars__:
-            self.image_bb.setVar(var, val)
-
-        self.template_hob.setVar(var, val)
-
-    def save(self):
-        self.image_bb.save()
-        self.template_hob.save()
-
-    def getVersion(self, path):
-        return HobTemplateFile(path).getVersion()
-
-    def load(self, path):
-        self.template_hob = HobTemplateFile(path)
-        self.dictionary = self.template_hob.load()
-
-    def getVar(self, var):
-        return self.template_hob.getVar(var)
-
-    def destroy(self):
-        if self.template_hob:
-            del self.template_hob
-            template_hob = None
-        if self.image_bb:
-            del self.image_bb
-            self.image_bb = None
-- 
1.7.9.5


