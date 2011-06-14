Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1QWNju-0000Ep-7e
	for bitbake-devel@lists.openembedded.org;
	Tue, 14 Jun 2011 09:08:43 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 14 Jun 2011 00:04:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,363,1304319600"; d="scan'208";a="13214388"
Received: from llu-piketon.sh.intel.com (HELO localhost) ([10.239.36.87])
	by orsmga002.jf.intel.com with ESMTP; 14 Jun 2011 00:03:59 -0700
From: Lianhao Lu <lianhao.lu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 14 Jun 2011 15:12:16 +0800
Message-Id: <714d7805d3c23cb9c13724502dc37e1eb9d0b90a.1308034271.git.lianhao.lu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1308034271.git.lianhao.lu@intel.com>
References: <cover.1308034271.git.lianhao.lu@intel.com>
Subject: [RFC PATCH 1/1] bitbake cooker/ui: handle cmd line parsing result by individual UI.
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
X-List-Received-Date: Tue, 14 Jun 2011 07:08:43 -0000

Changed the return result of "getCmdLineAction" to a dictionary
{'action', 'msg'} to allow the individual UI decide how to handle the
cmd line parsing result.

Signed-off-by: Lianhao Lu <lianhao.lu@intel.com>
---
 bitbake/lib/bb/cooker.py     |   34 ++++++++++++++++------------------
 bitbake/lib/bb/ui/depexp.py  |    7 +++++--
 bitbake/lib/bb/ui/goggle.py  |    6 +++++-
 bitbake/lib/bb/ui/knotty.py  |    6 +++++-
 bitbake/lib/bb/ui/ncurses.py |    6 +++++-
 5 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index c81baf6..76c29a8 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -176,41 +176,39 @@ class BBCooker:
 
     def parseCommandLine(self):
         # Parse any commandline into actions
+        self.commandlineAction = {'action':None, 'msg':None}
         if self.configuration.show_environment:
-            self.commandlineAction = None
-
             if 'world' in self.configuration.pkgs_to_build:
-                buildlog.error("'world' is not a valid target for --environment.")
-            if 'universe' in self.configuration.pkgs_to_build:
-                buildlog.error("'universe' is not a valid target for --environment.")
+                self.commandlineAction['msg'] = "'world' is not a valid target for --environment."
+            elif 'universe' in self.configuration.pkgs_to_build:
+                self.commandlineAction['msg'] = "'universe' is not a valid target for --environment."
             elif len(self.configuration.pkgs_to_build) > 1:
-                buildlog.error("Only one target can be used with the --environment option.")
+                self.commandlineAction['msg'] = "Only one target can be used with the --environment option."
             elif self.configuration.buildfile and len(self.configuration.pkgs_to_build) > 0:
-                buildlog.error("No target should be used with the --environment and --buildfile options.")
+                self.commandlineAction['msg'] = "No target should be used with the --environment and --buildfile options."
             elif len(self.configuration.pkgs_to_build) > 0:
-                self.commandlineAction = ["showEnvironmentTarget", self.configuration.pkgs_to_build]
+                self.commandlineAction['action'] = ["showEnvironmentTarget", self.configuration.pkgs_to_build]
             else:
-                self.commandlineAction = ["showEnvironment", self.configuration.buildfile]
+                self.commandlineAction['action'] = ["showEnvironment", self.configuration.buildfile]
         elif self.configuration.buildfile is not None:
-            self.commandlineAction = ["buildFile", self.configuration.buildfile, self.configuration.cmd]
+            self.commandlineAction['action'] = ["buildFile", self.configuration.buildfile, self.configuration.cmd]
         elif self.configuration.revisions_changed:
-            self.commandlineAction = ["compareRevisions"]
+            self.commandlineAction['action'] = ["compareRevisions"]
         elif self.configuration.show_versions:
-            self.commandlineAction = ["showVersions"]
+            self.commandlineAction['action'] = ["showVersions"]
         elif self.configuration.parse_only:
-            self.commandlineAction = ["parseFiles"]
+            self.commandlineAction['action'] = ["parseFiles"]
         elif self.configuration.dot_graph:
             if self.configuration.pkgs_to_build:
-                self.commandlineAction = ["generateDotGraph", self.configuration.pkgs_to_build, self.configuration.cmd]
+                self.commandlineAction['action'] = ["generateDotGraph", self.configuration.pkgs_to_build, self.configuration.cmd]
             else:
-                self.commandlineAction = None
-                buildlog.error("Please specify a package name for dependency graph generation.")
+                self.commandlineAction['msg'] = "Please specify a package name for dependency graph generation."
         else:
             if self.configuration.pkgs_to_build:
-                self.commandlineAction = ["buildTargets", self.configuration.pkgs_to_build, self.configuration.cmd]
+                self.commandlineAction['action'] = ["buildTargets", self.configuration.pkgs_to_build, self.configuration.cmd]
             else:
+                #self.commandlineAction['msg'] = "Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information."
                 self.commandlineAction = None
-                buildlog.error("Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.")
 
     def runCommands(self, server, data, abort):
         """
diff --git a/bitbake/lib/bb/ui/depexp.py b/bitbake/lib/bb/ui/depexp.py
index 575dd1c..0d58505 100644
--- a/bitbake/lib/bb/ui/depexp.py
+++ b/bitbake/lib/bb/ui/depexp.py
@@ -199,10 +199,13 @@ class gtkthread(threading.Thread):
 def main(server, eventHandler):
     try:
         cmdline = server.runCommand(["getCmdLineAction"])
-        if not cmdline or cmdline[0] != "generateDotGraph":
+        if cmdline and not cmdline['action']:
+            print(cmdline['msg'])
+            return
+        elif not cmdline or (cmdline['action'] and cmdline['action'][0] != "generateDotGraph"):
             print("This UI is only compatible with the -g option")
             return
-        ret = server.runCommand(["generateDepTreeEvent", cmdline[1], cmdline[2]])
+        ret = server.runCommand(["generateDepTreeEvent", cmdline['action'][1], cmdline['action'][2]])
         if ret != True:
             print("Couldn't run command! %s" % ret)
             return
diff --git a/bitbake/lib/bb/ui/goggle.py b/bitbake/lib/bb/ui/goggle.py
index bd03d31..b2fd274 100644
--- a/bitbake/lib/bb/ui/goggle.py
+++ b/bitbake/lib/bb/ui/goggle.py
@@ -82,8 +82,12 @@ def main (server, eventHandler):
     try:
         cmdline = server.runCommand(["getCmdLineAction"])
         if not cmdline:
+            print("Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.")
             return 1
-        ret = server.runCommand(cmdline)
+        elif not cmdline['action']:
+            print(cmdline['msg'])
+            return 1
+        ret = server.runCommand(cmdline['action'])
         if ret != True:
             print("Couldn't get default commandline! %s" % ret)
             return 1
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 997eb3f..a4deb46 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -80,8 +80,12 @@ def main(server, eventHandler):
     try:
         cmdline = server.runCommand(["getCmdLineAction"])
         if not cmdline:
+            print("Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.")
             return 1
-        ret = server.runCommand(cmdline)
+        elif not cmdline['action']:
+            print(cmdline['msg'])
+            return 1
+        ret = server.runCommand(cmdline['action'])
         if ret != True:
             print("Couldn't get default commandline! %s" % ret)
             return 1
diff --git a/bitbake/lib/bb/ui/ncurses.py b/bitbake/lib/bb/ui/ncurses.py
index 469f1b7..8684697 100644
--- a/bitbake/lib/bb/ui/ncurses.py
+++ b/bitbake/lib/bb/ui/ncurses.py
@@ -232,8 +232,12 @@ class NCursesUI:
         try:
             cmdline = server.runCommand(["getCmdLineAction"])
             if not cmdline:
+                print("Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.")
                 return
-            ret = server.runCommand(cmdline)
+            elif not cmdline['action']:
+                print(cmdline['msg'])
+                return
+            ret = server.runCommand(cmdline['action'])
             if ret != True:
                 print("Couldn't get default commandlind! %s" % ret)
                 return
-- 
1.7.0.4



