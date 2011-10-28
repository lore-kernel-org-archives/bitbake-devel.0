Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1RJnrR-0003P4-1h
	for bitbake-devel@lists.openembedded.org;
	Fri, 28 Oct 2011 16:56:45 +0200
Received: by ywf9 with SMTP id 9so3659436ywf.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Oct 2011 07:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:subject:date:message-id:x-mailer:in-reply-to:references
	:in-reply-to:references;
	bh=1X3TH2H1dBqlsu/sqaRxUXccyNfdNKOjGa1hX7HsPDk=;
	b=LX5+hZ1NeUjgo1nyxB24PxgRFfLh80lzsWUuyH4lNA8z/HNTMmLZ4jbxIBKgMqVV+N
	RZKJM7ORjZUDFu5EIzaR2oOZxwNnphMuuDGvVhwz0N8pKWX+aWRNi6kc2iLr38xc1AsQ
	96Mm7bs+Nrogsu6UV/rsLvMHbtKlPyFolLQko=
Received: by 10.101.45.5 with SMTP id x5mr662182anj.73.1319813443079;
	Fri, 28 Oct 2011 07:50:43 -0700 (PDT)
Received: from localhost.localdomain (ip24-251-167-38.ph.ph.cox.net.
	[24.251.167.38])
	by mx.google.com with ESMTPS id 4sm25218924ano.9.2011.10.28.07.50.41
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 28 Oct 2011 07:50:42 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Oct 2011 07:50:23 -0700
Message-Id: <3ea5d296f959c8a144d94f4a81d9730e4bba5985.1319813177.git.kergoth@gmail.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1319813177.git.kergoth@gmail.com>
References: <cover.1319813177.git.kergoth@gmail.com>
In-Reply-To: <cover.1319813177.git.kergoth@gmail.com>
References: <cover.1319813177.git.kergoth@gmail.com>
Subject: [PATCH 1/2] codeparser: merge the nested python parsing classes
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
X-List-Received-Date: Fri, 28 Oct 2011 14:56:46 -0000

The split is even less necessary now that we use ast.walk rather than an
actual NodeVisitor subclass.

Signed-off-by: Christopher Larson <kergoth@gmail.com>
---
 lib/bb/codeparser.py |  183 +++++++++++++++++++++++---------------------------
 1 files changed, 84 insertions(+), 99 deletions(-)

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
-        """
+    getvars = ("d.getVar", "bb.data.getVar", "data.getVar")
+    expands = ("d.expand", "bb.data.expand", "data.expand")
+    execfuncs = ("bb.build.exec_func", "bb.build.exec_task")
 
-        getvars = ("d.getVar", "bb.data.getVar", "data.getVar")
-        expands = ("d.expand", "bb.data.expand", "data.expand")
-        execs = ("bb.build.exec_func", "bb.build.exec_task")
+    @classmethod
+    def _compare_name(cls, strparts, node):
+        """Given a sequence of strings representing a python name,
+        where the last component is the actual Name and the prior
+        elements are Attribute nodes, determine if the supplied node
+        matches.
+        """
 
-        @classmethod
-        def _compare_name(cls, strparts, node):
-            """Given a sequence of strings representing a python name,
-            where the last component is the actual Name and the prior
-            elements are Attribute nodes, determine if the supplied node
-            matches.
-            """
+        if not strparts:
+            return True
 
-            if not strparts:
+        current, rest = strparts[0], strparts[1:]
+        if isinstance(node, ast.Attribute):
+            if current == node.attr:
+                return cls._compare_name(rest, node.value)
+        elif isinstance(node, ast.Name):
+            if current == node.id:
                 return True
+        return False
 
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
+    @classmethod
+    def compare_name(cls, value, node):
+        """Convenience function for the _compare_node method, which
+        can accept a string (which is split by '.' for you), or an
+        iterable of strings, in which case it checks to see if any of
+        them match, similar to isinstance.
+        """
 
-            if isinstance(value, basestring):
-                return cls._compare_name(tuple(reversed(value.split("."))),
-                                         node)
-            else:
-                return any(cls.compare_name(item, node) for item in value)
+        if isinstance(value, basestring):
+            return cls._compare_name(tuple(reversed(value.split("."))),
+                                        node)
+        else:
+            return any(cls.compare_name(item, node) for item in value)
 
-        def __init__(self, value):
-            self.var_references = set()
-            self.var_execs = set()
-            self.direct_func_calls = set()
-            self.var_expands = set()
-            self.value = value
+    @classmethod
+    def warn(cls, func, arg):
+        """Warn about calls of bitbake APIs which pass a non-literal
+        argument for the variable name, as we're not able to track such
+        a reference.
+        """
 
-        @classmethod
-        def warn(cls, func, arg):
-            """Warn about calls of bitbake APIs which pass a non-literal
-            argument for the variable name, as we're not able to track such
-            a reference.
-            """
+        try:
+            funcstr = codegen.to_source(func)
+            argstr = codegen.to_source(arg)
+        except TypeError:
+            logger.debug(2, 'Failed to convert function and argument to source form')
+        else:
+            logger.debug(1, "Warning: in call to '%s', argument '%s' is "
+                            "not a literal", funcstr, argstr)
 
-            try:
-                funcstr = codegen.to_source(func)
-                argstr = codegen.to_source(arg)
-            except TypeError:
-                logger.debug(2, 'Failed to convert function and argument to source form')
+    def visit_Call(self, node):
+        if self.compare_name(self.getvars, node.func):
+            if isinstance(node.args[0], ast.Str):
+                self.var_references.add(node.args[0].s)
             else:
-                logger.debug(1, "Warning: in call to '%s', argument '%s' is "
-                                "not a literal", funcstr, argstr)
-
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
-- 
1.7.7



