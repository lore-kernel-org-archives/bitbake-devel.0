Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 860F5700FD
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Apr 2016 10:37:16 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga102.jf.intel.com with ESMTP; 25 Apr 2016 03:37:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,532,1455004800"; d="scan'208";a="91381353"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga004.fm.intel.com with ESMTP; 25 Apr 2016 03:37:17 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 4C8686A4006;
	Mon, 25 Apr 2016 04:24:53 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 25 Apr 2016 11:16:28 +0300
Message-Id: <1461572190-17421-2-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1461572190-17421-1-git-send-email-ed.bartosh@linux.intel.com>
References: <1461572190-17421-1-git-send-email-ed.bartosh@linux.intel.com>
Subject: [PATCH 2/4] bitbake: main: fix bad-continuation warnings
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
X-List-Received-Date: Mon, 25 Apr 2016 10:37:16 -0000

Fixed pylint warning 'Wrong continued indentation'.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/main.py | 135 +++++++++++++++++++++++++------------------------
 1 file changed, 69 insertions(+), 66 deletions(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index c1f14be..3978a1b 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -137,103 +137,106 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
     It is assumed there is a conf/bblayers.conf available in cwd or in BBPATH which
     will provide the layer, BBFILES and other configuration information.""")
 
-        parser.add_option("-b", "--buildfile", help="Execute tasks from a specific .bb recipe directly. WARNING: Does not handle any dependencies from other recipes.",
-                   action="store", dest="buildfile", default=None)
+        parser.add_option("-b", "--buildfile", action="store", dest="buildfile", default=None,
+                          help="Execute tasks from a specific .bb recipe directly. WARNING: Does not handle any dependencies from other recipes.")
+        parser.add_option("-k", "--continue", action="store_false", dest="abort", default=True,
+                          help="Continue as much as possible after an error. While the target that failed and anything depending on it cannot be built, as much as possible will be built before stopping.")
 
-        parser.add_option("-k", "--continue", help="Continue as much as possible after an error. While the target that failed and anything depending on it cannot be built, as much as possible will be built before stopping.",
-                   action="store_false", dest="abort", default=True)
+        parser.add_option("-a", "--tryaltconfigs", action="store_true", dest="tryaltconfigs", default=False,
+                          help="Continue with builds by trying to use alternative providers where possible.")
 
-        parser.add_option("-a", "--tryaltconfigs", help="Continue with builds by trying to use alternative providers where possible.",
-                   action="store_true", dest="tryaltconfigs", default=False)
+        parser.add_option("-f", "--force", action="store_true", dest="force", default=False,
+                          help="Force the specified targets/task to run (invalidating any existing stamp file).")
 
-        parser.add_option("-f", "--force", help="Force the specified targets/task to run (invalidating any existing stamp file).",
-                   action="store_true", dest="force", default=False)
+        parser.add_option("-c", "--cmd", action="store", dest="cmd",
+                          help="Specify the task to execute. The exact options available depend on the metadata. Some examples might be 'compile' or 'populate_sysroot' or 'listtasks' may give a list of the tasks available.")
 
-        parser.add_option("-c", "--cmd", help="Specify the task to execute. The exact options available depend on the metadata. Some examples might be 'compile' or 'populate_sysroot' or 'listtasks' may give a list of the tasks available.",
-                   action="store", dest="cmd")
+        parser.add_option("-C", "--clear-stamp", action="store", dest="invalidate_stamp",
+                          help="Invalidate the stamp for the specified task such as 'compile' and then run the default task for the specified target(s).")
 
-        parser.add_option("-C", "--clear-stamp", help="Invalidate the stamp for the specified task such as 'compile' and then run the default task for the specified target(s).",
-                    action="store", dest="invalidate_stamp")
+        parser.add_option("-r", "--read", action="append", dest="prefile", default=[],
+                          help="Read the specified file before bitbake.conf.")
 
-        parser.add_option("-r", "--read", help="Read the specified file before bitbake.conf.",
-                   action="append", dest="prefile", default=[])
+        parser.add_option("-R", "--postread", action="append", dest="postfile", default=[],
+                          help="Read the specified file after bitbake.conf.")
 
-        parser.add_option("-R", "--postread", help="Read the specified file after bitbake.conf.",
-                          action="append", dest="postfile", default=[])
+        parser.add_option("-v", "--verbose", action="store_true", dest="verbose", default=False,
+                          help="Output more log message data to the terminal.")
 
-        parser.add_option("-v", "--verbose", help="Output more log message data to the terminal.",
-                   action="store_true", dest="verbose", default=False)
+        parser.add_option("-D", "--debug", action="count", dest="debug", default=0,
+                          help="Increase the debug level. You can specify this more than once.")
 
-        parser.add_option("-D", "--debug", help="Increase the debug level. You can specify this more than once.",
-                   action="count", dest="debug", default=0)
+        parser.add_option("-n", "--dry-run", action="store_true", dest="dry_run", default=False,
+                          help="Don't execute, just go through the motions.")
 
-        parser.add_option("-n", "--dry-run", help="Don't execute, just go through the motions.",
-                   action="store_true", dest="dry_run", default=False)
+        parser.add_option("-S", "--dump-signatures", action="append", dest="dump_signatures",
+                          default=[], metavar="SIGNATURE_HANDLER",
+                          help="Dump out the signature construction information, with no task execution. The SIGNATURE_HANDLER parameter is passed to the handler. Two common values are none and printdiff but the handler may define more/less. none means only dump the signature, printdiff means compare the dumped signature with the cached one.")
 
-        parser.add_option("-S", "--dump-signatures", help="Dump out the signature construction information, with no task execution. The SIGNATURE_HANDLER parameter is passed to the handler. Two common values are none and printdiff but the handler may define more/less. none means only dump the signature, printdiff means compare the dumped signature with the cached one.",
-                   action="append", dest="dump_signatures", default=[], metavar="SIGNATURE_HANDLER")
+        parser.add_option("-p", "--parse-only", action="store_true", dest="parse_only", default=False,
+                          help="Quit after parsing the BB recipes.")
 
-        parser.add_option("-p", "--parse-only", help="Quit after parsing the BB recipes.",
-                   action="store_true", dest="parse_only", default=False)
+        parser.add_option("-s", "--show-versions", action="store_true", dest="show_versions", default=False,
+                          help="Show current and preferred versions of all recipes.")
 
-        parser.add_option("-s", "--show-versions", help="Show current and preferred versions of all recipes.",
-                   action="store_true", dest="show_versions", default=False)
+        parser.add_option("-e", "--environment", action="store_true", dest="show_environment", default=False,
+                          help="Show the global or per-recipe environment complete with information about where variables were set/changed.")
 
-        parser.add_option("-e", "--environment", help="Show the global or per-recipe environment complete with information about where variables were set/changed.",
-                   action="store_true", dest="show_environment", default=False)
+        parser.add_option("-g", "--graphviz", action="store_true", dest="dot_graph", default=False,
+                          help="Save dependency tree information for the specified targets in the dot syntax.")
 
-        parser.add_option("-g", "--graphviz", help="Save dependency tree information for the specified targets in the dot syntax.",
-                    action="store_true", dest="dot_graph", default=False)
+        parser.add_option("-I", "--ignore-deps", action="append", dest="extra_assume_provided", default=[],
+                          help="""Assume these dependencies don't exist and are already provided (equivalent to ASSUME_PROVIDED). Useful to make dependency graphs more appealing""")
 
-        parser.add_option("-I", "--ignore-deps", help="""Assume these dependencies don't exist and are already provided (equivalent to ASSUME_PROVIDED). Useful to make dependency graphs more appealing""",
-                    action="append", dest="extra_assume_provided", default=[])
+        parser.add_option("-l", "--log-domains", action="append", dest="debug_domains", default=[],
+                          help="""Show debug logging for the specified logging domains""")
 
-        parser.add_option("-l", "--log-domains", help="""Show debug logging for the specified logging domains""",
-                    action="append", dest="debug_domains", default=[])
-
-        parser.add_option("-P", "--profile", help="Profile the command and save reports.",
-                   action="store_true", dest="profile", default=False)
+        parser.add_option("-P", "--profile", action="store_true", dest="profile", default=False,
+                          help="Profile the command and save reports.")
 
         # @CHOICES@ is substituted out by BitbakeHelpFormatter above
-        parser.add_option("-u", "--ui", help="The user interface to use (@CHOICES@ - default %default).",
-                   action="store", dest="ui", default=os.environ.get('BITBAKE_UI', 'knotty'))
+        parser.add_option("-u", "--ui", action="store", dest="ui", default=os.environ.get('BITBAKE_UI', 'knotty'),
+                          help="The user interface to use (@CHOICES@ - default %default).")
 
         # @CHOICES@ is substituted out by BitbakeHelpFormatter above
-        parser.add_option("-t", "--servertype", help="Choose which server type to use (@CHOICES@ - default %default).",
-                   action="store", dest="servertype", default=["process", "xmlrpc"]["BBSERVER" in os.environ])
+        parser.add_option("-t", "--servertype", action="store", dest="servertype",
+                          default=["process", "xmlrpc"]["BBSERVER" in os.environ],
+                          help="Choose which server type to use (@CHOICES@ - default %default).")
 
-        parser.add_option("", "--token", help="Specify the connection token to be used when connecting to a remote server.",
-                   action="store", dest="xmlrpctoken", default=os.environ.get("BBTOKEN"))
+        parser.add_option("", "--token", action="store", dest="xmlrpctoken", default=os.environ.get("BBTOKEN"),
+                          help="Specify the connection token to be used when connecting to a remote server.")
 
-        parser.add_option("", "--revisions-changed", help="Set the exit code depending on whether upstream floating revisions have changed or not.",
-                   action="store_true", dest="revisions_changed", default=False)
+        parser.add_option("", "--revisions-changed", action="store_true", dest="revisions_changed", default=False,
+                          help="Set the exit code depending on whether upstream floating revisions have changed or not.")
 
-        parser.add_option("", "--server-only", help="Run bitbake without a UI, only starting a server (cooker) process.",
-                   action="store_true", dest="server_only", default=False)
+        parser.add_option("", "--server-only", action="store_true", dest="server_only", default=False,
+                          help="Run bitbake without a UI, only starting a server (cooker) process.")
 
-        parser.add_option("-B", "--bind", help="The name/address for the bitbake server to bind to.",
-                   action="store", dest="bind", default=False)
+        parser.add_option("-B", "--bind", action="store", dest="bind", default=False,
+                          help="The name/address for the bitbake server to bind to.")
 
-        parser.add_option("", "--no-setscene", help="Do not run any setscene tasks. sstate will be ignored and everything needed, built.",
-                   action="store_true", dest="nosetscene", default=False)
+        parser.add_option("", "--no-setscene", action="store_true", dest="nosetscene", default=False,
+                          help="Do not run any setscene tasks. sstate will be ignored and everything needed, built.")
 
-        parser.add_option("", "--setscene-only", help="Only run setscene tasks, don't run any real tasks.",
-                   action="store_true", dest="setsceneonly", default=False)
+        parser.add_option("", "--setscene-only", action="store_true", dest="setsceneonly", default=False,
+                          help="Only run setscene tasks, don't run any real tasks.")
 
-        parser.add_option("", "--remote-server", help="Connect to the specified server.",
-                   action="store", dest="remote_server", default=os.environ.get("BBSERVER"))
+        parser.add_option("", "--remote-server", action="store", dest="remote_server",
+                          default=os.environ.get("BBSERVER"),
+                          help="Connect to the specified server.")
 
-        parser.add_option("-m", "--kill-server", help="Terminate the remote server.",
-                    action="store_true", dest="kill_server", default=False)
+        parser.add_option("-m", "--kill-server", action="store_true", dest="kill_server", default=False,
+                          help="Terminate the remote server.")
 
-        parser.add_option("", "--observe-only", help="Connect to a server as an observing-only client.",
-                   action="store_true", dest="observe_only", default=False)
+        parser.add_option("", "--observe-only", action="store_true", dest="observe_only", default=False,
+                          help="Connect to a server as an observing-only client.")
 
-        parser.add_option("", "--status-only", help="Check the status of the remote bitbake server.",
-                   action="store_true", dest="status_only", default=False)
+        parser.add_option("", "--status-only", action="store_true", dest="status_only", default=False,
+                          help="Check the status of the remote bitbake server.")
 
-        parser.add_option("-w", "--write-log", help="Writes the event log of the build to a bitbake event json file. Use '' (empty string) to assign the name automatically.",
-                   action="store", dest="writeeventlog", default=os.environ.get("BBEVENTLOG"))
+        parser.add_option("-w", "--write-log", action="store", dest="writeeventlog",
+                          default=os.environ.get("BBEVENTLOG"),
+                          help="Writes the event log of the build to a bitbake event json file. Use '' (empty string) to assign the name automatically.")
 
         options, targets = parser.parse_args(argv)
 
@@ -365,7 +368,7 @@ def bitbake_main(configParams, configuration):
             configuration.debug = level
 
     bb.msg.init_msgconfig(configParams.verbose, configuration.debug,
-                         configuration.debug_domains)
+                          configuration.debug_domains)
 
     # Ensure logging messages get sent to the UI as events
     handler = bb.event.LogHandler()
-- 
2.1.4


