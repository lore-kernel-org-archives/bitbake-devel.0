Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id E8502608C5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 May 2013 21:54:51 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4KLwBZF025723; Mon, 20 May 2013 22:58:12 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id dVGsfm33B-9Y; Mon, 20 May 2013 22:58:11 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4KLw75h025719
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 20 May 2013 22:58:08 +0100
Message-ID: <1369086870.4326.6.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 May 2013 22:54:30 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: "Damian, Alexandru" <alexandru.damian@intel.com>
Subject: [PATCH] bitbake: Create cookerdata splitting config from cooker and bin/bitbake
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
X-List-Received-Date: Mon, 20 May 2013 21:54:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit


Currently the UI and server configuration is one big incestuous mess. To
start to untangle this we creater cookerdata, a new module which contains
various confiuration modules and the code for building the base datastore.

To start with we add a ConfigParameters() class which contains information
about both the commandline configuration and the original environment.

The CookerConfiguration class is created to contain the cooker.configuration
options. This means we can transfer new paramters to the server over something
like XMLRPC and then build a new configuration from these on the server.

Based on a patch from Alexandru Damian <alexandru.damian@intel.com>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 0ca82e5..519ecd9 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -39,6 +39,7 @@ import bb.msg
 from bb import cooker
 from bb import ui
 from bb import server
+from bb import cookerdata
 
 __version__ = "1.19.0"
 logger = logging.getLogger("BitBake")
@@ -56,16 +57,6 @@ try:
 except:
     pass
 
-class BBConfiguration(object):
-    """
-    Manages build options and configurations for one run
-    """
-
-    def __init__(self, options):
-        for key, val in options.__dict__.items():
-            setattr(self, key, val)
-        self.pkgs_to_build = []
-
 
 def get_ui(config):
     if not config.ui:
@@ -104,94 +95,99 @@ warnings.filterwarnings("ignore", category=ImportWarning)
 warnings.filterwarnings("ignore", category=DeprecationWarning, module="<string>$")
 warnings.filterwarnings("ignore", message="With-statements now directly support multiple context managers")
 
+class BitBakeConfigParameters(cookerdata.ConfigParameters):
 
-def main():
-    parser = optparse.OptionParser(
-        version = "BitBake Build Tool Core version %s, %%prog version %s" % (bb.__version__, __version__),
-        usage = """%prog [options] [package ...]
+    def parseCommandLine(self):
+        parser = optparse.OptionParser(
+            version = "BitBake Build Tool Core version %s, %%prog version %s" % (bb.__version__, __version__),
+            usage = """%prog [options] [package ...]
 
-Executes the specified task (default is 'build') for a given set of BitBake files.
-It expects that BBFILES is defined, which is a space separated list of files to
-be executed.  BBFILES does support wildcards.
-Default BBFILES are the .bb files in the current directory.""")
+    Executes the specified task (default is 'build') for a given set of BitBake files.
+    It expects that BBFILES is defined, which is a space separated list of files to
+    be executed.  BBFILES does support wildcards.
+    Default BBFILES are the .bb files in the current directory.""")
 
-    parser.add_option("-b", "--buildfile", help = "execute the task against this .bb file, rather than a package from BBFILES. Does not handle any dependencies.",
-               action = "store", dest = "buildfile", default = None)
+        parser.add_option("-b", "--buildfile", help = "execute the task against this .bb file, rather than a package from BBFILES. Does not handle any dependencies.",
+                   action = "store", dest = "buildfile", default = None)
 
-    parser.add_option("-k", "--continue", help = "continue as much as possible after an error. While the target that failed, and those that depend on it, cannot be remade, the other dependencies of these targets can be processed all the same.",
-               action = "store_false", dest = "abort", default = True)
+        parser.add_option("-k", "--continue", help = "continue as much as possible after an error. While the target that failed, and those that depend on it, cannot be remade, the other dependencies of these targets can be processed all the same.",
+                   action = "store_false", dest = "abort", default = True)
 
-    parser.add_option("-a", "--tryaltconfigs", help = "continue with builds by trying to use alternative providers where possible.",
-               action = "store_true", dest = "tryaltconfigs", default = False)
+        parser.add_option("-a", "--tryaltconfigs", help = "continue with builds by trying to use alternative providers where possible.",
+                   action = "store_true", dest = "tryaltconfigs", default = False)
 
