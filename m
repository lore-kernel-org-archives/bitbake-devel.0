Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 6E80975D86
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jul 2015 14:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExO8N026688; Wed, 8 Jul 2015 15:59:25 +0100
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id TmTbPimBs7wy; Wed,  8 Jul 2015 15:59:24 +0100 (BST)
Received: from ted (5751f4a1.skybroadband.com [87.81.244.161])
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExM4f026604
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 8 Jul 2015 15:59:23 +0100
Received: from richard by ted with local (Exim 4.84_RC1)
	(envelope-from <richard@dan.rpsys.net>)
	id 1ZCqof-0004Sd-KS; Wed, 08 Jul 2015 15:59:17 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jul 2015 15:59:01 +0100
Message-Id: <3046b068adbb903f30015d5f11441cd4d2cf58b7.1436367362.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
References: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
References: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 07/16] parse/ast/data_smart: Add parsing flag to getVar/setVar
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
X-List-Received-Date: Wed, 08 Jul 2015 14:59:26 -0000

When parsing we find problems if we clear prepends/appends when
setting variables during the initial parsing phases. Later, we actively
want to do this (in what would be post finalisation previously).

To handle this, pass a parsing flag to the operations to control
the correct behaviour for the context.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 36 +++++++++++++++++++++---------------
 lib/bb/parse/ast.py  | 14 +++++++-------
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 28ea2ae..68efc7b 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -386,6 +386,10 @@ class DataSmart(MutableMapping):
 
     def setVar(self, var, value, **loginfo):
         #print("var=" + str(var) + "  val=" + str(value))
+        parsing=False
+        if 'parsing' in loginfo:
+            parsing=True
+
         if 'op' not in loginfo:
             loginfo['op'] = "set"
         self.expand_cache = {}
@@ -421,12 +425,13 @@ class DataSmart(MutableMapping):
         if not var in self.dict:
             self._makeShadowCopy(var)
 
-        if "_append" in self.dict[var]:
-            del self.dict[var]["_append"]
-        if "_prepend" in self.dict[var]:
-            del self.dict[var]["_prepend"]
-        if "_overrides" in self.dict[var]:
-            del self.dict[var]["_overrides"]
+        if not parsing:
+            if "_append" in self.dict[var]:
+                del self.dict[var]["_append"]
+            if "_prepend" in self.dict[var]:
+                del self.dict[var]["_prepend"]
+            if "_overrides" in self.dict[var]:
+                del self.dict[var]["_overrides"]
 
         # more cookies for the cookie monster
         if '_' in var:
@@ -464,20 +469,20 @@ class DataSmart(MutableMapping):
                 if len(shortvar) == 0:
                     override = None
 
-    def getVar(self, var, expand=False, noweakdefault=False):
-        return self.getVarFlag(var, "_content", expand, noweakdefault)
+    def getVar(self, var, expand=False, noweakdefault=False, parsing=False):
+        return self.getVarFlag(var, "_content", expand, noweakdefault, parsing)
 
     def renameVar(self, key, newkey, **loginfo):
         """
         Rename the variable key to newkey
         """
-        val = self.getVar(key, 0)
+        val = self.getVar(key, 0, parsing=True)
         if val is not None:
             loginfo['variable'] = newkey
             loginfo['op'] = 'rename from %s' % key
             loginfo['detail'] = val
             self.varhistory.record(**loginfo)
-            self.setVar(newkey, val, ignore=True)
+            self.setVar(newkey, val, ignore=True, parsing=True)
 
         for i in (__setvar_keyword__):
             src = self.getVarFlag(key, i)
@@ -545,11 +550,10 @@ class DataSmart(MutableMapping):
                 self.dict["__exportlist"]["_content"] = set()
             self.dict["__exportlist"]["_content"].add(var)
 
-    def getVarFlag(self, var, flag, expand=False, noweakdefault=False):
+    def getVarFlag(self, var, flag, expand=False, noweakdefault=False, parsing=False):
         local_var = self._findVar(var)
         value = None
