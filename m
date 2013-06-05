Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 463DC60881
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Jun 2013 14:27:40 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r55EWXXv010542 for <bitbake-devel@lists.openembedded.org>;
	Wed, 5 Jun 2013 15:32:33 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 7xiDO2zgd5db for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Jun 2013 15:32:33 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r55EWRhQ010515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Wed, 5 Jun 2013 15:32:28 +0100
Message-ID: <1370442444.1640.55.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 05 Jun 2013 15:27:24 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cooker: Split data from configuration
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 05 Jun 2013 14:27:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Stashing the data store within the configuration data is rather ugly and
leads to problems trying to pickle just the configuration for example.

The reasons for combining these objects is ancient history, it makes
sense to clean things up and separate them out now. This follows non
logically from the configuration cleansups and leads well into the
bitbake-worker changes.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
This patch is a prerequisite for the bitbake-worker changes but I'd
forgotten about it

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index cc6a981..ab69501 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -116,11 +116,11 @@ class Command:
 
     def finishAsyncCommand(self, msg=None, code=None):
         if msg:
-            bb.event.fire(CommandFailed(msg), self.cooker.configuration.event_data)
+            bb.event.fire(CommandFailed(msg), self.cooker.event_data)
         elif code:
-            bb.event.fire(CommandExit(code), self.cooker.configuration.event_data)
+            bb.event.fire(CommandExit(code), self.cooker.event_data)
         else:
-            bb.event.fire(CommandCompleted(), self.cooker.configuration.event_data)
+            bb.event.fire(CommandCompleted(), self.cooker.event_data)
         self.currentAsyncCommand = None
 
 
@@ -145,22 +145,22 @@ class CommandsSync:
 
     def getVariable(self, command, params):
         """
-        Read the value of a variable from configuration.data
+        Read the value of a variable from data
         """
         varname = params[0]
         expand = True
         if len(params) > 1:
             expand = params[1]
 
-        return command.cooker.configuration.data.getVar(varname, expand)
+        return command.cooker.data.getVar(varname, expand)
 
     def setVariable(self, command, params):
         """
-        Set the value of variable in configuration.data
+        Set the value of variable in data
         """
         varname = params[0]
         value = str(params[1])
-        command.cooker.configuration.data.setVar(varname, value)
+        command.cooker.data.setVar(varname, value)
 
     def setConfig(self, command, params):
         """
@@ -375,7 +375,7 @@ class CommandsAsync:
         """
         Parse the .bb files
         """
-        if bb.fetch.fetcher_compare_revisions(command.cooker.configuration.data):
+        if bb.fetch.fetcher_compare_revisions(command.cooker.data):
             command.finishAsyncCommand(code=1)
         else:
             command.finishAsyncCommand()
@@ -398,7 +398,7 @@ class CommandsAsync:
         Trigger a certain event
         """
         event = params[0]
-        bb.event.fire(eval(event), command.cooker.configuration.data)
+        bb.event.fire(eval(event), command.cooker.data)
         command.currentAsyncCommand = None
     triggerEvent.needcache = False
 
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 2edfa9f..77273dc 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -108,13 +108,13 @@ class BBCooker:
                 logger.critical("Unable to import extra RecipeInfo '%s' from '%s': %s" % (cache_name, module_name, exc))
                 sys.exit("FATAL: Failed to import extra cache class '%s'." % cache_name)
 
-        self.configuration.data = None
+        self.data = None
         self.initConfigurationData()
         self.loadConfigurationData()
 
         # Take a lock so only one copy of bitbake can run against a given build
         # directory at a time
-        lockfile = self.configuration.data.expand("${TOPDIR}/bitbake.lock")
+        lockfile = self.data.expand("${TOPDIR}/bitbake.lock")
         self.lock = bb.utils.lockfile(lockfile, False, False)
         if not self.lock:
             bb.fatal("Only one copy of bitbake should be run against a build directory")
@@ -122,9 +122,9 @@ class BBCooker:
         #
         # Special updated configuration we use for firing events
         #
