Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.66])
 by mx.groups.io with SMTP id smtpd.web11.12490.1604673322050300481
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Nov 2020 06:35:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=Jj0Frt5E;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.93.66, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URsVs74PkLT2A0SlEEmA3PBHIeLoyJUrWe9anLJ/CUeX1zh/jp3+0ZbKCHKamkdAdv+HH1sdbQEbYhhXO7Njw4aeG2joEDM6qlm2nuJMlvzrXNOrURFvB/42EQsBizLRRXbVOYJb6TOvk5DCtM2k9qtIlaxBpsYgDY1PHWEp27YZtG9fRtWRZC7bz6zEV0wB6gpxBNE+Ous8uxT41MFh6ybMmKcG/H5vvhw9Ayl4lgtvd2+9kweXhpsQvxqveNe5gEnnFr+aTRFLFOhipFD8JLQ6pt7iEqhySZwS+wGugvPiIjcNx1y8U3kVOhoCDvTFoosYE0xBWCgnOMRpqzwE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N20bhvpe2suenbSPY419OY5MlWa8evLB7ap4xgNjQNE=;
 b=eC53XqZe9hWxucPaKjYGYImyeorsdNTekwWbFL1yKoyv27YbvLpApBU4RXLdp0hG+nMvqQrcokbWbwhx8X0g8fjMVvzdOBugTXo+Y8cc9gZcu3M069tyBG94mKMcvhfZpaK4BQdYZzpuLBzOTLadhhIYXzATAwQztgDrTw/p9g4LJ54lLt54DzLs/lLkYYgfoTsHEyyS4/C6TLZHHlJ9dgTEXyyg7tjDKtxHfTRXqM0DRT9Zt21Wq2zkK27KgS5xuyWyCekxKVvbLnMmspu/dCsJC05ZKvAOj2St427E2E5+aDZk1ZEfLj4i2DDFJPZaffC/BrRLObakedSZyCBeag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N20bhvpe2suenbSPY419OY5MlWa8evLB7ap4xgNjQNE=;
 b=Jj0Frt5EmFl5eNDYp6X5cuA1Tbt+8fru3FLyyhYIs7LJH6qOZH4EMZgZgTtFBd/CQnRx+Zz7WBlOxNEj1ZQAq341d4h/C4az9Uac0asqbUVQQwF0Tlo5RE/Smtr5qq2XdHCLbDBN7p/bSEnwtwwIqpaPOYkSXFcYHOCLDMRt8c680xKYtEcE14VaAoNQ2m9LnJlwCptVI0tfnltqp5S1/pYoFNpq9LcL1F6tl7q7WLw3e6Cm9VbRhFQLpF9THD3KdrgmUMeULqe/r3bcbmj7ygi/Zyy8f8i8/nB/hAL8A60MalJTrSqq83Mzxe/jIfLQwLEoJ0p0z0v3tD9uwlSjyQ==
