Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 9434273CF2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jul 2015 22:30:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6MMUUcc013468 for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jul 2015 23:30:30 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ldl9QmJo3PkQ for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jul 2015 23:30:30 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6MMUFY8013458
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jul 2015 23:30:26 +0100
Message-ID: <1437604215.821.82.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 22 Jul 2015 23:30:15 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] bitbake-selftest: Add -v option for verbosity
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
X-List-Received-Date: Wed, 22 Jul 2015 22:30:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Also document BB_SKIP_NETTESTS=yes parameter in --help output.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/bin/bitbake-selftest b/bitbake/bin/bitbake-selftest
index 8db6197..462eb1b 100755
--- a/bitbake/bin/bitbake-selftest
+++ b/bitbake/bin/bitbake-selftest
@@ -26,14 +26,19 @@ except RuntimeError as exc:
     sys.exit(str(exc))
 
 def usage():
-    print('usage: %s [testname1 [testname2]...]' % os.path.basename(sys.argv[0]))
+    print('usage: [BB_SKIP_NETTESTS=yes] %s [-v] [testname1 [testname2]...]' % os.path.basename(sys.argv[0]))
 
-if len(sys.argv) > 1:
+verbosity = 1
+
+tests = sys.argv[1:]
+if '-v' in sys.argv:
+    tests.remove('-v')
+    verbosity = 2
+
+if tests:
     if '--help' in sys.argv[1:]:
         usage()
         sys.exit(0)
-
-    tests = sys.argv[1:]
 else:
     tests = ["bb.tests.codeparser",
              "bb.tests.cow",
@@ -46,5 +51,5 @@ for t in tests:
     t = '.'.join(t.split('.')[:3])
     __import__(t)
 
-unittest.main(argv=["bitbake-selftest"] + tests)
+unittest.main(argv=["bitbake-selftest"] + tests, verbosity=verbosity)
 



