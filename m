Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 759C0778B4
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 05:22:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 2B9472E3BD
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id iB-iangQYxz5 for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:19 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bes.se.axis.com (Postfix) with ESMTPS id 7703B2E467
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:19 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF06E1A07C
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C40E31A075
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder02.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by seth.se.axis.com (Postfix) with ESMTP id B8869211
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id v2B5MIR6004447
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id v2B5MIPE004446
	for bitbake-devel@lists.openembedded.org;
	Sat, 11 Mar 2017 06:22:18 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 11 Mar 2017 06:22:17 +0100
Message-Id: <5fe4766b19e4013bcf86334b5513d7c1a1af8e18.1489209703.git.pkj@axis.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <cover.1489209703.git.pkj@axis.com>
References: <cover.1489209703.git.pkj@axis.com>
X-TM-AS-GCONF: 00
Subject: [PATCH 3/3] bitbake-diffsigs: Add debug support
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

Currently shows the name of the signature files that were found when
--task is used.
---
 bitbake/bin/bitbake-diffsigs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/bitbake/bin/bitbake-diffsigs b/bitbake/bin/bitbake-diffsigs
index 527d2c7a9c..c087f99bc5 100755
--- a/bitbake/bin/bitbake-diffsigs
+++ b/bitbake/bin/bitbake-diffsigs
@@ -94,6 +94,8 @@ def find_compare_task(bbhandler, pn, taskname):
             return recout
 
         # Recurse into signature comparison
+        logger.debug("Signature file (previous): %s" % latestfiles[0])
+        logger.debug("Signature file (latest): %s" % latestfiles[1])
         output = bb.siggen.compare_sigfiles(latestfiles[0], latestfiles[1], recursecb)
         if output:
             print('\n'.join(output))
@@ -108,12 +110,19 @@ parser = optparse.OptionParser(
   %prog sigdatafile1 sigdatafile2
   %prog sigdatafile1""")
 
+parser.add_option("-D", "--debug",
+        help = "enable debug",
+        action = "store_true", dest="debug", default = False)
+
 parser.add_option("-t", "--task",
         help = "find the signature data files for last two runs of the specified task and compare them",
         action="store", dest="taskargs", nargs=2, metavar='recipename taskname')
 
 options, args = parser.parse_args(sys.argv)
 
+if options.debug:
+    logger.setLevel(logging.DEBUG)
+
 if options.taskargs:
     with bb.tinfoil.Tinfoil() as tinfoil:
         tinfoil.prepare(config_only=True)
-- 
2.12.0