-        self.configuration.event_data = bb.data.createCopy(self.configuration.data)
-        bb.data.update_data(self.configuration.event_data)
-        bb.parse.init_parser(self.configuration.event_data)
+        self.event_data = bb.data.createCopy(self.data)
+        bb.data.update_data(self.event_data)
+        bb.parse.init_parser(self.event_data)
 
         # TOSTOP must not be set or our children will hang when they output
         fd = sys.stdout.fileno()
@@ -147,27 +147,27 @@ class BBCooker:
             worker = True
 
         self.databuilder = bb.cookerdata.CookerDataBuilder(self.configuration, worker)
-        self.configuration.data = self.databuilder.data
+        self.data = self.databuilder.data
 
     def enableDataTracking(self):
-        self.configuration.data.enableTracking()
+        self.data.enableTracking()
 
     def disableDataTracking(self):
-        self.configuration.data.disableTracking()
+        self.data.disableTracking()
 
     def loadConfigurationData(self):
         self.databuilder.parseBaseConfiguration()
-        self.configuration.data = self.databuilder.data
-        self.configuration.data_hash = self.databuilder.data_hash
+        self.data = self.databuilder.data
+        self.data_hash = self.databuilder.data_hash
 
     def saveConfigurationVar(self, var, val, default_file):
 
         replaced = False
         #do not save if nothing changed
-        if str(val) == self.configuration.data.getVar(var):
+        if str(val) == self.data.getVar(var):
             return
 
-        conf_files = self.configuration.data.varhistory.get_variable_files(var)
+        conf_files = self.data.varhistory.get_variable_files(var)
 
         #format the value when it is a list
         if isinstance(val, list):
@@ -176,7 +176,7 @@ class BBCooker:
                 listval += "%s   " % value
             val = listval
 
-        topdir = self.configuration.data.getVar("TOPDIR")
+        topdir = self.data.getVar("TOPDIR")
 
         #comment or replace operations made on var
         for conf_file in conf_files:
@@ -185,7 +185,7 @@ class BBCooker:
                     contents = f.readlines()
                 f.close()
 
-                lines = self.configuration.data.varhistory.get_variable_lines(var, conf_file)
+                lines = self.data.varhistory.get_variable_lines(var, conf_file)
                 for line in lines:
                     total = ""
                     i = 0
@@ -218,7 +218,7 @@ class BBCooker:
 
         if replaced == False:
             #remove var from history
-            self.configuration.data.varhistory.del_var_history(var)
+            self.data.varhistory.del_var_history(var)
 
             #add var to the end of default_file
             default_file = bb.cookerdata.findConfigFile(default_file)
@@ -241,17 +241,17 @@ class BBCooker:
 
             #add to history
             loginfo = {"op":set, "file":default_file, "line":total.count("\n")}
-            self.configuration.data.setVar(var, val, **loginfo)
+            self.data.setVar(var, val, **loginfo)
 
     def parseConfiguration(self):
 
         # Set log file verbosity
-        verboselogs = bb.utils.to_boolean(self.configuration.data.getVar("BB_VERBOSE_LOGS", "0"))
+        verboselogs = bb.utils.to_boolean(self.data.getVar("BB_VERBOSE_LOGS", "0"))
         if verboselogs:
             bb.msg.loggerVerboseLogs = True
 
         # Change nice level if we're asked to
-        nice = self.configuration.data.getVar("BB_NICE_LEVEL", True)
+        nice = self.data.getVar("BB_NICE_LEVEL", True)
         if nice:
             curnice = os.nice(0)
             nice = int(nice) - curnice
@@ -261,7 +261,7 @@ class BBCooker:
             del self.recipecache
         self.recipecache = bb.cache.CacheData(self.caches_array)
 
