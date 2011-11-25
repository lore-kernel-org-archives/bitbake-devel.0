Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RTxWv-0005DY-3f for bitbake-devel@lists.openembedded.org;
	Fri, 25 Nov 2011 16:18:47 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAPFAuf1006402
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Nov 2011 15:10:56 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 06345-01 for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Nov 2011 15:10:51 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAPFAlTg006396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Nov 2011 15:10:48 GMT
Message-ID: <1322233854.22755.1.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 25 Nov 2011 15:10:54 +0000
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
X-Mailman-Approved-At: Fri, 25 Nov 2011 18:00:42 +0100
Subject: [PATCH] bitbake: Update users of getVar/setVar to use the data store functions directly
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
X-List-Received-Date: Fri, 25 Nov 2011 15:18:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/bin/bitbake-runtask b/bitbake/bin/bitbake-runtask
index 394b4c3..6a0ecdc 100755
--- a/bitbake/bin/bitbake-runtask
+++ b/bitbake/bin/bitbake-runtask
@@ -91,7 +91,7 @@ def register_idle_function(self, function, data):
 cooker = bb.cooker.BBCooker(config, register_idle_function, initialenv)
 config_data = cooker.configuration.data
 cooker.status = config_data
-cooker.handleCollections(bb.data.getVar("BBFILE_COLLECTIONS", config_data, 1))
+cooker.handleCollections(config_data.getVar("BBFILE_COLLECTIONS", 1))
 
 fn, cls = bb.cache.Cache.virtualfn2realfn(buildfile)
 buildfile = cooker.matchFile(fn)
@@ -108,9 +108,9 @@ if taskname.endswith("_setscene"):
 if hashdata:
     bb.parse.siggen.set_taskdata(hashdata["hashes"], hashdata["deps"])
     for h in hashdata["hashes"]:
-        bb.data.setVar("BBHASH_%s" % h, hashdata["hashes"][h], the_data)
+        the_data.setVar("BBHASH_%s" % h, hashdata["hashes"][h])
     for h in hashdata["deps"]:
-        bb.data.setVar("BBHASHDEPS_%s" % h, hashdata["deps"][h], the_data)
+        the_data.setVar("BBHASHDEPS_%s" % h, hashdata["deps"][h])
 
 ret = 0
 if dryrun != "True":
diff --git a/bitbake/bin/bitdoc b/bitbake/bin/bitdoc
index 08a0173..576d88b 100755
--- a/bitbake/bin/bitdoc
+++ b/bitbake/bin/bitdoc
@@ -462,7 +462,7 @@ def main():
     state_group = 2
 
     for key in bb.data.keys(documentation):
-        data   = bb.data.getVarFlag(key, "doc", documentation)
+        data   = documentation.getVarFlag(key, "doc")
         if not data:
             continue
 
diff --git a/bitbake/doc/manual/usermanual.xml b/bitbake/doc/manual/usermanual.xml
index 687503b..fa53ace 100644
--- a/bitbake/doc/manual/usermanual.xml
+++ b/bitbake/doc/manual/usermanual.xml
@@ -186,7 +186,7 @@ include</literal> directive.</para>
                 <title>Defining Python functions into the global Python namespace</title>
                 <para><emphasis>NOTE:</emphasis> This is only supported in .bb and .bbclass files.</para>
                 <para><screen>def get_depends(bb, d):
-    if bb.data.getVar('SOMECONDITION', d, True):
+    if d.getVar('SOMECONDITION', True):
         return "dependencywithcond"
     else:
         return "dependency"
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 1943322..ae4a962 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -70,9 +70,9 @@ class TaskBase(event.Event):
 
     def __init__(self, t, d ):
         self._task = t
-        self._package = bb.data.getVar("PF", d, 1)
+        self._package = d.getVar("PF", 1)
         event.Event.__init__(self)
-        self._message = "package %s: task %s: %s" % (bb.data.getVar("PF", d, 1), t, bb.event.getName(self)[4:])
+        self._message = "package %s: task %s: %s" % (d.getVar("PF", 1), t, bb.event.getName(self)[4:])
 
     def getTask(self):
         return self._task
diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index fe35e13..6b7fa6f 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -31,7 +31,6 @@
 import os
 import logging
 from collections import defaultdict
-import bb.data
 import bb.utils
 
 logger = logging.getLogger("BitBake.Cache")
@@ -260,7 +259,7 @@ class Cache(object):
         # It will be used in later for deciding whether we 
         # need extra cache file dump/load support 
         self.caches_array = caches_array
-        self.cachedir = bb.data.getVar("CACHE", data, True)
+        self.cachedir = data.getVar("CACHE", True)
         self.clean = set()
         self.checked = set()
         self.depends_cache = {}
@@ -283,7 +282,7 @@ class Cache(object):
         # If any of configuration.data's dependencies are newer than the
         # cache there isn't even any point in loading it...
         newest_mtime = 0
-        deps = bb.data.getVar("__base_depends", data)
+        deps = data.getVar("__base_depends")
 
         old_mtimes = [old_mtime for _, old_mtime in deps]
         old_mtimes.append(newest_mtime)
diff --git a/bitbake/lib/bb/codeparser.py b/bitbake/lib/bb/codeparser.py
index d425514..2590e5c 100644
--- a/bitbake/lib/bb/codeparser.py
+++ b/bitbake/lib/bb/codeparser.py
@@ -36,8 +36,8 @@ pythonparsecache = {}
 shellparsecache = {}
 
 def parser_cachefile(d):
-    cachedir = (bb.data.getVar("PERSISTENT_DIR", d, True) or
-                bb.data.getVar("CACHE", d, True))
+    cachedir = (d.getVar("PERSISTENT_DIR", True) or
+                d.getVar("CACHE", True))
     if cachedir in [None, '']:
         return None
     bb.utils.mkdirhier(cachedir)
diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 41796f6..1808f0c 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -30,7 +30,6 @@ Commands are queued in a CommandQueue
 
 import bb.event
 import bb.cooker
-import bb.data
 
 async_cmds = {}
 sync_cmds = {}
@@ -162,7 +161,7 @@ class CommandsSync:
         if len(params) > 1:
             expand = params[1]
 
-        return bb.data.getVar(varname, command.cooker.configuration.data, expand)
+        return command.cooker.configuration.data.getVar(varname, expand)
 
     def setVariable(self, command, params):
         """
@@ -170,7 +169,7 @@ class CommandsSync:
         """
         varname = params[0]
         value = params[1]
