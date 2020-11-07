Received: from NAM02-SN1-obe.outbound.protection.outlook.com (NAM02-SN1-obe.outbound.protection.outlook.com [40.107.77.47])
 by mx.groups.io with SMTP id smtpd.web08.6723.1604715676230790330
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Nov 2020 18:21:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=kUqf9Ut8;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.77.47, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c92GhTJlEGuUj3hc3mkggELufh5gPO9NqgLmwJM+xgEGQKjS374Eoojxgtcx8IdQr8TUUBxlVUOQ4a12mXhQMA/kHMIo779XQRXIIZUT9/uJ/CfRNQQ4dLRKYXJOgsUA6YGxPjOW7cvEp1TYb2tv0bMwT2OzmkFrD7UC32sHq95l6iR3SY3E1MNYiWz+8nvpnw1bqvAUqqQxAZqcMY1XDmZdoRuy0tRfXM6+wc4FbUOQO+V9RGoyZ988xGqKj4VtnOmNV+zZp2/imv32dSioowWepm+70uen19c3+G7H8p2ZEvygqHtu2i4T6Tpw2mwI9Xw7zp1RYXAWFsqWRNqgyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBwGrb4JRrIptLVNUTuiqXPqkI8K/jaV0n+c/8dOTmw=;
 b=euGK/azenqdcSdFx9pqy1z9EahroEqNGZjdfVJbtRR9oOobdTcC7hs27Mt2pQG5tgpxyPQtOzprxvb2qvQammJezptNLZma1ZWI+kyV9cDMBIOb2PnWqVxkEvIodMakaoK4ogBkesk5DkrGC16tk8Zzr8Tw++iJSTrtYZipUDfNLp0uMOa6eHIJtCVijyzOczKciIyqQlfSsQzqpHX7W6oFBIsFNjXScAqFkPQkouKYQ2rClyfW2tNrijRfIEApwts2Pof/a8ykzgVJDLUu8hS/um2n/dOIt0+lqA/+Encf56NBo2HaoHKzuuydvZdJvoNSYt7xUniBwBbVorEa+SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBwGrb4JRrIptLVNUTuiqXPqkI8K/jaV0n+c/8dOTmw=;
 b=kUqf9Ut8ePIshLHffVBDfRYTPPRyj6idQ4fVjzYc9/MEss7hrrwJEyNyjEbyaqCFpaBwz+PLu9l2q7DapfLyRqN0W6ca5oxo48U289mSgiOilUviaOq8+p+IDwhV9MJ3AF+Eq1NKe0KMnnagRGSMapL+vlyonuKoEi6dl/32baTWelAYxwjHXia7owkGMmb5gdqAMw7M0mD5YtmTkMUnyEITTUB9Jx7FmDtstspnbLXb1axdWpkNEabjyeNEghoLKzfVjodGzb4GaweWbbSGxfIdHv1f3BMPNJ7FJGOUa7CDSxpIDXj2C037g0Bs7CBTbAY9OfQzW8HPVhLZnxr2WA==
