Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TiDWW-0005eZ-QC for bitbake-devel@lists.openembedded.org;
	Tue, 11 Dec 2012 01:16:37 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qBB025i3006728;
	Tue, 11 Dec 2012 00:02:05 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 04801-09; Tue, 11 Dec 2012 00:02:01 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qBB01uB9006722
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2012 00:01:58 GMT
Message-ID: <1355184116.6771.1.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 11 Dec 2012 00:01:56 +0000
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: [PATCH] BBHandler/ast: Simplify/fix EXPORT_FUNCTIONS usage
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 11 Dec 2012 00:16:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The current usage of EXPORT_FUNCTIONS is rather problematic since a class
list (classes) is passed into the ast statement and cached as it was
when first parsed. This class list may be different in other cases but
is locked once in the cache.

Worse, the construction of classes can be broken by exceptions during parsing
at the wrong moments since the state of the parser is not always reset
correctly. This can lead to leakage of other classes into the classes list.

The current EXPORT_FUNCTIONS implementation looks at the last two currently
inherited classes and sets up an indirect function call view the second last
class inherited, e.g.:

 do_configure calls gnomebase_do_configure
 gnomebase_do_configure calls autotools_do_configure

This intermediary doesn't seem to serve a useful purpose.

This patch therefore makes builds deterministic and fixes various cache problems
and indirection by removing the intermediaries and simply performing
directly mapping for the cases where its needed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 4caa93e..79e9f7e 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -179,44 +179,35 @@ class MethodFlagsNode(AstNode):
             data.delVarFlag(self.key, "fakeroot")
 
 class ExportFuncsNode(AstNode):
-    def __init__(self, filename, lineno, fns, classes):
+    def __init__(self, filename, lineno, fns, classname):
         AstNode.__init__(self, filename, lineno)
         self.n = fns.split()
-        self.classes = classes
+        self.classname = classname
 
     def eval(self, data):
-        for f in self.n:
-            allvars = []
-            allvars.append(f)
-            allvars.append(self.classes[-1] + "_" + f)
-
-            vars = [[ allvars[0], allvars[1] ]]
-            if len(self.classes) > 1 and self.classes[-2] is not None:
-                allvars.append(self.classes[-2] + "_" + f)
-                vars = []
-                vars.append([allvars[2], allvars[1]])
-                vars.append([allvars[0], allvars[2]])
-
-            for (var, calledvar) in vars:
-                if data.getVar(var) and not data.getVarFlag(var, 'export_func'):
-                    continue
-
-                if data.getVar(var):
-                    data.setVarFlag(var, 'python', None)
-                    data.setVarFlag(var, 'func', None)
-
-                for flag in [ "func", "python" ]:
-                    if data.getVarFlag(calledvar, flag):
-                        data.setVarFlag(var, flag, data.getVarFlag(calledvar, flag))
-                for flag in [ "dirs" ]:
-                    if data.getVarFlag(var, flag):
-                        data.setVarFlag(calledvar, flag, data.getVarFlag(var, flag))
-
-                if data.getVarFlag(calledvar, "python"):
-                    data.setVar(var, "    bb.build.exec_func('" + calledvar + "', d)\n")
-                else:
-                    data.setVar(var, "    " + calledvar + "\n")
-                data.setVarFlag(var, 'export_func', '1')
+
+        for func in self.n:
+            calledfunc = self.classname + "_" + func
+
+            if data.getVar(func) and not data.getVarFlag(func, 'export_func'):
+                continue
+
+            if data.getVar(func):
+                data.setVarFlag(func, 'python', None)
+                data.setVarFlag(func, 'func', None)
+
+            for flag in [ "func", "python" ]:
+                if data.getVarFlag(calledfunc, flag):
+                    data.setVarFlag(func, flag, data.getVarFlag(calledfunc, flag))
+            for flag in [ "dirs" ]:
+                if data.getVarFlag(func, flag):
+                    data.setVarFlag(calledfunc, flag, data.getVarFlag(func, flag))
+
+            if data.getVarFlag(calledfunc, "python"):
+                data.setVar(func, "    bb.build.exec_func('" + calledfunc + "', d)\n")
+            else:
+                data.setVar(func, "    " + calledfunc + "\n")
+            data.setVarFlag(func, 'export_func', '1')
 
 class AddTaskNode(AstNode):
     def __init__(self, filename, lineno, func, before, after):
@@ -288,8 +279,8 @@ def handlePythonMethod(statements, filename, lineno, funcname, modulename, body)
 def handleMethodFlags(statements, filename, lineno, key, m):
     statements.append(MethodFlagsNode(filename, lineno, key, m))
 
-def handleExportFuncs(statements, filename, lineno, m, classes):
-    statements.append(ExportFuncsNode(filename, lineno, m.group(1), classes))
+def handleExportFuncs(statements, filename, lineno, m, classname):
+    statements.append(ExportFuncsNode(filename, lineno, m.group(1), classname))
 
 def handleAddTask(statements, filename, lineno, m):
     func = m.group("func")
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 2e0647b..92c55f5 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -51,7 +51,6 @@ __infunc__ = ""
 __inpython__ = False
 __body__   = []
 __classname__ = ""
-classes = [ None, ]
 
 cached_statements = {}
 
@@ -107,7 +106,7 @@ def get_statements(filename, absolute_filename, base_name):
         return statements
 
 def handle(fn, d, include):
-    global __func_start_regexp__, __inherit_regexp__, __export_func_regexp__, __addtask_regexp__, __addhandler_regexp__, __infunc__, __body__, __residue__
+    global __func_start_regexp__, __inherit_regexp__, __export_func_regexp__, __addtask_regexp__, __addhandler_regexp__, __infunc__, __body__, __residue__, __classname__
     __body__ = []
     __infunc__ = ""
     __classname__ = ""
@@ -125,7 +124,6 @@ def handle(fn, d, include):
 
     if ext == ".bbclass":
         __classname__ = root
-        classes.append(__classname__)
         __inherit_cache = d.getVar('__inherit_cache') or []
         if not fn in __inherit_cache:
             __inherit_cache.append(fn)
@@ -150,11 +148,8 @@ def handle(fn, d, include):
 
     statements.eval(d)
 
-    if ext == ".bbclass":
-        classes.remove(__classname__)
-    else:
-        if include == 0:
-            return ast.multi_finalize(fn, d)
+    if ext != ".bbclass" and include == 0:
+        return ast.multi_finalize(fn, d)
 
     if oldfile:
         d.setVar("FILE", oldfile)
@@ -166,7 +161,7 @@ def handle(fn, d, include):
     return d
 
 def feeder(lineno, s, fn, root, statements):
-    global __func_start_regexp__, __inherit_regexp__, __export_func_regexp__, __addtask_regexp__, __addhandler_regexp__, __def_regexp__, __python_func_regexp__, __inpython__, __infunc__, __body__, classes, bb, __residue__
+    global __func_start_regexp__, __inherit_regexp__, __export_func_regexp__, __addtask_regexp__, __addhandler_regexp__, __def_regexp__, __python_func_regexp__, __inpython__, __infunc__, __body__, bb, __residue__, __classname__
     if __infunc__:
         if s == '}':
             __body__.append('')
@@ -225,7 +220,7 @@ def feeder(lineno, s, fn, root, statements):
 
     m = __export_func_regexp__.match(s)
     if m:
-        ast.handleExportFuncs(statements, fn, lineno, m, classes)
+        ast.handleExportFuncs(statements, fn, lineno, m, __classname__)
         return
 
     m = __addtask_regexp__.match(s)




