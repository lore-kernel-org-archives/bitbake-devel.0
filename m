Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 54481778B0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 05:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 9D1D3182F3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id aVVBk89fBD24 for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:19 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id 06C1D18414
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:19 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBB861E070
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0C171E075
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder03.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by seth.se.axis.com (Postfix) with ESMTP id A52E2211
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id v2B5MIQv004419
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id v2B5MICs004416
	for bitbake-devel@lists.openembedded.org;
	Sat, 11 Mar 2017 06:22:18 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 11 Mar 2017 06:22:16 +0100
Message-Id: <1288c36048807e9a5694a76b5c05f686bdf18f2f.1489209703.git.pkj@axis.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <cover.1489209703.git.pkj@axis.com>
References: <cover.1489209703.git.pkj@axis.com>
X-TM-AS-GCONF: 00
Subject: [PATCH 2/3] bitbake-dumpsig: Add debug support
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
X-List-Received-Date: Sat, 11 Mar 2017 05:22:21 -0000

Currently shows the name of the signature file that was found when
--task is used.
---
 bitbake/bin/bitbake-dumpsig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bitbake/bin/bitbake-dumpsig b/bitbake/bin/bitbake-dumpsig
index b1fce2510d..38efd22864 100755
--- a/bitbake/bin/bitbake-dumpsig
+++ b/bitbake/bin/bitbake-dumpsig
@@ -67,16 +67,24 @@ parser = optparse.OptionParser(
   %prog -t recipename taskname
   %prog sigdatafile""")
 
+parser.add_option("-D", "--debug",
+        help = "enable debug",
+        action = "store_true", dest="debug", default = False)
+
 parser.add_option("-t", "--task",
         help = "find the signature data file for the specified task",
         action="store", dest="taskargs", nargs=2, metavar='recipename taskname')
 
 options, args = parser.parse_args(sys.argv)
 
+if options.debug:
+    logger.setLevel(logging.DEBUG)
+
 if options.taskargs:
     tinfoil = bb.tinfoil.Tinfoil()
     tinfoil.prepare(config_only = True)
     file = find_siginfo_task(tinfoil, options.taskargs[0], options.taskargs[1])
+    logger.debug("Signature file: %s" % file)
 elif len(args) == 1:
     parser.print_help()
     sys.exit(0)
-- 
2.12.0


