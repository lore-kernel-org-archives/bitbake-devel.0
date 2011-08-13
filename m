Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qs2d2-0000SE-3k
	for bitbake-devel@lists.openembedded.org;
	Sat, 13 Aug 2011 03:03:08 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 12 Aug 2011 17:58:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,365,1309762800"; d="scan'208";a="39013848"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.15.3])
	by fmsmga002.fm.intel.com with ESMTP; 12 Aug 2011 17:58:18 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Aug 2011 17:58:11 -0700
Message-Id: <0bed22559175a17f0af42f122e719c869f8dc0e7.1313196998.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313196998.git.josh@linux.intel.com>
References: <cover.1313196998.git.josh@linux.intel.com>
In-Reply-To: <cover.1313196998.git.josh@linux.intel.com>
References: <cover.1313196998.git.josh@linux.intel.com>
Subject: [RFC PATCH 1/1] Ensure only the filtered environment variables are inherited from the OS
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
X-List-Received-Date: Sat, 13 Aug 2011 01:03:08 -0000

The recent change which modified inheritFromOS to use the intial
environment, rather than the current environment, introduced a bug such
that variables which had been cleaned from the environment where still set
in the data store.

This patch changes things such that a list of approved environment
variables is saved after the environment is cleaned and only the variables
in this list are inherited in inheritFromOS.

CC: James Limbouris <james.limbouris@gmail.com>
CC: Chris Larson <clarson@kergoth.com>
Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 bin/bitbake-layers |    6 +++---
 lib/bb/cooker.py   |    3 ++-
 lib/bb/data.py     |   15 ++++++++-------
 lib/bb/utils.py    |   23 ++++++++++++++++-------
 4 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index d9f95d1..3fdf567 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -28,9 +28,10 @@ default_cmd = 'show_appends'
 
 def main(args):
     logging.basicConfig(format='%(levelname)s: %(message)s')
+    initialenv = os.environ.copy()
     bb.utils.clean_environment()
 
-    cmds = Commands()
+    cmds = Commands(initialenv)
     if args:
         cmds.onecmd(' '.join(args))
     else:
@@ -39,9 +40,8 @@ def main(args):
 
 
 class Commands(cmd.Cmd):
-    def __init__(self):
+    def __init__(self, initialenv):
         cmd.Cmd.__init__(self)
-        initialenv = os.environ.copy()
         self.returncode = 0
         self.config = Config(parse_only=True)
         self.cooker = bb.cooker.BBCooker(self.config,
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1978750..a0fcc15 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -163,7 +163,8 @@ class BBCooker:
     def loadConfigurationData(self):
         self.configuration.data = bb.data.init()
 
-        bb.data.inheritFromOS(self.configuration.data, self.savedenv)
+        filtered_keys = bb.utils.approved_variables()
+        bb.data.inheritFromOS(self.configuration.data, self.savedenv, filtered_keys)
 
         try:
             self.parseConfigurationFiles(self.configuration.prefile,
diff --git a/lib/bb/data.py b/lib/bb/data.py
index 65144bf..ac0d880 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -159,16 +159,17 @@ def expandKeys(alterdata, readdata = None):
         ekey = todolist[key]
         renameVar(key, ekey, alterdata)
 
-def inheritFromOS(d, savedenv):
+def inheritFromOS(d, savedenv, permitted):
     """Inherit variables from the initial environment."""
     exportlist = bb.utils.preserved_envvars_exported()
     for s in savedenv.keys():
-        try:
-            setVar(s, getVar(s, savedenv, True), d)
-            if s in exportlist:
-                setVarFlag(s, "export", True, d)
-        except TypeError:
-            pass
+        if s in permitted:
+            try:
+                setVar(s, getVar(s, savedenv, True), d)
+                if s in exportlist:
+                    setVarFlag(s, "export", True, d)
+            except TypeError:
+                pass
 
 def emit_var(var, o=sys.__stdout__, d = init(), all=False):
     """Emit a variable to be sourced by a shell."""
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 4eac285..a9c56e9 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -565,18 +565,27 @@ def create_interactive_env(d):
     for k in preserved_envvars_exported_interactive():
         os.setenv(k, bb.data.getVar(k, d, True))
 
+def approved_variables():
+    """
+    Determine and return the list of whitelisted variables which are approved
+    to remain in the envrionment.
+    """
+    approved = []
+    if 'BB_ENV_WHITELIST' in os.environ:
+        approved = os.environ['BB_ENV_WHITELIST'].split()
+    else:
+        approved = preserved_envvars()
+    if 'BB_ENV_EXTRAWHITE' in os.environ:
+        approved.extend(os.environ['BB_ENV_EXTRAWHITE'].split())
+    return approved
+
 def clean_environment():
     """
     Clean up any spurious environment variables. This will remove any
-    variables the user hasn't chose to preserve.
+    variables the user hasn't chosen to preserve.
     """
     if 'BB_PRESERVE_ENV' not in os.environ:
-        if 'BB_ENV_WHITELIST' in os.environ:
-            good_vars = os.environ['BB_ENV_WHITELIST'].split()
-        else:
-            good_vars = preserved_envvars()
-        if 'BB_ENV_EXTRAWHITE' in os.environ:
-            good_vars.extend(os.environ['BB_ENV_EXTRAWHITE'].split())
+        good_vars = approved_variables()
         filter_environment(good_vars)
 
 def empty_environment():
-- 
1.7.6



