Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id C63AD6FF56
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Apr 2016 10:37:39 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga103.jf.intel.com with ESMTP; 25 Apr 2016 03:37:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,532,1455004800"; d="scan'208";a="962137161"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 25 Apr 2016 03:37:19 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 8D94E6A4006;
	Mon, 25 Apr 2016 04:24:55 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 25 Apr 2016 11:16:29 +0300
Message-Id: <1461572190-17421-3-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1461572190-17421-1-git-send-email-ed.bartosh@linux.intel.com>
References: <1461572190-17421-1-git-send-email-ed.bartosh@linux.intel.com>
Subject: [PATCH 3/4] bitake: main: fix line-too-long pytling warnings
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
X-List-Received-Date: Mon, 25 Apr 2016 10:37:40 -0000

Wrapped long lines to fix "Line too long" pylint warnings.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/main.py | 121 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 82 insertions(+), 39 deletions(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index 3978a1b..60c7da3 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -103,8 +103,9 @@ def import_extension_module(pkg, modulename, checkattr):
         module = __import__(pkg.__name__, fromlist=[modulename])
         return getattr(module, modulename)
     except AttributeError:
-        raise BBMainException('FATAL: Unable to import extension module "%s" from %s. Valid extension modules: %s' % (modulename, pkg.__name__, present_options(list_extension_modules(pkg, checkattr))))
-
+        modules = present_options(list_extension_modules(pkg, checkattr))
+        raise BBMainException('FATAL: Unable to import extension module "%s" from %s. '
+                              'Valid extension modules: %s' % (modulename, pkg.__name__, modules))
 
 # Display bitbake/OE warnings via the BitBake.Warnings logger, ignoring others"""
 warnlog = logging.getLogger("BitBake.Warnings")
@@ -138,21 +139,32 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
     will provide the layer, BBFILES and other configuration information.""")
 
         parser.add_option("-b", "--buildfile", action="store", dest="buildfile", default=None,
-                          help="Execute tasks from a specific .bb recipe directly. WARNING: Does not handle any dependencies from other recipes.")
+                          help="Execute tasks from a specific .bb recipe directly. WARNING: Does "
+                               "not handle any dependencies from other recipes.")
+
         parser.add_option("-k", "--continue", action="store_false", dest="abort", default=True,
-                          help="Continue as much as possible after an error. While the target that failed and anything depending on it cannot be built, as much as possible will be built before stopping.")
+                          help="Continue as much as possible after an error. While the target that "
+                               "failed and anything depending on it cannot be built, as much as "
+                               "possible will be built before stopping.")
 
-        parser.add_option("-a", "--tryaltconfigs", action="store_true", dest="tryaltconfigs", default=False,
-                          help="Continue with builds by trying to use alternative providers where possible.")
+        parser.add_option("-a", "--tryaltconfigs", action="store_true",
+                          dest="tryaltconfigs", default=False,
+                          help="Continue with builds by trying to use alternative providers "
+                               "where possible.")
 
         parser.add_option("-f", "--force", action="store_true", dest="force", default=False,
-                          help="Force the specified targets/task to run (invalidating any existing stamp file).")
+                          help="Force the specified targets/task to run (invalidating any "
+                               "existing stamp file).")
 
         parser.add_option("-c", "--cmd", action="store", dest="cmd",
-                          help="Specify the task to execute. The exact options available depend on the metadata. Some examples might be 'compile' or 'populate_sysroot' or 'listtasks' may give a list of the tasks available.")
+                          help="Specify the task to execute. The exact options available "
+                               "depend on the metadata. Some examples might be 'compile'"
+                               " or 'populate_sysroot' or 'listtasks' may give a list of "
+                               "the tasks available.")
 
         parser.add_option("-C", "--clear-stamp", action="store", dest="invalidate_stamp",
-                          help="Invalidate the stamp for the specified task such as 'compile' and then run the default task for the specified target(s).")
+                          help="Invalidate the stamp for the specified task such as 'compile' "
+                               "and then run the default task for the specified target(s).")
 
         parser.add_option("-r", "--read", action="append", dest="prefile", default=[],
                           help="Read the specified file before bitbake.conf.")
@@ -171,31 +183,44 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
 
         parser.add_option("-S", "--dump-signatures", action="append", dest="dump_signatures",
                           default=[], metavar="SIGNATURE_HANDLER",
-                          help="Dump out the signature construction information, with no task execution. The SIGNATURE_HANDLER parameter is passed to the handler. Two common values are none and printdiff but the handler may define more/less. none means only dump the signature, printdiff means compare the dumped signature with the cached one.")
-
-        parser.add_option("-p", "--parse-only", action="store_true", dest="parse_only", default=False,
+                          help="Dump out the signature construction information, with no task "
+                               "execution. The SIGNATURE_HANDLER parameter is passed to the "
+                               "handler. Two common values are none and printdiff but the handler "
+                               "may define more/less. none means only dump the signature, printdiff"
+                               " means compare the dumped signature with the cached one.")
+
+        parser.add_option("-p", "--parse-only", action="store_true",
+                          dest="parse_only", default=False,
                           help="Quit after parsing the BB recipes.")
 
-        parser.add_option("-s", "--show-versions", action="store_true", dest="show_versions", default=False,
+        parser.add_option("-s", "--show-versions", action="store_true",
+                          dest="show_versions", default=False,
                           help="Show current and preferred versions of all recipes.")
 
-        parser.add_option("-e", "--environment", action="store_true", dest="show_environment", default=False,
-                          help="Show the global or per-recipe environment complete with information about where variables were set/changed.")
+        parser.add_option("-e", "--environment", action="store_true",
+                          dest="show_environment", default=False,
+                          help="Show the global or per-recipe environment complete with information"
+                               " about where variables were set/changed.")
 
         parser.add_option("-g", "--graphviz", action="store_true", dest="dot_graph", default=False,
-                          help="Save dependency tree information for the specified targets in the dot syntax.")
+                          help="Save dependency tree information for the specified "
+                               "targets in the dot syntax.")
 
-        parser.add_option("-I", "--ignore-deps", action="append", dest="extra_assume_provided", default=[],
-                          help="""Assume these dependencies don't exist and are already provided (equivalent to ASSUME_PROVIDED). Useful to make dependency graphs more appealing""")
+        parser.add_option("-I", "--ignore-deps", action="append",
+                          dest="extra_assume_provided", default=[],
+                          help="Assume these dependencies don't exist and are already provided "
+                               "(equivalent to ASSUME_PROVIDED). Useful to make dependency "
+                               "graphs more appealing")
 
         parser.add_option("-l", "--log-domains", action="append", dest="debug_domains", default=[],
-                          help="""Show debug logging for the specified logging domains""")
+                          help="Show debug logging for the specified logging domains")
 
         parser.add_option("-P", "--profile", action="store_true", dest="profile", default=False,
                           help="Profile the command and save reports.")
 
         # @CHOICES@ is substituted out by BitbakeHelpFormatter above
