Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qhow0-00046x-QD
	for bitbake-devel@lists.openembedded.org;
	Fri, 15 Jul 2011 22:24:29 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 15 Jul 2011 13:20:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,210,1309762800"; d="scan'208";a="27770693"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.32])
	by azsmga001.ch.intel.com with ESMTP; 15 Jul 2011 13:20:25 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jul 2011 13:20:13 -0700
Message-Id: <8fb497d1e0726dac790dc1c458e6378a10df0c15.1310761024.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1310761024.git.josh@linux.intel.com>
References: <cover.1310761024.git.josh@linux.intel.com>
In-Reply-To: <cover.1310761024.git.josh@linux.intel.com>
References: <cover.1310761024.git.josh@linux.intel.com>
Subject: [PATCH 1/6] ui/hob: replace the ugly static command map
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
X-List-Received-Date: Fri, 15 Jul 2011 20:24:29 -0000

The command_map was never a good idea, what's implemented here is a
fraction less ugly but a significant factor more readable and therefore
easy to maintain.
The method implemented in this patch also has the advantage of not being
static meaning we can determine the desired runCommand arguments
dynamically at call time.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobeventhandler.py |   63 ++++++++++++++++++++--------------
 lib/bb/ui/hob.py                    |    2 +-
 2 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index fa79e0c..50f3419 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -61,8 +61,11 @@ class HobHandler(gobject.GObject):
                                    gobject.TYPE_STRING)),
     }
 
+    (CFG_PATH_LOCAL, CFG_PATH_HOB, CFG_PATH_LAYERS, CFG_FILES_DISTRO, CFG_FILES_MACH, CFG_FILES_SDK, FILES_MATCH_CLASS, GENERATE_TGTS) = range(8)
+
     def __init__(self, taskmodel, server):
         gobject.GObject.__init__(self)
+
         self.current_command = None
         self.building = None
         self.gplv3_excluded = False
@@ -74,30 +77,40 @@ class HobHandler(gobject.GObject):
         self.model = taskmodel
         self.server = server
 
-        self.command_map = {
-            "findConfigFilePathLocal" : ("findConfigFilePath", ["hob.local.conf"], "findConfigFilePathHobLocal"),
-            "findConfigFilePathHobLocal" : ("findConfigFilePath", ["bblayers.conf"], "findConfigFilePathLayers"),
-            "findConfigFilePathLayers" : ("findConfigFiles", ["DISTRO"], "findConfigFilesDistro"),
-            "findConfigFilesDistro" : ("findConfigFiles", ["MACHINE"], "findConfigFilesMachine"),
-            "findConfigFilesMachine" : ("findConfigFiles", ["MACHINE-SDK"], "findConfigFilesSdkMachine"),
-            "findConfigFilesSdkMachine" : ("findFilesMatchingInDir", ["rootfs_", "classes"], "findFilesMatchingPackage"),
-            "findFilesMatchingPackage" : ("generateTargetsTree", ["classes/image.bbclass"], None),
-            "generateTargetsTree"  : (None, [], None),
-            }
-
     def run_next_command(self):
-        # FIXME: this is ugly and I *will* replace it
-        if self.current_command:
-            if not self.generating:
-                self.emit("generating-data")
-                self.generating = True
-            next_cmd = self.command_map[self.current_command]
-            command = next_cmd[0]
-            argument = next_cmd[1]
-            self.current_command = next_cmd[2]
-            args = [command]
-            args.extend(argument)
-            self.server.runCommand(args)
+        if self.current_command and not self.generating:
+            self.emit("generating-data")
+            self.generating = True
+
+        if self.current_command == self.CFG_PATH_LOCAL:
+            self.current_command = self.CFG_PATH_HOB
+            self.server.runCommand(["findConfigFilePath", "hob.local.conf"])
+        elif self.current_command == self.CFG_PATH_HOB:
+            self.current_command = self.CFG_PATH_LAYERS
+            self.server.runCommand(["findConfigFilePath", "bblayers.conf"])
+        elif self.current_command == self.CFG_PATH_LAYERS:
+            self.current_command = self.CFG_FILES_DISTRO
+            self.server.runCommand(["findConfigFiles", "DISTRO"])
+        elif self.current_command == self.CFG_FILES_DISTRO:
+            self.current_command = self.CFG_FILES_MACH
+            self.server.runCommand(["findConfigFiles", "MACHINE"])
+        elif self.current_command == self.CFG_FILES_MACH:
+            self.current_command = self.CFG_FILES_SDK
+            self.server.runCommand(["findConfigFiles", "MACHINE-SDK"])
+        elif self.current_command == self.CFG_FILES_SDK:
+            self.current_command = self.FILES_MATCH_CLASS
+            self.server.runCommand(["findFilesMatchingInDir", "rootfs_", "classes"])
+        elif self.current_command == self.FILES_MATCH_CLASS:
+            self.current_command = self.GENERATE_TGTS
+            self.server.runCommand(["generateTargetsTree", "classes/image.bbclass"])
+        elif self.current_command == self.GENERATE_TGTS:
+            if self.generating:
+                self.emit("data-generated")
+                self.generating = False
+            self.current_command = None
+        else:
+            # No command?
+            pass
 
     def handle_event(self, event, running_build, pbar):
         if not event:
@@ -107,8 +120,6 @@ class HobHandler(gobject.GObject):
         if self.building:
             running_build.handle_event(event)
         elif isinstance(event, bb.event.TargetsTreeGenerated):
-            self.emit("data-generated")
-            self.generating = False
             if event._model:
                 self.model.populate(event._model)
         elif isinstance(event, bb.event.ConfigFilesFound):
@@ -186,7 +197,7 @@ class HobHandler(gobject.GObject):
         selected_packages, _ = self.model.get_selected_packages()
         self.emit("reload-triggered", img, " ".join(selected_packages))
         self.server.runCommand(["reparseFiles"])
-        self.current_command = "findConfigFilePathLayers"
+        self.current_command = self.CFG_PATH_LAYERS
         self.run_next_command()
 
     def set_bbthreads(self, threads):
diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 06d936e..888f42e 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -906,7 +906,7 @@ def main (server, eventHandler):
 
     try:
         # kick the while thing off
-        handler.current_command = "findConfigFilePathLocal"
+        handler.current_command = handler.CFG_PATH_LOCAL
         server.runCommand(["findConfigFilePath", "local.conf"])
     except xmlrpclib.Fault:
         print("XMLRPC Fault getting commandline:\n %s" % x)
-- 
1.7.6



