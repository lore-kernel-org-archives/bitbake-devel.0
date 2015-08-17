Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id AC2A165CBC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Aug 2015 11:12:35 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 17 Aug 2015 04:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,694,1432623600"; d="scan'208";a="785564768"
Received: from jwanrooi-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.11.216])
	by orsmga002.jf.intel.com with ESMTP; 17 Aug 2015 04:12:35 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Aug 2015 12:12:16 +0100
Message-Id: <7381914724c957359c140ab9cda1c3dd7f1a8979.1439809654.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 01/13] Fix default function parameter assignment to a list
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
X-List-Received-Date: Mon, 17 Aug 2015 11:12:37 -0000

With python you should not assign a list as the default value of a
function parameter - because a list is mutable, the result will be that
the first time a value is passed it will actually modify the default.
Reference:

http://docs.python-guide.org/en/latest/writing/gotchas/#mutable-default-arguments

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py                    | 15 +++++++++------
 lib/bb/event.py                     |  4 ++--
 lib/bb/fetch2/__init__.py           | 23 +++++++++++++----------
 lib/bb/msg.py                       |  7 +++++--
 lib/bb/process.py                   |  5 ++++-
 lib/bb/server/process.py            |  4 +++-
 lib/bb/server/xmlrpc.py             |  7 +++++--
 lib/bb/taskdata.py                  |  8 +++++---
 lib/bb/ui/crumbs/hobeventhandler.py | 12 +++++++++---
 lib/toaster/toastergui/views.py     |  4 +++-
 10 files changed, 58 insertions(+), 31 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 0f99342..84bf46b 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -114,12 +114,13 @@ class BBCooker:
     Manages one bitbake build run
     """
 
-    def __init__(self, configuration, featureSet = []):
+    def __init__(self, configuration, featureSet=None):
         self.recipecache = None
         self.skiplist = {}
         self.featureset = CookerFeatures()
-        for f in featureSet:
-            self.featureset.setFeature(f)
+        if featureSet:
+            for f in featureSet:
+                self.featureset.setFeature(f)
 
         self.configuration = configuration
 
@@ -567,12 +568,14 @@ class BBCooker:
 
             logger.plain("%-35s %25s %25s", p, lateststr, prefstr)
 
-    def showEnvironment(self, buildfile = None, pkgs_to_build = []):
+    def showEnvironment(self, buildfile=None, pkgs_to_build=None):
         """
         Show the outer or per-recipe environment
         """
         fn = None
         envdata = None
+        if not pkgs_to_build:
+            pkgs_to_build = []
 
         if buildfile:
             # Parse the configuration here. We need to do it explicitly here since
@@ -1037,13 +1040,13 @@ class BBCooker:
 
         return pkg_list
 
-    def generateTargetsTree(self, klass=None, pkgs=[]):
+    def generateTargetsTree(self, klass=None, pkgs=None):
         """
         Generate a dependency tree of buildable targets
         Generate an event with the result
         """
         # if the caller hasn't specified a pkgs list default to universe
-        if not len(pkgs):
+        if not pkgs:
             pkgs = ['universe']
         # if inherited_class passed ensure all recipes which inherit the
         # specified class are included in pkgs
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 61a7f4a..0e18110 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -176,7 +176,7 @@ def fire_from_worker(event, d):
     fire_ui_handlers(event, d)
 
 noop = lambda _: None
-def register(name, handler, mask=[]):
+def register(name, handler, mask=None):
     """Register an Event handler"""
 
     # already registered
@@ -389,7 +389,7 @@ class DiskFull(Event):
 class NoProvider(Event):
     """No Provider for an Event"""
 
-    def __init__(self, item, runtime=False, dependees=None, reasons=[], close_matches=[]):
+    def __init__(self, item, runtime=False, dependees=None, reasons=None, close_matches=None):
         Event.__init__(self)
         self._item = item
         self._runtime = runtime
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 7b4d130..ec0c31a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -777,7 +777,7 @@ def localpath(url, d):
     fetcher = bb.fetch2.Fetch([url], d)
     return fetcher.localpath(url)
 
-def runfetchcmd(cmd, d, quiet = False, cleanup = []):
+def runfetchcmd(cmd, d, quiet=False, cleanup=None):
     """
     Run cmd returning the command output
     Raise an error if interrupted or cmd fails
