Return-Path: <ola.x.nilsson@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 351C77804E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 08:46:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id D22DD2E1C1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 10:46:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id S7gpIqSmLrt5 for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 10:46:49 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bes.se.axis.com (Postfix) with ESMTPS id 193152E084
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 10:46:49 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05FBD1E0AB
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 10:46:49 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE1FE1E0A9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 10:46:48 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder03.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 10:46:48 +0200 (CEST)
Received: from lnxolani1.se.axis.com (lnxolani1.se.axis.com [10.88.130.9])
	by seth.se.axis.com (Postfix) with ESMTP id E24D22271
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 10:46:48 +0200 (CEST)
Received: by lnxolani1.se.axis.com (Postfix, from userid 20853)
	id DD538409BA; Wed, 31 May 2017 10:46:48 +0200 (CEST)
From: Ola x Nilsson <ola.x.nilsson@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 31 May 2017 10:46:48 +0200
Message-Id: <20170531084648.2495-1-olani@axis.com>
X-Mailer: git-send-email 2.11.0
X-TM-AS-GCONF: 00
Subject: [PATCH v3] ConfHandler: Require whitespace between export and variable name
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
X-List-Received-Date: Wed, 31 May 2017 08:46:49 -0000

Signed-off-by: Ola x Nilsson <olani@axis.com>
---
 lib/bb/parse/parse_py/ConfHandler.py |  2 +-
 lib/bb/tests/parse.py                | 23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index f7d0cf74..bf7e9859 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -32,7 +32,7 @@ from bb.parse import ParseError, resolve_file, ast, logger, handle
 
 __config_regexp__  = re.compile( r"""
     ^
-    (?P<exp>export\s*)?
+    (?P<exp>export\s+)?
     (?P<var>[a-zA-Z0-9\-_+.${}/~]+?)
     (\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?
 
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index ab6ca903..8f16ba4f 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -83,7 +83,28 @@ unset B[flag]
         self.assertEqual(d.getVar("A"), None)
         self.assertEqual(d.getVarFlag("A","flag"), None)
         self.assertEqual(d.getVar("B"), "2")
-        
+
+    exporttest = """
+A = "a"
+export B = "b"
+export C
+exportD = "d"
+"""
+
+    def test_parse_exports(self):
+        f = self.parsehelper(self.exporttest)
+        d = bb.parse.handle(f.name, self.d)['']
+        self.assertEqual(d.getVar("A"), "a")
+        self.assertIsNone(d.getVarFlag("A", "export"))
+        self.assertEqual(d.getVar("B"), "b")
+        self.assertEqual(d.getVarFlag("B", "export"), 1)
+        self.assertIsNone(d.getVar("C"))
+        self.assertEqual(d.getVarFlag("C", "export"), 1)
+        self.assertIsNone(d.getVar("D"))
+        self.assertIsNone(d.getVarFlag("D", "export"))
+        self.assertEqual(d.getVar("exportD"), "d")
+        self.assertIsNone(d.getVarFlag("exportD", "export"))
+
 
     overridetest = """
 RRECOMMENDS_${PN} = "a"
-- 
2.11.0


