Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SEJrB-00045X-1C
	for bitbake-devel@lists.openembedded.org;
	Sun, 01 Apr 2012 14:26:05 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 01 Apr 2012 05:16:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="84032723"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by AZSMGA002.ch.intel.com with ESMTP; 01 Apr 2012 05:16:56 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  1 Apr 2012 20:14:15 +0800
Message-Id: <c96ae687bf17755f49b91bba83776428237b9653.1333269705.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333269705.git.dongxiao.xu@intel.com>
References: <cover.1333269705.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333269705.git.dongxiao.xu@intel.com>
References: <cover.1333269705.git.dongxiao.xu@intel.com>
Subject: [PATCH 07/10] Hob: Fix toolchain build
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
X-List-Received-Date: Sun, 01 Apr 2012 12:26:05 -0000

Originally we added -dev and -dbg postfixes to our selected packages as
toolchain packages. However, some package names are modified in recipes,
so we could not rely on its base name. The new approach is to detect if
a package is selected, then include those packages under the same recipe
endswith "-dev" and "-dbg".

This fixes [YOCTO #2185]

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py         |    9 ++++++---
 lib/bb/ui/crumbs/hobeventhandler.py |    9 ++++-----
 lib/bb/ui/crumbs/hoblistmodel.py    |   16 ++++++++++++++++
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 44b208a..8427623 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -457,12 +457,15 @@ class Builder(gtk.Window):
     def generate_image(self):
         # Build image
         self.set_user_config()
-        all_packages = self.package_model.get_selected_packages()
+        packages = self.package_model.get_selected_packages()
+        toolchain_packages = []
+        if self.configuration.toolchain_build:
+            toolchain_packages = self.package_model.get_selected_packages_toolchain()
         self.handler.reset_build()
-        self.handler.generate_image(all_packages,
+        self.handler.generate_image(packages,
                                     self.hob_image,
                                     self.hob_toolchain,
-                                    self.configuration.toolchain_build)
+                                    toolchain_packages)
 
     # Callback Functions
     def handler_config_updated_cb(self, handler, which, values):
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 74081dc..8909e01 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -131,9 +131,8 @@ class HobHandler(gobject.GObject):
             targets = [self.hob_image]
             self.server.runCommand(["setVariable", "LINGUAS_INSTALL", ""])
             self.server.runCommand(["setVariable", "PACKAGE_INSTALL", " ".join(self.package_queue)])
-            if self.toolchain_build:
-                pkgs = self.package_queue + [i+'-dev' for i in self.package_queue] + [i+'-dbg' for i in self.package_queue]
-                self.server.runCommand(["setVariable", "TOOLCHAIN_TARGET_TASK", " ".join(pkgs)])
+            if self.toolchain_packages:
+                self.server.runCommand(["setVariable", "TOOLCHAIN_TARGET_TASK", " ".join(self.toolchain_packages)])
                 targets.append(self.hob_toolchain)
             self.server.runCommand(["buildTargets", targets, "build"])
 
@@ -350,11 +349,11 @@ class HobHandler(gobject.GObject):
         self.commands_async.append(self.SUB_BUILD_RECIPES)
         self.run_next_command(self.GENERATE_PACKAGES)
 
-    def generate_image(self, tgts, hob_image, hob_toolchain, toolchain_build=False):
+    def generate_image(self, tgts, hob_image, hob_toolchain, toolchain_packages=[]):
         self.package_queue = tgts
         self.hob_image = hob_image
         self.hob_toolchain = hob_toolchain
-        self.toolchain_build = toolchain_build
+        self.toolchain_packages = toolchain_packages
         self.commands_async.append(self.SUB_PARSE_CONFIG)
         self.commands_async.append(self.SUB_BUILD_IMAGE)
         self.run_next_command(self.GENERATE_IMAGE)
diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
index 6a829e2..a351597 100644
--- a/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/lib/bb/ui/crumbs/hoblistmodel.py
@@ -357,6 +357,22 @@ class PackageListModel(gtk.TreeStore):
 
         return packagelist
 
+    def get_selected_packages_toolchain(self):
+        packagelist = []
+
+        it = self.get_iter_first()
+        while it:
+            if self.get_value(it, self.COL_INC):
+                child_it = self.iter_children(it)
+                while child_it:
+                    name = self.get_value(child_it, self.COL_NAME)
+                    inc = self.get_value(child_it, self.COL_INC)
+                    if inc or name.endswith("-dev") or name.endswith("-dbg"):
+                        packagelist.append(name)
+                    child_it = self.iter_next(child_it)
+            it = self.iter_next(it)
+
+        return packagelist
     """
     Return the selected package size, unit is KB.
     """
-- 
1.7.4.1



