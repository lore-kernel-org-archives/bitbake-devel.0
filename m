Return-Path: <joshua.g.lock@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 504A571B64
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Nov 2016 15:28:13 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 25 Nov 2016 07:28:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,547,1473145200"; d="scan'208";a="1064113752"
Received: from jlock-mobl1.ger.corp.intel.com ([10.252.26.83])
	by orsmga001.jf.intel.com with ESMTP; 25 Nov 2016 07:28:12 -0800
From: Joshua Lock <joshua.g.lock@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 25 Nov 2016 15:28:08 +0000
Message-Id: <1480087689-26680-1-git-send-email-joshua.g.lock@intel.com>
X-Mailer: git-send-email 2.7.4
X-Mailman-Approved-At: Fri, 25 Nov 2016 21:54:54 +0000
Subject: [PATCH 1/2] bitbake: remove True option to getVar calls
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

getVar() now defaults to expanding by default, thus remove the True
option from getVar() calls with a regex search and replace.

Search made with the following regex: getVar ?\(( ?[^,()]*), True\)

Signed-off-by: Joshua Lock <joshua.g.lock@intel.com>
---
 bin/bitbake-layers                                 |  2 +-
 bin/bitbake-worker                                 |  4 +-
 .../bitbake-user-manual-fetching.xml               |  4 +-
 .../bitbake-user-manual-metadata.xml               |  8 +--
 lib/bb/build.py                                    | 40 +++++++-------
 lib/bb/cache.py                                    |  8 +--
 lib/bb/cooker.py                                   | 42 +++++++-------
 lib/bb/cookerdata.py                               | 10 ++--
 lib/bb/data.py                                     | 18 +++---
 lib/bb/data_smart.py                               | 12 ++--
 lib/bb/fetch2/__init__.py                          | 64 +++++++++++-----------
 lib/bb/fetch2/clearcase.py                         | 10 ++--
 lib/bb/fetch2/cvs.py                               | 14 ++---
 lib/bb/fetch2/git.py                               | 12 ++--
 lib/bb/fetch2/hg.py                                | 10 ++--
 lib/bb/fetch2/local.py                             | 12 ++--
 lib/bb/fetch2/npm.py                               | 20 +++----
 lib/bb/fetch2/osc.py                               | 10 ++--
 lib/bb/fetch2/perforce.py                          |  8 +--
 lib/bb/fetch2/repo.py                              |  4 +-
 lib/bb/fetch2/sftp.py                              |  2 +-
 lib/bb/fetch2/ssh.py                               |  4 +-
 lib/bb/fetch2/svn.py                               |  2 +-
 lib/bb/fetch2/wget.py                              | 12 ++--
 lib/bb/monitordisk.py                              |  4 +-
 lib/bb/parse/__init__.py                           |  2 +-
 lib/bb/parse/ast.py                                | 12 ++--
 lib/bb/parse/parse_py/BBHandler.py                 |  2 +-
 lib/bb/parse/parse_py/ConfHandler.py               |  6 +-
 lib/bb/persist_data.py                             |  4 +-
 lib/bb/providers.py                                | 12 ++--
 lib/bb/runqueue.py                                 | 32 +++++------
 lib/bb/siggen.py                                   | 14 ++---
 lib/bb/tests/codeparser.py                         | 12 ++--
 lib/bb/tests/data.py                               | 58 ++++++++++----------
 lib/bb/tests/parse.py                              | 26 ++++-----
 lib/bb/utils.py                                    | 16 +++---
 lib/bblayers/action.py                             |  2 +-
 lib/bblayers/common.py                             |  2 +-
 lib/bblayers/layerindex.py                         |  8 +--
 lib/bblayers/query.py                              | 10 ++--
 lib/prserv/serv.py                                 |  4 +-
 42 files changed, 279 insertions(+), 279 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 946def2..1e2cfbc 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -89,7 +89,7 @@ def main():
     tinfoil = tinfoil_init(False)
     try:
         for path in ([topdir] +
-                    tinfoil.config_data.getVar('BBPATH', True).split(':')):
+                    tinfoil.config_data.getVar('BBPATH').split(':')):
             pluginpath = os.path.join(path, 'lib', 'bblayers')
             bb.utils.load_plugins(logger, plugins, pluginpath)
 
diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index af66ff0..1282471 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -209,7 +209,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, append
                 the_data = bb_cache.loadDataFull(fn, appends)
                 the_data.setVar('BB_TASKHASH', workerdata["runq_hash"][task])
 
-                bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN", True), taskname.replace("do_", "")))
+                bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN"), taskname.replace("do_", "")))
 
                 # exported_vars() returns a generator which *cannot* be passed to os.environ.update() 
                 # successfully. We also need to unset anything from the environment which shouldn't be there 
@@ -228,7 +228,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, append
                 if task_exports:
                     for e in task_exports.split():
                         the_data.setVarFlag(e, 'export', '1')
-                        v = the_data.getVar(e, True)
+                        v = the_data.getVar(e)
                         if v is not None:
                             os.environ[e] = v
 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
index 2a3340b..6e1642c 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
@@ -38,7 +38,7 @@
             The code to execute the first part of this process, a fetch,
             looks something like the following:
             <literallayout class='monospaced'>
-     src_uri = (d.getVar('SRC_URI', True) or "").split()
+     src_uri = (d.getVar('SRC_URI') or "").split()
      fetcher = bb.fetch2.Fetch(src_uri, d)
      fetcher.download()
             </literallayout>
@@ -52,7 +52,7 @@
         <para>
             The instantiation of the fetch class is usually followed by:
             <literallayout class='monospaced'>
-     rootdir = l.getVar('WORKDIR', True)
+     rootdir = l.getVar('WORKDIR')
      fetcher.unpack(rootdir)
             </literallayout>
             This code unpacks the downloaded files to the
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index 71bb25b..6103f34 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -1165,7 +1165,7 @@
                 <literallayout class='monospaced'>
      python some_python_function () {
          d.setVar("TEXT", "Hello World")
-         print d.getVar("TEXT", True)
+         print d.getVar("TEXT")
      }
                 </literallayout>
                 Because the Python "bb" and "os" modules are already
@@ -1180,7 +1180,7 @@
                     to freely set variable values to expandable expressions
                     without having them expanded prematurely.
                     If you do wish to expand a variable within a Python
-                    function, use <filename>d.getVar("X", True)</filename>.
+                    function, use <filename>d.getVar("X")</filename>.
                     Or, for more complicated expressions, use
                     <filename>d.expand()</filename>.
                 </note>
@@ -1232,7 +1232,7 @@
                 Here is an example:
                 <literallayout class='monospaced'>
      def get_depends(d):
-         if d.getVar('SOMECONDITION', True):
+         if d.getVar('SOMECONDITION'):
              return "dependencywithcond"
          else:
              return "dependency"
@@ -1367,7 +1367,7 @@
                 based on the value of  another variable:
                 <literallayout class='monospaced'>
      python () {
-         if d.getVar('SOMEVAR', True) == 'value':
+         if d.getVar('SOMEVAR') == 'value':
              d.setVar('ANOTHERVAR', 'value2')
      }
                 </literallayout>
diff --git a/lib/bb/build.py b/lib/bb/build.py
index e807a09..bdd83cd 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -91,13 +91,13 @@ class TaskBase(event.Event):
 
     def __init__(self, t, logfile, d):
         self._task = t
-        self._package = d.getVar("PF", True)
-        self.taskfile = d.getVar("FILE", True)
+        self._package = d.getVar("PF")
+        self.taskfile = d.getVar("FILE")
         self.taskname = self._task
         self.logfile = logfile
         self.time = time.time()
         event.Event.__init__(self)
-        self._message = "recipe %s: task %s: %s" % (d.getVar("PF", True), t, self.getDisplayName())
+        self._message = "recipe %s: task %s: %s" % (d.getVar("PF"), t, self.getDisplayName())
 
     def getTask(self):
         return self._task
@@ -226,17 +226,17 @@ def exec_func(func, d, dirs = None, pythonexception=False):
     else:
         lockfiles = None
 
-    tempdir = d.getVar('T', True)
+    tempdir = d.getVar('T')
 
     # or func allows items to be executed outside of the normal
     # task set, such as buildhistory
-    task = d.getVar('BB_RUNTASK', True) or func
+    task = d.getVar('BB_RUNTASK') or func
     if task == func:
         taskfunc = task
     else:
         taskfunc = "%s.%s" % (task, func)
 
-    runfmt = d.getVar('BB_RUNFMT', True) or "run.{func}.{pid}"
+    runfmt = d.getVar('BB_RUNFMT') or "run.{func}.{pid}"
     runfn = runfmt.format(taskfunc=taskfunc, task=task, func=func, pid=os.getpid())
     runfile = os.path.join(tempdir, runfn)
     bb.utils.mkdirhier(os.path.dirname(runfile))
@@ -368,7 +368,7 @@ exit $ret
 
     cmd = runfile
     if d.getVarFlag(func, 'fakeroot', False):
-        fakerootcmd = d.getVar('FAKEROOT', True)
+        fakerootcmd = d.getVar('FAKEROOT')
         if fakerootcmd:
             cmd = [fakerootcmd, runfile]
 
@@ -429,7 +429,7 @@ exit $ret
             else:
                 break
 
-    tempdir = d.getVar('T', True)
+    tempdir = d.getVar('T')
     fifopath = os.path.join(tempdir, 'fifo.%s' % os.getpid())
     if os.path.exists(fifopath):
         os.unlink(fifopath)
@@ -442,7 +442,7 @@ exit $ret
                 with open(os.devnull, 'r+') as stdin:
                     bb.process.run(cmd, shell=False, stdin=stdin, log=logfile, extrafiles=[(fifo,readfifo)])
             except bb.process.CmdError:
-                logfn = d.getVar('BB_LOGFILE', True)
+                logfn = d.getVar('BB_LOGFILE')
                 raise FuncFailed(func, logfn)
         finally:
             os.unlink(fifopath)
@@ -473,18 +473,18 @@ def _exec_task(fn, task, d, quieterr):
     logger.debug(1, "Executing task %s", task)
 
     localdata = _task_data(fn, task, d)
-    tempdir = localdata.getVar('T', True)
+    tempdir = localdata.getVar('T')
     if not tempdir:
         bb.fatal("T variable not set, unable to build")
 
     # Change nice level if we're asked to
-    nice = localdata.getVar("BB_TASK_NICE_LEVEL", True)
+    nice = localdata.getVar("BB_TASK_NICE_LEVEL")
     if nice:
         curnice = os.nice(0)
         nice = int(nice) - curnice
         newnice = os.nice(nice)
         logger.debug(1, "Renice to %s " % newnice)
-    ionice = localdata.getVar("BB_TASK_IONICE_LEVEL", True)
+    ionice = localdata.getVar("BB_TASK_IONICE_LEVEL")
     if ionice:
         try:
             cls, prio = ionice.split(".", 1)
@@ -495,7 +495,7 @@ def _exec_task(fn, task, d, quieterr):
     bb.utils.mkdirhier(tempdir)
 
     # Determine the logfile to generate
-    logfmt = localdata.getVar('BB_LOGFMT', True) or 'log.{task}.{pid}'
+    logfmt = localdata.getVar('BB_LOGFMT') or 'log.{task}.{pid}'
     logbase = logfmt.format(task=task, pid=os.getpid())
 
     # Document the order of the tasks...
@@ -627,7 +627,7 @@ def exec_task(fn, task, d, profile = False):
             quieterr = True
 
         if profile:
-            profname = "profile-%s.log" % (d.getVar("PN", True) + "-" + task)
+            profname = "profile-%s.log" % (d.getVar("PN") + "-" + task)
             try:
                 import cProfile as profile
             except:
@@ -667,8 +667,8 @@ def stamp_internal(taskname, d, file_name, baseonly=False, noextra=False):
         stamp = d.stamp[file_name]
         extrainfo = d.stamp_extrainfo[file_name].get(taskflagname) or ""
     else:
-        stamp = d.getVar('STAMP', True)
-        file_name = d.getVar('BB_FILENAME', True)
+        stamp = d.getVar('STAMP')
+        file_name = d.getVar('BB_FILENAME')
         extrainfo = d.getVarFlag(taskflagname, 'stamp-extra-info', True) or ""
 
     if baseonly:
@@ -703,8 +703,8 @@ def stamp_cleanmask_internal(taskname, d, file_name):
         stamp = d.stampclean[file_name]
         extrainfo = d.stamp_extrainfo[file_name].get(taskflagname) or ""
     else:
-        stamp = d.getVar('STAMPCLEAN', True)
-        file_name = d.getVar('BB_FILENAME', True)
+        stamp = d.getVar('STAMPCLEAN')
+        file_name = d.getVar('BB_FILENAME')
         extrainfo = d.getVarFlag(taskflagname, 'stamp-extra-info', True) or ""
 
     if not stamp:
@@ -741,7 +741,7 @@ def make_stamp(task, d, file_name = None):
     # as it completes
     if not task.endswith("_setscene") and task != "do_setscene" and not file_name:
         stampbase = stamp_internal(task, d, None, True)
-        file_name = d.getVar('BB_FILENAME', True)
+        file_name = d.getVar('BB_FILENAME')
         bb.parse.siggen.dump_sigtask(file_name, task, stampbase, True)
 
 def del_stamp(task, d, file_name = None):
@@ -763,7 +763,7 @@ def write_taint(task, d, file_name = None):
     if file_name:
         taintfn = d.stamp[file_name] + '.' + task + '.taint'
     else:
-        taintfn = d.getVar('STAMP', True) + '.' + task + '.taint'
+        taintfn = d.getVar('STAMP') + '.' + task + '.taint'
     bb.utils.mkdirhier(os.path.dirname(taintfn))
     # The specific content of the taint file is not really important,
     # we just need it to be random, so a random UUID is used
diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index dd9cfdf..131abbb 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -296,7 +296,7 @@ def parse_recipe(bb_data, bbfile, appends, mc=''):
     bb_data.setVar("__BBMULTICONFIG", mc)
 
     # expand tmpdir to include this topdir
-    bb_data.setVar('TMPDIR', bb_data.getVar('TMPDIR', True) or "")
+    bb_data.setVar('TMPDIR', bb_data.getVar('TMPDIR') or "")
     bbfile_loc = os.path.abspath(os.path.dirname(bbfile))
     oldpath = os.path.abspath(os.getcwd())
     bb.parse.cached_mtime_noerror(bbfile_loc)
@@ -378,7 +378,7 @@ class Cache(NoCache):
         # It will be used later for deciding whether we 
         # need extra cache file dump/load support 
         self.caches_array = caches_array
-        self.cachedir = data.getVar("CACHE", True)
+        self.cachedir = data.getVar("CACHE")
         self.clean = set()
         self.checked = set()
         self.depends_cache = {}
@@ -792,8 +792,8 @@ class MultiProcessCache(object):
         self.cachedata_extras = self.create_cachedata()
 
     def init_cache(self, d, cache_file_name=None):
-        cachedir = (d.getVar("PERSISTENT_DIR", True) or
-                    d.getVar("CACHE", True))
+        cachedir = (d.getVar("PERSISTENT_DIR") or
+                    d.getVar("CACHE"))
         if cachedir in [None, '']:
             return
         bb.utils.mkdirhier(cachedir)
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index c08af45..1b820d8 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -323,7 +323,7 @@ class BBCooker:
         # Need to preserve BB_CONSOLELOG over resets
         consolelog = None
         if hasattr(self, "data"):
-            consolelog = self.data.getVar("BB_CONSOLELOG", True)
+            consolelog = self.data.getVar("BB_CONSOLELOG")
 
         if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
             self.enableDataTracking()
@@ -518,7 +518,7 @@ class BBCooker:
             bb.msg.loggerVerboseLogs = True
 
         # Change nice level if we're asked to
-        nice = self.data.getVar("BB_NICE_LEVEL", True)
+        nice = self.data.getVar("BB_NICE_LEVEL")
         if nice:
             curnice = os.nice(0)
             nice = int(nice) - curnice
@@ -531,7 +531,7 @@ class BBCooker:
         for mc in self.multiconfigs:
             self.recipecaches[mc] = bb.cache.CacheData(self.caches_array)
 
-        self.handleCollections(self.data.getVar("BBFILE_COLLECTIONS", True))
+        self.handleCollections(self.data.getVar("BBFILE_COLLECTIONS"))
 
     def updateConfigOpts(self, options, environment):
         clean = True
@@ -611,7 +611,7 @@ class BBCooker:
             fn = self.matchFile(fn)
             fn = bb.cache.realfn2virtual(fn, cls, mc)
         elif len(pkgs_to_build) == 1:
-            ignore = self.expanded_data.getVar("ASSUME_PROVIDED", True) or ""
+            ignore = self.expanded_data.getVar("ASSUME_PROVIDED") or ""
             if pkgs_to_build[0] in set(ignore.split()):
                 bb.fatal("%s is in ASSUME_PROVIDED" % pkgs_to_build[0])
 
@@ -995,7 +995,7 @@ class BBCooker:
             bb.data.expandKeys(localdata)
 
             # Handle PREFERRED_PROVIDERS
-            for p in (localdata.getVar('PREFERRED_PROVIDERS', True) or "").split():
+            for p in (localdata.getVar('PREFERRED_PROVIDERS') or "").split():
                 try:
                     (providee, provider) = p.split(':')
                 except:
@@ -1006,7 +1006,7 @@ class BBCooker:
                 self.recipecaches[mc].preferred[providee] = provider
 
     def findCoreBaseFiles(self, subdir, configfile):
-        corebase = self.data.getVar('COREBASE', True) or ""
+        corebase = self.data.getVar('COREBASE') or ""
         paths = []
         for root, dirs, files in os.walk(corebase + '/' + subdir):
             for d in dirs:
@@ -1056,7 +1056,7 @@ class BBCooker:
         """
 
         matches = []
-        bbpaths = self.data.getVar('BBPATH', True).split(':')
+        bbpaths = self.data.getVar('BBPATH').split(':')
         for path in bbpaths:
             dirpath = os.path.join(path, directory)
             if os.path.exists(dirpath):
@@ -1078,7 +1078,7 @@ class BBCooker:
 
         data = self.data
         # iterate configs
-        bbpaths = data.getVar('BBPATH', True).split(':')
+        bbpaths = data.getVar('BBPATH').split(':')
         for path in bbpaths:
             confpath = os.path.join(path, "conf", var)
             if os.path.exists(confpath):
@@ -1147,7 +1147,7 @@ class BBCooker:
                 bb.debug(1,'Processing %s in collection list' % (c))
 
                 # Get collection priority if defined explicitly
-                priority = self.data.getVar("BBFILE_PRIORITY_%s" % c, True)
+                priority = self.data.getVar("BBFILE_PRIORITY_%s" % c)
                 if priority:
                     try:
                         prio = int(priority)
@@ -1161,7 +1161,7 @@ class BBCooker:
                     collection_priorities[c] = None
 
                 # Check dependencies and store information for priority calculation
-                deps = self.data.getVar("LAYERDEPENDS_%s" % c, True)
+                deps = self.data.getVar("LAYERDEPENDS_%s" % c)
                 if deps:
                     try:
                         depDict = bb.utils.explode_dep_versions2(deps)
@@ -1170,7 +1170,7 @@ class BBCooker:
                     for dep, oplist in list(depDict.items()):
                         if dep in collection_list:
                             for opstr in oplist:
-                                layerver = self.data.getVar("LAYERVERSION_%s" % dep, True)
+                                layerver = self.data.getVar("LAYERVERSION_%s" % dep)
                                 (op, depver) = opstr.split()
                                 if layerver:
                                     try:
@@ -1191,7 +1191,7 @@ class BBCooker:
                     collection_depends[c] = []
 
                 # Check recommends and store information for priority calculation
-                recs = self.data.getVar("LAYERRECOMMENDS_%s" % c, True)
+                recs = self.data.getVar("LAYERRECOMMENDS_%s" % c)
                 if recs:
                     try:
                         recDict = bb.utils.explode_dep_versions2(recs)
@@ -1201,7 +1201,7 @@ class BBCooker:
                         if rec in collection_list:
                             if oplist:
                                 opstr = oplist[0]
-                                layerver = self.data.getVar("LAYERVERSION_%s" % rec, True)
+                                layerver = self.data.getVar("LAYERVERSION_%s" % rec)
                                 if layerver:
                                     (op, recver) = opstr.split()
                                     try:
@@ -1235,7 +1235,7 @@ class BBCooker:
             # Calculate all layer priorities using calc_layer_priority and store in bbfile_config_priorities
             for c in collection_list:
                 calc_layer_priority(c)
-                regex = self.data.getVar("BBFILE_PATTERN_%s" % c, True)
+                regex = self.data.getVar("BBFILE_PATTERN_%s" % c)
                 if regex == None:
                     parselog.error("BBFILE_PATTERN_%s not defined" % c)
                     errors = True
@@ -1367,7 +1367,7 @@ class BBCooker:
         taskdata[mc] = bb.taskdata.TaskData(self.configuration.abort)
         taskdata[mc].add_provider(self.data, self.recipecaches[mc], item)
 
-        buildname = self.data.getVar("BUILDNAME", True)
+        buildname = self.data.getVar("BUILDNAME")
         bb.event.fire(bb.event.BuildStarted(buildname, [item]), self.expanded_data)
 
         # Execute the runqueue
@@ -1586,7 +1586,7 @@ class BBCooker:
                 bb.event.fire(bb.event.SanityCheck(False), self.data)
 
             for mc in self.multiconfigs:
-                ignore = self.databuilder.mcdata[mc].getVar("ASSUME_PROVIDED", True) or ""
+                ignore = self.databuilder.mcdata[mc].getVar("ASSUME_PROVIDED") or ""
                 self.recipecaches[mc].ignored_dependencies = set(ignore.split())
 
                 for dep in self.configuration.extra_assume_provided:
@@ -1627,7 +1627,7 @@ class BBCooker:
         if len(pkgs_to_build) == 0:
             raise NothingToBuild
 
-        ignore = (self.expanded_data.getVar("ASSUME_PROVIDED", True) or "").split()
+        ignore = (self.expanded_data.getVar("ASSUME_PROVIDED") or "").split()
         for pkg in pkgs_to_build:
             if pkg in ignore:
                 parselog.warning("Explicit target \"%s\" is in ASSUME_PROVIDED, ignoring" % pkg)
@@ -1797,7 +1797,7 @@ class CookerCollectFiles(object):
 
         collectlog.debug(1, "collecting .bb files")
 
-        files = (config.getVar( "BBFILES", True) or "").split()
+        files = (config.getVar( "BBFILES") or "").split()
         config.setVar("BBFILES", " ".join(files))
 
         # Sort files by priority
@@ -1827,7 +1827,7 @@ class CookerCollectFiles(object):
                     if g not in newfiles:
                         newfiles.append(g)
 
-        bbmask = config.getVar('BBMASK', True)
+        bbmask = config.getVar('BBMASK')
 
         if bbmask:
             # First validate the individual regular expressions and ignore any
@@ -1923,7 +1923,7 @@ class CookerCollectFiles(object):
 
         for collection, pattern, regex, _ in self.bbfile_config_priorities:
             if regex in unmatched:
-                if d.getVar('BBFILE_PATTERN_IGNORE_EMPTY_%s' % collection, True) != '1':
+                if d.getVar('BBFILE_PATTERN_IGNORE_EMPTY_%s' % collection) != '1':
                     collectlog.warning("No bb files matched BBFILE_PATTERN_%s '%s'" % (collection, pattern))
 
         return priorities
@@ -2080,7 +2080,7 @@ class CookerParser(object):
         self.toparse = self.total - len(self.fromcache)
         self.progress_chunk = int(max(self.toparse / 100, 1))
 
-        self.num_processes = min(int(self.cfgdata.getVar("BB_NUMBER_PARSE_THREADS", True) or
+        self.num_processes = min(int(self.cfgdata.getVar("BB_NUMBER_PARSE_THREADS") or
                                  multiprocessing.cpu_count()), len(self.willparse))
 
         self.start()
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index b07c266..680f79a 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -212,7 +212,7 @@ def _inherit(bbclass, data):
 
 def findConfigFile(configfile, data):
     search = []
-    bbpath = data.getVar("BBPATH", True)
+    bbpath = data.getVar("BBPATH")
     if bbpath:
         for i in bbpath.split(":"):
             search.append(os.path.join(i, "conf", configfile))
@@ -286,7 +286,7 @@ class CookerDataBuilder(object):
             self.data_hash = self.data.get_hash()
             self.mcdata[''] = self.data
 
-            multiconfig = (self.data.getVar("BBMULTICONFIG", True) or "").split()
+            multiconfig = (self.data.getVar("BBMULTICONFIG") or "").split()
             for config in multiconfig:
                 mcdata = self.parseConfigurationFiles(['conf/multiconfig/%s.conf' % config] + self.prefiles, self.postfiles)
                 bb.event.fire(bb.event.ConfigParsed(), mcdata)
@@ -319,7 +319,7 @@ class CookerDataBuilder(object):
             data.setVar("TOPDIR", os.path.dirname(os.path.dirname(layerconf)))
             data = parse_config_file(layerconf, data)
 
-            layers = (data.getVar('BBLAYERS', True) or "").split()
+            layers = (data.getVar('BBLAYERS') or "").split()
 
             data = bb.data.createCopy(data)
             approved = bb.utils.approved_variables()
@@ -342,7 +342,7 @@ class CookerDataBuilder(object):
             data.delVar('LAYERDIR_RE')
             data.delVar('LAYERDIR')
 
-        if not data.getVar("BBPATH", True):
+        if not data.getVar("BBPATH"):
             msg = "The BBPATH variable is not set"
             if not layerconf:
                 msg += (" and bitbake did not find a conf/bblayers.conf file in"
@@ -357,7 +357,7 @@ class CookerDataBuilder(object):
             data = parse_config_file(p, data)
 
         # Handle any INHERITs and inherit the base class
-        bbclasses  = ["base"] + (data.getVar('INHERIT', True) or "").split()
+        bbclasses  = ["base"] + (data.getVar('INHERIT') or "").split()
         for bbclass in bbclasses:
             data = _inherit(bbclass, data)
 
diff --git a/lib/bb/data.py b/lib/bb/data.py
index 1a2946f..02a1140 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -121,7 +121,7 @@ def inheritFromOS(d, savedenv, permitted):
     for s in savedenv.keys():
         if s in permitted:
             try:
-                d.setVar(s, savedenv.getVar(s, True), op = 'from env')
+                d.setVar(s, savedenv.getVar(s), op = 'from env')
                 if s in exportlist:
                     d.setVarFlag(s, "export", True, op = 'auto env export')
             except TypeError:
@@ -141,7 +141,7 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
     try:
         if all:
             oval = d.getVar(var, False)
-        val = d.getVar(var, True)
+        val = d.getVar(var)
     except (KeyboardInterrupt, bb.build.FuncFailed):
         raise
     except Exception as exc:
@@ -208,9 +208,9 @@ def exported_vars(d):
     k = list(exported_keys(d))
     for key in k:
         try:
-            value = d.getVar(key, True)
+            value = d.getVar(key)
         except Exception as err:
-            bb.warn("%s: Unable to export ${%s}: %s" % (d.getVar("FILE", True), key, err))
+            bb.warn("%s: Unable to export ${%s}: %s" % (d.getVar("FILE"), key, err))
             continue
 
         if value is not None:
@@ -225,7 +225,7 @@ def emit_func(func, o=sys.__stdout__, d = init()):
 
     o.write('\n')
     emit_var(func, o, d, False) and o.write('\n')
-    newdeps = bb.codeparser.ShellParser(func, logger).parse_shell(d.getVar(func, True))
+    newdeps = bb.codeparser.ShellParser(func, logger).parse_shell(d.getVar(func))
     newdeps |= set((d.getVarFlag(func, "vardeps", True) or "").split())
     seen = set()
     while newdeps:
@@ -235,7 +235,7 @@ def emit_func(func, o=sys.__stdout__, d = init()):
         for dep in deps:
             if d.getVarFlag(dep, "func", False) and not d.getVarFlag(dep, "python", False):
                emit_var(dep, o, d, False) and o.write('\n')
-               newdeps |=  bb.codeparser.ShellParser(dep, logger).parse_shell(d.getVar(dep, True))
+               newdeps |=  bb.codeparser.ShellParser(dep, logger).parse_shell(d.getVar(dep))
                newdeps |= set((d.getVarFlag(dep, "vardeps", True) or "").split())
         newdeps -= seen
 
@@ -295,7 +295,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
         def handle_contains(value, contains, d):
             newvalue = ""
             for k in sorted(contains):
-                l = (d.getVar(k, True) or "").split()
+                l = (d.getVar(k) or "").split()
                 for word in sorted(contains[k]):
                     if word in l:
                         newvalue += "\n%s{%s} = Set" %  (k, word)
@@ -313,7 +313,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
             if varflags.get("python"):
                 parser = bb.codeparser.PythonParser(key, logger)
                 if value and "\t" in value:
-                    logger.warning("Variable %s contains tabs, please remove these (%s)" % (key, d.getVar("FILE", True)))
+                    logger.warning("Variable %s contains tabs, please remove these (%s)" % (key, d.getVar("FILE")))
                 parser.parse_python(value, filename=varflags.get("filename"), lineno=varflags.get("lineno"))
                 deps = deps | parser.references
                 deps = deps | (keys & parser.execs)
@@ -368,7 +368,7 @@ def generate_dependencies(d):
 
     keys = set(key for key in d if not key.startswith("__"))
     shelldeps = set(key for key in d.getVar("__exportlist", False) if d.getVarFlag(key, "export", False) and not d.getVarFlag(key, "unexport", False))
-    varflagsexcl = d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS', True)
+    varflagsexcl = d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS')
 
     deps = {}
     values = {}
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index b7badb6..482399a 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -146,7 +146,7 @@ class DataContext(dict):
         self['d'] = metadata
 
     def __missing__(self, key):
-        value = self.metadata.getVar(key, True)
+        value = self.metadata.getVar(key)
         if value is None or self.metadata.getVarFlag(key, 'func', False):
             raise KeyError(key)
         else:
@@ -318,7 +318,7 @@ class VariableHistory(object):
         the files in which they were added.
         """
         history = self.variable(var)
