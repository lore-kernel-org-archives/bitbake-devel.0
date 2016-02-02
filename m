Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id EC963772FE
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Feb 2016 23:49:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u12NnFUf006097
	for <bitbake-devel@lists.openembedded.org>; Tue, 2 Feb 2016 23:49:15 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1ljrYI1sVPu8 for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Feb 2016 23:49:15 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u12Nn9F2006093
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 2 Feb 2016 23:49:10 GMT
Message-ID: <1454456949.27087.135.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 02 Feb 2016 23:49:09 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] lib/bb: Add expansion parameter to getVarFlag
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
X-List-Received-Date: Tue, 02 Feb 2016 23:49:15 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This sets the scene for removing the default False for expansion from 
getVarFlag. This would later allow True to become the expand default.

On the most part this is an automatic translation with:

sed -e 's:\(\.getVarFlag([^,()]*, [^,()]*\)):\1, False):g'  -i `grep -ril getVar *`

There should be no functional change from this patch.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/bin/bitdoc b/bitbake/bin/bitdoc
index 576d88b..defb3dd 100755
--- a/bitbake/bin/bitdoc
+++ b/bitbake/bin/bitdoc
@@ -462,7 +462,7 @@ def main():
     state_group = 2
 
     for key in bb.data.keys(documentation):
-        data   = documentation.getVarFlag(key, "doc")
+        data   = documentation.getVarFlag(key, "doc", False)
         if not data:
             continue
 
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index b7c49eb..3039837 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -318,7 +318,7 @@ exit $ret
     os.chmod(runfile, 0775)
 
     cmd = runfile
-    if d.getVarFlag(func, 'fakeroot'):
+    if d.getVarFlag(func, 'fakeroot', False):
         fakerootcmd = d.getVar('FAKEROOT', True)
         if fakerootcmd:
             cmd = [fakerootcmd, runfile]
@@ -393,7 +393,7 @@ def _exec_task(fn, task, d, quieterr):
     Execution of a task involves a bit more setup than executing a function,
     running it with its own local metadata, and with some useful variables set.
     """
-    if not d.getVarFlag(task, 'task'):
+    if not d.getVarFlag(task, 'task', False):
         event.fire(TaskInvalid(task, d), d)
         logger.error("No such task: %s" % task)
         return 1
@@ -532,7 +532,7 @@ def _exec_task(fn, task, d, quieterr):
             bb.utils.remove(loglink)
     event.fire(TaskSucceeded(task, logfn, localdata), localdata)
 
-    if not localdata.getVarFlag(task, 'nostamp') and not localdata.getVarFlag(task, 'selfstamp'):
+    if not localdata.getVarFlag(task, 'nostamp', False) and not localdata.getVarFlag(task, 'selfstamp', False):
         make_stamp(task, localdata)
 
     return 0
@@ -540,7 +540,7 @@ def _exec_task(fn, task, d, quieterr):
 def exec_task(fn, task, d, profile = False):
     try:
         quieterr = False
-        if d.getVarFlag(task, "quieterrors") is not None:
+        if d.getVarFlag(task, "quieterrors", False) is not None:
             quieterr = True
 
         if profile:
@@ -745,7 +745,7 @@ def addtask(task, before, after, d):
         bbtasks.append(task)
     d.setVar('__BBTASKS', bbtasks)
 
-    existing = d.getVarFlag(task, "deps") or []
+    existing = d.getVarFlag(task, "deps", False) or []
     if after is not None:
         # set up deps for function
         for entry in after.split():
@@ -755,7 +755,7 @@ def addtask(task, before, after, d):
     if before is not None:
         # set up things that depend on this func
         for entry in before.split():
-            existing = d.getVarFlag(entry, "deps") or []
+            existing = d.getVarFlag(entry, "deps", False) or []
             if task not in existing:
                 d.setVarFlag(entry, "deps", [task] + existing)
 
@@ -770,7 +770,7 @@ def deltask(task, d):
 
     d.delVarFlag(task, 'deps')
     for bbtask in d.getVar('__BBTASKS', False) or []:
-        deps = d.getVarFlag(bbtask, 'deps') or []
+        deps = d.getVarFlag(bbtask, 'deps', False) or []
         if task in deps:
             deps.remove(task)
             d.setVarFlag(bbtask, 'deps', deps)
diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 86ad4ed..890288e 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -107,7 +107,7 @@ def setVarFlag(var, flag, flagvalue, d):
 
 def getVarFlag(var, flag, d):
     """Gets given flag from given var"""
-    return d.getVarFlag(var, flag)
+    return d.getVarFlag(var, flag, False)
 
 def delVarFlag(var, flag, d):
     """Removes a given flag from the variable's flags"""
@@ -182,12 +182,12 @@ def inheritFromOS(d, savedenv, permitted):
 
 def emit_var(var, o=sys.__stdout__, d = init(), all=False):
     """Emit a variable to be sourced by a shell."""
-    if d.getVarFlag(var, "python"):
+    if d.getVarFlag(var, "python", False):
         return False
 
