Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 93881608C5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 May 2013 21:55:03 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4KLwOpS025733; Mon, 20 May 2013 22:58:24 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id rfupYL_31Nwx; Mon, 20 May 2013 22:58:23 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4KLwILp025726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 20 May 2013 22:58:20 +0100
Message-ID: <1369086881.4326.8.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Damian, Alexandru" <alexandru.damian@intel.com>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
Date: Mon, 20 May 2013 22:54:41 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cooker: Move commandline parsing back into the UI/cookerdata
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
X-List-Received-Date: Mon, 20 May 2013 21:55:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit


Building up a set of actions for the server is tricky since we depend upon the
commandline but fall back to values from the datastore. We should be able to build
a datastore without a commandline and vice versa. Ultimately the UI should send
the commands to the server.

This patch amounts to code rearranging, moving the heavy lifting to the UI, though
a helper in the configuration option. This will need further cleanup/tweaking but
this should be the only update needed to the UIs. The code now queries the server
for any missing data should it need to.

This code allows various knowledge of configuration variables to move to the UI side
only, partcularly pkgs_to_build but also all the command specifiers. It should also
be possible to move cmd eventually, I'm just unsure if any callers call the commands
expecting this to default to something sane right now.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 7087d2d..c87e5b3 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -238,7 +238,6 @@ def main():
     try:
         configuration.setServerRegIdleCallback(server.getServerIdleCB())
         cooker = bb.cooker.BBCooker(configuration)
-        cooker.parseCommandLine()
 
         server.addcooker(cooker)
         server.saveConnectionDetails()
@@ -272,7 +271,7 @@ def main():
             os.environ[k] = cleanedvars[k]
 
         try:
-            return server.launchUI(ui_main, server_connection.connection, server_connection.events)
+            return server.launchUI(ui_main, server_connection.connection, server_connection.events, configParams)
         finally:
             bb.event.ui_queue = []
             server_connection.terminate()
diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 8577df6..29d31d5 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -143,18 +143,6 @@ class CommandsSync:
         """
         command.cooker.stop()
 
-    def getCmdLineAction(self, command, params):
-        """
-        Get any command parsed from the commandline
-        """
-        cmd_action = command.cooker.commandlineAction
-        if cmd_action is None:
-            return None
-        elif 'msg' in cmd_action and cmd_action['msg']:
-            raise CommandError(cmd_action['msg'])
-        else:
-            return cmd_action['action']
-
     def getVariable(self, command, params):
         """
         Read the value of a variable from configuration.data
@@ -174,6 +162,14 @@ class CommandsSync:
         value = str(params[1])
         command.cooker.configuration.data.setVar(varname, value)
 