-
-        if flag == "_content" and local_var is not None and "_overrides" in local_var:
+        if flag == "_content" and local_var is not None and "_overrides" in local_var and not parsing:
             match = False
             active = {}
             for (r, o) in local_var["_overrides"]:
@@ -580,7 +584,8 @@ class DataSmart(MutableMapping):
             elif flag == "_content" and "_defaultval" in local_var and not noweakdefault:
                 value = copy.copy(local_var["_defaultval"])
 
-        if flag == "_content" and local_var is not None and "_append" in local_var:
+
+        if flag == "_content" and local_var is not None and "_append" in local_var and not parsing:
             if not value:
                 value = ""
             for (r, o) in local_var["_append"]:
@@ -592,10 +597,11 @@ class DataSmart(MutableMapping):
                 if match:
                     value = value + r
 
-        if flag == "_content" and local_var is not None and "_prepend" in local_var:
+        if flag == "_content" and local_var is not None and "_prepend" in local_var and not parsing:
             if not value:
                 value = ""
             for (r, o) in local_var["_prepend"]:
+
                 match = True
                 if o:
                     for o2 in o.split("_"):
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 1130b14..bd42bd3 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -85,7 +85,7 @@ class DataNode(AstNode):
         if 'flag' in self.groupd and self.groupd['flag'] != None:
             return data.getVarFlag(key, self.groupd['flag'], noweakdefault=True)
         else:
-            return data.getVar(key, False, noweakdefault=True)
+            return data.getVar(key, False, noweakdefault=True, parsing=True)
 
     def eval(self, data):
         groupd = self.groupd
@@ -136,7 +136,7 @@ class DataNode(AstNode):
         if flag:
             data.setVarFlag(key, flag, val, **loginfo)
         else:
-            data.setVar(key, val, **loginfo)
+            data.setVar(key, val, parsing=True, **loginfo)
 
 class MethodNode(AstNode):
     tr_tbl = string.maketrans('/.+-@%&', '_______')
@@ -155,10 +155,10 @@ class MethodNode(AstNode):
             anonfuncs = data.getVar('__BBANONFUNCS', False) or []
             anonfuncs.append(funcname)
             data.setVar('__BBANONFUNCS', anonfuncs)
-            data.setVar(funcname, text)
+            data.setVar(funcname, text, parsing=True)
         else:
             data.setVarFlag(self.func_name, "func", 1)
-            data.setVar(self.func_name, text)
+            data.setVar(self.func_name, text, parsing=True)
 
 class PythonMethodNode(AstNode):
     def __init__(self, filename, lineno, function, modulename, body):
@@ -175,7 +175,7 @@ class PythonMethodNode(AstNode):
         bb.methodpool.insert_method(self.modulename, text, self.filename)
         data.setVarFlag(self.function, "func", 1)
         data.setVarFlag(self.function, "python", 1)
-        data.setVar(self.function, text)
+        data.setVar(self.function, text, parsing=True)
 
 class MethodFlagsNode(AstNode):
     def __init__(self, filename, lineno, key, m):
@@ -224,11 +224,11 @@ class ExportFuncsNode(AstNode):
                     data.setVarFlag(calledfunc, flag, data.getVarFlag(func, flag))
 
             if data.getVarFlag(calledfunc, "python"):
-                data.setVar(func, "    bb.build.exec_func('" + calledfunc + "', d)\n")
+                data.setVar(func, "    bb.build.exec_func('" + calledfunc + "', d)\n", parsing=True)
             else:
                 if "-" in self.classname:
                    bb.fatal("The classname %s contains a dash character and is calling an sh function %s using EXPORT_FUNCTIONS. Since a dash is illegal in sh function names, this cannot work, please rename the class or don't use EXPORT_FUNCTIONS." % (self.classname, calledfunc))
-                data.setVar(func, "    " + calledfunc + "\n")
+                data.setVar(func, "    " + calledfunc + "\n", parsing=True)
             data.setVarFlag(func, 'export_func', '1')
 
 class AddTaskNode(AstNode):
-- 
2.1.0


