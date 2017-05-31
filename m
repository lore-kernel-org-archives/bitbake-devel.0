Return-Path: <ola.x.nilsson@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 9D3B178096
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 08:28:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id EFA6B2E0EB
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 10:28:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id IeweNO_sZQ0t for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 10:28:32 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bes.se.axis.com (Postfix) with ESMTPS id AF8E52E271
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 10:28:32 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99EB51A077
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 10:28:32 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88FE51A075
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 10:28:32 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder02.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 10:28:32 +0200 (CEST)
Received: from lnxolani1.se.axis.com (lnxolani1.se.axis.com [10.88.130.9])
	by thoth.se.axis.com (Postfix) with ESMTP id 7CF613C7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 10:28:32 +0200 (CEST)
Received: by lnxolani1.se.axis.com (Postfix, from userid 20853)
	id 7860E409BA; Wed, 31 May 2017 10:28:32 +0200 (CEST)
From: Ola x Nilsson <ola.x.nilsson@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 31 May 2017 10:28:32 +0200
Message-Id: <20170531082832.32497-1-olani@axis.com>
X-Mailer: git-send-email 2.11.0
X-TM-AS-GCONF: 00
Subject: [PATCH] ConfHandler: Require whitespace between export and variable name
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
X-List-Received-Date: Wed, 31 May 2017 08:28:34 -0000

Signed-off-by: Ola x Nilsson <olani@axis.com>
---
 lib/bb/parse/parse_py/ConfHandler.py |  4 ++--
 lib/bb/tests/parse.py                | 27 ++++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index f7d0cf74..24a0db0b 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -32,7 +32,7 @@ from bb.parse import ParseError, resolve_file, ast, logger, handle
 
 __config_regexp__  = re.compile( r"""
     ^
-    (?P<exp>export\s*)?
+    (?P<exp>export\s+)?
     (?P<var>[a-zA-Z0-9\-_+.${}/~]+?)
     (\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?
 
@@ -110,7 +110,7 @@ def include(parentfn, fn, lineno, data, error_out):
 # We have an issue where a UI might want to enforce particular settings such as
 # an empty DISTRO variable. If configuration files do something like assigning
 # a weak default, it turns out to be very difficult to filter out these changes,
-# particularly when the weak default might appear half way though parsing a chain 
+# particularly when the weak default might appear half way though parsing a chain
 # of configuration files. We therefore let the UIs hook into configuration file
 # parsing. This turns out to be a hard problem to solve any other way.
 confFilters = []
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index ab6ca903..7ad2a624 100644
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
@@ -145,10 +166,11 @@ python () {
 }
 """
 
+
     #
     # Test based upon a real world data corruption issue. One
     # data store changing a variable poked through into a different data
-    # store. This test case replicates that issue where the value 'B' would 
+    # store. This test case replicates that issue where the value 'B' would
     # become unset/disappear.
     #
     def test_parse_classextend_contamination(self):
@@ -161,4 +183,3 @@ python () {
         d2 = alldata[cls.name]
         self.assertEqual(d1.getVar("VAR_var"), "B")
         self.assertEqual(d2.getVar("VAR_var"), None)
-
-- 
2.11.0