-    export = d.getVarFlag(var, "export")
-    unexport = d.getVarFlag(var, "unexport")
-    func = d.getVarFlag(var, "func")
+    export = d.getVarFlag(var, "export", False)
+    unexport = d.getVarFlag(var, "unexport", False)
+    func = d.getVarFlag(var, "func", False)
     if not all and not export and not unexport and not func:
         return False
 
@@ -245,7 +245,7 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
 def emit_env(o=sys.__stdout__, d = init(), all=False):
     """Emits all items in the data store in a format such that it can be sourced by a shell."""
 
-    isfunc = lambda key: bool(d.getVarFlag(key, "func"))
+    isfunc = lambda key: bool(d.getVarFlag(key, "func", False))
     keys = sorted((key for key in d.keys() if not key.startswith("__")), key=isfunc)
     grouped = groupby(keys, isfunc)
     for isfunc, keys in grouped:
@@ -254,8 +254,8 @@ def emit_env(o=sys.__stdout__, d = init(), all=False):
 
 def exported_keys(d):
     return (key for key in d.keys() if not key.startswith('__') and
-                                      d.getVarFlag(key, 'export') and
-                                      not d.getVarFlag(key, 'unexport'))
+                                      d.getVarFlag(key, 'export', False) and
+                                      not d.getVarFlag(key, 'unexport', False))
 
 def exported_vars(d):
     for key in exported_keys(d):
@@ -270,7 +270,7 @@ def exported_vars(d):
 def emit_func(func, o=sys.__stdout__, d = init()):
     """Emits all items in the data store in a format such that it can be sourced by a shell."""
 
-    keys = (key for key in d.keys() if not key.startswith("__") and not d.getVarFlag(key, "func"))
+    keys = (key for key in d.keys() if not key.startswith("__") and not d.getVarFlag(key, "func", False))
     for key in keys:
         emit_var(key, o, d, False)
 
@@ -284,7 +284,7 @@ def emit_func(func, o=sys.__stdout__, d = init()):
         seen |= deps
         newdeps = set()
         for dep in deps:
-            if d.getVarFlag(dep, "func") and not d.getVarFlag(dep, "python"):
+            if d.getVarFlag(dep, "func", False) and not d.getVarFlag(dep, "python", False):
                emit_var(dep, o, d, False) and o.write('\n')
                newdeps |=  bb.codeparser.ShellParser(dep, logger).parse_shell(d.getVar(dep, True))
                newdeps |= set((d.getVarFlag(dep, "vardeps", True) or "").split())
@@ -317,7 +317,7 @@ def emit_func_python(func, o=sys.__stdout__, d = init()):
         seen |= deps
         newdeps = set()
         for dep in deps:
-            if d.getVarFlag(dep, "func") and d.getVarFlag(dep, "python"):
+            if d.getVarFlag(dep, "func", False) and d.getVarFlag(dep, "python", False):
                write_func(dep, o)
                pp = bb.codeparser.PythonParser(dep, logger)
                pp.parse_python(d.getVar(dep, True))
@@ -415,7 +415,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
 def generate_dependencies(d):
 
     keys = set(key for key in d if not key.startswith("__"))
-    shelldeps = set(key for key in d.getVar("__exportlist", False) if d.getVarFlag(key, "export") and not d.getVarFlag(key, "unexport"))
+    shelldeps = set(key for key in d.getVar("__exportlist", False) if d.getVarFlag(key, "export", False) and not d.getVarFlag(key, "unexport", False))
     varflagsexcl = d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS', True)
 
     deps = {}
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 78033d7..b700fc7 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -147,7 +147,7 @@ class DataContext(dict):
 
     def __missing__(self, key):
         value = self.metadata.getVar(key, True)
-        if value is None or self.metadata.getVarFlag(key, 'func'):
+        if value is None or self.metadata.getVarFlag(key, 'func', False):
             raise KeyError(key)
         else:
             return value
@@ -480,7 +480,7 @@ class DataSmart(MutableMapping):
             base = match.group('base')
             keyword = match.group("keyword")
             override = match.group('add')
-            l = self.getVarFlag(base, keyword) or []
+            l = self.getVarFlag(base, keyword, False) or []
             l.append([value, override])
             self.setVarFlag(base, keyword, l, ignore=True)
             # And cause that to be recorded:
@@ -582,11 +582,11 @@ class DataSmart(MutableMapping):
             self.setVar(newkey, val, ignore=True, parsing=True)
 
         for i in (__setvar_keyword__):
-            src = self.getVarFlag(key, i)
+            src = self.getVarFlag(key, i, False)
             if src is None:
                 continue
 
-            dest = self.getVarFlag(newkey, i) or []
+            dest = self.getVarFlag(newkey, i, False) or []
             dest.extend(src)
             self.setVarFlag(newkey, i, dest, ignore=True)
 
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index bbbc11a..1906c64 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1002,7 +1002,7 @@ def trusted_network(d, url):
         return True
 
     pkgname = d.expand(d.getVar('PN', False))
