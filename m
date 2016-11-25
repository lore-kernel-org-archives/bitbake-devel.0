Return-Path: <joshua.g.lock@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 9D4A171BA6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Nov 2016 15:28:14 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 25 Nov 2016 07:28:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,547,1473145200"; d="scan'208";a="1064113761"
Received: from jlock-mobl1.ger.corp.intel.com ([10.252.26.83])
	by orsmga001.jf.intel.com with ESMTP; 25 Nov 2016 07:28:14 -0800
From: Joshua Lock <joshua.g.lock@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 25 Nov 2016 15:28:09 +0000
Message-Id: <1480087689-26680-2-git-send-email-joshua.g.lock@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1480087689-26680-1-git-send-email-joshua.g.lock@intel.com>
References: <1480087689-26680-1-git-send-email-joshua.g.lock@intel.com>
Subject: [PATCH 2/2] bitbake: remove True option to getVarFlag calls
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
X-List-Received-Date: Fri, 25 Nov 2016 15:28:14 -0000

getVarFlag() now defaults to expanding by default, thus remove the
True option from getVarFlag() calls with a regex search and
replace.

Search made with the following regex:
getVarFlag ?\(( ?[^,()]*, ?[^,()]*), True\)

Signed-off-by: Joshua Lock <joshua.g.lock@intel.com>
---
 bin/bitbake-worker        | 2 +-
 lib/bb/build.py           | 6 +++---
 lib/bb/cache.py           | 2 +-
 lib/bb/cookerdata.py      | 2 +-
 lib/bb/data.py            | 8 ++++----
 lib/bb/data_smart.py      | 4 ++--
 lib/bb/fetch2/__init__.py | 4 ++--
 lib/bb/parse/ast.py       | 2 +-
 lib/bb/tests/parse.py     | 2 +-
 9 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 1282471..e8d665f 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -224,7 +224,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, append
                     the_data.setVar(e, fakeenv[e])
                     the_data.setVarFlag(e, 'export', "1")
 
-                task_exports = the_data.getVarFlag(taskname, 'exports', True)
+                task_exports = the_data.getVarFlag(taskname, 'exports')
                 if task_exports:
                     for e in task_exports.split():
                         the_data.setVarFlag(e, 'export', '1')
diff --git a/lib/bb/build.py b/lib/bb/build.py
index bdd83cd..7a7aabb 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -377,7 +377,7 @@ exit $ret
     else:
         logfile = sys.stdout
 
-    progress = d.getVarFlag(func, 'progress', True)
+    progress = d.getVarFlag(func, 'progress')
     if progress:
         if progress == 'percent':
             # Use default regex
@@ -669,7 +669,7 @@ def stamp_internal(taskname, d, file_name, baseonly=False, noextra=False):
     else:
         stamp = d.getVar('STAMP')
         file_name = d.getVar('BB_FILENAME')
-        extrainfo = d.getVarFlag(taskflagname, 'stamp-extra-info', True) or ""
+        extrainfo = d.getVarFlag(taskflagname, 'stamp-extra-info') or ""
 
     if baseonly:
         return stamp
@@ -705,7 +705,7 @@ def stamp_cleanmask_internal(taskname, d, file_name):
     else:
         stamp = d.getVar('STAMPCLEAN')
         file_name = d.getVar('BB_FILENAME')
-        extrainfo = d.getVarFlag(taskflagname, 'stamp-extra-info', True) or ""
+        extrainfo = d.getVarFlag(taskflagname, 'stamp-extra-info') or ""
 
     if not stamp:
         return []
diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 131abbb..c04ac13 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -71,7 +71,7 @@ class RecipeInfoCommon(object):
 
     @classmethod
     def flaglist(cls, flag, varlist, metadata, squash=False):