Received: from DM5PR15CA0050.namprd15.prod.outlook.com (2603:10b6:3:ae::12) by
 BN8PR12MB3217.namprd12.prod.outlook.com (2603:10b6:408:6e::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.29; Sat, 7 Nov 2020 02:21:14 +0000
Received: from DM6NAM12FT044.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::26) by DM5PR15CA0050.outlook.office365.com
 (2603:10b6:3:ae::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Sat, 7 Nov 2020 02:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 DM6NAM12FT044.mail.protection.outlook.com (10.13.178.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.7 via Frontend Transport; Sat, 7 Nov 2020 02:21:14 +0000
Received: from laplante-lm-19.localdomain (10.46.38.234) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.2044.4; Fri, 6 Nov 2020 19:21:11 -0700
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
Subject: [PATCH v2 1/5] main: migrate from optparse to argparse
Date: Fri, 6 Nov 2020 21:21:02 -0500
Message-ID: <20201107022106.84056-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201107022106.84056-1-chris.laplante@agilent.com>
References: <20201107022106.84056-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 10.46.38.234 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59d1cfd5-8e7a-4116-2440-08d882c3cd3b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BN8PR12MB3217BA06DE0D4D1E714550838BEC0@BN8PR12MB3217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EpkW7xHRrOohZxQApk2wy8Jp3c4+4ytL4SwTCKxnKiPUdztyo+teKy5hUMIpSvgl0P89WG5txHxFMO/FkzXF8euEnuW+Pg9dH4fr2a2hzOO3LT6uDofPNfwbc637FstZY2QXJ5gWStNCMzLlzUcyoPtVRWl4/dXHIZl5g/tKBQ1h29Sn4Ie97mso1sE8r/3gACvUp4e0Xsr8VO9QnkTj07526VoWZS3Km1ZmWhPt6sd1cFj6CduOFkNlLRx4g6TRK+NGhRLeqoeAcC7+M+Y5z/Lbai+rSBTh4iVsENfAGMMuNPGzm02Y7Yi2+tiTZvAm0ODEt+ay/5KK/RBOwe9e7qpGEj2kpg7MO00n1mMN0jPbv63zugzuzU22J5U25qv7zwh9+TDkZMUgdWNZoiV4pozeaRs6JXt0tQXukuP7sbvFPY0NnfzYJi9vrnoYkeeCT3VxVWeUFvOZ11NUGVMMZPaKUUm3QYHB5fZHlW92DguqaonOSlY1X8uUvmpm7Mei
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(29502001)(46966005)(356005)(82740400003)(82310400003)(6916009)(478600001)(2616005)(5660300002)(70206006)(83380400001)(186003)(86362001)(966005)(44832011)(47076004)(6666004)(36756003)(426003)(1076003)(8676002)(8936002)(316002)(54906003)(30864003)(2906002)(26005)(336012)(7636003)(36906005)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2020 02:21:14.5384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d1cfd5-8e7a-4116-2440-08d882c3cd3b
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT044.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3217
Content-Type: text/plain

Modernizes the argument parsing code and opens the door to grouping
the options (e.g. YOCTO #12018).

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/main.py | 264 ++++++++++++++++++++++++-------------------------
 1 file changed, 127 insertions(+), 137 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 06bad495..89d1a038 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -12,10 +12,10 @@
 import os
 import sys
 import logging
-import optparse
 import warnings
 import fcntl
 import time
+import argparse
 import traceback
 
 import bb
@@ -31,30 +31,14 @@ import bb.server.xmlrpcclient
 
 logger = logging.getLogger("BitBake")
 
+
 class BBMainException(Exception):
     pass
 
+
 class BBMainFatal(bb.BBHandledException):
     pass
 
-def present_options(optionlist):
-    if len(optionlist) > 1:
-        return ' or '.join([', '.join(optionlist[:-1]), optionlist[-1]])
-    else:
-        return optionlist[0]
-
-class BitbakeHelpFormatter(optparse.IndentedHelpFormatter):
-    def format_option(self, option):
-        # We need to do this here rather than in the text we supply to
-        # add_option() because we don't want to call list_extension_modules()
-        # on every execution (since it imports all of the modules)
-        # Note also that we modify option.help rather than the returned text
-        # - this is so that we don't have to re-format the text ourselves
-        if option.dest == 'ui':
-            valid_uis = list_extension_modules(bb.ui, 'main')
-            option.help = option.help.replace('@CHOICES@', present_options(valid_uis))
-
-        return optparse.IndentedHelpFormatter.format_option(self, option)
 
 def list_extension_modules(pkg, checkattr):
     """
@@ -69,36 +53,22 @@ def list_extension_modules(pkg, checkattr):
             as the type of extension you are looking for
     """
     import pkgutil
-    pkgdir = os.path.dirname(pkg.__file__)
+    import importlib
 
     modules = []
-    for _, modulename, _ in pkgutil.iter_modules([pkgdir]):
-        if os.path.isdir(os.path.join(pkgdir, modulename)):
-            # ignore directories
-            continue
+    # bb.ui uses namespace packaging: https://packaging.python.org/guides/packaging-namespace-packages/
+    for _, modulename, _ in pkgutil.iter_modules(pkg.__path__, pkg.__name__ + "."):
         try:
-            module = __import__(pkg.__name__, fromlist=[modulename])
+            module = importlib.import_module(modulename)
         except:
             # If we can't import it, it's not valid
             continue
-        module_if = getattr(module, modulename)
-        if getattr(module_if, 'hidden_extension', False):
-            continue
-        if not checkattr or hasattr(module_if, checkattr):
-            modules.append(modulename)
+        # if getattr(module_if, 'hidden_extension', False):
+        #     continue
+        if not checkattr or hasattr(module, checkattr):
+            modules.append(module)
     return modules
 
-def import_extension_module(pkg, modulename, checkattr):
-    try:
-        # Dynamically load the UI based on the ui name. Although we
-        # suggest a fixed set this allows you to have flexibility in which
-        # ones are available.
-        module = __import__(pkg.__name__, fromlist=[modulename])
-        return getattr(module, modulename)
-    except AttributeError:
-        modules = present_options(list_extension_modules(pkg, checkattr))
-        raise BBMainException('FATAL: Unable to import extension module "%s" from %s. '
-                              'Valid extension modules: %s' % (modulename, pkg.__name__, modules))
 
 # Display bitbake/OE warnings via the BitBake.Warnings logger, ignoring others"""
 warnlog = logging.getLogger("BitBake.Warnings")
@@ -120,213 +90,234 @@ warnings.filterwarnings("ignore", category=DeprecationWarning, module="<string>$
 warnings.filterwarnings("ignore", message="With-statements now directly support multiple context managers")
 
 
+class LazyUiChoices:
+    """
+    A proxy object that will act as both the 'choices' (via __iter__ and __contains__) and the 'type' (via __call__) for
+    the 'ui' argparse argument.
+    """
+    def __init__(self):
+        # map module name => imported module
+        self._modules = {}
+
+    def _lazy_load_modules(self):
+        if not self._modules:
+            self._modules = {module.__name__.split(".")[-1]: module for module in list_extension_modules(bb.ui, "main")}
+
+    def __iter__(self):
+        self._lazy_load_modules()
+        yield from self._modules.keys()
+
+    def __contains__(self, item):
+        self._lazy_load_modules()
+        return item in self._modules.values()
+
+    def __call__(self, *args, **kwargs):
+        """ Called by argparse to convert string name into the module itself """
+        self._lazy_load_modules()
+        try:
+            return self._modules[args[0]]
+        except KeyError:
+            # invalid choice, just return the string - will be rejected when argparse uses  __contains__ to check it
+            return args[0]
+
+
 def create_bitbake_parser():
-    parser = optparse.OptionParser(
-        formatter=BitbakeHelpFormatter(),
-        version="BitBake Build Tool Core version %s" % bb.__version__,
-        usage="""%prog [options] [recipename/target recipe:do_task ...]
+    parser = argparse.ArgumentParser(usage="""%(prog)s [options] [recipename/target recipe:do_task ...]
 
     Executes the specified task (default is 'build') for a given set of target recipes (.bb files).
     It is assumed there is a conf/bblayers.conf available in cwd or in BBPATH which
-    will provide the layer, BBFILES and other configuration information.""")
+    will provide the layer, BBFILES and other configuration information.
+    """)
+    parser.add_argument("targets", nargs="*")
+    parser.add_argument("--version",
+                        action="version",
+                        version="BitBake Build Tool Core version {0}".format(bb.__version__))
+
+    ui_choices = LazyUiChoices()
+    # Setting metavar="" is necessary otherwise argparse will immediately try to expand the choices
+    parser.add_argument("-u", "--ui",
+                        default=os.environ.get('BITBAKE_UI', 'knotty'),
+                        help="The user interface to use (%(choices)s) - default: %(default)s",
+                        choices=ui_choices, metavar="", type=ui_choices)
+
+    parser.add_argument("-v", "--verbose", action="store_true", dest="verbose",
+                      help="Enable tracing of shell tasks (with 'set -x'). "
+                           "Also print bb.note(...) messages to stdout (in "
+                           "addition to writing them to ${T}/log.do_<task>).")
 
-    parser.add_option("-b", "--buildfile", action="store", dest="buildfile", default=None,
+    parser.add_argument("-q", "--quiet", action="count", dest="quiet", default=0,
+                      help="Output less log message data to the terminal. You can specify this more than once.")
+
+    parser.add_argument("-D", "--debug", action="count", dest="debug", default=0,
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
+    parser.add_argument("-b", "--buildfile", dest="buildfile",
                       help="Execute tasks from a specific .bb recipe directly. WARNING: Does "
                            "not handle any dependencies from other recipes.")
 
-    parser.add_option("-k", "--continue", action="store_false", dest="abort", default=True,
+    parser.add_argument("-k", "--continue", action="store_false", dest="abort",
                       help="Continue as much as possible after an error. While the target that "
                            "failed and anything depending on it cannot be built, as much as "
                            "possible will be built before stopping.")
 
-    parser.add_option("-f", "--force", action="store_true", dest="force", default=False,
+    parser.add_argument("-f", "--force", action="store_true", dest="force",
                       help="Force the specified targets/task to run (invalidating any "
                            "existing stamp file).")
 
-    parser.add_option("-c", "--cmd", action="store", dest="cmd",
+    parser.add_argument("-c", "--cmd", dest="cmd",
                       help="Specify the task to execute. The exact options available "
                            "depend on the metadata. Some examples might be 'compile'"
                            " or 'populate_sysroot' or 'listtasks' may give a list of "
                            "the tasks available.")
 
-    parser.add_option("-C", "--clear-stamp", action="store", dest="invalidate_stamp",
+    parser.add_argument("-C", "--clear-stamp", dest="invalidate_stamp",
                       help="Invalidate the stamp for the specified task such as 'compile' "
                            "and then run the default task for the specified target(s).")
 
-    parser.add_option("-r", "--read", action="append", dest="prefile", default=[],
+    parser.add_argument("-r", "--read", action="append", dest="prefile", default=[],
                       help="Read the specified file before bitbake.conf.")
 
-    parser.add_option("-R", "--postread", action="append", dest="postfile", default=[],
+    parser.add_argument("-R", "--postread", action="append", dest="postfile", default=[],
                       help="Read the specified file after bitbake.conf.")
 
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
+    parser.add_argument("-n", "--dry-run", action="store_true", dest="dry_run", default=[],
                       help="Don't execute, just go through the motions.")
 
-    parser.add_option("-S", "--dump-signatures", action="append", dest="dump_signatures",
-                      default=[], metavar="SIGNATURE_HANDLER",
-                      help="Dump out the signature construction information, with no task "
+    parser.add_argument("-S", "--dump-signatures", action="append", dest="dump_signatures", metavar="SIGNATURE_HANDLER",
+                        default=[], help="Dump out the signature construction information, with no task "
                            "execution. The SIGNATURE_HANDLER parameter is passed to the "
                            "handler. Two common values are none and printdiff but the handler "
                            "may define more/less. none means only dump the signature, printdiff"
                            " means compare the dumped signature with the cached one.")
 
-    parser.add_option("-p", "--parse-only", action="store_true",
-                      dest="parse_only", default=False,
+    parser.add_argument("-p", "--parse-only", action="store_true", dest="parse_only",
                       help="Quit after parsing the BB recipes.")
 
-    parser.add_option("-s", "--show-versions", action="store_true",
-                      dest="show_versions", default=False,
+    parser.add_argument("-s", "--show-versions", action="store_true", dest="show_versions",
                       help="Show current and preferred versions of all recipes.")
 
-    parser.add_option("-e", "--environment", action="store_true",
-                      dest="show_environment", default=False,
+    parser.add_argument("-e", "--environment", action="store_true", dest="show_environment",
                       help="Show the global or per-recipe environment complete with information"
                            " about where variables were set/changed.")
 
-    parser.add_option("-g", "--graphviz", action="store_true", dest="dot_graph", default=False,
+    parser.add_argument("-g", "--graphviz", action="store_true", dest="dot_graph",
                       help="Save dependency tree information for the specified "
                            "targets in the dot syntax.")
 
-    parser.add_option("-I", "--ignore-deps", action="append",
-                      dest="extra_assume_provided", default=[],
+    parser.add_argument("-I", "--ignore-deps", action="append", default=[], dest="extra_assume_provided",
                       help="Assume these dependencies don't exist and are already provided "
                            "(equivalent to ASSUME_PROVIDED). Useful to make dependency "
                            "graphs more appealing")
 
-    parser.add_option("-l", "--log-domains", action="append", dest="debug_domains", default=[],
+    parser.add_argument("-l", "--log-domains", action="append", dest="debug_domains", default=[],
                       help="Show debug logging for the specified logging domains")
 
-    parser.add_option("-P", "--profile", action="store_true", dest="profile", default=False,
+    parser.add_argument("-P", "--profile", action="store_true", dest="profile", default=[],
                       help="Profile the command and save reports.")
 
-    # @CHOICES@ is substituted out by BitbakeHelpFormatter above
-    parser.add_option("-u", "--ui", action="store", dest="ui",
-                      default=os.environ.get('BITBAKE_UI', 'knotty'),
-                      help="The user interface to use (@CHOICES@ - default %default).")
-
-    parser.add_option("", "--token", action="store", dest="xmlrpctoken",
-                      default=os.environ.get("BBTOKEN"),
+    parser.add_argument("--token", dest="xmlrpctoken", default=os.environ.get("BBTOKEN"),
                       help="Specify the connection token to be used when connecting "
                            "to a remote server.")
 
-    parser.add_option("", "--revisions-changed", action="store_true",
-                      dest="revisions_changed", default=False,
+    parser.add_argument("--revisions-changed", action="store_true", dest="revisions_changed",
                       help="Set the exit code depending on whether upstream floating "
                            "revisions have changed or not.")
 
-    parser.add_option("", "--server-only", action="store_true",
-                      dest="server_only", default=False,
+    parser.add_argument("--server-only", action="store_true", dest="server_only",
                       help="Run bitbake without a UI, only starting a server "
                            "(cooker) process.")
 
-    parser.add_option("-B", "--bind", action="store", dest="bind", default=False,
+    parser.add_argument("-B", "--bind", dest="bind",
                       help="The name/address for the bitbake xmlrpc server to bind to.")
 
-    parser.add_option("-T", "--idle-timeout", type=float, dest="server_timeout",
+    parser.add_argument("-T", "--idle-timeout", type=float, dest="server_timeout",
                       default=os.getenv("BB_SERVER_TIMEOUT"),
                       help="Set timeout to unload bitbake server due to inactivity, "
                            "set to -1 means no unload, "
                            "default: Environment variable BB_SERVER_TIMEOUT.")
 
-    parser.add_option("", "--no-setscene", action="store_true",
-                      dest="nosetscene", default=False,
+    parser.add_argument("--no-setscene", action="store_true", dest="nosetscene",
                       help="Do not run any setscene tasks. sstate will be ignored and "
                            "everything needed, built.")
 
-    parser.add_option("", "--skip-setscene", action="store_true",
-                      dest="skipsetscene", default=False,
+    parser.add_argument("--skip-setscene", action="store_true", dest="skipsetscene",
                       help="Skip setscene tasks if they would be executed. Tasks previously "
                            "restored from sstate will be kept, unlike --no-setscene")
 
-    parser.add_option("", "--setscene-only", action="store_true",
-                      dest="setsceneonly", default=False,
+    parser.add_argument("--setscene-only", action="store_true", dest="setsceneonly",
                       help="Only run setscene tasks, don't run any real tasks.")
 
-    parser.add_option("", "--remote-server", action="store", dest="remote_server",
-                      default=os.environ.get("BBSERVER"),
+    parser.add_argument("--remote-server", dest="remote_server", default=os.environ.get("BBSERVER"),
                       help="Connect to the specified server.")
 
-    parser.add_option("-m", "--kill-server", action="store_true",
-                      dest="kill_server", default=False,
+    parser.add_argument("-m", "--kill-server", action="store_true", dest="kill_server",
                       help="Terminate any running bitbake server.")
 
-    parser.add_option("", "--observe-only", action="store_true",
-                      dest="observe_only", default=False,
+    parser.add_argument("--observe-only", action="store_true", dest="observe_only",
                       help="Connect to a server as an observing-only client.")
 
-    parser.add_option("", "--status-only", action="store_true",
-                      dest="status_only", default=False,
+    parser.add_argument("--status-only", action="store_true", dest="status_only",
                       help="Check the status of the remote bitbake server.")
 
-    parser.add_option("-w", "--write-log", action="store", dest="writeeventlog",
-                      default=os.environ.get("BBEVENTLOG"),
+    parser.add_argument("-w", "--write-log", dest="writeeventlog", default=os.environ.get("BBEVENTLOG"),
                       help="Writes the event log of the build to a bitbake event json file. "
                            "Use '' (empty string) to assign the name automatically.")
 
-    parser.add_option("", "--runall", action="append", dest="runall",
-                      help="Run the specified task for any recipe in the taskgraph of the specified target (even if it wouldn't otherwise have run).")
+    parser.add_argument("--runall", action="append", dest="runall", default=[],
+                      help="Run the specified task for any recipe in the taskgraph of the specified target (even if "
+                           "it wouldn't otherwise have run).")
 
-    parser.add_option("", "--runonly", action="append", dest="runonly",
-                      help="Run only the specified task within the taskgraph of the specified targets (and any task dependencies those tasks may have).")
+    parser.add_argument("--runonly", action="append", dest="runonly", default=[],
+                      help="Run only the specified task within the taskgraph of the specified targets (and any task "
+                           "dependencies those tasks may have).")
     return parser
 
 
 class BitBakeConfigParameters(cookerdata.ConfigParameters):
-    def parseCommandLine(self, argv=sys.argv):
+    def parseCommandLine(self, argv=None):
         parser = create_bitbake_parser()
-        options, targets = parser.parse_args(argv)
+        args = parser.parse_args(argv or sys.argv)
 
-        if options.quiet and options.verbose:
+        if args.quiet and args.verbose:
             parser.error("options --quiet and --verbose are mutually exclusive")
 
-        if options.quiet and options.debug:
+        if args.quiet and args.debug:
             parser.error("options --quiet and --debug are mutually exclusive")
 
         # use configuration files from environment variables
         if "BBPRECONF" in os.environ:
-            options.prefile.append(os.environ["BBPRECONF"])
+            args.prefile.append(os.environ["BBPRECONF"])
 
         if "BBPOSTCONF" in os.environ:
-            options.postfile.append(os.environ["BBPOSTCONF"])
+            args.postfile.append(os.environ["BBPOSTCONF"])
 
         # fill in proper log name if not supplied
-        if options.writeeventlog is not None and len(options.writeeventlog) == 0:
+        if args.writeeventlog is not None and len(args.writeeventlog) == 0:
             from datetime import datetime
             eventlog = "bitbake_eventlog_%s.json" % datetime.now().strftime("%Y%m%d%H%M%S")
-            options.writeeventlog = eventlog
+            args.writeeventlog = eventlog
 
-        if options.bind:
+        if args.bind:
             try:
                 #Checking that the port is a number and is a ':' delimited value
-                (host, port) = options.bind.split(':')
+                (host, port) = args.bind.split(':')
                 port = int(port)
             except (ValueError,IndexError):
                 raise BBMainException("FATAL: Malformed host:port bind parameter")
-            options.xmlrpcinterface = (host, port)
+            args.xmlrpcinterface = (host, port)
         else:
-            options.xmlrpcinterface = (None, 0)
+            args.xmlrpcinterface = (None, 0)
 
-        return options, targets[1:]
+        return args, args.targets[1:]
 
 
 def bitbake_main(configParams, configuration):
@@ -402,9 +393,8 @@ def setup_bitbake(configParams, extrafeatures=None):
         featureset = []
         ui_module = None
     else:
-        ui_module = import_extension_module(bb.ui, configParams.ui, 'main')
         # Collect the feature set for the UI
-        featureset = getattr(ui_module, "featureSet", [])
+        featureset = getattr(configParams.ui, "featureSet", [])
 
     if extrafeatures:
         for feature in extrafeatures:
@@ -489,7 +479,7 @@ def setup_bitbake(configParams, extrafeatures=None):
 
     logger.removeHandler(handler)
 
-    return server_connection, ui_module
+    return server_connection, configParams.ui
 
 def lockBitbake():
     topdir = bb.cookerdata.findTopdir()
-- 
2.17.1