@@ -802,6 +802,9 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
                   'SSH_AUTH_SOCK', 'SSH_AGENT_PID',
                   'SOCKS5_USER', 'SOCKS5_PASSWD']
 
+    if not cleanup:
+        cleanup = []
+
     for var in exportvars:
         val = d.getVar(var, True)
         if val:
@@ -1267,7 +1270,7 @@ class FetchData(object):
 class FetchMethod(object):
     """Base class for 'fetch'ing data"""
 
-    def __init__(self, urls = []):
+    def __init__(self, urls=None):
         self.urls = []
 
     def supports(self, urldata, d):
@@ -1552,11 +1555,11 @@ class Fetch(object):
 
         return local
 
-    def download(self, urls = []):
+    def download(self, urls=None):
         """
         Fetch all urls
         """
-        if len(urls) == 0:
+        if not urls:
             urls = self.urls
 
         network = self.d.getVar("BB_NO_NETWORK", True)
@@ -1634,12 +1637,12 @@ class Fetch(object):
             finally:
                 bb.utils.unlockfile(lf)
 
-    def checkstatus(self, urls = []):
+    def checkstatus(self, urls=None):
         """
         Check all urls exist upstream
         """
 
-        if len(urls) == 0:
+        if not urls:
             urls = self.urls
 
         for u in urls:
@@ -1662,12 +1665,12 @@ class Fetch(object):
             if not ret:
                 raise FetchError("URL %s doesn't work" % u, u)
 
-    def unpack(self, root, urls = []):
+    def unpack(self, root, urls=None):
         """
         Check all urls exist upstream
         """
 
-        if len(urls) == 0:
+        if not urls:
             urls = self.urls
 
         for u in urls:
@@ -1685,12 +1688,12 @@ class Fetch(object):
             if ud.lockfile:
                 bb.utils.unlockfile(lf)
 
-    def clean(self, urls = []):
+    def clean(self, urls=None):
         """
         Clean files that the fetcher gets or places
         """
 
-        if len(urls) == 0:
+        if not urls:
             urls = self.urls
 
         for url in urls:
diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index d79768d..786b5ae 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -150,7 +150,7 @@ loggerDefaultVerbose = False
 loggerVerboseLogs = False
 loggerDefaultDomains = []
 
-def init_msgconfig(verbose, debug, debug_domains = []):
+def init_msgconfig(verbose, debug, debug_domains=None):
     """
     Set default verbosity and debug levels config the logger
     """
@@ -158,7 +158,10 @@ def init_msgconfig(verbose, debug, debug_domains = []):
     bb.msg.loggerDefaultVerbose = verbose
     if verbose:
         bb.msg.loggerVerboseLogs = True
-    bb.msg.loggerDefaultDomains = debug_domains
+    if debug_domains:
+        bb.msg.loggerDefaultDomains = debug_domains
+    else:
+        bb.msg.loggerDefaultDomains = []
 
 def constructLogOptions():
     debug = loggerDefaultDebugLevel
diff --git a/lib/bb/process.py b/lib/bb/process.py
index 7c79785..1c07f2d 100644
--- a/lib/bb/process.py
+++ b/lib/bb/process.py
@@ -128,10 +128,13 @@ def _logged_communicate(pipe, log, input, extrafiles):
         pipe.stderr.close()
     return ''.join(outdata), ''.join(errdata)
 
-def run(cmd, input=None, log=None, extrafiles=[], **options):
+def run(cmd, input=None, log=None, extrafiles=None, **options):
     """Convenience function to run a command and return its output, raising an
     exception when the command fails"""
 
+    if not extrafiles:
+        extrafiles = []
+
     if isinstance(cmd, basestring) and not "shell" in options:
         options["shell"] = True
 
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index ef3ee57..3198635 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -124,8 +124,10 @@ class ProcessServer(Process, BaseImplServer):
         self.command_channel.close()
         self.cooker.shutdown(True)
 
-    def idle_commands(self, delay, fds = []):
+    def idle_commands(self, delay, fds=None):
         nextsleep = delay