-        bb.data.setVar(varname, value, command.cooker.configuration.data)
+        command.cooker.configuration.data.setVar(varname, value)
 
     def resetCooker(self, command, params):
         """
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 4f01cc1..5bbabfc 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -136,16 +136,16 @@ class BBCooker:
         self.loadConfigurationData()
 
         if not self.configuration.cmd:
-            self.configuration.cmd = bb.data.getVar("BB_DEFAULT_TASK", self.configuration.data, True) or "build"
+            self.configuration.cmd = self.configuration.data.getVar("BB_DEFAULT_TASK", True) or "build"
 
         # Take a lock so only one copy of bitbake can run against a given build
         # directory at a time
-        lockfile = bb.data.expand("${TOPDIR}/bitbake.lock", self.configuration.data)
+        lockfile = self.configuration.data.expand("${TOPDIR}/bitbake.lock")
         self.lock = bb.utils.lockfile(lockfile, False, False)
         if not self.lock:
             bb.fatal("Only one copy of bitbake should be run against a build directory")
 
-        bbpkgs = bb.data.getVar('BBPKGS', self.configuration.data, True)
+        bbpkgs = self.configuration.data.getVar('BBPKGS', True)
         if bbpkgs and len(self.configuration.pkgs_to_build) == 0:
             self.configuration.pkgs_to_build.extend(bbpkgs.split())
 
@@ -174,7 +174,7 @@ class BBCooker:
         self.configuration.data = bb.data.init()
 
         if not self.server_registration_cb:
-            bb.data.setVar("BB_WORKERCONTEXT", "1", self.configuration.data)
+            self.configuration.data.setVar("BB_WORKERCONTEXT", "1")
 
         filtered_keys = bb.utils.approved_variables()
         bb.data.inheritFromOS(self.configuration.data, self.savedenv, filtered_keys)
@@ -189,13 +189,13 @@ class BBCooker:
             sys.exit(1)
 
         if not self.configuration.cmd:
-            self.configuration.cmd = bb.data.getVar("BB_DEFAULT_TASK", self.configuration.data, True) or "build"
+            self.configuration.cmd = self.configuration.data.getVar("BB_DEFAULT_TASK", True) or "build"
 
     def parseConfiguration(self):
 
 
         # Change nice level if we're asked to
-        nice = bb.data.getVar("BB_NICE_LEVEL", self.configuration.data, True)
+        nice = self.configuration.data.getVar("BB_NICE_LEVEL", True)
         if nice:
             curnice = os.nice(0)
             nice = int(nice) - curnice
@@ -293,7 +293,7 @@ class BBCooker:
             # this showEnvironment() code path doesn't use the cache
             self.parseConfiguration()
             self.status = bb.cache.CacheData(self.caches_array)
-            self.handleCollections( bb.data.getVar("BBFILE_COLLECTIONS", self.configuration.data, 1) )
+            self.handleCollections( self.configuration.data.getVar("BBFILE_COLLECTIONS", 1) )
 
             fn = self.matchFile(buildfile)
         elif len(pkgs_to_build) == 1:
@@ -597,7 +597,7 @@ class BBCooker:
         bb.data.expandKeys(localdata)
 
         # Handle PREFERRED_PROVIDERS
-        for p in (bb.data.getVar('PREFERRED_PROVIDERS', localdata, True) or "").split():
+        for p in (localdata.getVar('PREFERRED_PROVIDERS', True) or "").split():
             try:
                 (providee, provider) = p.split(':')
             except:
@@ -645,8 +645,8 @@ class BBCooker:
         # Generate a list of parsed configuration files by searching the files
         # listed in the __depends and __base_depends variables with a .conf suffix.
         conffiles = []
-        dep_files = bb.data.getVar('__depends', self.configuration.data) or set()
-        dep_files.union(bb.data.getVar('__base_depends', self.configuration.data) or set())
+        dep_files = self.configuration.data.getVar('__depends') or set()
+        dep_files.union(self.configuration.data.getVar('__base_depends') or set())
 
         for f in dep_files:
             if f[0].endswith(".conf"):
@@ -674,7 +674,7 @@ class BBCooker:
 
         matches = []
         p = re.compile(re.escape(filepattern))
-        bbpaths = bb.data.getVar('BBPATH', self.configuration.data, True).split(':')
+        bbpaths = self.configuration.data.getVar('BBPATH', True).split(':')
         for path in bbpaths:
             dirpath = os.path.join(path, directory)
             if os.path.exists(dirpath):
@@ -696,7 +696,7 @@ class BBCooker:
 
         data = self.configuration.data
         # iterate configs
-        bbpaths = bb.data.getVar('BBPATH', data, True).split(':')
+        bbpaths = data.getVar('BBPATH', True).split(':')
         for path in bbpaths:
             confpath = os.path.join(path, "conf", var)
             if os.path.exists(confpath):
@@ -801,16 +801,16 @@ class BBCooker:
             parselog.debug(2, "Found bblayers.conf (%s)", layerconf)
             data = _parse(layerconf, data)
 
-            layers = (bb.data.getVar('BBLAYERS', data, True) or "").split()
+            layers = (data.getVar('BBLAYERS', True) or "").split()
 
             data = bb.data.createCopy(data)
             for layer in layers:
                 parselog.debug(2, "Adding layer %s", layer)
-                bb.data.setVar('LAYERDIR', layer, data)
+                data.setVar('LAYERDIR', layer)
                 data = _parse(os.path.join(layer, "conf", "layer.conf"), data)
                 data.expandVarref('LAYERDIR')
 
-            bb.data.delVar('LAYERDIR', data)
+            data.delVar('LAYERDIR')
 
         if not data.getVar("BBPATH", True):
             raise SystemExit("The BBPATH variable is not set")
@@ -828,8 +828,8 @@ class BBCooker:
 
         # Nomally we only register event handlers at the end of parsing .bb files
         # We register any handlers we've found so far here...
-        for var in bb.data.getVar('__BBHANDLERS', data) or []:
-            bb.event.register(var, bb.data.getVar(var, data))
+        for var in data.getVar('__BBHANDLERS') or []:
+            bb.event.register(var, data.getVar(var))
 
         if data.getVar("BB_WORKERCONTEXT", False) is None:
             bb.fetch.fetcher_init(data)
@@ -848,7 +848,7 @@ class BBCooker:
             min_prio = 0
             for c in collection_list:
                 # Get collection priority if defined explicitly
-                priority = bb.data.getVar("BBFILE_PRIORITY_%s" % c, self.configuration.data, 1)
+                priority = self.configuration.data.getVar("BBFILE_PRIORITY_%s" % c, 1)
                 if priority:
                     try:
                         prio = int(priority)
@@ -861,7 +861,7 @@ class BBCooker:
                     collection_priorities[c] = None
 
                 # Check dependencies and store information for priority calculation
-                deps = bb.data.getVar("LAYERDEPENDS_%s" % c, self.configuration.data, 1)
+                deps = self.configuration.data.getVar("LAYERDEPENDS_%s" % c, 1)
                 if deps:
                     depnamelist = []
                     deplist = deps.split()
@@ -880,7 +880,7 @@ class BBCooker:
 
                         if dep in collection_list:
                             if depver:
-                                layerver = bb.data.getVar("LAYERVERSION_%s" % dep, self.configuration.data, 1)
+                                layerver = self.configuration.data.getVar("LAYERVERSION_%s" % dep, 1)
                                 if layerver:
                                     try:
                                         lver = int(layerver)
@@ -913,7 +913,7 @@ class BBCooker:
             # Calculate all layer priorities using calc_layer_priority and store in bbfile_config_priorities
             for c in collection_list:
                 calc_layer_priority(c)
-                regex = bb.data.getVar("BBFILE_PATTERN_%s" % c, self.configuration.data, 1)
+                regex = self.configuration.data.getVar("BBFILE_PATTERN_%s" % c, 1)
                 if regex == None:
                     parselog.error("BBFILE_PATTERN_%s not defined" % c)
                     continue
@@ -928,9 +928,9 @@ class BBCooker:
         """
         Setup any variables needed before starting a build
         """
-        if not bb.data.getVar("BUILDNAME", self.configuration.data):
-            bb.data.setVar("BUILDNAME", time.strftime('%Y%m%d%H%M'), self.configuration.data)
-        bb.data.setVar("BUILDSTART", time.strftime('%m/%d/%Y %H:%M:%S', time.gmtime()), self.configuration.data)
+        if not self.configuration.data.getVar("BUILDNAME"):
+            self.configuration.data.setVar("BUILDNAME", time.strftime('%Y%m%d%H%M'))
+        self.configuration.data.setVar("BUILDSTART", time.strftime('%m/%d/%Y %H:%M:%S', time.gmtime()))
 
     def matchFiles(self, bf):
         """
@@ -977,7 +977,7 @@ class BBCooker:
         # buildFile() doesn't use the cache
         self.parseConfiguration()
         self.status = bb.cache.CacheData(self.caches_array)
-        self.handleCollections( bb.data.getVar("BBFILE_COLLECTIONS", self.configuration.data, 1) )
+        self.handleCollections( self.configuration.data.getVar("BBFILE_COLLECTIONS", 1) )
 
         # If we are told to do the None task then query the default task
         if (task == None):
@@ -1021,7 +1021,7 @@ class BBCooker:
         taskdata = bb.taskdata.TaskData(self.configuration.abort)
         taskdata.add_provider(self.configuration.data, self.status, item)
 
-        buildname = bb.data.getVar("BUILDNAME", self.configuration.data)
+        buildname = self.configuration.data.getVar("BUILDNAME")
         bb.event.fire(bb.event.BuildStarted(buildname, [item]), self.configuration.event_data)
 
         # Execute the runqueue
@@ -1098,7 +1098,7 @@ class BBCooker:
 
         self.buildSetVars()
 
-        buildname = bb.data.getVar("BUILDNAME", self.configuration.data)
+        buildname = self.configuration.data.getVar("BUILDNAME")
         bb.event.fire(bb.event.BuildStarted(buildname, targets), self.configuration.event_data)
 
         localdata = data.createCopy(self.configuration.data)
@@ -1132,16 +1132,16 @@ class BBCooker:
                 del self.status
             self.status = bb.cache.CacheData(self.caches_array)
 
-            ignore = bb.data.getVar("ASSUME_PROVIDED", self.configuration.data, 1) or ""
+            ignore = self.configuration.data.getVar("ASSUME_PROVIDED", 1) or ""
             self.status.ignored_dependencies = set(ignore.split())
 
             for dep in self.configuration.extra_assume_provided:
                 self.status.ignored_dependencies.add(dep)
 
