Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RNphy-0006FN-ES
	for bitbake-devel@lists.openembedded.org;
	Tue, 08 Nov 2011 18:43:38 +0100
Received: by opal (Postfix, from userid 111)
	id 8F8F510336; Tue,  8 Nov 2011 17:37:54 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111108173754.8F8F510336@opal>
Date: Tue,  8 Nov 2011 17:37:54 +0000 (UTC)
From: git@git.openembedded.org
Subject: Christopher Larson : codeparser: silence non-literal warnings for vardeps
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
X-List-Received-Date: Tue, 08 Nov 2011 17:43:38 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: e724b9f417d1baf898f5afc6376c73c1a2ad8db9
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=e724b9f417d1baf898f5afc6376c73c1a2ad8db9

Author: Christopher Larson <chris_larson@mentor.com>
Date:   Fri Nov  4 14:59:46 2011 -0400

codeparser: silence non-literal warnings for vardeps

If the vardeps flag is not None, we now silence the warnings about
non-literal usage for that variable.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>

---

 lib/bb/codeparser.py |   28 +++++++++++++++++++++++-----
 lib/bb/data.py       |   14 +++++++++-----
 lib/bb/data_smart.py |    8 +++++++-
 3 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 615fb7d..d425514 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -150,6 +150,22 @@ def parser_cache_savemerge(d):
     bb.utils.unlockfile(glf)
 
 
+Logger = logging.getLoggerClass()
+class BufferedLogger(Logger):
+    def __init__(self, name, level=0, target=None):
+        Logger.__init__(self, name)
+        self.setLevel(level)
+        self.buffer = []
+        self.target = target
+
+    def handle(self, record):
+        self.buffer.append(record)
+
+    def flush(self):
+        for record in self.buffer:
+            self.target.handle(record)
+        self.buffer = []
+
 class PythonParser():
     getvars = ("d.getVar", "bb.data.getVar", "data.getVar")
     execfuncs = ("bb.build.exec_func", "bb.build.exec_task")
@@ -164,9 +180,9 @@ class PythonParser():
             funcstr = codegen.to_source(func)
             argstr = codegen.to_source(arg)
         except TypeError:
-            logger.debug(2, 'Failed to convert function and argument to source form')
+            self.log.debug(2, 'Failed to convert function and argument to source form')
         else:
-            logger.debug(1, self.unhandled_message % (funcstr, argstr))
+            self.log.debug(1, self.unhandled_message % (funcstr, argstr))
 
     def visit_Call(self, node):
         name = self.called_node_name(node.func)
@@ -196,11 +212,12 @@ class PythonParser():
             else:
                 break
 
-    def __init__(self, name):
+    def __init__(self, name, log):
         self.var_references = set()
         self.var_execs = set()
         self.execs = set()
         self.references = set()
+        self.log = BufferedLogger('BitBake.Data.%s' % name, logging.DEBUG, log)
 
         self.unhandled_message = "in call of %s, argument '%s' is not a string literal"
         self.unhandled_message = "while parsing %s, %s" % (name, self.unhandled_message)
@@ -228,10 +245,11 @@ class PythonParser():
         pythonparsecache[h]["execs"] = self.execs
 
 class ShellParser():
-    def __init__(self, name):
+    def __init__(self, name, log):
         self.funcdefs = set()
         self.allexecs = set()
         self.execs = set()
+        self.log = BufferedLogger('BitBake.Data.%s' % name, logging.DEBUG, log)
         self.unhandled_template = "unable to handle non-literal command '%s'"
         self.unhandled_template = "while parsing %s, %s" % (name, self.unhandled_template)
 
@@ -348,7 +366,7 @@ class ShellParser():
 
                 cmd = word[1]
                 if cmd.startswith("$"):
-                    logger.debug(1, self.unhandled_template % cmd)
+                    self.log.debug(1, self.unhandled_template % cmd)
                 elif cmd == "eval":
                     command = " ".join(word for _, word in words[1:])
                     self.parse_shell(command)
diff --git a/lib/bb/data.py b/lib/bb/data.py
index bcb8b05..10188f3 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -49,6 +49,7 @@ from bb import data_smart
 from bb import codeparser
 import bb
 
+logger = data_smart.logger
 _dict_type = data_smart.DataSmart
 
 def init():
@@ -258,7 +259,7 @@ def emit_func(func, o=sys.__stdout__, d = init()):
         emit_var(key, o, d, False) and o.write('\n')
 
     emit_var(func, o, d, False) and o.write('\n')
-    newdeps = bb.codeparser.ShellParser(func).parse_shell(d.getVar(func, True))
+    newdeps = bb.codeparser.ShellParser(func, logger).parse_shell(d.getVar(func, True))
     seen = set()
     while newdeps:
         deps = newdeps
@@ -267,7 +268,7 @@ def emit_func(func, o=sys.__stdout__, d = init()):
         for dep in deps:
             if bb.data.getVarFlag(dep, "func", d):
                emit_var(dep, o, d, False) and o.write('\n')
-               newdeps |=  bb.codeparser.ShellParser(dep).parse_shell(d.getVar(dep, True))
+               newdeps |=  bb.codeparser.ShellParser(dep, logger).parse_shell(d.getVar(dep, True))
         newdeps -= seen
 
 def update_data(d):
@@ -276,25 +277,28 @@ def update_data(d):
 
 def build_dependencies(key, keys, shelldeps, d):
     deps = set()
+    vardeps = d.getVarFlag(key, "vardeps", True)
     try:
         if d.getVarFlag(key, "func"):
             if d.getVarFlag(key, "python"):
                 parsedvar = d.expandWithRefs(d.getVar(key, False), key)
-                parser = bb.codeparser.PythonParser(key)
+                parser = bb.codeparser.PythonParser(key, logger)
                 parser.parse_python(parsedvar.value)
                 deps = deps | parser.references
             else:
                 parsedvar = d.expandWithRefs(d.getVar(key, False), key)
-                parser = bb.codeparser.ShellParser(key)
+                parser = bb.codeparser.ShellParser(key, logger)
                 parser.parse_shell(parsedvar.value)
                 deps = deps | shelldeps
+            if vardeps is None:
+                parser.log.flush()
             deps = deps | parsedvar.references
             deps = deps | (keys & parser.execs) | (keys & parsedvar.execs)
         else:
             parser = d.expandWithRefs(d.getVar(key, False), key)
             deps |= parser.references
             deps = deps | (keys & parser.execs)
-        deps |= set((d.getVarFlag(key, "vardeps", True) or "").split())
+        deps |= set((vardeps or "").split())
         deps -= set((d.getVarFlag(key, "vardepsexclude", True) or "").split())
     except:
         bb.note("Error expanding variable %s" % key)
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 44369ed..072f403 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -68,8 +68,14 @@ class VariableParse:
             code = match.group()[3:-1]
             codeobj = compile(code.strip(), self.varname or "<expansion>", "eval")
 
-            parser = bb.codeparser.PythonParser(self.varname)
+            parser = bb.codeparser.PythonParser(self.varname, logger)
             parser.parse_python(code)
+            if self.varname:
+                vardeps = self.d.getVarFlag(self.varname, "vardeps", True)
+                if vardeps is None:
+                    parser.log.flush()
+            else:
+                parser.log.flush()
             self.references |= parser.references
             self.execs |= parser.execs
 