-    parser.add_option("-f", "--force", help = "force run of specified cmd, regardless of stamp status",
-               action = "store_true", dest = "force", default = False)
+        parser.add_option("-f", "--force", help = "force run of specified cmd, regardless of stamp status",
+                   action = "store_true", dest = "force", default = False)
 
-    parser.add_option("-c", "--cmd", help = "Specify task to execute. Note that this only executes the specified task for the providee and the packages it depends on, i.e. 'compile' does not implicitly call stage for the dependencies (IOW: use only if you know what you are doing). Depending on the base.bbclass a listtasks tasks is defined and will show available tasks",
-               action = "store", dest = "cmd")
+        parser.add_option("-c", "--cmd", help = "Specify task to execute. Note that this only executes the specified task for the providee and the packages it depends on, i.e. 'compile' does not implicitly call stage for the dependencies (IOW: use only if you know what you are doing). Depending on the base.bbclass a listtasks tasks is defined and will show available tasks",
+                   action = "store", dest = "cmd")
 
-    parser.add_option("-C", "--clear-stamp", help = "Invalidate the stamp for the specified cmd such as 'compile' and run the default task for the specified target(s)",
-                action = "store", dest = "invalidate_stamp")
+        parser.add_option("-C", "--clear-stamp", help = "Invalidate the stamp for the specified cmd such as 'compile' and run the default task for the specified target(s)",
+                    action = "store", dest = "invalidate_stamp")
 
-    parser.add_option("-r", "--read", help = "read the specified file before bitbake.conf",
-               action = "append", dest = "prefile", default = [])
+        parser.add_option("-r", "--read", help = "read the specified file before bitbake.conf",
+                   action = "append", dest = "prefile", default = [])
 
-    parser.add_option("-R", "--postread", help = "read the specified file after bitbake.conf",
-                      action = "append", dest = "postfile", default = [])
+        parser.add_option("-R", "--postread", help = "read the specified file after bitbake.conf",
+                          action = "append", dest = "postfile", default = [])
 
-    parser.add_option("-v", "--verbose", help = "output more chit-chat to the terminal",
-               action = "store_true", dest = "verbose", default = False)
+        parser.add_option("-v", "--verbose", help = "output more chit-chat to the terminal",
+                   action = "store_true", dest = "verbose", default = False)
 
-    parser.add_option("-D", "--debug", help = "Increase the debug level. You can specify this more than once.",
-               action = "count", dest="debug", default = 0)
+        parser.add_option("-D", "--debug", help = "Increase the debug level. You can specify this more than once.",
+                   action = "count", dest="debug", default = 0)
 
-    parser.add_option("-n", "--dry-run", help = "don't execute, just go through the motions",
-               action = "store_true", dest = "dry_run", default = False)
+        parser.add_option("-n", "--dry-run", help = "don't execute, just go through the motions",
+                   action = "store_true", dest = "dry_run", default = False)
 
-    parser.add_option("-S", "--dump-signatures", help = "don't execute, just dump out the signature construction information",
-               action = "store_true", dest = "dump_signatures", default = False)
+        parser.add_option("-S", "--dump-signatures", help = "don't execute, just dump out the signature construction information",
+                   action = "store_true", dest = "dump_signatures", default = False)
 
-    parser.add_option("-p", "--parse-only", help = "quit after parsing the BB files (developers only)",
-               action = "store_true", dest = "parse_only", default = False)
+        parser.add_option("-p", "--parse-only", help = "quit after parsing the BB files (developers only)",
+                   action = "store_true", dest = "parse_only", default = False)
 
-    parser.add_option("-s", "--show-versions", help = "show current and preferred versions of all recipes",
-               action = "store_true", dest = "show_versions", default = False)
+        parser.add_option("-s", "--show-versions", help = "show current and preferred versions of all recipes",
+                   action = "store_true", dest = "show_versions", default = False)
 
-    parser.add_option("-e", "--environment", help = "show the global or per-package environment (this is what used to be bbread)",
-               action = "store_true", dest = "show_environment", default = False)
+        parser.add_option("-e", "--environment", help = "show the global or per-package environment (this is what used to be bbread)",
+                   action = "store_true", dest = "show_environment", default = False)
 
