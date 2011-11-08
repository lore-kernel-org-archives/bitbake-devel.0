Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RNphy-0006FP-0A
	for bitbake-devel@lists.openembedded.org;
	Tue, 08 Nov 2011 18:43:39 +0100
Received: by opal (Postfix, from userid 111)
	id 0FA9A1032E; Tue,  8 Nov 2011 17:37:54 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111108173754.0FA9A1032E@opal>
Date: Tue,  8 Nov 2011 17:37:54 +0000 (UTC)
From: git@git.openembedded.org
Subject: Christopher Larson : codeparser: merge the nested python parsing classes
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
X-List-Received-Date: Tue, 08 Nov 2011 17:43:39 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: d6c44fac184abae8395bfa7078f06675218aa534
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=d6c44fac184abae8395bfa7078f06675218aa534

Author: Christopher Larson <kergoth@gmail.com>
Date:   Thu Oct 27 22:23:05 2011 -0700

codeparser: merge the nested python parsing classes

The split is even less necessary now that we use ast.walk rather than an
actual NodeVisitor subclass.

Signed-off-by: Christopher Larson <kergoth@gmail.com>

---

 lib/bb/codeparser.py |  189 +++++++++++++++++++++++---------------------------
 1 files changed, 87 insertions(+), 102 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 0dd9a36..0f3d646 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -151,116 +151,103 @@ def parser_cache_savemerge(d):
 
 
 class PythonParser():
