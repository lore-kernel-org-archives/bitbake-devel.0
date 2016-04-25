Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 628696FF56
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Apr 2016 10:37:06 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 25 Apr 2016 03:37:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,532,1455004800"; d="scan'208";a="962136865"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 25 Apr 2016 03:36:20 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id E18B16A4006;
	Mon, 25 Apr 2016 04:23:56 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 25 Apr 2016 11:16:27 +0300
Message-Id: <1461572190-17421-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 1/4] bitbake: main: fix bad-witespace pylint warnings
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
X-List-Received-Date: Mon, 25 Apr 2016 10:37:08 -0000

Fixed pylint warnings:
 No space allowed around keyword argument assignment
 No space allowed after bracket
 No space allowed before bracket

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/main.py | 138 ++++++++++++++++++++++++-------------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index b843b7d..c1f14be 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -100,7 +100,7 @@ def import_extension_module(pkg, modulename, checkattr):
         # Dynamically load the UI based on the ui name. Although we
         # suggest a fixed set this allows you to have flexibility in which
         # ones are available.
-        module = __import__(pkg.__name__, fromlist = [modulename])
+        module = __import__(pkg.__name__, fromlist=[modulename])
         return getattr(module, modulename)
     except AttributeError:
         raise BBMainException('FATAL: Unable to import extension module "%s" from %s. Valid extension modules: %s' % (modulename, pkg.__name__, present_options(list_extension_modules(pkg, checkattr))))
