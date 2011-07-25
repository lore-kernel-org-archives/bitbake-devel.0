Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QlQJt-0005y7-6O
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Jul 2011 20:56:01 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 25 Jul 2011 11:51:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,264,1309762800"; d="scan'208";a="29903197"
Received: from vorpal.jf.intel.com ([10.7.199.57])
	by orsmga002.jf.intel.com with ESMTP; 25 Jul 2011 11:51:41 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 25 Jul 2011 11:56:09 -0700
Message-Id: <127f57c838311e2dcb3b52120c8c8dc7946f4921.1311620081.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311620081.git.josh@linux.intel.com>
References: <cover.1311620081.git.josh@linux.intel.com>
In-Reply-To: <cover.1311620081.git.josh@linux.intel.com>
References: <cover.1311620081.git.josh@linux.intel.com>
Subject: [PATCH 1/4] data|cooker: use saved environment variables when calling inheritFromOS
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
X-List-Received-Date: Mon, 25 Jul 2011 18:56:01 -0000

Now that we have a pristine copy of the variables available at launch time
we can use them when looking to inherit the OS's environment.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/cooker.py |    2 +-
 lib/bb/data.py   |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index d8535a7..1b5101d 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -132,7 +132,7 @@ class BBCooker:
 
         self.configuration.data = bb.data.init()
 
-        bb.data.inheritFromOS(self.configuration.data)
+        bb.data.inheritFromOS(self.configuration.data, self.savedenv)
 
         try:
             self.parseConfigurationFiles(self.configuration.prefile,
diff --git a/lib/bb/data.py b/lib/bb/data.py
index 2269f9d..65144bf 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -159,12 +159,12 @@ def expandKeys(alterdata, readdata = None):
         ekey = todolist[key]
         renameVar(key, ekey, alterdata)
 
-def inheritFromOS(d):
-    """Inherit variables from the environment."""
+def inheritFromOS(d, savedenv):
+    """Inherit variables from the initial environment."""
     exportlist = bb.utils.preserved_envvars_exported()
-    for s in os.environ.keys():
+    for s in savedenv.keys():
         try:
-            setVar(s, os.environ[s], d)
+            setVar(s, getVar(s, savedenv, True), d)
             if s in exportlist:
                 setVarFlag(s, "export", True, d)
         except TypeError:
-- 
1.7.6



