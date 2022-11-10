Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80742C4332F
	for <webhook@archiver.kernel.org>; Thu, 10 Nov 2022 17:01:22 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
 by mx.groups.io with SMTP id smtpd.web09.10108.1668099677306547040
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Nov 2022 09:01:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=oxufPq0c;
 spf=pass (domain: gmail.com, ip: 209.85.167.176, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f176.google.com with SMTP id s206so2440818oie.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 10 Nov 2022 09:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S0a9kudhTtMK9qmRc7AhnfoAvC9WHngGCwULtScUzVU=;
        b=oxufPq0c04gjtwDv02it4CrJRfWDDgkaGugiuRiIT2fYADpbHHZZoPgLJPjfcFxjtj
         DFLZwodQ41zpILvUIcv8tsc6pGKUZE/PlPdoWwKdxG8cye/D7rFBwsM2D6ySqxjrKaky
         kvJRt4HqQcN5zVx7Il/YtqRtZ1LEMAdjzA9RFZD17HO8lzt/r60oU14Mq43WcB802Pl4
         rTfTw3gp1Ev2VH5rO7Mct+NzssOW577ygjDdG1a0GZ8LfpcBZ3dLNwI/VuESHu4GOdWY
         mzIf7di/I08JkMaTwmroxbbRFUlvZyAukogcFD+RJq+0sOFzHX/7UAREb1gbHoy0k7Uo
         CX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0a9kudhTtMK9qmRc7AhnfoAvC9WHngGCwULtScUzVU=;
        b=w2VIvPL6nWqjFWbW7+WVrxBV5wk4/822SFENJrOzEEZ26gryBkkyAiu7Wm/uTYhImg
         R1TtLA+xruN8yPAYSR0Rbz4rk11jJDGWdo3puE4tdTDkL0ffn/tytRG/q17kuhI+1xSs
         Js7ZKf1dvOcPthJfPuSd6R7KBnNegYNrv14YCTNZi4ETeeTjHDgUWxBN+1HdzqCaaNew
         e79msTXV7Psm0kbDk1yiM1YM/Xt1rY+0Zfa9308yyukSc47BZo1CP0PbvZZVSXjfWRqX
         E/hyzxPyES6YzUKOEUucyIe1jSZZ8IPu3SInPeSD4zgVQLlDSRI6X/IZwjS7DHKB5Ei5
         yd9w==
X-Gm-Message-State: ACrzQf07CFPLj6GBNknWdB+8/jdeXiu+ItlphX52o42dH92S8SCnr/ga
	qoDwX/keGgw3melIIFLdioSyLRXiMMg=
X-Google-Smtp-Source: AMsMyM5i+uHmo+IBp9TBOyvFcnpyCo5VeWZk+SprXP/yjmCOjpaQVEc+sogukz/vnQgwLTw7Rw2qLQ==
X-Received: by 2002:a05:6808:ec6:b0:35a:220f:8008 with SMTP id q6-20020a0568080ec600b0035a220f8008mr1542884oiv.245.1668099675721;
        Thu, 10 Nov 2022 09:01:15 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id l9-20020a056870f14900b00127fbb7afffsm81503oac.5.2022.11.10.09.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:01:15 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake: Convert to argparse
Date: Thu, 10 Nov 2022 11:00:46 -0600
Message-Id: <20221110170046.3295885-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Nov 2022 17:01:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14067

Converts the main bitbake program to use argparse instead of the
deprecated optparse

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/main.py | 346 +++++++++++++++++++++--------------------
 1 file changed, 175 insertions(+), 171 deletions(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index 93eda3632ed..d4080d63075 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -12,7 +12,7 @@
 import os
 import sys
 import logging
-import optparse
+import argparse
 import warnings
 import fcntl
 import time
@@ -43,18 +43,18 @@ def present_options(optionlist):
     else:
         return optionlist[0]
 
-class BitbakeHelpFormatter(optparse.IndentedHelpFormatter):
-    def format_option(self, option):
+class BitbakeHelpFormatter(argparse.HelpFormatter):
+    def _get_help_string(self, action):
         # We need to do this here rather than in the text we supply to
         # add_option() because we don't want to call list_extension_modules()
         # on every execution (since it imports all of the modules)
         # Note also that we modify option.help rather than the returned text
         # - this is so that we don't have to re-format the text ourselves
-        if option.dest == 'ui':
+        if action.dest == 'ui':
             valid_uis = list_extension_modules(bb.ui, 'main')
-            option.help = option.help.replace('@CHOICES@', present_options(valid_uis))
+            return action.help.replace('@CHOICES@', present_options(valid_uis))
 
-        return optparse.IndentedHelpFormatter.format_option(self, option)
+        return action.help
 
 def list_extension_modules(pkg, checkattr):
     """
@@ -114,180 +114,184 @@ def _showwarning(message, category, filename, lineno, file=None, line=None):
 warnings.showwarning = _showwarning
 
 def create_bitbake_parser():
-    parser = optparse.OptionParser(
-        formatter=BitbakeHelpFormatter(),
-        version="BitBake Build Tool Core version %s" % bb.__version__,
-        usage="""%prog [options] [recipename/target recipe:do_task ...]
-
-    Executes the specified task (default is 'build') for a given set of target recipes (.bb files).
-    It is assumed there is a conf/bblayers.conf available in cwd or in BBPATH which
-    will provide the layer, BBFILES and other configuration information.""")
-
-    parser.add_option("-b", "--buildfile", action="store", dest="buildfile", default=None,
-                      help="Execute tasks from a specific .bb recipe directly. WARNING: Does "
-                           "not handle any dependencies from other recipes.")
-
-    parser.add_option("-k", "--continue", action="store_false", dest="halt", default=True,
-                      help="Continue as much as possible after an error. While the target that "
-                           "failed and anything depending on it cannot be built, as much as "
-                           "possible will be built before stopping.")
-
-    parser.add_option("-f", "--force", action="store_true", dest="force", default=False,
-                      help="Force the specified targets/task to run (invalidating any "
-                           "existing stamp file).")
-
-    parser.add_option("-c", "--cmd", action="store", dest="cmd",
-                      help="Specify the task to execute. The exact options available "
-                           "depend on the metadata. Some examples might be 'compile'"
-                           " or 'populate_sysroot' or 'listtasks' may give a list of "
-                           "the tasks available.")
-
-    parser.add_option("-C", "--clear-stamp", action="store", dest="invalidate_stamp",
-                      help="Invalidate the stamp for the specified task such as 'compile' "
-                           "and then run the default task for the specified target(s).")
-
-    parser.add_option("-r", "--read", action="append", dest="prefile", default=[],
-                      help="Read the specified file before bitbake.conf.")
-
-    parser.add_option("-R", "--postread", action="append", dest="postfile", default=[],
-                      help="Read the specified file after bitbake.conf.")
-
-    parser.add_option("-v", "--verbose", action="store_true", dest="verbose", default=False,
-                      help="Enable tracing of shell tasks (with 'set -x'). "
-                           "Also print bb.note(...) messages to stdout (in "
-                           "addition to writing them to ${T}/log.do_<task>).")
-
-    parser.add_option("-D", "--debug", action="count", dest="debug", default=0,
-                      help="Increase the debug level. You can specify this "
-                           "more than once. -D sets the debug level to 1, "
-                           "where only bb.debug(1, ...) messages are printed "
-                           "to stdout; -DD sets the debug level to 2, where "
-                           "both bb.debug(1, ...) and bb.debug(2, ...) "
-                           "messages are printed; etc. Without -D, no debug "
-                           "messages are printed. Note that -D only affects "
-                           "output to stdout. All debug messages are written "
-                           "to ${T}/log.do_taskname, regardless of the debug "
-                           "level.")
-
-    parser.add_option("-q", "--quiet", action="count", dest="quiet", default=0,
-                      help="Output less log message data to the terminal. You can specify this more than once.")
-
-    parser.add_option("-n", "--dry-run", action="store_true", dest="dry_run", default=False,
-                      help="Don't execute, just go through the motions.")
-
-    parser.add_option("-S", "--dump-signatures", action="append", dest="dump_signatures",
-                      default=[], metavar="SIGNATURE_HANDLER",
-                      help="Dump out the signature construction information, with no task "
-                           "execution. The SIGNATURE_HANDLER parameter is passed to the "
-                           "handler. Two common values are none and printdiff but the handler "
-                           "may define more/less. none means only dump the signature, printdiff"
-                           " means compare the dumped signature with the cached one.")
-
-    parser.add_option("-p", "--parse-only", action="store_true",
-                      dest="parse_only", default=False,
-                      help="Quit after parsing the BB recipes.")
-
-    parser.add_option("-s", "--show-versions", action="store_true",
-                      dest="show_versions", default=False,
-                      help="Show current and preferred versions of all recipes.")
-
-    parser.add_option("-e", "--environment", action="store_true",
-                      dest="show_environment", default=False,
-                      help="Show the global or per-recipe environment complete with information"
-                           " about where variables were set/changed.")
-
-    parser.add_option("-g", "--graphviz", action="store_true", dest="dot_graph", default=False,
-                      help="Save dependency tree information for the specified "
-                           "targets in the dot syntax.")
-
-    parser.add_option("-I", "--ignore-deps", action="append",
-                      dest="extra_assume_provided", default=[],
-                      help="Assume these dependencies don't exist and are already provided "
-                           "(equivalent to ASSUME_PROVIDED). Useful to make dependency "
-                           "graphs more appealing")
-
-    parser.add_option("-l", "--log-domains", action="append", dest="debug_domains", default=[],
-                      help="Show debug logging for the specified logging domains")
-
-    parser.add_option("-P", "--profile", action="store_true", dest="profile", default=False,
-                      help="Profile the command and save reports.")
+    parser = argparse.ArgumentParser(
+        description="""\
+            It is assumed there is a conf/bblayers.conf available in cwd or in BBPATH which
+            will provide the layer, BBFILES and other configuration information.
+            """,
+        formatter_class=BitbakeHelpFormatter,
+        allow_abbrev=False,
+    )
+
+    parser.add_argument("--version", action="store_true",
+                        help="Show programs version and exit")
+
+    parser.add_argument("-b", "--buildfile",
+                        help="Execute tasks from a specific .bb recipe directly. WARNING: Does "
+                             "not handle any dependencies from other recipes.")
+
+    parser.add_argument("-k", "--continue", action="store_false", dest="halt",
+                        help="Continue as much as possible after an error. While the target that "
+                             "failed and anything depending on it cannot be built, as much as "
+                             "possible will be built before stopping.")
+
+    parser.add_argument("-f", "--force", action="store_true",
+                        help="Force the specified targets/task to run (invalidating any "
+                             "existing stamp file).")
+
+    parser.add_argument("-c", "--cmd",
+                        help="Specify the task to execute. The exact options available "
+                             "depend on the metadata. Some examples might be 'compile'"
+                             " or 'populate_sysroot' or 'listtasks' may give a list of "
+                             "the tasks available.")
+
+    parser.add_argument("-C", "--clear-stamp", dest="invalidate_stamp",
+                        help="Invalidate the stamp for the specified task such as 'compile' "
+                             "and then run the default task for the specified target(s).")
+
+    parser.add_argument("-r", "--read", action="append", dest="prefile", default=[],
+                        help="Read the specified file before bitbake.conf.")
+
+    parser.add_argument("-R", "--postread", action="append", dest="postfile", default=[],
+                        help="Read the specified file after bitbake.conf.")
+
+    parser.add_argument("-v", "--verbose", action="store_true",
+                        help="Enable tracing of shell tasks (with 'set -x'). "
+                             "Also print bb.note(...) messages to stdout (in "
+                             "addition to writing them to ${T}/log.do_<task>).")
+
+    parser.add_argument("-D", "--debug", action="count", default=0,
+                        help="Increase the debug level. You can specify this "
+                             "more than once. -D sets the debug level to 1, "
+                             "where only bb.debug(1, ...) messages are printed "
+                             "to stdout; -DD sets the debug level to 2, where "
+                             "both bb.debug(1, ...) and bb.debug(2, ...) "
+                             "messages are printed; etc. Without -D, no debug "
+                             "messages are printed. Note that -D only affects "
+                             "output to stdout. All debug messages are written "
+                             "to ${T}/log.do_taskname, regardless of the debug "
+                             "level.")
+
+    parser.add_argument("-q", "--quiet", action="count", default=0,
+                        help="Output less log message data to the terminal. You can specify this more than once.")
+
+    parser.add_argument("-n", "--dry-run", action="store_true",
+                        help="Don't execute, just go through the motions.")
+
+    parser.add_argument("-S", "--dump-signatures", action="append",
+                        default=[], metavar="SIGNATURE_HANDLER",
+                        help="Dump out the signature construction information, with no task "
+                             "execution. The SIGNATURE_HANDLER parameter is passed to the "
+                             "handler. Two common values are none and printdiff but the handler "
+                             "may define more/less. none means only dump the signature, printdiff"
+                             " means compare the dumped signature with the cached one.")
+
+    parser.add_argument("-p", "--parse-only", action="store_true",
+                        help="Quit after parsing the BB recipes.")
+
+    parser.add_argument("-s", "--show-versions", action="store_true",
+                        help="Show current and preferred versions of all recipes.")
+
+    parser.add_argument("-e", "--environment", action="store_true",
+                        dest="show_environment",
+                        help="Show the global or per-recipe environment complete with information"
+                             " about where variables were set/changed.")
+
+    parser.add_argument("-g", "--graphviz", action="store_true", dest="dot_graph",
+                        help="Save dependency tree information for the specified "
+                             "targets in the dot syntax.")
+
+    parser.add_argument("-I", "--ignore-deps", action="append",
+                        dest="extra_assume_provided", default=[],
+                        help="Assume these dependencies don't exist and are already provided "
+                             "(equivalent to ASSUME_PROVIDED). Useful to make dependency "
+                             "graphs more appealing")
+
+    parser.add_argument("-l", "--log-domains", action="append", dest="debug_domains", default=[],
+                        help="Show debug logging for the specified logging domains")
+
+    parser.add_argument("-P", "--profile", action="store_true",
+                        help="Profile the command and save reports.")
 
     # @CHOICES@ is substituted out by BitbakeHelpFormatter above
-    parser.add_option("-u", "--ui", action="store", dest="ui",
-                      default=os.environ.get('BITBAKE_UI', 'knotty'),
-                      help="The user interface to use (@CHOICES@ - default %default).")
-
-    parser.add_option("", "--token", action="store", dest="xmlrpctoken",
-                      default=os.environ.get("BBTOKEN"),
-                      help="Specify the connection token to be used when connecting "
-                           "to a remote server.")
-
-    parser.add_option("", "--revisions-changed", action="store_true",
-                      dest="revisions_changed", default=False,
-                      help="Set the exit code depending on whether upstream floating "
-                           "revisions have changed or not.")
-
-    parser.add_option("", "--server-only", action="store_true",
-                      dest="server_only", default=False,
-                      help="Run bitbake without a UI, only starting a server "
-                           "(cooker) process.")
-
-    parser.add_option("-B", "--bind", action="store", dest="bind", default=False,
-                      help="The name/address for the bitbake xmlrpc server to bind to.")
-
-    parser.add_option("-T", "--idle-timeout", type=float, dest="server_timeout",
-                      default=os.getenv("BB_SERVER_TIMEOUT"),
-                      help="Set timeout to unload bitbake server due to inactivity, "
-                           "set to -1 means no unload, "
-                           "default: Environment variable BB_SERVER_TIMEOUT.")
-
-    parser.add_option("", "--no-setscene", action="store_true",
-                      dest="nosetscene", default=False,
-                      help="Do not run any setscene tasks. sstate will be ignored and "
-                           "everything needed, built.")
-
-    parser.add_option("", "--skip-setscene", action="store_true",
-                      dest="skipsetscene", default=False,
-                      help="Skip setscene tasks if they would be executed. Tasks previously "
-                           "restored from sstate will be kept, unlike --no-setscene")
-
-    parser.add_option("", "--setscene-only", action="store_true",
-                      dest="setsceneonly", default=False,
-                      help="Only run setscene tasks, don't run any real tasks.")
-
-    parser.add_option("", "--remote-server", action="store", dest="remote_server",
-                      default=os.environ.get("BBSERVER"),
-                      help="Connect to the specified server.")
-
-    parser.add_option("-m", "--kill-server", action="store_true",
-                      dest="kill_server", default=False,
-                      help="Terminate any running bitbake server.")
-
-    parser.add_option("", "--observe-only", action="store_true",
-                      dest="observe_only", default=False,
-                      help="Connect to a server as an observing-only client.")
-
-    parser.add_option("", "--status-only", action="store_true",
-                      dest="status_only", default=False,
-                      help="Check the status of the remote bitbake server.")
-
-    parser.add_option("-w", "--write-log", action="store", dest="writeeventlog",
-                      default=os.environ.get("BBEVENTLOG"),
-                      help="Writes the event log of the build to a bitbake event json file. "
-                           "Use '' (empty string) to assign the name automatically.")
-
-    parser.add_option("", "--runall", action="append", dest="runall",
+    parser.add_argument("-u", "--ui",
+                        default=os.environ.get('BITBAKE_UI', 'knotty'),
+                        help="The user interface to use (@CHOICES@ - default %(default)s).")
+
+    parser.add_argument("--token", dest="xmlrpctoken",
+                        default=os.environ.get("BBTOKEN"),
+                        help="Specify the connection token to be used when connecting "
+                             "to a remote server.")
+
+    parser.add_argument("--revisions-changed", action="store_true",
+                        help="Set the exit code depending on whether upstream floating "
+                            "revisions have changed or not.")
+
+    parser.add_argument("--server-only", action="store_true",
+                        help="Run bitbake without a UI, only starting a server "
+                            "(cooker) process.")
+
+    parser.add_argument("-B", "--bind", default=False,
+                        help="The name/address for the bitbake xmlrpc server to bind to.")
+
+    parser.add_argument("-T", "--idle-timeout", type=float, dest="server_timeout",
+                        default=os.getenv("BB_SERVER_TIMEOUT"),
+                        help="Set timeout to unload bitbake server due to inactivity, "
+                             "set to -1 means no unload, "
+                             "default: Environment variable BB_SERVER_TIMEOUT.")
+
+    parser.add_argument("--no-setscene", action="store_true",
+                        dest="nosetscene",
+                        help="Do not run any setscene tasks. sstate will be ignored and "
+                            "everything needed, built.")
+
+    parser.add_argument("--skip-setscene", action="store_true",
+                        dest="skipsetscene",
+                        help="Skip setscene tasks if they would be executed. Tasks previously "
+                            "restored from sstate will be kept, unlike --no-setscene")
+
+    parser.add_argument("--setscene-only", action="store_true",
+                        dest="setsceneonly",
+                        help="Only run setscene tasks, don't run any real tasks.")
+
+    parser.add_argument("--remote-server",
+                        default=os.environ.get("BBSERVER"),
+                        help="Connect to the specified server.")
+
+    parser.add_argument("-m", "--kill-server", action="store_true",
+                        help="Terminate any running bitbake server.")
+
+    parser.add_argument("--observe-only", action="store_true",
+                        help="Connect to a server as an observing-only client.")
+
+    parser.add_argument("--status-only", action="store_true",
+                        help="Check the status of the remote bitbake server.")
+
+    parser.add_argument("-w", "--write-log", dest="writeeventlog",
+                        default=os.environ.get("BBEVENTLOG"),
+                        help="Writes the event log of the build to a bitbake event json file. "
+                            "Use '' (empty string) to assign the name automatically.")
+
+    parser.add_argument("--runall", action="append", default=[],
                       help="Run the specified task for any recipe in the taskgraph of the specified target (even if it wouldn't otherwise have run).")
 
-    parser.add_option("", "--runonly", action="append", dest="runonly",
-                      help="Run only the specified task within the taskgraph of the specified targets (and any task dependencies those tasks may have).")
+    parser.add_argument("--runonly", action="append",
+                        help="Run only the specified task within the taskgraph of the specified targets (and any task dependencies those tasks may have).")
+
+    parser.add_argument("targets", nargs="*", action="append", default=[], metavar="recipename/target",
+                        help="Execute the specified task (default is 'build') for these target recipes (.bb files).")
+
     return parser
 
 
 class BitBakeConfigParameters(cookerdata.ConfigParameters):
     def parseCommandLine(self, argv=sys.argv):
         parser = create_bitbake_parser()
-        options, targets = parser.parse_args(argv)
+        options = parser.parse_args(argv)
+
+        if options.version:
+            print("BitBake Build Tool Core version %s" % bb.__version__)
+            sys.exit(0)
 
         if options.quiet and options.verbose:
             parser.error("options --quiet and --verbose are mutually exclusive")
@@ -319,7 +323,7 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         else:
             options.xmlrpcinterface = (None, 0)
 
-        return options, targets[1:]
+        return options, options.targets
 
 
 def bitbake_main(configParams, configuration):
-- 
2.33.0