-    class ValueVisitor():
-        """Visitor to traverse a python abstract syntax tree and obtain
-        the variables referenced via bitbake metadata APIs, and the external
-        functions called.
+    getvars = ("d.getVar", "bb.data.getVar", "data.getVar")
+    expands = ("d.expand", "bb.data.expand", "data.expand")
+    execfuncs = ("bb.build.exec_func", "bb.build.exec_task")
+
+    @classmethod
+    def _compare_name(cls, strparts, node):
+        """Given a sequence of strings representing a python name,
+        where the last component is the actual Name and the prior
+        elements are Attribute nodes, determine if the supplied node
+        matches.
         """
 
-        getvars = ("d.getVar", "bb.data.getVar", "data.getVar")
-        expands = ("d.expand", "bb.data.expand", "data.expand")
-        execs = ("bb.build.exec_func", "bb.build.exec_task")
+        if not strparts:
+            return True
 
-        @classmethod
-        def _compare_name(cls, strparts, node):
-            """Given a sequence of strings representing a python name,
-            where the last component is the actual Name and the prior
-            elements are Attribute nodes, determine if the supplied node
-            matches.
-            """
-
-            if not strparts:
+        current, rest = strparts[0], strparts[1:]
+        if isinstance(node, ast.Attribute):
+            if current == node.attr:
+                return cls._compare_name(rest, node.value)
+        elif isinstance(node, ast.Name):
+            if current == node.id:
                 return True
+        return False
+
+    @classmethod
+    def compare_name(cls, value, node):
+        """Convenience function for the _compare_node method, which
+        can accept a string (which is split by '.' for you), or an
+        iterable of strings, in which case it checks to see if any of
+        them match, similar to isinstance.
+        """
 
-            current, rest = strparts[0], strparts[1:]
-            if isinstance(node, ast.Attribute):
-                if current == node.attr:
-                    return cls._compare_name(rest, node.value)
-            elif isinstance(node, ast.Name):
-                if current == node.id:
-                    return True
-            return False
-
-        @classmethod
-        def compare_name(cls, value, node):
-            """Convenience function for the _compare_node method, which
-            can accept a string (which is split by '.' for you), or an
-            iterable of strings, in which case it checks to see if any of
-            them match, similar to isinstance.
-            """
-
-            if isinstance(value, basestring):
-                return cls._compare_name(tuple(reversed(value.split("."))),
-                                         node)
-            else:
-                return any(cls.compare_name(item, node) for item in value)
-
-        def __init__(self, value):
-            self.var_references = set()
-            self.var_execs = set()
-            self.direct_func_calls = set()
-            self.var_expands = set()
-            self.value = value
-
-        @classmethod
-        def warn(cls, func, arg):
-            """Warn about calls of bitbake APIs which pass a non-literal
-            argument for the variable name, as we're not able to track such
-            a reference.
-            """
+        if isinstance(value, basestring):
+            return cls._compare_name(tuple(reversed(value.split("."))),
+                                        node)
+        else:
+            return any(cls.compare_name(item, node) for item in value)
 
-            try:
-                funcstr = codegen.to_source(func)
-                argstr = codegen.to_source(arg)
-            except TypeError:
-                logger.debug(2, 'Failed to convert function and argument to source form')
-            else:
-                logger.debug(1, "Warning: in call to '%s', argument '%s' is "
-                                "not a literal", funcstr, argstr)
+    @classmethod
+    def warn(cls, func, arg):
+        """Warn about calls of bitbake APIs which pass a non-literal
+        argument for the variable name, as we're not able to track such
+        a reference.
+        """
 
-        def visit_Call(self, node):
-            if self.compare_name(self.getvars, node.func):
-                if isinstance(node.args[0], ast.Str):
-                    self.var_references.add(node.args[0].s)
-                else:
-                    self.warn(node.func, node.args[0])
-            elif self.compare_name(self.expands, node.func):
-                if isinstance(node.args[0], ast.Str):
-                    self.warn(node.func, node.args[0])
-                    self.var_expands.add(node.args[0].s)
-                elif isinstance(node.args[0], ast.Call) and \
-                     self.compare_name(self.getvars, node.args[0].func):
-                    pass
-                else:
-                    self.warn(node.func, node.args[0])
-            elif self.compare_name(self.execs, node.func):
-                if isinstance(node.args[0], ast.Str):
-                    self.var_execs.add(node.args[0].s)
-                else:
-                    self.warn(node.func, node.args[0])
-            elif isinstance(node.func, ast.Name):
-                self.direct_func_calls.add(node.func.id)
-            elif isinstance(node.func, ast.Attribute):
-                # We must have a qualified name.  Therefore we need
-                # to walk the chain of 'Attribute' nodes to determine
-                # the qualification.
-                attr_node = node.func.value
-                identifier = node.func.attr
-                while isinstance(attr_node, ast.Attribute):
-                    identifier = attr_node.attr + "." + identifier
-                    attr_node = attr_node.value
-                if isinstance(attr_node, ast.Name):
-                    identifier = attr_node.id + "." + identifier
-                self.direct_func_calls.add(identifier)
+        try:
+            funcstr = codegen.to_source(func)
+            argstr = codegen.to_source(arg)
+        except TypeError:
+            logger.debug(2, 'Failed to convert function and argument to source form')
+        else:
+            logger.debug(1, "Warning: in call to '%s', argument '%s' is "
+                            "not a literal", funcstr, argstr)
+
+    def visit_Call(self, node):
+        if self.compare_name(self.getvars, node.func):
+            if isinstance(node.args[0], ast.Str):
+                self.var_references.add(node.args[0].s)
+            else:
+                self.warn(node.func, node.args[0])
+        elif self.compare_name(self.expands, node.func):
+            if isinstance(node.args[0], ast.Str):
+                self.warn(node.func, node.args[0])
+                self.var_expands.add(node.args[0].s)
+            elif isinstance(node.args[0], ast.Call) and \
+                    self.compare_name(self.getvars, node.args[0].func):
+                pass
+            else:
+                self.warn(node.func, node.args[0])
+        elif self.compare_name(self.execfuncs, node.func):
+            if isinstance(node.args[0], ast.Str):
+                self.var_execs.add(node.args[0].s)
+            else:
+                self.warn(node.func, node.args[0])
+        elif isinstance(node.func, ast.Name):
+            self.execs.add(node.func.id)
+        elif isinstance(node.func, ast.Attribute):
+            # We must have a qualified name.  Therefore we need
+            # to walk the chain of 'Attribute' nodes to determine
+            # the qualification.
+            attr_node = node.func.value
+            identifier = node.func.attr
+            while isinstance(attr_node, ast.Attribute):
+                identifier = attr_node.attr + "." + identifier
+                attr_node = attr_node.value
+            if isinstance(attr_node, ast.Name):
+                identifier = attr_node.id + "." + identifier
+            self.execs.add(identifier)
 
     def __init__(self):
-        #self.funcdefs = set()
+        self.var_references = set()
+        self.var_execs = set()
         self.execs = set()
-        #self.external_cmds = set()
+        self.var_expands = set()
         self.references = set()
 
     def parse_python(self, node):
-
         h = hash(str(node))
 
         if h in pythonparsecache:
@@ -271,14 +258,12 @@ class PythonParser():
         code = compile(check_indent(str(node)), "<string>", "exec",
                        ast.PyCF_ONLY_AST)
 
-        visitor = self.ValueVisitor(code)
         for n in ast.walk(code):
             if n.__class__.__name__ == "Call":
-                visitor.visit_Call(n)
+                self.visit_Call(n)
 
-        self.references.update(visitor.var_references)
-        self.references.update(visitor.var_execs)
-        self.execs = visitor.direct_func_calls
+        self.references.update(self.var_references)
+        self.references.update(self.var_execs)
 
         pythonparsecache[h] = {}
         pythonparsecache[h]["refs"] = self.references