-        self.handleCollections( self.configuration.data.getVar("BBFILE_COLLECTIONS", True) )
+        self.handleCollections( self.data.getVar("BBFILE_COLLECTIONS", True) )
 
     def runCommands(self, server, data, abort):
         """
@@ -275,7 +275,7 @@ class BBCooker:
     def showVersions(self):
 
         pkg_pn = self.recipecache.pkg_pn
-        (latest_versions, preferred_versions) = bb.providers.findProviders(self.configuration.data, self.recipecache, pkg_pn)
+        (latest_versions, preferred_versions) = bb.providers.findProviders(self.data, self.recipecache, pkg_pn)
 
         logger.plain("%-35s %25s %25s", "Recipe Name", "Latest Version", "Preferred Version")
         logger.plain("%-35s %25s %25s\n", "===========", "==============", "=================")
@@ -308,11 +308,11 @@ class BBCooker:
             fn = self.matchFile(fn)
             fn = bb.cache.Cache.realfn2virtual(fn, cls)
         elif len(pkgs_to_build) == 1:
-            ignore = self.configuration.data.getVar("ASSUME_PROVIDED", True) or ""
+            ignore = self.data.getVar("ASSUME_PROVIDED", True) or ""
             if pkgs_to_build[0] in set(ignore.split()):
                 bb.fatal("%s is in ASSUME_PROVIDED" % pkgs_to_build[0])
 
-            localdata = data.createCopy(self.configuration.data)
+            localdata = data.createCopy(self.data)
             bb.data.update_data(localdata)
             bb.data.expandKeys(localdata)
 
@@ -324,18 +324,18 @@ class BBCooker:
             fnid = taskdata.build_targets[targetid][0]
             fn = taskdata.fn_index[fnid]
         else:
-            envdata = self.configuration.data
+            envdata = self.data
 
         if fn:
             try:
-                envdata = bb.cache.Cache.loadDataFull(fn, self.collection.get_file_appends(fn), self.configuration.data)
+                envdata = bb.cache.Cache.loadDataFull(fn, self.collection.get_file_appends(fn), self.data)
             except Exception as e:
                 parselog.exception("Unable to read %s", fn)
                 raise
 
         # Display history
         with closing(StringIO()) as env:
-            self.configuration.data.inchistory.emit(env)
+            self.data.inchistory.emit(env)
             logger.plain(env.getvalue())
 
         # emit variables and shell functions
@@ -354,7 +354,7 @@ class BBCooker:
         """
         Prepare a runqueue and taskdata object for iteration over pkgs_to_build
         """
-        bb.event.fire(bb.event.TreeDataPreparationStarted(), self.configuration.data)
+        bb.event.fire(bb.event.TreeDataPreparationStarted(), self.data)
 
         # If we are told to do the None task then query the default task
         if (task == None):
@@ -362,7 +362,7 @@ class BBCooker:
 
         pkgs_to_build = self.checkPackages(pkgs_to_build)
 
-        localdata = data.createCopy(self.configuration.data)
+        localdata = data.createCopy(self.data)
         bb.data.update_data(localdata)
         bb.data.expandKeys(localdata)
         # We set abort to False here to prevent unbuildable targets raising
@@ -375,9 +375,9 @@ class BBCooker:
             taskdata.add_provider(localdata, self.recipecache, k)
             runlist.append([k, "do_%s" % task])
             current += 1
-            bb.event.fire(bb.event.TreeDataPreparationProgress(current, len(pkgs_to_build)), self.configuration.data)
+            bb.event.fire(bb.event.TreeDataPreparationProgress(current, len(pkgs_to_build)), self.data)
         taskdata.add_unresolved(localdata, self.recipecache)
-        bb.event.fire(bb.event.TreeDataPreparationCompleted(len(pkgs_to_build)), self.configuration.data)
+        bb.event.fire(bb.event.TreeDataPreparationCompleted(len(pkgs_to_build)), self.data)
         return runlist, taskdata
     
     ######## WARNING : this function requires cache_extra to be enabled ########
@@ -388,7 +388,7 @@ class BBCooker:
         information.
         """
         runlist, taskdata = self.prepareTreeData(pkgs_to_build, task)
-        rq = bb.runqueue.RunQueue(self, self.configuration.data, self.recipecache, taskdata, runlist)
+        rq = bb.runqueue.RunQueue(self, self.data, self.recipecache, taskdata, runlist)
         rq.rqdata.prepare()
 
         seen_fnids = []
