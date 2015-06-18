Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5C6A573306
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Jun 2015 14:14:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t5IEEdj2027697 for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Jun 2015 15:14:39 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Op2TUk6vkU9r for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Jun 2015 15:14:39 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t5IEESBq027650
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Jun 2015 15:14:39 +0100
Message-ID: <1434636859.14710.95.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 18 Jun 2015 15:14:19 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] bitbake: Add explict getVar param for (non) expansion
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
X-List-Received-Date: Thu, 18 Jun 2015 14:14:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Rather than just use d.getVar(X), use the more explict d.getVar(X, False)
since at some point in the future, having the default of expansion would
be nice. This is the first step towards that.

This patch was mostly made using the command:

sed -e 's:\(getVar([^,()]*\)\s*):\1, False):g' -i `grep -ril getVar *`

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.xml b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
index 17a7459..fa52e29 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
@@ -287,8 +287,8 @@
             <link linkend='var-PN'><filename>PN</filename></link> and
             <link linkend='var-PV'><filename>PV</filename></link>:
             <literallayout class='monospaced'>
-     PN = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE'),d)[0] or 'defaultpkgname'}"
-     PV = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE'),d)[1] or '1.0'}"
+     PN = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE', False),d)[0] or 'defaultpkgname'}"
+     PV = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE', False),d)[1] or '1.0'}"
             </literallayout>
             In this example, a recipe called "something_1.2.3.bb" would set
             <filename>PN</filename> to "something" and
diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
index 2fb58e4..b37b2ae 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
@@ -628,7 +628,7 @@
                 <literallayout class='monospaced'>
      SRC_URI = "ccrc://cc.example.org/ccrc;vob=/example_vob;module=/example_module"
      SRCREV = "EXAMPLE_CLEARCASE_TAG"
-     PV = "${@d.getVar("SRCREV").replace("/", "+")}"
+     PV = "${@d.getVar("SRCREV", False).replace("/", "+")}"
                 </literallayout>
                 The fetcher uses the <filename>rcleartool</filename> or
                 <filename>cleartool</filename> remote client, depending on
diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index fbffade..1b9d800 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -327,8 +327,8 @@
                 The following lines select the values of a package name
                 and its version number, respectively:
                 <literallayout class='monospaced'>
-     PN = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE'),d)[0] or 'defaultpkgname'}"
-     PV = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE'),d)[1] or '1.0'}"
+     PN = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE', False),d)[0] or 'defaultpkgname'}"
+     PV = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE', False),d)[1] or '1.0'}"
                 </literallayout>
             </para>
         </section>
@@ -1163,7 +1163,7 @@
             <para>
                 The <filename>BB_ORIGENV</filename> variable returns a datastore
                 object that can be queried using the standard datastore operators
-                such as <filename>getVar()</filename>.
+                such as <filename>getVar(, False)</filename>.
                 The datastore object is useful, for example, to find the original
                 <filename>DISPLAY</filename> variable.
                 Here is an example:
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 0f6aa1a..14dc5e0 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -159,7 +159,7 @@ class LogTee(object):
 def exec_func(func, d, dirs = None):
     """Execute a BB 'function'"""
 
-    body = d.getVar(func)
+    body = d.getVar(func, False)
     if not body:
         if body is None:
             logger.warn("Function %s doesn't exist", func)
@@ -646,7 +646,7 @@ def stampfile(taskname, d, file_name = None):
     return stamp_internal(taskname, d, file_name)
 
 def add_tasks(tasklist, deltasklist, d):
-    task_deps = d.getVar('_task_deps')
+    task_deps = d.getVar('_task_deps', False)
     if not task_deps:
         task_deps = {}
     if not 'tasks' in task_deps:
@@ -696,7 +696,7 @@ def addtask(task, before, after, d):
         task = "do_" + task
 
     d.setVarFlag(task, "task", 1)
-    bbtasks = d.getVar('__BBTASKS') or []
+    bbtasks = d.getVar('__BBTASKS', False) or []
     if not task in bbtasks:
         bbtasks.append(task)
     d.setVar('__BBTASKS', bbtasks)
@@ -719,7 +719,7 @@ def deltask(task, d):
     if task[:3] != "do_":
         task = "do_" + task
 