+    def setConfig(self, command, params):
+        """
+        Set the value of variable in configuration
+        """
+        varname = params[0]
+        value = str(params[1])
+        setattr(command.cooker.configuration, varname, value)
+
     def enableDataTracking(self, command, params):
         """
         Enable history tracking for variables
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 1a2c016..ca54455 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -147,10 +147,6 @@ class BBCooker:
         if not self.lock:
             bb.fatal("Only one copy of bitbake should be run against a build directory")
 
-        bbpkgs = self.configuration.data.getVar('BBPKGS', True)
-        if bbpkgs and len(self.configuration.pkgs_to_build) == 0:
-            self.configuration.pkgs_to_build.extend(bbpkgs.split())
-
         #
         # Special updated configuration we use for firing events
         #
@@ -175,7 +171,7 @@ class BBCooker:
 
     def initConfigurationData(self):
         self.configuration.data = bb.data.init()
-        if self.configuration.show_environment:
+        if self.configuration.tracking:
             self.configuration.data.enableTracking()
 
         if not self.configuration.server_register_idlecallback:
@@ -203,9 +199,6 @@ class BBCooker:
             logger.exception("Error parsing configuration files")
             sys.exit(1)
 
-        if not self.configuration.cmd:
-            self.configuration.cmd = self.configuration.data.getVar("BB_DEFAULT_TASK", True) or "build"
-
     def saveConfigurationVar(self, var, val, default_file):
 
         replaced = False
@@ -309,44 +302,6 @@ class BBCooker:
 
         self.handleCollections( self.configuration.data.getVar("BBFILE_COLLECTIONS", True) )
 
-    def parseCommandLine(self):
-        # Parse any commandline into actions
-        self.commandlineAction = {'action':None, 'msg':None}
-        if self.configuration.show_environment:
-            if 'world' in self.configuration.pkgs_to_build:
-                self.commandlineAction['msg'] = "'world' is not a valid target for --environment."
-            elif 'universe' in self.configuration.pkgs_to_build:
-                self.commandlineAction['msg'] = "'universe' is not a valid target for --environment."
-            elif len(self.configuration.pkgs_to_build) > 1:
-                self.commandlineAction['msg'] = "Only one target can be used with the --environment option."
-            elif self.configuration.buildfile and len(self.configuration.pkgs_to_build) > 0:
-                self.commandlineAction['msg'] = "No target should be used with the --environment and --buildfile options."
-            elif len(self.configuration.pkgs_to_build) > 0:
-                self.commandlineAction['action'] = ["showEnvironmentTarget", self.configuration.pkgs_to_build]
-                self.configuration.data.setVar("BB_CONSOLELOG", None)
-            else:
-                self.commandlineAction['action'] = ["showEnvironment", self.configuration.buildfile]
-                self.configuration.data.setVar("BB_CONSOLELOG", None)
-        elif self.configuration.buildfile is not None:
-            self.commandlineAction['action'] = ["buildFile", self.configuration.buildfile, self.configuration.cmd]
-        elif self.configuration.revisions_changed:
-            self.commandlineAction['action'] = ["compareRevisions"]
-        elif self.configuration.show_versions:
-            self.commandlineAction['action'] = ["showVersions"]
-        elif self.configuration.parse_only:
-            self.commandlineAction['action'] = ["parseFiles"]
-        elif self.configuration.dot_graph:
-            if self.configuration.pkgs_to_build:
-                self.commandlineAction['action'] = ["generateDotGraph", self.configuration.pkgs_to_build, self.configuration.cmd]
-            else:
-                self.commandlineAction['msg'] = "Please specify a package name for dependency graph generation."
-        else:
-            if self.configuration.pkgs_to_build:
-                self.commandlineAction['action'] = ["buildTargets", self.configuration.pkgs_to_build, self.configuration.cmd]
-            else:
-                #self.commandlineAction['msg'] = "Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information."
-                self.commandlineAction = None
-
     def runCommands(self, server, data, abort):
         """
         Run any queued asynchronous command
diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 2c3275a..3c2469e 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -50,6 +50,61 @@ class ConfigParameters(object):
     def parseEnvironment(self):
         return os.environ.copy()
 
