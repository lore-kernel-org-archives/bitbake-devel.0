Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id F0BAA601D3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Dec 2015 17:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tBFHfI9Y009029 for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Dec 2015 17:41:18 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id EY1klbRDF2Cy for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Dec 2015 17:41:18 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tBFHfCUO009026
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Dec 2015 17:41:14 GMT
Message-ID: <1450201272.13505.83.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 15 Dec 2015 17:41:12 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] ast/event/utils: Improve tracebacks to include file and line numbers more correctly
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
X-List-Received-Date: Tue, 15 Dec 2015 17:41:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently bitbake tracebacks can have places where the line numbers are
inaccurate and filenames may be missing. These changes start to try and
correct this.

The only way I could find to correct line numbers was to compile as a
python ast, tweak the line numbers then compile to bytecode. I'm open
to better ways of doing this if anyone knows of any.

This does mean passing a few more parameters into functions, and putting
more data into the data store about functions (i.e. their filenames
and line numbers) but the improvement in debugging is more than worthwhile).

Before:
----------------
ERROR: Execution of event handler 'run_buildstats' failed
Traceback (most recent call last):
  File "run_buildstats(e)", line 43, in run_buildstats(e=<bb.build.TaskStarted object at 0x7f7b7c57a590>)
NameError: global name 'notexist' is not defined

ERROR: Build of do_patch failed
ERROR: Traceback (most recent call last):
  File "/media/build1/poky/bitbake/lib/bb/build.py", line 560, in exec_task
    return _exec_task(fn, task, d, quieterr)
  File "/media/build1/poky/bitbake/lib/bb/build.py", line 497, in _exec_task
    event.fire(TaskStarted(task, logfn, flags, localdata), localdata)
  File "/media/build1/poky/bitbake/lib/bb/event.py", line 170, in fire
    fire_class_handlers(event, d)
  File "/media/build1/poky/bitbake/lib/bb/event.py", line 109, in fire_class_handlers
    execute_handler(name, handler, event, d)
  File "/media/build1/poky/bitbake/lib/bb/event.py", line 81, in execute_handler
    ret = handler(event)
  File "run_buildstats(e)", line 43, in run_buildstats
NameError: global name 'notexist' is not defined

----------------

After:
----------------
ERROR: Execution of event handler 'run_buildstats' failed
Traceback (most recent call last):
  File "/media/build1/poky/meta/classes/buildstats.bbclass", line 143, in run_buildstats(e=<bb.build.TaskStarted object at 0x7efe89284e10>):
         if isinstance(e, bb.build.TaskStarted):
    >        trigger = notexist
             pn = d.getVar("PN", True)
NameError: global name 'notexist' is not defined

ERROR: Build of do_package failed
ERROR: Traceback (most recent call last):
  File "/media/build1/poky/bitbake/lib/bb/build.py", line 560, in exec_task
    return _exec_task(fn, task, d, quieterr)
  File "/media/build1/poky/bitbake/lib/bb/build.py", line 497, in _exec_task
    event.fire(TaskStarted(task, logfn, flags, localdata), localdata)
  File "/media/build1/poky/bitbake/lib/bb/event.py", line 170, in fire
    fire_class_handlers(event, d)
  File "/media/build1/poky/bitbake/lib/bb/event.py", line 109, in fire_class_handlers
    execute_handler(name, handler, event, d)
  File "/media/build1/poky/bitbake/lib/bb/event.py", line 81, in execute_handler
    ret = handler(event)
  File "/media/build1/poky/meta/classes/buildstats.bbclass", line 143, in run_buildstats
    trigger = notexist
NameError: global name 'notexist' is not defined
----------------

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 671c0cb..b47e7f3 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -317,7 +317,9 @@ class CookerDataBuilder(object):
         # Nomally we only register event handlers at the end of parsing .bb files
         # We register any handlers we've found so far here...
         for var in data.getVar('__BBHANDLERS', False) or []:
-            bb.event.register(var, data.getVar(var, False),  (data.getVarFlag(var, "eventmask", True) or "").split())
+            handlerfn = data.getVarFlag(var, "filename", False)
+            handlerln = int(data.getVarFlag(var, "lineno", False))
+            bb.event.register(var, data.getVar(var, False),  (data.getVarFlag(var, "eventmask", True) or "").split(), handlerfn, handlerln)
 
         if data.getVar("BB_WORKERCONTEXT", False) is None:
             bb.fetch.fetcher_init(data)
diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index ec25ce7..bd2b0a4 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -177,7 +177,7 @@ def fire_from_worker(event, d):
     fire_ui_handlers(event, d)
 
 noop = lambda _: None
-def register(name, handler, mask=None):
+def register(name, handler, mask=None, filename=None, lineno=None):
     """Register an Event handler"""
 
     # already registered
@@ -189,7 +189,13 @@ def register(name, handler, mask=None):
         if isinstance(handler, basestring):
             tmp = "def %s(e):\n%s" % (name, handler)
             try:
-                code = compile(tmp, "%s(e)" % name, "exec")
+                import ast
+                if filename is None:
+                    filename = "%s(e)" % name
+                code = compile(tmp, filename, "exec", ast.PyCF_ONLY_AST)
+                if lineno is not None:
+                    ast.increment_lineno(code, lineno-1)
+                code = compile(code, filename, "exec")
             except SyntaxError:
                 logger.error("Unable to register event handler '%s':\n%s", name,
                              ''.join(traceback.format_exc(limit=0)))
diff --git a/bitbake/lib/bb/methodpool.py b/bitbake/lib/bb/methodpool.py
index bf2e9f5..b2ea1a1 100644
--- a/bitbake/lib/bb/methodpool.py
+++ b/bitbake/lib/bb/methodpool.py
@@ -19,11 +19,11 @@
 
 from bb.utils import better_compile, better_exec
 
-def insert_method(modulename, code, fn):
+def insert_method(modulename, code, fn, lineno):
     """
     Add code of a module should be added. The methods
     will be simply added, no checking will be done
     """
-    comp = better_compile(code, modulename, fn )
+    comp = better_compile(code, modulename, fn, lineno=lineno)
     better_exec(comp, None, code, fn)
 
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 11db180..e1bf82f 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -148,17 +148,19 @@ class MethodNode(AstNode):
 
     def eval(self, data):
         text = '\n'.join(self.body)
+        funcname = self.func_name
         if self.func_name == "__anonymous":
             funcname = ("__anon_%s_%s" % (self.lineno, self.filename.translate(MethodNode.tr_tbl)))
             text = "def %s(d):\n" % (funcname) + text
-            bb.methodpool.insert_method(funcname, text, self.filename)
+            bb.methodpool.insert_method(funcname, text, self.filename, self.lineno - len(self.body))
             anonfuncs = data.getVar('__BBANONFUNCS', False) or []
             anonfuncs.append(funcname)
             data.setVar('__BBANONFUNCS', anonfuncs)
-            data.setVar(funcname, text, parsing=True)
         else:
             data.setVarFlag(self.func_name, "func", 1)
-            data.setVar(self.func_name, text, parsing=True)
+        data.setVar(funcname, text, parsing=True)
+        data.setVarFlag(funcname, 'filename', self.filename)
+        data.setVarFlag(funcname, 'lineno', str(self.lineno - len(self.body)))
 
 class PythonMethodNode(AstNode):
     def __init__(self, filename, lineno, function, modulename, body):
@@ -172,10 +174,12 @@ class PythonMethodNode(AstNode):
         # 'this' file. This means we will not parse methods from
         # bb classes twice
         text = '\n'.join(self.body)
-        bb.methodpool.insert_method(self.modulename, text, self.filename)
+        bb.methodpool.insert_method(self.modulename, text, self.filename, self.lineno - len(self.body) - 1)
         data.setVarFlag(self.function, "func", 1)
         data.setVarFlag(self.function, "python", 1)
         data.setVar(self.function, text, parsing=True)
+        data.setVarFlag(self.function, 'filename', self.filename)
+        data.setVarFlag(self.function, 'lineno', str(self.lineno - len(self.body) - 1))
 
 class MethodFlagsNode(AstNode):
     def __init__(self, filename, lineno, key, m):
@@ -317,7 +321,9 @@ def finalize(fn, d, variant = None):
     all_handlers = {}
     for var in d.getVar('__BBHANDLERS', False) or []:
         # try to add the handler
-        bb.event.register(var, d.getVar(var, False), (d.getVarFlag(var, "eventmask", True) or "").split())
+        handlerfn = d.getVarFlag(var, "filename", False)
+        handlerln = int(d.getVarFlag(var, "lineno", False))
+        bb.event.register(var, d.getVar(var, False), (d.getVarFlag(var, "eventmask", True) or "").split(), handlerfn, handlerln)
 
     bb.event.fire(bb.event.RecipePreFinalise(fn), d)
 
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 4ed7608..e564bb6 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -33,6 +33,7 @@ import fnmatch
 import traceback
 import errno
 import signal
+import ast
 from commands import getstatusoutput
 from contextlib import contextmanager
 from ctypes import cdll
@@ -291,19 +292,22 @@ def _print_trace(body, line):
             error.append('     %.4d:%s' % (i, body[i-1].rstrip()))
     return error
 
-def better_compile(text, file, realfile, mode = "exec"):
+def better_compile(text, file, realfile, mode = "exec", lineno = None):
     """
     A better compile method. This method
     will print the offending lines.
     """
     try:
-        return compile(text, file, mode)
+        code = compile(text, realfile, mode, ast.PyCF_ONLY_AST)
+        if lineno is not None:
+            ast.increment_lineno(code, lineno)
+        return compile(code, realfile, mode)
     except Exception as e:
         error = []
         # split the text into lines again
         body = text.split('\n')
-        error.append("Error in compiling python function in %s:\n" % realfile)
-        if e.lineno:
+        error.append("Error in compiling python function in %s, line %s:\n" % (realfile, lineno))
+        if hasattr(e, "lineno"):
             error.append("The code lines resulting in this error were:")
             error.extend(_print_trace(body, e.lineno))
         else:



