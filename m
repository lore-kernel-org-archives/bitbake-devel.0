Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 37AB973216
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Aug 2016 16:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7GGklY5031451 for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Aug 2016 17:47:09 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ryRxXwbjgLq4 for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Aug 2016 17:47:09 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7GGl65W031455
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Aug 2016 17:47:08 +0100
Message-ID: <1471366026.20391.117.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 16 Aug 2016 17:47:06 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
X-Mailman-Approved-At: Tue, 16 Aug 2016 17:04:54 +0000
Subject: [PATCH] bitbake: Initial multi-config support
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
X-List-Received-Date: Tue, 16 Aug 2016 16:47:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This patch adds the notion of supporting multiple configurations within
a single build. To enable it, set a line in local.conf like:

BBMULTICONFIG = "configA configB configC"

This would tell bitbake that before it parses the base configuration,
it should load conf/configA.conf and so on for each different
configuration. These would contain lines like:

MACHINE = "A"

or other variables which can be set which can be built in the same
build directory (or change TMPDIR not to conflict).

One downside I've already discovered is that if we want to inherit this
file right at the start of parsing, the only place you can put the
configurations is in "cwd", since BBPATH isn't constructed until the
layers are parsed and therefore using it as a preconf file isn't
possible unless its located there.

Execution of these targets takes the form "bitbake
multiconfig:configA:core-image-minimal core-image-sato" so similar to
our virtclass approach for native/nativesdk/multilib using BBCLASSEXTEND.

Implementation wise, the implication is that instead of tasks being
uniquely referenced with "recipename/fn:task" it now needs to be
"configuration:recipename:task".

We already started using "virtual" filenames for recipes when we
implemented BBCLASSEXTEND and this patch adds a new prefix to
these, "multiconfig:<configname>:" and hence avoid changes to a large
part of the codebase thanks to this. databuilder has an internal array
of data stores and uses the right one depending on the supplied virtual
filename.

That trick allows us to use the existing parsing code including the
multithreading mostly unchanged as well as most of the cache code.

For recipecache, we end up with a dict of these accessed by
multiconfig (mc). taskdata and runqueue can only cope with one recipecache
so for taskdata, we pass in each recipecache and have it compute the result
and end up with an array of taskdatas. We can only have one runqueue so there
extensive changes there.

This initial implementation has some drawbacks:

a) There are no inter-multi-configuration dependencies as yet