@@ -129,111 +129,111 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
 
     def parseCommandLine(self, argv=sys.argv):
         parser = optparse.OptionParser(
-            formatter = BitbakeHelpFormatter(),
-            version = "BitBake Build Tool Core version %s" % bb.__version__,
-            usage = """%prog [options] [recipename/target recipe:do_task ...]
+            formatter=BitbakeHelpFormatter(),
+            version="BitBake Build Tool Core version %s" % bb.__version__,
+            usage="""%prog [options] [recipename/target recipe:do_task ...]
 
     Executes the specified task (default is 'build') for a given set of target recipes (.bb files).
     It is assumed there is a conf/bblayers.conf available in cwd or in BBPATH which
     will provide the layer, BBFILES and other configuration information.""")
 
-        parser.add_option("-b", "--buildfile", help = "Execute tasks from a specific .bb recipe directly. WARNING: Does not handle any dependencies from other recipes.",
-                   action = "store", dest = "buildfile", default = None)
+        parser.add_option("-b", "--buildfile", help="Execute tasks from a specific .bb recipe directly. WARNING: Does not handle any dependencies from other recipes.",
+                   action="store", dest="buildfile", default=None)
 
-        parser.add_option("-k", "--continue", help = "Continue as much as possible after an error. While the target that failed and anything depending on it cannot be built, as much as possible will be built before stopping.",
-                   action = "store_false", dest = "abort", default = True)
+        parser.add_option("-k", "--continue", help="Continue as much as possible after an error. While the target that failed and anything depending on it cannot be built, as much as possible will be built before stopping.",
+                   action="store_false", dest="abort", default=True)
 
-        parser.add_option("-a", "--tryaltconfigs", help = "Continue with builds by trying to use alternative providers where possible.",
-                   action = "store_true", dest = "tryaltconfigs", default = False)
+        parser.add_option("-a", "--tryaltconfigs", help="Continue with builds by trying to use alternative providers where possible.",
+                   action="store_true", dest="tryaltconfigs", default=False)
 
-        parser.add_option("-f", "--force", help = "Force the specified targets/task to run (invalidating any existing stamp file).",
-                   action = "store_true", dest = "force", default = False)
+        parser.add_option("-f", "--force", help="Force the specified targets/task to run (invalidating any existing stamp file).",
+                   action="store_true", dest="force", default=False)
 
-        parser.add_option("-c", "--cmd", help = "Specify the task to execute. The exact options available depend on the metadata. Some examples might be 'compile' or 'populate_sysroot' or 'listtasks' may give a list of the tasks available.",
-                   action = "store", dest = "cmd")
+        parser.add_option("-c", "--cmd", help="Specify the task to execute. The exact options available depend on the metadata. Some examples might be 'compile' or 'populate_sysroot' or 'listtasks' may give a list of the tasks available.",
+                   action="store", dest="cmd")
 
-        parser.add_option("-C", "--clear-stamp", help = "Invalidate the stamp for the specified task such as 'compile' and then run the default task for the specified target(s).",
-                    action = "store", dest = "invalidate_stamp")
+        parser.add_option("-C", "--clear-stamp", help="Invalidate the stamp for the specified task such as 'compile' and then run the default task for the specified target(s).",
+                    action="store", dest="invalidate_stamp")
 
-        parser.add_option("-r", "--read", help = "Read the specified file before bitbake.conf.",
-                   action = "append", dest = "prefile", default = [])
+        parser.add_option("-r", "--read", help="Read the specified file before bitbake.conf.",
+                   action="append", dest="prefile", default=[])
 
-        parser.add_option("-R", "--postread", help = "Read the specified file after bitbake.conf.",
-                          action = "append", dest = "postfile", default = [])
+        parser.add_option("-R", "--postread", help="Read the specified file after bitbake.conf.",
+                          action="append", dest="postfile", default=[])
 
-        parser.add_option("-v", "--verbose", help = "Output more log message data to the terminal.",
-                   action = "store_true", dest = "verbose", default = False)
+        parser.add_option("-v", "--verbose", help="Output more log message data to the terminal.",
+                   action="store_true", dest="verbose", default=False)
 
-        parser.add_option("-D", "--debug", help = "Increase the debug level. You can specify this more than once.",
-                   action = "count", dest="debug", default = 0)
+        parser.add_option("-D", "--debug", help="Increase the debug level. You can specify this more than once.",
+                   action="count", dest="debug", default=0)
 
-        parser.add_option("-n", "--dry-run", help = "Don't execute, just go through the motions.",
-                   action = "store_true", dest = "dry_run", default = False)
+        parser.add_option("-n", "--dry-run", help="Don't execute, just go through the motions.",
+                   action="store_true", dest="dry_run", default=False)
 
-        parser.add_option("-S", "--dump-signatures", help = "Dump out the signature construction information, with no task execution. The SIGNATURE_HANDLER parameter is passed to the handler. Two common values are none and printdiff but the handler may define more/less. none means only dump the signature, printdiff means compare the dumped signature with the cached one.",
-                   action = "append", dest = "dump_signatures", default = [], metavar="SIGNATURE_HANDLER")
+        parser.add_option("-S", "--dump-signatures", help="Dump out the signature construction information, with no task execution. The SIGNATURE_HANDLER parameter is passed to the handler. Two common values are none and printdiff but the handler may define more/less. none means only dump the signature, printdiff means compare the dumped signature with the cached one.",
+                   action="append", dest="dump_signatures", default=[], metavar="SIGNATURE_HANDLER")
 
-        parser.add_option("-p", "--parse-only", help = "Quit after parsing the BB recipes.",
-                   action = "store_true", dest = "parse_only", default = False)
+        parser.add_option("-p", "--parse-only", help="Quit after parsing the BB recipes.",
+                   action="store_true", dest="parse_only", default=False)
 
-        parser.add_option("-s", "--show-versions", help = "Show current and preferred versions of all recipes.",
-                   action = "store_true", dest = "show_versions", default = False)
+        parser.add_option("-s", "--show-versions", help="Show current and preferred versions of all recipes.",
+                   action="store_true", dest="show_versions", default=False)
 
-        parser.add_option("-e", "--environment", help = "Show the global or per-recipe environment complete with information about where variables were set/changed.",
-                   action = "store_true", dest = "show_environment", default = False)
+        parser.add_option("-e", "--environment", help="Show the global or per-recipe environment complete with information about where variables were set/changed.",
+                   action="store_true", dest="show_environment", default=False)
 
-        parser.add_option("-g", "--graphviz", help = "Save dependency tree information for the specified targets in the dot syntax.",
-                    action = "store_true", dest = "dot_graph", default = False)
+        parser.add_option("-g", "--graphviz", help="Save dependency tree information for the specified targets in the dot syntax.",
+                    action="store_true", dest="dot_graph", default=False)
 
-        parser.add_option("-I", "--ignore-deps", help = """Assume these dependencies don't exist and are already provided (equivalent to ASSUME_PROVIDED). Useful to make dependency graphs more appealing""",
-                    action = "append", dest = "extra_assume_provided", default = [])
+        parser.add_option("-I", "--ignore-deps", help="""Assume these dependencies don't exist and are already provided (equivalent to ASSUME_PROVIDED). Useful to make dependency graphs more appealing""",
+                    action="append", dest="extra_assume_provided", default=[])
 
-        parser.add_option("-l", "--log-domains", help = """Show debug logging for the specified logging domains""",
-                    action = "append", dest = "debug_domains", default = [])
+        parser.add_option("-l", "--log-domains", help="""Show debug logging for the specified logging domains""",
+                    action="append", dest="debug_domains", default=[])
 
-        parser.add_option("-P", "--profile", help = "Profile the command and save reports.",
-                   action = "store_true", dest = "profile", default = False)
+        parser.add_option("-P", "--profile", help="Profile the command and save reports.",
+                   action="store_true", dest="profile", default=False)
 
         # @CHOICES@ is substituted out by BitbakeHelpFormatter above