-    trusted_hosts = d.getVarFlag('BB_ALLOWED_NETWORKS', pkgname)
+    trusted_hosts = d.getVarFlag('BB_ALLOWED_NETWORKS', pkgname, False)
 
     if not trusted_hosts:
         trusted_hosts = d.getVar('BB_ALLOWED_NETWORKS', True)
@@ -1185,13 +1185,13 @@ class FetchData(object):
         elif self.type not in ["http", "https", "ftp", "ftps", "sftp"]:
             self.md5_expected = None
         else:
-            self.md5_expected = d.getVarFlag("SRC_URI", self.md5_name)
+            self.md5_expected = d.getVarFlag("SRC_URI", self.md5_name, False)
         if self.sha256_name in self.parm:
             self.sha256_expected = self.parm[self.sha256_name]
         elif self.type not in ["http", "https", "ftp", "ftps", "sftp"]:
             self.sha256_expected = None
         else:
-            self.sha256_expected = d.getVarFlag("SRC_URI", self.sha256_name)
+            self.sha256_expected = d.getVarFlag("SRC_URI", self.sha256_name, False)
         self.ignore_checksums = False
 
         self.names = self.parm.get("name",'default').split(',')
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 1c5b9d1..c676fc6 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -83,7 +83,7 @@ class DataNode(AstNode):
 
     def getFunc(self, key, data):
         if 'flag' in self.groupd and self.groupd['flag'] != None:
-            return data.getVarFlag(key, self.groupd['flag'], noweakdefault=True)
+            return data.getVarFlag(key, self.groupd['flag'], expand=False, noweakdefault=True)
         else:
             return data.getVar(key, False, noweakdefault=True, parsing=True)
 
@@ -213,7 +213,7 @@ class ExportFuncsNode(AstNode):
         for func in self.n:
             calledfunc = self.classname + "_" + func
 
-            if data.getVar(func, False) and not data.getVarFlag(func, 'export_func'):
+            if data.getVar(func, False) and not data.getVarFlag(func, 'export_func', False):
                 continue
 
             if data.getVar(func, False):
@@ -221,15 +221,15 @@ class ExportFuncsNode(AstNode):
                 data.setVarFlag(func, 'func', None)
 
             for flag in [ "func", "python" ]:
-                if data.getVarFlag(calledfunc, flag):
-                    data.setVarFlag(func, flag, data.getVarFlag(calledfunc, flag))
+                if data.getVarFlag(calledfunc, flag, False):
+                    data.setVarFlag(func, flag, data.getVarFlag(calledfunc, flag, False))
             for flag in [ "dirs" ]:
-                if data.getVarFlag(func, flag):
-                    data.setVarFlag(calledfunc, flag, data.getVarFlag(func, flag))
+                if data.getVarFlag(func, flag, False):
+                    data.setVarFlag(calledfunc, flag, data.getVarFlag(func, flag, False))
             data.setVarFlag(func, "filename", "autogenerated")
             data.setVarFlag(func, "lineno", 1)
 
-            if data.getVarFlag(calledfunc, "python"):
+            if data.getVarFlag(calledfunc, "python", False):
                 data.setVar(func, "    bb.build.exec_func('" + calledfunc + "', d)\n", parsing=True)
             else:
                 if "-" in self.classname:
diff --git a/bitbake/lib/bb/tests/data.py b/bitbake/lib/bb/tests/data.py
index a96078f..1223230 100644
--- a/bitbake/lib/bb/tests/data.py
+++ b/bitbake/lib/bb/tests/data.py
@@ -399,13 +399,13 @@ class TestFlags(unittest.TestCase):
         self.d.setVarFlag("foo", "flag2", "value of flag2")
 
     def test_setflag(self):
-        self.assertEqual(self.d.getVarFlag("foo", "flag1"), "value of flag1")
-        self.assertEqual(self.d.getVarFlag("foo", "flag2"), "value of flag2")
+        self.assertEqual(self.d.getVarFlag("foo", "flag1", False), "value of flag1")
+        self.assertEqual(self.d.getVarFlag("foo", "flag2", False), "value of flag2")
 
     def test_delflag(self):
         self.d.delVarFlag("foo", "flag2")
-        self.assertEqual(self.d.getVarFlag("foo", "flag1"), "value of flag1")
-        self.assertEqual(self.d.getVarFlag("foo", "flag2"), None)
+        self.assertEqual(self.d.getVarFlag("foo", "flag1", False), "value of flag1")
+        self.assertEqual(self.d.getVarFlag("foo", "flag2", False), None)
 
 
 class Contains(unittest.TestCase):
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index ae10213..9730b51 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -631,7 +631,7 @@ def build_environment(d):
     """
     import bb.data
     for var in bb.data.keys(d):
-        export = d.getVarFlag(var, "export")
+        export = d.getVarFlag(var, "export", False)
         if export:
             os.environ[var] = d.getVar(var, True) or ""
 



