Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1S0UVS-0002qp-C4
	for bitbake-devel@lists.openembedded.org;
	Thu, 23 Feb 2012 09:58:30 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 23 Feb 2012 00:50:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="120437658"
Received: from llu-piketon.sh.intel.com (HELO localhost) ([10.239.36.62])
	by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2012 00:50:07 -0800
From: Lianhao Lu <lianhao.lu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Feb 2012 16:49:26 +0800
Message-Id: <ab500c7719d39ee983ac44837fe46f282730aac6.1329986451.git.lianhao.lu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1329986451.git.lianhao.lu@intel.com>
References: <cover.1329986451.git.lianhao.lu@intel.com>
Subject: [PATCH 1/1] bitbake: Add new otpion --environment-more
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
X-List-Received-Date: Thu, 23 Feb 2012 08:58:30 -0000

Added a new otpion --environment-more, similar to --environment but
displaying addtional file dependency informations in the shell variable
"__depends".

Signed-off-by: Lianhao Lu <lianhao.lu@intel.com>
---
 bitbake/bin/bitbake       |    3 +++
 bitbake/lib/bb/command.py |    6 ++++--
 bitbake/lib/bb/cooker.py  |   22 ++++++++++++++++++----
 scripts/bitbake           |    2 +-
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 6da4980..efe9980 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -144,6 +144,9 @@ Default BBFILES are the .bb files in the current directory.""")
     parser.add_option("-e", "--environment", help = "show the global or per-package environment (this is what used to be bbread)",
                action = "store_true", dest = "show_environment", default = False)
 
+    parser.add_option("", "--environment-more", help = "same as --environment, but with more information",
+               action = "store_true", dest = "show_environment_more", default = False)
+
     parser.add_option("-g", "--graphviz", help = "emit the dependency trees of the specified packages in the dot syntax",
                 action = "store_true", dest = "dot_graph", default = False)
 
diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 2a3a3af..d2dd99c 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -299,8 +299,9 @@ class CommandsAsync:
         (needs the cache to work out which recipe to use)
         """
         pkg = params[0]
+        more = params[1]
 
-        command.cooker.showEnvironment(None, pkg)
+        command.cooker.showEnvironment(None, pkg, more)
         command.finishAsyncCommand()
     showEnvironmentTarget.needcache = True
 
@@ -310,8 +311,9 @@ class CommandsAsync:
         or if specified the environment for a specified recipe
         """
         bfile = params[0]
+        more = params[1]
 
-        command.cooker.showEnvironment(bfile)
+        command.cooker.showEnvironment(bfile, [], more)
         command.finishAsyncCommand()
     showEnvironment.needcache = False
 
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index f0778e5..b241bc0 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -212,7 +212,7 @@ class BBCooker:
     def parseCommandLine(self):
         # Parse any commandline into actions
         self.commandlineAction = {'action':None, 'msg':None}
-        if self.configuration.show_environment:
+        if self.configuration.show_environment or self.configuration.show_environment_more:
             if 'world' in self.configuration.pkgs_to_build:
                 self.commandlineAction['msg'] = "'world' is not a valid target for --environment."
             elif 'universe' in self.configuration.pkgs_to_build:
@@ -222,9 +222,9 @@ class BBCooker:
             elif self.configuration.buildfile and len(self.configuration.pkgs_to_build) > 0:
                 self.commandlineAction['msg'] = "No target should be used with the --environment and --buildfile options."
             elif len(self.configuration.pkgs_to_build) > 0:
-                self.commandlineAction['action'] = ["showEnvironmentTarget", self.configuration.pkgs_to_build]
+                self.commandlineAction['action'] = ["showEnvironmentTarget", self.configuration.pkgs_to_build, self.configuration.show_environment_more]
             else:
-                self.commandlineAction['action'] = ["showEnvironment", self.configuration.buildfile]
+                self.commandlineAction['action'] = ["showEnvironment", self.configuration.buildfile, self.configuration.show_environment_more]
         elif self.configuration.buildfile is not None:
             self.commandlineAction['action'] = ["buildFile", self.configuration.buildfile, self.configuration.cmd]
         elif self.configuration.revisions_changed:
@@ -277,7 +277,7 @@ class BBCooker:
 
             logger.plain("%-35s %25s %25s", p, lateststr, prefstr)
 
-    def showEnvironment(self, buildfile = None, pkgs_to_build = []):
+    def showEnvironment(self, buildfile = None, pkgs_to_build = [], more = False):
         """
         Show the outer or per-package environment
         """
@@ -330,6 +330,20 @@ class BBCooker:
             if data.getVarFlag( e, 'python', envdata ):
                 logger.plain("\npython %s () {\n%s}\n", e, data.getVar(e, envdata, 1))
 
+        # more depends data
+        if more:
+            if fn:
+                realfn, _ = bb.cache.Cache.virtualfn2realfn(fn)
+                logger.plain("\n__file=\"%s\"", realfn)
+            dep_files = []
+            depends = envdata.getVar('__depends', True) or set()
+            depends = depends.union(self.configuration.data.getVar('__base_depends', True) or set())
+            depends = depends.union(self.configuration.data.getVar('__depends', True) or set())
+            for (fn, ctime) in depends:
+                dep_files.append(os.path.abspath(fn))
+            if dep_files:
+                logger.plain("__depends=\"%s\"\n" , " ".join(dep_files))
+
     def prepareTreeData(self, pkgs_to_build, task):
         """
         Prepare a runqueue and taskdata object for iteration over pkgs_to_build
diff --git a/scripts/bitbake b/scripts/bitbake
index dda3b26..d77ecb5 100755
--- a/scripts/bitbake
+++ b/scripts/bitbake
@@ -3,7 +3,7 @@
 export BBFETCH2=True
 export BB_ENV_EXTRAWHITE="PSEUDO_BUILD PSEUDO_DISABLED $BB_ENV_EXTRAWHITE"
 
-NO_BUILD_OPTS="--version -h --help -p --parse-only -s --show-versions -e --environment -g --graphviz"
+NO_BUILD_OPTS="--version -h --help -p --parse-only -s --show-versions -e --environment --environment-more -g --graphviz"
 PASSTHROUGH_OPTS="-D -DD -DDD -DDDD -v"
 needpseudo="1"
 for opt in $@; do
-- 
1.7.0.4