@@ -543,7 +543,7 @@ class BBCooker:
         Generate an event with the result
         """
         depgraph = self.generateTaskDepTreeData(pkgs_to_build, task)
-        bb.event.fire(bb.event.DepTreeGenerated(depgraph), self.configuration.data)
+        bb.event.fire(bb.event.DepTreeGenerated(depgraph), self.data)
 
     def generateDotGraphFiles(self, pkgs_to_build, task):
         """
@@ -621,7 +621,7 @@ class BBCooker:
                            for append in appends)
             msg = 'No recipes available for:\n%s' % '\n'.join(appendlines)
             warn_only = data.getVar("BB_DANGLINGAPPENDS_WARNONLY", \
-                 self.configuration.data, False) or "no"
+                 self.data, False) or "no"
             if warn_only.lower() in ("1", "yes", "true"):
                 bb.warn(msg)
             else:
@@ -629,7 +629,7 @@ class BBCooker:
 
     def handlePrefProviders(self):
 
-        localdata = data.createCopy(self.configuration.data)
+        localdata = data.createCopy(self.data)
         bb.data.update_data(localdata)
         bb.data.expandKeys(localdata)
 
@@ -645,7 +645,7 @@ class BBCooker:
             self.recipecache.preferred[providee] = provider
 
     def findCoreBaseFiles(self, subdir, configfile):
-        corebase = self.configuration.data.getVar('COREBASE', True) or ""
+        corebase = self.data.getVar('COREBASE', True) or ""
         paths = []
         for root, dirs, files in os.walk(corebase + '/' + subdir):
             for d in dirs:
@@ -654,7 +654,7 @@ class BBCooker:
                     paths.append(os.path.join(root, d))
 
         if paths:
-            bb.event.fire(bb.event.CoreBaseFilesFound(paths), self.configuration.data)
+            bb.event.fire(bb.event.CoreBaseFilesFound(paths), self.data)
 
     def findConfigFilePath(self, configfile):
         """
@@ -668,8 +668,8 @@ class BBCooker:
         # Generate a list of parsed configuration files by searching the files
         # listed in the __depends and __base_depends variables with a .conf suffix.
         conffiles = []
-        dep_files = self.configuration.data.getVar('__base_depends') or []
-        dep_files = dep_files + (self.configuration.data.getVar('__depends') or [])
+        dep_files = self.data.getVar('__base_depends') or []
+        dep_files = dep_files + (self.data.getVar('__depends') or [])
 
         for f in dep_files:
             if f[0].endswith(".conf"):
@@ -682,7 +682,7 @@ class BBCooker:
         for cfg in conffiles:
             if cfg.endswith(match):
                 bb.event.fire(bb.event.ConfigFilePathFound(path),
-                              self.configuration.data)
+                              self.data)
                 break
 
     def findFilesMatchingInDir(self, filepattern, directory):
@@ -697,7 +697,7 @@ class BBCooker:
 
         matches = []
         p = re.compile(re.escape(filepattern))
-        bbpaths = self.configuration.data.getVar('BBPATH', True).split(':')
+        bbpaths = self.data.getVar('BBPATH', True).split(':')
         for path in bbpaths:
             dirpath = os.path.join(path, directory)
             if os.path.exists(dirpath):
@@ -707,7 +707,7 @@ class BBCooker:
                             matches.append(f)
 
         if matches:
-            bb.event.fire(bb.event.FilesMatchingFound(filepattern, matches), self.configuration.data)
+            bb.event.fire(bb.event.FilesMatchingFound(filepattern, matches), self.data)
 
     def findConfigFiles(self, varname):
         """
@@ -717,7 +717,7 @@ class BBCooker:
         possible = []
         var = varname.lower()
 
-        data = self.configuration.data
+        data = self.data
         # iterate configs
         bbpaths = data.getVar('BBPATH', True).split(':')
         for path in bbpaths:
@@ -731,7 +731,7 @@ class BBCooker:
                             possible.append(val)
 
         if possible:
-            bb.event.fire(bb.event.ConfigFilesFound(var, possible), self.configuration.data)
+            bb.event.fire(bb.event.ConfigFilesFound(var, possible), self.data)
 
     def findInheritsClass(self, klass):
         """
@@ -762,7 +762,7 @@ class BBCooker:
 
         # generate a dependency tree for all our packages
         tree = self.generatePkgDepTreeData(pkgs, 'build')
-        bb.event.fire(bb.event.TargetsTreeGenerated(tree), self.configuration.data)
+        bb.event.fire(bb.event.TargetsTreeGenerated(tree), self.data)
 
     def buildWorldTargetList(self):
         """