b) There are no sstate optimisations. This means if the build uses the
same object twice in say two different TMPDIRs, it will either load from
an existing sstate cache at the start or build it twice. We can then in
due course look at ways in which it would only build it once and then
reuse it. This will likely need significant changes to the way sstate
currently works to make that possible.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index 96648da..87e3e27 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -201,7 +201,8 @@ def fork_off_task(worker, cfg, data, databuilder, workerdata, fn, task, taskname
 
             try:
                 bb_cache = bb.cache.NoCache(databuilder)
-                the_data = databuilder.data
+                (realfn, virtual, mc) = bb.cache.virtualfn2realfn(fn)
+                the_data = databuilder.mcdata[mc]
                 the_data.setVar("BB_WORKERCONTEXT", "1")
                 the_data.setVar("BB_TASKDEPDATA", taskdepdata)
                 the_data.setVar("BUILDNAME", workerdata["buildname"])
@@ -387,7 +388,8 @@ class BitbakeWorker(object):
         bb.msg.loggerDefaultVerbose = self.workerdata["logdefaultverbose"]
         bb.msg.loggerVerboseLogs = self.workerdata["logdefaultverboselogs"]
         bb.msg.loggerDefaultDomains = self.workerdata["logdefaultdomain"]
-        self.data.setVar("PRSERV_HOST", self.workerdata["prhost"])
+        for mc in self.databuilder.mcdata:
+            self.databuilder.mcdata[mc].setVar("PRSERV_HOST", self.workerdata["prhost"])
 
     def handle_ping(self, _):
         workerlog_write("Handling ping\n")
diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 5f302d6..0d5a034 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -248,6 +248,11 @@ def virtualfn2realfn(virtualfn):
     """
     Convert a virtual file name to a real one + the associated subclass keyword
     """
+    mc = ""
+    if virtualfn.startswith('multiconfig:'):
+        elems = virtualfn.split(':')
+        mc = elems[1]
+        virtualfn = ":".join(elems[2:])
 
     fn = virtualfn
     cls = ""
@@ -255,15 +260,32 @@ def virtualfn2realfn(virtualfn):
         elems = virtualfn.split(':')
         cls = ":".join(elems[1:-1])
         fn = elems[-1]
-    return (fn, cls)
 
-def realfn2virtual(realfn, cls):
+    return (fn, cls, mc)
+
+def realfn2virtual(realfn, cls, mc):
+    """
+    Convert a real filename + the associated subclass keyword to a virtual filename
+    """
+    if cls:
+        realfn = "virtual:" + cls + ":" + realfn
+    if mc:
+        realfn = "multiconfig:" + mc + ":" + realfn
+    return realfn
+
+def variant2virtual(realfn, variant):
     """
     Convert a real filename + the associated subclass keyword to a virtual filename
     """
-    if cls == "":
+    if variant == "":
         return realfn
-    return "virtual:" + cls + ":" + realfn
+    if variant.startswith("multiconfig:"):
+        elems = variant.split(":")
+        if elems[2]:
+            return "multiconfig:" + elems[1] + ":virtual:" + ":".join(elems[2:]) + ":" + realfn
+        return "multiconfig:" + elems[1] + ":" + realfn
+    return "virtual:" + variant + ":" + realfn
+
 
 class NoCache(object):
 
@@ -277,7 +299,7 @@ class NoCache(object):
         To do this, we need to parse the file.
         """
         logger.debug(1, "Parsing %s (full)" % virtualfn)
-        (fn, virtual) = virtualfn2realfn(virtualfn)
+        (fn, virtual, mc) = virtualfn2realfn(virtualfn)
         bb_data = self.load_bbfile(virtualfn, appends, virtonly=True)
         return bb_data[virtual]
 
@@ -288,8 +310,8 @@ class NoCache(object):
         """
 
         if virtonly:
-            (bbfile, virtual) = virtualfn2realfn(bbfile)
-            bb_data = self.data.createCopy()
+            (bbfile, virtual, mc) = virtualfn2realfn(bbfile)
+            bb_data = self.databuilder.mcdata[mc].createCopy()
             bb_data.setVar("__BBMULTICONFIG", mc) 
             bb_data.setVar("__ONLYFINALISE", virtual or "default")
             datastores = self._load_bbfile(bb_data, bbfile, appends)
@@ -298,6 +320,15 @@ class NoCache(object):
         bb_data = self.data.createCopy()
         datastores = self._load_bbfile(bb_data, bbfile, appends)
 
+        for mc in self.databuilder.mcdata:
+            if not mc:
+                continue
+            bb_data = self.databuilder.mcdata[mc].createCopy()
+            bb_data.setVar("__BBMULTICONFIG", mc) 
+            newstores = self._load_bbfile(bb_data, bbfile, appends)
+            for ns in newstores:
+                datastores["multiconfig:%s:%s" % (mc, ns)] = newstores[ns]
+
         return datastores
 
     def _load_bbfile(self, bb_data, bbfile, appends):
@@ -451,7 +482,7 @@ class Cache(NoCache):
         for variant, data in sorted(datastores.items(),
                                     key=lambda i: i[0],
                                     reverse=True):
-            virtualfn = realfn2virtual(filename, variant)
+            virtualfn = variant2virtual(filename, variant)
             variants.append(variant)
             depends = depends + (data.getVar("__depends", False) or [])
             if depends and not variant:
@@ -480,7 +511,7 @@ class Cache(NoCache):
             # info_array item is a list of [CoreRecipeInfo, XXXRecipeInfo]
             info_array = self.depends_cache[filename]
             for variant in info_array[0].variants:
-                virtualfn = realfn2virtual(filename, variant)
+                virtualfn = variant2virtual(filename, variant)
                 infos.append((virtualfn, self.depends_cache[virtualfn]))
         else:
             return self.parse(filename, appends, configdata, self.caches_array)
@@ -601,7 +632,7 @@ class Cache(NoCache):
 
         invalid = False
         for cls in info_array[0].variants:
-            virtualfn = realfn2virtual(fn, cls)
+            virtualfn = variant2virtual(fn, cls)
             self.clean.add(virtualfn)
             if virtualfn not in self.depends_cache:
                 logger.debug(2, "Cache: %s is not cached", virtualfn)
@@ -613,7 +644,7 @@ class Cache(NoCache):
         # If any one of the variants is not present, mark as invalid for all
         if invalid:
             for cls in info_array[0].variants:
-                virtualfn = realfn2virtual(fn, cls)
+                virtualfn = variant2virtual(fn, cls)
                 if virtualfn in self.clean:
                     logger.debug(2, "Cache: Removing %s from cache", virtualfn)
                     self.clean.remove(virtualfn)
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index fe95e73..783f1c1 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -166,7 +166,7 @@ class BBCooker:
     """
 
     def __init__(self, configuration, featureSet=None):
-        self.recipecache = None
+        self.recipecaches = None
         self.skiplist = {}
         self.featureset = CookerFeatures()
         if featureSet:
@@ -521,11 +521,14 @@ class BBCooker:
             nice = int(nice) - curnice
             buildlog.verbose("Renice to %s " % os.nice(nice))
 
-        if self.recipecache:
-            del self.recipecache
-        self.recipecache = bb.cache.CacheData(self.caches_array)
+        if self.recipecaches:
+            del self.recipecaches
+        self.multiconfigs = self.databuilder.mcdata.keys()
+        self.recipecaches = {}
+        for mc in self.multiconfigs:
+            self.recipecaches[mc] = bb.cache.CacheData(self.caches_array)
 
-        self.handleCollections( self.data.getVar("BBFILE_COLLECTIONS", True) )
+        self.handleCollections(self.data.getVar("BBFILE_COLLECTIONS", True))
 
     def updateConfigOpts(self, options, environment):
         clean = True
@@ -601,17 +604,18 @@ class BBCooker:
             # this showEnvironment() code path doesn't use the cache
             self.parseConfiguration()
 
-            fn, cls = bb.cache.virtualfn2realfn(buildfile)
+            fn, cls, mc = bb.cache.virtualfn2realfn(buildfile)
             fn = self.matchFile(fn)
-            fn = bb.cache.realfn2virtual(fn, cls)
+            fn = bb.cache.realfn2virtual(fn, cls, mc)
         elif len(pkgs_to_build) == 1:
             ignore = self.expanded_data.getVar("ASSUME_PROVIDED", True) or ""
             if pkgs_to_build[0] in set(ignore.split()):
                 bb.fatal("%s is in ASSUME_PROVIDED" % pkgs_to_build[0])
 
-            taskdata, runlist, pkgs_to_build = self.buildTaskData(pkgs_to_build, None, self.configuration.abort, allowincomplete=True)
+            taskdata, runlist = self.buildTaskData(pkgs_to_build, None, self.configuration.abort, allowincomplete=True)
 
-            fn = taskdata.build_targets[pkgs_to_build[0]][0]
+            mc = runlist[0][0]
+            fn = runlist[0][3]
         else:
             envdata = self.data
 
@@ -652,29 +656,40 @@ class BBCooker:
             task = self.configuration.cmd
 
         fulltargetlist = self.checkPackages(pkgs_to_build)
+        taskdata = {}
+        localdata = {}
 
-        localdata = data.createCopy(self.data)
-        bb.data.update_data(localdata)
-        bb.data.expandKeys(localdata)
-        taskdata = bb.taskdata.TaskData(abort, skiplist=self.skiplist, allowincomplete=allowincomplete)
+        for mc in self.multiconfigs:
+            taskdata[mc] = bb.taskdata.TaskData(abort, skiplist=self.skiplist, allowincomplete=allowincomplete)
+            localdata[mc] = data.createCopy(self.databuilder.mcdata[mc])
+            bb.data.update_data(localdata[mc])
+            bb.data.expandKeys(localdata[mc])
 
         current = 0
         runlist = []
         for k in fulltargetlist:
+            mc = ""
+            if k.startswith("multiconfig:"):
+                mc = k.split(":")[1]
+                k = ":".join(k.split(":")[2:])
             ktask = task
             if ":do_" in k:
                 k2 = k.split(":do_")
                 k = k2[0]
                 ktask = k2[1]
-            taskdata.add_provider(localdata, self.recipecache, k)
+            taskdata[mc].add_provider(localdata[mc], self.recipecaches[mc], k)
             current += 1
             if not ktask.startswith("do_"):
                 ktask = "do_%s" % ktask
-            runlist.append([k, ktask])
+            fn = taskdata[mc].build_targets[k][0]
+            runlist.append([mc, k, ktask, fn])
             bb.event.fire(bb.event.TreeDataPreparationProgress(current, len(fulltargetlist)), self.data)
-        taskdata.add_unresolved(localdata, self.recipecache)
+
+        for mc in self.multiconfigs:
+            taskdata[mc].add_unresolved(localdata[mc], self.recipecaches[mc])
+
         bb.event.fire(bb.event.TreeDataPreparationCompleted(len(fulltargetlist)), self.data)
-        return taskdata, runlist, fulltargetlist
+        return taskdata, runlist
 
     def prepareTreeData(self, pkgs_to_build, task):
         """
@@ -683,7 +698,7 @@ class BBCooker:
 
         # We set abort to False here to prevent unbuildable targets raising
         # an exception when we're just generating data
-        taskdata, runlist, pkgs_to_build = self.buildTaskData(pkgs_to_build, task, False, allowincomplete=True)
+        taskdata, runlist = self.buildTaskData(pkgs_to_build, task, False, allowincomplete=True)
 
         return runlist, taskdata
 
@@ -695,10 +710,15 @@ class BBCooker:
         information.
         """
         runlist, taskdata = self.prepareTreeData(pkgs_to_build, task)
-        rq = bb.runqueue.RunQueue(self, self.data, self.recipecache, taskdata, runlist)
+        rq = bb.runqueue.RunQueue(self, self.data, self.recipecaches, taskdata, runlist)
         rq.rqdata.prepare()
         return self.buildDependTree(rq, taskdata)
 
+    @staticmethod
+    def add_mc_prefix(mc, pn):
+        if mc:
+            return "multiconfig:%s.%s" % (mc, pn)
+        return pn
 
     def buildDependTree(self, rq, taskdata):
         seen_fns = []
@@ -711,24 +731,27 @@ class BBCooker:
         depend_tree["rdepends-pkg"] = {}
         depend_tree["rrecs-pkg"] = {}
         depend_tree['providermap'] = {}
-        depend_tree["layer-priorities"] = self.recipecache.bbfile_config_priorities
+        depend_tree["layer-priorities"] = self.bbfile_config_priorities
 
-        for name, fn in list(taskdata.get_providermap().items()):
-            pn = self.recipecache.pkg_fn[fn]
-            if name != pn:
-                version = "%s:%s-%s" % self.recipecache.pkg_pepvpr[fn]
-                depend_tree['providermap'][name] = (pn, version)
+        for mc in taskdata:
+            for name, fn in list(taskdata[mc].get_providermap().items()):
+                pn = self.recipecaches[mc].pkg_fn[fn]
+                pn = self.add_mc_prefix(mc, pn)
+                if name != pn:
+                    version = "%s:%s-%s" % self.recipecaches[mc].pkg_pepvpr[fn]
+                    depend_tree['providermap'][name] = (pn, version)
 
         for tid in rq.rqdata.runtaskentries:
-            taskname = bb.runqueue.taskname_from_tid(tid)
-            fn = bb.runqueue.fn_from_tid(tid)
-            pn = self.recipecache.pkg_fn[fn]
-            version  = "%s:%s-%s" % self.recipecache.pkg_pepvpr[fn]
+            (mc, fn, taskname) = bb.runqueue.split_tid(tid)
+            taskfn = bb.runqueue.taskfn_fromtid(tid)
+            pn = self.recipecaches[mc].pkg_fn[taskfn]
+            pn = self.add_mc_prefix(mc, pn)
+            version  = "%s:%s-%s" % self.recipecaches[mc].pkg_pepvpr[taskfn]
             if pn not in depend_tree["pn"]:
                 depend_tree["pn"][pn] = {}
-                depend_tree["pn"][pn]["filename"] = fn
+                depend_tree["pn"][pn]["filename"] = taskfn
                 depend_tree["pn"][pn]["version"] = version
-                depend_tree["pn"][pn]["inherits"] = self.recipecache.inherits.get(fn, None)
+                depend_tree["pn"][pn]["inherits"] = self.recipecaches[mc].inherits.get(taskfn, None)
 
                 # if we have extra caches, list all attributes they bring in
                 extra_info = []
@@ -739,36 +762,37 @@ class BBCooker:
 
                 # for all attributes stored, add them to the dependency tree
                 for ei in extra_info:
-                    depend_tree["pn"][pn][ei] = vars(self.recipecache)[ei][fn]
+                    depend_tree["pn"][pn][ei] = vars(self.recipecaches[mc])[ei][taskfn]
 
 
             for dep in rq.rqdata.runtaskentries[tid].depends:
-                depfn = bb.runqueue.fn_from_tid(dep)
-                deppn = self.recipecache.pkg_fn[depfn]
+                (depmc, depfn, deptaskname) = bb.runqueue.split_tid(dep)
+                deptaskfn = bb.runqueue.taskfn_fromtid(dep)
+                deppn = self.recipecaches[mc].pkg_fn[deptaskfn]
                 dotname = "%s.%s" % (pn, bb.runqueue.taskname_from_tid(tid))
                 if not dotname in depend_tree["tdepends"]:
                     depend_tree["tdepends"][dotname] = []
                 depend_tree["tdepends"][dotname].append("%s.%s" % (deppn, bb.runqueue.taskname_from_tid(dep)))
-            if fn not in seen_fns:
-                seen_fns.append(fn)
+            if taskfn not in seen_fns:
+                seen_fns.append(taskfn)
                 packages = []
 
                 depend_tree["depends"][pn] = []
-                for dep in taskdata.depids[fn]:
+                for dep in taskdata[mc].depids[taskfn]:
                     depend_tree["depends"][pn].append(dep)
 
                 depend_tree["rdepends-pn"][pn] = []
-                for rdep in taskdata.rdepids[fn]:
+                for rdep in taskdata[mc].rdepids[taskfn]:
                     depend_tree["rdepends-pn"][pn].append(rdep)
 
-                rdepends = self.recipecache.rundeps[fn]
+                rdepends = self.recipecaches[mc].rundeps[taskfn]
                 for package in rdepends:
                     depend_tree["rdepends-pkg"][package] = []
                     for rdepend in rdepends[package]:
                         depend_tree["rdepends-pkg"][package].append(rdepend)
                     packages.append(package)
 
-                rrecs = self.recipecache.runrecs[fn]
+                rrecs = self.recipecaches[mc].runrecs[taskfn]
                 for package in rrecs:
                     depend_tree["rrecs-pkg"][package] = []
                     for rdepend in rrecs[package]:
@@ -780,7 +804,7 @@ class BBCooker:
                     if package not in depend_tree["packages"]:
                         depend_tree["packages"][package] = {}
                         depend_tree["packages"][package]["pn"] = pn
-                        depend_tree["packages"][package]["filename"] = fn
+                        depend_tree["packages"][package]["filename"] = taskfn
                         depend_tree["packages"][package]["version"] = version
 
         return depend_tree
@@ -807,44 +831,54 @@ class BBCooker:
                 cachefields = getattr(cache_class, 'cachefields', [])
                 extra_info = extra_info + cachefields
 
-        for tid in taskdata.taskentries:
-            fn = bb.runqueue.fn_from_tid(tid)
-            pn = self.recipecache.pkg_fn[fn]
+        tids = []
+        for mc in taskdata:
+            for tid in taskdata[mc].taskentries:
+                tids.append(tid)
+
+        for tid in tids:
+            (mc, fn, taskname) = bb.runqueue.split_tid(tid)
+            taskfn = bb.runqueue.taskfn_fromtid(tid)
+
+            pn = self.recipecaches[mc].pkg_fn[taskfn]
+            pn = self.add_mc_prefix(mc, pn)
 
             if pn not in depend_tree["pn"]:
                 depend_tree["pn"][pn] = {}
-                depend_tree["pn"][pn]["filename"] = fn
-                version  = "%s:%s-%s" % self.recipecache.pkg_pepvpr[fn]
+                depend_tree["pn"][pn]["filename"] = taskfn
+                version  = "%s:%s-%s" % self.recipecaches[mc].pkg_pepvpr[taskfn]
                 depend_tree["pn"][pn]["version"] = version
-                rdepends = self.recipecache.rundeps[fn]
-                rrecs = self.recipecache.runrecs[fn]
-                depend_tree["pn"][pn]["inherits"] = self.recipecache.inherits.get(fn, None)
+                rdepends = self.recipecache.rundeps[taskfn]
+                rrecs = self.recipecache.runrecs[taskfn]
+                depend_tree["pn"][pn]["inherits"] = self.recipecaches[mc].inherits.get(taskfn, None)
 
                 # for all extra attributes stored, add them to the dependency tree
                 for ei in extra_info:
-                    depend_tree["pn"][pn][ei] = vars(self.recipecache)[ei][fn]
+                    depend_tree["pn"][pn][ei] = vars(self.recipecaches[mc])[ei][taskfn]
 
-            if fn not in seen_fns:
-                seen_fns.append(fn)
+            if taskfn not in seen_fns:
+                seen_fns.append(taskfn)
 
                 depend_tree["depends"][pn] = []
-                for item in taskdata.depids[fn]:
+                for item in taskdata[mc].depids[taskfn]:
                     pn_provider = ""
-                    if dep in taskdata.build_targets and taskdata.build_targets[dep]:
-                        fn_provider = taskdata.build_targets[dep][0]
-                        pn_provider = self.recipecache.pkg_fn[fn_provider]
+                    if dep in taskdata[mc].build_targets and taskdata[mc].build_targets[dep]:
+                        fn_provider = taskdata[mc].build_targets[dep][0]
+                        pn_provider = self.recipecaches[mc].pkg_fn[fn_provider]
                     else:
                         pn_provider = item
+                    pn_provider = self.add_mc_prefix(mc, pn_provider)
                     depend_tree["depends"][pn].append(pn_provider)
 
                 depend_tree["rdepends-pn"][pn] = []
-                for rdep in taskdata.rdepids[fn]:
+                for rdep in taskdata[mc].rdepids[taskfn]:
                     pn_rprovider = ""
-                    if rdep in taskdata.run_targets and taskdata.run_targets[rdep]:
-                        fn_rprovider = taskdata.run_targets[rdep][0]
+                    if rdep in taskdata[mc].run_targets and taskdata[mc].run_targets[rdep]:
+                        fn_rprovider = taskdata[mc].run_targets[rdep][0]
                         pn_rprovider = self.recipecache.pkg_fn[fn_rprovider]
                     else:
                         pn_rprovider = rdep
+                    pn_rprovider = self.add_mc_prefix(mc, pn_rprovider)
                     depend_tree["rdepends-pn"][pn].append(pn_rprovider)
 
                 depend_tree["rdepends-pkg"].update(rdepends)
@@ -928,7 +962,7 @@ class BBCooker:
         # Determine which bbappends haven't been applied
 
         # First get list of recipes, including skipped
-        recipefns = list(self.recipecache.pkg_fn.keys())
+        recipefns = list(self.recipecaches[''].pkg_fn.keys())
         recipefns.extend(self.skiplist.keys())
 
         # Work out list of bbappends that have been applied
@@ -952,20 +986,21 @@ class BBCooker:
 
     def handlePrefProviders(self):
 
-        localdata = data.createCopy(self.data)
-        bb.data.update_data(localdata)
-        bb.data.expandKeys(localdata)
+        for mc in self.multiconfigs:
+            localdata = data.createCopy(self.databuilder.mcdata[mc])
+            bb.data.update_data(localdata)
+            bb.data.expandKeys(localdata)
 
-        # Handle PREFERRED_PROVIDERS
-        for p in (localdata.getVar('PREFERRED_PROVIDERS', True) or "").split():
-            try:
-                (providee, provider) = p.split(':')
-            except:
-                providerlog.critical("Malformed option in PREFERRED_PROVIDERS variable: %s" % p)
-                continue
-            if providee in self.recipecache.preferred and self.recipecache.preferred[providee] != provider:
-                providerlog.error("conflicting preferences for %s: both %s and %s specified", providee, provider, self.recipecache.preferred[providee])
-            self.recipecache.preferred[providee] = provider
+            # Handle PREFERRED_PROVIDERS
+            for p in (localdata.getVar('PREFERRED_PROVIDERS', True) or "").split():
+                try:
+                    (providee, provider) = p.split(':')
+                except:
+                    providerlog.critical("Malformed option in PREFERRED_PROVIDERS variable: %s" % p)
+                    continue
+                if providee in self.recipecaches[mc].preferred and self.recipecaches[mc].preferred[providee] != provider:
+                    providerlog.error("conflicting preferences for %s: both %s and %s specified", providee, provider, self.recipecaches[mc].preferred[providee])
+                self.recipecaches[mc].preferred[providee] = provider
 
     def findCoreBaseFiles(self, subdir, configfile):
         corebase = self.data.getVar('COREBASE', True) or ""
@@ -1060,10 +1095,10 @@ class BBCooker:
         """
         pkg_list = []
 
-        for pfn in self.recipecache.pkg_fn:
-            inherits = self.recipecache.inherits.get(pfn, None)
+        for pfn in self.recipecaches[''].pkg_fn:
+            inherits = self.recipecaches[''].inherits.get(pfn, None)
             if inherits and klass in inherits:
-                pkg_list.append(self.recipecache.pkg_fn[pfn])
+                pkg_list.append(self.recipecaches[''].pkg_fn[pfn])
 
         return pkg_list
 
@@ -1096,10 +1131,10 @@ class BBCooker:
             shell.start( self )
 
 
-    def handleCollections( self, collections ):
+    def handleCollections(self, collections):
         """Handle collections"""
         errors = False
-        self.recipecache.bbfile_config_priorities = []
+        self.bbfile_config_priorities = []
         if collections:
             collection_priorities = {}
             collection_depends = {}
@@ -1177,7 +1212,7 @@ class BBCooker:
                     parselog.error("BBFILE_PATTERN_%s \"%s\" is not a valid regular expression", c, regex)
                     errors = True
                     continue
-                self.recipecache.bbfile_config_priorities.append((c, regex, cre, collection_priorities[c]))
+                self.bbfile_config_priorities.append((c, regex, cre, collection_priorities[c]))
         if errors:
             # We've already printed the actual error(s)
             raise CollectionError("Errors during parsing layer configuration")
@@ -1200,7 +1235,7 @@ class BBCooker:
         if bf.startswith("/") or bf.startswith("../"):
             bf = os.path.abspath(bf)
 
-        self.collection = CookerCollectFiles(self.recipecache.bbfile_config_priorities)
+        self.collection = CookerCollectFiles(self.bbfile_config_priorities)
         filelist, masked = self.collection.collect_bbfiles(self.data, self.expanded_data)
         try:
             os.stat(bf)
@@ -1250,7 +1285,7 @@ class BBCooker:
         if (task == None):
             task = self.configuration.cmd
 
-        fn, cls = bb.cache.virtualfn2realfn(buildfile)
+        fn, cls, mc = bb.cache.virtualfn2realfn(buildfile)
         fn = self.matchFile(fn)
 
         self.buildSetVars()
@@ -1260,7 +1295,7 @@ class BBCooker:
         infos = bb_cache.parse(fn, self.collection.get_file_appends(fn))
         infos = dict(infos)
 
-        fn = bb.cache.realfn2virtual(fn, cls)
+        fn = bb.cache.realfn2virtual(fn, cls, mc)
         try:
             info_array = infos[fn]
         except KeyError:
@@ -1269,29 +1304,30 @@ class BBCooker:
         if info_array[0].skipped:
             bb.fatal("%s was skipped: %s" % (fn, info_array[0].skipreason))
 
-        self.recipecache.add_from_recipeinfo(fn, info_array)
+        self.recipecaches[mc].add_from_recipeinfo(fn, info_array)
 
         # Tweak some variables
         item = info_array[0].pn
-        self.recipecache.ignored_dependencies = set()
-        self.recipecache.bbfile_priority[fn] = 1
+        self.recipecaches[mc].ignored_dependencies = set()
+        self.recipecaches[mc].bbfile_priority[fn] = 1
 
         # Remove external dependencies
-        self.recipecache.task_deps[fn]['depends'] = {}
-        self.recipecache.deps[fn] = []
-        self.recipecache.rundeps[fn] = []
-        self.recipecache.runrecs[fn] = []
+        self.recipecaches[mc].task_deps[fn]['depends'] = {}
+        self.recipecaches[mc].deps[fn] = []
+        self.recipecaches[mc].rundeps[fn] = []
+        self.recipecaches[mc].runrecs[fn] = []
 
         # Invalidate task for target if force mode active
         if self.configuration.force:
             logger.verbose("Invalidate task %s, %s", task, fn)
             if not task.startswith("do_"):
                 task = "do_%s" % task
-            bb.parse.siggen.invalidate_task(task, self.recipecache, fn)
+            bb.parse.siggen.invalidate_task(task, self.recipecaches[mc], fn)
 
         # Setup taskdata structure
-        taskdata = bb.taskdata.TaskData(self.configuration.abort)
-        taskdata.add_provider(self.data, self.recipecache, item)
+        taskdata = {}
+        taskdata[mc] = bb.taskdata.TaskData(self.configuration.abort)
+        taskdata[mc].add_provider(self.data, self.recipecaches[mc], item)
 
         buildname = self.data.getVar("BUILDNAME", True)
         bb.event.fire(bb.event.BuildStarted(buildname, [item]), self.expanded_data)
@@ -1299,9 +1335,9 @@ class BBCooker:
         # Execute the runqueue
         if not task.startswith("do_"):
             task = "do_%s" % task
-        runlist = [[item, task]]
+        runlist = [[mc, item, task, fn]]
 
-        rq = bb.runqueue.RunQueue(self, self.data, self.recipecache, taskdata, runlist)
+        rq = bb.runqueue.RunQueue(self, self.data, self.recipecaches, taskdata, runlist)
 
         def buildFileIdle(server, rq, abort):
 
@@ -1382,23 +1418,20 @@ class BBCooker:
         packages = ["%s:%s" % (target, task) for target in targets]
         bb.event.fire(bb.event.BuildInit(packages), self.expanded_data)
 
-        taskdata, runlist, fulltargetlist = self.buildTaskData(targets, task, self.configuration.abort)
+        taskdata, runlist = self.buildTaskData(targets, task, self.configuration.abort)
 
         buildname = self.data.getVar("BUILDNAME", False)
 
         # make targets to always look as <target>:do_<task>
         ntargets = []
-        for target in fulltargetlist:
-            if ":" in target:
-                if ":do_" not in target:
-                    target = "%s:do_%s" % tuple(target.split(":", 1))
-            else:
-                target = "%s:%s" % (target, task)
-            ntargets.append(target)
+        for target in runlist:
+            if target[0]:
+                ntargets.append("multiconfig:%s:%s:%s" % (target[0], target[1], target[2]))
+            ntargets.append("%s:%s" % (target[1], target[2]))
 
         bb.event.fire(bb.event.BuildStarted(buildname, ntargets), self.data)
 
-        rq = bb.runqueue.RunQueue(self, self.data, self.recipecache, taskdata, runlist)
+        rq = bb.runqueue.RunQueue(self, self.data, self.recipecaches, taskdata, runlist)
         if 'universe' in targets:
             rq.rqdata.warn_multi_bb = True
 
@@ -1513,13 +1546,14 @@ class BBCooker:
             if CookerFeatures.SEND_SANITYEVENTS in self.featureset:
                 bb.event.fire(bb.event.SanityCheck(False), self.data)
 
-            ignore = self.expanded_data.getVar("ASSUME_PROVIDED", True) or ""
-            self.recipecache.ignored_dependencies = set(ignore.split())
+            for mc in self.multiconfigs:
+                ignore = self.databuilder.mcdata[mc].getVar("ASSUME_PROVIDED", True) or ""
+                self.recipecaches[mc].ignored_dependencies = set(ignore.split())
 
-            for dep in self.configuration.extra_assume_provided:
-                self.recipecache.ignored_dependencies.add(dep)
+                for dep in self.configuration.extra_assume_provided:
+                    self.recipecaches[mc].ignored_dependencies.add(dep)
 
-            self.collection = CookerCollectFiles(self.recipecache.bbfile_config_priorities)
+            self.collection = CookerCollectFiles(self.bbfile_config_priorities)
             (filelist, masked) = self.collection.collect_bbfiles(self.data, self.expanded_data)
 
             self.parser = CookerParser(self, filelist, masked)
@@ -1533,13 +1567,15 @@ class BBCooker:
                 raise bb.BBHandledException()
             self.show_appends_with_no_recipes()
             self.handlePrefProviders()
-            self.recipecache.bbfile_priority = self.collection.collection_priorities(self.recipecache.pkg_fn, self.data)
+            for mc in self.multiconfigs:
+                self.recipecaches[mc].bbfile_priority = self.collection.collection_priorities(self.recipecaches[mc].pkg_fn, self.data)
             self.state = state.running
 
             # Send an event listing all stamps reachable after parsing
             # which the metadata may use to clean up stale data
-            event = bb.event.ReachableStamps(self.recipecache.stamp)
-            bb.event.fire(event, self.expanded_data)
+            for mc in self.multiconfigs:
+                event = bb.event.ReachableStamps(self.recipecaches[mc].stamp)
+                bb.event.fire(event, self.databuilder.mcdata[mc])
             return None
 
         return True
@@ -1558,23 +1594,26 @@ class BBCooker:
                 parselog.warning("Explicit target \"%s\" is in ASSUME_PROVIDED, ignoring" % pkg)
 
         if 'world' in pkgs_to_build:
-            bb.providers.buildWorldTargetList(self.recipecache)
             pkgs_to_build.remove('world')
-            for t in self.recipecache.world_target:
-                pkgs_to_build.append(t)
+            for mc in self.multiconfigs:
+                bb.providers.buildWorldTargetList(self.recipecaches[mc])
+                for t in self.recipecaches[mc].world_target:
+                    if mc:
+                        t = "multiconfig:" + mc + ":" + t
+                    pkgs_to_build.append(t)
 
         if 'universe' in pkgs_to_build:
             parselog.warning("The \"universe\" target is only intended for testing and may produce errors.")
             parselog.debug(1, "collating packages for \"universe\"")
             pkgs_to_build.remove('universe')
-            for t in self.recipecache.universe_target:
-                pkgs_to_build.append(t)
+            for mc in self.multiconfigs:
+                for t in self.recipecaches[mc].universe_target:
+                    if mc:
+                        t = "multiconfig:" + mc + ":" + t
+                    pkgs_to_build.append(t)
 
         return pkgs_to_build
 
-
-
-
     def pre_serve(self):
         # Empty the environment. The environment will be populated as
         # necessary from the data store.
@@ -1823,7 +1862,7 @@ class CookerCollectFiles(object):
         # Calculate priorities for each file
         matched = set()
         for p in pkgfns:
-            realfn, cls = bb.cache.virtualfn2realfn(p)
+            realfn, cls, mc = bb.cache.virtualfn2realfn(p)
             priorities[p] = self.calc_bbfile_priority(realfn, matched)
 
         # Don't show the warning if the BBFILE_PATTERN did match .bbappend files
@@ -2164,11 +2203,13 @@ class CookerParser(object):
             if info_array[0].skipped:
                 self.skipped += 1
                 self.cooker.skiplist[virtualfn] = SkippedPackage(info_array[0])
-            self.bb_cache.add_info(virtualfn, info_array, self.cooker.recipecache,
+            (fn, cls, mc) = bb.cache.virtualfn2realfn(virtualfn)
+            self.bb_cache.add_info(virtualfn, info_array, self.cooker.recipecaches[mc],
                                         parsed=parsed, watcher = self.cooker.add_filewatch)
         return True
 
     def reparse(self, filename):
         infos = self.bb_cache.parse(filename, self.cooker.collection.get_file_appends(filename))
         for vfn, info_array in infos:
-            self.cooker.recipecache.add_from_recipeinfo(vfn, info_array)
+            (fn, cls, mc) = bb.cache.virtualfn2realfn(vfn)
+            self.cooker.recipecaches[mc].add_from_recipeinfo(vfn, info_array)
diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 71021a3..fa1de7a 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -237,9 +237,9 @@ class CookerDataBuilder(object):
 
         bb.utils.set_context(bb.utils.clean_context())
         bb.event.set_class_handlers(bb.event.clean_class_handlers())
-        self.data = bb.data.init()
+        self.basedata = bb.data.init()
         if self.tracking:
-            self.data.enableTracking()
+            self.basedata.enableTracking()
 
         # Keep a datastore of the initial environment variables and their
         # values from when BitBake was launched to enable child processes
@@ -250,15 +250,40 @@ class CookerDataBuilder(object):
             self.savedenv.setVar(k, cookercfg.env[k])
 
         filtered_keys = bb.utils.approved_variables()
-        bb.data.inheritFromOS(self.data, self.savedenv, filtered_keys)
-        self.data.setVar("BB_ORIGENV", self.savedenv)
+        bb.data.inheritFromOS(self.basedata, self.savedenv, filtered_keys)
+        self.basedata.setVar("BB_ORIGENV", self.savedenv)
         
         if worker:
-            self.data.setVar("BB_WORKERCONTEXT", "1")
+            self.basedata.setVar("BB_WORKERCONTEXT", "1")
+
+        self.data = self.basedata
+        self.mcdata = {}
 
     def parseBaseConfiguration(self):
         try:
-            self.parseConfigurationFiles()
+            bb.parse.init_parser(self.basedata)
+            self.data = self.parseConfigurationFiles(self.prefiles, self.postfiles)
+
+            if self.data.getVar("BB_WORKERCONTEXT", False) is None:
+                bb.fetch.fetcher_init(self.data)
+            bb.codeparser.parser_cache_init(self.data)
+
+            bb.event.fire(bb.event.ConfigParsed(), self.data)
+
+            if self.data.getVar("BB_INVALIDCONF", False) is True:
+                self.data.setVar("BB_INVALIDCONF", False)
+                self.data = self.parseConfigurationFiles(self.prefiles, self.postfiles)
+
+            bb.parse.init_parser(self.data)
+            self.data_hash = self.data.get_hash()
+            self.mcdata[''] = self.data
+
+            multiconfig = (self.data.getVar("BBMULTICONFIG", True) or "").split()
+            for config in multiconfig:
+                mcdata = self.parseConfigurationFiles(['conf/multiconfig/%s.conf' % config] + self.prefiles, self.postfiles)
+                bb.event.fire(bb.event.ConfigParsed(), mcdata)
+                self.mcdata[config] = mcdata
+
         except SyntaxError:
             raise bb.BBHandledException
         except bb.data_smart.ExpansionError as e:
@@ -271,11 +296,8 @@ class CookerDataBuilder(object):
     def _findLayerConf(self, data):
         return findConfigFile("bblayers.conf", data)
 
-    def parseConfigurationFiles(self):
-        data = self.data
-        prefiles = self.prefiles
-        postfiles = self.postfiles
-        bb.parse.init_parser(data)
+    def parseConfigurationFiles(self, prefiles, postfiles):
+        data = bb.data.createCopy(self.basedata)
 
         # Parse files for loading *before* bitbake.conf and any includes
         for f in prefiles:
@@ -338,20 +360,7 @@ class CookerDataBuilder(object):
             handlerln = int(data.getVarFlag(var, "lineno", False))
             bb.event.register(var, data.getVar(var, False),  (data.getVarFlag(var, "eventmask", True) or "").split(), handlerfn, handlerln)
 
-        if data.getVar("BB_WORKERCONTEXT", False) is None:
-            bb.fetch.fetcher_init(data)
-        bb.codeparser.parser_cache_init(data)
-        bb.event.fire(bb.event.ConfigParsed(), data)
-
-        if data.getVar("BB_INVALIDCONF", False) is True:
-            data.setVar("BB_INVALIDCONF", False)
-            self.parseConfigurationFiles()
-            return
-
-        bb.parse.init_parser(data)
         data.setVar('BBINCLUDED',bb.parse.get_file_depends(data))
-        self.data = data
-        self.data_hash = data.get_hash()
-
 
+        return data
 
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index f8bb641..5fc40ef 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -48,6 +48,31 @@ def fn_from_tid(tid):
 def taskname_from_tid(tid):
     return tid.rsplit(":", 1)[1]
 
+def split_tid(tid):
+    if tid.startswith('multiconfig:'):
+        elems = tid.split(':')
+        mc = elems[1]
+        fn = ":".join(elems[2:-1])
+        taskname = elems[-1]
+    else:
+        tid = tid.rsplit(":", 1)
+        mc = ""
+        fn = tid[0]
+        taskname = tid[1]
+
+    return (mc, fn, taskname)
+
+def build_tid(mc, fn, taskname):
+    if mc:
+        return "multiconfig:" + mc + ":" + fn + ":" + taskname
+    return fn + ":" + taskname
+
+def taskfn_fromtid(tid):
+    (mc, fn, taskname) = split_tid(tid)
+    if mc:
+        return "multiconfig:" + mc + ":" + fn
+    return fn
+
 class RunQueueStats:
     """
     Holds statistics on the tasks handled by the associated runQueue
@@ -110,9 +135,9 @@ class RunQueueScheduler(object):
         self.buildable = []
         self.stamps = {}
         for tid in self.rqdata.runtaskentries:
-            fn = fn_from_tid(tid)
-            taskname = taskname_from_tid(tid)
-            self.stamps[tid] = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
+            (mc, fn, taskname) = split_tid(tid)
+            taskfn = taskfn_fromtid(tid)
+            self.stamps[tid] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn)
             if tid in self.rq.runq_buildable:
                 self.buildable.append(tid)
 
@@ -230,9 +255,9 @@ class RunQueueData:
     """
     BitBake Run Queue implementation
     """
-    def __init__(self, rq, cooker, cfgData, dataCache, taskData, targets):
+    def __init__(self, rq, cooker, cfgData, dataCaches, taskData, targets):
         self.cooker = cooker
-        self.dataCache = dataCache
+        self.dataCaches = dataCaches
         self.taskData = taskData
         self.targets = targets
         self.rq = rq
@@ -264,8 +289,8 @@ class RunQueueData:
         return tid + task_name_suffix
 
     def get_short_user_idstring(self, task, task_name_suffix = ""):
-        fn = fn_from_tid(task)
-        pn = self.dataCache.pkg_fn[fn]
+        (mc, fn, taskname) = split_tid(task)
+        pn = self.dataCaches[mc].pkg_fn[fn]
         taskname = taskname_from_tid(task) + task_name_suffix
         return "%s:%s" % (pn, taskname)
 
@@ -429,7 +454,12 @@ class RunQueueData:
 
         taskData = self.taskData
 
-        if len(taskData.taskentries) == 0:
+        found = False
+        for mc in self.taskData:
+            if len(taskData[mc].taskentries) > 0:
+                found = True
+                break
+        if not found:
             # Nothing to do
             return 0
 
@@ -447,55 +477,60 @@ class RunQueueData:
         # process is repeated for each type of dependency (tdepends, deptask,
         # rdeptast, recrdeptask, idepends).
 
-        def add_build_dependencies(depids, tasknames, depends):
+        def add_build_dependencies(depids, tasknames, depends, mc):
             for depname in depids:
                 # Won't be in build_targets if ASSUME_PROVIDED
-                if depname not in taskData.build_targets or not taskData.build_targets[depname]:
+                if depname not in taskData[mc].build_targets or not taskData[mc].build_targets[depname]:
                     continue
-                depdata = taskData.build_targets[depname][0]
+                depdata = taskData[mc].build_targets[depname][0]
                 if depdata is None:
                     continue
                 for taskname in tasknames:
                     t = depdata + ":" + taskname
-                    if t in taskData.taskentries:
+                    if t in taskData[mc].taskentries:
                         depends.add(t)
 
-        def add_runtime_dependencies(depids, tasknames, depends):
+        def add_runtime_dependencies(depids, tasknames, depends, mc):
             for depname in depids:
-                if depname not in taskData.run_targets or not taskData.run_targets[depname]:
+                if depname not in taskData[mc].run_targets or not taskData[mc].run_targets[depname]:
                     continue
-                depdata = taskData.run_targets[depname][0]
+                depdata = taskData[mc].run_targets[depname][0]
                 if depdata is None:
                     continue
                 for taskname in tasknames:
                     t = depdata + ":" + taskname
-                    if t in taskData.taskentries:
+                    if t in taskData[mc].taskentries:
                         depends.add(t)
 
-        def add_resolved_dependencies(fn, tasknames, depends):
+        def add_resolved_dependencies(mc, fn, tasknames, depends):
             for taskname in tasknames:
-                tid = fn + ":" + taskname
+                tid = build_tid(mc, fn, taskname)
                 if tid in self.runtaskentries:
                     depends.add(tid)
 
-        for tid in taskData.taskentries:
+        for mc in taskData:
+            for tid in taskData[mc].taskentries:
 
-            fn = fn_from_tid(tid)
-            taskname = taskname_from_tid(tid)
+                (mc, fn, taskname) = split_tid(tid)
+                #runtid = build_tid(mc, fn, taskname)
+                taskfn = taskfn_fromtid(tid)
 
-            depends = set()
-            task_deps = self.dataCache.task_deps[fn]
+                #logger.debug(2, "Processing %s,%s:%s", mc, fn, taskname)
 
-            self.runtaskentries[tid] = RunTaskEntry()
+                depends = set()
+                task_deps = self.dataCaches[mc].task_deps[taskfn]
 
-            #logger.debug(2, "Processing %s:%s", fn, taskname)
+                self.runtaskentries[tid] = RunTaskEntry()
 
-            if fn not in taskData.failed_fns:
+                if fn in taskData[mc].failed_fns:
+                    continue
 
                 # Resolve task internal dependencies
                 #
                 # e.g. addtask before X after Y
-                depends.update(taskData.taskentries[tid].tdepends)
+                for t in taskData[mc].taskentries[tid].tdepends:
+                    (_, depfn, deptaskname) = split_tid(t)
+                    depends.add(build_tid(mc, depfn, deptaskname))
 
                 # Resolve 'deptask' dependencies
                 #
@@ -503,7 +538,7 @@ class RunQueueData:
                 # (makes sure sometask runs after someothertask of all DEPENDS)
                 if 'deptask' in task_deps and taskname in task_deps['deptask']:
                     tasknames = task_deps['deptask'][taskname].split()
-                    add_build_dependencies(taskData.depids[fn], tasknames, depends)
+                    add_build_dependencies(taskData[mc].depids[taskfn], tasknames, depends, mc)
 
                 # Resolve 'rdeptask' dependencies
                 #
@@ -511,31 +546,31 @@ class RunQueueData:
                 # (makes sure sometask runs after someothertask of all RDEPENDS)
                 if 'rdeptask' in task_deps and taskname in task_deps['rdeptask']:
                     tasknames = task_deps['rdeptask'][taskname].split()
-                    add_runtime_dependencies(taskData.rdepids[fn], tasknames, depends)
+                    add_runtime_dependencies(taskData[mc].rdepids[taskfn], tasknames, depends, mc)
 
                 # Resolve inter-task dependencies
                 #
                 # e.g. do_sometask[depends] = "targetname:do_someothertask"
                 # (makes sure sometask runs after targetname's someothertask)
-                idepends = taskData.taskentries[tid].idepends
+                idepends = taskData[mc].taskentries[tid].idepends
                 for (depname, idependtask) in idepends:
-                    if depname in taskData.build_targets and taskData.build_targets[depname] and not depname in taskData.failed_deps:
+                    if depname in taskData[mc].build_targets and taskData[mc].build_targets[depname] and not depname in taskData[mc].failed_deps:
                         # Won't be in build_targets if ASSUME_PROVIDED
-                        depdata = taskData.build_targets[depname][0]
+                        depdata = taskData[mc].build_targets[depname][0]
                         if depdata is not None:
                             t = depdata + ":" + idependtask
                             depends.add(t)
-                            if t not in taskData.taskentries:
+                            if t not in taskData[mc].taskentries:
                                 bb.msg.fatal("RunQueue", "Task %s in %s depends upon non-existent task %s in %s" % (taskname, fn, idependtask, depdata))
-                irdepends = taskData.taskentries[tid].irdepends
+                irdepends = taskData[mc].taskentries[tid].irdepends
                 for (depname, idependtask) in irdepends:
-                    if depname in taskData.run_targets:
+                    if depname in taskData[mc].run_targets:
                         # Won't be in run_targets if ASSUME_PROVIDED
-                        depdata = taskData.run_targets[depname][0]
+                        depdata = taskData[mc].run_targets[depname][0]
                         if depdata is not None:
                             t = depdata + ":" + idependtask
                             depends.add(t)
-                            if t not in taskData.taskentries:
+                            if t not in taskData[mc].taskentries:
                                 bb.msg.fatal("RunQueue", "Task %s in %s rdepends upon non-existent task %s in %s" % (taskname, fn, idependtask, depdata))
 
                 # Resolve recursive 'recrdeptask' dependencies (Part A)
@@ -546,18 +581,20 @@ class RunQueueData:
                 if 'recrdeptask' in task_deps and taskname in task_deps['recrdeptask']:
                     tasknames = task_deps['recrdeptask'][taskname].split()
                     recursivetasks[tid] = tasknames
-                    add_build_dependencies(taskData.depids[fn], tasknames, depends)
-                    add_runtime_dependencies(taskData.rdepids[fn], tasknames, depends)
+                    add_build_dependencies(taskData[mc].depids[taskfn], tasknames, depends, mc)
+                    add_runtime_dependencies(taskData[mc].rdepids[taskfn], tasknames, depends, mc)
                     if taskname in tasknames:
                         recursivetasksselfref.add(tid)
 
                     if 'recideptask' in task_deps and taskname in task_deps['recideptask']:
                         recursiveitasks[tid] = []
                         for t in task_deps['recideptask'][taskname].split():
-                            newdep = fn + ":" + t
+                            newdep = build_tid(mc, fn, t)
                             recursiveitasks[tid].append(newdep)
 
-            self.runtaskentries[tid].depends = depends
+                self.runtaskentries[tid].depends = depends
+
+        #self.dump_data()
 
         # Resolve recursive 'recrdeptask' dependencies (Part B)
         #
@@ -574,7 +611,8 @@ class RunQueueData:
 
             def generate_recdeps(t):
                 newdeps = set()
-                add_resolved_dependencies(fn_from_tid(t), tasknames, newdeps)
+                (mc, fn, taskname) = split_tid(t)
+                add_resolved_dependencies(mc, fn, tasknames, newdeps)
                 extradeps[tid].update(newdeps)
                 seendeps.add(t)
                 newdeps.add(t)
@@ -606,6 +644,8 @@ class RunQueueData:
 
         self.init_progress_reporter.next_stage()
 
+        #self.dump_data()
+
         # Step B - Mark all active tasks
         #
         # Start with the tasks we were asked to run and mark all dependencies
@@ -629,31 +669,30 @@ class RunQueueData:
             for depend in depends:
                 mark_active(depend, depth+1)
 
-        self.target_pairs = []
-        for target in self.targets:
-            if target[0] not in taskData.build_targets or not taskData.build_targets[target[0]]:
+        self.target_tids = []
+        for (mc, target, task, fn) in self.targets:
+
+            if target not in taskData[mc].build_targets or not taskData[mc].build_targets[target]:
                 continue
 
-            if target[0] in taskData.failed_deps:
+            if target in taskData[mc].failed_deps:
                 continue
 
-            fn = taskData.build_targets[target[0]][0]
-            task = target[1]
             parents = False
             if task.endswith('-'):
                 parents = True
                 task = task[:-1]
 
-            self.target_pairs.append((fn, task))
-
-            if fn in taskData.failed_fns:
+            if fn in taskData[mc].failed_fns:
                 continue
 
+            # fn already has mc prefix
             tid = fn + ":" + task
-            if tid not in taskData.taskentries:
+            self.target_tids.append(tid)
+            if tid not in taskData[mc].taskentries:
                 import difflib
                 tasks = []
-                for x in taskData.taskentries:
+                for x in taskData[mc].taskentries:
                     if x.startswith(fn + ":"):
                         tasks.append(taskname_from_tid(x))
                 close_matches = difflib.get_close_matches(task, tasks, cutoff=0.7)
@@ -661,7 +700,7 @@ class RunQueueData:
                     extra = ". Close matches:\n  %s" % "\n  ".join(close_matches)
                 else:
                     extra = ""
-                bb.msg.fatal("RunQueue", "Task %s does not exist for target %s%s" % (task, target[0], extra))
+                bb.msg.fatal("RunQueue", "Task %s does not exist for target %s (%s)%s" % (task, target, tid, extra))
 
             # For tasks called "XXXX-", ony run their dependencies
             if parents:
@@ -690,7 +729,7 @@ class RunQueueData:
 
         # Check to make sure we still have tasks to run
         if len(self.runtaskentries) == 0:
-            if not taskData.abort:
+            if not taskData[''].abort:
                 bb.msg.fatal("RunQueue", "All buildable tasks have been run but the build is incomplete (--continue mode). Errors for the tasks that failed will have been printed above.")
             else:
                 bb.msg.fatal("RunQueue", "No active tasks and not in --continue mode?! Please report this bug.")
@@ -717,7 +756,6 @@ class RunQueueData:
                 endpoints.append(tid)
             for dep in revdeps:
                 if dep in self.runtaskentries[tid].depends:
-                    #self.dump_data(taskData)
                     bb.msg.fatal("RunQueue", "Task %s has circular dependency on %s" % (tid, dep))
 
 
@@ -732,24 +770,31 @@ class RunQueueData:
         self.init_progress_reporter.next_stage()
 
         # Sanity Check - Check for multiple tasks building the same provider
-        prov_list = {}
-        seen_fn = []
-        for tid in self.runtaskentries:
-            fn = fn_from_tid(tid)
-            if fn in seen_fn:
-                continue
-            seen_fn.append(fn)
-            for prov in self.dataCache.fn_provides[fn]:
-                if prov not in prov_list:
-                    prov_list[prov] = [fn]
-                elif fn not in prov_list[prov]:
-                    prov_list[prov].append(fn)
-        for prov in prov_list:
-            if len(prov_list[prov]) > 1 and prov not in self.multi_provider_whitelist:
+        for mc in self.dataCaches:
+            prov_list = {}
+            seen_fn = []
+            for tid in self.runtaskentries:
+                (tidmc, fn, taskname) = split_tid(tid)
+                taskfn = taskfn_fromtid(tid)
+                if taskfn in seen_fn:
+                    continue
+                if mc != tidmc:
+                    continue
+                seen_fn.append(taskfn)
+                for prov in self.dataCaches[mc].fn_provides[taskfn]:
+                    if prov not in prov_list:
+                        prov_list[prov] = [taskfn]
+                    elif taskfn not in prov_list[prov]:
+                        prov_list[prov].append(taskfn)
+            for prov in prov_list:
+                if len(prov_list[prov]) < 2:
+                    continue
+                if prov in self.multi_provider_whitelist:
+                    continue
                 seen_pn = []
                 # If two versions of the same PN are being built its fatal, we don't support it.
                 for fn in prov_list[prov]:
-                    pn = self.dataCache.pkg_fn[fn]
+                    pn = self.dataCaches[mc].pkg_fn[fn]
                     if pn not in seen_pn:
                         seen_pn.append(pn)
                     else:
@@ -790,16 +835,16 @@ class RunQueueData:
                 commonprovs = None
                 commonrprovs = None
                 for provfn in prov_list[prov]:
-                    provides = set(self.dataCache.fn_provides[provfn])
+                    provides = set(self.dataCaches[mc].fn_provides[provfn])
                     rprovides = set()
-                    for rprovide in self.dataCache.rproviders:
-                        if provfn in self.dataCache.rproviders[rprovide]:
+                    for rprovide in self.dataCaches[mc].rproviders:
+                        if provfn in self.dataCaches[mc].rproviders[rprovide]:
                             rprovides.add(rprovide)
-                    for package in self.dataCache.packages:
-                        if provfn in self.dataCache.packages[package]:
+                    for package in self.dataCaches[mc].packages:
+                        if provfn in self.dataCaches[mc].packages[package]:
                             rprovides.add(package)
-                    for package in self.dataCache.packages_dynamic:
-                        if provfn in self.dataCache.packages_dynamic[package]:
+                    for package in self.dataCaches[mc].packages_dynamic:
+                        if provfn in self.dataCaches[mc].packages_dynamic[package]:
                             rprovides.add(package)
                     if not commonprovs:
                         commonprovs = set(provides)
@@ -825,13 +870,14 @@ class RunQueueData:
         self.init_progress_reporter.next_stage()
 
         # Create a whitelist usable by the stamp checks
-        stampfnwhitelist = []
-        for entry in self.stampwhitelist.split():
-            if entry not in self.taskData.build_targets:
-                continue
-            fn = self.taskData.build_targets[entry][0]
-            stampfnwhitelist.append(fn)
-        self.stampfnwhitelist = stampfnwhitelist
+        self.stampfnwhitelist = {}
+        for mc in self.taskData: 
+            self.stampfnwhitelist[mc] = []
+            for entry in self.stampwhitelist.split():
+                if entry not in self.taskData[mc].build_targets:
+                    continue
+                fn = self.taskData.build_targets[entry][0]
+                self.stampfnwhitelist[mc].append(fn)
 
         self.init_progress_reporter.next_stage()
 
@@ -839,16 +885,16 @@ class RunQueueData:
         self.runq_setscene_tids = []
         if not self.cooker.configuration.nosetscene:
             for tid in self.runtaskentries:
-                setscenetid = tid + "_setscene"
-                if setscenetid not in taskData.taskentries:
+                (mc, fn, taskname) = split_tid(tid)
+                setscenetid = fn + ":" + taskname + "_setscene"
+                if setscenetid not in taskData[mc].taskentries:
                     continue
-                task = self.runtaskentries[tid].task
                 self.runq_setscene_tids.append(tid)
 
-        def invalidate_task(fn, taskname, error_nostamp):
-            taskdep = self.dataCache.task_deps[fn]
-            tid = fn + ":" + taskname
-            if tid not in taskData.taskentries:
+        def invalidate_task(tid, error_nostamp):
+            (mc, fn, taskname) = split_tid(tid)
+            taskdep = self.dataCaches[mc].task_deps[fn]
+            if fn + ":" + taskname not in taskData[mc].taskentries:
                 logger.warning("Task %s does not exist, invalidating this task will have no effect" % taskname)
             if 'nostamp' in taskdep and taskname in taskdep['nostamp']:
                 if error_nostamp:
@@ -857,33 +903,35 @@ class RunQueueData:
                     bb.debug(1, "Task %s is marked nostamp, cannot invalidate this task" % taskname)
             else:
                 logger.verbose("Invalidate task %s, %s", taskname, fn)
-                bb.parse.siggen.invalidate_task(taskname, self.dataCache, fn)
+                bb.parse.siggen.invalidate_task(taskname, self.dataCaches[mc], fn)
 
         self.init_progress_reporter.next_stage()
 
         # Invalidate task if force mode active
         if self.cooker.configuration.force:
-            for (fn, target) in self.target_pairs:
-                invalidate_task(fn, target, False)
+            for tid in self.target_tids:
+                invalidate_task(tid, False)
 
         # Invalidate task if invalidate mode active
         if self.cooker.configuration.invalidate_stamp:
-            for (fn, target) in self.target_pairs:
+            for tid in self.target_tids:
+                fn = fn_from_tid(tid)
                 for st in self.cooker.configuration.invalidate_stamp.split(','):
                     if not st.startswith("do_"):
                         st = "do_%s" % st
-                    invalidate_task(fn, st, True)
+                    invalidate_task(fn + ":" + st, True)
 
         self.init_progress_reporter.next_stage()
 
         # Create and print to the logs a virtual/xxxx -> PN (fn) table
-        virtmap = taskData.get_providermap(prefix="virtual/")
-        virtpnmap = {}
-        for v in virtmap:
-            virtpnmap[v] = self.dataCache.pkg_fn[virtmap[v]]
-            bb.debug(2, "%s resolved to: %s (%s)" % (v, virtpnmap[v], virtmap[v]))
-        if hasattr(bb.parse.siggen, "tasks_resolved"):
-            bb.parse.siggen.tasks_resolved(virtmap, virtpnmap, self.dataCache)
+        for mc in taskData:
+            virtmap = taskData[mc].get_providermap(prefix="virtual/")
+            virtpnmap = {}
+            for v in virtmap:
+                virtpnmap[v] = self.dataCaches[mc].pkg_fn[virtmap[v]]
+                bb.debug(2, "%s resolved to: %s (%s)" % (v, virtpnmap[v], virtmap[v]))
+            if hasattr(bb.parse.siggen, "tasks_resolved"):
+                bb.parse.siggen.tasks_resolved(virtmap, virtpnmap, self.dataCaches[mc])
 
         self.init_progress_reporter.next_stage()
 
@@ -898,13 +946,17 @@ class RunQueueData:
                     procdep = []
                     for dep in self.runtaskentries[tid].depends:
                         procdep.append(fn_from_tid(dep) + "." + taskname_from_tid(dep))
-                    self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(fn_from_tid(tid), taskname_from_tid(tid), procdep, self.dataCache)
+                    (mc, fn, taskname) = split_tid(tid)
+                    taskfn = taskfn_fromtid(tid)
+                    self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(taskfn, taskname, procdep, self.dataCaches[mc])
                     task = self.runtaskentries[tid].task
 
         bb.parse.siggen.writeout_file_checksum_cache()
+
+        #self.dump_data()
         return len(self.runtaskentries)
 
-    def dump_data(self, taskQueue):
+    def dump_data(self):
         """
         Dump some debug information on the internal data structures
         """
@@ -915,24 +967,17 @@ class RunQueueData:
                          self.runtaskentries[tid].depends,
                          self.runtaskentries[tid].revdeps)
 
-        logger.debug(3, "sorted_tasks:")
-        for tid in self.prio_map:
-            logger.debug(3, " %s: %s   Deps %s RevDeps %s", tid,
-                         self.runtaskentries[tid].weight,
-                         self.runtaskentries[tid].depends,
-                         self.runtaskentries[tid].revdeps)
-
 class RunQueueWorker():
     def __init__(self, process, pipe):
         self.process = process
         self.pipe = pipe
 
 class RunQueue:
-    def __init__(self, cooker, cfgData, dataCache, taskData, targets):
+    def __init__(self, cooker, cfgData, dataCaches, taskData, targets):
 
         self.cooker = cooker
         self.cfgData = cfgData
-        self.rqdata = RunQueueData(self, cooker, cfgData, dataCache, taskData, targets)
+        self.rqdata = RunQueueData(self, cooker, cfgData, dataCaches, taskData, targets)
 
         self.stamppolicy = cfgData.getVar("BB_STAMP_POLICY", True) or "perfile"
         self.hashvalidate = cfgData.getVar("BB_HASHCHECK_FUNCTION", True) or None
@@ -948,7 +993,7 @@ class RunQueue:
         self.worker = {}
         self.fakeworker = {}
 
-    def _start_worker(self, fakeroot = False, rqexec = None):
+    def _start_worker(self, mc, fakeroot = False, rqexec = None):
         logger.debug(1, "Starting bitbake-worker")
         magic = "decafbad"
         if self.cooker.configuration.profile:
@@ -971,10 +1016,10 @@ class RunQueue:
             runqhash[tid] = self.rqdata.runtaskentries[tid].hash
 
         workerdata = {
-            "taskdeps" : self.rqdata.dataCache.task_deps,
-            "fakerootenv" : self.rqdata.dataCache.fakerootenv,
-            "fakerootdirs" : self.rqdata.dataCache.fakerootdirs,
-            "fakerootnoenv" : self.rqdata.dataCache.fakerootnoenv,
+            "taskdeps" : self.rqdata.dataCaches[mc].task_deps,
+            "fakerootenv" : self.rqdata.dataCaches[mc].fakerootenv,
+            "fakerootdirs" : self.rqdata.dataCaches[mc].fakerootdirs,
+            "fakerootnoenv" : self.rqdata.dataCaches[mc].fakerootnoenv,
             "sigdata" : bb.parse.siggen.get_taskdata(),
             "runq_hash" : runqhash,
             "logdefaultdebug" : bb.msg.loggerDefaultDebugLevel,
@@ -1014,11 +1059,13 @@ class RunQueue:
         if self.worker:
             self.teardown_workers()
         self.teardown = False
-        self.worker[''] = self._start_worker()
+        for mc in self.rqdata.dataCaches:
+            self.worker[mc] = self._start_worker(mc)
 
     def start_fakeworker(self, rqexec):
         if not self.fakeworker:
-            self.fakeworker[''] = self._start_worker(True, rqexec)
+            for mc in self.rqdata.dataCaches:
+                self.fakeworker[mc] = self._start_worker(mc, True, rqexec)
 
     def teardown_workers(self):
         self.teardown = True
@@ -1052,26 +1099,27 @@ class RunQueue:
             except:
                 return None
 
+        (mc, fn, tn) = split_tid(tid)
+        taskfn = taskfn_fromtid(tid)
+        if taskname is None:
+            taskname = tn
+
         if self.stamppolicy == "perfile":
             fulldeptree = False
         else:
             fulldeptree = True
             stampwhitelist = []
             if self.stamppolicy == "whitelist":
-                stampwhitelist = self.rqdata.stampfnwhitelist
-
-        fn = fn_from_tid(tid)
-        if taskname is None:
-            taskname = taskname_from_tid(tid)
+                stampwhitelist = self.rqdata.stampfnwhitelist[mc]
 
-        stampfile = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
+        stampfile = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn)
 
         # If the stamp is missing, it's not current
         if not os.access(stampfile, os.F_OK):
             logger.debug(2, "Stampfile %s not available", stampfile)
             return False
         # If it's a 'nostamp' task, it's not current
-        taskdep = self.rqdata.dataCache.task_deps[fn]
+        taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
         if 'nostamp' in taskdep and taskname in taskdep['nostamp']:
             logger.debug(2, "%s.%s is nostamp\n", fn, taskname)
             return False
@@ -1086,10 +1134,10 @@ class RunQueue:
         t1 = get_timestamp(stampfile)
         for dep in self.rqdata.runtaskentries[tid].depends:
             if iscurrent:
-                fn2 = fn_from_tid(dep)
-                taskname2 = taskname_from_tid(dep)
-                stampfile2 = bb.build.stampfile(taskname2, self.rqdata.dataCache, fn2)
-                stampfile3 = bb.build.stampfile(taskname2 + "_setscene", self.rqdata.dataCache, fn2)
+                (mc2, fn2, taskname2) = split_tid(dep)
+                taskfn2 = taskfn_fromtid(dep)
+                stampfile2 = bb.build.stampfile(taskname2, self.rqdata.dataCaches[mc2], taskfn2)
+                stampfile3 = bb.build.stampfile(taskname2 + "_setscene", self.rqdata.dataCaches[mc2], taskfn2)
                 t2 = get_timestamp(stampfile2)
                 t3 = get_timestamp(stampfile3)
                 if t3 and not t2:
@@ -1195,10 +1243,11 @@ class RunQueue:
                 logger.info("Tasks Summary: Attempted %d tasks of which %d didn't need to be rerun and all succeeded.", self.rqexe.stats.completed, self.rqexe.stats.skipped)
 
         if self.state is runQueueFailed:
-            if not self.rqdata.taskData.tryaltconfigs:
-                raise bb.runqueue.TaskFailure(self.rqexe.failed_fns)
-            for fn in self.rqexe.failed_fns:
-                self.rqdata.taskData.fail_fn(fn)
+            if not self.rqdata.taskData[''].tryaltconfigs:
+                raise bb.runqueue.TaskFailure(self.rqexe.failed_tids)
+            for tid in self.rqexe.failed_tids:
+                (mc, fn, tn) = split_tid(tid)
+                self.rqdata.taskData[mc].fail_fn(fn)
             self.rqdata.reset()
 
         if self.state is runQueueComplete:
@@ -1245,13 +1294,14 @@ class RunQueue:
     def dump_signatures(self, options):
         done = set()
         bb.note("Reparsing files to collect dependency data")
+        bb_cache = bb.cache.NoCache(self.cooker.databuilder)
         for tid in self.rqdata.runtaskentries:
-            fn = fn_from_tid(tid)
+            fn = taskfn_fromtid(tid)
             if fn not in done:
-                the_data = bb.cache.Cache.loadDataFull(fn, self.cooker.collection.get_file_appends(fn), self.cooker.data)
+                the_data = bb_cache.loadDataFull(fn, self.cooker.collection.get_file_appends(fn))
                 done.add(fn)
 
-        bb.parse.siggen.dump_sigs(self.rqdata.dataCache, options)
+        bb.parse.siggen.dump_sigs(self.rqdata.dataCaches, options)
 
         return
 
@@ -1268,16 +1318,16 @@ class RunQueue:
         valid_new = set()
 
         for tid in self.rqdata.runtaskentries:
-            fn = fn_from_tid(tid)
-            taskname = taskname_from_tid(tid)
-            taskdep = self.rqdata.dataCache.task_deps[fn]
+            (mc, fn, taskname) = split_tid(tid)
+            taskfn = taskfn_fromtid(tid)
+            taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
 
             if 'noexec' in taskdep and taskname in taskdep['noexec']:
                 noexec.append(tid)
                 continue
 
             sq_fn.append(fn)
-            sq_hashfn.append(self.rqdata.dataCache.hashfn[fn])
+            sq_hashfn.append(self.rqdata.dataCaches[mc].hashfn[fn])
             sq_hash.append(self.rqdata.runtaskentries[tid].hash)
             sq_taskname.append(taskname)
             sq_task.append(tid)
@@ -1357,9 +1407,8 @@ class RunQueue:
 
 
         for tid in invalidtasks:
-            fn = fn_from_tid(tid)
-            pn = self.rqdata.dataCache.pkg_fn[fn]
-            taskname = taskname_from_tid(tid)
+            (mc, fn, taskname) = split_tid(tid)
+            pn = self.rqdata.dataCaches[mc].pkg_fn[fn]
             h = self.rqdata.runtaskentries[tid].hash
             matches = bb.siggen.find_siginfo(pn, taskname, [], self.cfgData)
             match = None
@@ -1392,7 +1441,7 @@ class RunQueueExecute:
 
         self.build_stamps = {}
         self.build_stamps2 = []
-        self.failed_fns = []
+        self.failed_tids = []
 
         self.stampcache = {}
 
@@ -1433,7 +1482,7 @@ class RunQueueExecute:
                 # worker must have died?
                 pass
 
-        if len(self.failed_fns) != 0:
+        if len(self.failed_tids) != 0:
             self.rq.state = runQueueFailed
             return
 
@@ -1448,7 +1497,7 @@ class RunQueueExecute:
             self.rq.read_workers()
             return self.rq.active_fds()
 
-        if len(self.failed_fns) != 0:
+        if len(self.failed_tids) != 0:
             self.rq.state = runQueueFailed
             return True
 
@@ -1462,9 +1511,8 @@ class RunQueueExecute:
         taskdata = {}
         taskdeps.add(task)
         for dep in taskdeps:
-            fn = fn_from_tid(dep)
-            pn = self.rqdata.dataCache.pkg_fn[fn]
-            taskname = taskname_from_tid(dep)
+            (mc, fn, taskname) = split_tid(dep)
+            pn = self.rqdata.dataCaches[mc].pkg_fn[fn]
             taskdata[dep] = [pn, taskname, fn]
         call = self.rq.depvalidate + "(task, taskdata, notneeded, d)"
         locs = { "task" : task, "taskdata" : taskdata, "notneeded" : self.scenequeue_notneeded, "d" : self.cooker.expanded_data }
@@ -1518,10 +1566,10 @@ class RunQueueExecuteTasks(RunQueueExecute):
             tasknames = {}
             fns = {}
             for tid in self.rqdata.runtaskentries:
-                fn = fn_from_tid(tid)
-                taskname = taskname_from_tid(tid)
-                taskdep = self.rqdata.dataCache.task_deps[fn]
-                fns[tid] = fn
+                (mc, fn, taskname) = split_tid(tid)
+                taskfn = taskfn_fromtid(tid)
+                taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
+                fns[tid] = taskfn
                 tasknames[tid] = taskname
                 if 'noexec' in taskdep and taskname in taskdep['noexec']:
                     continue
@@ -1538,9 +1586,10 @@ class RunQueueExecuteTasks(RunQueueExecute):
             covered_remove = bb.utils.better_eval(call, locs)
 
         def removecoveredtask(tid):
-            fn = fn_from_tid(tid)
-            taskname = taskname_from_tid(tid) + '_setscene'
-            bb.build.del_stamp(taskname, self.rqdata.dataCache, fn)
+            (mc, fn, taskname) = split_tid(tid)
+            taskname = taskname + '_setscene'
+            taskfn = taskfn_fromtid(tid)
+            bb.build.del_stamp(taskname, self.rqdata.dataCaches[mc], taskfn)
             self.rq.scenequeue_covered.remove(tid)
 
         toremove = covered_remove
@@ -1561,7 +1610,15 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
         logger.debug(1, 'Full skip list %s', self.rq.scenequeue_covered)
 
-        event.fire(bb.event.StampUpdate(self.rqdata.target_pairs, self.rqdata.dataCache.stamp), self.cfgData)
+
+        for mc in self.rqdata.dataCaches:
+            target_pairs = []
+            for tid in self.rqdata.target_tids:
+                (tidmc, fn, taskname) = split_tid(tid)
+                if tidmc == mc:
+                    target_pairs.append((fn, taskname))
+
+            event.fire(bb.event.StampUpdate(target_pairs, self.rqdata.dataCaches[mc].stamp), self.cfgData)
 
         schedulers = self.get_schedulers()
         for scheduler in schedulers:
@@ -1632,10 +1689,9 @@ class RunQueueExecuteTasks(RunQueueExecute):
         Updates the state engine with the failure
         """
         self.stats.taskFailed()
-        fn = fn_from_tid(task)
-        self.failed_fns.append(fn)
+        self.failed_tids.append(task)
         bb.event.fire(runQueueTaskFailed(task, self.stats, exitcode, self.rq), self.cfgData)
-        if self.rqdata.taskData.abort:
+        if self.rqdata.taskData[''].abort:
             self.rq.state = runQueueCleanUp
 
     def task_skip(self, task, reason):
@@ -1703,8 +1759,8 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
         task = self.sched.next()
         if task is not None:
-            fn = fn_from_tid(task)
-            taskname = taskname_from_tid(task)
+            (mc, fn, taskname) = split_tid(task)
+            taskfn = taskfn_fromtid(task)
 
             if task in self.rq.scenequeue_covered:
                 logger.debug(2, "Setscene covered task %s", task)
@@ -1717,7 +1773,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 self.task_skip(task, "existing")
                 return True
 
-            taskdep = self.rqdata.dataCache.task_deps[fn]
+            taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
             if 'noexec' in taskdep and taskname in taskdep['noexec']:
                 startevent = runQueueTaskStarted(task, self.stats, self.rq,
                                                  noexec=True)
@@ -1725,7 +1781,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 self.runq_running.add(task)
                 self.stats.taskActive()
                 if not self.cooker.configuration.dry_run:
-                    bb.build.make_stamp(taskname, self.rqdata.dataCache, fn)
+                    bb.build.make_stamp(taskname, self.rqdata.dataCaches[mc], taskfn)
                 self.task_complete(task)
                 return True
             else:
@@ -1734,7 +1790,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
             taskdepdata = self.build_taskdepdata(task)
 
-            taskdep = self.rqdata.dataCache.task_deps[fn]
+            taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
                 if not self.rq.fakeworker:
                     try:
@@ -1743,13 +1799,13 @@ class RunQueueExecuteTasks(RunQueueExecute):
                         logger.critical("Failed to spawn fakeroot worker to run %s: %s" % (task, str(exc)))
                         self.rq.state = runQueueFailed
                         return True
-                self.rq.fakeworker[''].process.stdin.write(b"<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn), taskdepdata)) + b"</runtask>")
-                self.rq.fakeworker[''].process.stdin.flush()
+                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, False, self.cooker.collection.get_file_appends(fn), taskdepdata)) + b"</runtask>")
+                self.rq.fakeworker[mc].process.stdin.flush()
             else:
-                self.rq.worker[''].process.stdin.write(b"<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn), taskdepdata)) + b"</runtask>")
-                self.rq.worker[''].process.stdin.flush()
+                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, False, self.cooker.collection.get_file_appends(taskfn), taskdepdata)) + b"</runtask>")
+                self.rq.worker[mc].process.stdin.flush()
 
-            self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
+            self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn)
             self.build_stamps2.append(self.build_stamps[task])
             self.runq_running.add(task)
             self.stats.taskActive()
@@ -1760,7 +1816,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
             self.rq.read_workers()
             return self.rq.active_fds()
 
-        if len(self.failed_fns) != 0:
+        if len(self.failed_tids) != 0:
             self.rq.state = runQueueFailed
             return True
 
@@ -1783,11 +1839,11 @@ class RunQueueExecuteTasks(RunQueueExecute):
         while next:
             additional = []
             for revdep in next:
-                fn = fn_from_tid(revdep)
-                pn = self.rqdata.dataCache.pkg_fn[fn]
-                taskname = taskname_from_tid(revdep)
+                (mc, fn, taskname) = split_tid(revdep)
+                taskfn = taskfn_fromtid(revdep)
+                pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
                 deps = self.rqdata.runtaskentries[revdep].depends
-                provides = self.rqdata.dataCache.fn_provides[fn]
+                provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
                 taskdepdata[revdep] = [pn, taskname, fn, deps, provides]
                 for revdep2 in deps:
                     if revdep2 not in taskdepdata:
@@ -1940,14 +1996,15 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         # e.g. do_sometask_setscene[depends] = "targetname:do_someothertask_setscene"
         # Note that anything explicitly depended upon will have its reverse dependencies removed to avoid circular dependencies
         for tid in self.rqdata.runq_setscene_tids:
-                realtid = tid + "_setscene"
-                idepends = self.rqdata.taskData.taskentries[realtid].idepends
+                (mc, fn, taskname) = split_tid(tid)
+                realtid = fn + ":" + taskname + "_setscene"
+                idepends = self.rqdata.taskData[mc].taskentries[realtid].idepends
                 for (depname, idependtask) in idepends:
 
-                    if depname not in self.rqdata.taskData.build_targets:
+                    if depname not in self.rqdata.taskData[mc].build_targets:
                         continue
 
-                    depfn = self.rqdata.taskData.build_targets[depname][0]
+                    depfn = self.rqdata.taskData[mc].build_targets[depname][0]
                     if depfn is None:
                          continue
                     deptid = depfn + ":" + idependtask.replace("_setscene", "")
@@ -2001,15 +2058,15 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             noexec = []
             stamppresent = []
             for tid in self.sq_revdeps:
-                fn = fn_from_tid(tid)
-                taskname = taskname_from_tid(tid)
+                (mc, fn, taskname) = split_tid(tid)
+                taskfn = taskfn_fromtid(tid)
 
