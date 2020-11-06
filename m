Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.107.237.86])
 by mx.groups.io with SMTP id smtpd.web11.749.1604685801126785179
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Nov 2020 10:03:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=aJuwuT9n;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.237.86, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAcYYSrIcAALzKYR+HHjwekX2DkKh2xMBfuew4K2I3oMWtkqE+r5Hc3s9+66AuNxVy864NLdEIJvTXhZ450NjrqhB1ObdlTLXP3xpKP/ATfXw1QgLzbhIRxX7xmS/mBP15vcFjYnwBgHUMPNZ1VWJ2XAYwm7SLbKQY9xrADcDQ4VnJKjf5eWH/66hRl/CpVOmyNX+v+MIphJbM9zG66iJHCyfzF/2LkGLPjQsvc9qN9L1npcG6aFTEPS3WhNk4bFIAW7P+OTmpe0itDcBZ6BbDmyKmfxxZKMV6M+sD9Cz84jsvGAhC0E2ztoTeUWITkSZGqSdQTlKPcXgOG5tPzQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHglkp/Oq6DGA44J/td23wvIjsPrB24GZrXMd/OE4Sc=;
 b=dM5ghV/NlecqJHvFVEYaOhWbTe2yna7gZHDMKdVTzkxMSdGpbOOq7mBszIs56kIPhGj9XFpiqx0nr7jhxVkqpUw+P9i4aDD9XC4Ld9Djwt0P7eyYR4XizljgGpeRzqrnni68L/hK/mzHpayR26qYjY0PiQN6IlsqV7a0o0gSYi4Wi4xr42YOARrX6Ws0LHq/tizBR0t6R0qgZPF7dUB8VkgT4nS86NuoHGUolMJxT36sqgz1Cv14KDp0CAPNe9PBSWtdEY3w2578FIbXqZbpRGrGY8/KpouuNpYly3rOr5L0d3YWSfMbm4h+pbD39j4vKUM+bedgf1lSbpWQDxecoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHglkp/Oq6DGA44J/td23wvIjsPrB24GZrXMd/OE4Sc=;
 b=aJuwuT9nMzs+LcmYN14JEtgaH15mvVUxPCQ1FhBtxek0Wxtu872ItAM5/OgFaJ4wdRb14x46btezO6NVIlP32djJgyUTEfQDZNcIkedgxZfsfC7KV474zBmMgHZ0VxKDrhmzwSqMqtZuOH3vtxvtu3iRZzwDlARX66/xqkl+fKdy5BRFqElAAyRLOP2vnzKJ6LC3mHN+EUnecyGgoz1Hswa7+Y5uEklGz2pvnhJ4Ln9OtwQcw1AlFWlTXovTScd1UnuXwGAaxTW2HZh83dEmZbCGrF46VN3BCWHPx1f+oDuHgyVco7/EP+EVPkc63lEQdPcuZSv5KBgIkMkEjApgAg==