@@ -808,7 +808,7 @@ class BBCooker:
             min_prio = 0
             for c in collection_list:
                 # Get collection priority if defined explicitly
-                priority = self.configuration.data.getVar("BBFILE_PRIORITY_%s" % c, True)
+                priority = self.data.getVar("BBFILE_PRIORITY_%s" % c, True)
                 if priority:
                     try:
                         prio = int(priority)
@@ -822,7 +822,7 @@ class BBCooker:
                     collection_priorities[c] = None
 
                 # Check dependencies and store information for priority calculation
-                deps = self.configuration.data.getVar("LAYERDEPENDS_%s" % c, True)
+                deps = self.data.getVar("LAYERDEPENDS_%s" % c, True)
                 if deps:
                     depnamelist = []
                     deplist = deps.split()
@@ -842,7 +842,7 @@ class BBCooker:
 
                         if dep in collection_list:
                             if depver:
-                                layerver = self.configuration.data.getVar("LAYERVERSION_%s" % dep, True)
+                                layerver = self.data.getVar("LAYERVERSION_%s" % dep, True)
                                 if layerver:
                                     try:
                                         lver = int(layerver)
@@ -879,7 +879,7 @@ class BBCooker:
             # Calculate all layer priorities using calc_layer_priority and store in bbfile_config_priorities
             for c in collection_list:
                 calc_layer_priority(c)
-                regex = self.configuration.data.getVar("BBFILE_PATTERN_%s" % c, True)
+                regex = self.data.getVar("BBFILE_PATTERN_%s" % c, True)
                 if regex == None:
                     parselog.error("BBFILE_PATTERN_%s not defined" % c)
                     errors = True
@@ -899,9 +899,9 @@ class BBCooker:
         """
         Setup any variables needed before starting a build
         """