-        parser.add_option("-u", "--ui", action="store", dest="ui", default=os.environ.get('BITBAKE_UI', 'knotty'),
+        parser.add_option("-u", "--ui", action="store", dest="ui",
+                          default=os.environ.get('BITBAKE_UI', 'knotty'),
                           help="The user interface to use (@CHOICES@ - default %default).")
 
         # @CHOICES@ is substituted out by BitbakeHelpFormatter above
@@ -203,40 +228,53 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
                           default=["process", "xmlrpc"]["BBSERVER" in os.environ],
                           help="Choose which server type to use (@CHOICES@ - default %default).")
 
-        parser.add_option("", "--token", action="store", dest="xmlrpctoken", default=os.environ.get("BBTOKEN"),
-                          help="Specify the connection token to be used when connecting to a remote server.")
+        parser.add_option("", "--token", action="store", dest="xmlrpctoken",
+                          default=os.environ.get("BBTOKEN"),
+                          help="Specify the connection token to be used when connecting "
+                               "to a remote server.")
 
-        parser.add_option("", "--revisions-changed", action="store_true", dest="revisions_changed", default=False,
-                          help="Set the exit code depending on whether upstream floating revisions have changed or not.")
+        parser.add_option("", "--revisions-changed", action="store_true",
+                          dest="revisions_changed", default=False,
+                          help="Set the exit code depending on whether upstream floating "
+                               "revisions have changed or not.")
 
-        parser.add_option("", "--server-only", action="store_true", dest="server_only", default=False,
-                          help="Run bitbake without a UI, only starting a server (cooker) process.")
+        parser.add_option("", "--server-only", action="store_true",
+                          dest="server_only", default=False,
+                          help="Run bitbake without a UI, only starting a server "
+                               "(cooker) process.")
 
         parser.add_option("-B", "--bind", action="store", dest="bind", default=False,
                           help="The name/address for the bitbake server to bind to.")
 