-        finalitems = (d.getVar(var, True) or '').split()
+        finalitems = (d.getVar(var) or '').split()
         filemap = {}
         isset = False
         for event in history:
@@ -426,11 +426,11 @@ class DataSmart(MutableMapping):
             # Can end up here recursively so setup dummy values
             self.overrides = []
             self.overridesset = set()
-            self.overrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
+            self.overrides = (self.getVar("OVERRIDES") or "").split(":") or []
             self.overridesset = set(self.overrides)
             self.inoverride = False
             self.expand_cache = {}
-            newoverrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
+            newoverrides = (self.getVar("OVERRIDES") or "").split(":") or []
             if newoverrides == self.overrides:
                 break
             self.overrides = newoverrides
@@ -541,7 +541,7 @@ class DataSmart(MutableMapping):
             nextnew = set()
             self.overridevars.update(new)
             for i in new:
-                vardata = self.expandWithRefs(self.getVar(i, True), i)
+                vardata = self.expandWithRefs(self.getVar(i), i)
                 nextnew.update(vardata.references)
                 nextnew.update(vardata.contains.keys())
             new = nextnew
@@ -937,7 +937,7 @@ class DataSmart(MutableMapping):
         bb.data.expandKeys(d)
         bb.data.update_data(d)
 
-        config_whitelist = set((d.getVar("BB_HASHCONFIG_WHITELIST", True) or "").split())
+        config_whitelist = set((d.getVar("BB_HASHCONFIG_WHITELIST") or "").split())
         keys = set(key for key in iter(d) if not key.startswith("__"))
         for key in keys:
             if key in config_whitelist:
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 5c76b22..ced4363 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -491,7 +491,7 @@ def fetcher_init(d):
     Calls before this must not hit the cache.
     """
     # When to drop SCM head revisions controlled by user policy
-    srcrev_policy = d.getVar('BB_SRCREV_POLICY', True) or "clear"
+    srcrev_policy = d.getVar('BB_SRCREV_POLICY') or "clear"
     if srcrev_policy == "cache":
         logger.debug(1, "Keeping SRCREV cache due to cache policy of: %s", srcrev_policy)
     elif srcrev_policy == "clear":
@@ -572,7 +572,7 @@ def verify_checksum(ud, d, precomputed={}):
 
     if ud.method.recommends_checksum(ud) and not ud.md5_expected and not ud.sha256_expected:
         # If strict checking enabled and neither sum defined, raise error
-        strict = d.getVar("BB_STRICT_CHECKSUM", True) or "0"
+        strict = d.getVar("BB_STRICT_CHECKSUM") or "0"
         if strict == "1":
             logger.error('No checksum specified for %s, please add at least one to the recipe:\n'
                              'SRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"' %
@@ -718,7 +718,7 @@ def subprocess_setup():
 
 def get_autorev(d):
     #  only not cache src rev in autorev case
-    if d.getVar('BB_SRCREV_POLICY', True) != "cache":
+    if d.getVar('BB_SRCREV_POLICY') != "cache":
         d.setVar('BB_DONT_CACHE', '1')
     return "AUTOINC"
 
@@ -737,7 +737,7 @@ def get_srcrev(d, method_name='sortable_revision'):
     """
 
     scms = []
-    fetcher = Fetch(d.getVar('SRC_URI', True).split(), d)
+    fetcher = Fetch(d.getVar('SRC_URI').split(), d)
     urldata = fetcher.ud
     for u in urldata:
         if urldata[u].method.supports_srcrev():
@@ -757,7 +757,7 @@ def get_srcrev(d, method_name='sortable_revision'):
     #
     # Mutiple SCMs are in SRC_URI so we resort to SRCREV_FORMAT
     #
-    format = d.getVar('SRCREV_FORMAT', True)
+    format = d.getVar('SRCREV_FORMAT')
     if not format:
         raise FetchError("The SRCREV_FORMAT variable must be set when multiple SCMs are used.")
 
@@ -821,7 +821,7 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
 
     origenv = d.getVar("BB_ORIGENV", False)
     for var in exportvars:
-        val = d.getVar(var, True) or (origenv and origenv.getVar(var, True))
+        val = d.getVar(var) or (origenv and origenv.getVar(var))
         if val:
             cmd = 'export ' + var + '=\"%s\"; %s' % (val, cmd)
 
@@ -860,7 +860,7 @@ def check_network_access(d, info = "", url = None):
     """
     log remote network access, and error if BB_NO_NETWORK is set
     """
-    if d.getVar("BB_NO_NETWORK", True) == "1":
+    if d.getVar("BB_NO_NETWORK") == "1":
         raise NetworkAccess(url, info)
     else:
         logger.debug(1, "Fetcher accessed the network with the command %s" % info)
@@ -958,7 +958,7 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
 
         # We may be obtaining a mirror tarball which needs further processing by the real fetcher
         # If that tarball is a local file:// we need to provide a symlink to it
-        dldir = ld.getVar("DL_DIR", True)
+        dldir = ld.getVar("DL_DIR")
         if origud.mirrortarball and os.path.basename(ud.localpath) == os.path.basename(origud.mirrortarball) \
                 and os.path.basename(ud.localpath) != os.path.basename(origud.localpath):
             # Create donestamp in old format to avoid triggering a re-download
@@ -1032,14 +1032,14 @@ def trusted_network(d, url):
     BB_ALLOWED_NETWORKS is set globally or for a specific recipe.
     Note: modifies SRC_URI & mirrors.
     """
-    if d.getVar('BB_NO_NETWORK', True) == "1":
+    if d.getVar('BB_NO_NETWORK') == "1":
         return True
 
     pkgname = d.expand(d.getVar('PN', False))
     trusted_hosts = d.getVarFlag('BB_ALLOWED_NETWORKS', pkgname, False)
 
     if not trusted_hosts:
-        trusted_hosts = d.getVar('BB_ALLOWED_NETWORKS', True)
+        trusted_hosts = d.getVar('BB_ALLOWED_NETWORKS')
 
     # Not enabled.
     if not trusted_hosts:
@@ -1071,7 +1071,7 @@ def srcrev_internal_helper(ud, d, name):
     """
 
     srcrev = None
-    pn = d.getVar("PN", True)
+    pn = d.getVar("PN")
     attempts = []
     if name != '' and pn:
         attempts.append("SRCREV_%s_pn-%s" % (name, pn))
@@ -1082,7 +1082,7 @@ def srcrev_internal_helper(ud, d, name):
     attempts.append("SRCREV")
 
     for a in attempts:
-        srcrev = d.getVar(a, True)              
+        srcrev = d.getVar(a)              
         if srcrev and srcrev != "INVALID":
             break
 
@@ -1115,7 +1115,7 @@ def get_checksum_file_list(d):
     """
     fetch = Fetch([], d, cache = False, localonly = True)
 
-    dl_dir = d.getVar('DL_DIR', True)
+    dl_dir = d.getVar('DL_DIR')
     filelist = []
     for u in fetch.urls:
         ud = fetch.ud[u]
@@ -1129,9 +1129,9 @@ def get_checksum_file_list(d):
                 if f.startswith(dl_dir):
                     # The local fetcher's behaviour is to return a path under DL_DIR if it couldn't find the file anywhere else
                     if os.path.exists(f):
-                        bb.warn("Getting checksum for %s SRC_URI entry %s: file not found except in DL_DIR" % (d.getVar('PN', True), os.path.basename(f)))
+                        bb.warn("Getting checksum for %s SRC_URI entry %s: file not found except in DL_DIR" % (d.getVar('PN'), os.path.basename(f)))
                     else:
-                        bb.warn("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('PN', True), os.path.basename(f)))
+                        bb.warn("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('PN'), os.path.basename(f)))
                 filelist.append(f + ":" + str(os.path.exists(f)))
 
     return " ".join(filelist)
@@ -1204,7 +1204,7 @@ class FetchData(object):
             raise NonLocalMethod()
 
         if self.parm.get("proto", None) and "protocol" not in self.parm:
-            logger.warning('Consider updating %s recipe to use "protocol" not "proto" in SRC_URI.', d.getVar('PN', True))
+            logger.warning('Consider updating %s recipe to use "protocol" not "proto" in SRC_URI.', d.getVar('PN'))
             self.parm["protocol"] = self.parm.get("proto", None)
 
         if hasattr(self.method, "urldata_init"):
@@ -1217,7 +1217,7 @@ class FetchData(object):
         elif self.localfile:
             self.localpath = self.method.localpath(self, d)
 
-        dldir = d.getVar("DL_DIR", True)
+        dldir = d.getVar("DL_DIR")
 
         if not self.needdonestamp:
             return
@@ -1257,12 +1257,12 @@ class FetchData(object):
         if "srcdate" in self.parm:
             return self.parm['srcdate']
 
-        pn = d.getVar("PN", True)
+        pn = d.getVar("PN")
 
         if pn:
-            return d.getVar("SRCDATE_%s" % pn, True) or d.getVar("SRCDATE", True) or d.getVar("DATE", True)
+            return d.getVar("SRCDATE_%s" % pn) or d.getVar("SRCDATE") or d.getVar("DATE")
 
-        return d.getVar("SRCDATE", True) or d.getVar("DATE", True)
+        return d.getVar("SRCDATE") or d.getVar("DATE")
 
 class FetchMethod(object):
     """Base class for 'fetch'ing data"""
@@ -1282,7 +1282,7 @@ class FetchMethod(object):
         Can also setup variables in urldata for use in go (saving code duplication
         and duplicate code execution)
         """
