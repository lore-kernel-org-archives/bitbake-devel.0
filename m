Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8E856719FA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Jan 2017 22:38:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0NMcSnT030327; Mon, 23 Jan 2017 22:38:28 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0ZpMs3Lw3f11; Mon, 23 Jan 2017 22:38:28 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0NMcO9w030324
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 23 Jan 2017 22:38:26 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cVnFo-0002UR-Up; Mon, 23 Jan 2017 22:38:24 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 23 Jan 2017 22:38:22 +0000
Message-Id: <1485211102-9532-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] cooker: Drop package-depends.dot and pn-depends.dot generation
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
X-List-Received-Date: Mon, 23 Jan 2017 22:38:31 -0000

A long time ago when we switched to task basked execution we added
task-depends.dot and generated package-depends.dot and pn-depends.dot
for compatibility as best we could.

The problem is they contain partial data about the taskgraph, its
incomplete and tends to confuse users.

I propose we remove the two compatibilty outputs and just generate
the one which contains definitive data.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 43 -------------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 80007c5..e654a60 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -949,49 +949,6 @@ class BBCooker:
 
         depgraph = self.generateTaskDepTreeData(pkgs_to_build, task)
 
-        # Prints a flattened form of package-depends below where subpackages of a package are merged into the main pn
-        depends_file = open('pn-depends.dot', 'w' )
-        buildlist_file = open('pn-buildlist', 'w' )
-        print("digraph depends {", file=depends_file)
-        for pn in depgraph["pn"]:
-            fn = depgraph["pn"][pn]["filename"]
-            version = depgraph["pn"][pn]["version"]
-            print('"%s" [label="%s %s\\n%s"]' % (pn, pn, version, fn), file=depends_file)
-            print("%s" % pn, file=buildlist_file)
-        buildlist_file.close()
-        logger.info("PN build list saved to 'pn-buildlist'")
-        for pn in depgraph["depends"]:
-            for depend in depgraph["depends"][pn]:
-                print('"%s" -> "%s" [style=solid]' % (pn, depend), file=depends_file)
-        for pn in depgraph["rdepends-pn"]:
-            for rdepend in depgraph["rdepends-pn"][pn]:
-                print('"%s" -> "%s" [style=dashed]' % (pn, rdepend), file=depends_file)
-        print("}", file=depends_file)
-        depends_file.close()
-        logger.info("PN dependencies saved to 'pn-depends.dot'")
-
-        depends_file = open('package-depends.dot', 'w' )
-        print("digraph depends {", file=depends_file)
-        for package in depgraph["packages"]:
-            pn = depgraph["packages"][package]["pn"]
-            fn = depgraph["packages"][package]["filename"]
-            version = depgraph["packages"][package]["version"]
-            if package == pn:
-                print('"%s" [label="%s %s\\n%s"]' % (pn, pn, version, fn), file=depends_file)
-            else:
-                print('"%s" [label="%s(%s) %s\\n%s"]' % (package, package, pn, version, fn), file=depends_file)
-            for depend in depgraph["depends"][pn]:
-                print('"%s" -> "%s" [style=solid]' % (package, depend), file=depends_file)
-        for package in depgraph["rdepends-pkg"]:
-            for rdepend in depgraph["rdepends-pkg"][package]:
-                print('"%s" -> "%s" [style=dashed]' % (package, rdepend), file=depends_file)
-        for package in depgraph["rrecs-pkg"]:
-            for rdepend in depgraph["rrecs-pkg"][package]:
-                print('"%s" -> "%s" [style=dotted]' % (package, rdepend), file=depends_file)
-        print("}", file=depends_file)
-        depends_file.close()
-        logger.info("Package dependencies saved to 'package-depends.dot'")
-
         tdepends_file = open('task-depends.dot', 'w' )
         print("digraph depends {", file=tdepends_file)
         for task in depgraph["tdepends"]:
-- 
2.7.4