-                taskdep = self.rqdata.dataCache.task_deps[fn]
+                taskdep = self.rqdata.dataCaches[mc].task_deps[fn]
 
                 if 'noexec' in taskdep and taskname in taskdep['noexec']:
                     noexec.append(tid)
                     self.task_skip(tid)
-                    bb.build.make_stamp(taskname + "_setscene", self.rqdata.dataCache, fn)
+                    bb.build.make_stamp(taskname + "_setscene", self.rqdata.dataCaches[mc], taskfn)
                     continue
 
                 if self.rq.check_stamp_task(tid, taskname + "_setscene", cache=self.stampcache):
@@ -2025,7 +2082,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                     continue
 
                 sq_fn.append(fn)
-                sq_hashfn.append(self.rqdata.dataCache.hashfn[fn])
+                sq_hashfn.append(self.rqdata.dataCaches[mc].hashfn[fn])
                 sq_hash.append(self.rqdata.runtaskentries[tid].hash)
                 sq_taskname.append(taskname)
                 sq_task.append(tid)
@@ -2126,10 +2183,9 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                     if nexttask not in self.unskippable and len(self.sq_revdeps[nexttask]) > 0 and self.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sq_revdeps[nexttask], True):
                         fn = fn_from_tid(nexttask)
                         foundtarget = False
