Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S42jr-0004pb-NR for bitbake-devel@lists.openembedded.org;
	Sun, 04 Mar 2012 05:08:04 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q243xVYt020058
	for <bitbake-devel@lists.openembedded.org>; Sun, 4 Mar 2012 03:59:31 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 19596-08 for <bitbake-devel@lists.openembedded.org>;
	Sun,  4 Mar 2012 03:59:26 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q243xJCi020052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>; Sun, 4 Mar 2012 03:59:22 GMT
Message-ID: <1330833563.3949.1.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 03 Mar 2012 19:59:23 -0800
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake: Convert getVar/getVarFlag(xxx, 1) -> (xxx, True)
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
X-List-Received-Date: Sun, 04 Mar 2012 04:08:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Using "1" with getVar is bad coding style and "True" is preferred.

This patch is a sed over bitbake directory of the form:

sed \
 -e 's:\(\.getVar([^,()]*, \)1 *):\1True):g' \
 -e 's:\(\.getVarFlag([^,()]*, [^,()]*, \)1 *):\1True):g' \
 -i `grep -ril getVar *`

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 classes/base.bbclass                 |    2 +-
 conf/bitbake.conf                    |    2 +-
 lib/bb/build.py                      |    4 ++--
 lib/bb/cooker.py                     |   18 +++++++++---------
 lib/bb/data_smart.py                 |    2 +-
 lib/bb/fetch/__init__.py             |   10 +++++-----
 lib/bb/monitordisk.py                |    4 ++--
 lib/bb/parse/parse_py/ConfHandler.py |    2 +-
 lib/bb/providers.py                  |    4 ++--
 lib/bb/runqueue.py                   |    8 ++++----
 10 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/classes/base.bbclass b/classes/base.bbclass
index 444b830..49f8e39 100644
--- a/classes/base.bbclass
+++ b/classes/base.bbclass
@@ -44,7 +44,7 @@ python do_showdata() {
 	# emit the metadata which isnt valid shell
 	for e in bb.data.keys(d):
 		if d.getVarFlag(e, 'python'):
-			sys.__stdout__.write("\npython %s () {\n%s}\n" % (e, d.getVar(e, 1)))
+			sys.__stdout__.write("\npython %s () {\n%s}\n" % (e, d.getVar(e, True)))
 }
 
 addtask listtasks
diff --git a/conf/bitbake.conf b/conf/bitbake.conf
index 1ee4dc5..c2ed926 100644
--- a/conf/bitbake.conf
+++ b/conf/bitbake.conf
@@ -28,7 +28,7 @@ FETCHCOMMAND = ""
 FETCHCOMMAND_cvs = "/usr/bin/env cvs -d${CVSROOT} co ${CVSCOOPTS} ${CVSMODULE}"
 FETCHCOMMAND_svn = "/usr/bin/env svn co ${SVNCOOPTS} ${SVNROOT} ${SVNMODULE}"
 FETCHCOMMAND_wget = "/usr/bin/env wget -t 5 --passive-ftp -P ${DL_DIR} ${URI}"
-FILESDIR = "${@bb.utils.which(d.getVar('FILESPATH', 1), '.')}"
+FILESDIR = "${@bb.utils.which(d.getVar('FILESPATH', True), '.')}"
 FILESPATH = "${FILE_DIRNAME}/${PF}:${FILE_DIRNAME}/${P}:${FILE_DIRNAME}/${PN}:${FILE_DIRNAME}/files:${FILE_DIRNAME}"
 FILE_DIRNAME = "${@os.path.dirname(d.getVar('FILE'))}"
 GITDIR = "${DL_DIR}/git"
diff --git a/lib/bb/build.py b/lib/bb/build.py
index a9b40e7..736ba24 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -70,9 +70,9 @@ class TaskBase(event.Event):
 
     def __init__(self, t, d ):
         self._task = t
-        self._package = d.getVar("PF", 1)
+        self._package = d.getVar("PF", True)
         event.Event.__init__(self)
-        self._message = "package %s: task %s: %s" % (d.getVar("PF", 1), t, self.getDisplayName())
+        self._message = "package %s: task %s: %s" % (d.getVar("PF", True), t, self.getDisplayName())
 
     def getTask(self):
         return self._task
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index bf8389a..451f1e9 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -298,7 +298,7 @@ class BBCooker:
             # this showEnvironment() code path doesn't use the cache
             self.parseConfiguration()
             self.status = bb.cache.CacheData(self.caches_array)
-            self.handleCollections( self.configuration.data.getVar("BBFILE_COLLECTIONS", 1) )
+            self.handleCollections( self.configuration.data.getVar("BBFILE_COLLECTIONS", True) )
 
             fn, cls = bb.cache.Cache.virtualfn2realfn(buildfile)
             fn = self.matchFile(fn)
