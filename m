Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 88ED971BE5
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 28 Jan 2018 11:21:52 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w0SBLng6025256
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Sun, 28 Jan 2018 11:21:51 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1efl1x-0002bI-QW; Sun, 28 Jan 2018 11:21:49 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 28 Jan 2018 11:21:47 +0000
Message-Id: <1517138508-9957-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 1/2] cooker: Sort task graph (dot) file output
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
X-List-Received-Date: Sun, 28 Jan 2018 11:21:52 -0000

This means two different graph files can easily be compared, currently
you'd have to sort them as the output is randomized.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 28717f4..cd365f7 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -856,12 +856,12 @@ class BBCooker:
 
         with open('task-depends.dot', 'w') as f:
             f.write("digraph depends {\n")
-            for task in depgraph["tdepends"]:
+            for task in sorted(depgraph["tdepends"]):
                 (pn, taskname) = task.rsplit(".", 1)
                 fn = depgraph["pn"][pn]["filename"]
                 version = depgraph["pn"][pn]["version"]
                 f.write('"%s.%s" [label="%s %s\\n%s\\n%s"]\n' % (pn, taskname, pn, taskname, version, fn))
-                for dep in depgraph["tdepends"][task]:
+                for dep in sorted(depgraph["tdepends"][task]):
                     f.write('"%s" -> "%s"\n' % (task, dep))
             f.write("}\n")
         logger.info("Task dependencies saved to 'task-depends.dot'")
@@ -869,18 +869,18 @@ class BBCooker:
         with open('recipe-depends.dot', 'w') as f:
             f.write("digraph depends {\n")
             pndeps = {}
-            for task in depgraph["tdepends"]:
+            for task in sorted(depgraph["tdepends"]):
                 (pn, taskname) = task.rsplit(".", 1)
                 if pn not in pndeps:
                     pndeps[pn] = set()
-                for dep in depgraph["tdepends"][task]:
+                for dep in sorted(depgraph["tdepends"][task]):
                     (deppn, deptaskname) = dep.rsplit(".", 1)
                     pndeps[pn].add(deppn)
-            for pn in pndeps:
+            for pn in sorted(pndeps):
                 fn = depgraph["pn"][pn]["filename"]
                 version = depgraph["pn"][pn]["version"]
                 f.write('"%s" [label="%s\\n%s\\n%s"]\n' % (pn, pn, version, fn))
-                for dep in pndeps[pn]:
+                for dep in sorted(pndeps[pn]):
                     if dep == pn:
                         continue
                     f.write('"%s" -> "%s"\n' % (pn, dep))
-- 
2.7.4


