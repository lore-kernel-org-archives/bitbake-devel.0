Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QcWtS-0007rE-HG
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jul 2011 08:07:58 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 30 Jun 2011 23:03:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,456,1304319600"; d="scan'208";a="21321719"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.228])
	by azsmga001.ch.intel.com with ESMTP; 30 Jun 2011 23:03:07 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jun 2011 23:02:53 -0700
Message-Id: <841eee6d27a54335e9435b1d6f2b4b63b5ddf6d7.1309499228.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1309499227.git.josh@linux.intel.com>
References: <cover.1309499227.git.josh@linux.intel.com>
In-Reply-To: <cover.1309499227.git.josh@linux.intel.com>
References: <cover.1309499227.git.josh@linux.intel.com>
Subject: [PATCH 07/10] bitbake: add -R option for loading configuration files after bitbake.conf
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
X-List-Received-Date: Fri, 01 Jul 2011 06:07:58 -0000

Useful if you want to load a configuration file that sets values which may
also be set in bitbake.conf or one of the files it includes.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 bin/bitbake      |    5 ++++-
 lib/bb/cooker.py |   13 ++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index d577e05..206d97b 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -118,7 +118,10 @@ Default BBFILES are the .bb files in the current directory.""")
                action = "store", dest = "cmd")
 
     parser.add_option("-r", "--read", help = "read the specified file before bitbake.conf",
-               action = "append", dest = "file", default = [])
+               action = "append", dest = "prefile", default = [])
+
+    parser.add_option("-R", "--postread", help = "read the specified file after bitbake.conf",
+                      action = "append", dest = "postfile", default = [])
 
     parser.add_option("-v", "--verbose", help = "output more chit-chat to the terminal",
                action = "store_true", dest = "verbose", default = False)
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index f0c94fa..13e898e 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -126,7 +126,8 @@ class BBCooker:
         bb.data.inheritFromOS(self.configuration.data)
 
         try:
-            self.parseConfigurationFiles(self.configuration.file)
+            self.parseConfigurationFiles(self.configuration.prefile,
+                                         self.configuration.postfile)
         except SyntaxError:
             sys.exit(1)
         except Exception:
@@ -682,10 +683,12 @@ class BBCooker:
     def _findLayerConf(self):
         return self._findConfigFile("bblayers.conf")
 
-    def parseConfigurationFiles(self, files):
+    def parseConfigurationFiles(self, prefiles, postfiles):
         data = self.configuration.data
         bb.parse.init_parser(data)
-        for f in files:
+
+        # Parse files for loading *before* bitbake.conf and any includes
+        for f in prefiles:
             data = _parse(f, data)
 
         layerconf = self._findLayerConf()
@@ -709,6 +712,10 @@ class BBCooker:
 
         data = _parse(os.path.join("conf", "bitbake.conf"), data)
 
+        # Parse files for loading *after* bitbake.conf and any includes
+        for p in postfiles:
+            data = _parse(p, data)
+
         # Handle any INHERITs and inherit the base class
         bbclasses  = ["base"] + (data.getVar('INHERIT', True) or "").split()
         for bbclass in bbclasses:
-- 
1.7.5.4