-            self.handleCollections( bb.data.getVar("BBFILE_COLLECTIONS", self.configuration.data, 1) )
+            self.handleCollections( self.configuration.data.getVar("BBFILE_COLLECTIONS", 1) )
 
             (filelist, masked) = self.collect_bbfiles()
-            bb.data.renameVar("__depends", "__base_depends", self.configuration.data)
+            self.configuration.data.renameVar("__depends", "__base_depends")
 
             self.parser = CookerParser(self, filelist, masked)
             self.state = state.parsing
@@ -1232,7 +1232,7 @@ class BBCooker:
                     if g not in newfiles:
                         newfiles.append(g)
 
-        bbmask = bb.data.getVar('BBMASK', self.configuration.data, 1)
+        bbmask = self.configuration.data.getVar('BBMASK', 1)
 
         if bbmask:
             try:
diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 7c1533c..e5c408c 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -266,7 +266,7 @@ def emit_func(func, o=sys.__stdout__, d = init()):
         seen |= deps
         newdeps = set()
         for dep in deps:
-            if bb.data.getVarFlag(dep, "func", d):
+            if d.getVarFlag(dep, "func"):
                emit_var(dep, o, d, False) and o.write('\n')
                newdeps |=  bb.codeparser.ShellParser(dep, logger).parse_shell(d.getVar(dep, True))
         newdeps -= seen
@@ -319,7 +319,7 @@ def generate_dependencies(d):
     deps = {}
     values = {}
 
-    tasklist = bb.data.getVar('__BBTASKS', d) or []
+    tasklist = d.getVar('__BBTASKS') or []
     for task in tasklist:
         deps[task], values[task] = build_dependencies(task, keys, shelldeps, vardepvals, d)
         newdeps = deps[task]
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index ec4e921..ea13478 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -146,7 +146,7 @@ class DataSmart(MutableMapping):
 
         return varparse
 
-    def expand(self, s, varname):
+    def expand(self, s, varname = None):
         return self.expandWithRefs(s, varname).value
 
 
diff --git a/bitbake/lib/bb/fetch/__init__.py b/bitbake/lib/bb/fetch/__init__.py
index 5be4c9c..ea98019 100644
--- a/bitbake/lib/bb/fetch/__init__.py
+++ b/bitbake/lib/bb/fetch/__init__.py
@@ -154,7 +154,7 @@ def fetcher_init(d):
     Calls before this must not hit the cache.
     """
     # When to drop SCM head revisions controlled by user policy
-    srcrev_policy = bb.data.getVar('BB_SRCREV_POLICY', d, 1) or "clear"
+    srcrev_policy = d.getVar('BB_SRCREV_POLICY', 1) or "clear"
     if srcrev_policy == "cache":
         logger.debug(1, "Keeping SRCREV cache due to cache policy of: %s", srcrev_policy)
     elif srcrev_policy == "clear":
@@ -200,7 +200,7 @@ def fetcher_compare_revisions(d):
 def init(urls, d, setup = True):
     urldata = {}
 
-    fn = bb.data.getVar('FILE', d, 1)
+    fn = d.getVar('FILE', 1)
     if fn in urldata_cache:
         urldata = urldata_cache[fn]
 
@@ -243,7 +243,7 @@ def verify_checksum(u, ud, d):
                     'SRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"',
                     ud.localpath, ud.md5_name, md5data,
                     ud.sha256_name, sha256data)
-        if bb.data.getVar("BB_STRICT_CHECKSUM", d, True) == "1":
+        if d.getVar("BB_STRICT_CHECKSUM", True) == "1":
             raise FetchError("No checksum specified for %s." % u)
         return
 
@@ -276,7 +276,7 @@ def go(d, urls = None):
 
         if m.try_premirror(u, ud, d):
             # First try fetching uri, u, from PREMIRRORS
-            mirrors = mirror_from_string(bb.data.getVar('PREMIRRORS', d, True))
+            mirrors = mirror_from_string(d.getVar('PREMIRRORS', True))
             localpath = try_mirrors(d, u, mirrors, False, m.forcefetch(u, ud, d))
         elif os.path.exists(ud.localfile):
             localpath = ud.localfile
@@ -291,7 +291,7 @@ def go(d, urls = None):
                 # Remove any incomplete file
                 bb.utils.remove(ud.localpath)
                 # Finally, try fetching uri, u, from MIRRORS
-                mirrors = mirror_from_string(bb.data.getVar('MIRRORS', d, True))
+                mirrors = mirror_from_string(d.getVar('MIRRORS', True))
                 localpath = try_mirrors (d, u, mirrors)
                 if not localpath or not os.path.exists(localpath):
                     raise FetchError("Unable to fetch URL %s from any source." % u)
@@ -327,7 +327,7 @@ def checkstatus(d, urls = None):
         m = ud.method
         logger.debug(1, "Testing URL %s", u)
         # First try checking uri, u, from PREMIRRORS
-        mirrors = mirror_from_string(bb.data.getVar('PREMIRRORS', d, True))
+        mirrors = mirror_from_string(d.getVar('PREMIRRORS', True))
         ret = try_mirrors(d, u, mirrors, True)
         if not ret:
             # Next try checking from the original uri, u
@@ -335,7 +335,7 @@ def checkstatus(d, urls = None):
                 ret = m.checkstatus(u, ud, d)
             except:
                 # Finally, try checking uri, u, from MIRRORS
-                mirrors = mirror_from_string(bb.data.getVar('MIRRORS', d, True))
+                mirrors = mirror_from_string(d.getVar('MIRRORS', True))
                 ret = try_mirrors (d, u, mirrors, True)
 
         if not ret:
@@ -383,7 +383,7 @@ def get_srcrev(d):
     scms = []
 
     # Only call setup_localpath on URIs which supports_srcrev()
-    urldata = init(bb.data.getVar('SRC_URI', d, 1).split(), d, False)
+    urldata = init(d.getVar('SRC_URI', 1).split(), d, False)
     for u in urldata:
         ud = urldata[u]
         if ud.method.supports_srcrev():
@@ -395,8 +395,8 @@ def get_srcrev(d):
         logger.error("SRCREV was used yet no valid SCM was found in SRC_URI")
         raise ParameterError
 
-    if bb.data.getVar('BB_SRCREV_POLICY', d, True) != "cache":
-        bb.data.setVar('__BB_DONT_CACHE', '1', d)
+    if d.getVar('BB_SRCREV_POLICY', True) != "cache":
+        d.setVar('__BB_DONT_CACHE', '1')
 
     if len(scms) == 1:
         return urldata[scms[0]].method.sortable_revision(scms[0], urldata[scms[0]], d)
@@ -404,7 +404,7 @@ def get_srcrev(d):
     #
     # Mutiple SCMs are in SRC_URI so we resort to SRCREV_FORMAT
     #
-    format = bb.data.getVar('SRCREV_FORMAT', d, 1)
+    format = d.getVar('SRCREV_FORMAT', 1)
     if not format:
         logger.error("The SRCREV_FORMAT variable must be set when multiple SCMs are used.")
         raise ParameterError
@@ -539,8 +539,8 @@ class FetchData(object):
         else:
             self.md5_name = "md5sum"
             self.sha256_name = "sha256sum"
-        self.md5_expected = bb.data.getVarFlag("SRC_URI", self.md5_name, d)
-        self.sha256_expected = bb.data.getVarFlag("SRC_URI", self.sha256_name, d)
+        self.md5_expected = d.getVarFlag("SRC_URI", self.md5_name)
+        self.sha256_expected = d.getVarFlag("SRC_URI", self.sha256_name)
 
         for m in methods:
             if m.supports(url, self, d):
@@ -555,7 +555,7 @@ class FetchData(object):
             self.localpath = self.parm["localpath"]
             self.basename = os.path.basename(self.localpath)
         else:
-            premirrors = bb.data.getVar('PREMIRRORS', d, True)
+            premirrors = d.getVar('PREMIRRORS', True)
             local = ""
             if premirrors and self.url:
                 aurl = self.url.split(";")[0]
@@ -775,7 +775,7 @@ class Fetch(object):
 
         latest_rev = self._build_revision(url, ud, d)
         last_rev = localcounts.get(key + '_rev')
-        uselocalcount = bb.data.getVar("BB_LOCALCOUNT_OVERRIDE", d, True) or False
+        uselocalcount = d.getVar("BB_LOCALCOUNT_OVERRIDE", True) or False
         count = None
         if uselocalcount:
             count = Fetch.localcount_internal_helper(ud, d)
@@ -803,7 +803,7 @@ class Fetch(object):
 
     def generate_revision_key(self, url, ud, d):
         key = self._revision_key(url, ud, d)
-        return "%s-%s" % (key, bb.data.getVar("PN", d, True) or "")
+        return "%s-%s" % (key, d.getVar("PN", True) or "")
 
 from . import cvs
 from . import git
diff --git a/bitbake/lib/bb/fetch/git.py b/bitbake/lib/bb/fetch/git.py
index 49c1cfe..7160919 100644
--- a/bitbake/lib/bb/fetch/git.py
+++ b/bitbake/lib/bb/fetch/git.py
@@ -34,7 +34,7 @@ class Git(Fetch):
         #
         # Only enable _sortable revision if the key is set
         #
-        if bb.data.getVar("BB_GIT_CLONE_FOR_SRCREV", d, True):
+        if d.getVar("BB_GIT_CLONE_FOR_SRCREV", True):
             self._sortable_buildindex = self._sortable_buildindex_disabled
     def supports(self, url, ud, d):
         """
@@ -220,7 +220,7 @@ class Git(Fetch):
 
     def generate_revision_key(self, url, ud, d, branch=False):
         key = self._revision_key(url, ud, d, branch)
-        return "%s-%s" % (key, bb.data.getVar("PN", d, True) or "")
+        return "%s-%s" % (key, d.getVar("PN", True) or "")
 
     def _latest_revision(self, url, ud, d):
         """
@@ -276,7 +276,7 @@ class Git(Fetch):
                 del localcounts[oldkey + '_rev']
                 localcounts[key + '_rev'] = last_rev
 
-        uselocalcount = bb.data.getVar("BB_LOCALCOUNT_OVERRIDE", d, True) or False
+        uselocalcount = d.getVar("BB_LOCALCOUNT_OVERRIDE", True) or False
         count = None
         if uselocalcount:
             count = Fetch.localcount_internal_helper(ud, d)
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index d3c761d..19a79fd 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -28,7 +28,7 @@ from __future__ import absolute_import
 from __future__ import print_function
 import os, re
 import logging
-import bb.data, bb.persist_data, bb.utils
+import bb.persist_data, bb.utils
 from bb import data
 
 __version__ = "2"
@@ -211,7 +211,7 @@ def fetcher_init(d):
     Calls before this must not hit the cache.
     """
     # When to drop SCM head revisions controlled by user policy
-    srcrev_policy = bb.data.getVar('BB_SRCREV_POLICY', d, True) or "clear"
+    srcrev_policy = d.getVar('BB_SRCREV_POLICY', True) or "clear"
     if srcrev_policy == "cache":
         logger.debug(1, "Keeping SRCREV cache due to cache policy of: %s", srcrev_policy)
     elif srcrev_policy == "clear":
@@ -271,7 +271,7 @@ def verify_checksum(u, ud, d):
     sha256data = bb.utils.sha256_file(ud.localpath)
 
     # If strict checking enabled and neither sum defined, raise error
-    strict = bb.data.getVar("BB_STRICT_CHECKSUM", d, True) or None
+    strict = d.getVar("BB_STRICT_CHECKSUM", True) or None
     if (strict and ud.md5_expected == None and ud.sha256_expected == None):
         raise FetchError('No checksum specified for %s, please add at least one to the recipe:\n'
                          'SRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"', u,
@@ -336,8 +336,8 @@ def subprocess_setup():
 
 def get_autorev(d):
     #  only not cache src rev in autorev case
-    if bb.data.getVar('BB_SRCREV_POLICY', d, True) != "cache":
-        bb.data.setVar('__BB_DONT_CACHE', '1', d)
+    if d.getVar('BB_SRCREV_POLICY', True) != "cache":
+        d.setVar('__BB_DONT_CACHE', '1')
     return "AUTOINC"
 
 def get_srcrev(d):
@@ -350,7 +350,7 @@ def get_srcrev(d):
     """
 
     scms = []
-    fetcher = Fetch(bb.data.getVar('SRC_URI', d, True).split(), d)
+    fetcher = Fetch(d.getVar('SRC_URI', True).split(), d)
     urldata = fetcher.ud
     for u in urldata:
         if urldata[u].method.supports_srcrev():
@@ -365,7 +365,7 @@ def get_srcrev(d):
     #
     # Mutiple SCMs are in SRC_URI so we resort to SRCREV_FORMAT
     #
-    format = bb.data.getVar('SRCREV_FORMAT', d, True)
+    format = d.getVar('SRCREV_FORMAT', True)
     if not format:
         raise FetchError("The SRCREV_FORMAT variable must be set when multiple SCMs are used.")
 
@@ -400,7 +400,7 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
                   'GIT_PROXY_IGNORE', 'SOCKS5_USER', 'SOCKS5_PASSWD']
 
     for var in exportvars:
-        val = bb.data.getVar(var, d, True)
+        val = d.getVar(var, True)
         if val:
             cmd = 'export ' + var + '=\"%s\"; %s' % (val, cmd)
 
@@ -440,7 +440,7 @@ def check_network_access(d, info = "", url = None):
     """
     log remote network access, and error if BB_NO_NETWORK is set
     """
-    if bb.data.getVar("BB_NO_NETWORK", d, True) == "1":
+    if d.getVar("BB_NO_NETWORK", True) == "1":
         raise NetworkAccess(url, info)
     else:
         logger.debug(1, "Fetcher accessed the network with the command %s" % info)
@@ -526,15 +526,15 @@ def srcrev_internal_helper(ud, d, name):
         return ud.parm['tag']
 
     rev = None
-    pn = bb.data.getVar("PN", d, True)
+    pn = d.getVar("PN", True)
     if name != '':
-        rev = bb.data.getVar("SRCREV_%s_pn-%s" % (name, pn), d, True)
+        rev = d.getVar("SRCREV_%s_pn-%s" % (name, pn), True)
         if not rev:
-            rev = bb.data.getVar("SRCREV_%s" % name, d, True)
+            rev = d.getVar("SRCREV_%s" % name, True)
     if not rev:
-       rev = bb.data.getVar("SRCREV_pn-%s" % pn, d, True)
+       rev = d.getVar("SRCREV_pn-%s" % pn, True)
     if not rev:
-        rev = bb.data.getVar("SRCREV", d, True)
+        rev = d.getVar("SRCREV", True)
     if rev == "INVALID":
         raise FetchError("Please set SRCREV to a valid value", ud.url)
     if rev == "AUTOINC":
@@ -572,11 +572,11 @@ class FetchData(object):
         if self.md5_name in self.parm:
             self.md5_expected = self.parm[self.md5_name]
         else:
-            self.md5_expected = bb.data.getVarFlag("SRC_URI", self.md5_name, d)
+            self.md5_expected = d.getVarFlag("SRC_URI", self.md5_name)
         if self.sha256_name in self.parm:
             self.sha256_expected = self.parm[self.sha256_name]
         else:
-            self.sha256_expected = bb.data.getVarFlag("SRC_URI", self.sha256_name, d)
+            self.sha256_expected = d.getVarFlag("SRC_URI", self.sha256_name)
 
         self.names = self.parm.get("name",'default').split(',')
 
@@ -600,7 +600,7 @@ class FetchData(object):
             self.localpath = self.method.localpath(self.url, self, d)
 
         # Note: These files should always be in DL_DIR whereas localpath may not be.
-        basepath = bb.data.expand("${DL_DIR}/%s" % os.path.basename(self.localpath or self.basename), d)
+        basepath = d.expand("${DL_DIR}/%s" % os.path.basename(self.localpath or self.basename))
         self.donestamp = basepath + '.done'
         self.lockfile = basepath + '.lock'
 
@@ -626,12 +626,12 @@ class FetchData(object):
         if "srcdate" in self.parm:
             return self.parm['srcdate']
 
-        pn = bb.data.getVar("PN", d, True)
+        pn = d.getVar("PN", True)
 
         if pn:
-            return bb.data.getVar("SRCDATE_%s" % pn, d, True) or bb.data.getVar("SRCDATE", d, True) or bb.data.getVar("DATE", d, True)
+            return d.getVar("SRCDATE_%s" % pn, True) or d.getVar("SRCDATE", True) or d.getVar("DATE", True)
 
-        return bb.data.getVar("SRCDATE", d, True) or bb.data.getVar("DATE", d, True)
+        return d.getVar("SRCDATE", True) or d.getVar("DATE", True)
 
 class FetchMethod(object):
     """Base class for 'fetch'ing data"""
@@ -703,7 +703,7 @@ class FetchMethod(object):
 
         dots = file.split(".")
         if dots[-1] in ['gz', 'bz2', 'Z']:
-            efile = os.path.join(bb.data.getVar('WORKDIR', data, True),os.path.basename('.'.join(dots[0:-1])))
+            efile = os.path.join(data.getVar('WORKDIR', True),os.path.basename('.'.join(dots[0:-1])))
         else:
             efile = file
         cmd = None
@@ -747,7 +747,7 @@ class FetchMethod(object):
             dest = os.path.join(rootdir, os.path.basename(file))
             if (file != dest) and not (os.path.exists(dest) and os.path.samefile(file, dest)):
                 if os.path.isdir(file):
-                    filesdir = os.path.realpath(bb.data.getVar("FILESDIR", data, True))
+                    filesdir = os.path.realpath(data.getVar("FILESDIR", True))
                     destdir = "."
                     if file[0:len(filesdir)] == filesdir:
                         destdir = file[len(filesdir):file.rfind('/')]
@@ -779,7 +779,7 @@ class FetchMethod(object):
             bb.utils.mkdirhier(newdir)
             os.chdir(newdir)
 
-        cmd = "PATH=\"%s\" %s" % (bb.data.getVar('PATH', data, True), cmd)
+        cmd = "PATH=\"%s\" %s" % (data.getVar('PATH', True), cmd)
         bb.note("Unpacking %s to %s/" % (file, os.getcwd()))
         ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True)
 
@@ -824,10 +824,10 @@ class FetchMethod(object):
 
         localcount = None
         if name != '':
-            pn = bb.data.getVar("PN", d, True)
-            localcount = bb.data.getVar("LOCALCOUNT_" + name, d, True)
+            pn = d.getVar("PN", True)
+            localcount = d.getVar("LOCALCOUNT_" + name, True)
         if not localcount:
-            localcount = bb.data.getVar("LOCALCOUNT", d, True)
+            localcount = d.getVar("LOCALCOUNT", True)
         return localcount
 
     localcount_internal_helper = staticmethod(localcount_internal_helper)
@@ -859,7 +859,7 @@ class FetchMethod(object):
 
         latest_rev = self._build_revision(url, ud, d, name)
         last_rev = localcounts.get(key + '_rev')
-        uselocalcount = bb.data.getVar("BB_LOCALCOUNT_OVERRIDE", d, True) or False
+        uselocalcount = d.getVar("BB_LOCALCOUNT_OVERRIDE", True) or False
         count = None
         if uselocalcount:
             count = FetchMethod.localcount_internal_helper(ud, d, name)
@@ -887,7 +887,7 @@ class FetchMethod(object):
 
     def generate_revision_key(self, url, ud, d, name):
         key = self._revision_key(url, ud, d, name)
-        return "%s-%s" % (key, bb.data.getVar("PN", d, True) or "")
+        return "%s-%s" % (key, d.getVar("PN", True) or "")
 
 class Fetch(object):
     def __init__(self, urls, d, cache = True):
@@ -897,7 +897,7 @@ class Fetch(object):
         self.d = d
         self.ud = {}
 
-        fn = bb.data.getVar('FILE', d, True)
+        fn = d.getVar('FILE', True)
         if cache and fn in urldata_cache:
             self.ud = urldata_cache[fn]
 
@@ -913,7 +913,7 @@ class Fetch(object):
             self.ud[url] = FetchData(url, self.d)
 
         self.ud[url].setup_localpath(self.d)
-        return bb.data.expand(self.ud[url].localpath, self.d)
+        return self.d.expand(self.ud[url].localpath)
 
     def localpaths(self):
         """
@@ -935,8 +935,8 @@ class Fetch(object):
         if len(urls) == 0:
             urls = self.urls
 
-        network = bb.data.getVar("BB_NO_NETWORK", self.d, True)
-        premirroronly = (bb.data.getVar("BB_FETCH_PREMIRRORONLY", self.d, True) == "1")
+        network = self.d.getVar("BB_NO_NETWORK", True)
+        premirroronly = (self.d.getVar("BB_FETCH_PREMIRRORONLY", True) == "1")
 
         for u in urls:
             ud = self.ud[u]
@@ -947,17 +947,17 @@ class Fetch(object):
             lf = bb.utils.lockfile(ud.lockfile)
 
             try:
-                bb.data.setVar("BB_NO_NETWORK", network, self.d)
+                self.d.setVar("BB_NO_NETWORK", network)
  
                 if not m.need_update(u, ud, self.d):
                     localpath = ud.localpath
                 elif m.try_premirror(u, ud, self.d):
                     logger.debug(1, "Trying PREMIRRORS")
-                    mirrors = mirror_from_string(bb.data.getVar('PREMIRRORS', self.d, True))
+                    mirrors = mirror_from_string(self.d.getVar('PREMIRRORS', True))
                     localpath = try_mirrors(self.d, ud, mirrors, False)
 
                 if premirroronly:
-                    bb.data.setVar("BB_NO_NETWORK", "1", self.d)
+                    self.d.setVar("BB_NO_NETWORK", "1")
 
                 if not localpath and m.need_update(u, ud, self.d):
                     try:
@@ -979,7 +979,7 @@ class Fetch(object):
                         if os.path.isfile(ud.localpath):
                             bb.utils.remove(ud.localpath)
                         logger.debug(1, "Trying MIRRORS")
-                        mirrors = mirror_from_string(bb.data.getVar('MIRRORS', self.d, True))
+                        mirrors = mirror_from_string(self.d.getVar('MIRRORS', True))
                         localpath = try_mirrors (self.d, ud, mirrors)
 
                 if not localpath or ((not os.path.exists(localpath)) and localpath.find("*") == -1):
@@ -1004,7 +1004,7 @@ class Fetch(object):
             m = ud.method
             logger.debug(1, "Testing URL %s", u)
             # First try checking uri, u, from PREMIRRORS
-            mirrors = mirror_from_string(bb.data.getVar('PREMIRRORS', self.d, True))
+            mirrors = mirror_from_string(self.d.getVar('PREMIRRORS', True))
             ret = try_mirrors(self.d, ud, mirrors, True)
             if not ret:
                 # Next try checking from the original uri, u
@@ -1012,7 +1012,7 @@ class Fetch(object):
                     ret = m.checkstatus(u, ud, self.d)
                 except:
                     # Finally, try checking uri, u, from MIRRORS
-                    mirrors = mirror_from_string(bb.data.getVar('MIRRORS', self.d, True))
+                    mirrors = mirror_from_string(self.d.getVar('MIRRORS', True))
                     ret = try_mirrors (self.d, ud, mirrors, True)
 
             if not ret:
@@ -1030,7 +1030,7 @@ class Fetch(object):
             ud = self.ud[u]
             ud.setup_localpath(self.d)
 
-            if bb.data.expand(self.localpath, self.d) is None:
+            if self.d.expand(self.localpath) is None:
                 continue
 
             if ud.lockfile:
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 87a35d9..f203c5a 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -68,7 +68,7 @@ class Git(FetchMethod):
         #
         # Only enable _sortable revision if the key is set
         #
-        if bb.data.getVar("BB_GIT_CLONE_FOR_SRCREV", d, True):
+        if d.getVar("BB_GIT_CLONE_FOR_SRCREV", True):
             self._sortable_buildindex = self._sortable_buildindex_disabled
     def supports(self, url, ud, d):
         """
@@ -146,7 +146,7 @@ class Git(FetchMethod):
     def try_premirror(self, u, ud, d):
         # If we don't do this, updating an existing checkout with only premirrors
         # is not possible
-        if bb.data.getVar("BB_FETCH_PREMIRRORONLY", d, True) is not None:
+        if d.getVar("BB_FETCH_PREMIRRORONLY", True) is not None:
             return True
         if os.path.exists(ud.clonedir):
             return False
diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__init__.py
index eee8d9c..c5005ae 100644
--- a/bitbake/lib/bb/parse/__init__.py
+++ b/bitbake/lib/bb/parse/__init__.py
@@ -62,9 +62,9 @@ def update_mtime(f):
 def mark_dependency(d, f):
     if f.startswith('./'):
         f = "%s/%s" % (os.getcwd(), f[2:])
-    deps = bb.data.getVar('__depends', d) or set()
+    deps = d.getVar('__depends') or set()
     deps.update([(f, cached_mtime(f))])
-    bb.data.setVar('__depends', deps, d)
+    d.setVar('__depends', deps)
 
 def supports(fn, data):
     """Returns true if we have a handler for this file, false otherwise"""
@@ -90,7 +90,7 @@ def init_parser(d):
 
 def resolve_file(fn, d):
     if not os.path.isabs(fn):
-        bbpath = bb.data.getVar("BBPATH", d, True)
+        bbpath = d.getVar("BBPATH", True)
         newfn = bb.utils.which(bbpath, fn)
         if not newfn:
             raise IOError("file %s not found in %s" % (fn, bbpath))
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 3f9065a..31c930d 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -54,7 +54,7 @@ class IncludeNode(AstNode):
         """
         Include the file and evaluate the statements
         """
-        s = bb.data.expand(self.what_file, data)
+        s = data.expand(self.what_file)
         logger.debug(2, "CONF %s:%s: including %s", self.filename, self.lineno, s)
 
         # TODO: Cache those includes... maybe not here though
@@ -69,7 +69,7 @@ class ExportNode(AstNode):
         self.var = var
 
     def eval(self, data):
-        bb.data.setVarFlag(self.var, "export", 1, data)
+        data.setVarFlag(self.var, "export", 1)
 
 class DataNode(AstNode):
     """
@@ -92,7 +92,7 @@ class DataNode(AstNode):
         groupd = self.groupd
         key = groupd["var"]
         if "exp" in groupd and groupd["exp"] != None:
-            bb.data.setVarFlag(key, "export", 1, data)
+            data.setVarFlag(key, "export", 1)
         if "ques" in groupd and groupd["ques"] != None:
             val = self.getFunc(key, data)
             if val == None:
@@ -100,7 +100,7 @@ class DataNode(AstNode):
         elif "colon" in groupd and groupd["colon"] != None:
             e = data.createCopy()
             bb.data.update_data(e)
-            val = bb.data.expand(groupd["value"], e, key + "[:=]")
+            val = e.expand(groupd["value"], key + "[:=]")
         elif "append" in groupd and groupd["append"] != None:
             val = "%s %s" % ((self.getFunc(key, data) or ""), groupd["value"])
         elif "prepend" in groupd and groupd["prepend"] != None:
@@ -113,11 +113,11 @@ class DataNode(AstNode):
             val = groupd["value"]
 
         if 'flag' in groupd and groupd['flag'] != None:
-            bb.data.setVarFlag(key, groupd['flag'], val, data)
+            data.setVarFlag(key, groupd['flag'], val)
         elif groupd["lazyques"]:
-            bb.data.setVarFlag(key, "defaultval", val, data)
+            data.setVarFlag(key, "defaultval", val)
         else:
-            bb.data.setVar(key, val, data)
+            data.setVar(key, val)
 
 class MethodNode(AstNode):
     def __init__(self, filename, lineno, func_name, body):
@@ -131,12 +131,12 @@ class MethodNode(AstNode):
             if not funcname in bb.methodpool._parsed_fns:
                 text = "def %s(d):\n" % (funcname) + '\n'.join(self.body)
                 bb.methodpool.insert_method(funcname, text, self.filename)
-            anonfuncs = bb.data.getVar('__BBANONFUNCS', data) or []
+            anonfuncs = data.getVar('__BBANONFUNCS') or []
             anonfuncs.append(funcname)
-            bb.data.setVar('__BBANONFUNCS', anonfuncs, data)
+            data.setVar('__BBANONFUNCS', anonfuncs)
         else:
-            bb.data.setVarFlag(self.func_name, "func", 1, data)
-            bb.data.setVar(self.func_name, '\n'.join(self.body), data)
+            data.setVarFlag(self.func_name, "func", 1)
+            data.setVar(self.func_name, '\n'.join(self.body))
 
 class PythonMethodNode(AstNode):
     def __init__(self, filename, lineno, function, define, body):
@@ -152,9 +152,9 @@ class PythonMethodNode(AstNode):
         text = '\n'.join(self.body)
         if not bb.methodpool.parsed_module(self.define):
             bb.methodpool.insert_method(self.define, text, self.filename)
-        bb.data.setVarFlag(self.function, "func", 1, data)
-        bb.data.setVarFlag(self.function, "python", 1, data)
-        bb.data.setVar(self.function, text, data)
+        data.setVarFlag(self.function, "func", 1)
+        data.setVarFlag(self.function, "python", 1)
+        data.setVar(self.function, text)
 
 class MethodFlagsNode(AstNode):
     def __init__(self, filename, lineno, key, m):
@@ -163,19 +163,19 @@ class MethodFlagsNode(AstNode):
         self.m = m
 
     def eval(self, data):
-        if bb.data.getVar(self.key, data):
+        if data.getVar(self.key):
             # clean up old version of this piece of metadata, as its
             # flags could cause problems
-            bb.data.setVarFlag(self.key, 'python', None, data)
-            bb.data.setVarFlag(self.key, 'fakeroot', None, data)
+            data.setVarFlag(self.key, 'python', None)
+            data.setVarFlag(self.key, 'fakeroot', None)
         if self.m.group("py") is not None:
-            bb.data.setVarFlag(self.key, "python", "1", data)
+            data.setVarFlag(self.key, "python", "1")
         else:
-            bb.data.delVarFlag(self.key, "python", data)
+            data.delVarFlag(self.key, "python")
         if self.m.group("fr") is not None:
-            bb.data.setVarFlag(self.key, "fakeroot", "1", data)
+            data.setVarFlag(self.key, "fakeroot", "1")
         else:
-            bb.data.delVarFlag(self.key, "fakeroot", data)
+            data.delVarFlag(self.key, "fakeroot")
 
 class ExportFuncsNode(AstNode):
     def __init__(self, filename, lineno, fns, classes):
@@ -197,25 +197,25 @@ class ExportFuncsNode(AstNode):
                 vars.append([allvars[0], allvars[2]])
 
             for (var, calledvar) in vars:
-                if bb.data.getVar(var, data) and not bb.data.getVarFlag(var, 'export_func', data):
+                if data.getVar(var) and not data.getVarFlag(var, 'export_func'):
                     continue
 
-                if bb.data.getVar(var, data):
-                    bb.data.setVarFlag(var, 'python', None, data)
-                    bb.data.setVarFlag(var, 'func', None, data)
+                if data.getVar(var):
+                    data.setVarFlag(var, 'python', None)
+                    data.setVarFlag(var, 'func', None)
 
                 for flag in [ "func", "python" ]:
-                    if bb.data.getVarFlag(calledvar, flag, data):
-                        bb.data.setVarFlag(var, flag, bb.data.getVarFlag(calledvar, flag, data), data)
+                    if data.getVarFlag(calledvar, flag):
+                        data.setVarFlag(var, flag, data.getVarFlag(calledvar, flag))
                 for flag in [ "dirs" ]:
-                    if bb.data.getVarFlag(var, flag, data):
-                        bb.data.setVarFlag(calledvar, flag, bb.data.getVarFlag(var, flag, data), data)
+                    if data.getVarFlag(var, flag):
+                        data.setVarFlag(calledvar, flag, data.getVarFlag(var, flag))
 
-                if bb.data.getVarFlag(calledvar, "python", data):
-                    bb.data.setVar(var, "\tbb.build.exec_func('" + calledvar + "', d)\n", data)
+                if data.getVarFlag(calledvar, "python"):
+                    data.setVar(var, "\tbb.build.exec_func('" + calledvar + "', d)\n")
                 else:
-                    bb.data.setVar(var, "\t" + calledvar + "\n", data)
-                bb.data.setVarFlag(var, 'export_func', '1', data)
+                    data.setVar(var, "\t" + calledvar + "\n")
+                data.setVarFlag(var, 'export_func', '1')
 
 class AddTaskNode(AstNode):
     def __init__(self, filename, lineno, func, before, after):
@@ -229,25 +229,25 @@ class AddTaskNode(AstNode):
         if self.func[:3] != "do_":
             var = "do_" + self.func
 
-        bb.data.setVarFlag(var, "task", 1, data)
-        bbtasks = bb.data.getVar('__BBTASKS', data) or []
+        data.setVarFlag(var, "task", 1)
+        bbtasks = data.getVar('__BBTASKS') or []
         if not var in bbtasks:
             bbtasks.append(var)
-        bb.data.setVar('__BBTASKS', bbtasks, data)
+        data.setVar('__BBTASKS', bbtasks)
 
-        existing = bb.data.getVarFlag(var, "deps", data) or []
+        existing = data.getVarFlag(var, "deps") or []
         if self.after is not None:
             # set up deps for function
             for entry in self.after.split():
                 if entry not in existing:
                     existing.append(entry)
-        bb.data.setVarFlag(var, "deps", existing, data)
+        data.setVarFlag(var, "deps", existing)
         if self.before is not None:
             # set up things that depend on this func
             for entry in self.before.split():
-                existing = bb.data.getVarFlag(entry, "deps", data) or []
+                existing = data.getVarFlag(entry, "deps") or []
                 if var not in existing:
-                    bb.data.setVarFlag(entry, "deps", [var] + existing, data)
+                    data.setVarFlag(entry, "deps", [var] + existing)
 
 class BBHandlerNode(AstNode):
     def __init__(self, filename, lineno, fns):
@@ -255,11 +255,11 @@ class BBHandlerNode(AstNode):
         self.hs = fns.split()
 
     def eval(self, data):
-        bbhands = bb.data.getVar('__BBHANDLERS', data) or []
+        bbhands = data.getVar('__BBHANDLERS') or []
         for h in self.hs:
             bbhands.append(h)
-            bb.data.setVarFlag(h, "handler", 1, data)
-        bb.data.setVar('__BBHANDLERS', bbhands, data)
+            data.setVarFlag(h, "handler", 1)
+        data.setVar('__BBHANDLERS', bbhands)
 
 class InheritNode(AstNode):
     def __init__(self, filename, lineno, classes):
@@ -308,9 +308,9 @@ def handleInherit(statements, filename, lineno, m):
 
 def finalize(fn, d, variant = None):
     all_handlers = {}
-    for var in bb.data.getVar('__BBHANDLERS', d) or []:
+    for var in d.getVar('__BBHANDLERS') or []:
         # try to add the handler
-        handler = bb.data.getVar(var, d)
+        handler = d.getVar(var)
         bb.event.register(var, handler)
 
     bb.event.fire(bb.event.RecipePreFinalise(fn), d)
@@ -318,12 +318,12 @@ def finalize(fn, d, variant = None):
     bb.data.expandKeys(d)
     bb.data.update_data(d)
     code = []
-    for funcname in bb.data.getVar("__BBANONFUNCS", d) or []:
+    for funcname in d.getVar("__BBANONFUNCS") or []:
         code.append("%s(d)" % funcname)
     bb.utils.simple_exec("\n".join(code), {"d": d})
     bb.data.update_data(d)
 
-    tasklist = bb.data.getVar('__BBTASKS', d) or []
+    tasklist = d.getVar('__BBTASKS') or []
     bb.build.add_tasks(tasklist, d)
 
     bb.parse.siggen.finalise(fn, d, variant)
@@ -378,7 +378,7 @@ def multi_finalize(fn, d):
     try:
         finalize(fn, d)
     except bb.parse.SkipPackage as e:
-        bb.data.setVar("__SKIPPED", e.args[0], d)
+        d.setVar("__SKIPPED", e.args[0])
     datastores = {"": safe_d}
 
     versions = (d.getVar("BBVERSIONS", True) or "").split()
@@ -421,7 +421,7 @@ def multi_finalize(fn, d):
             try:
                 finalize(fn, d)
             except bb.parse.SkipPackage as e:
-                bb.data.setVar("__SKIPPED", e.args[0], d)
+                d.setVar("__SKIPPED", e.args[0])
 
         _create_variants(datastores, versions, verfunc)
 
@@ -461,7 +461,7 @@ def multi_finalize(fn, d):
                 if not onlyfinalise or variant in onlyfinalise:
                     finalize(fn, variant_d, variant)
             except bb.parse.SkipPackage as e:
-                bb.data.setVar("__SKIPPED", e.args[0], variant_d)
+                variant_d.setVar("__SKIPPED", e.args[0])
 
     if len(datastores) > 1:
         variants = filter(None, datastores.iterkeys())
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 8c1bd60..2d6e331 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -159,7 +159,7 @@ def handle(fn, d, include):
             return ast.multi_finalize(fn, d)
 
     if oldfile:
-        bb.data.setVar("FILE", oldfile, d)
+        d.setVar("FILE", oldfile)
 
     # we have parsed the bb class now
     if ext == ".bbclass" or ext == ".inc":
diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index e168d24..6ae9d97 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -24,7 +24,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-import re, bb.data, os
+import re, os
 import logging
 import bb.utils
 from bb.parse import ParseError, resolve_file, ast, logger
@@ -36,9 +36,9 @@ __require_regexp__ = re.compile( r"require\s+(.+)" )
 __export_regexp__ = re.compile( r"export\s+(.+)" )
 
 def init(data):
-    topdir = bb.data.getVar('TOPDIR', data)
+    topdir = data.getVar('TOPDIR')
     if not topdir:
-        bb.data.setVar('TOPDIR', os.getcwd(), data)
+        data.setVar('TOPDIR', os.getcwd())
 
 
 def supports(fn, d):
@@ -53,12 +53,12 @@ def include(oldfn, fn, data, error_out):
         return None
 
     import bb
-    fn = bb.data.expand(fn, data)
-    oldfn = bb.data.expand(oldfn, data)
+    fn = data.expand(fn)
+    oldfn = data.expand(oldfn)
 
     if not os.path.isabs(fn):
         dname = os.path.dirname(oldfn)
-        bbpath = "%s:%s" % (dname, bb.data.getVar("BBPATH", data, 1))
+        bbpath = "%s:%s" % (dname, data.getVar("BBPATH", 1))
         abs_fn = bb.utils.which(bbpath, fn)
         if abs_fn:
             fn = abs_fn
@@ -77,7 +77,7 @@ def handle(fn, data, include):
     if include == 0:
         oldfile = None
     else:
-        oldfile = bb.data.getVar('FILE', data)
+        oldfile = data.getVar('FILE')
 
     abs_fn = resolve_file(fn, data)
     f = open(abs_fn, 'r')
@@ -102,10 +102,10 @@ def handle(fn, data, include):
         feeder(lineno, s, fn, statements)
 
     # DONE WITH PARSING... time to evaluate
-    bb.data.setVar('FILE', abs_fn, data)
+    data.setVar('FILE', abs_fn)
     statements.eval(data)
     if oldfile:
-        bb.data.setVar('FILE', oldfile, data)
+        data.setVar('FILE', oldfile)
 
     return data
 
diff --git a/bitbake/lib/bb/persist_data.py b/bitbake/lib/bb/persist_data.py
index 551b58a..17620ef 100644
--- a/bitbake/lib/bb/persist_data.py
+++ b/bitbake/lib/bb/persist_data.py
@@ -192,9 +192,9 @@ def connect(database):
 
 def persist(domain, d):
     """Convenience factory for SQLTable objects based upon metadata"""
-    import bb.data, bb.utils
-    cachedir = (bb.data.getVar("PERSISTENT_DIR", d, True) or
-                bb.data.getVar("CACHE", d, True))
+    import bb.utils
+    cachedir = (d.getVar("PERSISTENT_DIR", True) or
+                d.getVar("CACHE", True))
     if not cachedir:
         logger.critical("Please set the 'PERSISTENT_DIR' or 'CACHE' variable")
         sys.exit(1)
diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index b2f9896..4543447 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -84,10 +84,10 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
     preferred_ver = None
 
     localdata = data.createCopy(cfgData)
-    bb.data.setVar('OVERRIDES', "%s:pn-%s:%s" % (data.getVar('OVERRIDES', localdata), pn, pn), localdata)
+    localdata.setVar('OVERRIDES', "%s:pn-%s:%s" % (data.getVar('OVERRIDES', localdata), pn, pn))
     bb.data.update_data(localdata)
 
-    preferred_v = bb.data.getVar('PREFERRED_VERSION', localdata, True)
+    preferred_v = localdata.getVar('PREFERRED_VERSION', True)
     if preferred_v:
         m = re.match('(\d+:)*(.*)(_.*)*', preferred_v)
         if m:
@@ -248,7 +248,7 @@ def filterProviders(providers, item, cfgData, dataCache):
 
     eligible = _filterProviders(providers, item, cfgData, dataCache)
 
-    prefervar = bb.data.getVar('PREFERRED_PROVIDER_%s' % item, cfgData, 1)
+    prefervar = cfgData.getVar('PREFERRED_PROVIDER_%s' % item, 1)
     if prefervar:
         dataCache.preferred[item] = prefervar
 
@@ -286,7 +286,7 @@ def filterProvidersRunTime(providers, item, cfgData, dataCache):
         pn = dataCache.pkg_fn[p]
         provides = dataCache.pn_provides[pn]
         for provide in provides:
-            prefervar = bb.data.getVar('PREFERRED_PROVIDER_%s' % provide, cfgData, 1)
+            prefervar = cfgData.getVar('PREFERRED_PROVIDER_%s' % provide, 1)
             logger.debug(1, "checking PREFERRED_PROVIDER_%s (value %s) against %s", provide, prefervar, pns.keys())
             if prefervar in pns and pns[prefervar] not in preferred:
                 var = "PREFERRED_PROVIDER_%s = %s" % (provide, prefervar)
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 36ae1c2..435e7d2 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -188,8 +188,8 @@ class RunQueueData:
         self.targets = targets
         self.rq = rq
 
-        self.stampwhitelist = bb.data.getVar("BB_STAMP_WHITELIST", cfgData, 1) or ""
-        self.multi_provider_whitelist = (bb.data.getVar("MULTI_PROVIDER_WHITELIST", cfgData, 1) or "").split()
+        self.stampwhitelist = cfgData.getVar("BB_STAMP_WHITELIST", 1) or ""
+        self.multi_provider_whitelist = (cfgData.getVar("MULTI_PROVIDER_WHITELIST", 1) or "").split()
 
         self.reset()
 
@@ -765,9 +765,9 @@ class RunQueue:
         self.cfgData = cfgData
         self.rqdata = RunQueueData(self, cooker, cfgData, dataCache, taskData, targets)
 
-        self.stamppolicy = bb.data.getVar("BB_STAMP_POLICY", cfgData, True) or "perfile"
-        self.hashvalidate = bb.data.getVar("BB_HASHCHECK_FUNCTION", cfgData, True) or None
-        self.setsceneverify = bb.data.getVar("BB_SETSCENE_VERIFY_FUNCTION", cfgData, True) or None
+        self.stamppolicy = cfgData.getVar("BB_STAMP_POLICY", True) or "perfile"
+        self.hashvalidate = cfgData.getVar("BB_HASHCHECK_FUNCTION", True) or None
+        self.setsceneverify = cfgData.getVar("BB_SETSCENE_VERIFY_FUNCTION", True) or None
 
         self.state = runQueuePrepare
 
@@ -1007,8 +1007,8 @@ class RunQueueExecute:
         self.cfgData = rq.cfgData
         self.rqdata = rq.rqdata
 
-        self.number_tasks = int(bb.data.getVar("BB_NUMBER_THREADS", self.cfgData, 1) or 1)
-        self.scheduler = bb.data.getVar("BB_SCHEDULER", self.cfgData, 1) or "speed"
+        self.number_tasks = int(self.cfgData.getVar("BB_NUMBER_THREADS", 1) or 1)
+        self.scheduler = self.cfgData.getVar("BB_SCHEDULER", 1) or "speed"
 
         self.runq_buildable = []
         self.runq_running = []
@@ -1132,9 +1132,9 @@ class RunQueueExecute:
             if umask:
                 os.umask(umask)
 
-            bb.data.setVar("BB_WORKERCONTEXT", "1", self.cooker.configuration.data)
-            bb.data.setVar("__RUNQUEUE_DO_NOT_USE_EXTERNALLY", self, self.cooker.configuration.data)
-            bb.data.setVar("__RUNQUEUE_DO_NOT_USE_EXTERNALLY2", fn, self.cooker.configuration.data)
+            self.cooker.configuration.data.setVar("BB_WORKERCONTEXT", "1")
+            self.cooker.configuration.data.setVar("__RUNQUEUE_DO_NOT_USE_EXTERNALLY", self)
+            self.cooker.configuration.data.setVar("__RUNQUEUE_DO_NOT_USE_EXTERNALLY2", fn)
             bb.parse.siggen.set_taskdata(self.rqdata.hashes, self.rqdata.hash_deps)
             ret = 0
             try:
@@ -1261,7 +1261,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                              if type(obj) is type and
                                 issubclass(obj, RunQueueScheduler))
 
-        user_schedulers = bb.data.getVar("BB_SCHEDULERS", self.cfgData, True)
+        user_schedulers = self.cfgData.getVar("BB_SCHEDULERS", True)
         if user_schedulers:
             for sched in user_schedulers.split():
                 if not "." in sched:
@@ -1361,9 +1361,9 @@ class RunQueueExecuteTasks(RunQueueExecute):
                     else:
                         fakeenv["PSEUDO_UNLOAD"] = "yes"
 
-                    bb.data.setVar("BB_WORKERCONTEXT", "1", self.cooker.configuration.data)
-                    bb.data.setVar("__RUNQUEUE_DO_NOT_USE_EXTERNALLY", self, self.cooker.configuration.data)
-                    bb.data.setVar("__RUNQUEUE_DO_NOT_USE_EXTERNALLY2", fn, self.cooker.configuration.data)
+                    self.cooker.configuration.data.setVar("BB_WORKERCONTEXT", "1")
+                    self.cooker.configuration.data.setVar("__RUNQUEUE_DO_NOT_USE_EXTERNALLY", self)
+                    self.cooker.configuration.data.setVar("__RUNQUEUE_DO_NOT_USE_EXTERNALLY2", fn)
                     bb.parse.siggen.set_taskdata(self.rqdata.hashes, self.rqdata.hash_deps)
 
                     the_data = bb.cache.Cache.loadDataFull(fn, self.cooker.get_file_appends(fn), self.cooker.configuration.data)
@@ -1734,8 +1734,8 @@ class runQueueTaskCompleted(runQueueEvent):
     """
 
 def check_stamp_fn(fn, taskname, d):
-    rqexe = bb.data.getVar("__RUNQUEUE_DO_NOT_USE_EXTERNALLY", d)
-    fn = bb.data.getVar("__RUNQUEUE_DO_NOT_USE_EXTERNALLY2", d)
+    rqexe = d.getVar("__RUNQUEUE_DO_NOT_USE_EXTERNALLY")
+    fn = d.getVar("__RUNQUEUE_DO_NOT_USE_EXTERNALLY2")
     fnid = rqexe.rqdata.taskData.getfn_id(fn)
     taskid = rqexe.rqdata.get_task_id(fnid, taskname)
     if taskid is not None:
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 91b4160..8d768ce 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -16,7 +16,7 @@ def init(d):
     siggens = [obj for obj in globals().itervalues()
                       if type(obj) is type and issubclass(obj, SignatureGenerator)]
 
-    desired = bb.data.getVar("BB_SIGNATURE_HANDLER", d, True) or "noop"
+    desired = d.getVar("BB_SIGNATURE_HANDLER", True) or "noop"
     for sg in siggens:
         if desired == sg.name:
             return sg(d)
diff --git a/bitbake/lib/bb/ui/crumbs/configurator.py b/bitbake/lib/bb/ui/crumbs/configurator.py
index 458e056..837ee1c 100644
--- a/bitbake/lib/bb/ui/crumbs/configurator.py
+++ b/bitbake/lib/bb/ui/crumbs/configurator.py
@@ -58,7 +58,7 @@ class Configurator(gobject.GObject):
 
     def _loadConf(self, path):
         def getString(var):
-            return bb.data.getVar(var, data, True) or ""
+            return data.getVar(var, True) or ""
 
         if self.orig_config:
             del self.orig_config
@@ -125,7 +125,7 @@ class Configurator(gobject.GObject):
         self.loaded_layers = {}
         data = bb.data.init()
         data = self._parse(self.bblayers, data)
-        layers = (bb.data.getVar('BBLAYERS', data, True) or "").split()
+        layers = (data.getVar('BBLAYERS', True) or "").split()
         for layer in layers:
             # TODO: we may be better off calling the layer by its
             # BBFILE_COLLECTIONS value?
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 521a068..a26635a 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -562,7 +562,7 @@ def filter_environment(good_vars):
 
 def create_interactive_env(d):
     for k in preserved_envvars_exported_interactive():
-        os.setenv(k, bb.data.getVar(k, d, True))
+        os.setenv(k, d.getVar(k, True))
 
 def approved_variables():
     """
@@ -601,9 +601,9 @@ def build_environment(d):
     """
     import bb.data
     for var in bb.data.keys(d):
-        export = bb.data.getVarFlag(var, "export", d)
+        export = d.getVarFlag(var, "export")
         if export:
-            os.environ[var] = bb.data.getVar(var, d, True) or ""
+            os.environ[var] = d.getVar(var, True) or ""
 
 def remove(path, recurse=False):
     """Equivalent to rm -f or rm -rf"""