Received: from BN8PR15CA0023.namprd15.prod.outlook.com (2603:10b6:408:c0::36)
 by BYAPR12MB3461.namprd12.prod.outlook.com (2603:10b6:a03:da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 14:35:18 +0000
Received: from BN8NAM12FT065.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::d2) by BN8PR15CA0023.outlook.office365.com
 (2603:10b6:408:c0::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Fri, 6 Nov 2020 14:35:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.37)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.37 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.37; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.37) by
 BN8NAM12FT065.mail.protection.outlook.com (10.13.182.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.7 via Frontend Transport; Fri, 6 Nov 2020 14:35:17 +0000
Received: from laplante-lm-19.localdomain (10.46.38.234) by
 edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server id
 15.1.2044.4; Fri, 6 Nov 2020 07:34:44 -0700
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 1/3] main: extract creation of argument parser into function so it can be utilized externally, e.g. by unit tests
Date: Fri, 6 Nov 2020 09:34:55 -0500
Message-ID: <20201106143457.81958-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg1.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 10.46.38.234 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a97af33-864c-4bf6-3cb3-08d882612eb7
X-MS-TrafficTypeDiagnostic: BYAPR12MB3461:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR12MB3461C78239473697976FD8F98BED0@BYAPR12MB3461.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gUN/fj8Wl2DUg3H4yX/xFv8fhLjjFxm7bJDvTWe67CQaGBpMfQmhsYkv4ZbdkrhmBp72sfjIiLepUUo63kCz3u3u/9GZ/1/GkSgwkwnqC1iYJam92A6Yqh76Lr6cbRIvL3mCXfc8J0FxzNA5+N7mixUfPqRszz3ckO26XZv6UzuhtI/FG9OId9FUn57YgnfJ2bRhCyf6o2pHOcf2WHroZDmXeVRsOwHDF4iGP02jkk+A7v3tdd2w5tO4w/AabbJ8yvaq9fI6JeGN0VRAYZix+xi62iISDIqqyIrhm6+Up8hBp+B54S+od/IMx/CRxEkd+va9RSEyHcNuAn12CR0G3F31JhrZh4XbJn4rmliG1OMVy1MTDa26k3s7eAJk/udUgA8EamLUHvhFNv7e7Ad4EFUM807dkf2W7c0HJXgZD0c=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.37;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:cos.smtp.agilent.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(29502001)(46966005)(8936002)(426003)(26005)(316002)(478600001)(1076003)(6666004)(86362001)(2616005)(6916009)(336012)(5660300002)(30864003)(8676002)(44832011)(4326008)(7636003)(82740400003)(356005)(47076004)(107886003)(82310400003)(2906002)(70206006)(36756003)(83380400001)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 14:35:17.8755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a97af33-864c-4bf6-3cb3-08d882612eb7
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.37];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN8NAM12FT065.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3461
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/main.py | 333 +++++++++++++++++++++++++------------------------
 1 file changed, 168 insertions(+), 165 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index e92e409f..06bad495 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -119,178 +119,181 @@ warnings.filterwarnings("ignore", category=ImportWarning)
 warnings.filterwarnings("ignore", category=DeprecationWarning, module="<string>$")
 warnings.filterwarnings("ignore", message="With-statements now directly support multiple context managers")
 
-class BitBakeConfigParameters(cookerdata.ConfigParameters):
 