-                        for target in self.rqdata.target_pairs:
-                            if target[0] == fn and target[1] == taskname_from_tid(nexttask):
-                                foundtarget = True
-                                break
+
+                        if nexttask in self.rqdata.target_tids:
+                            foundtarget = True
                         if not foundtarget:
                             logger.debug(2, "Skipping setscene for task %s" % nexttask)
                             self.task_skip(nexttask)
@@ -2141,18 +2197,18 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                     task = nexttask
                     break
         if task is not None:
-            fn = fn_from_tid(task)
-            taskname = taskname_from_tid(task) + "_setscene"
+            (mc, fn, taskname) = split_tid(task)
+            taskfn = taskfn_fromtid(task)
+            taskname = taskname + "_setscene"
             if self.rq.check_stamp_task(task, taskname_from_tid(task), recurse = True, cache=self.stampcache):
                 logger.debug(2, 'Stamp for underlying task %s is current, so skipping setscene variant', task)
                 self.task_failoutright(task)
                 return True
 
             if self.cooker.configuration.force:
-                for target in self.rqdata.target_pairs:
-                    if target[0] == fn and target[1] == taskname_from_tid(task):
-                        self.task_failoutright(task)
-                        return True
+                if task in self.rqdata.target_tids:
+                    self.task_failoutright(task)
+                    return True
 
             if self.rq.check_stamp_task(task, taskname, cache=self.stampcache):
                 logger.debug(2, 'Setscene stamp current task %s, so skip it and its dependencies', task)