-    parser.add_option("-g", "--graphviz", help = "emit the dependency trees of the specified packages in the dot syntax, and the pn-buildlist to show the build list",
-                action = "store_true", dest = "dot_graph", default = False)
+        parser.add_option("-g", "--graphviz", help = "emit the dependency trees of the specified packages in the dot syntax, and the pn-buildlist to show the build list",
+                    action = "store_true", dest = "dot_graph", default = False)
 
-    parser.add_option("-I", "--ignore-deps", help = """Assume these dependencies don't exist and are already provided (equivalent to ASSUME_PROVIDED). Useful to make dependency graphs more appealing""",
-                action = "append", dest = "extra_assume_provided", default = [])
+        parser.add_option("-I", "--ignore-deps", help = """Assume these dependencies don't exist and are already provided (equivalent to ASSUME_PROVIDED). Useful to make dependency graphs more appealing""",
+                    action = "append", dest = "extra_assume_provided", default = [])
 
-    parser.add_option("-l", "--log-domains", help = """Show debug logging for the specified logging domains""",
-                action = "append", dest = "debug_domains", default = [])
+        parser.add_option("-l", "--log-domains", help = """Show debug logging for the specified logging domains""",
+                    action = "append", dest = "debug_domains", default = [])
 
-    parser.add_option("-P", "--profile", help = "profile the command and print a report",
-               action = "store_true", dest = "profile", default = False)
+        parser.add_option("-P", "--profile", help = "profile the command and print a report",
+                   action = "store_true", dest = "profile", default = False)
 
-    parser.add_option("-u", "--ui", help = "userinterface to use",
-               action = "store", dest = "ui")
+        parser.add_option("-u", "--ui", help = "userinterface to use",
+                   action = "store", dest = "ui")
 
-    parser.add_option("-t", "--servertype", help = "Choose which server to use, none, process or xmlrpc",
-               action = "store", dest = "servertype")
+        parser.add_option("-t", "--servertype", help = "Choose which server to use, none, process or xmlrpc",
+                   action = "store", dest = "servertype")
 
-    parser.add_option("", "--revisions-changed", help = "Set the exit code depending on whether upstream floating revisions have changed or not",
-               action = "store_true", dest = "revisions_changed", default = False)
+        parser.add_option("", "--revisions-changed", help = "Set the exit code depending on whether upstream floating revisions have changed or not",
+                   action = "store_true", dest = "revisions_changed", default = False)
 
-    parser.add_option("", "--server-only", help = "Run bitbake without UI,  the frontend can connect with bitbake server itself",
-               action = "store_true", dest = "server_only", default = False)
+        parser.add_option("", "--server-only", help = "Run bitbake without UI,  the frontend can connect with bitbake server itself",
+                   action = "store_true", dest = "server_only", default = False)
 
-    parser.add_option("-B", "--bind", help = "The name/address for the bitbake server to bind to",
-               action = "store", dest = "bind", default = False)
-    parser.add_option("", "--no-setscene", help = "Do not run any setscene tasks, forces builds",
-               action = "store_true", dest = "nosetscene", default = False)
-    options, args = parser.parse_args(sys.argv)
+        parser.add_option("-B", "--bind", help = "The name/address for the bitbake server to bind to",
+                   action = "store", dest = "bind", default = False)
+        parser.add_option("", "--no-setscene", help = "Do not run any setscene tasks, forces builds",
+                   action = "store_true", dest = "nosetscene", default = False)
+        options, targets = parser.parse_args(sys.argv)
+        return options, targets[1:]
 
-    configuration = BBConfiguration(options)
-    configuration.pkgs_to_build.extend(args[1:])
+def main():
+
+    configParams = BitBakeConfigParameters()
+    configuration = cookerdata.CookerConfiguration()
+    configuration.setConfigParameters(configParams)
 
     ui_main = get_ui(configuration)
 
@@ -230,9 +226,6 @@ Default BBFILES are the .bb files in the current directory.""")
     handler = bb.event.LogHandler()
     logger.addHandler(handler)
 
-    # Before we start modifying the environment we should take a pristine
-    # copy for possible later use
-    initialenv = os.environ.copy()
     # Clear away any spurious environment variables while we stoke up the cooker
     cleanedvars = bb.utils.clean_environment()
 
@@ -242,10 +235,9 @@ Default BBFILES are the .bb files in the current directory.""")
     else:
         server.initServer()
 
-    idle = server.getServerIdleCB()
-
     try:
-        cooker = bb.cooker.BBCooker(configuration, idle, initialenv)
+        configuration.setServerRegIdleCallback(server.getServerIdleCB())
+        cooker = bb.cooker.BBCooker(configuration)
         cooker.parseCommandLine()
 
         server.addcooker(cooker)
diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 3abdd0c..8577df6 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -78,7 +78,7 @@ class Command:
         if command not in CommandsAsync.__dict__:
             return None, "No such command"
         self.currentAsyncCommand = (command, commandline)
-        self.cooker.server_registration_cb(self.cooker.runCommands, self.cooker)
+        self.cooker.configuration.server_register_idlecallback(self.cooker.runCommands, self.cooker)
         return True, None
 
     def runAsyncCommand(self):
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index affe113..1a2c016 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -87,12 +87,10 @@ class BBCooker:
     Manages one bitbake build run
     """
 
-    def __init__(self, configuration, server_registration_cb, savedenv={}):
+    def __init__(self, configuration):
         self.recipecache = None
         self.skiplist = {}
 
-        self.server_registration_cb = server_registration_cb
-
         self.configuration = configuration
 
         # Keep a datastore of the initial environment variables and their
@@ -100,6 +98,7 @@ class BBCooker:
         # to use environment variables which have been cleaned from the
         # BitBake processes env
         self.savedenv = bb.data.init()
+        savedenv = configuration.params.environment
         for k in savedenv:
             self.savedenv.setVar(k, savedenv[k])
 
@@ -179,7 +178,7 @@ class BBCooker:
         if self.configuration.show_environment:
             self.configuration.data.enableTracking()
 
-        if not self.server_registration_cb:
+        if not self.configuration.server_register_idlecallback:
             self.configuration.data.setVar("BB_WORKERCONTEXT", "1")
 
         filtered_keys = bb.utils.approved_variables()
@@ -1188,7 +1187,7 @@ class BBCooker:
                 return True
             return retval
 
-        self.server_registration_cb(buildFileIdle, rq)
+        self.configuration.server_register_idlecallback(buildFileIdle, rq)
 
     def buildTargets(self, targets, task):
         """
@@ -1246,7 +1245,7 @@ class BBCooker:
         if universe:
             rq.rqdata.warn_multi_bb = True
 
-        self.server_registration_cb(buildTargetsIdle, rq)
+        self.configuration.server_register_idlecallback(buildTargetsIdle, rq)
 
     def generateNewImage(self, image, base_image, package_queue):
         '''
diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
new file mode 100644
index 0000000..2c3275a
--- /dev/null
+++ b/bitbake/lib/bb/cookerdata.py
@@ -0,0 +1,73 @@
+#!/usr/bin/env python
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# Copyright (C) 2003, 2004  Chris Larson
+# Copyright (C) 2003, 2004  Phil Blundell
+# Copyright (C) 2003 - 2005 Michael 'Mickey' Lauer
+# Copyright (C) 2005        Holger Hans Peter Freyther
+# Copyright (C) 2005        ROAD GmbH
+# Copyright (C) 2006        Richard Purdie
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import os, sys
+from functools import wraps
+import logging
+from bb import data
+
+logger      = logging.getLogger("BitBake")
+parselog    = logging.getLogger("BitBake.Parsing")
+
+class ConfigParameters(object):
+    def __init__(self):
+        self.options, targets = self.parseCommandLine()
+        self.environment = self.parseEnvironment()
+
+        self.options.pkgs_to_build = targets or []
+
+        self.options.tracking = False
+        if self.options.show_environment:
+            self.options.tracking = True
+
+        for key, val in self.options.__dict__.items():
+            setattr(self, key, val)
+
+    def parseCommandLine(self):
+        raise Exception("Caller must implement commandline option parsing")
+
+    def parseEnvironment(self):
+        return os.environ.copy()
+
+class CookerConfiguration(object):
+    """
+    Manages build options and configurations for one run
+    """
+
+    def __init__(self):
+        self.debug_domains = []
+        self.extra_assume_provided = []
+        self.prefile = []
+        self.postfile = []
+        self.debug = 0
+        self.pkgs_to_build = []
+
+    def setConfigParameters(self, parameters):
+        self.params = parameters
+        for key, val in parameters.options.__dict__.items():
+            setattr(self, key, val)
+
+    def setServerRegIdleCallback(self, srcb):
+        self.server_register_idlecallback = srcb
+




