Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id E274A6C29F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 01:10:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 135691849C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 02:10:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id gkloM8Im-WIk for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 02:10:20 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id 67FF618441
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 02:10:20 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 528F41E07D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 02:10:20 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 476761E07C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 02:10:20 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder03.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 02:10:20 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by thoth.se.axis.com (Postfix) with ESMTP id 3B4E12D50
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 02:10:20 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id wAE1AKid000934
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 02:10:20 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id wAE1AKGI000933
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Nov 2018 02:10:20 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Nov 2018 02:10:19 +0100
Message-Id: <20181114011019.878-2-pkj@axis.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20181114011019.878-1-pkj@axis.com>
References: <20181114011019.878-1-pkj@axis.com>
X-TM-AS-GCONF: 00
Subject: [PATCH 2/2] bitbake-dumpsig: Change to use argparse
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
X-List-Received-Date: Wed, 14 Nov 2018 01:10:22 -0000

This corresponds to commit 7f130e0b for bitbake-diffsigs.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/bin/bitbake-dumpsig | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/bitbake/bin/bitbake-dumpsig b/bitbake/bin/bitbake-dumpsig
index 40e08e0439..50e5717ace 100755
--- a/bitbake/bin/bitbake-dumpsig
+++ b/bitbake/bin/bitbake-dumpsig
@@ -22,7 +22,7 @@
 import os
 import sys
 import warnings
-import optparse
+import argparse
 import logging
 import pickle
 
@@ -73,21 +73,22 @@ def find_siginfo_task(bbhandler, pn, taskname):
 
     return latestfiles[0]
 
-parser = optparse.OptionParser(
-    description = "Dumps siginfo/sigdata files written out by BitBake",
-    usage = """
-  %prog -t recipename taskname
-  %prog sigdatafile""")
+parser = argparse.ArgumentParser(
+    description="Dump siginfo/sigdata files written out by BitBake")
 
-parser.add_option("-D", "--debug",
-        help = "enable debug",
-        action = "store_true", dest="debug", default = False)
+parser.add_argument('-d', '--debug',
+                    help='Enable debug output',
+                    action='store_true')
 
-parser.add_option("-t", "--task",
-        help = "find the signature data file for the specified task",
-        action="store", dest="taskargs", nargs=2, metavar='recipename taskname')
+parser.add_argument("-t", "--task",
+        help="find the signature data file for the last run of the specified task",
+        action="store", dest="taskargs", nargs=2, metavar=('recipename', 'taskname'))
 
-options, args = parser.parse_args(sys.argv)
+parser.add_argument("sigdatafile",
+        help="Signature file to dump. Not used when using -t/--task.",
+        action="store", nargs='?')
+
+options = parser.parse_args()
 
 if options.debug:
     logger.setLevel(logging.DEBUG)
@@ -97,11 +98,11 @@ if options.taskargs:
     tinfoil.prepare(config_only = True)
     file = find_siginfo_task(tinfoil, options.taskargs[0], options.taskargs[1])
     logger.debug("Signature file: %s" % file)
-elif len(args) == 1:
-    parser.print_help()
-    sys.exit(0)
+elif options.sigdatafile:
+    file = options.sigdatafile
 else:
-    file = args[1]
+    parser.print_help()
+    sys.exit(1)
 
 try:
     output = bb.siggen.dump_sigfile(file)
-- 
2.12.0


