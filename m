Return-Path: <cristiana.voicu@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id E996260FA6
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Oct 2013 13:15:23 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 04 Oct 2013 06:15:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1033,1371106800"; d="scan'208";a="369798750"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.65])
	by azsmga001.ch.intel.com with ESMTP; 04 Oct 2013 06:15:24 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Oct 2013 16:19:45 +0300
Message-Id: <1380892785-32612-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] bitbake/hob: removing extra parameters from conf files using hob
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 04 Oct 2013 13:15:24 -0000

In Hob settings, there is a tab to add/remove extra settings. This
patch implements a way to "remove" variables from conf files, through
bitbake. But, to keep the history assigment of the variables synchronized,
instead of removing, it replaces the lines with blank lines.

[YOCTO #5284]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/command.py                   |    7 +++++
 bitbake/lib/bb/cooker.py                    |   38 +++++++++++++++++++++++++++
 bitbake/lib/bb/data_smart.py                |    8 ++++--
 bitbake/lib/bb/ui/crumbs/builder.py         |    2 +-
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |   17 ++++++++++++
 5 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 21a6de0..3ca27a6 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -241,6 +241,13 @@ class CommandsSync:
         op = params[3]
         command.cooker.modifyConfigurationVar(var, val, default_file, op)
 
+    def removeVarFile(self, command, params):
+        """
+        Remove a variable declaration from a file
+        """
+        var = params[0]
+        command.cooker.removeConfigurationVar(var)
+
     def createConfigFile(self, command, params):
         """
         Create an extra configuration file
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index ff2af69..36d013d 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -301,6 +301,44 @@ class BBCooker:
             loginfo = {"op":set, "file":default_file, "line":total.count("\n")}
             self.data.setVar(var, val, **loginfo)
 
+    def removeConfigurationVar(self, var):
+        conf_files = self.data.varhistory.get_variable_files(var)
+        topdir = self.data.getVar("TOPDIR")
+
+        for conf_file in conf_files:
+            if topdir in conf_file:
+                with open(conf_file, 'r') as f:
+                    contents = f.readlines()
+                f.close()
+
+                lines = self.data.varhistory.get_variable_lines(var, conf_file)
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
+
+                    #check if the variable was saved before in the same way
+                    if contents[begin_line-1]== "#added by bitbake\n":
+                        contents[begin_line-1] = contents[begin_line] = "\n"
+                    else:
+                        contents[begin_line] = "\n"
+                    #remove var from history
+                    self.data.varhistory.del_var_history(var, conf_file, line)
+
+                total = ""
+                for c in contents:
+                    total += c
+                with open(conf_file, 'w') as f:
+                    f.write(total)
+                f.close()
+
     def createConfigFile(self, name):
         path = os.getcwd()
         confpath = os.path.join(path, "conf", name)
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index b6f5b78..a1cbaba 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -281,9 +281,13 @@ class VariableHistory(object):
                 lines.append(line)
         return lines
 
-    def del_var_history(self, var):
+    def del_var_history(self, var, f=None, line=None):
+        """If file f and line are not given, the entire history of var is deleted"""
         if var in self.variables:
-            self.variables[var] = []
+            if f and line:
+                self.variables[var] = [ x for x in self.variables[var] if x['file']!=f and x['line']!=line]
+            else:
+                self.variables[var] = []
 
 class DataSmart(MutableMapping):
     def __init__(self, special = COWDictBase.copy(), seen = COWDictBase.copy() ):
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 8292813..dc60d90 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -218,7 +218,7 @@ class Configuration:
         handler.set_var_in_file("SDKMACHINE", self.curr_sdk_machine, "local.conf")
         handler.set_var_in_file("CONF_VERSION", self.conf_version, "local.conf")
         handler.set_var_in_file("LCONF_VERSION", self.lconf_version, "bblayers.conf")
-        handler.set_var_in_file("EXTRA_SETTING", self.extra_setting, "local.conf")
+        handler.set_extra_config(self.extra_setting)
         handler.set_var_in_file("TOOLCHAIN_BUILD", self.toolchain_build, "local.conf")
         handler.set_var_in_file("IMAGE_FSTYPES", self.image_fstypes, "local.conf")
         if not defaults:
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index ef74e56..5683a7c 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -21,6 +21,7 @@
 
 import gobject
 import logging
+import ast
 from bb.ui.crumbs.runningbuild import RunningBuild
 
 class HobHandler(gobject.GObject):
@@ -357,7 +358,20 @@ class HobHandler(gobject.GObject):
     def set_incompatible_license(self, incompat_license):
         self.set_var_in_file("INCOMPATIBLE_LICENSE", incompat_license, "local.conf")
 
+    def set_extra_setting(self, extra_setting):
+        self.set_var_in_file("EXTRA_SETTING", extra_setting, "local.conf")
+
     def set_extra_config(self, extra_setting):
+        old_extra_setting = ast.literal_eval(self.runCommand(["getVariable", "EXTRA_SETTING"]) or "{}")
+        if extra_setting:
+            self.set_var_in_file("EXTRA_SETTING", extra_setting, "local.conf")
+        else:
+            self.remove_var_from_file("EXTRA_SETTING")
+
+        #remove not needed settings from conf
+        for key in old_extra_setting:
+            if key not in extra_setting:
+                self.remove_var_from_file(key)
         for key in extra_setting.keys():
             value = extra_setting[key]
             self.set_var_in_file(key, value, "local.conf")
@@ -472,6 +486,9 @@ class HobHandler(gobject.GObject):
         self.server.runCommand(["setVarFile", var, val, default_file, "set"])
         self.runCommand(["disableDataTracking"])
 
+    def remove_var_from_file(self, var):
+        self.server.runCommand(["removeVarFile", var])
+
     def append_var_in_file(self, var, val, default_file=None):
         self.server.runCommand(["setVarFile", var, val, default_file, "append"])
 
-- 
1.7.9.5