@@ -2162,15 +2218,15 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             startevent = sceneQueueTaskStarted(task, self.stats, self.rq)
             bb.event.fire(startevent, self.cfgData)
 
-            taskdep = self.rqdata.dataCache.task_deps[fn]
+            taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
                 if not self.rq.fakeworker:
                     self.rq.start_fakeworker(self)
-                self.rq.fakeworker[''].process.stdin.write(b"<runtask>" + pickle.dumps((fn, task, taskname, True, self.cooker.collection.get_file_appends(fn), None)) + b"</runtask>")
-                self.rq.fakeworker[''].process.stdin.flush()
+                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, True, self.cooker.collection.get_file_appends(taskfn), None)) + b"</runtask>")
+                self.rq.fakeworker[mc].process.stdin.flush()
             else:
-                self.rq.worker[''].process.stdin.write(b"<runtask>" + pickle.dumps((fn, task, taskname, True, self.cooker.collection.get_file_appends(fn), None)) + b"</runtask>")
-                self.rq.worker[''].process.stdin.flush()
+                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, True, self.cooker.collection.get_file_appends(taskfn), None)) + b"</runtask>")
+                self.rq.worker[mc].process.stdin.flush()
 
             self.runq_running.add(task)
             self.stats.taskActive()
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index eba465a..a46cdcf 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -144,8 +144,9 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
     def finalise(self, fn, d, variant):
 
