Return-Path: <Qi.Chen@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 15FAA6069C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Aug 2019 07:39:41 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x7M7dMRO000989
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Aug 2019 00:39:33 -0700
Received: from pek-qchen1-d1.corp.ad.wrs.com (128.224.162.148) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.468.0; Thu, 22 Aug 2019 00:39:11 -0700
From: Chen Qi <Qi.Chen@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 22 Aug 2019 15:52:51 +0800
Message-ID: <0042fbfe33dae7b7ed4c0ac00f50a8179f6777b8.1566460314.git.Qi.Chen@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1566460314.git.Qi.Chen@windriver.com>
References: <cover.1566460314.git.Qi.Chen@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] cooker.py: remove generation of recipe-depends.dot
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
X-List-Received-Date: Thu, 22 Aug 2019 07:39:42 -0000
Content-Type: text/plain

The information of recipe-depends.dot is misleading.

e.g.
$ grep xz recipe-depends.dot | grep bzip2
"bzip2" -> "xz"
"xz" -> "bzip2"

Users would wonder why they get some circular dependency.

The information is derived from removing the task names
of task-depends.dot. It's not giving people any additonal
information, and it's misleading.

So we remove the generation of this file.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/cooker.py | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 0607fcc..e46868d 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -919,6 +919,10 @@ class BBCooker:
             os.unlink('package-depends.dot')
         except FileNotFoundError:
             pass
+        try:
+            os.unlink('recipe-depends.dot')
+        except FileNotFoundError:
+            pass
 
         with open('task-depends.dot', 'w') as f:
             f.write("digraph depends {\n")
@@ -932,27 +936,6 @@ class BBCooker:
             f.write("}\n")
         logger.info("Task dependencies saved to 'task-depends.dot'")
 
-        with open('recipe-depends.dot', 'w') as f:
-            f.write("digraph depends {\n")
-            pndeps = {}
-            for task in sorted(depgraph["tdepends"]):
-                (pn, taskname) = task.rsplit(".", 1)
-                if pn not in pndeps:
-                    pndeps[pn] = set()
-                for dep in sorted(depgraph["tdepends"][task]):
-                    (deppn, deptaskname) = dep.rsplit(".", 1)
-                    pndeps[pn].add(deppn)
-            for pn in sorted(pndeps):
-                fn = depgraph["pn"][pn]["filename"]
-                version = depgraph["pn"][pn]["version"]
-                f.write('"%s" [label="%s\\n%s\\n%s"]\n' % (pn, pn, version, fn))
-                for dep in sorted(pndeps[pn]):
-                    if dep == pn:
-                        continue
-                    f.write('"%s" -> "%s"\n' % (pn, dep))
-            f.write("}\n")
-        logger.info("Flattened recipe dependencies saved to 'recipe-depends.dot'")
-
     def show_appends_with_no_recipes(self):
         # Determine which bbappends haven't been applied
 
-- 
1.9.1