@@ -882,7 +882,7 @@ class BBCooker:
             min_prio = 0
             for c in collection_list:
                 # Get collection priority if defined explicitly
-                priority = self.configuration.data.getVar("BBFILE_PRIORITY_%s" % c, 1)
+                priority = self.configuration.data.getVar("BBFILE_PRIORITY_%s" % c, True)
                 if priority:
                     try:
                         prio = int(priority)
@@ -896,7 +896,7 @@ class BBCooker:
                     collection_priorities[c] = None
 
                 # Check dependencies and store information for priority calculation
-                deps = self.configuration.data.getVar("LAYERDEPENDS_%s" % c, 1)
+                deps = self.configuration.data.getVar("LAYERDEPENDS_%s" % c, True)
                 if deps:
                     depnamelist = []
                     deplist = deps.split()
@@ -916,7 +916,7 @@ class BBCooker:
 
                         if dep in collection_list:
                             if depver:
-                                layerver = self.configuration.data.getVar("LAYERVERSION_%s" % dep, 1)
+                                layerver = self.configuration.data.getVar("LAYERVERSION_%s" % dep, True)
                                 if layerver:
                                     try:
                                         lver = int(layerver)
@@ -953,7 +953,7 @@ class BBCooker:
             # Calculate all layer priorities using calc_layer_priority and store in bbfile_config_priorities
             for c in collection_list:
                 calc_layer_priority(c)
-                regex = self.configuration.data.getVar("BBFILE_PATTERN_%s" % c, 1)
+                regex = self.configuration.data.getVar("BBFILE_PATTERN_%s" % c, True)
                 if regex == None:
                     parselog.error("BBFILE_PATTERN_%s not defined" % c)
                     errors = True
@@ -1027,7 +1027,7 @@ class BBCooker:
         # buildFile() doesn't use the cache
         self.parseConfiguration()
         self.status = bb.cache.CacheData(self.caches_array)
-        self.handleCollections( self.configuration.data.getVar("BBFILE_COLLECTIONS", 1) )
+        self.handleCollections( self.configuration.data.getVar("BBFILE_COLLECTIONS", True) )
 
         # If we are told to do the None task then query the default task
         if (task == None):
@@ -1181,13 +1181,13 @@ class BBCooker:
                 del self.status
             self.status = bb.cache.CacheData(self.caches_array)
 
-            ignore = self.configuration.data.getVar("ASSUME_PROVIDED", 1) or ""
+            ignore = self.configuration.data.getVar("ASSUME_PROVIDED", True) or ""
             self.status.ignored_dependencies = set(ignore.split())
 
             for dep in self.configuration.extra_assume_provided:
                 self.status.ignored_dependencies.add(dep)
 
-            self.handleCollections( self.configuration.data.getVar("BBFILE_COLLECTIONS", 1) )
+            self.handleCollections( self.configuration.data.getVar("BBFILE_COLLECTIONS", True) )
 
             (filelist, masked) = self.collect_bbfiles()
             self.configuration.data.renameVar("__depends", "__base_depends")
@@ -1282,7 +1282,7 @@ class BBCooker:
                     if g not in newfiles:
                         newfiles.append(g)
 
-        bbmask = self.configuration.data.getVar('BBMASK', 1)
+        bbmask = self.configuration.data.getVar('BBMASK', True)
 
         if bbmask:
             try:
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 7765f81..2c200db 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -58,7 +58,7 @@ class VariableParse:
             if self.varname and key:
                 if self.varname == key:
                     raise Exception("variable %s references itself!" % self.varname)
-            var = self.d.getVar(key, 1)
+            var = self.d.getVar(key, True)
             if var is not None:
                 self.references.add(key)
                 return var
diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
index ea98019..1898864 100644
--- a/lib/bb/fetch/__init__.py
+++ b/lib/bb/fetch/__init__.py
@@ -154,7 +154,7 @@ def fetcher_init(d):
     Calls before this must not hit the cache.
     """
     # When to drop SCM head revisions controlled by user policy
-    srcrev_policy = d.getVar('BB_SRCREV_POLICY', 1) or "clear"
+    srcrev_policy = d.getVar('BB_SRCREV_POLICY', True) or "clear"
     if srcrev_policy == "cache":
         logger.debug(1, "Keeping SRCREV cache due to cache policy of: %s", srcrev_policy)
     elif srcrev_policy == "clear":
@@ -200,7 +200,7 @@ def fetcher_compare_revisions(d):
 def init(urls, d, setup = True):
     urldata = {}
 
-    fn = d.getVar('FILE', 1)
+    fn = d.getVar('FILE', True)
     if fn in urldata_cache:
         urldata = urldata_cache[fn]
 
@@ -261,7 +261,7 @@ def go(d, urls = None):
     init must have previously been called
     """
     if not urls:
-        urls = d.getVar("SRC_URI", 1).split()
+        urls = d.getVar("SRC_URI", True).split()
     urldata = init(urls, d, True)
 
     for u in urls:
@@ -383,7 +383,7 @@ def get_srcrev(d):
     scms = []
 
     # Only call setup_localpath on URIs which supports_srcrev()
-    urldata = init(d.getVar('SRC_URI', 1).split(), d, False)
+    urldata = init(d.getVar('SRC_URI', True).split(), d, False)
     for u in urldata:
         ud = urldata[u]
         if ud.method.supports_srcrev():
@@ -404,7 +404,7 @@ def get_srcrev(d):
     #
     # Mutiple SCMs are in SRC_URI so we resort to SRCREV_FORMAT
     #
-    format = d.getVar('SRCREV_FORMAT', 1)
+    format = d.getVar('SRCREV_FORMAT', True)
     if not format:
         logger.error("The SRCREV_FORMAT variable must be set when multiple SCMs are used.")
         raise ParameterError
diff --git a/lib/bb/monitordisk.py b/lib/bb/monitordisk.py
index 04f090c..9baba5e 100644
--- a/lib/bb/monitordisk.py
+++ b/lib/bb/monitordisk.py
@@ -136,7 +136,7 @@ def getInterval(configuration):
 
     """ Get the disk space interval """
 
-    interval = configuration.getVar("BB_DISKMON_WARNINTERVAL", 1)
+    interval = configuration.getVar("BB_DISKMON_WARNINTERVAL", True)
     if not interval:
         # The default value is 50M and 5K.
         return 50 * 1024 * 1024, 5 * 1024
@@ -170,7 +170,7 @@ class diskMonitor:
 
         self.enableMonitor = False
 
-        BBDirs = configuration.getVar("BB_DISKMON_DIRS", 1) or None
+        BBDirs = configuration.getVar("BB_DISKMON_DIRS", True) or None
         if BBDirs:
             self.devDict = getDiskData(BBDirs, configuration)
             if self.devDict:
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 0e24b72..fa811f3 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -58,7 +58,7 @@ def include(oldfn, fn, lineno, data, error_out):
 
     if not os.path.isabs(fn):
         dname = os.path.dirname(oldfn)
-        bbpath = "%s:%s" % (dname, data.getVar("BBPATH", 1))
+        bbpath = "%s:%s" % (dname, data.getVar("BBPATH", True))
         abs_fn = bb.utils.which(bbpath, fn)
         if abs_fn:
             fn = abs_fn
diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index 1dc6a8e..bd729df 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -284,7 +284,7 @@ def filterProviders(providers, item, cfgData, dataCache):
 
     eligible = _filterProviders(providers, item, cfgData, dataCache)
 
-    prefervar = cfgData.getVar('PREFERRED_PROVIDER_%s' % item, 1)
+    prefervar = cfgData.getVar('PREFERRED_PROVIDER_%s' % item, True)
     if prefervar:
         dataCache.preferred[item] = prefervar
 
@@ -322,7 +322,7 @@ def filterProvidersRunTime(providers, item, cfgData, dataCache):
         pn = dataCache.pkg_fn[p]
         provides = dataCache.pn_provides[pn]
         for provide in provides:
-            prefervar = cfgData.getVar('PREFERRED_PROVIDER_%s' % provide, 1)
+            prefervar = cfgData.getVar('PREFERRED_PROVIDER_%s' % provide, True)
             logger.debug(1, "checking PREFERRED_PROVIDER_%s (value %s) against %s", provide, prefervar, pns.keys())
             if prefervar in pns and pns[prefervar] not in preferred:
                 var = "PREFERRED_PROVIDER_%s = %s" % (provide, prefervar)
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index f44c2ec..bc06027 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -190,8 +190,8 @@ class RunQueueData:
         self.rq = rq
         self.warn_multi_bb = False
 
-        self.stampwhitelist = cfgData.getVar("BB_STAMP_WHITELIST", 1) or ""
-        self.multi_provider_whitelist = (cfgData.getVar("MULTI_PROVIDER_WHITELIST", 1) or "").split()
+        self.stampwhitelist = cfgData.getVar("BB_STAMP_WHITELIST", True) or ""
+        self.multi_provider_whitelist = (cfgData.getVar("MULTI_PROVIDER_WHITELIST", True) or "").split()
 
         self.reset()
 
@@ -1029,8 +1029,8 @@ class RunQueueExecute:
         self.cfgData = rq.cfgData
         self.rqdata = rq.rqdata
 
-        self.number_tasks = int(self.cfgData.getVar("BB_NUMBER_THREADS", 1) or 1)
-        self.scheduler = self.cfgData.getVar("BB_SCHEDULER", 1) or "speed"
+        self.number_tasks = int(self.cfgData.getVar("BB_NUMBER_THREADS", True) or 1)
+        self.scheduler = self.cfgData.getVar("BB_SCHEDULER", True) or "speed"
 
         self.runq_buildable = []
         self.runq_running = []




