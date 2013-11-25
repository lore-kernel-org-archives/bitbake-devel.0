Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id D29A16D959
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 22:59:51 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAPMxj5r025887 for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 22:59:45 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wbYGxfR74FcP for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 22:59:45 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAPMxgZ2025884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 22:59:43 GMT
Message-ID: <1385420379.24083.22.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 25 Nov 2013 22:59:39 +0000
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] data/codeparser: Improve handling of contains functions
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
X-List-Received-Date: Mon, 25 Nov 2013 22:59:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

One of the current frustrations with the sstate checksums is that
code like base_contains('X', 'y',...) adds a full dependency on X
and varies depend even on whitespace changes in X.

This patch adds special handling of the contains functions to expand
the first parameter and check for the flag specified by the second
parameter (assuming its a string).

The result is then appended to the value of the variable with a "Set"
or "Unset" status. If the flag is added/removed, the stored variable
value changes and hence the checksum changes. No dependency on X
is added so it is free to change with regard to other flags or
whitespace.

This code is far from ideal, ideally we'd have properly typed variables
however it fixes a major annoyance of the current checksums and
is of enough value its worth adding in a stopgap solution. It shouldn't
significantly restrict any propely typed variable implementation in
future.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/codeparser.py b/bitbake/lib/bb/codeparser.py
index 1164815..6e34eff 100644
--- a/bitbake/lib/bb/codeparser.py
+++ b/bitbake/lib/bb/codeparser.py
@@ -1,6 +1,7 @@
 import ast
 import codegen
 import logging
+import collections
 import os.path
 import bb.utils, bb.data
 from itertools import chain
@@ -35,7 +36,7 @@ def check_indent(codestr):
 
 class CodeParserCache(MultiProcessCache):
     cache_file_name = "bb_codeparser.dat"
-    CACHE_VERSION = 3
+    CACHE_VERSION = 4
 
     def __init__(self):
         MultiProcessCache.__init__(self)
@@ -122,7 +123,11 @@ class PythonParser():
         name = self.called_node_name(node.func)
         if name in self.getvars or name in self.containsfuncs:
             if isinstance(node.args[0], ast.Str):
-                self.references.add(node.args[0].s)
+                varname = node.args[0].s
+                if name in self.containsfuncs and isinstance(node.args[1], ast.Str):
+                    self.contains[varname].add(node.args[1].s)
+                else:                      
+                    self.references.add(node.args[0].s)
             else:
                 self.warn(node.func, node.args[0])
         elif name in self.execfuncs:
@@ -148,6 +153,7 @@ class PythonParser():
 
     def __init__(self, name, log):
         self.var_execs = set()
+        self.contains = collections.defaultdict(set)
         self.execs = set()
         self.references = set()
         self.log = BufferedLogger('BitBake.Data.%s' % name, logging.DEBUG, log)
@@ -161,14 +167,15 @@ class PythonParser():
         if h in codeparsercache.pythoncache:
             self.references = codeparsercache.pythoncache[h]["refs"]
             self.execs = codeparsercache.pythoncache[h]["execs"]
+            self.contains = codeparsercache.pythoncache[h]["contains"]
             return
 
         if h in codeparsercache.pythoncacheextras:
             self.references = codeparsercache.pythoncacheextras[h]["refs"]
             self.execs = codeparsercache.pythoncacheextras[h]["execs"]
+            self.contains = codeparsercache.pythoncacheextras[h]["contains"]
             return
 
-
         code = compile(check_indent(str(node)), "<string>", "exec",
                        ast.PyCF_ONLY_AST)
 
@@ -181,6 +188,7 @@ class PythonParser():
         codeparsercache.pythoncacheextras[h] = {}
         codeparsercache.pythoncacheextras[h]["refs"] = self.references
         codeparsercache.pythoncacheextras[h]["execs"] = self.execs
+        codeparsercache.pythoncacheextras[h]["contains"] = self.contains
 
 class ShellParser():
     def __init__(self, name, log):
diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index bdd1e79..3d2c6a4 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -299,6 +299,21 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
         vardeps = varflags.get("vardeps")
         value = d.getVar(key, False)
 
+        def handle_contains(value, contains, d):
+            newvalue = ""
+            for k in contains:
+                l = (d.getVar(k, True) or "").split()
+                for word in contains[k]:
+                    if word in l:
+                        newvalue += "\n%s{%s} = Set" %  (k, word)
+                    else:
+                        newvalue += "\n%s{%s} = Unset" %  (k, word)
+            if not newvalue:
+                return value
+            if not value:
+                return newvalue
+            return value + newvalue
+
         if "vardepvalue" in varflags:
            value = varflags.get("vardepvalue")
         elif varflags.get("func"):
@@ -309,6 +324,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
                     logger.warn("Variable %s contains tabs, please remove these (%s)" % (key, d.getVar("FILE", True)))
                 parser.parse_python(parsedvar.value)
                 deps = deps | parser.references
+                value = handle_contains(value, parser.contains, d)
             else:
                 parsedvar = d.expandWithRefs(value, key)
                 parser = bb.codeparser.ShellParser(key, logger)
@@ -318,10 +334,12 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
                 parser.log.flush()
             deps = deps | parsedvar.references
             deps = deps | (keys & parser.execs) | (keys & parsedvar.execs)
+            value = handle_contains(value, parsedvar.contains, d)
         else:
             parser = d.expandWithRefs(value, key)
             deps |= parser.references
             deps = deps | (keys & parser.execs)
+            value = handle_contains(value, parser.contains, d)
 
         # Add varflags, assuming an exclusion list is set
         if varflagsexcl:
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index a1cbaba..9a6f767 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -35,6 +35,7 @@ import hashlib
 import bb, bb.codeparser
 from bb   import utils
 from bb.COW  import COWDictBase
+import collections
 
 logger = logging.getLogger("BitBake.Data")
 
@@ -88,6 +89,7 @@ class VariableParse:
 
         self.references = set()
         self.execs = set()
+        self.contains = collections.defaultdict(set)
 
     def var_sub(self, match):
             key = match.group()[2:-1]
@@ -120,6 +122,8 @@ class VariableParse:
             self.references |= parser.references
             self.execs |= parser.execs
 
+            for k in parser.contains:
+                self.contains[k].update(parser.contains[k])
             value = utils.better_eval(codeobj, DataContext(self.d))
             return str(value)
 



