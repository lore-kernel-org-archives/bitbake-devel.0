Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C23616FF76
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Feb 2016 15:10:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u19FAfUW022517
	for <bitbake-devel@lists.openembedded.org>; Tue, 9 Feb 2016 15:10:59 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id x0bZwv1kqWKJ for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Feb 2016 15:10:58 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u19FAudY022540
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 9 Feb 2016 15:10:57 GMT
Message-ID: <1455030656.16142.80.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 09 Feb 2016 15:10:56 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] BBHandler/ast: Merge handMethod and handleMethodFlags
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
X-List-Received-Date: Tue, 09 Feb 2016 15:11:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The functionality overlap between these two functions is significant and
its clearer to handle both things together since they are intimately
linked. There should be no behaviour change, just clearer code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index c676fc6..5f55af5 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -141,22 +141,33 @@ class DataNode(AstNode):
 class MethodNode(AstNode):
     tr_tbl = string.maketrans('/.+-@%&', '_______')
 
-    def __init__(self, filename, lineno, func_name, body):
+    def __init__(self, filename, lineno, func_name, body, python, fakeroot):
         AstNode.__init__(self, filename, lineno)
         self.func_name = func_name
         self.body = body
+        self.python = python
+        self.fakeroot = fakeroot
 
     def eval(self, data):
         text = '\n'.join(self.body)
         funcname = self.func_name
         if self.func_name == "__anonymous":
             funcname = ("__anon_%s_%s" % (self.lineno, self.filename.translate(MethodNode.tr_tbl)))
+            self.python = True
             text = "def %s(d):\n" % (funcname) + text
             bb.methodpool.insert_method(funcname, text, self.filename, self.lineno - len(self.body))
             anonfuncs = data.getVar('__BBANONFUNCS', False) or []
             anonfuncs.append(funcname)
             data.setVar('__BBANONFUNCS', anonfuncs)
-            data.setVarFlag(funcname, "python", 1)
+        if data.getVar(funcname, False):
+            # clean up old version of this piece of metadata, as its
+            # flags could cause problems
+            data.delVarFlag(funcname, 'python')
+            data.delVarFlag(funcname, 'fakeroot')
+        if self.python:
+            data.setVarFlag(funcname, "python", "1")
+        if self.fakeroot:
+            data.setVarFlag(funcname, "fakeroot", "1")
         data.setVarFlag(funcname, "func", 1)
         data.setVar(funcname, text, parsing=True)
         data.setVarFlag(funcname, 'filename', self.filename)
@@ -181,27 +192,6 @@ class PythonMethodNode(AstNode):
         data.setVarFlag(self.function, 'filename', self.filename)
         data.setVarFlag(self.function, 'lineno', str(self.lineno - len(self.body) - 1))
 
-class MethodFlagsNode(AstNode):
-    def __init__(self, filename, lineno, key, m):
-        AstNode.__init__(self, filename, lineno)
-        self.key = key
-        self.m = m
-
-    def eval(self, data):
-        if data.getVar(self.key, False):
-            # clean up old version of this piece of metadata, as its
-            # flags could cause problems
-            data.setVarFlag(self.key, 'python', None)
-            data.setVarFlag(self.key, 'fakeroot', None)
-        if self.m.group("py") is not None:
-            data.setVarFlag(self.key, "python", "1")
-        else:
-            data.delVarFlag(self.key, "python")
-        if self.m.group("fr") is not None:
-            data.setVarFlag(self.key, "fakeroot", "1")
-        else:
-            data.delVarFlag(self.key, "fakeroot")
-
 class ExportFuncsNode(AstNode):
     def __init__(self, filename, lineno, fns, classname):
         AstNode.__init__(self, filename, lineno)
@@ -284,15 +274,12 @@ def handleExport(statements, filename, lineno, m):
 def handleData(statements, filename, lineno, groupd):
     statements.append(DataNode(filename, lineno, groupd))
 
-def handleMethod(statements, filename, lineno, func_name, body):
-    statements.append(MethodNode(filename, lineno, func_name, body))
+def handleMethod(statements, filename, lineno, func_name, body, python, fakeroot):
+    statements.append(MethodNode(filename, lineno, func_name, body, python, fakeroot))
 
 def handlePythonMethod(statements, filename, lineno, funcname, modulename, body):
     statements.append(PythonMethodNode(filename, lineno, funcname, modulename, body))
 
-def handleMethodFlags(statements, filename, lineno, key, m):
-    statements.append(MethodFlagsNode(filename, lineno, key, m))
-
 def handleExportFuncs(statements, filename, lineno, m, classname):
     statements.append(ExportFuncsNode(filename, lineno, m.group(1), classname))
 
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 97a9ee8..ef72c37 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -166,7 +166,7 @@ def feeder(lineno, s, fn, root, statements, eof=False):
     if __infunc__:
         if s == '}':
             __body__.append('')
-            ast.handleMethod(statements, fn, lineno, __infunc__[0], __body__)
+            ast.handleMethod(statements, fn, lineno, __infunc__[0], __body__, __infunc__[3], __infunc__[4])
             __infunc__ = []
             __body__ = []
         else:
@@ -211,8 +211,7 @@ def feeder(lineno, s, fn, root, statements, eof=False):
 
     m = __func_start_regexp__.match(s)
     if m:
-        __infunc__ = [m.group("func") or "__anonymous", fn, lineno]
-        ast.handleMethodFlags(statements, fn, lineno, __infunc__[0], m)
+        __infunc__ = [m.group("func") or "__anonymous", fn, lineno, m.group("py") is not None, m.group("fr") is not None]
         return
 
     m = __def_regexp__.match(s)



