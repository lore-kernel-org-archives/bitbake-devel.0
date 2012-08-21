Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1T3sBa-0001jx-2U
	for bitbake-devel@lists.openembedded.org;
	Tue, 21 Aug 2012 19:24:15 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by fmsmga102.fm.intel.com with ESMTP; 21 Aug 2012 10:12:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,803,1336374000"; d="scan'208";a="136563937"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.105])
	by AZSMGA002.ch.intel.com with ESMTP; 21 Aug 2012 10:12:09 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Aug 2012 18:11:46 +0100
Message-Id: <b3a23c6e0370290e2ab9c411c74c2607d9614118.1345568965.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1345568965.git.paul.eggleton@linux.intel.com>
References: <cover.1345568965.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1345568965.git.paul.eggleton@linux.intel.com>
References: <cover.1345568965.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/3] bitbake-layers: avoid full parse for show-layers subcommand
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
X-List-Received-Date: Tue, 21 Aug 2012 17:24:15 -0000

We don't actually need to parse all recipes just to show the configured
layers, so just parse the configuration instead.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 1dacc25..6d18d94 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -86,9 +86,13 @@ class Commands(cmd.Cmd):
         self.cooker_data = self.cooker.status
         self.cooker_data.appends = self.cooker.appendlist
 
-    def check_prepare_cooker(self):
+    def check_prepare_cooker(self, config_only = False):
         if not self.cooker_data:
-            self.prepare_cooker()
+            if config_only:
+                self.cooker.parseConfiguration()
+                self.cooker_data = self.cooker.status
+            else:
+                self.prepare_cooker()
 
     def default(self, line):
         """Handle unrecognised commands"""
@@ -113,8 +117,7 @@ class Commands(cmd.Cmd):
 
     def do_show_layers(self, args):
         """show current configured layers"""
-        self.check_prepare_cooker()
-        logger.plain('')
+        self.check_prepare_cooker(config_only = True)
         logger.plain("%s  %s  %s" % ("layer".ljust(20), "path".ljust(40), "priority"))
         logger.plain('=' * 74)
         for layerdir in self.bblayers:
-- 
1.7.9.5