Received: from BN6PR21CA0019.namprd21.prod.outlook.com (2603:10b6:404:8e::29)
 by BY5PR12MB3682.namprd12.prod.outlook.com (2603:10b6:a03:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 6 Nov
 2020 18:03:19 +0000
Received: from BN8NAM12FT018.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::f7) by BN6PR21CA0019.outlook.office365.com
 (2603:10b6:404:8e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6 via Frontend
 Transport; Fri, 6 Nov 2020 18:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 BN8NAM12FT018.mail.protection.outlook.com (10.13.183.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.7 via Frontend Transport; Fri, 6 Nov 2020 18:03:18 +0000
Received: from laplante-lm-19.localdomain (10.46.38.234) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.2044.4; Fri, 6 Nov 2020 11:02:14 -0700
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] main: group --help options to make them easier to read
Date: Fri, 6 Nov 2020 13:02:07 -0500
Message-ID: <20201106180207.87220-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 10.46.38.234 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd20919e-85ba-4bc3-08b0-08d8827e3e02
X-MS-TrafficTypeDiagnostic: BY5PR12MB3682:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR12MB3682BED3F86F74AF900150488BED0@BY5PR12MB3682.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	t50uKwZ3zjatZePDcZ2gne2Wmb0eaWbuiEgYX/NUGpakdlQHbZtCKDRUBwF6eVT4MPBmElz23Pq5oW2BobpKjBII3HnNCtljGzTHG6ZbmoxwzbcvQcMhW63WYVzg4GJ1f27ZrpspXlfj2OC9Nvz1riNzvli+XZqwYzzlovEIcbTaJ9O1XHxGyz92k45PBzYSce7QYfTp9ujQvEogwUQ5u/Hi/OwGUhLS6VSrZL+Vou1V2d/6HQzoFLuPIicH6NHlP58k0tyfOeBueIT7bhU2qAXvvHmqsjkMCpkeevv0+IHO+TssnYdTUu3nroQgDLaV8BAv8p8Kclpj+Y0AuESDXolXYdteSX/8qHYYDD9hnRMqV/R+FbXtAaudCAHWFj/u+kAswJQTES0ziytmxvP1LLvekIygbifQCcBsGqwswNg=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:cos.smtp.agilent.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(29502001)(46966005)(8936002)(316002)(82740400003)(5660300002)(7636003)(83380400001)(356005)(47076004)(6666004)(186003)(26005)(107886003)(82310400003)(30864003)(1076003)(44832011)(2616005)(6916009)(2906002)(86362001)(8676002)(426003)(70206006)(36906005)(4326008)(36756003)(336012)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 18:03:18.9146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd20919e-85ba-4bc3-08b0-08d8827e3e02
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN8NAM12FT018.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3682
Content-Type: text/plain

(YOCTO #12018)

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/main.py | 175 +++++++++++++++++++++++++++----------------------
 1 file changed, 95 insertions(+), 80 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 89d1a038..c53da851 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -127,28 +127,56 @@ def create_bitbake_parser():
     Executes the specified task (default is 'build') for a given set of target recipes (.bb files).
     It is assumed there is a conf/bblayers.conf available in cwd or in BBPATH which
     will provide the layer, BBFILES and other configuration information.
-    """)
+    """, add_help=False)
     parser.add_argument("targets", nargs="*")
-    parser.add_argument("--version",
-                        action="version",
-                        version="BitBake Build Tool Core version {0}".format(bb.__version__))
 
+    # List options that the user is most likely to use first
+    frequent_group = parser.add_argument_group("frequently used")
+    frequent_group.add_argument("-c", "--cmd", dest="cmd",
+                                help="Specify the task to execute. The exact options available "
+                                     "depend on the metadata. Some examples might be 'compile'"
+                                     " or 'populate_sysroot' or 'listtasks' may give a list of "
+                                     "the tasks available.")
+
+    frequent_group.add_argument("-k", "--continue", action="store_false", dest="abort",
+                                help="Continue as much as possible after an error. While the target that "
+                                     "failed and anything depending on it cannot be built, as much as "
+                                     "possible will be built before stopping.")
+
+    frequent_group.add_argument("-C", "--clear-stamp", dest="invalidate_stamp",
+                                help="Invalidate the stamp for the specified task such as 'compile' "
+                                     "and then run the default task for the specified target(s).")
+
+    frequent_group.add_argument("--runall", action="append", dest="runall", default=[],
+                                help="Run the specified task for any recipe in the taskgraph of the specified target (even if "
+                                     "it wouldn't otherwise have run).")
+
+    frequent_group.add_argument("--runonly", action="append", dest="runonly", default=[],
+                                help="Run only the specified task within the taskgraph of the specified targets (and any task "
+                                     "dependencies those tasks may have).")
+
+    frequent_group.add_argument("-f", "--force", action="store_true", dest="force",
+                            help="Force the specified targets/task to run (invalidating any "
+                                 "existing stamp file).")
+
+    # Options having to do with UI or verbosity/debug reporting
+    output_control_group = parser.add_argument_group("output control")
     ui_choices = LazyUiChoices()
     # Setting metavar="" is necessary otherwise argparse will immediately try to expand the choices
-    parser.add_argument("-u", "--ui",
+    output_control_group.add_argument("-u", "--ui",
                         default=os.environ.get('BITBAKE_UI', 'knotty'),
                         help="The user interface to use (%(choices)s) - default: %(default)s",
                         choices=ui_choices, metavar="", type=ui_choices)
 
-    parser.add_argument("-v", "--verbose", action="store_true", dest="verbose",
+    output_control_group.add_argument("-v", "--verbose", action="store_true", dest="verbose",
                       help="Enable tracing of shell tasks (with 'set -x'). "
                            "Also print bb.note(...) messages to stdout (in "
                            "addition to writing them to ${T}/log.do_<task>).")
 
-    parser.add_argument("-q", "--quiet", action="count", dest="quiet", default=0,
+    output_control_group.add_argument("-q", "--quiet", action="count", dest="quiet", default=0,
                       help="Output less log message data to the terminal. You can specify this more than once.")
 
-    parser.add_argument("-D", "--debug", action="count", dest="debug", default=0,
+    output_control_group.add_argument("-D", "--debug", action="count", dest="debug", default=0,
                       help="Increase the debug level. You can specify this "
                            "more than once. -D sets the debug level to 1, "
                            "where only bb.debug(1, ...) messages are printed "
@@ -160,125 +188,112 @@ def create_bitbake_parser():
                            "to ${T}/log.do_taskname, regardless of the debug "
                            "level.")
 
-    parser.add_argument("-b", "--buildfile", dest="buildfile",
-                      help="Execute tasks from a specific .bb recipe directly. WARNING: Does "
-                           "not handle any dependencies from other recipes.")
+    output_control_group.add_argument("-w", "--write-log", dest="writeeventlog", default=os.environ.get("BBEVENTLOG"),
+                        help="Writes the event log of the build to a bitbake event json file. "
+                             "Use '' (empty string) to assign the name automatically.")
 
-    parser.add_argument("-k", "--continue", action="store_false", dest="abort",
-                      help="Continue as much as possible after an error. While the target that "
-                           "failed and anything depending on it cannot be built, as much as "
-                           "possible will be built before stopping.")
+    output_control_group.add_argument("-l", "--log-domains", action="append", dest="debug_domains", default=[],
+                        help="Show debug logging for the specified logging domains")
 
-    parser.add_argument("-f", "--force", action="store_true", dest="force",
-                      help="Force the specified targets/task to run (invalidating any "
-                           "existing stamp file).")
+    # Debugging options
+    debugging_group = parser.add_argument_group("debugging and introspection")
+    debugging_group.add_argument("-e", "--environment", action="store_true", dest="show_environment",
+                                 help="Show the global or per-recipe environment complete with information"
+                                      " about where variables were set/changed.")
 
-    parser.add_argument("-c", "--cmd", dest="cmd",
-                      help="Specify the task to execute. The exact options available "
-                           "depend on the metadata. Some examples might be 'compile'"
-                           " or 'populate_sysroot' or 'listtasks' may give a list of "
-                           "the tasks available.")
-
-    parser.add_argument("-C", "--clear-stamp", dest="invalidate_stamp",
-                      help="Invalidate the stamp for the specified task such as 'compile' "
-                           "and then run the default task for the specified target(s).")
-
-    parser.add_argument("-r", "--read", action="append", dest="prefile", default=[],
-                      help="Read the specified file before bitbake.conf.")
-
-    parser.add_argument("-R", "--postread", action="append", dest="postfile", default=[],
-                      help="Read the specified file after bitbake.conf.")
-
-    parser.add_argument("-n", "--dry-run", action="store_true", dest="dry_run", default=[],
+    debugging_group.add_argument("-n", "--dry-run", action="store_true", dest="dry_run", default=[],
                       help="Don't execute, just go through the motions.")
 
-    parser.add_argument("-S", "--dump-signatures", action="append", dest="dump_signatures", metavar="SIGNATURE_HANDLER",
+    debugging_group.add_argument("-S", "--dump-signatures", action="append", dest="dump_signatures", metavar="SIGNATURE_HANDLER",
                         default=[], help="Dump out the signature construction information, with no task "
                            "execution. The SIGNATURE_HANDLER parameter is passed to the "
                            "handler. Two common values are none and printdiff but the handler "
                            "may define more/less. none means only dump the signature, printdiff"
                            " means compare the dumped signature with the cached one.")
 
-    parser.add_argument("-p", "--parse-only", action="store_true", dest="parse_only",
+    debugging_group.add_argument("-p", "--parse-only", action="store_true", dest="parse_only",
                       help="Quit after parsing the BB recipes.")
 
-    parser.add_argument("-s", "--show-versions", action="store_true", dest="show_versions",
+    debugging_group.add_argument("-s", "--show-versions", action="store_true", dest="show_versions",
                       help="Show current and preferred versions of all recipes.")
 
-    parser.add_argument("-e", "--environment", action="store_true", dest="show_environment",
-                      help="Show the global or per-recipe environment complete with information"
-                           " about where variables were set/changed.")
-
-    parser.add_argument("-g", "--graphviz", action="store_true", dest="dot_graph",
+    debugging_group.add_argument("-g", "--graphviz", action="store_true", dest="dot_graph",
                       help="Save dependency tree information for the specified "
                            "targets in the dot syntax.")
 
-    parser.add_argument("-I", "--ignore-deps", action="append", default=[], dest="extra_assume_provided",
+    debugging_group.add_argument("--revisions-changed", action="store_true", dest="revisions_changed",
+                        help="Set the exit code depending on whether upstream floating "
+                             "revisions have changed or not.")
+
+    debugging_group.add_argument("-P", "--profile", action="store_true", dest="profile", default=[],
+                                              help="Profile the command and save reports.")
+
+    # Developer options that aren't commonly used by normal users
+    developer_group = parser.add_argument_group("developer")
+    developer_group.add_argument("-r", "--read", action="append", dest="prefile", default=[],
+                                   help="Read the specified file before bitbake.conf.")
+
+    developer_group.add_argument("-R", "--postread", action="append", dest="postfile", default=[],
+                                   help="Read the specified file after bitbake.conf.")
+
+    developer_group.add_argument("-I", "--ignore-deps", action="append", default=[], dest="extra_assume_provided",
                       help="Assume these dependencies don't exist and are already provided "
                            "(equivalent to ASSUME_PROVIDED). Useful to make dependency "
                            "graphs more appealing")
 
-    parser.add_argument("-l", "--log-domains", action="append", dest="debug_domains", default=[],
-                      help="Show debug logging for the specified logging domains")
+    developer_group.add_argument("--no-setscene", action="store_true", dest="nosetscene",
+                        help="Do not run any setscene tasks. sstate will be ignored and "
+                             "everything needed, built.")
 
-    parser.add_argument("-P", "--profile", action="store_true", dest="profile", default=[],
-                      help="Profile the command and save reports.")
+    developer_group.add_argument("--skip-setscene", action="store_true", dest="skipsetscene",
+                        help="Skip setscene tasks if they would be executed. Tasks previously "
+                             "restored from sstate will be kept, unlike --no-setscene")
 
-    parser.add_argument("--token", dest="xmlrpctoken", default=os.environ.get("BBTOKEN"),
+    developer_group.add_argument("--setscene-only", action="store_true", dest="setsceneonly",
+                        help="Only run setscene tasks, don't run any real tasks.")
+
+    developer_group.add_argument("-b", "--buildfile", dest="buildfile",
+                               help="Execute tasks from a specific .bb recipe directly. WARNING: Does "
+                                    "not handle any dependencies from other recipes.")
+    # Server control options
+    server_control_group = parser.add_argument_group("server control")
+    server_control_group.add_argument("--token", dest="xmlrpctoken", default=os.environ.get("BBTOKEN"),
                       help="Specify the connection token to be used when connecting "
                            "to a remote server.")
 
-    parser.add_argument("--revisions-changed", action="store_true", dest="revisions_changed",
-                      help="Set the exit code depending on whether upstream floating "
-                           "revisions have changed or not.")
-
-    parser.add_argument("--server-only", action="store_true", dest="server_only",
+    server_control_group.add_argument("--server-only", action="store_true", dest="server_only",
                       help="Run bitbake without a UI, only starting a server "
                            "(cooker) process.")
 
-    parser.add_argument("-B", "--bind", dest="bind",
+    server_control_group.add_argument("-B", "--bind", dest="bind",
                       help="The name/address for the bitbake xmlrpc server to bind to.")
 
-    parser.add_argument("-T", "--idle-timeout", type=float, dest="server_timeout",
+    server_control_group.add_argument("-T", "--idle-timeout", type=float, dest="server_timeout",
                       default=os.getenv("BB_SERVER_TIMEOUT"),
                       help="Set timeout to unload bitbake server due to inactivity, "
                            "set to -1 means no unload, "
                            "default: Environment variable BB_SERVER_TIMEOUT.")
 
-    parser.add_argument("--no-setscene", action="store_true", dest="nosetscene",
-                      help="Do not run any setscene tasks. sstate will be ignored and "
-                           "everything needed, built.")
-
-    parser.add_argument("--skip-setscene", action="store_true", dest="skipsetscene",
-                      help="Skip setscene tasks if they would be executed. Tasks previously "
-                           "restored from sstate will be kept, unlike --no-setscene")
-
-    parser.add_argument("--setscene-only", action="store_true", dest="setsceneonly",
-                      help="Only run setscene tasks, don't run any real tasks.")
-
-    parser.add_argument("--remote-server", dest="remote_server", default=os.environ.get("BBSERVER"),
+    server_control_group.add_argument("--remote-server", dest="remote_server", default=os.environ.get("BBSERVER"),
                       help="Connect to the specified server.")
 
-    parser.add_argument("-m", "--kill-server", action="store_true", dest="kill_server",
+    server_control_group.add_argument("-m", "--kill-server", action="store_true", dest="kill_server",
                       help="Terminate any running bitbake server.")
 
-    parser.add_argument("--observe-only", action="store_true", dest="observe_only",
+    server_control_group.add_argument("--observe-only", action="store_true", dest="observe_only",
                       help="Connect to a server as an observing-only client.")
 
-    parser.add_argument("--status-only", action="store_true", dest="status_only",
+    server_control_group.add_argument("--status-only", action="store_true", dest="status_only",
                       help="Check the status of the remote bitbake server.")
 
-    parser.add_argument("-w", "--write-log", dest="writeeventlog", default=os.environ.get("BBEVENTLOG"),
-                      help="Writes the event log of the build to a bitbake event json file. "
-                           "Use '' (empty string) to assign the name automatically.")
+    # Options that don't really fit elsewhere
+    other_options = parser.add_argument_group("other")
+    other_options.add_argument("--version",
+                    action="version",
+                    version="BitBake Build Tool Core version {0}".format(bb.__version__))
 
-    parser.add_argument("--runall", action="append", dest="runall", default=[],
-                      help="Run the specified task for any recipe in the taskgraph of the specified target (even if "
-                           "it wouldn't otherwise have run).")
+    other_options.add_argument("-h", "--help", action="help", help="show this help message and exit")
 
-    parser.add_argument("--runonly", action="append", dest="runonly", default=[],
-                      help="Run only the specified task within the taskgraph of the specified targets (and any task "
-                           "dependencies those tasks may have).")
     return parser
 
 
-- 
2.17.1