-        if variant:
-            fn = "virtual:" + variant + ":" + fn
+        mc = d.getVar("__BBMULTICONFIG", False) or ""
+        if variant or mc:
+            fn = bb.cache.realfn2virtual(fn, variant, mc)
 
         try:
             taskdeps = self._build_data(fn, d)
@@ -300,16 +301,18 @@ class SignatureGeneratorBasic(SignatureGenerator):
             if computed_taskhash != self.taskhash[k]:
                 bb.error("Taskhash mismatch %s versus %s for %s" % (computed_taskhash, self.taskhash[k], k))
 
-    def dump_sigs(self, dataCache, options):
+    def dump_sigs(self, dataCaches, options):
         for fn in self.taskdeps:
             for task in self.taskdeps[fn]:
+                tid = fn + ":" + task
+                (mc, _, _) = bb.runqueue.split_tid(tid)
                 k = fn + "." + task
                 if k not in self.taskhash:
                     continue
-                if dataCache.basetaskhash[k] != self.basehash[k]:
+                if dataCaches[mc].basetaskhash[k] != self.basehash[k]:
                     bb.error("Bitbake's cached basehash does not match the one we just generated (%s)!" % k)
-                    bb.error("The mismatched hashes were %s and %s" % (dataCache.basetaskhash[k], self.basehash[k]))
-                self.dump_sigtask(fn, task, dataCache.stamp[fn], True)
+                    bb.error("The mismatched hashes were %s and %s" % (dataCaches[mc].basetaskhash[k], self.basehash[k]))
+                self.dump_sigtask(fn, task, dataCaches[mc].stamp[fn], True)
 
 class SignatureGeneratorBasicHash(SignatureGeneratorBasic):
     name = "basichash"
diff --git a/bitbake/lib/bb/tinfoil.py b/bitbake/lib/bb/tinfoil.py
index 7aa653f..95608ae 100644
--- a/bitbake/lib/bb/tinfoil.py
+++ b/bitbake/lib/bb/tinfoil.py
@@ -74,13 +74,13 @@ class Tinfoil:
         self.logger.setLevel(logging.INFO)
         sys.stderr.write("done.\n")
 
-        self.cooker_data = self.cooker.recipecache
+        self.cooker_data = self.cooker.recipecaches['']
 
     def prepare(self, config_only = False):
         if not self.cooker_data:
             if config_only:
                 self.cooker.parseConfiguration()
-                self.cooker_data = self.cooker.recipecache
+                self.cooker_data = self.cooker.recipecaches['']
             else:
                 self.parseRecipes()
 