-        parser.add_option("-u", "--ui", help = "The user interface to use (@CHOICES@ - default %default).",
+        parser.add_option("-u", "--ui", help="The user interface to use (@CHOICES@ - default %default).",
                    action="store", dest="ui", default=os.environ.get('BITBAKE_UI', 'knotty'))
 
         # @CHOICES@ is substituted out by BitbakeHelpFormatter above
-        parser.add_option("-t", "--servertype", help = "Choose which server type to use (@CHOICES@ - default %default).",
-                   action = "store", dest = "servertype", default = ["process", "xmlrpc"]["BBSERVER" in os.environ])
+        parser.add_option("-t", "--servertype", help="Choose which server type to use (@CHOICES@ - default %default).",
+                   action="store", dest="servertype", default=["process", "xmlrpc"]["BBSERVER" in os.environ])
 
-        parser.add_option("", "--token", help = "Specify the connection token to be used when connecting to a remote server.",
-                   action = "store", dest = "xmlrpctoken", default = os.environ.get("BBTOKEN"))
+        parser.add_option("", "--token", help="Specify the connection token to be used when connecting to a remote server.",
+                   action="store", dest="xmlrpctoken", default=os.environ.get("BBTOKEN"))
 
-        parser.add_option("", "--revisions-changed", help = "Set the exit code depending on whether upstream floating revisions have changed or not.",
-                   action = "store_true", dest = "revisions_changed", default = False)
+        parser.add_option("", "--revisions-changed", help="Set the exit code depending on whether upstream floating revisions have changed or not.",
+                   action="store_true", dest="revisions_changed", default=False)
 
-        parser.add_option("", "--server-only", help = "Run bitbake without a UI, only starting a server (cooker) process.",
-                   action = "store_true", dest = "server_only", default = False)
+        parser.add_option("", "--server-only", help="Run bitbake without a UI, only starting a server (cooker) process.",
+                   action="store_true", dest="server_only", default=False)
 
-        parser.add_option("-B", "--bind", help = "The name/address for the bitbake server to bind to.",
-                   action = "store", dest = "bind", default = False)
+        parser.add_option("-B", "--bind", help="The name/address for the bitbake server to bind to.",
+                   action="store", dest="bind", default=False)
 
-        parser.add_option("", "--no-setscene", help = "Do not run any setscene tasks. sstate will be ignored and everything needed, built.",
-                   action = "store_true", dest = "nosetscene", default = False)
+        parser.add_option("", "--no-setscene", help="Do not run any setscene tasks. sstate will be ignored and everything needed, built.",
+                   action="store_true", dest="nosetscene", default=False)
 
-        parser.add_option("", "--setscene-only", help = "Only run setscene tasks, don't run any real tasks.",
-                   action = "store_true", dest = "setsceneonly", default = False)
+        parser.add_option("", "--setscene-only", help="Only run setscene tasks, don't run any real tasks.",
+                   action="store_true", dest="setsceneonly", default=False)
 
-        parser.add_option("", "--remote-server", help = "Connect to the specified server.",
-                   action = "store", dest = "remote_server", default = os.environ.get("BBSERVER"))
+        parser.add_option("", "--remote-server", help="Connect to the specified server.",
+                   action="store", dest="remote_server", default=os.environ.get("BBSERVER"))
 
-        parser.add_option("-m", "--kill-server", help = "Terminate the remote server.",
-                    action = "store_true", dest = "kill_server", default = False)
+        parser.add_option("-m", "--kill-server", help="Terminate the remote server.",
+                    action="store_true", dest="kill_server", default=False)
 
-        parser.add_option("", "--observe-only", help = "Connect to a server as an observing-only client.",
-                   action = "store_true", dest = "observe_only", default = False)
+        parser.add_option("", "--observe-only", help="Connect to a server as an observing-only client.",
+                   action="store_true", dest="observe_only", default=False)
 
-        parser.add_option("", "--status-only", help = "Check the status of the remote bitbake server.",
-                   action = "store_true", dest = "status_only", default = False)
+        parser.add_option("", "--status-only", help="Check the status of the remote bitbake server.",
+                   action="store_true", dest="status_only", default=False)
 
-        parser.add_option("-w", "--write-log", help = "Writes the event log of the build to a bitbake event json file. Use '' (empty string) to assign the name automatically.",
-                   action = "store", dest = "writeeventlog", default = os.environ.get("BBEVENTLOG"))
+        parser.add_option("-w", "--write-log", help="Writes the event log of the build to a bitbake event json file. Use '' (empty string) to assign the name automatically.",
+                   action="store", dest="writeeventlog", default=os.environ.get("BBEVENTLOG"))
 
         options, targets = parser.parse_args(argv)
 
@@ -280,7 +280,7 @@ def start_server(servermodule, configParams, configuration, features):
     if configParams.bind:
         (host, port) = configParams.bind.split(':')
         server.initServer((host, int(port)), single_use)
-        configuration.interface = [ server.serverImpl.host, server.serverImpl.port ]
+        configuration.interface = [server.serverImpl.host, server.serverImpl.port]
     else:
         server.initServer(single_use=single_use)
         configuration.interface = []
@@ -342,7 +342,7 @@ def bitbake_main(configParams, configuration):
         if configParams.remote_server:
             raise BBMainException("FATAL: The '--server-only' option conflicts with %s.\n" %
                                   ("the BBSERVER environment variable" if "BBSERVER" in os.environ \
-                                   else "the '--remote-server' option" ))
+                                   else "the '--remote-server' option"))
 
     if configParams.bind and configParams.servertype != "xmlrpc":
         raise BBMainException("FATAL: If '-B' or '--bind' is defined, we must "
-- 
2.1.4


