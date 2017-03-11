Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 53216777B3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 05:22:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 3499D18408
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 2Tk+wAdK3AyK for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id BFCDB1806C
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A64591E072
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B95B1E070
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder03.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by thoth.se.axis.com (Postfix) with ESMTP id 8FD7E792
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id v2B5MISd004411
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id v2B5MI0w004408
	for bitbake-devel@lists.openembedded.org;
	Sat, 11 Mar 2017 06:22:18 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 11 Mar 2017 06:22:15 +0100
Message-Id: <c30142545c7732d25bfe1e387f144a175773e313.1489209703.git.pkj@axis.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <cover.1489209703.git.pkj@axis.com>
References: <cover.1489209703.git.pkj@axis.com>
X-TM-AS-GCONF: 00
Subject: [PATCH 1/3] bitbake-dumpsig: Allow recipe and task to be specified
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
X-List-Received-Date: Sat, 11 Mar 2017 05:22:22 -0000

Use --task <recipe> <task> to dump the signature info for a given
recipe and task. This is similar to the --task option of
bitbake-diffsigs.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/bin/bitbake-dumpsig | 53 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/bitbake/bin/bitbake-dumpsig b/bitbake/bin/bitbake-dumpsig
index 58ba1cad04..b1fce2510d 100755
--- a/bitbake/bin/bitbake-dumpsig
+++ b/bitbake/bin/bitbake-dumpsig
@@ -27,6 +27,7 @@ import pickle
 
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
 
+import bb.tinfoil
 import bb.siggen
 
 def logger_create(name, output=sys.stderr):
@@ -42,24 +43,54 @@ def logger_create(name, output=sys.stderr):
 
 logger = logger_create('bitbake-dumpsig')
 
+def find_siginfo_task(bbhandler, pn, taskname):
+    """ Find the most recent signature file for the specified PN/task """
+
+    if not hasattr(bb.siggen, 'find_siginfo'):
+        logger.error('Metadata does not support finding signature data files')
+        sys.exit(1)
+
+    if not taskname.startswith('do_'):
+        taskname = 'do_%s' % taskname
+
+    filedates = bb.siggen.find_siginfo(pn, taskname, None, bbhandler.config_data)
+    latestfiles = sorted(filedates.keys(), key=lambda f: filedates[f])[-1:]
+    if not latestfiles:
+        logger.error('No sigdata files found matching %s %s' % (pn, taskname))
+        sys.exit(1)
+
+    return latestfiles[0]
+
 parser = optparse.OptionParser(
     description = "Dumps siginfo/sigdata files written out by BitBake",
     usage = """
+  %prog -t recipename taskname
   %prog sigdatafile""")
 
+parser.add_option("-t", "--task",
+        help = "find the signature data file for the specified task",
+        action="store", dest="taskargs", nargs=2, metavar='recipename taskname')
+
 options, args = parser.parse_args(sys.argv)
 
-if len(args) == 1:
+if options.taskargs:
+    tinfoil = bb.tinfoil.Tinfoil()
+    tinfoil.prepare(config_only = True)
+    file = find_siginfo_task(tinfoil, options.taskargs[0], options.taskargs[1])
+elif len(args) == 1:
     parser.print_help()
+    sys.exit(0)
 else:
-    try:
-        output = bb.siggen.dump_sigfile(args[1])
-    except IOError as e:
-        logger.error(str(e))
-        sys.exit(1)
-    except (pickle.UnpicklingError, EOFError):
-        logger.error('Invalid signature data - ensure you are specifying a sigdata/siginfo file')
-        sys.exit(1)
+    file = args[1]
+
+try:
+    output = bb.siggen.dump_sigfile(file)
+except IOError as e:
+    logger.error(str(e))
+    sys.exit(1)
+except (pickle.UnpicklingError, EOFError):
+    logger.error('Invalid signature data - ensure you are specifying a sigdata/siginfo file')
+    sys.exit(1)
 
-    if output:
-        print('\n'.join(output))
+if output:
+    print('\n'.join(output))
-- 
2.12.0