-    def parseCommandLine(self, argv=sys.argv):
-        parser = optparse.OptionParser(
-            formatter=BitbakeHelpFormatter(),
-            version="BitBake Build Tool Core version %s" % bb.__version__,
-            usage="""%prog [options] [recipename/target recipe:do_task ...]
+def create_bitbake_parser():
+    parser = optparse.OptionParser(
+        formatter=BitbakeHelpFormatter(),
+        version="BitBake Build Tool Core version %s" % bb.__version__,
+        usage="""%prog [options] [recipename/target recipe:do_task ...]
 
     Executes the specified task (default is 'build') for a given set of target recipes (.bb files).
     It is assumed there is a conf/bblayers.conf available in cwd or in BBPATH which
     will provide the layer, BBFILES and other configuration information.""")
 
-        parser.add_option("-b", "--buildfile", action="store", dest="buildfile", default=None,
-                          help="Execute tasks from a specific .bb recipe directly. WARNING: Does "
-                               "not handle any dependencies from other recipes.")
-
-        parser.add_option("-k", "--continue", action="store_false", dest="abort", default=True,
-                          help="Continue as much as possible after an error. While the target that "
-                               "failed and anything depending on it cannot be built, as much as "
-                               "possible will be built before stopping.")
-
-        parser.add_option("-f", "--force", action="store_true", dest="force", default=False,
-                          help="Force the specified targets/task to run (invalidating any "
-                               "existing stamp file).")
-
-        parser.add_option("-c", "--cmd", action="store", dest="cmd",
-                          help="Specify the task to execute. The exact options available "
-                               "depend on the metadata. Some examples might be 'compile'"
-                               " or 'populate_sysroot' or 'listtasks' may give a list of "
-                               "the tasks available.")
-
-        parser.add_option("-C", "--clear-stamp", action="store", dest="invalidate_stamp",
-                          help="Invalidate the stamp for the specified task such as 'compile' "
-                               "and then run the default task for the specified target(s).")
-
-        parser.add_option("-r", "--read", action="append", dest="prefile", default=[],
-                          help="Read the specified file before bitbake.conf.")
-
-        parser.add_option("-R", "--postread", action="append", dest="postfile", default=[],
-                          help="Read the specified file after bitbake.conf.")
-
-        parser.add_option("-v", "--verbose", action="store_true", dest="verbose", default=False,
-                          help="Enable tracing of shell tasks (with 'set -x'). "
-                               "Also print bb.note(...) messages to stdout (in "
-                               "addition to writing them to ${T}/log.do_<task>).")
-
-        parser.add_option("-D", "--debug", action="count", dest="debug", default=0,
-                          help="Increase the debug level. You can specify this "
-                               "more than once. -D sets the debug level to 1, "
-                               "where only bb.debug(1, ...) messages are printed "
-                               "to stdout; -DD sets the debug level to 2, where "
-                               "both bb.debug(1, ...) and bb.debug(2, ...) "
-                               "messages are printed; etc. Without -D, no debug "
-                               "messages are printed. Note that -D only affects "
-                               "output to stdout. All debug messages are written "
-                               "to ${T}/log.do_taskname, regardless of the debug "
-                               "level.")
-
-        parser.add_option("-q", "--quiet", action="count", dest="quiet", default=0,
-                          help="Output less log message data to the terminal. You can specify this more than once.")
-
-        parser.add_option("-n", "--dry-run", action="store_true", dest="dry_run", default=False,
-                          help="Don't execute, just go through the motions.")
-
-        parser.add_option("-S", "--dump-signatures", action="append", dest="dump_signatures",
-                          default=[], metavar="SIGNATURE_HANDLER",
-                          help="Dump out the signature construction information, with no task "
-                               "execution. The SIGNATURE_HANDLER parameter is passed to the "
-                               "handler. Two common values are none and printdiff but the handler "
-                               "may define more/less. none means only dump the signature, printdiff"
-                               " means compare the dumped signature with the cached one.")
-
-        parser.add_option("-p", "--parse-only", action="store_true",
-                          dest="parse_only", default=False,
-                          help="Quit after parsing the BB recipes.")
-
-        parser.add_option("-s", "--show-versions", action="store_true",
-                          dest="show_versions", default=False,
-                          help="Show current and preferred versions of all recipes.")
-
-        parser.add_option("-e", "--environment", action="store_true",
-                          dest="show_environment", default=False,
-                          help="Show the global or per-recipe environment complete with information"
-                               " about where variables were set/changed.")
-
-        parser.add_option("-g", "--graphviz", action="store_true", dest="dot_graph", default=False,
-                          help="Save dependency tree information for the specified "
-                               "targets in the dot syntax.")
-
-        parser.add_option("-I", "--ignore-deps", action="append",
-                          dest="extra_assume_provided", default=[],
-                          help="Assume these dependencies don't exist and are already provided "
-                               "(equivalent to ASSUME_PROVIDED). Useful to make dependency "
-                               "graphs more appealing")
-
-        parser.add_option("-l", "--log-domains", action="append", dest="debug_domains", default=[],
-                          help="Show debug logging for the specified logging domains")
-
-        parser.add_option("-P", "--profile", action="store_true", dest="profile", default=False,
-                          help="Profile the command and save reports.")
-
-        # @CHOICES@ is substituted out by BitbakeHelpFormatter above
-        parser.add_option("-u", "--ui", action="store", dest="ui",
-                          default=os.environ.get('BITBAKE_UI', 'knotty'),
-                          help="The user interface to use (@CHOICES@ - default %default).")
-
-        parser.add_option("", "--token", action="store", dest="xmlrpctoken",
-                          default=os.environ.get("BBTOKEN"),
-                          help="Specify the connection token to be used when connecting "
-                               "to a remote server.")
-
-        parser.add_option("", "--revisions-changed", action="store_true",
-                          dest="revisions_changed", default=False,
-                          help="Set the exit code depending on whether upstream floating "
-                               "revisions have changed or not.")
-
-        parser.add_option("", "--server-only", action="store_true",
-                          dest="server_only", default=False,
-                          help="Run bitbake without a UI, only starting a server "
-                               "(cooker) process.")
-
-        parser.add_option("-B", "--bind", action="store", dest="bind", default=False,
-                          help="The name/address for the bitbake xmlrpc server to bind to.")
-
-        parser.add_option("-T", "--idle-timeout", type=float, dest="server_timeout",
-                          default=os.getenv("BB_SERVER_TIMEOUT"),
-                          help="Set timeout to unload bitbake server due to inactivity, "
-                                "set to -1 means no unload, "
-                                "default: Environment variable BB_SERVER_TIMEOUT.")
-
-        parser.add_option("", "--no-setscene", action="store_true",
-                          dest="nosetscene", default=False,
-                          help="Do not run any setscene tasks. sstate will be ignored and "
-                               "everything needed, built.")
-
-        parser.add_option("", "--skip-setscene", action="store_true",
-                          dest="skipsetscene", default=False,
-                          help="Skip setscene tasks if they would be executed. Tasks previously "
-                               "restored from sstate will be kept, unlike --no-setscene")
-
-        parser.add_option("", "--setscene-only", action="store_true",
-                          dest="setsceneonly", default=False,
-                          help="Only run setscene tasks, don't run any real tasks.")
-
-        parser.add_option("", "--remote-server", action="store", dest="remote_server",
-                          default=os.environ.get("BBSERVER"),
-                          help="Connect to the specified server.")
-
-        parser.add_option("-m", "--kill-server", action="store_true",
-                          dest="kill_server", default=False,
-                          help="Terminate any running bitbake server.")
-
-        parser.add_option("", "--observe-only", action="store_true",
-                          dest="observe_only", default=False,
-                          help="Connect to a server as an observing-only client.")
-
-        parser.add_option("", "--status-only", action="store_true",
-                          dest="status_only", default=False,
-                          help="Check the status of the remote bitbake server.")
-
-        parser.add_option("-w", "--write-log", action="store", dest="writeeventlog",
-                          default=os.environ.get("BBEVENTLOG"),
-                          help="Writes the event log of the build to a bitbake event json file. "
-                               "Use '' (empty string) to assign the name automatically.")
-
-        parser.add_option("", "--runall", action="append", dest="runall",
-                          help="Run the specified task for any recipe in the taskgraph of the specified target (even if it wouldn't otherwise have run).")
-
-        parser.add_option("", "--runonly", action="append", dest="runonly",
-                          help="Run only the specified task within the taskgraph of the specified targets (and any task dependencies those tasks may have).")
+    parser.add_option("-b", "--buildfile", action="store", dest="buildfile", default=None,
+                      help="Execute tasks from a specific .bb recipe directly. WARNING: Does "
+                           "not handle any dependencies from other recipes.")
+
+    parser.add_option("-k", "--continue", action="store_false", dest="abort", default=True,
+                      help="Continue as much as possible after an error. While the target that "
+                           "failed and anything depending on it cannot be built, as much as "
+                           "possible will be built before stopping.")
+
+    parser.add_option("-f", "--force", action="store_true", dest="force", default=False,
+                      help="Force the specified targets/task to run (invalidating any "
+                           "existing stamp file).")
+
+    parser.add_option("-c", "--cmd", action="store", dest="cmd",
+                      help="Specify the task to execute. The exact options available "
+                           "depend on the metadata. Some examples might be 'compile'"
+                           " or 'populate_sysroot' or 'listtasks' may give a list of "
+                           "the tasks available.")
+
+    parser.add_option("-C", "--clear-stamp", action="store", dest="invalidate_stamp",
+                      help="Invalidate the stamp for the specified task such as 'compile' "
+                           "and then run the default task for the specified target(s).")
+
+    parser.add_option("-r", "--read", action="append", dest="prefile", default=[],
+                      help="Read the specified file before bitbake.conf.")
+
+    parser.add_option("-R", "--postread", action="append", dest="postfile", default=[],
+                      help="Read the specified file after bitbake.conf.")
+
+    parser.add_option("-v", "--verbose", action="store_true", dest="verbose", default=False,
+                      help="Enable tracing of shell tasks (with 'set -x'). "
+                           "Also print bb.note(...) messages to stdout (in "
+                           "addition to writing them to ${T}/log.do_<task>).")
+
+    parser.add_option("-D", "--debug", action="count", dest="debug", default=0,
+                      help="Increase the debug level. You can specify this "
+                           "more than once. -D sets the debug level to 1, "
+                           "where only bb.debug(1, ...) messages are printed "
+                           "to stdout; -DD sets the debug level to 2, where "
+                           "both bb.debug(1, ...) and bb.debug(2, ...) "
+                           "messages are printed; etc. Without -D, no debug "
+                           "messages are printed. Note that -D only affects "
+                           "output to stdout. All debug messages are written "
+                           "to ${T}/log.do_taskname, regardless of the debug "
+                           "level.")
+
+    parser.add_option("-q", "--quiet", action="count", dest="quiet", default=0,
+                      help="Output less log message data to the terminal. You can specify this more than once.")
+
+    parser.add_option("-n", "--dry-run", action="store_true", dest="dry_run", default=False,
+                      help="Don't execute, just go through the motions.")
+
+    parser.add_option("-S", "--dump-signatures", action="append", dest="dump_signatures",
+                      default=[], metavar="SIGNATURE_HANDLER",
+                      help="Dump out the signature construction information, with no task "
+                           "execution. The SIGNATURE_HANDLER parameter is passed to the "
+                           "handler. Two common values are none and printdiff but the handler "
+                           "may define more/less. none means only dump the signature, printdiff"
+                           " means compare the dumped signature with the cached one.")
+
+    parser.add_option("-p", "--parse-only", action="store_true",
+                      dest="parse_only", default=False,
+                      help="Quit after parsing the BB recipes.")
+
+    parser.add_option("-s", "--show-versions", action="store_true",
+                      dest="show_versions", default=False,
+                      help="Show current and preferred versions of all recipes.")
+
+    parser.add_option("-e", "--environment", action="store_true",
+                      dest="show_environment", default=False,
+                      help="Show the global or per-recipe environment complete with information"
+                           " about where variables were set/changed.")
+
+    parser.add_option("-g", "--graphviz", action="store_true", dest="dot_graph", default=False,
+                      help="Save dependency tree information for the specified "
+                           "targets in the dot syntax.")
+
+    parser.add_option("-I", "--ignore-deps", action="append",
+                      dest="extra_assume_provided", default=[],
+                      help="Assume these dependencies don't exist and are already provided "
+                           "(equivalent to ASSUME_PROVIDED). Useful to make dependency "
+                           "graphs more appealing")
+
+    parser.add_option("-l", "--log-domains", action="append", dest="debug_domains", default=[],
+                      help="Show debug logging for the specified logging domains")
+
+    parser.add_option("-P", "--profile", action="store_true", dest="profile", default=False,
+                      help="Profile the command and save reports.")
+
+    # @CHOICES@ is substituted out by BitbakeHelpFormatter above
+    parser.add_option("-u", "--ui", action="store", dest="ui",
+                      default=os.environ.get('BITBAKE_UI', 'knotty'),
+                      help="The user interface to use (@CHOICES@ - default %default).")
+
+    parser.add_option("", "--token", action="store", dest="xmlrpctoken",
+                      default=os.environ.get("BBTOKEN"),
+                      help="Specify the connection token to be used when connecting "
+                           "to a remote server.")
+
+    parser.add_option("", "--revisions-changed", action="store_true",
+                      dest="revisions_changed", default=False,
+                      help="Set the exit code depending on whether upstream floating "
+                           "revisions have changed or not.")
+
+    parser.add_option("", "--server-only", action="store_true",
+                      dest="server_only", default=False,
+                      help="Run bitbake without a UI, only starting a server "
+                           "(cooker) process.")
+
+    parser.add_option("-B", "--bind", action="store", dest="bind", default=False,
+                      help="The name/address for the bitbake xmlrpc server to bind to.")
+
+    parser.add_option("-T", "--idle-timeout", type=float, dest="server_timeout",
+                      default=os.getenv("BB_SERVER_TIMEOUT"),
+                      help="Set timeout to unload bitbake server due to inactivity, "
+                           "set to -1 means no unload, "
+                           "default: Environment variable BB_SERVER_TIMEOUT.")
+
+    parser.add_option("", "--no-setscene", action="store_true",
+                      dest="nosetscene", default=False,
+                      help="Do not run any setscene tasks. sstate will be ignored and "
+                           "everything needed, built.")
+
+    parser.add_option("", "--skip-setscene", action="store_true",
+                      dest="skipsetscene", default=False,
+                      help="Skip setscene tasks if they would be executed. Tasks previously "
+                           "restored from sstate will be kept, unlike --no-setscene")
+
+    parser.add_option("", "--setscene-only", action="store_true",
+                      dest="setsceneonly", default=False,
+                      help="Only run setscene tasks, don't run any real tasks.")
+
+    parser.add_option("", "--remote-server", action="store", dest="remote_server",
+                      default=os.environ.get("BBSERVER"),
+                      help="Connect to the specified server.")
+
+    parser.add_option("-m", "--kill-server", action="store_true",
+                      dest="kill_server", default=False,
+                      help="Terminate any running bitbake server.")
+
+    parser.add_option("", "--observe-only", action="store_true",
+                      dest="observe_only", default=False,
+                      help="Connect to a server as an observing-only client.")
+
+    parser.add_option("", "--status-only", action="store_true",
+                      dest="status_only", default=False,
+                      help="Check the status of the remote bitbake server.")
+
+    parser.add_option("-w", "--write-log", action="store", dest="writeeventlog",
+                      default=os.environ.get("BBEVENTLOG"),
+                      help="Writes the event log of the build to a bitbake event json file. "
+                           "Use '' (empty string) to assign the name automatically.")
+
+    parser.add_option("", "--runall", action="append", dest="runall",
+                      help="Run the specified task for any recipe in the taskgraph of the specified target (even if it wouldn't otherwise have run).")
+
+    parser.add_option("", "--runonly", action="append", dest="runonly",
+                      help="Run only the specified task within the taskgraph of the specified targets (and any task dependencies those tasks may have).")
+    return parser
 
 
+class BitBakeConfigParameters(cookerdata.ConfigParameters):
+    def parseCommandLine(self, argv=sys.argv):
+        parser = create_bitbake_parser()
         options, targets = parser.parse_args(argv)
 
         if options.quiet and options.verbose:
@@ -466,7 +469,7 @@ def setup_bitbake(configParams, extrafeatures=None):
                     logger.info("Retrying server connection (#%d)..." % tryno)
                 else:
                     logger.info("Retrying server connection (#%d)... (%s)" % (tryno, traceback.format_exc()))
-                
+
             if not retries:
                 bb.fatal("Unable to connect to bitbake server, or start one (server startup failures would be in bitbake-cookerdaemon.log).")
             bb.event.print_ui_queue()
-- 
2.17.1