-        out_dict = dict((var, metadata.getVarFlag(var, flag, True))
+        out_dict = dict((var, metadata.getVarFlag(var, flag))
                     for var in varlist)
         if squash:
             return dict((k,v) for (k,v) in out_dict.items() if v)
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 680f79a..320bb59 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -369,7 +369,7 @@ class CookerDataBuilder(object):
                 parselog.critical("Undefined event handler function '%s'" % var)
                 sys.exit(1)
             handlerln = int(data.getVarFlag(var, "lineno", False))
-            bb.event.register(var, data.getVar(var, False),  (data.getVarFlag(var, "eventmask", True) or "").split(), handlerfn, handlerln)
+            bb.event.register(var, data.getVar(var, False),  (data.getVarFlag(var, "eventmask") or "").split(), handlerfn, handlerln)
 
         data.setVar('BBINCLUDED',bb.parse.get_file_depends(data))
 
diff --git a/lib/bb/data.py b/lib/bb/data.py
index 02a1140..0f05b60 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -226,7 +226,7 @@ def emit_func(func, o=sys.__stdout__, d = init()):
     o.write('\n')
     emit_var(func, o, d, False) and o.write('\n')
     newdeps = bb.codeparser.ShellParser(func, logger).parse_shell(d.getVar(func))
-    newdeps |= set((d.getVarFlag(func, "vardeps", True) or "").split())
+    newdeps |= set((d.getVarFlag(func, "vardeps") or "").split())
     seen = set()
     while newdeps:
         deps = newdeps
@@ -236,7 +236,7 @@ def emit_func(func, o=sys.__stdout__, d = init()):
             if d.getVarFlag(dep, "func", False) and not d.getVarFlag(dep, "python", False):
                emit_var(dep, o, d, False) and o.write('\n')
                newdeps |=  bb.codeparser.ShellParser(dep, logger).parse_shell(d.getVar(dep))
-               newdeps |= set((d.getVarFlag(dep, "vardeps", True) or "").split())
+               newdeps |= set((d.getVarFlag(dep, "vardeps") or "").split())
         newdeps -= seen
 
 _functionfmt = """
@@ -259,7 +259,7 @@ def emit_func_python(func, o=sys.__stdout__, d = init()):
     pp = bb.codeparser.PythonParser(func, logger)
     pp.parse_python(d.getVar(func, False))
     newdeps = pp.execs
-    newdeps |= set((d.getVarFlag(func, "vardeps", True) or "").split())
+    newdeps |= set((d.getVarFlag(func, "vardeps") or "").split())
     seen = set()
     while newdeps:
         deps = newdeps
@@ -271,7 +271,7 @@ def emit_func_python(func, o=sys.__stdout__, d = init()):
                pp = bb.codeparser.PythonParser(dep, logger)
                pp.parse_python(d.getVar(dep, False))
                newdeps |= pp.execs
-               newdeps |= set((d.getVarFlag(dep, "vardeps", True) or "").split())
+               newdeps |= set((d.getVarFlag(dep, "vardeps") or "").split())
         newdeps -= seen
 
 def update_data(d):
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 482399a..be43eb9 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -108,7 +108,7 @@ class VariableParse:
                 varparse = self.d.expand_cache[key]
                 var = varparse.value
             else:
-                var = self.d.getVarFlag(key, "_content", True)
+                var = self.d.getVarFlag(key, "_content")
             self.references.add(key)
             if var is not None:
                 return var
@@ -122,7 +122,7 @@ class VariableParse:
             parser = bb.codeparser.PythonParser(self.varname, logger)
             parser.parse_python(code)
             if self.varname:
-                vardeps = self.d.getVarFlag(self.varname, "vardeps", True)
+                vardeps = self.d.getVarFlag(self.varname, "vardeps")
                 if vardeps is None:
                     parser.log.flush()
             else:
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index ced4363..2bb41a4 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1180,13 +1180,13 @@ class FetchData(object):
         elif self.type not in ["http", "https", "ftp", "ftps", "sftp"]:
             self.md5_expected = None
         else:
-            self.md5_expected = d.getVarFlag("SRC_URI", self.md5_name, True)
+            self.md5_expected = d.getVarFlag("SRC_URI", self.md5_name)
         if self.sha256_name in self.parm:
             self.sha256_expected = self.parm[self.sha256_name]
         elif self.type not in ["http", "https", "ftp", "ftps", "sftp"]:
             self.sha256_expected = None
         else:
-            self.sha256_expected = d.getVarFlag("SRC_URI", self.sha256_name, True)
+            self.sha256_expected = d.getVarFlag("SRC_URI", self.sha256_name)
         self.ignore_checksums = False
 
         self.names = self.parm.get("name",'default').split(',')
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index a3990e5..7020940 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -347,7 +347,7 @@ def finalize(fn, d, variant = None):
         if not handlerfn:
             bb.fatal("Undefined event handler function '%s'" % var)
         handlerln = int(d.getVarFlag(var, "lineno", False))
-        bb.event.register(var, d.getVar(var, False), (d.getVarFlag(var, "eventmask", True) or "").split(), handlerfn, handlerln)
+        bb.event.register(var, d.getVar(var, False), (d.getVarFlag(var, "eventmask") or "").split(), handlerfn, handlerln)
 
     bb.event.fire(bb.event.RecipePreFinalise(fn), d)
 
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 86e86ed..ab6ca90 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -81,7 +81,7 @@ unset B[flag]
         f = self.parsehelper(self.unsettest)
         d = bb.parse.handle(f.name, self.d)['']
         self.assertEqual(d.getVar("A"), None)
-        self.assertEqual(d.getVarFlag("A","flag", True), None)
+        self.assertEqual(d.getVarFlag("A","flag"), None)
         self.assertEqual(d.getVar("B"), "2")
         
 
-- 
2.7.4