-    bbtasks = d.getVar('__BBDELTASKS') or []
+    bbtasks = d.getVar('__BBDELTASKS', False) or []
     if not task in bbtasks:
         bbtasks.append(task)
     d.setVar('__BBDELTASKS', bbtasks)
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index d15bed3..d42b389 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -386,7 +386,7 @@ class BBCooker:
 
         replaced = False
         #do not save if nothing changed
-        if str(val) == self.data.getVar(var):
+        if str(val) == self.data.getVar(var, False):
             return
 
         conf_files = self.data.varhistory.get_variable_files(var)
@@ -398,7 +398,7 @@ class BBCooker:
                 listval += "%s   " % value
             val = listval
 
-        topdir = self.data.getVar("TOPDIR")
+        topdir = self.data.getVar("TOPDIR", False)
 
         #comment or replace operations made on var
         for conf_file in conf_files:
@@ -453,7 +453,7 @@ class BBCooker:
 
     def removeConfigurationVar(self, var):
         conf_files = self.data.varhistory.get_variable_files(var)
-        topdir = self.data.getVar("TOPDIR")
+        topdir = self.data.getVar("TOPDIR", False)
 
         for conf_file in conf_files:
             if topdir in conf_file:
@@ -493,7 +493,7 @@ class BBCooker:
 
     def parseConfiguration(self):
         # Set log file verbosity
-        verboselogs = bb.utils.to_boolean(self.data.getVar("BB_VERBOSE_LOGS", "0"))
+        verboselogs = bb.utils.to_boolean(self.data.getVar("BB_VERBOSE_LOGS", False))
         if verboselogs:
             bb.msg.loggerVerboseLogs = True
 
@@ -613,7 +613,7 @@ class BBCooker:
         data.expandKeys(envdata)
         for e in envdata.keys():
             if data.getVarFlag( e, 'python', envdata ):
-                logger.plain("\npython %s () {\n%s}\n", e, data.getVar(e, envdata, 1))
+                logger.plain("\npython %s () {\n%s}\n", e, envdata.getVar(e, True))
 
 
     def buildTaskData(self, pkgs_to_build, task, abort):
@@ -908,8 +908,8 @@ class BBCooker:
                            for appends in appends_without_recipes
                            for append in appends)
             msg = 'No recipes available for:\n%s' % '\n'.join(appendlines)
-            warn_only = data.getVar("BB_DANGLINGAPPENDS_WARNONLY", \
-                 self.data, False) or "no"
+            warn_only = self.data.getVar("BB_DANGLINGAPPENDS_WARNONLY", \
+                 False) or "no"
             if warn_only.lower() in ("1", "yes", "true"):
                 bb.warn(msg)
             else:
@@ -956,8 +956,8 @@ class BBCooker:
         # Generate a list of parsed configuration files by searching the files
         # listed in the __depends and __base_depends variables with a .conf suffix.
         conffiles = []
-        dep_files = self.data.getVar('__base_depends') or []
-        dep_files = dep_files + (self.data.getVar('__depends') or [])
+        dep_files = self.data.getVar('__base_depends', False) or []
+        dep_files = dep_files + (self.data.getVar('__depends', False) or [])
 
         for f in dep_files:
             if f[0].endswith(".conf"):
