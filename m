Return-Path: <cristiana.voicu@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id B3B4D6B485
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jul 2013 12:57:03 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 29 Jul 2013 05:57:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,769,1367996400"; d="scan'208";a="372876003"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga001.fm.intel.com with ESMTP; 29 Jul 2013 05:57:03 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Jul 2013 15:59:20 +0300
Message-Id: <1375102770-14079-7-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1375102770-14079-1-git-send-email-cristiana.voicu@intel.com>
References: <1375102770-14079-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH_V3 06/16] hob & bitbake: append a value to a variable from hob throught bitbake
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
X-List-Received-Date: Mon, 29 Jul 2013 12:57:03 -0000

It was necessary to append ${TOPDIR}/recipes/images to BBFILES.
Implemented the mechanism to append a value to a variable: a command and
the method in cooker.

[YOCTO #4193]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/command.py                   |    5 +++--
 bitbake/lib/bb/cooker.py                    |   29 +++++++++++++++++++++++++++
 bitbake/lib/bb/data.py                      |    4 ++++
 bitbake/lib/bb/ui/crumbs/builder.py         |    1 +
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |   11 +++++++++-
 5 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 5eb34af..33a2440 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -153,7 +153,7 @@ class CommandsSync:
         varname = params[0]
         expand = True
         if len(params) > 1:
-            expand = params[1]
+            expand = (params[1] == "True")
 
         return command.cooker.data.getVar(varname, expand)
     getVariable.readonly = True
@@ -230,7 +230,8 @@ class CommandsSync:
         var = params[0]
         val = params[1]
         default_file = params[2]
-        command.cooker.saveConfigurationVar(var, val, default_file)
+        op = params[3]
+        command.cooker.modifyConfigurationVar(var, val, default_file, op)
 
     def createConfigFile(self, command, params):
         """
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 7ca9947..a4a6be6 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -162,6 +162,35 @@ class BBCooker:
         self.data = self.databuilder.data
         self.data_hash = self.databuilder.data_hash
 
+    def modifyConfigurationVar(self, var, val, default_file, op):
+        if op == "append":
+            self.appendConfigurationVar(var, val, default_file)
+        elif op == "set":
+            self.saveConfigurationVar(var, val, default_file)
+
+    def appendConfigurationVar(self, var, val, default_file):
+        #add append var operation to the end of default_file
+        default_file = bb.cookerdata.findConfigFile(default_file)
+
+        with open(default_file, 'r') as f:
+            contents = f.readlines()
+        f.close()
+
+        total = ""
+        for c in contents:
+            total += c
+
+        total += "#added by bitbake"
+        total += "\n%s += \"%s\"\n" % (var, val)
+
+        with open(default_file, 'w') as f:
+            f.write(total)
+        f.close()
+
+        #add to history
+        loginfo = {"op":append, "file":default_file, "line":total.count("\n")}
+        self.data.appendVar(var, val, **loginfo)
+
     def saveConfigurationVar(self, var, val, default_file):
 
         replaced = False
diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 87c4808..8c9cb0f 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -97,6 +97,10 @@ def delVar(var, d):
     """Removes a variable from the data set"""
     d.delVar(var)
 
+def appendVar(var, value, d):
+    """Append additional value to a variable"""
+    d.appendVar(var, value)
+
 def setVarFlag(var, flag, flagvalue, d):
     """Set a flag for a given variable to a given value"""
     d.setVarFlag(var, flag, flagvalue)
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 6bf4024..3ddfb36 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -440,6 +440,7 @@ class Builder(gtk.Window):
         self.handler.connect("recipe-populated",         self.handler_recipe_populated_cb)
         self.handler.connect("package-populated",        self.handler_package_populated_cb)
 
+        self.handler.append_to_bbfiles("${TOPDIR}/recipes/images/*.bb")
         self.initiate_new_build_async()
 
         signal.signal(signal.SIGINT, self.event_handle_SIGINT)
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 42fd0b9..7854742 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -471,9 +471,18 @@ class HobHandler(gobject.GObject):
 
     def set_var_in_file(self, var, val, default_file=None):
         self.runCommand(["enableDataTracking"])
-        self.server.runCommand(["setVarFile", var, val, default_file])
+        self.server.runCommand(["setVarFile", var, val, default_file, "set"])
         self.runCommand(["disableDataTracking"])
 
+    def append_var_in_file(self, var, val, default_file=None):
+        self.server.runCommand(["setVarFile", var, val, default_file, "append"])
+
+    def append_to_bbfiles(self, val):
+        bbfiles = self.runCommand(["getVariable", "BBFILES", "False"]) or ""
+        bbfiles = bbfiles.split()
+        if val not in bbfiles:
+            self.append_var_in_file("BBFILES", val, "local.conf")
+
     def get_parameters(self):
         # retrieve the parameters from bitbake
         params = {}
-- 
1.7.9.5


