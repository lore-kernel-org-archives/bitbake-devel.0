Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 4550E6086B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 May 2013 09:47:28 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4N9p8KU017288; Thu, 23 May 2013 10:51:09 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SQLiDJJxB6p2; Thu, 23 May 2013 10:51:08 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4N9p16J017273
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Thu, 23 May 2013 10:51:02 +0100
Message-ID: <1369302430.14887.25.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 23 May 2013 10:47:10 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] methodpool: Retire it, remove global method scope
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 23 May 2013 09:47:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Having a global method scope confuses users and with the introduction
of parallel parsing, its not even possible to correctly detect conflicting
functions. Rather than try and fix that, its simpler to retire the global
method scope and restrict functions to those locations they're defined
within. This is more what users actually expect too.

If we remove the global function scope, the need for methodpool is reduced
to the point we may as well retire it. There is some small loss of caching
of parsed functions but timing measurements so the impact to be neglibile
in the overall parsing time.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index daf37eb..eed489f 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1454,6 +1454,7 @@ class Parser(multiprocessing.Process):
         self.quit = quit
         self.init = init
         multiprocessing.Process.__init__(self)
+        self.context = bb.utils._context.copy()
 
     def run(self):
         if self.init:
@@ -1488,6 +1489,7 @@ class Parser(multiprocessing.Process):
 
     def parse(self, filename, appends, caches_array):
         try:
+            bb.utils._context = self.context.copy()
             return True, bb.cache.Cache.parse(filename, appends, self.cfg, caches_array)
         except Exception as exc:
             tb = sys.exc_info()[2]
diff --git a/bitbake/lib/bb/methodpool.py b/bitbake/lib/bb/methodpool.py
index 8ad23c6..bf2e9f5 100644
--- a/bitbake/lib/bb/methodpool.py
+++ b/bitbake/lib/bb/methodpool.py
@@ -17,24 +17,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-
-"""
-    What is a method pool?
-
-    BitBake has a global method scope where .bb, .inc and .bbclass
-    files can install methods. These methods are parsed from strings.
-    To avoid recompiling and executing these string we introduce
-    a method pool to do this task.
-
-    This pool will be used to compile and execute the functions. It
-    will be smart enough to
-"""
-
 from bb.utils import better_compile, better_exec
-from bb       import error
-
-# A dict of function names we have seen
-_parsed_fns     = { }
 
 def insert_method(modulename, code, fn):
     """
@@ -44,28 +27,3 @@ def insert_method(modulename, code, fn):
     comp = better_compile(code, modulename, fn )
     better_exec(comp, None, code, fn)
 
-    # now some instrumentation
-    code = comp.co_names
-    for name in code:
-        if name in ['None', 'False']:
-            continue
-        elif name in _parsed_fns and not _parsed_fns[name] == modulename:
-            bb.fatal("The function %s defined in %s was already declared in %s. BitBake has a global python function namespace so shared functions should be declared in a common include file rather than being duplicated, or if the functions are different, please use different function names." % (name, modulename, _parsed_fns[name]))
-        else:
-            _parsed_fns[name] = modulename
-
-# A dict of modules the parser has finished with
-_parsed_methods = {}
-
-def parsed_module(modulename):
-    """
-    Has module been parsed?
-    """
-    return modulename in _parsed_methods
-
-def set_parsed_module(modulename):
-    """
-    Set module as parsed
-    """
-    _parsed_methods[modulename] = True
-
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index b2657f8..713bef1 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -148,9 +148,8 @@ class MethodNode(AstNode):
         text = '\n'.join(self.body)
         if self.func_name == "__anonymous":
             funcname = ("__anon_%s_%s" % (self.lineno, self.filename.translate(string.maketrans('/.+-', '____'))))
-            if not funcname in bb.methodpool._parsed_fns:
-                text = "def %s(d):\n" % (funcname) + text
-                bb.methodpool.insert_method(funcname, text, self.filename)
+            text = "def %s(d):\n" % (funcname) + text
+            bb.methodpool.insert_method(funcname, text, self.filename)
             anonfuncs = data.getVar('__BBANONFUNCS') or []
             anonfuncs.append(funcname)
             data.setVar('__BBANONFUNCS', anonfuncs)
@@ -171,8 +170,7 @@ class PythonMethodNode(AstNode):
         # 'this' file. This means we will not parse methods from
         # bb classes twice
         text = '\n'.join(self.body)
-        if not bb.methodpool.parsed_module(self.modulename):
-            bb.methodpool.insert_method(self.modulename, text, self.filename)
+        bb.methodpool.insert_method(self.modulename, text, self.filename)
         data.setVarFlag(self.function, "func", 1)
         data.setVarFlag(self.function, "python", 1)
         data.setVar(self.function, text)
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 87a1530..01f22d3 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -167,10 +167,6 @@ def handle(fn, d, include):
     if oldfile:
         d.setVar("FILE", oldfile)
 
-    # we have parsed the bb class now
-    if ext == ".bbclass" or ext == ".inc":
-        bb.methodpool.set_parsed_module(base_name)
-
     return d
 
 def feeder(lineno, s, fn, root, statements):