-        return os.path.join(d.getVar("DL_DIR", True), urldata.localfile)
+        return os.path.join(d.getVar("DL_DIR"), urldata.localfile)
 
     def supports_checksum(self, urldata):
         """
@@ -1450,7 +1450,7 @@ class FetchMethod(object):
         if not cmd:
             return
 
-        path = data.getVar('PATH', True)
+        path = data.getVar('PATH')
         if path:
             cmd = "PATH=\"%s\" %s" % (path, cmd)
         bb.note("Unpacking %s to %s/" % (file, unpackdir))
@@ -1507,7 +1507,7 @@ class FetchMethod(object):
 
     def generate_revision_key(self, ud, d, name):
         key = self._revision_key(ud, d, name)
-        return "%s-%s" % (key, d.getVar("PN", True) or "")
+        return "%s-%s" % (key, d.getVar("PN") or "")
 
 class Fetch(object):
     def __init__(self, urls, d, cache = True, localonly = False, connection_cache = None):
@@ -1515,14 +1515,14 @@ class Fetch(object):
             raise Exception("bb.fetch2.Fetch.__init__: cannot set cache and localonly at same time")
 
         if len(urls) == 0:
-            urls = d.getVar("SRC_URI", True).split()
+            urls = d.getVar("SRC_URI").split()
         self.urls = urls
         self.d = d
         self.ud = {}
         self.connection_cache = connection_cache
 
-        fn = d.getVar('FILE', True)
-        mc = d.getVar('__BBMULTICONFIG', True) or ""
+        fn = d.getVar('FILE')
+        mc = d.getVar('__BBMULTICONFIG') or ""
         if cache and fn and mc + fn in urldata_cache:
             self.ud = urldata_cache[mc + fn]
 
@@ -1565,8 +1565,8 @@ class Fetch(object):
         if not urls:
             urls = self.urls
 
-        network = self.d.getVar("BB_NO_NETWORK", True)
-        premirroronly = (self.d.getVar("BB_FETCH_PREMIRRORONLY", True) == "1")
+        network = self.d.getVar("BB_NO_NETWORK")
+        premirroronly = (self.d.getVar("BB_FETCH_PREMIRRORONLY") == "1")
 
         for u in urls:
             ud = self.ud[u]
@@ -1584,7 +1584,7 @@ class Fetch(object):
                     localpath = ud.localpath
                 elif m.try_premirror(ud, self.d):
                     logger.debug(1, "Trying PREMIRRORS")
-                    mirrors = mirror_from_string(self.d.getVar('PREMIRRORS', True))
+                    mirrors = mirror_from_string(self.d.getVar('PREMIRRORS'))
                     localpath = try_mirrors(self, self.d, ud, mirrors, False)
 
                 if premirroronly:
@@ -1624,7 +1624,7 @@ class Fetch(object):
                         if not verified_stamp:
                             m.clean(ud, self.d)
                         logger.debug(1, "Trying MIRRORS")
-                        mirrors = mirror_from_string(self.d.getVar('MIRRORS', True))
+                        mirrors = mirror_from_string(self.d.getVar('MIRRORS'))
                         localpath = try_mirrors(self, self.d, ud, mirrors)
 
                 if not localpath or ((not os.path.exists(localpath)) and localpath.find("*") == -1):
@@ -1657,7 +1657,7 @@ class Fetch(object):
             m = ud.method
             logger.debug(1, "Testing URL %s", u)
             # First try checking uri, u, from PREMIRRORS
-            mirrors = mirror_from_string(self.d.getVar('PREMIRRORS', True))
+            mirrors = mirror_from_string(self.d.getVar('PREMIRRORS'))
             ret = try_mirrors(self, self.d, ud, mirrors, True)
             if not ret:
                 # Next try checking from the original uri, u
@@ -1665,7 +1665,7 @@ class Fetch(object):
                     ret = m.checkstatus(self, ud, self.d)
                 except:
                     # Finally, try checking uri, u, from MIRRORS
-                    mirrors = mirror_from_string(self.d.getVar('MIRRORS', True))
+                    mirrors = mirror_from_string(self.d.getVar('MIRRORS'))
                     ret = try_mirrors(self, self.d, ud, mirrors, True)
 
             if not ret:
diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
index d35b2da..8df8f53 100644
--- a/lib/bb/fetch2/clearcase.py
+++ b/lib/bb/fetch2/clearcase.py
@@ -108,13 +108,13 @@ class ClearCase(FetchMethod):
         else:
             ud.module = ""
 
-        ud.basecmd = d.getVar("FETCHCMD_ccrc", True) or spawn.find_executable("cleartool") or spawn.find_executable("rcleartool")
+        ud.basecmd = d.getVar("FETCHCMD_ccrc") or spawn.find_executable("cleartool") or spawn.find_executable("rcleartool")
 
-        if d.getVar("SRCREV", True) == "INVALID":
+        if d.getVar("SRCREV") == "INVALID":
           raise FetchError("Set a valid SRCREV for the clearcase fetcher in your recipe, e.g. SRCREV = \"/main/LATEST\" or any other label of your choice.")
 
         ud.label = d.getVar("SRCREV", False)
-        ud.customspec = d.getVar("CCASE_CUSTOM_CONFIG_SPEC", True)
+        ud.customspec = d.getVar("CCASE_CUSTOM_CONFIG_SPEC")
 
         ud.server     = "%s://%s%s" % (ud.proto, ud.host, ud.path)
 
@@ -124,7 +124,7 @@ class ClearCase(FetchMethod):
 
         ud.viewname         = "%s-view%s" % (ud.identifier, d.getVar("DATETIME", d, True))
         ud.csname           = "%s-config-spec" % (ud.identifier)
-        ud.ccasedir         = os.path.join(d.getVar("DL_DIR", True), ud.type)
+        ud.ccasedir         = os.path.join(d.getVar("DL_DIR"), ud.type)
         ud.viewdir          = os.path.join(ud.ccasedir, ud.viewname)
         ud.configspecfile   = os.path.join(ud.ccasedir, ud.csname)
         ud.localfile        = "%s.tar.gz" % (ud.identifier)
@@ -144,7 +144,7 @@ class ClearCase(FetchMethod):
         self.debug("configspecfile  = %s" % ud.configspecfile)
         self.debug("localfile       = %s" % ud.localfile)
 
-        ud.localfile = os.path.join(d.getVar("DL_DIR", True), ud.localfile)
+        ud.localfile = os.path.join(d.getVar("DL_DIR"), ud.localfile)
 
     def _build_ccase_command(self, ud, command):
         """
diff --git a/lib/bb/fetch2/cvs.py b/lib/bb/fetch2/cvs.py
index 5ff70ba..64c50c2 100644
--- a/lib/bb/fetch2/cvs.py
+++ b/lib/bb/fetch2/cvs.py
@@ -87,10 +87,10 @@ class Cvs(FetchMethod):
             cvsroot = ud.path
         else:
             cvsroot = ":" + method
-            cvsproxyhost = d.getVar('CVS_PROXY_HOST', True)
+            cvsproxyhost = d.getVar('CVS_PROXY_HOST')
             if cvsproxyhost:
                 cvsroot += ";proxy=" + cvsproxyhost
-            cvsproxyport = d.getVar('CVS_PROXY_PORT', True)
+            cvsproxyport = d.getVar('CVS_PROXY_PORT')
             if cvsproxyport:
                 cvsroot += ";proxyport=" + cvsproxyport
             cvsroot += ":" + ud.user
@@ -110,7 +110,7 @@ class Cvs(FetchMethod):
         if ud.tag:
             options.append("-r %s" % ud.tag)
 
-        cvsbasecmd = d.getVar("FETCHCMD_cvs", True)
+        cvsbasecmd = d.getVar("FETCHCMD_cvs")
         cvscmd = cvsbasecmd + " '-d" + cvsroot + "' co " + " ".join(options) + " " + ud.module
         cvsupdatecmd = cvsbasecmd + " '-d" + cvsroot + "' update -d -P " + " ".join(options)
 
@@ -120,8 +120,8 @@ class Cvs(FetchMethod):
 
         # create module directory
         logger.debug(2, "Fetch: checking for module directory")
-        pkg = d.getVar('PN', True)
-        pkgdir = os.path.join(d.getVar('CVSDIR', True), pkg)
+        pkg = d.getVar('PN')
+        pkgdir = os.path.join(d.getVar('CVSDIR'), pkg)
         moddir = os.path.join(pkgdir, localdir)
         workdir = None
         if os.access(os.path.join(moddir, 'CVS'), os.R_OK):
@@ -164,8 +164,8 @@ class Cvs(FetchMethod):
     def clean(self, ud, d):
         """ Clean CVS Files and tarballs """
 
-        pkg = d.getVar('PN', True)
-        pkgdir = os.path.join(d.getVar("CVSDIR", True), pkg)
+        pkg = d.getVar('PN')
+        pkgdir = os.path.join(d.getVar("CVSDIR"), pkg)
 
         bb.utils.remove(pkgdir, True)
         bb.utils.remove(ud.localpath)
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 6b61834..cb9fa3f 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -182,9 +182,9 @@ class Git(FetchMethod):
         if ud.usehead:
             ud.unresolvedrev['default'] = 'HEAD'
 
-        ud.basecmd = d.getVar("FETCHCMD_git", True) or "git -c core.fsyncobjectfiles=0"
+        ud.basecmd = d.getVar("FETCHCMD_git") or "git -c core.fsyncobjectfiles=0"
 
-        ud.write_tarballs = ((d.getVar("BB_GENERATE_MIRROR_TARBALLS", True) or "0") != "0") or ud.rebaseable
+        ud.write_tarballs = ((d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0") != "0") or ud.rebaseable
 
         ud.setup_revisons(d)
 
@@ -207,8 +207,8 @@ class Git(FetchMethod):
             for name in ud.names:
                 gitsrcname = gitsrcname + '_' + ud.revisions[name]
         ud.mirrortarball = 'git2_%s.tar.gz' % (gitsrcname)
-        ud.fullmirror = os.path.join(d.getVar("DL_DIR", True), ud.mirrortarball)
-        gitdir = d.getVar("GITDIR", True) or (d.getVar("DL_DIR", True) + "/git2/")
+        ud.fullmirror = os.path.join(d.getVar("DL_DIR"), ud.mirrortarball)
+        gitdir = d.getVar("GITDIR") or (d.getVar("DL_DIR") + "/git2/")
         ud.clonedir = os.path.join(gitdir, gitsrcname)
 
         ud.localfile = ud.clonedir
@@ -229,7 +229,7 @@ class Git(FetchMethod):
     def try_premirror(self, ud, d):
         # If we don't do this, updating an existing checkout with only premirrors
         # is not possible
-        if d.getVar("BB_FETCH_PREMIRRORONLY", True) is not None:
+        if d.getVar("BB_FETCH_PREMIRRORONLY") is not None:
             return True
         if os.path.exists(ud.clonedir):
             return False
@@ -418,7 +418,7 @@ class Git(FetchMethod):
         """
         pupver = ('', '')
 
-        tagregex = re.compile(d.getVar('UPSTREAM_CHECK_GITTAGREGEX', True) or "(?P<pver>([0-9][\.|_]?)+)")
+        tagregex = re.compile(d.getVar('UPSTREAM_CHECK_GITTAGREGEX') or "(?P<pver>([0-9][\.|_]?)+)")
         try:
             output = self._lsremote(ud, d, "refs/tags/*")
         except bb.fetch2.FetchError or bb.fetch2.NetworkAccess:
diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index a1419aa..ee5b2dd 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -78,15 +78,15 @@ class Hg(FetchMethod):
         hgsrcname = '%s_%s_%s' % (ud.module.replace('/', '.'), \
                             ud.host, ud.path.replace('/', '.'))
         ud.mirrortarball = 'hg_%s.tar.gz' % hgsrcname
-        ud.fullmirror = os.path.join(d.getVar("DL_DIR", True), ud.mirrortarball)
+        ud.fullmirror = os.path.join(d.getVar("DL_DIR"), ud.mirrortarball)
 
-        hgdir = d.getVar("HGDIR", True) or (d.getVar("DL_DIR", True) + "/hg/")
+        hgdir = d.getVar("HGDIR") or (d.getVar("DL_DIR") + "/hg/")
         ud.pkgdir = os.path.join(hgdir, hgsrcname)
         ud.moddir = os.path.join(ud.pkgdir, ud.module)
         ud.localfile = ud.moddir
-        ud.basecmd = d.getVar("FETCHCMD_hg", True) or "/usr/bin/env hg"
+        ud.basecmd = d.getVar("FETCHCMD_hg") or "/usr/bin/env hg"
 
-        ud.write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS", True)
+        ud.write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS")
 
     def need_update(self, ud, d):
         revTag = ud.parm.get('rev', 'tip')
@@ -99,7 +99,7 @@ class Hg(FetchMethod):
     def try_premirror(self, ud, d):
         # If we don't do this, updating an existing checkout with only premirrors
         # is not possible
-        if d.getVar("BB_FETCH_PREMIRRORONLY", True) is not None:
+        if d.getVar("BB_FETCH_PREMIRRORONLY") is not None:
             return True
         if os.path.exists(ud.moddir):
             return False
diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index 5adfd5d..8377888 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -63,13 +63,13 @@ class Local(FetchMethod):
         newpath = path
         if path[0] == "/":
             return [path]
-        filespath = d.getVar('FILESPATH', True)
+        filespath = d.getVar('FILESPATH')
         if filespath:
             logger.debug(2, "Searching for %s in paths:\n    %s" % (path, "\n    ".join(filespath.split(":"))))
             newpath, hist = bb.utils.which(filespath, path, history=True)
             searched.extend(hist)
         if not newpath:
-            filesdir = d.getVar('FILESDIR', True)
+            filesdir = d.getVar('FILESDIR')
             if filesdir:
                 logger.debug(2, "Searching for %s in path: %s" % (path, filesdir))
                 newpath = os.path.join(filesdir, path)
@@ -81,7 +81,7 @@ class Local(FetchMethod):
             logger.debug(2, "Searching for %s in path: %s" % (path, newpath))
             return searched
         if not os.path.exists(newpath):
-            dldirfile = os.path.join(d.getVar("DL_DIR", True), path)
+            dldirfile = os.path.join(d.getVar("DL_DIR"), path)
             logger.debug(2, "Defaulting to %s for %s" % (dldirfile, path))
             bb.utils.mkdirhier(os.path.dirname(dldirfile))
             searched.append(dldirfile)
@@ -100,13 +100,13 @@ class Local(FetchMethod):
         # no need to fetch local files, we'll deal with them in place.
         if self.supports_checksum(urldata) and not os.path.exists(urldata.localpath):
             locations = []
-            filespath = d.getVar('FILESPATH', True)
+            filespath = d.getVar('FILESPATH')
             if filespath:
                 locations = filespath.split(":")
-            filesdir = d.getVar('FILESDIR', True)
+            filesdir = d.getVar('FILESDIR')
             if filesdir:
                 locations.append(filesdir)
-            locations.append(d.getVar("DL_DIR", True))
+            locations.append(d.getVar("DL_DIR"))
 
             msg = "Unable to find file " + urldata.url + " anywhere. The paths that were searched were:\n    " + "\n    ".join(locations)
             raise FetchError(msg)
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 66ab075..cbeb8ff 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -87,12 +87,12 @@ class Npm(FetchMethod):
             bb.utils.mkdirhier(ud.pkgdatadir)
         ud.localpath = d.expand("${DL_DIR}/npm/%s" % ud.bbnpmmanifest)
 
-        self.basecmd = d.getVar("FETCHCMD_wget", True) or "/usr/bin/env wget -O -t 2 -T 30 -nv --passive-ftp --no-check-certificate "
+        self.basecmd = d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -O -t 2 -T 30 -nv --passive-ftp --no-check-certificate "
         ud.prefixdir = prefixdir
 
-        ud.write_tarballs = ((d.getVar("BB_GENERATE_MIRROR_TARBALLS", True) or "0") != "0")
+        ud.write_tarballs = ((d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0") != "0")
         ud.mirrortarball = 'npm_%s-%s.tar.xz' % (ud.pkgname, ud.version)
-        ud.fullmirror = os.path.join(d.getVar("DL_DIR", True), ud.mirrortarball)
+        ud.fullmirror = os.path.join(d.getVar("DL_DIR"), ud.mirrortarball)
 
     def need_update(self, ud, d):
         if os.path.exists(ud.localpath):
@@ -102,7 +102,7 @@ class Npm(FetchMethod):
     def _runwget(self, ud, d, command, quiet):
         logger.debug(2, "Fetching %s using command '%s'" % (ud.url, command))
         bb.fetch2.check_network_access(d, command)
-        dldir = d.getVar("DL_DIR", True)
+        dldir = d.getVar("DL_DIR")
         runfetchcmd(command, d, quiet, workdir=dldir)
 
     def _unpackdep(self, ud, pkg, data, destdir, dldir, d):
@@ -116,7 +116,7 @@ class Npm(FetchMethod):
         # Change to subdir before executing command
         if not os.path.exists(destdir):
             os.makedirs(destdir)
-        path = d.getVar('PATH', True)
+        path = d.getVar('PATH')
         if path:
             cmd = "PATH=\"%s\" %s" % (path, cmd)
         bb.note("Unpacking %s to %s/" % (file, destdir))
@@ -132,7 +132,7 @@ class Npm(FetchMethod):
 
 
     def unpack(self, ud, destdir, d):
-        dldir = d.getVar("DL_DIR", True)
+        dldir = d.getVar("DL_DIR")
         depdumpfile = "%s-%s.deps.json" % (ud.pkgname, ud.version)
         with open("%s/npm/%s" % (dldir, depdumpfile)) as datafile:
             workobj = json.load(datafile)
@@ -251,12 +251,12 @@ class Npm(FetchMethod):
         lockdown = {}
 
         if not os.listdir(ud.pkgdatadir) and os.path.exists(ud.fullmirror):
-            dest = d.getVar("DL_DIR", True)
+            dest = d.getVar("DL_DIR")
             bb.utils.mkdirhier(dest)
             runfetchcmd("tar -xJf %s" % (ud.fullmirror), d, workdir=dest)
             return
 
-        shwrf = d.getVar('NPM_SHRINKWRAP', True)
+        shwrf = d.getVar('NPM_SHRINKWRAP')
         logger.debug(2, "NPM shrinkwrap file is %s" % shwrf)
         if shwrf:
             try:
@@ -266,7 +266,7 @@ class Npm(FetchMethod):
                 raise FetchError('Error loading NPM_SHRINKWRAP file "%s" for %s: %s' % (shwrf, ud.pkgname, str(e)))
         elif not ud.ignore_checksums:
             logger.warning('Missing shrinkwrap file in NPM_SHRINKWRAP for %s, this will lead to unreliable builds!' % ud.pkgname)
-        lckdf = d.getVar('NPM_LOCKDOWN', True)
+        lckdf = d.getVar('NPM_LOCKDOWN')
         logger.debug(2, "NPM lockdown file is %s" % lckdf)
         if lckdf:
             try:
@@ -292,7 +292,7 @@ class Npm(FetchMethod):
             if os.path.islink(ud.fullmirror):
                 os.unlink(ud.fullmirror)
 
-            dldir = d.getVar("DL_DIR", True)
+            dldir = d.getVar("DL_DIR")
             logger.info("Creating tarball of npm data")
             runfetchcmd("tar -cJf %s npm/%s npm/%s" % (ud.fullmirror, ud.bbnpmmanifest, ud.pkgname), d,
                         workdir=dldir)
diff --git a/lib/bb/fetch2/osc.py b/lib/bb/fetch2/osc.py
index 295abf9..26f88e1 100644
--- a/lib/bb/fetch2/osc.py
+++ b/lib/bb/fetch2/osc.py
@@ -34,7 +34,7 @@ class Osc(FetchMethod):
 
         # Create paths to osc checkouts
         relpath = self._strip_leading_slashes(ud.path)
-        ud.pkgdir = os.path.join(d.getVar('OSCDIR', True), ud.host)
+        ud.pkgdir = os.path.join(d.getVar('OSCDIR'), ud.host)
         ud.moddir = os.path.join(ud.pkgdir, relpath, ud.module)
 
         if 'rev' in ud.parm:
@@ -84,7 +84,7 @@ class Osc(FetchMethod):
 
         logger.debug(2, "Fetch: checking for module directory '" + ud.moddir + "'")
 
-        if os.access(os.path.join(d.getVar('OSCDIR', True), ud.path, ud.module), os.R_OK):
+        if os.access(os.path.join(d.getVar('OSCDIR'), ud.path, ud.module), os.R_OK):
             oscupdatecmd = self._buildosccommand(ud, d, "update")
             logger.info("Update "+ ud.url)
             # update sources there
@@ -112,7 +112,7 @@ class Osc(FetchMethod):
         Generate a .oscrc to be used for this run.
         """
 
-        config_path = os.path.join(d.getVar('OSCDIR', True), "oscrc")
+        config_path = os.path.join(d.getVar('OSCDIR'), "oscrc")
         if (os.path.exists(config_path)):
             os.remove(config_path)
 
@@ -121,8 +121,8 @@ class Osc(FetchMethod):
         f.write("apisrv = %s\n" % ud.host)
         f.write("scheme = http\n")
         f.write("su-wrapper = su -c\n")
-        f.write("build-root = %s\n" % d.getVar('WORKDIR', True))
-        f.write("urllist = %s\n" % d.getVar("OSCURLLIST", True))
+        f.write("build-root = %s\n" % d.getVar('WORKDIR'))
+        f.write("urllist = %s\n" % d.getVar("OSCURLLIST"))
         f.write("extra-pkgs = gzip\n")
         f.write("\n")
         f.write("[%s]\n" % ud.host)
diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
index 50cb479..be73ca0 100644
--- a/lib/bb/fetch2/perforce.py
+++ b/lib/bb/fetch2/perforce.py
@@ -44,13 +44,13 @@ class Perforce(FetchMethod):
         provided by the env, use it.  If P4PORT is specified by the recipe, use
         its values, which may override the settings in P4CONFIG.
         """
-        ud.basecmd = d.getVar('FETCHCMD_p4', True)
+        ud.basecmd = d.getVar('FETCHCMD_p4')
         if not ud.basecmd:
             ud.basecmd = "/usr/bin/env p4"
 
-        ud.dldir = d.getVar('P4DIR', True)
+        ud.dldir = d.getVar('P4DIR')
         if not ud.dldir:
-            ud.dldir = '%s/%s' % (d.getVar('DL_DIR', True), 'p4')
+            ud.dldir = '%s/%s' % (d.getVar('DL_DIR'), 'p4')
 
         path = ud.url.split('://')[1]
         path = path.split(';')[0]
@@ -62,7 +62,7 @@ class Perforce(FetchMethod):
             ud.path = path
 
         ud.usingp4config = False
-        p4port = d.getVar('P4PORT', True)
+        p4port = d.getVar('P4PORT')
 
         if p4port:
             logger.debug(1, 'Using recipe provided P4PORT: %s' % p4port)
diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
index bfd4ae1..24dcebb 100644
--- a/lib/bb/fetch2/repo.py
+++ b/lib/bb/fetch2/repo.py
@@ -56,12 +56,12 @@ class Repo(FetchMethod):
     def download(self, ud, d):
         """Fetch url"""
 
-        if os.access(os.path.join(d.getVar("DL_DIR", True), ud.localfile), os.R_OK):
+        if os.access(os.path.join(d.getVar("DL_DIR"), ud.localfile), os.R_OK):
             logger.debug(1, "%s already exists (or was stashed). Skipping repo init / sync.", ud.localpath)
             return
 
         gitsrcname = "%s%s" % (ud.host, ud.path.replace("/", "."))
-        repodir = d.getVar("REPODIR", True) or os.path.join(d.getVar("DL_DIR", True), "repo")
+        repodir = d.getVar("REPODIR") or os.path.join(d.getVar("DL_DIR"), "repo")
         codir = os.path.join(repodir, gitsrcname, ud.manifest)
 
         if ud.user:
diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch2/sftp.py
index 48ddfc1..da857dd 100644
--- a/lib/bb/fetch2/sftp.py
+++ b/lib/bb/fetch2/sftp.py
@@ -104,7 +104,7 @@ class SFTP(FetchMethod):
             port = '-P %d' % urlo.port
             urlo.port = None
 
-        dldir = d.getVar('DL_DIR', True)
+        dldir = d.getVar('DL_DIR')
         lpath = os.path.join(dldir, ud.localfile)
 
         user = ''
diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
index 56f9b7e..e668b0d 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch2/ssh.py
@@ -87,11 +87,11 @@ class SSH(FetchMethod):
         m = __pattern__.match(urldata.url)
         path = m.group('path')
         host = m.group('host')
-        urldata.localpath = os.path.join(d.getVar('DL_DIR', True),
+        urldata.localpath = os.path.join(d.getVar('DL_DIR'),
                 os.path.basename(os.path.normpath(path)))
 
     def download(self, urldata, d):
-        dldir = d.getVar('DL_DIR', True)
+        dldir = d.getVar('DL_DIR')
 
         m = __pattern__.match(urldata.url)
         path = m.group('path')
diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index 6ca79d3..b568c72 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -50,7 +50,7 @@ class Svn(FetchMethod):
         if not "module" in ud.parm:
             raise MissingParameterError('module', ud.url)
 
-        ud.basecmd = d.getVar('FETCHCMD_svn', True)
+        ud.basecmd = d.getVar('FETCHCMD_svn')
 
         ud.module = ud.parm["module"]
 
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index ecb946a..4ba63df 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -88,7 +88,7 @@ class Wget(FetchMethod):
         if not ud.localfile:
             ud.localfile = data.expand(urllib.parse.unquote(ud.host + ud.path).replace("/", "."), d)
 
-        self.basecmd = d.getVar("FETCHCMD_wget", True) or "/usr/bin/env wget -t 2 -T 30 --passive-ftp --no-check-certificate"
+        self.basecmd = d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -t 2 -T 30 --passive-ftp --no-check-certificate"
 
     def _runwget(self, ud, d, command, quiet):
 
@@ -104,7 +104,7 @@ class Wget(FetchMethod):
         fetchcmd = self.basecmd
 
         if 'downloadfilename' in ud.parm:
-            dldir = d.getVar("DL_DIR", True)
+            dldir = d.getVar("DL_DIR")
             bb.utils.mkdirhier(os.path.dirname(dldir + os.sep + ud.localfile))
             fetchcmd += " -O " + dldir + os.sep + ud.localfile
 
@@ -543,7 +543,7 @@ class Wget(FetchMethod):
         self.suffix_regex_comp = re.compile(psuffix_regex)
 
         # compile regex, can be specific by package or generic regex
-        pn_regex = d.getVar('UPSTREAM_CHECK_REGEX', True)
+        pn_regex = d.getVar('UPSTREAM_CHECK_REGEX')
         if pn_regex:
             package_custom_regex_comp = re.compile(pn_regex)
         else:
@@ -564,7 +564,7 @@ class Wget(FetchMethod):
         sanity check to ensure same name and type.
         """
         package = ud.path.split("/")[-1]
-        current_version = ['', d.getVar('PV', True), '']
+        current_version = ['', d.getVar('PV'), '']
 
         """possible to have no version in pkg name, such as spectrum-fw"""
         if not re.search("\d+", package):
@@ -579,7 +579,7 @@ class Wget(FetchMethod):
         bb.debug(3, "latest_versionstring, regex: %s" % (package_regex.pattern))
 
         uri = ""
-        regex_uri = d.getVar("UPSTREAM_CHECK_URI", True)
+        regex_uri = d.getVar("UPSTREAM_CHECK_URI")
         if not regex_uri:
             path = ud.path.split(package)[0]
 
@@ -588,7 +588,7 @@ class Wget(FetchMethod):
             dirver_regex = re.compile("(?P<dirver>[^/]*(\d+\.)*\d+([-_]r\d+)*)/")
             m = dirver_regex.search(path)
             if m:
-                pn = d.getVar('PN', True)
+                pn = d.getVar('PN')
                 dirver = m.group('dirver')
 
                 dirver_pn_regex = re.compile("%s\d?" % (re.escape(pn)))
diff --git a/lib/bb/monitordisk.py b/lib/bb/monitordisk.py
index 203c405..dff57ad 100644
--- a/lib/bb/monitordisk.py
+++ b/lib/bb/monitordisk.py
@@ -141,7 +141,7 @@ def getInterval(configuration):
     spaceDefault = 50 * 1024 * 1024
     inodeDefault = 5 * 1024
 
-    interval = configuration.getVar("BB_DISKMON_WARNINTERVAL", True)
+    interval = configuration.getVar("BB_DISKMON_WARNINTERVAL")
     if not interval:
         return spaceDefault, inodeDefault
     else:
@@ -179,7 +179,7 @@ class diskMonitor:
         self.enableMonitor = False
         self.configuration = configuration
 
-        BBDirs = configuration.getVar("BB_DISKMON_DIRS", True) or None
+        BBDirs = configuration.getVar("BB_DISKMON_DIRS") or None
         if BBDirs:
             self.devDict = getDiskData(BBDirs, configuration)
             if self.devDict:
diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index 26ae7ea..a2952ec 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
@@ -123,7 +123,7 @@ def init_parser(d):
 
 def resolve_file(fn, d):
     if not os.path.isabs(fn):
-        bbpath = d.getVar("BBPATH", True)
+        bbpath = d.getVar("BBPATH")
         newfn, attempts = bb.utils.which(bbpath, fn, history=True)
         for af in attempts:
             mark_dependency(d, af)
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index fa83b18..a3990e5 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -407,7 +407,7 @@ def _expand_versions(versions):
             versions = itertools.chain(newversions, versions)
 
 def multi_finalize(fn, d):
-    appends = (d.getVar("__BBAPPEND", True) or "").split()
+    appends = (d.getVar("__BBAPPEND") or "").split()
     for append in appends:
         logger.debug(1, "Appending .bbappend file %s to %s", append, fn)
         bb.parse.BBHandler.handle(append, d, True)
@@ -422,16 +422,16 @@ def multi_finalize(fn, d):
         d.setVar("__SKIPPED", e.args[0])
     datastores = {"": safe_d}
 
-    versions = (d.getVar("BBVERSIONS", True) or "").split()
+    versions = (d.getVar("BBVERSIONS") or "").split()
     if versions:
-        pv = orig_pv = d.getVar("PV", True)
+        pv = orig_pv = d.getVar("PV")
         baseversions = {}
 
         def verfunc(ver, d, pv_d = None):
             if pv_d is None:
                 pv_d = d
 
-            overrides = d.getVar("OVERRIDES", True).split(":")
+            overrides = d.getVar("OVERRIDES").split(":")
             pv_d.setVar("PV", ver)
             overrides.append(ver)
             bpv = baseversions.get(ver) or orig_pv
@@ -466,7 +466,7 @@ def multi_finalize(fn, d):
 
         _create_variants(datastores, versions, verfunc, onlyfinalise)
 
-    extended = d.getVar("BBCLASSEXTEND", True) or ""
+    extended = d.getVar("BBCLASSEXTEND") or ""
     if extended:
         # the following is to support bbextends with arguments, for e.g. multilib
         # an example is as follows:
@@ -484,7 +484,7 @@ def multi_finalize(fn, d):
             else:
                 extendedmap[ext] = ext
 
-        pn = d.getVar("PN", True)
+        pn = d.getVar("PN")
         def extendfunc(name, d):
             if name != extendedmap[name]:
                 d.setVar("BBEXTENDCURR", extendedmap[name])
diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index c54a079..f2a2151 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -66,7 +66,7 @@ def inherit(files, fn, lineno, d):
             file = os.path.join('classes', '%s.bbclass' % file)
 
         if not os.path.isabs(file):
-            bbpath = d.getVar("BBPATH", True)
+            bbpath = d.getVar("BBPATH")
             abs_fn, attempts = bb.utils.which(bbpath, file, history=True)
             for af in attempts:
                 if af != abs_fn:
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 875250d..5759cb2 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -83,16 +83,16 @@ def include(parentfn, fn, lineno, data, error_out):
 
     if not os.path.isabs(fn):
         dname = os.path.dirname(parentfn)
-        bbpath = "%s:%s" % (dname, data.getVar("BBPATH", True))
+        bbpath = "%s:%s" % (dname, data.getVar("BBPATH"))
         abs_fn, attempts = bb.utils.which(bbpath, fn, history=True)
         if abs_fn and bb.parse.check_dependency(data, abs_fn):
-            logger.warning("Duplicate inclusion for %s in %s" % (abs_fn, data.getVar('FILE', True)))
+            logger.warning("Duplicate inclusion for %s in %s" % (abs_fn, data.getVar('FILE')))
         for af in attempts:
             bb.parse.mark_dependency(data, af)
         if abs_fn:
             fn = abs_fn
     elif bb.parse.check_dependency(data, fn):
-        logger.warning("Duplicate inclusion for %s in %s" % (fn, data.getVar('FILE', True)))
+        logger.warning("Duplicate inclusion for %s in %s" % (fn, data.getVar('FILE')))
 
     try:
         bb.parse.handle(fn, data, True)
diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
index bb6deca..e6bbff8 100644
--- a/lib/bb/persist_data.py
+++ b/lib/bb/persist_data.py
@@ -207,8 +207,8 @@ def connect(database):
 def persist(domain, d):
     """Convenience factory for SQLTable objects based upon metadata"""
     import bb.utils
-    cachedir = (d.getVar("PERSISTENT_DIR", True) or
-                d.getVar("CACHE", True))
+    cachedir = (d.getVar("PERSISTENT_DIR") or
+                d.getVar("CACHE"))
     if not cachedir:
         logger.critical("Please set the 'PERSISTENT_DIR' or 'CACHE' variable")
         sys.exit(1)
diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index db02a0b..0e9c834 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -123,11 +123,11 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
 
     # pn can contain '_', e.g. gcc-cross-x86_64 and an override cannot
     # hence we do this manually rather than use OVERRIDES
-    preferred_v = cfgData.getVar("PREFERRED_VERSION_pn-%s" % pn, True)
+    preferred_v = cfgData.getVar("PREFERRED_VERSION_pn-%s" % pn)
     if not preferred_v:
-        preferred_v = cfgData.getVar("PREFERRED_VERSION_%s" % pn, True)
+        preferred_v = cfgData.getVar("PREFERRED_VERSION_%s" % pn)
     if not preferred_v:
-        preferred_v = cfgData.getVar("PREFERRED_VERSION", True)
+        preferred_v = cfgData.getVar("PREFERRED_VERSION")
 
     if preferred_v:
         m = re.match('(\d+:)*(.*)(_.*)*', preferred_v)
@@ -289,7 +289,7 @@ def filterProviders(providers, item, cfgData, dataCache):
 
     eligible = _filterProviders(providers, item, cfgData, dataCache)
 
-    prefervar = cfgData.getVar('PREFERRED_PROVIDER_%s' % item, True)
+    prefervar = cfgData.getVar('PREFERRED_PROVIDER_%s' % item)
     if prefervar:
         dataCache.preferred[item] = prefervar
 
@@ -318,7 +318,7 @@ def filterProvidersRunTime(providers, item, cfgData, dataCache):
     eligible = _filterProviders(providers, item, cfgData, dataCache)
 
     # First try and match any PREFERRED_RPROVIDER entry
-    prefervar = cfgData.getVar('PREFERRED_RPROVIDER_%s' % item, True)
+    prefervar = cfgData.getVar('PREFERRED_RPROVIDER_%s' % item)
     foundUnique = False
     if prefervar:
         for p in eligible:
@@ -345,7 +345,7 @@ def filterProvidersRunTime(providers, item, cfgData, dataCache):
             pn = dataCache.pkg_fn[p]
             provides = dataCache.pn_provides[pn]
             for provide in provides:
-                prefervar = cfgData.getVar('PREFERRED_PROVIDER_%s' % provide, True)
+                prefervar = cfgData.getVar('PREFERRED_PROVIDER_%s' % provide)
                 #logger.debug(1, "checking PREFERRED_PROVIDER_%s (value %s) against %s", provide, prefervar, pns.keys())
                 if prefervar in pns and pns[prefervar] not in preferred:
                     var = "PREFERRED_PROVIDER_%s = %s" % (provide, prefervar)
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 84b2685..51d68a5 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -262,8 +262,8 @@ class RunQueueData:
         self.rq = rq
         self.warn_multi_bb = False
 
-        self.stampwhitelist = cfgData.getVar("BB_STAMP_WHITELIST", True) or ""
-        self.multi_provider_whitelist = (cfgData.getVar("MULTI_PROVIDER_WHITELIST", True) or "").split()
+        self.stampwhitelist = cfgData.getVar("BB_STAMP_WHITELIST") or ""
+        self.multi_provider_whitelist = (cfgData.getVar("MULTI_PROVIDER_WHITELIST") or "").split()
         self.setscenewhitelist = get_setscene_enforce_whitelist(cfgData)
         self.setscenewhitelist_checked = False
         self.init_progress_reporter = bb.progress.DummyMultiStageProcessProgressReporter()
@@ -976,10 +976,10 @@ class RunQueue:
         self.cfgData = cfgData
         self.rqdata = RunQueueData(self, cooker, cfgData, dataCaches, taskData, targets)
 
-        self.stamppolicy = cfgData.getVar("BB_STAMP_POLICY", True) or "perfile"
-        self.hashvalidate = cfgData.getVar("BB_HASHCHECK_FUNCTION", True) or None
-        self.setsceneverify = cfgData.getVar("BB_SETSCENE_VERIFY_FUNCTION2", True) or None
-        self.depvalidate = cfgData.getVar("BB_SETSCENE_DEPVALID", True) or None
+        self.stamppolicy = cfgData.getVar("BB_STAMP_POLICY") or "perfile"
+        self.hashvalidate = cfgData.getVar("BB_HASHCHECK_FUNCTION") or None
+        self.setsceneverify = cfgData.getVar("BB_SETSCENE_VERIFY_FUNCTION2") or None
+        self.depvalidate = cfgData.getVar("BB_SETSCENE_DEPVALID") or None
 
         self.state = runQueuePrepare
 
@@ -997,8 +997,8 @@ class RunQueue:
             magic = "decafbadbad"
         if fakeroot:
             magic = magic + "beef"
-            fakerootcmd = self.cfgData.getVar("FAKEROOTCMD", True)
-            fakerootenv = (self.cfgData.getVar("FAKEROOTBASEENV", True) or "").split()
+            fakerootcmd = self.cfgData.getVar("FAKEROOTCMD")
+            fakerootenv = (self.cfgData.getVar("FAKEROOTBASEENV") or "").split()
             env = os.environ.copy()
             for key, value in (var.split('=') for var in fakerootenv):
                 env[key] = value
@@ -1024,9 +1024,9 @@ class RunQueue:
             "logdefaultverboselogs" : bb.msg.loggerVerboseLogs,
             "logdefaultdomain" : bb.msg.loggerDefaultDomains,
             "prhost" : self.cooker.prhost,
-            "buildname" : self.cfgData.getVar("BUILDNAME", True),
-            "date" : self.cfgData.getVar("DATE", True),
-            "time" : self.cfgData.getVar("TIME", True),
+            "buildname" : self.cfgData.getVar("BUILDNAME"),
+            "date" : self.cfgData.getVar("DATE"),
+            "time" : self.cfgData.getVar("TIME"),
         }
 
         worker.stdin.write(b"<cookerconfig>" + pickle.dumps(self.cooker.configuration) + b"</cookerconfig>")
@@ -1427,8 +1427,8 @@ class RunQueueExecute:
         self.cfgData = rq.cfgData
         self.rqdata = rq.rqdata
 
-        self.number_tasks = int(self.cfgData.getVar("BB_NUMBER_THREADS", True) or 1)
-        self.scheduler = self.cfgData.getVar("BB_SCHEDULER", True) or "speed"
+        self.number_tasks = int(self.cfgData.getVar("BB_NUMBER_THREADS") or 1)
+        self.scheduler = self.cfgData.getVar("BB_SCHEDULER") or "speed"
 
         self.runq_buildable = set()
         self.runq_running = set()
@@ -1630,7 +1630,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                              if type(obj) is type and
                                 issubclass(obj, RunQueueScheduler))
 
-        user_schedulers = self.cfgData.getVar("BB_SCHEDULERS", True)
+        user_schedulers = self.cfgData.getVar("BB_SCHEDULERS")
         if user_schedulers:
             for sched in user_schedulers.split():
                 if not "." in sched:
@@ -2402,9 +2402,9 @@ class runQueuePipe():
         self.input.close()
 
 def get_setscene_enforce_whitelist(d):
-    if d.getVar('BB_SETSCENE_ENFORCE', True) != '1':
+    if d.getVar('BB_SETSCENE_ENFORCE') != '1':
         return None
-    whitelist = (d.getVar("BB_SETSCENE_ENFORCE_WHITELIST", True) or "").split()
+    whitelist = (d.getVar("BB_SETSCENE_ENFORCE_WHITELIST") or "").split()
     outlist = []
     for item in whitelist[:]:
         if item.startswith('%:'):
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index c1685a9..fa8a6b1 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -13,7 +13,7 @@ def init(d):
     siggens = [obj for obj in globals().values()
                       if type(obj) is type and issubclass(obj, SignatureGenerator)]
 
-    desired = d.getVar("BB_SIGNATURE_HANDLER", True) or "noop"
+    desired = d.getVar("BB_SIGNATURE_HANDLER") or "noop"
     for sg in siggens:
         if desired == sg.name:
             return sg(d)
@@ -82,10 +82,10 @@ class SignatureGeneratorBasic(SignatureGenerator):
         self.gendeps = {}
         self.lookupcache = {}
         self.pkgnameextract = re.compile("(?P<fn>.*)\..*")
-        self.basewhitelist = set((data.getVar("BB_HASHBASE_WHITELIST", True) or "").split())
+        self.basewhitelist = set((data.getVar("BB_HASHBASE_WHITELIST") or "").split())
         self.taskwhitelist = None
         self.init_rundepcheck(data)
-        checksum_cache_file = data.getVar("BB_HASH_CHECKSUM_CACHE_FILE", True)
+        checksum_cache_file = data.getVar("BB_HASH_CHECKSUM_CACHE_FILE")
         if checksum_cache_file:
             self.checksum_cache = FileChecksumCache()
             self.checksum_cache.init_cache(data, checksum_cache_file)
@@ -93,7 +93,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             self.checksum_cache = None
 
     def init_rundepcheck(self, data):
-        self.taskwhitelist = data.getVar("BB_HASHTASK_WHITELIST", True) or None
+        self.taskwhitelist = data.getVar("BB_HASHTASK_WHITELIST") or None
         if self.taskwhitelist:
             self.twl = re.compile(self.taskwhitelist)
         else:
@@ -160,7 +160,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         #Slow but can be useful for debugging mismatched basehashes
         #for task in self.taskdeps[fn]:
-        #    self.dump_sigtask(fn, task, d.getVar("STAMP", True), False)
+        #    self.dump_sigtask(fn, task, d.getVar("STAMP"), False)
 
         for task in taskdeps:
             d.setVar("BB_BASEHASH_task-%s" % task, self.basehash[fn + "." + task])
@@ -345,8 +345,8 @@ class SignatureGeneratorBasicHash(SignatureGeneratorBasic):
 
 def dump_this_task(outfile, d):
     import bb.parse
-    fn = d.getVar("BB_FILENAME", True)
-    task = "do_" + d.getVar("BB_CURRENTTASK", True)
+    fn = d.getVar("BB_FILENAME")
+    task = "do_" + d.getVar("BB_CURRENTTASK")
     referencestamp = bb.build.stamp_internal(task, d, None, True)
     bb.parse.siggen.dump_sigtask(fn, task, outfile, "customfile:" + referencestamp)
 
diff --git a/lib/bb/tests/codeparser.py b/lib/bb/tests/codeparser.py
index b80c315..a681841 100644
--- a/lib/bb/tests/codeparser.py
+++ b/lib/bb/tests/codeparser.py
@@ -68,7 +68,7 @@ class VariableReferenceTest(ReferenceTest):
 
     def test_python_reference(self):
         self.setEmptyVars(["BAR"])
-        self.parseExpression("${@d.getVar('BAR', True) + 'foo'}")
+        self.parseExpression("${@d.getVar('BAR') + 'foo'}")
         self.assertReferences(set(["BAR"]))
 
 class ShellReferenceTest(ReferenceTest):
@@ -209,17 +209,17 @@ be. These unit tests are testing snippets."""
         return " " + value
 
     def test_getvar_reference(self):
-        self.parseExpression("d.getVar('foo', True)")
+        self.parseExpression("d.getVar('foo')")
         self.assertReferences(set(["foo"]))
         self.assertExecs(set())
 
     def test_getvar_computed_reference(self):
-        self.parseExpression("d.getVar('f' + 'o' + 'o', True)")
+        self.parseExpression("d.getVar('f' + 'o' + 'o')")
         self.assertReferences(set())
         self.assertExecs(set())
 
     def test_getvar_exec_reference(self):
-        self.parseExpression("eval('d.getVar(\"foo\", True)')")
+        self.parseExpression("eval('d.getVar(\"foo\")')")
         self.assertReferences(set())
         self.assertExecs(set(["eval"]))
 
@@ -269,11 +269,11 @@ be. These unit tests are testing snippets."""
 class DependencyReferenceTest(ReferenceTest):
 
     pydata = """
-d.getVar('somevar', True)
+d.getVar('somevar')
 def test(d):
     foo = 'bar %s' % 'foo'
 def test2(d):
-    d.getVar(foo, True)
+    d.getVar(foo)
     d.getVar('bar', False)
     test2(d)
 
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index b54eb06..1a5a28a 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -77,13 +77,13 @@ class DataExpansions(unittest.TestCase):
         self.assertEqual(str(val), "boo value_of_foo")
 
     def test_python_snippet_getvar(self):
-        val = self.d.expand("${@d.getVar('foo', True) + ' ${bar}'}")
+        val = self.d.expand("${@d.getVar('foo') + ' ${bar}'}")
         self.assertEqual(str(val), "value_of_foo value_of_bar")
 
     def test_python_unexpanded(self):
         self.d.setVar("bar", "${unsetvar}")
-        val = self.d.expand("${@d.getVar('foo', True) + ' ${bar}'}")
-        self.assertEqual(str(val), "${@d.getVar('foo', True) + ' ${unsetvar}'}")
+        val = self.d.expand("${@d.getVar('foo') + ' ${bar}'}")
+        self.assertEqual(str(val), "${@d.getVar('foo') + ' ${unsetvar}'}")
 
     def test_python_snippet_syntax_error(self):
         self.d.setVar("FOO", "${@foo = 5}")
@@ -99,7 +99,7 @@ class DataExpansions(unittest.TestCase):
         self.assertRaises(bb.data_smart.ExpansionError, self.d.getVar, "FOO", True)
 
     def test_value_containing_value(self):
-        val = self.d.expand("${@d.getVar('foo', True) + ' ${bar}'}")
+        val = self.d.expand("${@d.getVar('foo') + ' ${bar}'}")
         self.assertEqual(str(val), "value_of_foo value_of_bar")
 
     def test_reference_undefined_var(self):
@@ -109,7 +109,7 @@ class DataExpansions(unittest.TestCase):
     def test_double_reference(self):
         self.d.setVar("BAR", "bar value")
         self.d.setVar("FOO", "${BAR} foo ${BAR}")
-        val = self.d.getVar("FOO", True)
+        val = self.d.getVar("FOO")
         self.assertEqual(str(val), "bar value foo bar value")
 
     def test_direct_recursion(self):
@@ -129,12 +129,12 @@ class DataExpansions(unittest.TestCase):
 
     def test_incomplete_varexp_single_quotes(self):
         self.d.setVar("FOO", "sed -i -e 's:IP{:I${:g' $pc")
-        val = self.d.getVar("FOO", True)
+        val = self.d.getVar("FOO")
         self.assertEqual(str(val), "sed -i -e 's:IP{:I${:g' $pc")
 
     def test_nonstring(self):
         self.d.setVar("TEST", 5)
-        val = self.d.getVar("TEST", True)
+        val = self.d.getVar("TEST")
         self.assertEqual(str(val), "5")
 
     def test_rename(self):
@@ -234,19 +234,19 @@ class TestConcat(unittest.TestCase):
     def test_prepend(self):
         self.d.setVar("TEST", "${VAL}")
         self.d.prependVar("TEST", "${FOO}:")
-        self.assertEqual(self.d.getVar("TEST", True), "foo:val")
+        self.assertEqual(self.d.getVar("TEST"), "foo:val")
 
     def test_append(self):
         self.d.setVar("TEST", "${VAL}")
         self.d.appendVar("TEST", ":${BAR}")
-        self.assertEqual(self.d.getVar("TEST", True), "val:bar")
+        self.assertEqual(self.d.getVar("TEST"), "val:bar")
 
     def test_multiple_append(self):
         self.d.setVar("TEST", "${VAL}")
         self.d.prependVar("TEST", "${FOO}:")
         self.d.appendVar("TEST", ":val2")
         self.d.appendVar("TEST", ":${BAR}")
-        self.assertEqual(self.d.getVar("TEST", True), "foo:val:val2:bar")
+        self.assertEqual(self.d.getVar("TEST"), "foo:val:val2:bar")
 
 class TestConcatOverride(unittest.TestCase):
     def setUp(self):
@@ -259,13 +259,13 @@ class TestConcatOverride(unittest.TestCase):
         self.d.setVar("TEST", "${VAL}")
         self.d.setVar("TEST_prepend", "${FOO}:")
         bb.data.update_data(self.d)
-        self.assertEqual(self.d.getVar("TEST", True), "foo:val")
+        self.assertEqual(self.d.getVar("TEST"), "foo:val")
 
     def test_append(self):
         self.d.setVar("TEST", "${VAL}")
         self.d.setVar("TEST_append", ":${BAR}")
         bb.data.update_data(self.d)
-        self.assertEqual(self.d.getVar("TEST", True), "val:bar")
+        self.assertEqual(self.d.getVar("TEST"), "val:bar")
 
     def test_multiple_append(self):
         self.d.setVar("TEST", "${VAL}")
@@ -273,47 +273,47 @@ class TestConcatOverride(unittest.TestCase):
         self.d.setVar("TEST_append", ":val2")
         self.d.setVar("TEST_append", ":${BAR}")
         bb.data.update_data(self.d)
-        self.assertEqual(self.d.getVar("TEST", True), "foo:val:val2:bar")
+        self.assertEqual(self.d.getVar("TEST"), "foo:val:val2:bar")
 
     def test_append_unset(self):
         self.d.setVar("TEST_prepend", "${FOO}:")
         self.d.setVar("TEST_append", ":val2")
         self.d.setVar("TEST_append", ":${BAR}")
         bb.data.update_data(self.d)
-        self.assertEqual(self.d.getVar("TEST", True), "foo::val2:bar")
+        self.assertEqual(self.d.getVar("TEST"), "foo::val2:bar")
 
     def test_remove(self):
         self.d.setVar("TEST", "${VAL} ${BAR}")
         self.d.setVar("TEST_remove", "val")
         bb.data.update_data(self.d)
-        self.assertEqual(self.d.getVar("TEST", True), "bar")
+        self.assertEqual(self.d.getVar("TEST"), "bar")
 
     def test_doubleref_remove(self):
         self.d.setVar("TEST", "${VAL} ${BAR}")
         self.d.setVar("TEST_remove", "val")
         self.d.setVar("TEST_TEST", "${TEST} ${TEST}")
         bb.data.update_data(self.d)
-        self.assertEqual(self.d.getVar("TEST_TEST", True), "bar bar")
+        self.assertEqual(self.d.getVar("TEST_TEST"), "bar bar")
 
     def test_empty_remove(self):
         self.d.setVar("TEST", "")
         self.d.setVar("TEST_remove", "val")
         bb.data.update_data(self.d)
-        self.assertEqual(self.d.getVar("TEST", True), "")
+        self.assertEqual(self.d.getVar("TEST"), "")
 
     def test_remove_expansion(self):
         self.d.setVar("BAR", "Z")
         self.d.setVar("TEST", "${BAR}/X Y")
         self.d.setVar("TEST_remove", "${BAR}/X")
         bb.data.update_data(self.d)
-        self.assertEqual(self.d.getVar("TEST", True), "Y")
+        self.assertEqual(self.d.getVar("TEST"), "Y")
 
     def test_remove_expansion_items(self):
         self.d.setVar("TEST", "A B C D")
         self.d.setVar("BAR", "B D")
         self.d.setVar("TEST_remove", "${BAR}")
         bb.data.update_data(self.d)
-        self.assertEqual(self.d.getVar("TEST", True), "A C")
+        self.assertEqual(self.d.getVar("TEST"), "A C")
 
 class TestOverrides(unittest.TestCase):
     def setUp(self):
@@ -323,17 +323,17 @@ class TestOverrides(unittest.TestCase):
 
     def test_no_override(self):
         bb.data.update_data(self.d)
-        self.assertEqual(self.d.getVar("TEST", True), "testvalue")
+        self.assertEqual(self.d.getVar("TEST"), "testvalue")
 
     def test_one_override(self):
         self.d.setVar("TEST_bar", "testvalue2")
         bb.data.update_data(self.d)
-        self.assertEqual(self.d.getVar("TEST", True), "testvalue2")
+        self.assertEqual(self.d.getVar("TEST"), "testvalue2")
 
     def test_one_override_unset(self):
         self.d.setVar("TEST2_bar", "testvalue2")
         bb.data.update_data(self.d)
-        self.assertEqual(self.d.getVar("TEST2", True), "testvalue2")
+        self.assertEqual(self.d.getVar("TEST2"), "testvalue2")
         self.assertCountEqual(list(self.d.keys()), ['TEST', 'TEST2', 'OVERRIDES', 'TEST2_bar'])
 
     def test_multiple_override(self):
@@ -341,18 +341,18 @@ class TestOverrides(unittest.TestCase):
         self.d.setVar("TEST_local", "testvalue3")
         self.d.setVar("TEST_foo", "testvalue4")
         bb.data.update_data(self.d)
-        self.assertEqual(self.d.getVar("TEST", True), "testvalue3")
+        self.assertEqual(self.d.getVar("TEST"), "testvalue3")
         self.assertCountEqual(list(self.d.keys()), ['TEST', 'TEST_foo', 'OVERRIDES', 'TEST_bar', 'TEST_local'])
 
     def test_multiple_combined_overrides(self):
         self.d.setVar("TEST_local_foo_bar", "testvalue3")
         bb.data.update_data(self.d)
-        self.assertEqual(self.d.getVar("TEST", True), "testvalue3")
+        self.assertEqual(self.d.getVar("TEST"), "testvalue3")
 
     def test_multiple_overrides_unset(self):
         self.d.setVar("TEST2_local_foo_bar", "testvalue3")
         bb.data.update_data(self.d)
-        self.assertEqual(self.d.getVar("TEST2", True), "testvalue3")
+        self.assertEqual(self.d.getVar("TEST2"), "testvalue3")
 
     def test_keyexpansion_override(self):
         self.d.setVar("LOCAL", "local")
@@ -361,21 +361,21 @@ class TestOverrides(unittest.TestCase):
         self.d.setVar("TEST_foo", "testvalue4")
         bb.data.update_data(self.d)
         bb.data.expandKeys(self.d)
-        self.assertEqual(self.d.getVar("TEST", True), "testvalue3")
+        self.assertEqual(self.d.getVar("TEST"), "testvalue3")
 
     def test_rename_override(self):
         self.d.setVar("ALTERNATIVE_ncurses-tools_class-target", "a")
         self.d.setVar("OVERRIDES", "class-target")
         bb.data.update_data(self.d)
         self.d.renameVar("ALTERNATIVE_ncurses-tools", "ALTERNATIVE_lib32-ncurses-tools")
-        self.assertEqual(self.d.getVar("ALTERNATIVE_lib32-ncurses-tools", True), "a")
+        self.assertEqual(self.d.getVar("ALTERNATIVE_lib32-ncurses-tools"), "a")
 
     def test_underscore_override(self):
         self.d.setVar("TEST_bar", "testvalue2")
         self.d.setVar("TEST_some_val", "testvalue3")
         self.d.setVar("TEST_foo", "testvalue4")
         self.d.setVar("OVERRIDES", "foo:bar:some_val")
-        self.assertEqual(self.d.getVar("TEST", True), "testvalue3")
+        self.assertEqual(self.d.getVar("TEST"), "testvalue3")
 
 class TestKeyExpansion(unittest.TestCase):
     def setUp(self):
@@ -389,7 +389,7 @@ class TestKeyExpansion(unittest.TestCase):
         with LogRecord() as logs:
             bb.data.expandKeys(self.d)
             self.assertTrue(logContains("Variable key VAL_${FOO} (A) replaces original key VAL_foo (B)", logs))
-        self.assertEqual(self.d.getVar("VAL_foo", True), "A")
+        self.assertEqual(self.d.getVar("VAL_foo"), "A")
 
 class TestFlags(unittest.TestCase):
     def setUp(self):
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 0b2706a..86e86ed 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -58,9 +58,9 @@ C = "3"
     def test_parse_simple(self):
         f = self.parsehelper(self.testfile)
         d = bb.parse.handle(f.name, self.d)['']
-        self.assertEqual(d.getVar("A", True), "1")
-        self.assertEqual(d.getVar("B", True), "2")
-        self.assertEqual(d.getVar("C", True), "3")
+        self.assertEqual(d.getVar("A"), "1")
+        self.assertEqual(d.getVar("B"), "2")
+        self.assertEqual(d.getVar("C"), "3")
 
     def test_parse_incomplete_function(self):
         testfileB = self.testfile.replace("}", "")
@@ -80,9 +80,9 @@ unset B[flag]
     def test_parse_unset(self):
         f = self.parsehelper(self.unsettest)
         d = bb.parse.handle(f.name, self.d)['']
-        self.assertEqual(d.getVar("A", True), None)
+        self.assertEqual(d.getVar("A"), None)
         self.assertEqual(d.getVarFlag("A","flag", True), None)
-        self.assertEqual(d.getVar("B", True), "2")
+        self.assertEqual(d.getVar("B"), "2")
         
 
     overridetest = """
@@ -95,11 +95,11 @@ PN = "gtk+"
     def test_parse_overrides(self):
         f = self.parsehelper(self.overridetest)
         d = bb.parse.handle(f.name, self.d)['']
-        self.assertEqual(d.getVar("RRECOMMENDS", True), "b")
+        self.assertEqual(d.getVar("RRECOMMENDS"), "b")
         bb.data.expandKeys(d)
-        self.assertEqual(d.getVar("RRECOMMENDS", True), "b")
+        self.assertEqual(d.getVar("RRECOMMENDS"), "b")
         d.setVar("RRECOMMENDS_gtk+", "c")
-        self.assertEqual(d.getVar("RRECOMMENDS", True), "c")
+        self.assertEqual(d.getVar("RRECOMMENDS"), "c")
 
     overridetest2 = """
 EXTRA_OECONF = ""
@@ -112,7 +112,7 @@ EXTRA_OECONF_append = " c"
         d = bb.parse.handle(f.name, self.d)['']
         d.appendVar("EXTRA_OECONF", " d")
         d.setVar("OVERRIDES", "class-target")
-        self.assertEqual(d.getVar("EXTRA_OECONF", True), "b c d")
+        self.assertEqual(d.getVar("EXTRA_OECONF"), "b c d")
 
     overridetest3 = """
 DESCRIPTION = "A"
@@ -124,11 +124,11 @@ PN = "bc"
         f = self.parsehelper(self.overridetest3)
         d = bb.parse.handle(f.name, self.d)['']
         bb.data.expandKeys(d)
-        self.assertEqual(d.getVar("DESCRIPTION_bc-dev", True), "A B")
+        self.assertEqual(d.getVar("DESCRIPTION_bc-dev"), "A B")
         d.setVar("DESCRIPTION", "E")
         d.setVar("DESCRIPTION_bc-dev", "C D")
         d.setVar("OVERRIDES", "bc-dev")
-        self.assertEqual(d.getVar("DESCRIPTION", True), "C D")
+        self.assertEqual(d.getVar("DESCRIPTION"), "C D")
 
 
     classextend = """
@@ -159,6 +159,6 @@ python () {
         alldata = bb.parse.handle(f.name, self.d)
         d1 = alldata['']
         d2 = alldata[cls.name]
-        self.assertEqual(d1.getVar("VAR_var", True), "B")
-        self.assertEqual(d2.getVar("VAR_var", True), None)
+        self.assertEqual(d1.getVar("VAR_var"), "B")
+        self.assertEqual(d2.getVar("VAR_var"), None)
 
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 729848a..c4b25b5 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -665,7 +665,7 @@ def build_environment(d):
     for var in bb.data.keys(d):
         export = d.getVarFlag(var, "export", False)
         if export:
-            os.environ[var] = d.getVar(var, True) or ""
+            os.environ[var] = d.getVar(var) or ""
 
 def _check_unsafe_delete_path(path):
     """
@@ -953,7 +953,7 @@ def contains(variable, checkvalues, truevalue, falsevalue, d):
     Arguments:
 
     variable -- the variable name. This will be fetched and expanded (using
-    d.getVar(variable, True)) and then split into a set().
+    d.getVar(variable)) and then split into a set().
 
     checkvalues -- if this is a string it is split on whitespace into a set(),
     otherwise coerced directly into a set().
@@ -966,7 +966,7 @@ def contains(variable, checkvalues, truevalue, falsevalue, d):
     d -- the data store.
     """
 
-    val = d.getVar(variable, True)
+    val = d.getVar(variable)
     if not val:
         return falsevalue
     val = set(val.split())
@@ -979,7 +979,7 @@ def contains(variable, checkvalues, truevalue, falsevalue, d):
     return falsevalue
 
 def contains_any(variable, checkvalues, truevalue, falsevalue, d):
-    val = d.getVar(variable, True)
+    val = d.getVar(variable)
     if not val:
         return falsevalue
     val = set(val.split())
@@ -1378,10 +1378,10 @@ def edit_bblayers_conf(bblayers_conf, add, remove):
 
 def get_file_layer(filename, d):
     """Determine the collection (as defined by a layer's layer.conf file) containing the specified file"""
-    collections = (d.getVar('BBFILE_COLLECTIONS', True) or '').split()
+    collections = (d.getVar('BBFILE_COLLECTIONS') or '').split()
     collection_res = {}
     for collection in collections:
-        collection_res[collection] = d.getVar('BBFILE_PATTERN_%s' % collection, True) or ''
+        collection_res[collection] = d.getVar('BBFILE_PATTERN_%s' % collection) or ''
 
     def path_to_layer(path):
         # Use longest path so we handle nested layers
@@ -1394,7 +1394,7 @@ def get_file_layer(filename, d):
         return match
 
     result = None
-    bbfiles = (d.getVar('BBFILES', True) or '').split()
+    bbfiles = (d.getVar('BBFILES') or '').split()
     bbfilesmatch = False
     for bbfilesentry in bbfiles:
         if fnmatch.fnmatch(filename, bbfilesentry):
@@ -1471,7 +1471,7 @@ def export_proxies(d):
         if v in os.environ.keys():
             exported = True
         else:
-            v_proxy = d.getVar(v, True)
+            v_proxy = d.getVar(v)
             if v_proxy is not None:
                 os.environ[v] = v_proxy
                 exported = True
diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
index 739ae27..cf94704 100644
--- a/lib/bblayers/action.py
+++ b/lib/bblayers/action.py
@@ -180,7 +180,7 @@ build results (as the layer priority order has effectively changed).
 
         if first_regex:
             # Find the BBFILES entries that match (which will have come from this conf/layer.conf file)
-            bbfiles = str(self.tinfoil.config_data.getVar('BBFILES', True)).split()
+            bbfiles = str(self.tinfoil.config_data.getVar('BBFILES')).split()
             bbfiles_layer = []
             for item in bbfiles:
                 if first_regex.match(item):
diff --git a/lib/bblayers/common.py b/lib/bblayers/common.py
index b10fb4c..98515ce 100644
--- a/lib/bblayers/common.py
+++ b/lib/bblayers/common.py
@@ -12,7 +12,7 @@ class LayerPlugin():
 
     def tinfoil_init(self, tinfoil):
         self.tinfoil = tinfoil
-        self.bblayers = (self.tinfoil.config_data.getVar('BBLAYERS', True) or "").split()
+        self.bblayers = (self.tinfoil.config_data.getVar('BBLAYERS') or "").split()
         layerconfs = self.tinfoil.config_data.varhistory.get_variable_items_files('BBFILE_COLLECTIONS', self.tinfoil.config_data)
         self.bbfile_collections = {layer: os.path.dirname(os.path.dirname(path)) for layer, path in layerconfs.items()}
 
diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 10ad718..013e952 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -151,7 +151,7 @@ class LayerIndexPlugin(ActionPlugin):
     def do_layerindex_fetch(self, args):
         """Fetches a layer from a layer index along with its dependent layers, and adds them to conf/bblayers.conf.
 """
-        apiurl = self.tinfoil.config_data.getVar('BBLAYERS_LAYERINDEX_URL', True)
+        apiurl = self.tinfoil.config_data.getVar('BBLAYERS_LAYERINDEX_URL')
         if not apiurl:
             logger.error("Cannot get BBLAYERS_LAYERINDEX_URL")
             return 1
@@ -173,8 +173,8 @@ class LayerIndexPlugin(ActionPlugin):
             return 1
 
         ignore_layers = []
-        for collection in self.tinfoil.config_data.getVar('BBFILE_COLLECTIONS', True).split():
-            lname = self.tinfoil.config_data.getVar('BBLAYERS_LAYERINDEX_NAME_%s' % collection, True)
+        for collection in self.tinfoil.config_data.getVar('BBFILE_COLLECTIONS').split():
+            lname = self.tinfoil.config_data.getVar('BBLAYERS_LAYERINDEX_NAME_%s' % collection)
             if lname:
                 ignore_layers.append(lname)
 
@@ -225,7 +225,7 @@ class LayerIndexPlugin(ActionPlugin):
             printedlayers.append(dependency)
 
         if repourls:
-            fetchdir = self.tinfoil.config_data.getVar('BBLAYERS_FETCH_DIR', True)
+            fetchdir = self.tinfoil.config_data.getVar('BBLAYERS_FETCH_DIR')
             if not fetchdir:
                 logger.error("Cannot get BBLAYERS_FETCH_DIR")
                 return 1
diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
index ee1e7c8..2949116 100644
--- a/lib/bblayers/query.py
+++ b/lib/bblayers/query.py
@@ -62,7 +62,7 @@ are overlayed will also be listed, with a " (skipped)" suffix.
         # factor - however, each layer.conf is free to either prepend or append to
         # BBPATH (or indeed do crazy stuff with it). Thus the order in BBPATH might
         # not be exactly the order present in bblayers.conf either.
-        bbpath = str(self.tinfoil.config_data.getVar('BBPATH', True))
+        bbpath = str(self.tinfoil.config_data.getVar('BBPATH'))
         overlayed_class_found = False
         for (classfile, classdirs) in classes.items():
             if len(classdirs) > 1:
@@ -114,7 +114,7 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
 
     def list_recipes(self, title, pnspec, show_overlayed_only, show_same_ver_only, show_filenames, show_multi_provider_only, inherits):
         if inherits:
-            bbpath = str(self.tinfoil.config_data.getVar('BBPATH', True))
+            bbpath = str(self.tinfoil.config_data.getVar('BBPATH'))
             for classname in inherits:
                 classfile = 'classes/%s.bbclass' % classname
                 if not bb.utils.which(bbpath, classfile, history=False):
@@ -158,7 +158,7 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
                     logger.plain("%s:", pn)
                 logger.plain("  %s %s%s", layer.ljust(20), ver, skipped)
 
-        global_inherit = (self.tinfoil.config_data.getVar('INHERIT', True) or "").split()
+        global_inherit = (self.tinfoil.config_data.getVar('INHERIT') or "").split()
         cls_re = re.compile('classes/')
 
         preffiles = []
@@ -319,12 +319,12 @@ NOTE: .bbappend files can impact the dependencies.
         ignore_layers = (args.ignore or '').split(',')
 
         pkg_fn = self.tinfoil.cooker_data.pkg_fn
-        bbpath = str(self.tinfoil.config_data.getVar('BBPATH', True))
+        bbpath = str(self.tinfoil.config_data.getVar('BBPATH'))
         self.require_re = re.compile(r"require\s+(.+)")
         self.include_re = re.compile(r"include\s+(.+)")
         self.inherit_re = re.compile(r"inherit\s+(.+)")
 
-        global_inherit = (self.tinfoil.config_data.getVar('INHERIT', True) or "").split()
+        global_inherit = (self.tinfoil.config_data.getVar('INHERIT') or "").split()
 
         # The bb's DEPENDS and RDEPENDS
         for f in pkg_fn:
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index cafcc82..350b085 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -420,7 +420,7 @@ class PRServiceConfigError(Exception):
 def auto_start(d):
     global singleton
 
-    host_params = list(filter(None, (d.getVar('PRSERV_HOST', True) or '').split(':')))
+    host_params = list(filter(None, (d.getVar('PRSERV_HOST') or '').split(':')))
     if not host_params:
         return None
 
@@ -431,7 +431,7 @@ def auto_start(d):
 
     if is_local_special(host_params[0], int(host_params[1])) and not singleton:
         import bb.utils
-        cachedir = (d.getVar("PERSISTENT_DIR", True) or d.getVar("CACHE", True))
+        cachedir = (d.getVar("PERSISTENT_DIR") or d.getVar("CACHE"))
         if not cachedir:
             logger.critical("Please set the 'PERSISTENT_DIR' or 'CACHE' variable")
             raise PRServiceConfigError
-- 
2.7.4


