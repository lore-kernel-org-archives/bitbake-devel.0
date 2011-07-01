Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QcWtR-0007r2-KR
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jul 2011 08:07:57 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 30 Jun 2011 23:03:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,456,1304319600"; d="scan'208";a="21321707"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.228])
	by azsmga001.ch.intel.com with ESMTP; 30 Jun 2011 23:03:06 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jun 2011 23:02:50 -0700
Message-Id: <5556caea9263fb625bae90248e6967664862086c.1309499228.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1309499227.git.josh@linux.intel.com>
References: <cover.1309499227.git.josh@linux.intel.com>
In-Reply-To: <cover.1309499227.git.josh@linux.intel.com>
References: <cover.1309499227.git.josh@linux.intel.com>
Subject: [PATCH 04/10] cooker: add generic method to locate configuration files
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
X-List-Received-Date: Fri, 01 Jul 2011 06:07:57 -0000

Convert _findLayerConf(self) to _findConfigFile(self, configfile) so that
the core functionality of the method can be used elsewhere.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/cooker.py |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 4ad1536..94acce6 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -643,15 +643,18 @@ class BBCooker:
         else:
             shell.start( self )
 
-    def _findLayerConf(self):
+    def _findConfigFile(self, configfile):
         path = os.getcwd()
         while path != "/":
-            bblayers = os.path.join(path, "conf", "bblayers.conf")
-            if os.path.exists(bblayers):
-                return bblayers
+            confpath = os.path.join(path, "conf", configfile)
+            if os.path.exists(confpath):
+                return confpath
 
             path, _ = os.path.split(path)
 
+    def _findLayerConf(self):
+        return self._findConfigFile("bblayers.conf")
+
     def parseConfigurationFiles(self, files):
         data = self.configuration.data
         bb.parse.init_parser(data)
-- 
1.7.5.4



