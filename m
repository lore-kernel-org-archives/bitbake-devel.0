Return-Path: <s.christ@phytec.de>
X-Greylist: delayed 361 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 08 Sep 2015 08:10:53 UTC
Received: from root.phytec.de (mail.x-arc.de [217.6.246.34])
	by mail.openembedded.org (Postfix) with ESMTP id E7CA774197
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Sep 2015 08:10:53 +0000 (UTC)
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
	by root.phytec.de (Postfix) with ESMTP id D043EA0023D
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Sep 2015 10:04:53 +0200 (CEST)
Received: from augenblix.phytec.de ([172.16.0.56])
	by idefix.phytec.de (IBM Domino Release 9.0.1FP2 HF590)
	with ESMTP id 2015090810045257-2964 ; Tue, 8 Sep 2015 10:04:52 +0200 
From: Stefan Christ <s.christ@phytec.de>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 8 Sep 2015 10:04:38 +0200
Message-Id: <1441699478-30724-1-git-send-email-s.christ@phytec.de>
X-Mailer: git-send-email 1.9.1
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP2
	HF590|December 11, 2014) at 08.09.2015 10:04:52,
	Serialize by Router on Idefix/Phytec(Release 9.0.1FP2 HF590|December 11,
	2014) at 08.09.2015 10:04:52,
	Serialize complete at 08.09.2015 10:04:52
Subject: [PATCH] bitbake: cooker: sort file pn-buildlist
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
X-List-Received-Date: Tue, 08 Sep 2015 08:10:55 -0000

The list of recipe names in the file pn-buildlist should be
sorted/deterministic. This makes it easier to compare multiple files,
e.g. with vimdiff.

Signed-off-by: Stefan Christ <s.christ@phytec.de>
---
 lib/bb/cooker.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index a0d7d59..b2fc1ed 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -869,16 +869,17 @@ class BBCooker:
         depgraph = self.generateTaskDepTreeData(pkgs_to_build, task)
 
         # Prints a flattened form of package-depends below where subpackages of a package are merged into the main pn
+        with open('pn-buildlist', 'w') as buildlist_file:
+            for pn in sorted(depgraph["pn"]):  # be deterministic
+                buildlist_file.write(pn + "\n")
+        logger.info("PN build list saved to 'pn-buildlist'")
+
         depends_file = file('pn-depends.dot', 'w' )
-        buildlist_file = file('pn-buildlist', 'w' )
         print("digraph depends {", file=depends_file)
         for pn in depgraph["pn"]:
             fn = depgraph["pn"][pn]["filename"]
             version = depgraph["pn"][pn]["version"]
             print('"%s" [label="%s %s\\n%s"]' % (pn, pn, version, fn), file=depends_file)
-            print("%s" % pn, file=buildlist_file)
-        buildlist_file.close()
-        logger.info("PN build list saved to 'pn-buildlist'")
         for pn in depgraph["depends"]:
             for depend in depgraph["depends"][pn]:
                 print('"%s" -> "%s"' % (pn, depend), file=depends_file)
-- 
1.9.1