@@ -1175,7 +1175,7 @@ class BBCooker:
         Setup any variables needed before starting a build
         """
         t = time.gmtime() 
-        if not self.data.getVar("BUILDNAME"):
+        if not self.data.getVar("BUILDNAME", False):
             self.data.setVar("BUILDNAME", time.strftime('%Y%m%d%H%M', t))
         self.data.setVar("BUILDSTART", time.strftime('%m/%d/%Y %H:%M:%S', t))
         self.data.setVar("DATE", time.strftime('%Y%m%d', t))
@@ -1278,7 +1278,7 @@ class BBCooker:
         taskdata = bb.taskdata.TaskData(self.configuration.abort)
         taskdata.add_provider(self.data, self.recipecache, item)
 
-        buildname = self.data.getVar("BUILDNAME")
+        buildname = self.data.getVar("BUILDNAME", False)
         bb.event.fire(bb.event.BuildStarted(buildname, [item]), self.expanded_data)
 
         # Execute the runqueue
@@ -1351,7 +1351,7 @@ class BBCooker:
 
         taskdata, runlist, fulltargetlist = self.buildTaskData(targets, task, self.configuration.abort)
 
-        buildname = self.data.getVar("BUILDNAME")
+        buildname = self.data.getVar("BUILDNAME", False)
         bb.event.fire(bb.event.BuildStarted(buildname, fulltargetlist), self.data)
 
         rq = bb.runqueue.RunQueue(self, self.data, self.recipecache, taskdata, runlist)
@@ -1405,7 +1405,7 @@ class BBCooker:
             if base_image is None:
                 imagefile.write("inherit core-image\n")
             else:
-                topdir = self.data.getVar("TOPDIR")
+                topdir = self.data.getVar("TOPDIR", False)
                 if topdir in base_image:
                     base_image = require_line.split()[1]
                 imagefile.write("require " + base_image + "\n")
@@ -1465,7 +1465,7 @@ class BBCooker:
             (filelist, masked) = self.collection.collect_bbfiles(self.data, self.expanded_data)
 
             self.data.renameVar("__depends", "__base_depends")
-            self.add_filewatch(self.data.getVar("__base_depends"), self.configwatcher)
+            self.add_filewatch(self.data.getVar("__base_depends", False), self.configwatcher)
 
             self.parser = CookerParser(self, filelist, masked)
             self.parsecache_valid = True
diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 630ee27..0ca87a0 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -301,15 +301,15 @@ class CookerDataBuilder(object):
 
         # Nomally we only register event handlers at the end of parsing .bb files
         # We register any handlers we've found so far here...
-        for var in data.getVar('__BBHANDLERS') or []:
-            bb.event.register(var, data.getVar(var),  (data.getVarFlag(var, "eventmask", True) or "").split())
+        for var in data.getVar('__BBHANDLERS', False) or []:
+            bb.event.register(var, data.getVar(var, False),  (data.getVarFlag(var, "eventmask", True) or "").split())
 
         if data.getVar("BB_WORKERCONTEXT", False) is None:
             bb.fetch.fetcher_init(data)
         bb.codeparser.parser_cache_init(data)
         bb.event.fire(bb.event.ConfigParsed(), data)
 
-        if data.getVar("BB_INVALIDCONF") is True:
+        if data.getVar("BB_INVALIDCONF", False) is True:
             data.setVar("BB_INVALIDCONF", False)
             self.parseConfigurationFiles(self.prefiles, self.postfiles)
             return
diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 84f5355..8b21c46 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -419,7 +419,7 @@ def generate_dependencies(d):
     deps = {}
     values = {}
 
-    tasklist = d.getVar('__BBTASKS') or []
+    tasklist = d.getVar('__BBTASKS', False) or []
     for task in tasklist:
         deps[task], values[task] = build_dependencies(task, keys, shelldeps, varflagsexcl, d)
         newdeps = deps[task]
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index e47ddf3..9384ffd 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -547,7 +547,7 @@ class DataSmart(MutableMapping):
         """
         Rename the variable key to newkey
         """
-        val = self.getVar(key, 0, parsing=True)
+        val = self.getVar(key, False, parsing=True)
         if val is not None:
             loginfo['variable'] = newkey
             loginfo['op'] = 'rename from %s' % key
@@ -662,7 +662,7 @@ class DataSmart(MutableMapping):
                             match = active[a]
                             del active[a]
             if match:
-                value = self.getVar(match)
+                value = self.getVar(match, False)
 
         if local_var is not None and value is None:
             if flag in local_var:
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 33a04a5..b9bccc5 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1029,7 +1029,7 @@ def trusted_network(d, url):
     if d.getVar('BB_NO_NETWORK', True) == "1":
         return True
 
-    pkgname = d.expand(d.getVar('PN'))
+    pkgname = d.expand(d.getVar('PN', False))
     trusted_hosts = d.getVarFlag('BB_ALLOWED_NETWORKS', pkgname)
 
     if not trusted_hosts:
diff --git a/bitbake/lib/bb/fetch2/clearcase.py b/bitbake/lib/bb/fetch2/clearcase.py
index bfca2f7..ba83e7c 100644
--- a/bitbake/lib/bb/fetch2/clearcase.py
+++ b/bitbake/lib/bb/fetch2/clearcase.py
@@ -9,7 +9,7 @@ Usage in the recipe:
 
     SRC_URI = "ccrc://cc.example.org/ccrc;vob=/example_vob;module=/example_module"
     SRCREV = "EXAMPLE_CLEARCASE_TAG"
-    PV = "${@d.getVar("SRCREV").replace("/", "+")}"
+    PV = "${@d.getVar("SRCREV", False).replace("/", "+")}"
 
 The fetcher uses the rcleartool or cleartool remote client, depending on which one is available.
 
@@ -113,7 +113,7 @@ class ClearCase(FetchMethod):
         if data.getVar("SRCREV", d, True) == "INVALID":
           raise FetchError("Set a valid SRCREV for the clearcase fetcher in your recipe, e.g. SRCREV = \"/main/LATEST\" or any other label of your choice.")
 
-        ud.label = d.getVar("SRCREV")
+        ud.label = d.getVar("SRCREV", False)
         ud.customspec = d.getVar("CCASE_CUSTOM_CONFIG_SPEC", True)
 
         ud.server     = "%s://%s%s" % (ud.proto, ud.host, ud.path)
diff --git a/bitbake/lib/bb/fetch2/perforce.py b/bitbake/lib/bb/fetch2/perforce.py
index d079a33..5a6631a 100644
--- a/bitbake/lib/bb/fetch2/perforce.py
+++ b/bitbake/lib/bb/fetch2/perforce.py
@@ -48,7 +48,7 @@ class Perforce(FetchMethod):
             (user, pswd, host, port) = path.split('@')[0].split(":")
             path = path.split('@')[1]
         else:
-            (host, port) = d.getVar('P4PORT').split(':')
+            (host, port) = d.getVar('P4PORT', False).split(':')
             user = ""
             pswd = ""
 
diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__init__.py
index 25effc2..4a78e18 100644
--- a/bitbake/lib/bb/parse/__init__.py
+++ b/bitbake/lib/bb/parse/__init__.py
@@ -81,7 +81,7 @@ def update_cache(f):
 def mark_dependency(d, f):
     if f.startswith('./'):
         f = "%s/%s" % (os.getcwd(), f[2:])
-    deps = (d.getVar('__depends') or [])
+    deps = (d.getVar('__depends', False) or [])
     s = (f, cached_mtime_noerror(f))
     if s not in deps:
         deps.append(s)
@@ -89,7 +89,7 @@ def mark_dependency(d, f):
 
 def check_dependency(d, f):
     s = (f, cached_mtime_noerror(f))
-    deps = (d.getVar('__depends') or [])
+    deps = (d.getVar('__depends', False) or [])
     return s in deps
    
 def supports(fn, data):
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index d6c5c35..bd42bd3 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -85,7 +85,7 @@ class DataNode(AstNode):
         if 'flag' in self.groupd and self.groupd['flag'] != None:
             return data.getVarFlag(key, self.groupd['flag'], noweakdefault=True)
         else:
-            return data.getVar(key, noweakdefault=True, parsing=True)
+            return data.getVar(key, False, noweakdefault=True, parsing=True)
 
     def eval(self, data):
         groupd = self.groupd
@@ -152,7 +152,7 @@ class MethodNode(AstNode):
             funcname = ("__anon_%s_%s" % (self.lineno, self.filename.translate(MethodNode.tr_tbl)))
             text = "def %s(d):\n" % (funcname) + text
             bb.methodpool.insert_method(funcname, text, self.filename)
-            anonfuncs = data.getVar('__BBANONFUNCS') or []
+            anonfuncs = data.getVar('__BBANONFUNCS', False) or []
             anonfuncs.append(funcname)
             data.setVar('__BBANONFUNCS', anonfuncs)
             data.setVar(funcname, text, parsing=True)
@@ -184,7 +184,7 @@ class MethodFlagsNode(AstNode):
         self.m = m
 
     def eval(self, data):
-        if data.getVar(self.key):
+        if data.getVar(self.key, False):
             # clean up old version of this piece of metadata, as its
             # flags could cause problems
             data.setVarFlag(self.key, 'python', None)
@@ -209,10 +209,10 @@ class ExportFuncsNode(AstNode):
         for func in self.n:
             calledfunc = self.classname + "_" + func
 
-            if data.getVar(func) and not data.getVarFlag(func, 'export_func'):
+            if data.getVar(func, False) and not data.getVarFlag(func, 'export_func'):
                 continue
 
-            if data.getVar(func):
+            if data.getVar(func, False):
                 data.setVarFlag(func, 'python', None)
                 data.setVarFlag(func, 'func', None)
 
@@ -255,7 +255,7 @@ class BBHandlerNode(AstNode):
         self.hs = fns.split()
 
     def eval(self, data):
-        bbhands = data.getVar('__BBHANDLERS') or []
+        bbhands = data.getVar('__BBHANDLERS', False) or []
         for h in self.hs:
             bbhands.append(h)
             data.setVarFlag(h, "handler", 1)
@@ -315,22 +315,22 @@ def handleInherit(statements, filename, lineno, m):
 
 def finalize(fn, d, variant = None):
     all_handlers = {}
-    for var in d.getVar('__BBHANDLERS') or []:
+    for var in d.getVar('__BBHANDLERS', False) or []:
         # try to add the handler
-        bb.event.register(var, d.getVar(var), (d.getVarFlag(var, "eventmask", True) or "").split())
+        bb.event.register(var, d.getVar(var, False), (d.getVarFlag(var, "eventmask", True) or "").split())
 
     bb.event.fire(bb.event.RecipePreFinalise(fn), d)
 
     bb.data.expandKeys(d)
     bb.data.update_data(d)
     code = []
-    for funcname in d.getVar("__BBANONFUNCS") or []:
+    for funcname in d.getVar("__BBANONFUNCS", False) or []:
         code.append("%s(d)" % funcname)
     bb.utils.better_exec("\n".join(code), {"d": d})
     bb.data.update_data(d)
 
-    tasklist = d.getVar('__BBTASKS') or []
-    deltasklist = d.getVar('__BBDELTASKS') or []
+    tasklist = d.getVar('__BBTASKS', False) or []
+    deltasklist = d.getVar('__BBDELTASKS', False) or []
     bb.build.add_tasks(tasklist, deltasklist, d)
 
     bb.parse.siggen.finalise(fn, d, variant)
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 03109df..ec097ba 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -69,7 +69,7 @@ def supports(fn, d):
     return os.path.splitext(fn)[-1] in [".bb", ".bbclass", ".inc"]
 
 def inherit(files, fn, lineno, d):
-    __inherit_cache = d.getVar('__inherit_cache') or []
+    __inherit_cache = d.getVar('__inherit_cache', False) or []
     files = d.expand(files).split()
     for file in files:
         if not os.path.isabs(file) and not file.endswith(".bbclass"):
@@ -89,7 +89,7 @@ def inherit(files, fn, lineno, d):
             __inherit_cache.append( file )
             d.setVar('__inherit_cache', __inherit_cache)
             include(fn, file, lineno, d, "inherit")
-            __inherit_cache = d.getVar('__inherit_cache') or []
+            __inherit_cache = d.getVar('__inherit_cache', False) or []
 
 def get_statements(filename, absolute_filename, base_name):
     global cached_statements
@@ -129,13 +129,13 @@ def handle(fn, d, include):
 
     if ext == ".bbclass":
         __classname__ = root
-        __inherit_cache = d.getVar('__inherit_cache') or []
+        __inherit_cache = d.getVar('__inherit_cache', False) or []
         if not fn in __inherit_cache:
             __inherit_cache.append(fn)
             d.setVar('__inherit_cache', __inherit_cache)
 
     if include != 0:
-        oldfile = d.getVar('FILE')
+        oldfile = d.getVar('FILE', False)
     else:
         oldfile = None
 
diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index 8d7a0d5..250a557 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -58,7 +58,7 @@ __require_regexp__ = re.compile( r"require\s+(.+)" )
 __export_regexp__ = re.compile( r"export\s+([a-zA-Z0-9\-_+.${}/]+)$" )
 
 def init(data):
-    topdir = data.getVar('TOPDIR')
+    topdir = data.getVar('TOPDIR', False)
     if not topdir:
         data.setVar('TOPDIR', os.getcwd())
 
@@ -112,7 +112,7 @@ def handle(fn, data, include):
     if include == 0:
         oldfile = None
     else:
-        oldfile = data.getVar('FILE')
+        oldfile = data.getVar('FILE', False)
 
     abs_fn = resolve_file(fn, data)
     f = open(abs_fn, 'r')
diff --git a/bitbake/lib/bb/tests/data.py b/bitbake/lib/bb/tests/data.py
index e96e07d..e9aab57 100644
--- a/bitbake/lib/bb/tests/data.py
+++ b/bitbake/lib/bb/tests/data.py
@@ -134,12 +134,12 @@ class DataExpansions(unittest.TestCase):
 
     def test_rename(self):
         self.d.renameVar("foo", "newfoo")
-        self.assertEqual(self.d.getVar("newfoo"), "value_of_foo")
-        self.assertEqual(self.d.getVar("foo"), None)
+        self.assertEqual(self.d.getVar("newfoo", False), "value_of_foo")
+        self.assertEqual(self.d.getVar("foo", False), None)
 
     def test_deletion(self):
         self.d.delVar("foo")
-        self.assertEqual(self.d.getVar("foo"), None)
+        self.assertEqual(self.d.getVar("foo", False), None)
 
     def test_keys(self):
         keys = self.d.keys()
@@ -196,28 +196,28 @@ class TestMemoize(unittest.TestCase):
     def test_memoized(self):
         d = bb.data.init()
         d.setVar("FOO", "bar")
-        self.assertTrue(d.getVar("FOO") is d.getVar("FOO"))
+        self.assertTrue(d.getVar("FOO", False) is d.getVar("FOO", False))
 
     def test_not_memoized(self):
         d1 = bb.data.init()
         d2 = bb.data.init()
         d1.setVar("FOO", "bar")
         d2.setVar("FOO", "bar2")
-        self.assertTrue(d1.getVar("FOO") is not d2.getVar("FOO"))
+        self.assertTrue(d1.getVar("FOO", False) is not d2.getVar("FOO", False))
 
     def test_changed_after_memoized(self):
         d = bb.data.init()
         d.setVar("foo", "value of foo")
-        self.assertEqual(str(d.getVar("foo")), "value of foo")
+        self.assertEqual(str(d.getVar("foo", False)), "value of foo")
         d.setVar("foo", "second value of foo")
-        self.assertEqual(str(d.getVar("foo")), "second value of foo")
+        self.assertEqual(str(d.getVar("foo", False)), "second value of foo")
 
     def test_same_value(self):
         d = bb.data.init()
         d.setVar("foo", "value of")
         d.setVar("bar", "value of")
-        self.assertEqual(d.getVar("foo"),
-                         d.getVar("bar"))
+        self.assertEqual(d.getVar("foo", False),
+                         d.getVar("bar", False))
 
 class TestConcat(unittest.TestCase):
     def setUp(self):
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 455af32..dcc4104 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -309,7 +309,7 @@ class Parameters:
 
 def hob_conf_filter(fn, data):
     if fn.endswith("/local.conf"):
-        distro = data.getVar("DISTRO_HOB")
+        distro = data.getVar("DISTRO_HOB", False)
         if distro:
             if distro != "defaultsetup":
                 data.setVar("DISTRO", distro)
@@ -320,13 +320,13 @@ def hob_conf_filter(fn, data):
                 "BB_NUMBER_THREADS_HOB", "PARALLEL_MAKE_HOB", "DL_DIR_HOB", \
                 "SSTATE_DIR_HOB", "SSTATE_MIRRORS_HOB", "INCOMPATIBLE_LICENSE_HOB"]
         for key in keys:
-            var_hob = data.getVar(key)
+            var_hob = data.getVar(key, False)
             if var_hob:
                 data.setVar(key.split("_HOB")[0], var_hob)
         return
 
     if fn.endswith("/bblayers.conf"):
-        layers = data.getVar("BBLAYERS_HOB")
+        layers = data.getVar("BBLAYERS_HOB", False)
         if layers:
             data.setVar("BBLAYERS", layers)
         return



