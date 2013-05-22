Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 5BCB36A358
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 May 2013 14:25:29 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 22 May 2013 07:25:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,721,1363158000"; d="scan'208";a="338233569"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.12.181])
	by fmsmga001.fm.intel.com with ESMTP; 22 May 2013 07:25:20 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 May 2013 15:25:12 +0100
Message-Id: <7db8d7aa902ca330a5d7dce23dc95dc623f5e76b.1369232029.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1369232029.git.paul.eggleton@linux.intel.com>
References: <cover.1369232029.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1369232029.git.paul.eggleton@linux.intel.com>
References: <cover.1369232029.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/3] tinfoil: fix for changes to cooker config structure
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
X-List-Received-Date: Wed, 22 May 2013 14:25:29 -0000

Fix the code here for recent changes to the initialisation of
configuration objects for cooker.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/tinfoil.py | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/bitbake/lib/bb/tinfoil.py b/bitbake/lib/bb/tinfoil.py
index 56ce54f..c05e146 100644
--- a/bitbake/lib/bb/tinfoil.py
+++ b/bitbake/lib/bb/tinfoil.py
@@ -25,7 +25,8 @@ import bb.cache
 import bb.cooker
 import bb.providers
 import bb.utils
-from bb.cooker import state
+from bb.cooker import state, BBCooker
+from bb.cookerdata import CookerConfiguration, ConfigParameters
 import bb.fetch2
 
 class Tinfoil:
@@ -43,12 +44,11 @@ class Tinfoil:
         console.setFormatter(format)
         self.logger.addHandler(console)
 
-        initialenv = os.environ.copy()
-        bb.utils.clean_environment()
-        self.config = TinfoilConfig(parse_only=True)
-        self.cooker = bb.cooker.BBCooker(self.config,
-                                            self.register_idle_function,
-                                            initialenv)
+        self.config = CookerConfiguration()
+        configparams = TinfoilConfigParameters(parse_only=True)
+        self.config.setConfigParameters(configparams)
+        self.config.setServerRegIdleCallback(self.register_idle_function)
+        self.cooker = BBCooker(self.config)
         self.config_data = self.cooker.configuration.data
         bb.providers.logger.setLevel(logging.ERROR)
         self.cooker_data = None
@@ -81,20 +81,21 @@ class Tinfoil:
             else:
                 self.parseRecipes()
 
+class TinfoilConfigParameters(ConfigParameters):
 
-class TinfoilConfig(object):
     def __init__(self, **options):
-        self.pkgs_to_build = []
-        self.debug_domains = []
-        self.extra_assume_provided = []
-        self.prefile = []
-        self.postfile = []
-        self.debug = 0
-        self.__dict__.update(options)
+        self.initial_options = options
+        super(TinfoilConfigParameters, self).__init__()
 
-    def __getattr__(self, attribute):
-        try:
-            return super(TinfoilConfig, self).__getattribute__(attribute)
-        except AttributeError:
-            return None
+    def parseCommandLine(self):
+        class DummyOptions:
+            def __init__(self, initial_options):
+                self.show_environment = False
+                self.pkgs_to_build = []
+                self.prefile = []
+                self.postfile = []
+                self.tracking = False
+                for key, val in initial_options.items():
+                    setattr(self, key, val)
 
+        return DummyOptions(self.initial_options), None
-- 
1.8.1.2


