Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RNphy-0006FU-Mv
	for bitbake-devel@lists.openembedded.org;
	Tue, 08 Nov 2011 18:43:39 +0100
Received: by opal (Postfix, from userid 111)
	id 4152410332; Tue,  8 Nov 2011 17:37:54 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111108173754.4152410332@opal>
Date: Tue,  8 Nov 2011 17:37:54 +0000 (UTC)
From: git@git.openembedded.org
Subject: Christopher Larson : codeparser: accept a name for better messages
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
Commit: 1060193ae4d54e667735dbff5d1d2be49a3f95c9
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=1060193ae4d54e667735dbff5d1d2be49a3f95c9

Author: Christopher Larson <chris_larson@mentor.com>
Date:   Fri Oct 28 21:32:26 2011 -0400

codeparser: accept a name for better messages

- If a name is passed to the parser, prepend the messages with "while
  parsing <name>:". This gives a bit more context.
- Tweak the warning messages slightly (they had to be altered anyway to
  inject the variable being parsed).

Before:
  DEBUG: Warning: in call to 'bb.data.getVar': argument ''%s' % var' is \
         not a literal

After:
  DEBUG: while parsing emit_pkgdata, in call of bb.data.getVar, argument \
         ''%s' % var' is not a string literal

Signed-off-by: Christopher Larson <chris_larson@mentor.com>

---

 lib/bb/codeparser.py |   18 ++++++++++--------
 lib/bb/data.py       |    8 ++++----
 lib/bb/data_smart.py |    2 +-
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 7715613..9a692a0 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -155,8 +155,7 @@ class PythonParser():
     expands = ("d.expand", "bb.data.expand", "data.expand")
     execfuncs = ("bb.build.exec_func", "bb.build.exec_task")
 
-    @classmethod
-    def warn(cls, func, arg):
+    def warn(self, func, arg):
         """Warn about calls of bitbake APIs which pass a non-literal
         argument for the variable name, as we're not able to track such
         a reference.
@@ -168,8 +167,7 @@ class PythonParser():
         except TypeError:
             logger.debug(2, 'Failed to convert function and argument to source form')
         else:
-            logger.debug(1, "Warning: in call to '%s', argument '%s' is "
-                            "not a literal", funcstr, argstr)
+            logger.debug(1, self.unhandled_message % (funcstr, argstr))
 
     def visit_Call(self, node):
         name = self.called_node_name(node.func)
@@ -208,13 +206,16 @@ class PythonParser():
             else:
                 break
 
-    def __init__(self):
+    def __init__(self, name):
         self.var_references = set()
         self.var_execs = set()
         self.execs = set()
         self.var_expands = set()
         self.references = set()
 
+        self.unhandled_message = "in call of %s, argument '%s' is not a string literal"
+        self.unhandled_message = "while parsing %s, %s" % (name, self.unhandled_message)
+
     def parse_python(self, node):
         h = hash(str(node))
 
@@ -238,10 +239,12 @@ class PythonParser():
         pythonparsecache[h]["execs"] = self.execs
 
 class ShellParser():
-    def __init__(self):
+    def __init__(self, name):
         self.funcdefs = set()
         self.allexecs = set()
         self.execs = set()
+        self.unhandled_template = "unable to handle non-literal command '%s'"
+        self.unhandled_template = "while parsing %s, %s" % (name, self.unhandled_template)
 
     def parse_shell(self, value):
         """Parse the supplied shell code in a string, returning the external
@@ -356,8 +359,7 @@ class ShellParser():
 
                 cmd = word[1]
                 if cmd.startswith("$"):
-                    logger.debug(1, "Warning: execution of non-literal "
-                                    "command '%s'", cmd)
+                    logger.debug(1, self.unhandled_template % cmd)
                 elif cmd == "eval":
                     command = " ".join(word for _, word in words[1:])
                     self.parse_shell(command)
diff --git a/lib/bb/data.py b/lib/bb/data.py
index ac0d880..bcb8b05 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -258,7 +258,7 @@ def emit_func(func, o=sys.__stdout__, d = init()):
         emit_var(key, o, d, False) and o.write('\n')
 
     emit_var(func, o, d, False) and o.write('\n')
-    newdeps = bb.codeparser.ShellParser().parse_shell(d.getVar(func, True))
+    newdeps = bb.codeparser.ShellParser(func).parse_shell(d.getVar(func, True))
     seen = set()
     while newdeps:
         deps = newdeps
@@ -267,7 +267,7 @@ def emit_func(func, o=sys.__stdout__, d = init()):
         for dep in deps:
             if bb.data.getVarFlag(dep, "func", d):
                emit_var(dep, o, d, False) and o.write('\n')
-               newdeps |=  bb.codeparser.ShellParser().parse_shell(d.getVar(dep, True))
+               newdeps |=  bb.codeparser.ShellParser(dep).parse_shell(d.getVar(dep, True))
         newdeps -= seen
 
 def update_data(d):
@@ -280,12 +280,12 @@ def build_dependencies(key, keys, shelldeps, d):
         if d.getVarFlag(key, "func"):
             if d.getVarFlag(key, "python"):
                 parsedvar = d.expandWithRefs(d.getVar(key, False), key)
-                parser = bb.codeparser.PythonParser()
+                parser = bb.codeparser.PythonParser(key)
                 parser.parse_python(parsedvar.value)
                 deps = deps | parser.references
             else:
                 parsedvar = d.expandWithRefs(d.getVar(key, False), key)
-                parser = bb.codeparser.ShellParser()
+                parser = bb.codeparser.ShellParser(key)
                 parser.parse_shell(parsedvar.value)
                 deps = deps | shelldeps
             deps = deps | parsedvar.references
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index d8ba24f..44369ed 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -68,7 +68,7 @@ class VariableParse:
             code = match.group()[3:-1]
             codeobj = compile(code.strip(), self.varname or "<expansion>", "eval")
 
-            parser = bb.codeparser.PythonParser()
+            parser = bb.codeparser.PythonParser(self.varname)
             parser.parse_python(code)
             self.references |= parser.references
             self.execs |= parser.execs



