Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TykA2-0005Ze-MZ
	for bitbake-devel@lists.openembedded.org;
	Fri, 25 Jan 2013 15:21:46 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 25 Jan 2013 06:06:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,538,1355126400"; d="scan'208";a="278378033"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by fmsmga001.fm.intel.com with ESMTP; 25 Jan 2013 06:06:06 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 25 Jan 2013 16:10:12 +0200
Message-Id: <1359123012-7707-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH V2] bitbake & hob: implement functions to assure consistency for configuration files
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
X-List-Received-Date: Fri, 25 Jan 2013 14:21:46 -0000

Added a new command in bitbake to save a variable in a file; added a function
in cooker which is called by this command.

Added new command in bitbake to enable/disable data tracking.

The function saveConfigurationVar from cooker.py saves a variable in the file that
is received by argument. It checks all the operations made on that variable, using the history.
If it's the first time when it does some changes on a variable,it comments the lines where
an operation is made on it, and it sets it in a line to the end of file. If it's not
the first time(it has a comment before), it replaces the line.

Made some changes in hob to save the variables from bblayers.conf and local.conf
using the bitbake command.

[YOCTO #2934]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/command.py                   |   18 ++++++
 bitbake/lib/bb/cooker.py                    |   89 +++++++++++++++++++++++++++
 bitbake/lib/bb/data_smart.py                |   22 +++++++
 bitbake/lib/bb/ui/crumbs/builder.py         |   32 ++++++----
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    5 ++
 bitbake/lib/bb/ui/crumbs/template.py        |   24 --------
 6 files changed, 153 insertions(+), 37 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 0fed25a..59336bb 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -174,6 +174,18 @@ class CommandsSync:
         value = str(params[1])
         command.cooker.configuration.data.setVar(varname, value)
 
+    def enableDataTracking(self, command, params):
+        """
+        Enable history tracking for variables
+        """
+        command.cooker.enableDataTracking()
+
+    def disableDataTracking(self, command, params):
+        """
+        Disable history tracking for variables
+        """
+        command.cooker.disableDataTracking()
+
     def initCooker(self, command, params):
         """
         Init the cooker to initial state with nothing parsed
@@ -210,6 +222,12 @@ class CommandsSync:
         package_queue = params[2]
         return command.cooker.generateNewImage(image, base_image, package_queue)
 
+    def setVarFile(self, command, params):
+        var = params[0]
+        val = params[1]
+        default_file = params[2]
+        command.cooker.saveConfigurationVar(var, val, default_file)
+
 class CommandsAsync:
     """
     A class of asynchronous commands
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index caf1123..9a4695b 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -186,6 +186,12 @@ class BBCooker:
         filtered_keys = bb.utils.approved_variables()
         bb.data.inheritFromOS(self.configuration.data, self.savedenv, filtered_keys)
 
+    def enableDataTracking(self):
+        self.configuration.data.enableTracking()
+
+    def disableDataTracking(self):
+        self.configuration.data.disableTracking()
+
     def loadConfigurationData(self):
         self.initConfigurationData()
 
@@ -201,6 +207,89 @@ class BBCooker:
         if not self.configuration.cmd:
             self.configuration.cmd = self.configuration.data.getVar("BB_DEFAULT_TASK", True) or "build"
 
+    def saveConfigurationVar(self, var, val, default_file):
+
+        replaced = False
+        #do not save if nothing changed
+        if str(val) == self.configuration.data.getVar(var):
+            return
+
+        conf_files = self.configuration.data.varhistory.get_variable_files(var)
+
+        #format the value when it is a list
+        if isinstance(val, list):
+            listval = ""
+            for value in val:
+                listval += "%s   " % value
+            val = listval
+
+        topdir = self.configuration.data.getVar("TOPDIR")
+
+        #comment or replace operations made on var
+        for conf_file in conf_files:
+            if topdir in conf_file:
+                with open(conf_file, 'r') as f:
+                    contents = f.readlines()
+                f.close()
+
+                lines = self.configuration.data.varhistory.get_variable_lines(var, conf_file)
+                for line in lines:
+                    total = ""
+                    i = 0
+                    for c in contents:
+                        total += c
+                        i = i + 1
+                        if i==int(line):
+                            end_index = len(total)
+                    index = total.rfind(var, 0, end_index)
+
+                    begin_line = total.count("\n",0,index)
+                    end_line = int(line)
+
+                    #check if the variable was saved before in the same way
+                    #if true it replace the place where the variable was declared
+                    #else it comments it
+                    if contents[begin_line-1]== "#added by bitbake\n":
+                        contents[begin_line] = "%s = \"%s\"\n" % (var, val)
+                        replaced = True
+                    else:
+                        for ii in range(begin_line, end_line):
+                            contents[ii] = "#" + contents[ii]
+
+                total = ""
+                for c in contents:
+                    total += c
+                with open(conf_file, 'w') as f:
+                    f.write(total)
+                f.close()
+
+        if replaced == False:
+            #remove var from history
+            self.configuration.data.varhistory.del_var_history(var)
+
+            #add var to the end of default_file
+            default_file = self._findConfigFile(default_file)
+
+            with open(default_file, 'r') as f:
+                contents = f.readlines()
+            f.close()
+
+            total = ""
+            for c in contents:
+                total += c
+
+            #add the variable on a single line, to be easy to replace the second time
+            total += "#added by bitbake"
+            total += "\n%s = \"%s\"\n" % (var, val)
+
+            with open(default_file, 'w') as f:
+                f.write(total)
+            f.close()
+
+            #add to history
+            loginfo = {"op":set, "file":default_file, "line":total.count("\n")}
+            self.configuration.data.setVar(var, val, **loginfo)
+
     def parseConfiguration(self):
 
         # Set log file verbosity
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index ddf98e6..5bf11e5 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -259,6 +259,27 @@ class VariableHistory(object):
             o.write("#\n# $%s\n#   [no history recorded]\n#\n" % var)
             o.write('#   "%s"\n' % (commentVal))
 
+    def get_variable_files(self, var):
+        """Get the files where operations are made on a variable"""
+        var_history = self.variable(var)
+        files = []
+        for event in var_history:
+            files.append(event['file'])
+        return files
+
+    def get_variable_lines(self, var, f):
+        """Get the line where a operation is made on a variable in file f"""
+        var_history = self.variable(var)
+        lines = []
+        for event in var_history:
+            if f== event['file']:
+                line = event['line']
+                lines.append(line)
+        return lines
+
+    def del_var_history(self, var):
+        if var in self.variables:
+            self.variables[var] = []
 
 class DataSmart(MutableMapping):
     def __init__(self, special = COWDictBase.copy(), seen = COWDictBase.copy() ):
@@ -429,6 +450,7 @@ class DataSmart(MutableMapping):
 
 
     def setVar(self, var, value, **loginfo):
+        #print("var=" + str(var) + "  val=" + str(value))
         if 'op' not in loginfo:
             loginfo['op'] = "set"
         self.expand_cache = {}
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 9da926d..e9cfa21 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -217,26 +217,32 @@ class Configuration:
         self.split_proxy("git", template.getVar("GIT_PROXY_HOST") + ":" + template.getVar("GIT_PROXY_PORT"))
         self.split_proxy("cvs", template.getVar("CVS_PROXY_HOST") + ":" + template.getVar("CVS_PROXY_PORT"))
 
-    def save(self, template, defaults=False):
+    def save(self, handler, template, defaults=False):
         template.setVar("VERSION", "%s" % hobVer)
         # bblayers.conf
-        template.setVar("BBLAYERS", " ".join(self.layers))
+        handler.set_var_in_file("BBLAYERS", self.layers, "bblayers.conf")
         # local.conf
         if not defaults:
-            template.setVar("MACHINE", self.curr_mach)
-        template.setVar("DISTRO", self.curr_distro)
-        template.setVar("DL_DIR", self.dldir)
-        template.setVar("SSTATE_DIR", self.sstatedir)
-        template.setVar("SSTATE_MIRRORS", self.sstatemirror)
-        template.setVar("PARALLEL_MAKE", "-j %s" % self.pmake)
-        template.setVar("BB_NUMBER_THREADS", self.bbthread)
-        template.setVar("PACKAGE_CLASSES", " ".join(["package_" + i for i in self.curr_package_format.split()]))
+            handler.set_var_in_file("MACHINE", self.curr_mach, "local.conf")
+        handler.set_var_in_file("DISTRO", self.curr_distro, "local.conf")
+        handler.set_var_in_file("DL_DIR", self.dldir, "local.conf")
+        handler.set_var_in_file("SSTATE_DIR", self.sstatedir, "local.conf")
+        sstate_mirror_list = self.sstatemirror.split("\\n ")
+        sstate_mirror_list_modified = []
+        for mirror in sstate_mirror_list:
+            if mirror != "":
+                mirror = mirror + "\\n"
+                sstate_mirror_list_modified.append(mirror)
+        handler.set_var_in_file("SSTATE_MIRRORS", sstate_mirror_list_modified, "local.conf")
+        handler.set_var_in_file("PARALLEL_MAKE", "-j %s" % self.pmake, "local.conf")
+        handler.set_var_in_file("BB_NUMBER_THREADS", self.bbthread, "local.conf")
+        handler.set_var_in_file("PACKAGE_CLASSES", " ".join(["package_" + i for i in self.curr_package_format.split()]), "local.conf")
         template.setVar("IMAGE_ROOTFS_SIZE", self.image_rootfs_size)
         template.setVar("IMAGE_EXTRA_SPACE", self.image_extra_size)
         template.setVar("INCOMPATIBLE_LICENSE", self.incompat_license)
         template.setVar("SDKMACHINE", self.curr_sdk_machine)
-        template.setVar("CONF_VERSION", self.conf_version)
-        template.setVar("LCONF_VERSION", self.lconf_version)
+        handler.set_var_in_file("CONF_VERSION", self.conf_version, "local.conf")
+        handler.set_var_in_file("LCONF_VERSION", self.lconf_version, "bblayers.conf")
         template.setVar("EXTRA_SETTING", self.extra_setting)
         template.setVar("TOOLCHAIN_BUILD", self.toolchain_build)
         template.setVar("IMAGE_FSTYPES", self.image_fstypes)
@@ -670,7 +676,7 @@ class Builder(gtk.Window):
         self.template = TemplateMgr()
         try:
             self.template.open(filename, path)
-            self.configuration.save(self.template, defaults)
+            self.configuration.save(self.handler, self.template, defaults)
 
             self.template.save()
         except Exception as e:
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 41022ef..d953f34 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -146,7 +146,9 @@ class HobHandler(gobject.GObject):
         elif next_command == self.SUB_MATCH_CLASS:
             self.runCommand(["findFilesMatchingInDir", "rootfs_", "classes"])
         elif next_command == self.SUB_PARSE_CONFIG:
+            self.runCommand(["enableDataTracking"])
             self.runCommand(["parseConfigurationFiles", "", ""])
+            self.runCommand(["disableDataTracking"])
         elif next_command == self.SUB_GNERATE_TGTS:
             self.runCommand(["generateTargetsTree", "classes/image.bbclass", []])
         elif next_command == self.SUB_GENERATE_PKGINFO:
@@ -451,6 +453,9 @@ class HobHandler(gobject.GObject):
                 ret.append(i)
         return " ".join(ret)
 
+    def set_var_in_file(self, var, val, default_file=None):
+        self.server.runCommand(["setVarFile", var, val, default_file])
+
     def get_parameters(self):
         # retrieve the parameters from bitbake
         params = {}
diff --git a/bitbake/lib/bb/ui/crumbs/template.py b/bitbake/lib/bb/ui/crumbs/template.py
index e303c3a..92c438f 100644
--- a/bitbake/lib/bb/ui/crumbs/template.py
+++ b/bitbake/lib/bb/ui/crumbs/template.py
@@ -137,8 +137,6 @@ class RecipeFile(ConfigFile):
 
 class TemplateMgr(gobject.GObject):
 
-    __gLocalVars__ = ["MACHINE", "PACKAGE_CLASSES", "DISTRO", "DL_DIR", "SSTATE_DIR", "SSTATE_MIRRORS", "PARALLEL_MAKE", "BB_NUMBER_THREADS", "CONF_VERSION"]
-    __gBBLayersVars__ = ["BBLAYERS", "LCONF_VERSION"]
     __gRecipeVars__ = ["DEPENDS", "IMAGE_INSTALL"]
 
     def __init__(self):
@@ -153,36 +151,20 @@ class TemplateMgr(gobject.GObject):
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
         self.image_bb = RecipeFile(TemplateMgr.convert_to_image_pathfilename(filename, path))
 
     def setVar(self, var, val):
-        if var in TemplateMgr.__gLocalVars__:
-            self.local_conf.setVar(var, val)
-        if var in TemplateMgr.__gBBLayersVars__:
-            self.bblayers_conf.setVar(var, val)
         if var in TemplateMgr.__gRecipeVars__:
             self.image_bb.setVar(var, val)
 
         self.template_hob.setVar(var, val)
 
     def save(self):
-        self.local_conf.save()
-        self.bblayers_conf.save()
         self.image_bb.save()
         self.template_hob.save()
 
@@ -200,12 +182,6 @@ class TemplateMgr(gobject.GObject):
         if self.template_hob:
             del self.template_hob
             template_hob = None
-        if self.bblayers_conf:
-            del self.bblayers_conf
-            self.bblayers_conf = None
-        if self.local_conf:
-            del self.local_conf
-            self.local_conf = None
         if self.image_bb:
             del self.image_bb
             self.image_bb = None
-- 
1.7.9.5