-        parser.add_option("", "--no-setscene", action="store_true", dest="nosetscene", default=False,
-                          help="Do not run any setscene tasks. sstate will be ignored and everything needed, built.")
+        parser.add_option("", "--no-setscene", action="store_true",
+                          dest="nosetscene", default=False,
+                          help="Do not run any setscene tasks. sstate will be ignored and "
+                               "everything needed, built.")
 
-        parser.add_option("", "--setscene-only", action="store_true", dest="setsceneonly", default=False,
+        parser.add_option("", "--setscene-only", action="store_true",
+                          dest="setsceneonly", default=False,
                           help="Only run setscene tasks, don't run any real tasks.")
 
         parser.add_option("", "--remote-server", action="store", dest="remote_server",
                           default=os.environ.get("BBSERVER"),
                           help="Connect to the specified server.")
 
-        parser.add_option("-m", "--kill-server", action="store_true", dest="kill_server", default=False,
+        parser.add_option("-m", "--kill-server", action="store_true",
+                          dest="kill_server", default=False,
                           help="Terminate the remote server.")
 
-        parser.add_option("", "--observe-only", action="store_true", dest="observe_only", default=False,
+        parser.add_option("", "--observe-only", action="store_true",
+                          dest="observe_only", default=False,
                           help="Connect to a server as an observing-only client.")
 
-        parser.add_option("", "--status-only", action="store_true", dest="status_only", default=False,
+        parser.add_option("", "--status-only", action="store_true",
+                          dest="status_only", default=False,
                           help="Check the status of the remote bitbake server.")
 
         parser.add_option("-w", "--write-log", action="store", dest="writeeventlog",
                           default=os.environ.get("BBEVENTLOG"),
-                          help="Writes the event log of the build to a bitbake event json file. Use '' (empty string) to assign the name automatically.")
+                          help="Writes the event log of the build to a bitbake event json file. "
+                               "Use '' (empty string) to assign the name automatically.")
 
         options, targets = parser.parse_args(argv)
 
@@ -249,8 +287,9 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
 
         # fill in proper log name if not supplied
         if options.writeeventlog is not None and len(options.writeeventlog) == 0:
-            import datetime
-            options.writeeventlog = "bitbake_eventlog_%s.json" % datetime.datetime.now().strftime("%Y%m%d%H%M%S")
+            from datetime import datetime
+            eventlog = "bitbake_eventlog_%s.json" % datetime.now().strftime("%Y%m%d%H%M%S")
+            options.writeeventlog = eventlog
 
         # if BBSERVER says to autodetect, let's do that
         if options.remote_server:
@@ -360,7 +399,8 @@ def bitbake_main(configParams, configuration):
                               "connecting to a server.\n")
 
     if configParams.kill_server and not configParams.remote_server:
-        raise BBMainException("FATAL: '--kill-server' can only be used to terminate a remote server")
+        raise BBMainException("FATAL: '--kill-server' can only be used to "
+                              "terminate a remote server")
 
     if "BBDEBUG" in os.environ:
         level = int(os.environ["BBDEBUG"])
@@ -397,7 +437,8 @@ def bitbake_main(configParams, configuration):
         bb.event.ui_queue = []
     else:
         # we start a stub server that is actually a XMLRPClient that connects to a real server
-        server = servermodule.BitBakeXMLRPCClient(configParams.observe_only, configParams.xmlrpctoken)
+        server = servermodule.BitBakeXMLRPCClient(configParams.observe_only,
+                                                  configParams.xmlrpctoken)
         server.saveConnectionDetails(configParams.remote_server)
 
 
@@ -426,12 +467,14 @@ def bitbake_main(configParams, configuration):
             return 0
 
         try:
-            return ui_module.main(server_connection.connection, server_connection.events, configParams)
+            return ui_module.main(server_connection.connection, server_connection.events,
+                                  configParams)
         finally:
             bb.event.ui_queue = []
             server_connection.terminate()
     else:
-        print("Bitbake server address: %s, server port: %s" % (server.serverImpl.host, server.serverImpl.port))
+        print("Bitbake server address: %s, server port: %s" % (server.serverImpl.host,
+                                                               server.serverImpl.port))
         return 0
 
     return 1
-- 
2.1.4


