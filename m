Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id A210F6DEE2
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Dec 2013 12:10:20 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rB3C9kbr006225
	for <bitbake-devel@lists.openembedded.org>; Tue, 3 Dec 2013 12:10:14 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id QT38sLarroFN for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Dec 2013 12:10:14 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rB3CAAXS006232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 3 Dec 2013 12:10:12 GMT
Message-ID: <1386072605.4463.40.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 03 Dec 2013 12:10:05 +0000
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] codeparser/data_smart: Optimise parsing speed
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
X-List-Received-Date: Tue, 03 Dec 2013 12:10:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The previous "contains" changes caused a ~3% parsing speed impact.
Looking at the cause of those changes was interesting:

* Use of defaultdict was slower than just checking for missing entries
  and setting them when needed.
* Even the "import collections" adversely affects parsing speed
* There was a missing intern function for the contains cache data
* Setting up a log object for each variable has noticeable overhead
  due to the changes in the code paths uses, we can avoid this.
* We can call getVarFlag on "_content" directly within VariableParse
  for a noticeable speed gain since its a seriously hot code path.

This patch therefore tweaks the code based on the above observations to
get some of the speed back.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/codeparser.py b/bitbake/lib/bb/codeparser.py
index 6e34eff..62b6cf9 100644
--- a/bitbake/lib/bb/codeparser.py
+++ b/bitbake/lib/bb/codeparser.py
@@ -1,7 +1,6 @@
 import ast
 import codegen
 import logging
-import collections
 import os.path
 import bb.utils, bb.data
 from itertools import chain
@@ -65,6 +64,8 @@ class CodeParserCache(MultiProcessCache):
         for h in data[0]:
             data[0][h]["refs"] = self.internSet(data[0][h]["refs"])
             data[0][h]["execs"] = self.internSet(data[0][h]["execs"])
+            for k in data[0][h]["contains"]:
+                data[0][h]["contains"][k] = self.internSet(data[0][h]["contains"][k])
         for h in data[1]:
             data[1][h]["execs"] = self.internSet(data[1][h]["execs"])
         return
@@ -125,6 +126,8 @@ class PythonParser():
             if isinstance(node.args[0], ast.Str):
                 varname = node.args[0].s
                 if name in self.containsfuncs and isinstance(node.args[1], ast.Str):
+                    if varname not in self.contains:
+                        self.contains[varname] = set()
                     self.contains[varname].add(node.args[1].s)
                 else:                      
                     self.references.add(node.args[0].s)
@@ -153,10 +156,10 @@ class PythonParser():
 
     def __init__(self, name, log):
         self.var_execs = set()
-        self.contains = collections.defaultdict(set)
+        self.contains = {}
         self.execs = set()
         self.references = set()
-        self.log = BufferedLogger('BitBake.Data.%s' % name, logging.DEBUG, log)
+        self.log = BufferedLogger('BitBake.Data.PythonParser', logging.DEBUG, log)
 
         self.unhandled_message = "in call of %s, argument '%s' is not a string literal"
         self.unhandled_message = "while parsing %s, %s" % (name, self.unhandled_message)
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 9a6f767..833d9f1 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -35,7 +35,6 @@ import hashlib
 import bb, bb.codeparser
 from bb   import utils
 from bb.COW  import COWDictBase
-import collections
 
 logger = logging.getLogger("BitBake.Data")
 
@@ -89,7 +88,7 @@ class VariableParse:
 
         self.references = set()
         self.execs = set()
-        self.contains = collections.defaultdict(set)
+        self.contains = {}
 
     def var_sub(self, match):
             key = match.group()[2:-1]
@@ -100,7 +99,7 @@ class VariableParse:
                 varparse = self.d.expand_cache[key]
                 var = varparse.value
             else:
-                var = self.d.getVar(key, True)
+                var = self.d.getVarFlag(key, "_content", True)
             self.references.add(key)
             if var is not None:
                 return var
@@ -123,7 +122,10 @@ class VariableParse:
             self.execs |= parser.execs
 
             for k in parser.contains:
-                self.contains[k].update(parser.contains[k])
+                if k not in self.contains:
+                    self.contains[k] = parser.contains[k]
+                else:
+                    self.contains[k].update(parser.contains[k])
             value = utils.better_eval(codeobj, DataContext(self.d))
             return str(value)
 



