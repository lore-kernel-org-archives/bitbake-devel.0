Return-Path: <denis@denix.org>
Received: from vms173003pub.verizon.net (vms173003pub.verizon.net
	[206.46.173.3])
	by mail.openembedded.org (Postfix) with ESMTP id 000E26C000
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Sep 2013 16:34:05 +0000 (UTC)
Received: from gandalf.denix.org ([unknown] [108.45.150.102])
	by vms173003.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0MSX00H1Z4NTDGT0@vms173003.mailsrvcs.net> for
	bitbake-devel@lists.openembedded.org;
	Tue, 10 Sep 2013 11:33:45 -0500 (CDT)
Received: from elrond.denix (elrond [192.168.0.7])
	by gandalf.denix.org (Postfix) with ESMTP id 1B5AC20033; Tue,
	10 Sep 2013 12:33:29 -0400 (EDT)
From: Denys Dmytriyenko <denis@denix.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Sep 2013 12:33:27 -0400
Message-id: <1378830807-24027-2-git-send-email-denis@denix.org>
X-Mailer: git-send-email 1.8.3.2
In-reply-to: <1378830807-24027-1-git-send-email-denis@denix.org>
References: <1378830807-24027-1-git-send-email-denis@denix.org>
Subject: [1.18][PATCH] methodpool: Retire it, remove global method scope
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
X-List-Received-Date: Tue, 10 Sep 2013 16:34:06 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

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
Tested-by: Denys Dmytriyenko <denys@ti.com>
---
 lib/bb/cooker.py                   |  2 ++
 lib/bb/methodpool.py               | 43 --------------------------------------
 lib/bb/parse/ast.py                |  8 +++----
 lib/bb/parse/parse_py/BBHandler.py |  4 ----
 4 files changed, 5 insertions(+), 52 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 2c54209..4d6cf81 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1606,6 +1606,7 @@ class Parser(multiprocessing.Process):
         self.quit = quit
         self.init = init
         multiprocessing.Process.__init__(self)
+        self.context = bb.utils._context.copy()
 
     def run(self):
         if self.init:
@@ -1640,6 +1641,7 @@ class Parser(multiprocessing.Process):
 
     def parse(self, filename, appends, caches_array):
         try:
+            bb.utils._context = self.context.copy()
             return True, bb.cache.Cache.parse(filename, appends, self.cfg, caches_array)
         except Exception as exc:
             tb = sys.exc_info()[2]
diff --git a/lib/bb/methodpool.py b/lib/bb/methodpool.py
index 2fb5d96..3cf2040 100644
--- a/lib/bb/methodpool.py
+++ b/lib/bb/methodpool.py
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
@@ -43,29 +26,3 @@ def insert_method(modulename, code, fn):
     """
     comp = better_compile(code, modulename, fn )
     better_exec(comp, None, code, fn)
-
-    # now some instrumentation
-    code = comp.co_names
-    for name in code:
-        if name in ['None', 'False']:
-            continue
-        elif name in _parsed_fns and not _parsed_fns[name] == modulename:
-            error("The function %s defined in %s was already declared in %s. BitBake has a global python function namespace so shared functions should be declared in a common include file rather than being duplicated, or if the functions are different, please use different function names." % (name, modulename, _parsed_fns[name]))
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
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index b2657f8..713bef1 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
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
diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index 81fb8d3..2aba9a0 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -166,10 +166,6 @@ def handle(fn, d, include):
     if oldfile:
         d.setVar("FILE", oldfile)
 
-    # we have parsed the bb class now
-    if ext == ".bbclass" or ext == ".inc":
-        bb.methodpool.set_parsed_module(base_name)
-
     return d
 
 def feeder(lineno, s, fn, root, statements):
-- 
1.8.3.2