-        if not self.configuration.data.getVar("BUILDNAME"):
-            self.configuration.data.setVar("BUILDNAME", time.strftime('%Y%m%d%H%M'))
-        self.configuration.data.setVar("BUILDSTART", time.strftime('%m/%d/%Y %H:%M:%S', time.gmtime()))
+        if not self.data.getVar("BUILDNAME"):
+            self.data.setVar("BUILDNAME", time.strftime('%Y%m%d%H%M'))
+        self.data.setVar("BUILDSTART", time.strftime('%m/%d/%Y %H:%M:%S', time.gmtime()))
 
     def matchFiles(self, bf):
         """
@@ -911,7 +911,7 @@ class BBCooker:
             bf = os.path.abspath(bf)
 
         self.collection = CookerCollectFiles(self.recipecache.bbfile_config_priorities)
-        filelist, masked = self.collection.collect_bbfiles(self.configuration.data, self.configuration.event_data)
+        filelist, masked = self.collection.collect_bbfiles(self.data, self.event_data)
         try:
             os.stat(bf)
             bf = os.path.abspath(bf)
@@ -966,7 +966,7 @@ class BBCooker:
 
         self.recipecache = bb.cache.CacheData(self.caches_array)
         infos = bb.cache.Cache.parse(fn, self.collection.get_file_appends(fn), \
-                                     self.configuration.data,
+                                     self.data,
                                      self.caches_array)
         infos = dict(infos)
 
@@ -999,15 +999,15 @@ class BBCooker:
 
         # Setup taskdata structure
         taskdata = bb.taskdata.TaskData(self.configuration.abort)
-        taskdata.add_provider(self.configuration.data, self.recipecache, item)
+        taskdata.add_provider(self.data, self.recipecache, item)
 
-        buildname = self.configuration.data.getVar("BUILDNAME")
-        bb.event.fire(bb.event.BuildStarted(buildname, [item]), self.configuration.event_data)
+        buildname = self.data.getVar("BUILDNAME")
+        bb.event.fire(bb.event.BuildStarted(buildname, [item]), self.event_data)
 
         # Execute the runqueue
         runlist = [[item, "do_%s" % task]]
 
-        rq = bb.runqueue.RunQueue(self, self.configuration.data, self.recipecache, taskdata, runlist)
+        rq = bb.runqueue.RunQueue(self, self.data, self.recipecache, taskdata, runlist)
 
         def buildFileIdle(server, rq, abort):
 
@@ -1026,7 +1026,7 @@ class BBCooker:
                 return False
 
             if not retval:
-                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, item, failures), self.configuration.event_data)
+                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, item, failures), self.event_data)
                 self.command.finishAsyncCommand()
                 return False
             if retval is True:
@@ -1063,7 +1063,7 @@ class BBCooker:
                 return False
 
             if not retval:
-                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, targets, failures), self.configuration.data)
+                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, targets, failures), self.data)
                 self.command.finishAsyncCommand()
                 return False
             if retval is True:
@@ -1072,10 +1072,10 @@ class BBCooker:
 
         self.buildSetVars()
 
-        buildname = self.configuration.data.getVar("BUILDNAME")
-        bb.event.fire(bb.event.BuildStarted(buildname, targets), self.configuration.data)
+        buildname = self.data.getVar("BUILDNAME")
+        bb.event.fire(bb.event.BuildStarted(buildname, targets), self.data)
 
-        localdata = data.createCopy(self.configuration.data)
+        localdata = data.createCopy(self.data)
         bb.data.update_data(localdata)
         bb.data.expandKeys(localdata)
 
@@ -1087,7 +1087,7 @@ class BBCooker:
             runlist.append([k, "do_%s" % task])
         taskdata.add_unresolved(localdata, self.recipecache)
 
-        rq = bb.runqueue.RunQueue(self, self.configuration.data, self.recipecache, taskdata, runlist)
+        rq = bb.runqueue.RunQueue(self, self.data, self.recipecache, taskdata, runlist)
         if universe:
             rq.rqdata.warn_multi_bb = True
 
@@ -1123,16 +1123,16 @@ class BBCooker:
         if self.state != state.parsing:
             self.parseConfiguration ()
 
-            ignore = self.configuration.data.getVar("ASSUME_PROVIDED", True) or ""
+            ignore = self.data.getVar("ASSUME_PROVIDED", True) or ""
             self.recipecache.ignored_dependencies = set(ignore.split())
 
             for dep in self.configuration.extra_assume_provided:
                 self.recipecache.ignored_dependencies.add(dep)
 
             self.collection = CookerCollectFiles(self.recipecache.bbfile_config_priorities)
-            (filelist, masked) = self.collection.collect_bbfiles(self.configuration.data, self.configuration.event_data)
+            (filelist, masked) = self.collection.collect_bbfiles(self.data, self.event_data)
 
-            self.configuration.data.renameVar("__depends", "__base_depends")
+            self.data.renameVar("__depends", "__base_depends")
 
             self.parser = CookerParser(self, filelist, masked)
             self.state = state.parsing
@@ -1177,14 +1177,14 @@ class BBCooker:
         # necessary from the data store.
         #bb.utils.empty_environment()
         try:
-            prserv.serv.auto_start(self.configuration.data)
+            prserv.serv.auto_start(self.data)
         except prserv.serv.PRServiceConfigError:
-            bb.event.fire(CookerExit(), self.configuration.event_data)
+            bb.event.fire(CookerExit(), self.event_data)
         return
 
     def post_serve(self):
-        prserv.serv.auto_shutdown(self.configuration.data)
-        bb.event.fire(CookerExit(), self.configuration.event_data)
+        prserv.serv.auto_shutdown(self.data)
+        bb.event.fire(CookerExit(), self.event_data)
 
     def shutdown(self):
         self.state = state.shutdown
@@ -1490,8 +1490,8 @@ class CookerParser(object):
     def __init__(self, cooker, filelist, masked):
         self.filelist = filelist
         self.cooker = cooker
-        self.cfgdata = cooker.configuration.data
-        self.cfghash = cooker.configuration.data_hash
+        self.cfgdata = cooker.data
+        self.cfghash = cooker.data_hash
 
         # Accounting statistics
         self.parsed = 0
@@ -1582,8 +1582,8 @@ class CookerParser(object):
         sync = threading.Thread(target=self.bb_cache.sync)
         sync.start()
         multiprocessing.util.Finalize(None, sync.join, exitpriority=-100)
-        bb.codeparser.parser_cache_savemerge(self.cooker.configuration.data)
-        bb.fetch.fetcher_parse_done(self.cooker.configuration.data)
+        bb.codeparser.parser_cache_savemerge(self.cooker.data)
+        bb.fetch.fetcher_parse_done(self.cooker.data)
 
     def load_cached(self):
         for filename, appends in self.fromcache:
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index f1964da..090d1b5 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -957,7 +957,7 @@ class RunQueue:
         for task in range(len(self.rqdata.runq_fnid)):
             if self.rqdata.runq_fnid[task] not in done:
                 fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]]
-                the_data = bb.cache.Cache.loadDataFull(fn, self.cooker.collection.get_file_appends(fn), self.cooker.configuration.data)
+                the_data = bb.cache.Cache.loadDataFull(fn, self.cooker.collection.get_file_appends(fn), self.cooker.data)
                 done.add(self.rqdata.runq_fnid[task])
 
         bb.parse.siggen.dump_sigs(self.rqdata.dataCache)
@@ -1119,11 +1119,11 @@ class RunQueueExecute:
             if umask:
                 os.umask(umask)
 
-            self.cooker.configuration.data.setVar("BB_WORKERCONTEXT", "1")
+            self.cooker.data.setVar("BB_WORKERCONTEXT", "1")
             bb.parse.siggen.set_taskdata(self.rqdata.hashes, self.rqdata.hash_deps)
             ret = 0
             try:
-                the_data = bb.cache.Cache.loadDataFull(fn, self.cooker.collection.get_file_appends(fn), self.cooker.configuration.data)
+                the_data = bb.cache.Cache.loadDataFull(fn, self.cooker.collection.get_file_appends(fn), self.cooker.data)
                 the_data.setVar('BB_TASKHASH', self.rqdata.runq_hash[task])
                 for h in self.rqdata.hashes:
                     the_data.setVar("BBHASH_%s" % h, self.rqdata.hashes[h])
@@ -1180,7 +1180,7 @@ class RunQueueExecute:
             taskname = self.rqdata.runq_task[depid]
             taskdata[dep] = [pn, taskname, fn]
         call = self.rq.depvalidate + "(task, taskdata, notneeded, d)"
-        locs = { "task" : task, "taskdata" : taskdata, "notneeded" : self.scenequeue_notneeded, "d" : self.cooker.configuration.data }
+        locs = { "task" : task, "taskdata" : taskdata, "notneeded" : self.scenequeue_notneeded, "d" : self.cooker.data }
         valid = bb.utils.better_eval(call, locs)
         return valid
 
@@ -1247,7 +1247,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
             call = self.rq.setsceneverify + "(covered, tasknames, fnids, fns, d, invalidtasks=invalidtasks)"
             call2 = self.rq.setsceneverify + "(covered, tasknames, fnids, fns, d)"
-            locs = { "covered" : self.rq.scenequeue_covered, "tasknames" : self.rqdata.runq_task, "fnids" : self.rqdata.runq_fnid, "fns" : self.rqdata.taskData.fn_index, "d" : self.cooker.configuration.data, "invalidtasks" : invalidtasks }
+            locs = { "covered" : self.rq.scenequeue_covered, "tasknames" : self.rqdata.runq_task, "fnids" : self.rqdata.runq_fnid, "fns" : self.rqdata.taskData.fn_index, "d" : self.cooker.data, "invalidtasks" : invalidtasks }
             # Backwards compatibility with older versions without invalidtasks
             try:
                 covered_remove = bb.utils.better_eval(call, locs)
@@ -1607,7 +1607,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 sq_taskname.append(taskname)
                 sq_task.append(task)
             call = self.rq.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d)"
-            locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.configuration.data }
+            locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
             valid = bb.utils.better_eval(call, locs)
 
             valid_new = stamppresent



