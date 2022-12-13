Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488C1C4332F
	for <webhook@archiver.kernel.org>; Tue, 13 Dec 2022 21:46:10 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
 by mx.groups.io with SMTP id smtpd.web10.86817.1670967967354017607
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Dec 2022 13:46:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=hykzO/rz;
 spf=pass (domain: gmail.com, ip: 209.85.160.43, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-144b21f5e5fso14225475fac.12
        for <bitbake-devel@lists.openembedded.org>; Tue, 13 Dec 2022 13:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lv/MvvV2M36o0gVK7HdlfoLKTrAMeCXBDyV4PosWDpU=;
        b=hykzO/rzTkxcYaidVxhAYuJ3lFBmDDLAbDfYW7JCTsXu0orqF85Az4zXuYmSkiui0c
         tWOfJvHmwD5rFGbsk3rcwjTJ9b8BrXyaD7yk+QOsgA3ESkruMcyXUWkoedxxmEIiVPgx
         c/QrUFgy9pT3spMbNPhfqYqegpnY5GN+Tcm+cHxsTplcIFaFeEkLn80HHskC8obhWeER
         WDE2+S8U/NbfaiW/921hgqROJuJjvwJU+Ed5D2dXS9s7AE1JtUA1OHbx7iSGtk6FDtyB
         Kl++NzlocbFjHRGiO5Fq3eNd3Nsh2tjCltOzVpgw0ULVb06Xl150kJGXfWO4omFh1RA2
         197g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lv/MvvV2M36o0gVK7HdlfoLKTrAMeCXBDyV4PosWDpU=;
        b=QGbpgQarE85sy8RQZVrA4lZMWoPdhDmTXZlfnfm8YoShwXwQ6IJdWezz9WW8G/RPKO
         He8acYlC4xpDnOhBsDpCWIDxzthxwfjI+6mv7J3DIM3OMJYc7jLnsB/j4l2ko5SvEFZe
         5QxX8NhN6EAXn76l+NQyLoA0gOdZ2Eoyp2a5aE2/6ZgzAKmgq9Pf4Phn1jMnUdxFTYtZ
         7qIJYSBp4Dsg92ZwlsCtFpDfRdWGX/32jKV6OUic8vcVZ73aXCabTZD31q38CBdwkyN2
         2WIXuNSnnZTS2JE7QRbJDJDLBbemj5XsUtPk1jQx0jblZekS2xdcVtw6vFl15Z45F/ED
         XTtA==
X-Gm-Message-State: ANoB5pn808KZhG1gx5dwlUvp2Io0u9gIKX8HuY5/iqFJc5DIJLHw0uqd
	8TLkhIT6jRK/7UgzT1JU8a0zt9fY0/Y=
X-Google-Smtp-Source: AA0mqf5V6p+TyeUM8PyLQQDEync7rJhlkVwLR9wVt97rxdCWaM6se6wLhU/elfZLg8jUladkrzr1vg==
X-Received: by 2002:a05:6870:1f11:b0:144:b331:bd2d with SMTP id pd17-20020a0568701f1100b00144b331bd2dmr11115071oab.33.1670967965818;
        Tue, 13 Dec 2022 13:46:05 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id ba35-20020a056870c5a300b0013b9ee734dcsm1969559oab.35.2022.12.13.13.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 13:46:05 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4] bitbake: Convert to argparse
Date: Tue, 13 Dec 2022 15:45:50 -0600
Message-Id: <20221213214550.2609969-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221110170046.3295885-1-JPEWhacker@gmail.com>
References: <20221110170046.3295885-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Dec 2022 21:46:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14186

Converts the main bitbake program to use argparse instead of the
deprecated optparse.

The resulting Namespace returned by argparse should be equivalent to the
one returned from optparse; the only major difference is that the
positional "target" arguments are consumed by argparse and returned as
the "targets" property instead of an additional argument from
parse_args().

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/main.py | 346 +++++++++++++++++++++--------------------
 1 file changed, 175 insertions(+), 171 deletions(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index 1e38d04bcf..0f849cd04c 100755
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
@@ -44,18 +44,18 @@ def present_options(optionlist):
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
@@ -115,180 +115,184 @@ def _showwarning(message, category, filename, lineno, file=None, line=None):
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
+    parser.add_argument("targets", nargs="*", metavar="recipename/target",
+                        help="Execute the specified task (default is 'build') for these target recipes (.bb files).")
+
     return parser
 
 
 class BitBakeConfigParameters(cookerdata.ConfigParameters):
     def parseCommandLine(self, argv=sys.argv):
         parser = create_bitbake_parser()
-        options, targets = parser.parse_args(argv)
+        options = parser.parse_intermixed_args(argv[1:])
+
+        if options.version:
+            print("BitBake Build Tool Core version %s" % bb.__version__)
+            sys.exit(0)
 
         if options.quiet and options.verbose:
             parser.error("options --quiet and --verbose are mutually exclusive")
@@ -320,7 +324,7 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         else:
             options.xmlrpcinterface = (None, 0)
 
-        return options, targets[1:]
+        return options, options.targets
 
 
 def bitbake_main(configParams, configuration):
-- 
2.33.0


