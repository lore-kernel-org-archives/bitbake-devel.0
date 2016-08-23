Return-Path: <jeremy.rosen@smile.fr>
Received: from idris.smile.fr (idris.smile.fr [91.216.209.19])
	by mail.openembedded.org (Postfix) with ESMTP id CFBB273243
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Aug 2016 09:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by idris.smile.fr (Postfix) with ESMTP id 15AC91EE0820;
	Tue, 23 Aug 2016 11:45:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at smile.fr
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from idris.smile.fr ([127.0.0.1])
	by localhost (bluemind-mta.prod.vitry.intranet [127.0.0.1])
	(amavisd-new, port 10024)
	with ESMTP id 2lydx+23Bjaf; Tue, 23 Aug 2016 11:45:03 +0200 (CEST)
Received: from pcrosen.daviel.openwide.fr (unknown [193.56.60.161])
	by idris.smile.fr (Postfix) with ESMTPA id 49CB61EE0476;
	Tue, 23 Aug 2016 11:45:03 +0200 (CEST)
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Rosen?= <jeremy.rosen@smile.fr>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 23 Aug 2016 11:44:51 +0200
Message-Id: <320ea3092e4cdc1c8f9a7177ca09fc21ebce5eff.1471945418.git-series.jeremy.rosen@smile.fr>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.d26c020bb7163ba8281b0826f12094be699d8182.1471945418.git-series.jeremy.rosen@smile.fr>
References: <cover.d26c020bb7163ba8281b0826f12094be699d8182.1471945418.git-series.jeremy.rosen@smile.fr>
MIME-Version: 1.0
In-Reply-To: <cover.d26c020bb7163ba8281b0826f12094be699d8182.1471945418.git-series.jeremy.rosen@smile.fr>
References: <cover.d26c020bb7163ba8281b0826f12094be699d8182.1471945418.git-series.jeremy.rosen@smile.fr>
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Rosen?= <jeremy.rosen@openwide.fr>
Subject: [PATCH v2 1/1] add a syntax to clear variable
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
X-List-Received-Date: Tue, 23 Aug 2016 09:45:05 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

unset VAR
will clear variable VAR
unset VAR[flag]
will clear flag "flag" from var VAR

Signed-off-by: Jérémy Rosen <jeremy.rosen@openwide.fr>
---
 bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml | 17 ++++-
 bitbake/lib/bb/parse/ast.py                                      | 33 +++++++-
 bitbake/lib/bb/parse/parse_py/ConfHandler.py                     | 12 +++-
 bitbake/lib/bb/tests/parse.py                                    | 17 ++++-
 4 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index 7ef848f..47db85b 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -431,6 +431,23 @@
             </para>
         </section>
 
+        <section id='unsetting-variables'>
+            <title>Unseting variables</title>
+
+            <para>
+                It is possible to completely remove a variable or a variable flag 
+                from BitBake's internal data dictionary by using the "unset" keyword.
+                Here is an example:
+                <literallayout class='monospaced'>
+        unset DATE
+        unset do_fetch[noexec]
+                </literallayout>
+                These two statements remove the <filename>DATE</filename> and the 
+                <filename>do_fetch[noexec]</filename> flag.
+            </para>
+
+        </section>
+
         <section id='providing-pathnames'>
             <title>Providing Pathnames</title>
 
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 8b9baa7..b407b09 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -69,6 +69,33 @@ class ExportNode(AstNode):
     def eval(self, data):
         data.setVarFlag(self.var, "export", 1, op = 'exported')
 
+class UnsetNode(AstNode):
+    def __init__(self, filename, lineno, var):
+        AstNode.__init__(self, filename, lineno)
+        self.var = var
+
+    def eval(self, data):
+        loginfo = {
+            'variable': self.var,
+            'file': self.filename,
+            'line': self.lineno,
+        }
+        data.delVar(self.var,**loginfo)
+
+class UnsetFlagNode(AstNode):
+    def __init__(self, filename, lineno, var, flag):
+        AstNode.__init__(self, filename, lineno)
+        self.var = var
+        self.flag = flag
+
+    def eval(self, data):
+        loginfo = {
+            'variable': self.var,
+            'file': self.filename,
+            'line': self.lineno,
+        }
+        data.delVarFlag(self.var, self.flag, **loginfo)
+
 class DataNode(AstNode):
     """
     Various data related updates. For the sake of sanity
@@ -270,6 +297,12 @@ def handleInclude(statements, filename, lineno, m, force):
 def handleExport(statements, filename, lineno, m):
     statements.append(ExportNode(filename, lineno, m.group(1)))
 
+def handleUnset(statements, filename, lineno, m):
+    statements.append(UnsetNode(filename, lineno, m.group(1)))
+
+def handleUnsetFlag(statements, filename, lineno, m):
+    statements.append(UnsetFlagNode(filename, lineno, m.group(1), m.group(2)))
+
 def handleData(statements, filename, lineno, groupd):
     statements.append(DataNode(filename, lineno, groupd))
 
diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index b971292..875250d 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -57,6 +57,8 @@ __config_regexp__  = re.compile( r"""
 __include_regexp__ = re.compile( r"include\s+(.+)" )
 __require_regexp__ = re.compile( r"require\s+(.+)" )
 __export_regexp__ = re.compile( r"export\s+([a-zA-Z0-9\-_+.${}/]+)$" )
+__unset_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/]+)$" )
+__unset_flag_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/]+)\[([a-zA-Z0-9\-_+.${}/]+)\]$" )
 
 def init(data):
     topdir = data.getVar('TOPDIR', False)
@@ -185,6 +187,16 @@ def feeder(lineno, s, fn, statements):
         ast.handleExport(statements, fn, lineno, m)
         return
 
+    m = __unset_regexp__.match(s)
+    if m:
+        ast.handleUnset(statements, fn, lineno, m)
+        return
+
+    m = __unset_flag_regexp__.match(s)
+    if m:
+        ast.handleUnsetFlag(statements, fn, lineno, m)
+        return
+
     raise ParseError("unparsed line: '%s'" % s, fn, lineno);
 
 # Add us to the handlers list
diff --git a/bitbake/lib/bb/tests/parse.py b/bitbake/lib/bb/tests/parse.py
index c296db2..0b2706a 100644
--- a/bitbake/lib/bb/tests/parse.py
+++ b/bitbake/lib/bb/tests/parse.py
@@ -68,6 +68,23 @@ C = "3"
         with self.assertRaises(bb.parse.ParseError):
             d = bb.parse.handle(f.name, self.d)['']
 
+    unsettest = """
+A = "1"
+B = "2"
+B[flag] = "3"
+
+unset A
+unset B[flag]
+"""
+
+    def test_parse_unset(self):
+        f = self.parsehelper(self.unsettest)
+        d = bb.parse.handle(f.name, self.d)['']
+        self.assertEqual(d.getVar("A", True), None)
+        self.assertEqual(d.getVarFlag("A","flag", True), None)
+        self.assertEqual(d.getVar("B", True), "2")
+        
+
     overridetest = """
 RRECOMMENDS_${PN} = "a"
 RRECOMMENDS_${PN}_libc = "b"
-- 
git-series 0.8.9

