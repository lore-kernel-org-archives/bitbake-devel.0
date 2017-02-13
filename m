Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 0FB8271E51
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Feb 2017 11:36:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v1DBaHgX004160; Mon, 13 Feb 2017 11:36:17 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id EyGJl7Py8wjl; Mon, 13 Feb 2017 11:36:17 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v1DBa8fr004151
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 13 Feb 2017 11:36:11 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cdEvQ-0008Mh-9v; Mon, 13 Feb 2017 03:36:08 -0800
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 Feb 2017 03:36:02 -0800
Message-Id: <1486985762-32111-2-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1486985762-32111-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1486985762-32111-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 2/2] cooker: Rewrite dependency dot file generation
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
X-List-Received-Date: Mon, 13 Feb 2017 11:36:18 -0000

The package-depends.dot and pn-depends.dot files are inaccurate, missing
out key dependencies such those made via the [depends] flags. As such
they can be misleading to the user.

They mainly exist for historical reasons, coming from a time before
we had task based execution.

This commit removes the two dated file formats and replaces them with
a recipe-depends.dot which is a flattened version of task-depends.dot.

The old format files are removed if present so that the user can't get
confused about why data might not match between files.

The code is also rewritten to use 'with f: f.write()' syntax as is more
commonly used now.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 98 ++++++++++++++++++++++++++------------------------------
 1 file changed, 45 insertions(+), 53 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index fd1c629..ce84e1c 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -947,62 +947,54 @@ class BBCooker:
 
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
+        with open('pn-buildlist', 'w') as f:
+            for pn in depgraph["pn"]:
+                f.write(pn + "\n")
         logger.info("PN build list saved to 'pn-buildlist'")
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
-        tdepends_file = open('task-depends.dot', 'w' )
-        print("digraph depends {", file=tdepends_file)
-        for task in depgraph["tdepends"]:
-            (pn, taskname) = task.rsplit(".", 1)
-            fn = depgraph["pn"][pn]["filename"]
-            version = depgraph["pn"][pn]["version"]
-            print('"%s.%s" [label="%s %s\\n%s\\n%s"]' % (pn, taskname, pn, taskname, version, fn), file=tdepends_file)
-            for dep in depgraph["tdepends"][task]:
-                print('"%s" -> "%s"' % (task, dep), file=tdepends_file)
-        print("}", file=tdepends_file)
-        tdepends_file.close()
+
+        # Remove old format output files to ensure no confusion with stale data
+        try:
+            os.unlink('pn-depends.dot')
+        except FileNotFoundError:
+            pass
+        try:
+            os.unlink('package-depends.dot')
+        except FileNotFoundError:
+            pass
+
+        with open('task-depends.dot', 'w') as f:
+            f.write("digraph depends {\n")
+            for task in depgraph["tdepends"]:
+                (pn, taskname) = task.rsplit(".", 1)
+                fn = depgraph["pn"][pn]["filename"]
+                version = depgraph["pn"][pn]["version"]
+                f.write('"%s.%s" [label="%s %s\\n%s\\n%s"]\n' % (pn, taskname, pn, taskname, version, fn))
+                for dep in depgraph["tdepends"][task]:
+                    f.write('"%s" -> "%s"\n' % (task, dep))
+            f.write("}\n")
         logger.info("Task dependencies saved to 'task-depends.dot'")
 
+        with open('recipe-depends.dot', 'w') as f:
+            f.write("digraph depends {\n")
+            pndeps = {}
+            for task in depgraph["tdepends"]:
+                (pn, taskname) = task.rsplit(".", 1)
+                if pn not in pndeps:
+                    pndeps[pn] = set()
+                for dep in depgraph["tdepends"][task]:
+                    (deppn, deptaskname) = dep.rsplit(".", 1)
+                    pndeps[pn].add(deppn)
+            for pn in pndeps:
+                fn = depgraph["pn"][pn]["filename"]
+                version = depgraph["pn"][pn]["version"]
+                f.write('"%s" [label="%s\\n%s\\n%s"]\n' % (pn, pn, version, fn))
+                for dep in pndeps[pn]:
+                    if dep == pn:
+                        continue
+                    f.write('"%s" -> "%s"\n' % (pn, dep))
+            f.write("}\n")
+        logger.info("Flatened recipe dependencies saved to 'recipe-depends.dot'")
+
     def show_appends_with_no_recipes(self):
         # Determine which bbappends haven't been applied
 
-- 
2.7.4