+        if not fds:
+            fds = []
 
         for function, data in self._idlefuns.items():
             try:
diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
index 75ec855..f1a2067 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -281,12 +281,15 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
         self.connection_token = token
 
 class BitBakeXMLRPCServerConnection(BitBakeBaseServerConnection):
-    def __init__(self, serverImpl, clientinfo=("localhost", 0), observer_only = False, featureset = []):
+    def __init__(self, serverImpl, clientinfo=("localhost", 0), observer_only = False, featureset = None):
         self.connection, self.transport = _create_server(serverImpl.host, serverImpl.port)
         self.clientinfo = clientinfo
         self.serverImpl = serverImpl
         self.observer_only = observer_only
-        self.featureset = featureset
+        if featureset:
+            self.featureset = featureset
+        else:
+            self.featureset = []
 
     def connect(self, token = None):
         if token is None:
diff --git a/lib/bb/taskdata.py b/lib/bb/taskdata.py
index ca58e17..5fab704 100644
--- a/lib/bb/taskdata.py
+++ b/lib/bb/taskdata.py
@@ -514,7 +514,7 @@ class TaskData:
             self.add_runtime_target(fn, item)
             self.add_tasks(fn, dataCache)
 
-    def fail_fnid(self, fnid, missing_list = []):
+    def fail_fnid(self, fnid, missing_list=None):
         """
         Mark a file as failed (unbuildable)
         Remove any references from build and runtime provider lists
@@ -523,6 +523,8 @@ class TaskData:
         """
         if fnid in self.failed_fnids:
             return
+        if not missing_list:
+            missing_list = []
         logger.debug(1, "File '%s' is unbuildable, removing...", self.fn_index[fnid])
         self.failed_fnids.append(fnid)
         for target in self.build_targets:
@@ -536,7 +538,7 @@ class TaskData:
                 if len(self.run_targets[target]) == 0:
                     self.remove_runtarget(target, missing_list)
 
-    def remove_buildtarget(self, targetid, missing_list = []):
+    def remove_buildtarget(self, targetid, missing_list=None):
         """
         Mark a build target as failed (unbuildable)
         Trigger removal of any files that have this as a dependency
@@ -561,7 +563,7 @@ class TaskData:
             logger.error("Required build target '%s' has no buildable providers.\nMissing or unbuildable dependency chain was: %s", target, missing_list)
             raise bb.providers.NoProvider(target)
 
-    def remove_runtarget(self, targetid, missing_list = []):
+    def remove_runtarget(self, targetid, missing_list=None):
         """
         Mark a run target as failed (unbuildable)
         Trigger removal of any files that have this as a dependency
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 43edb70..b71fb33 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -440,11 +440,17 @@ class HobHandler(gobject.GObject):
         self.commands_async.append(self.SUB_BUILD_RECIPES)
         self.run_next_command(self.GENERATE_PACKAGES)
 
-    def generate_image(self, image, base_image, image_packages=[], toolchain_packages=[], default_task="build"):
+    def generate_image(self, image, base_image, image_packages=None, toolchain_packages=None, default_task="build"):
         self.image = image
         self.base_image = base_image
-        self.package_queue = image_packages
-        self.toolchain_packages = toolchain_packages
+        if image_packages:
+            self.package_queue = image_packages
+        else:
+            self.package_queue = []
+        if toolchain_packages:
+            self.toolchain_packages = toolchain_packages
+        else:
+            self.toolchain_packages = []
         self.default_task = default_task
         self.runCommand(["setPrePostConfFiles", "conf/.hob.conf", ""])
         self.commands_async.append(self.SUB_PARSE_CONFIG)
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 889b6c6..d29ddd6 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -522,7 +522,9 @@ def builddashboard( request, build_id ):
 
 
 
-def generateCoveredList2( revlist = [] ):
+def generateCoveredList2( revlist = None ):
+    if not revlist:
+        revlist = []
     covered_list =  [ x for x in revlist if x.outcome == Task.OUTCOME_COVERED ]
     while len(covered_list):
         revlist =  [ x for x in revlist if x.outcome != Task.OUTCOME_COVERED ]
-- 
2.1.0