+    def updateFromServer(self, server):
+        if not self.options.cmd:
+            defaulttask, error = server.runCommand(["getVariable", "BB_DEFAULT_TASK"])
+            if error:
+                raise Exception("Unable to get the value of BB_DEFAULT_TASK from the server: %s" % error)
+            self.options.cmd = defaulttask or "build"
+        _, error = server.runCommand(["setConfig", "cmd", self.options.cmd])
+        if error:
+            raise Exception("Unable to set configuration option 'cmd' on the server: %s" % error)
+
+        if not self.options.pkgs_to_build:
+            bbpkgs, error = server.runCommand(["getVariable", "BBPKGS"])
+            if error:
+                raise Exception("Unable to get the value of BBPKGS from the server: %s" % error)
+            if bbpkgs:
+                self.options.pkgs_to_build.extend(bbpkgs.split())
+
+    def parseActions(self):
+        # Parse any commandline into actions
+        action = {'action':None, 'msg':None}
+        if self.options.show_environment:
+            if 'world' in self.options.pkgs_to_build:
+                action['msg'] = "'world' is not a valid target for --environment."
+            elif 'universe' in self.options.pkgs_to_build:
+                action['msg'] = "'universe' is not a valid target for --environment."
+            elif len(self.options.pkgs_to_build) > 1:
+                action['msg'] = "Only one target can be used with the --environment option."
+            elif self.options.buildfile and len(self.options.pkgs_to_build) > 0:
+                action['msg'] = "No target should be used with the --environment and --buildfile options."
+            elif len(self.options.pkgs_to_build) > 0:
+                action['action'] = ["showEnvironmentTarget", self.options.pkgs_to_build]
+            else:
+                action['action'] = ["showEnvironment", self.options.buildfile]
+        elif self.options.buildfile is not None:
+            action['action'] = ["buildFile", self.options.buildfile, self.options.cmd]
+        elif self.options.revisions_changed:
+            action['action'] = ["compareRevisions"]
+        elif self.options.show_versions:
+            action['action'] = ["showVersions"]
+        elif self.options.parse_only:
+            action['action'] = ["parseFiles"]
+        elif self.options.dot_graph:
+            if self.options.pkgs_to_build:
+                action['action'] = ["generateDotGraph", self.options.pkgs_to_build, self.options.cmd]
+            else:
+                action['msg'] = "Please specify a package name for dependency graph generation."
+        else:
+            if self.options.pkgs_to_build:
+                action['action'] = ["buildTargets", self.options.pkgs_to_build, self.options.cmd]
+            else:
+                #action['msg'] = "Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information."
+                action = None
+        self.options.initialaction = action
+        return action
+
 class CookerConfiguration(object):
     """
     Manages build options and configurations for one run
@@ -61,7 +116,7 @@ class CookerConfiguration(object):
         self.prefile = []
         self.postfile = []
         self.debug = 0
-        self.pkgs_to_build = []
+        self.cmd = None
 
     def setConfigParameters(self, parameters):
         self.params = parameters
diff --git a/bitbake/lib/bb/ui/depexp.py b/bitbake/lib/bb/ui/depexp.py
index 85910f6..885c31a 100644
--- a/bitbake/lib/bb/ui/depexp.py
+++ b/bitbake/lib/bb/ui/depexp.py
@@ -196,16 +196,18 @@ class gtkthread(threading.Thread):
         gtkthread.quit.set()
 

-def main(server, eventHandler):
+def main(server, eventHandler, params):
     try:
-        cmdline, error = server.runCommand(["getCmdLineAction"])
-        if error:
-            print("Error getting bitbake commandline: %s" % error)
-            return 1
-        elif not cmdline:
+        params.updateFromServer(server)
+        cmdline = params.parseActions()
+        if not cmdline:
             print("Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.")
             return 1
-        elif not cmdline or cmdline[0] != "generateDotGraph":
+        if 'msg' in cmdline and cmdline['msg']:
+            logger.error(cmdline['msg'])
+            return 1
+        cmdline = cmdline['action']
+        if not cmdline or cmdline[0] != "generateDotGraph":
             print("This UI is only compatible with the -g option")
             return 1
         ret, error = server.runCommand(["generateDepTreeEvent", cmdline[1], cmdline[2]])
diff --git a/bitbake/lib/bb/ui/goggle.py b/bitbake/lib/bb/ui/goggle.py
index e8a54ab..16faba4 100644
--- a/bitbake/lib/bb/ui/goggle.py
+++ b/bitbake/lib/bb/ui/goggle.py
@@ -63,7 +63,7 @@ class MainWindow (gtk.Window):
         scrolled_window.add (self.cur_build_tv)
 

-def main (server, eventHandler):
+def main (server, eventHandler, params):
     gobject.threads_init()
     gtk.gdk.threads_init()
 
@@ -80,13 +80,15 @@ def main (server, eventHandler):
     running_build.connect ("build-failed", running_build_failed_cb)
 
     try:
-        cmdline, error = server.runCommand(["getCmdLineAction"])
-        if error:
-            print("Error getting bitbake commandline: %s" % error)
-            return 1
-        elif not cmdline:
+        params.updateFromServer(server)
+        cmdline = params.parseActions()
+        if not cmdline:
             print("Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.")
             return 1
+        if 'msg' in cmdline and cmdline['msg']:
+            logger.error(cmdline['msg'])
+            return 1
+        cmdline = cmdline['action']
         ret, error = server.runCommand(cmdline)
         if error:
             print("Error running command '%s': %s" % (cmdline, error))
diff --git a/bitbake/lib/bb/ui/hob.py b/bitbake/lib/bb/ui/hob.py
index 55bd84c..2c75cb8 100755
--- a/bitbake/lib/bb/ui/hob.py
+++ b/bitbake/lib/bb/ui/hob.py
@@ -58,7 +58,8 @@ def event_handle_idle_func(eventHandler, hobHandler):
         event = eventHandler.getEvent()
     return True
 
-def main (server = None, eventHandler = None):
+def main (server, eventHandler, params):
+    params.updateFromServer(server)
     gobject.threads_init()
 
     # That indicates whether the Hob and the bitbake server are
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 6ea7d86..389c3cc 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -216,7 +216,7 @@ class TerminalFilter(object):
             fd = sys.stdin.fileno()
             self.termios.tcsetattr(fd, self.termios.TCSADRAIN, self.stdinbackup)
 
-def main(server, eventHandler, tf = TerminalFilter):
+def main(server, eventHandler, params, tf = TerminalFilter):
 
     # Get values of variables which control our output
     includelogs, error = server.runCommand(["getVariable", "BBINCLUDELOGS"])
@@ -245,7 +245,8 @@ def main(server, eventHandler, tf = TerminalFilter):
     bb.msg.addDefaultlogFilter(console)
     console.setFormatter(format)
     logger.addHandler(console)
-    if consolelogfile:
+
+    if consolelogfile and not params.options.show_environment:
         bb.utils.mkdirhier(os.path.dirname(consolelogfile))
         conlogformat = bb.msg.BBLogFormatter(format_str)
         consolelog = logging.FileHandler(consolelogfile)
@@ -254,14 +255,16 @@ def main(server, eventHandler, tf = TerminalFilter):
         logger.addHandler(consolelog)
 
     try:
-        cmdline, error = server.runCommand(["getCmdLineAction"])
-        if error:
-            logger.error("Unable to get bitbake commandline arguments: %s" % error)
-            return 1
-        elif not cmdline:
+        params.updateFromServer(server)
+        cmdline = params.parseActions()
+        if not cmdline:
             print("Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.")
             return 1
-        ret, error = server.runCommand(cmdline)
+        if 'msg' in cmdline and cmdline['msg']:
+            logger.error(cmdline['msg'])
+            return 1
+
+        ret, error = server.runCommand(cmdline['action'])
         if error:
             logger.error("Command '%s' failed: %s" % (cmdline, error))
             return 1
diff --git a/bitbake/lib/bb/ui/ncurses.py b/bitbake/lib/bb/ui/ncurses.py
index 98647fc..c45ffd6 100644
--- a/bitbake/lib/bb/ui/ncurses.py
+++ b/bitbake/lib/bb/ui/ncurses.py
@@ -196,7 +196,7 @@ class NCursesUI:
 #            t.start()
 
     #-------------------------------------------------------------------------#
-    def main(self, stdscr, server, eventHandler):
+    def main(self, stdscr, server, eventHandler, params):
     #-------------------------------------------------------------------------#
         height, width = stdscr.getmaxyx()
 
@@ -236,13 +236,15 @@ class NCursesUI:
         shutdown = 0
 
         try:
-            cmdline, error = server.runCommand(["getCmdLineAction"])
+            params.updateFromServer(server)
+            cmdline = params.parseActions()
             if not cmdline:
                 print("Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.")
-                return
-            elif error:
-                print("Error getting bitbake commandline: %s" % error)
-                return
+                return 1
+            if 'msg' in cmdline and cmdline['msg']:
+                logger.error(cmdline['msg'])
+                return 1
+            cmdline = cmdline['action']
             ret, error = server.runCommand(cmdline)
             if error:
                 print("Error running command '%s': %s" % (cmdline, error))




