Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF177C3DA7A
	for <webhook@archiver.kernel.org>; Fri,  6 Jan 2023 14:10:30 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.14204.1673014220426688981
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Jan 2023 06:10:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20210112.gappssmtp.com header.s=20210112 header.b=0P3eovpB;
 spf=pass (domain: smile.fr, ip: 209.85.128.47, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f47.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso1171751wmb.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 06 Jan 2023 06:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Eg/Vs42v3obACPDe0icEU3bidGgO9bGqVI2yxJ6i+k=;
        b=0P3eovpBjBTW7dR5uNG4eM8BxKgqI7D8NWVonz6kOR1m2MkI+8F6wK5Qw9qqdvlGnH
         U8oKKAxbiEkRARef2kiZKysUj6LpbKPpwNsX15ACQLeyDK59+cN9Sft4o/uAeQDSgt6Z
         gt3HpLjgC+HPZFqvsWSyLAErH2n5IsKhj0dHfIWGDU0KojM3VLna62M265tul77Wvznr
         3JcfVzezngle7UdcRtWjvmRBzrqk+KvJDggPuowkNiUS4p4MgIVuBy0RafdmPyEhrgkL
         z41DJqe7ofAPS3r7MwROmhi1FTHmXj9ZKuHvT1yijrbNiCZBsG//1wsgqKjK0WccvpTe
         EXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Eg/Vs42v3obACPDe0icEU3bidGgO9bGqVI2yxJ6i+k=;
        b=D0SU58lA7SgfCFODAuNZVTJtGM+3aBemZcfquEw7lgmJRg2zpnhBZ/Zxeu34u4iS1H
         OOILaxDsuokRuq279F3xOnZZeaus+XdXEM/RshAaR8bBZVwzVDD7lJQV6EDuYZXtTaeA
         +KCEn6DrUgEMg5ICTy/uq9wKKEU5TXdV8/SXXiiyTUrYQdpkuNiIY9oRyaaFkPewU2qb
         mahFxA1HoyJVNTj3W2k5TEg6c/vaLG43q5BS4OWVlfGIGbttNJukZ7a3W8i+0GVu9+UT
         sQ7VtYfdWkWoEid3lSCvR/kKBOrJqX1MByN4O2EFvS4jwiO0uYHDphPv6K+QMPS3hdtn
         x2Iw==
X-Gm-Message-State: AFqh2kqr4ADXgIiAtiQOqxHECvVJn5U+s8+gB4ct4xaAma2Cw+R8cpIY
	mKcG+S5x1mNgR2w02vBVTIRzozlwDpjoPRGe
X-Google-Smtp-Source: AMrXdXszWeIzYWJd7pmxC3yKIxRqK7FQuH+fUiXNLWSN99/qFXqEwQ+mZ48n12G6ULaS2XlOBCoC4Q==
X-Received: by 2002:a05:600c:3596:b0:3cf:497c:c4f5 with SMTP id p22-20020a05600c359600b003cf497cc4f5mr41695820wmq.13.1673014217880;
        Fri, 06 Jan 2023 06:10:17 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.numericable.fr (89-159-1-53.rev.numericable.fr. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id f3-20020a1c6a03000000b003d9ad6783b1sm1828150wmc.6.2023.01.06.06.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 06:10:17 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH] Group and reorder options in bitbake help
Date: Fri,  6 Jan 2023 15:09:41 +0100
Message-Id: <20230106140941.2319632-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Jan 2023 14:10:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14290

Fixes [YOCTO #12018].

Also, I have included some small fixes:
* added a '.' at the end of sentence where it was missing
* split some long lines

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/main.py | 222 +++++++++++++++++++++++++++----------------------
 1 file changed, 122 insertions(+), 100 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 70b3845a..1c87a02d 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -122,64 +122,100 @@ def create_bitbake_parser():
             """,
         formatter_class=BitbakeHelpFormatter,
         allow_abbrev=False,
+        add_help=False, # help is manually added below in a specific argument group
     )
 
-    parser.add_argument("--version", action="store_true",
-                        help="Show programs version and exit")
+    general_group  = parser.add_argument_group('General options')
+    task_group     = parser.add_argument_group('Task control options')
+    exec_group     = parser.add_argument_group('Execution control options')
+    logging_group  = parser.add_argument_group('Logging/output control options')
+    server_group   = parser.add_argument_group('Server options')
+    config_group   = parser.add_argument_group('Configuration options')
 
-    parser.add_argument("-b", "--buildfile",
+    general_group.add_argument("targets", nargs="*", metavar="recipename/target",
+                        help="Execute the specified task (default is 'build') for these target "
+                             "recipes (.bb files).")
+
+    general_group.add_argument("-b", "--buildfile",
                         help="Execute tasks from a specific .bb recipe directly. WARNING: Does "
                              "not handle any dependencies from other recipes.")
 
-    parser.add_argument("-k", "--continue", action="store_false", dest="halt",
-                        help="Continue as much as possible after an error. While the target that "
-                             "failed and anything depending on it cannot be built, as much as "
-                             "possible will be built before stopping.")
+    general_group.add_argument("-s", "--show-versions", action="store_true",
+                        help="Show current and preferred versions of all recipes.")
+
+    general_group.add_argument("-e", "--environment", action="store_true",
+                        dest="show_environment",
+                        help="Show the global or per-recipe environment complete with information"
+                             " about where variables were set/changed.")
+
+    general_group.add_argument("-g", "--graphviz", action="store_true", dest="dot_graph",
+                        help="Save dependency tree information for the specified "
+                             "targets in the dot syntax.")
+
+    # @CHOICES@ is substituted out by BitbakeHelpFormatter above
+    general_group.add_argument("-u", "--ui",
+                        default=os.environ.get('BITBAKE_UI', 'knotty'),
+                        help="The user interface to use (@CHOICES@ - default %(default)s).")
+
+    general_group.add_argument("--version", action="store_true",
+                        help="Show programs version and exit.")
+
+    general_group.add_argument('-h', '--help', action='help',
+                        help='Show this help message and exit.')
+
 
-    parser.add_argument("-f", "--force", action="store_true",
+    task_group.add_argument("-f", "--force", action="store_true",
                         help="Force the specified targets/task to run (invalidating any "
                              "existing stamp file).")
 
-    parser.add_argument("-c", "--cmd",
+    task_group.add_argument("-c", "--cmd",
                         help="Specify the task to execute. The exact options available "
                              "depend on the metadata. Some examples might be 'compile'"
                              " or 'populate_sysroot' or 'listtasks' may give a list of "
                              "the tasks available.")
 
-    parser.add_argument("-C", "--clear-stamp", dest="invalidate_stamp",
+    task_group.add_argument("-C", "--clear-stamp", dest="invalidate_stamp",
                         help="Invalidate the stamp for the specified task such as 'compile' "
                              "and then run the default task for the specified target(s).")
 
-    parser.add_argument("-r", "--read", action="append", dest="prefile", default=[],
-                        help="Read the specified file before bitbake.conf.")
+    task_group.add_argument("--runall", action="append", default=[],
+                        help="Run the specified task for any recipe in the taskgraph of the "
+                             "specified target (even if it wouldn't otherwise have run).")
 
-    parser.add_argument("-R", "--postread", action="append", dest="postfile", default=[],
-                        help="Read the specified file after bitbake.conf.")
+    task_group.add_argument("--runonly", action="append",
+                        help="Run only the specified task within the taskgraph of the "
+                             "specified targets (and any task dependencies those tasks may have).")
 
-    parser.add_argument("-v", "--verbose", action="store_true",
-                        help="Enable tracing of shell tasks (with 'set -x'). "
-                             "Also print bb.note(...) messages to stdout (in "
-                             "addition to writing them to ${T}/log.do_<task>).")
+    task_group.add_argument("--no-setscene", action="store_true",
+                        dest="nosetscene",
+                        help="Do not run any setscene tasks. sstate will be ignored and "
+                            "everything needed, built.")
 
-    parser.add_argument("-D", "--debug", action="count", default=0,
-                        help="Increase the debug level. You can specify this "
-                             "more than once. -D sets the debug level to 1, "
-                             "where only bb.debug(1, ...) messages are printed "
-                             "to stdout; -DD sets the debug level to 2, where "
-                             "both bb.debug(1, ...) and bb.debug(2, ...) "
-                             "messages are printed; etc. Without -D, no debug "
-                             "messages are printed. Note that -D only affects "
-                             "output to stdout. All debug messages are written "
-                             "to ${T}/log.do_taskname, regardless of the debug "
-                             "level.")
+    task_group.add_argument("--skip-setscene", action="store_true",
+                        dest="skipsetscene",
+                        help="Skip setscene tasks if they would be executed. Tasks previously "
+                            "restored from sstate will be kept, unlike --no-setscene.")
+
+    task_group.add_argument("--setscene-only", action="store_true",
+                        dest="setsceneonly",
+                        help="Only run setscene tasks, don't run any real tasks.")
 
-    parser.add_argument("-q", "--quiet", action="count", default=0,
-                        help="Output less log message data to the terminal. You can specify this more than once.")
 
-    parser.add_argument("-n", "--dry-run", action="store_true",
+    exec_group.add_argument("-n", "--dry-run", action="store_true",
                         help="Don't execute, just go through the motions.")
 
-    parser.add_argument("-S", "--dump-signatures", action="append",
+    exec_group.add_argument("-p", "--parse-only", action="store_true",
+                        help="Quit after parsing the BB recipes.")
+
+    exec_group.add_argument("-k", "--continue", action="store_false", dest="halt",
+                        help="Continue as much as possible after an error. While the target that "
+                             "failed and anything depending on it cannot be built, as much as "
+                             "possible will be built before stopping.")
+
+    exec_group.add_argument("-P", "--profile", action="store_true",
+                        help="Profile the command and save reports.")
+
+    exec_group.add_argument("-S", "--dump-signatures", action="append",
                         default=[], metavar="SIGNATURE_HANDLER",
                         help="Dump out the signature construction information, with no task "
                              "execution. The SIGNATURE_HANDLER parameter is passed to the "
@@ -187,100 +223,86 @@ def create_bitbake_parser():
                              "may define more/less. none means only dump the signature, printdiff"
                              " means compare the dumped signature with the cached one.")
 
-    parser.add_argument("-p", "--parse-only", action="store_true",
-                        help="Quit after parsing the BB recipes.")
-
-    parser.add_argument("-s", "--show-versions", action="store_true",
-                        help="Show current and preferred versions of all recipes.")
-
-    parser.add_argument("-e", "--environment", action="store_true",
-                        dest="show_environment",
-                        help="Show the global or per-recipe environment complete with information"
-                             " about where variables were set/changed.")
-
-    parser.add_argument("-g", "--graphviz", action="store_true", dest="dot_graph",
-                        help="Save dependency tree information for the specified "
-                             "targets in the dot syntax.")
+    exec_group.add_argument("--revisions-changed", action="store_true",
+                        help="Set the exit code depending on whether upstream floating "
+                            "revisions have changed or not.")
 
-    parser.add_argument("-I", "--ignore-deps", action="append",
-                        dest="extra_assume_provided", default=[],
-                        help="Assume these dependencies don't exist and are already provided "
-                             "(equivalent to ASSUME_PROVIDED). Useful to make dependency "
-                             "graphs more appealing")
 
-    parser.add_argument("-l", "--log-domains", action="append", dest="debug_domains", default=[],
-                        help="Show debug logging for the specified logging domains")
+    logging_group.add_argument("-D", "--debug", action="count", default=0,
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
 
-    parser.add_argument("-P", "--profile", action="store_true",
-                        help="Profile the command and save reports.")
+    logging_group.add_argument("-l", "--log-domains", action="append", dest="debug_domains",
+                        default=[],
+                        help="Show debug logging for the specified logging domains.")
 
-    # @CHOICES@ is substituted out by BitbakeHelpFormatter above
-    parser.add_argument("-u", "--ui",
-                        default=os.environ.get('BITBAKE_UI', 'knotty'),
-                        help="The user interface to use (@CHOICES@ - default %(default)s).")
+    logging_group.add_argument("-v", "--verbose", action="store_true",
+                        help="Enable tracing of shell tasks (with 'set -x'). "
+                             "Also print bb.note(...) messages to stdout (in "
+                             "addition to writing them to ${T}/log.do_<task>).")
 
-    parser.add_argument("--token", dest="xmlrpctoken",
-                        default=os.environ.get("BBTOKEN"),
-                        help="Specify the connection token to be used when connecting "
-                             "to a remote server.")
+    logging_group.add_argument("-q", "--quiet", action="count", default=0,
+                        help="Output less log message data to the terminal. You can specify this "
+                             "more than once.")
 
-    parser.add_argument("--revisions-changed", action="store_true",
-                        help="Set the exit code depending on whether upstream floating "
-                            "revisions have changed or not.")
+    logging_group.add_argument("-w", "--write-log", dest="writeeventlog",
+                        default=os.environ.get("BBEVENTLOG"),
+                        help="Writes the event log of the build to a bitbake event json file. "
+                            "Use '' (empty string) to assign the name automatically.")
 
-    parser.add_argument("--server-only", action="store_true",
-                        help="Run bitbake without a UI, only starting a server "
-                            "(cooker) process.")
 
-    parser.add_argument("-B", "--bind", default=False,
+    server_group.add_argument("-B", "--bind", default=False,
                         help="The name/address for the bitbake xmlrpc server to bind to.")
 
-    parser.add_argument("-T", "--idle-timeout", type=float, dest="server_timeout",
+    server_group.add_argument("-T", "--idle-timeout", type=float, dest="server_timeout",
                         default=os.getenv("BB_SERVER_TIMEOUT"),
                         help="Set timeout to unload bitbake server due to inactivity, "
                              "set to -1 means no unload, "
                              "default: Environment variable BB_SERVER_TIMEOUT.")
 
-    parser.add_argument("--no-setscene", action="store_true",
-                        dest="nosetscene",
-                        help="Do not run any setscene tasks. sstate will be ignored and "
-                            "everything needed, built.")
-
-    parser.add_argument("--skip-setscene", action="store_true",
-                        dest="skipsetscene",
-                        help="Skip setscene tasks if they would be executed. Tasks previously "
-                            "restored from sstate will be kept, unlike --no-setscene")
-
-    parser.add_argument("--setscene-only", action="store_true",
-                        dest="setsceneonly",
-                        help="Only run setscene tasks, don't run any real tasks.")
-
-    parser.add_argument("--remote-server",
+    server_group.add_argument("--remote-server",
                         default=os.environ.get("BBSERVER"),
                         help="Connect to the specified server.")
 
-    parser.add_argument("-m", "--kill-server", action="store_true",
+    server_group.add_argument("-m", "--kill-server", action="store_true",
                         help="Terminate any running bitbake server.")
 
-    parser.add_argument("--observe-only", action="store_true",
+    server_group.add_argument("--token", dest="xmlrpctoken",
+                        default=os.environ.get("BBTOKEN"),
+                        help="Specify the connection token to be used when connecting "
+                             "to a remote server.")
+
+    server_group.add_argument("--observe-only", action="store_true",
                         help="Connect to a server as an observing-only client.")
 
-    parser.add_argument("--status-only", action="store_true",
+    server_group.add_argument("--status-only", action="store_true",
                         help="Check the status of the remote bitbake server.")
 
-    parser.add_argument("-w", "--write-log", dest="writeeventlog",
-                        default=os.environ.get("BBEVENTLOG"),
-                        help="Writes the event log of the build to a bitbake event json file. "
-                            "Use '' (empty string) to assign the name automatically.")
+    server_group.add_argument("--server-only", action="store_true",
+                        help="Run bitbake without a UI, only starting a server "
+                            "(cooker) process.")
 
-    parser.add_argument("--runall", action="append", default=[],
-                      help="Run the specified task for any recipe in the taskgraph of the specified target (even if it wouldn't otherwise have run).")
 
-    parser.add_argument("--runonly", action="append",
-                        help="Run only the specified task within the taskgraph of the specified targets (and any task dependencies those tasks may have).")
+    config_group.add_argument("-r", "--read", action="append", dest="prefile", default=[],
+                        help="Read the specified file before bitbake.conf.")
+
+    config_group.add_argument("-R", "--postread", action="append", dest="postfile", default=[],
+                        help="Read the specified file after bitbake.conf.")
+
 
-    parser.add_argument("targets", nargs="*", metavar="recipename/target",
-                        help="Execute the specified task (default is 'build') for these target recipes (.bb files).")
+    config_group.add_argument("-I", "--ignore-deps", action="append",
+                        dest="extra_assume_provided", default=[],
+                        help="Assume these dependencies don't exist and are already provided "
+                             "(equivalent to ASSUME_PROVIDED). Useful to make dependency "
+                             "graphs more appealing.")
 
     return parser
 
-- 
2.30.2


