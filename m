Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QruRm-0007rD-Ll
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 18:18:59 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 12 Aug 2011 09:14:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,363,1309762800"; d="scan'208";a="38827068"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.18.64])
	by fmsmga002.fm.intel.com with ESMTP; 12 Aug 2011 09:14:05 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Aug 2011 17:13:59 +0100
Message-Id: <eb0754914f76dec08c182a4e04abc769b81161b7.1313165343.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1313165343.git.paul.eggleton@linux.intel.com>
References: <cover.1313165343.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1313165343.git.paul.eggleton@linux.intel.com>
References: <cover.1313165343.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 4/4] bitbake-layers: extend show_layers
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
X-List-Received-Date: Fri, 12 Aug 2011 16:19:00 -0000

Make show_layers print layer name, path, and priority in a simple table
rather than just the value of BBLAYERS.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index aea8f93..ce6a03e 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -102,7 +102,20 @@ class Commands(cmd.Cmd):
     def do_show_layers(self, args):
         """show current configured layers"""
         self.check_prepare_cooker()
-        logger.plain(str(self.config_data.getVar('BBLAYERS', True)))
+        logger.plain('')
+        logger.plain("%s  %s  %s" % ("layer".ljust(20), "path".ljust(40), "priority"))
+        logger.plain('=' * 74)
+        layerdirs = str(self.config_data.getVar('BBLAYERS', True)).split()
+        for layerdir in layerdirs:
+            layername = '?'
+            layerpri = 0
+            for layer, _, regex, pri in self.cooker.status.bbfile_config_priorities:
+                if regex.match(os.path.join(layerdir, 'test')):
+                    layername = layer
+                    layerpri = pri
+                    break
+
+            logger.plain("%s  %s  %d" % (layername.ljust(20), layerdir.ljust(40), layerpri))
 
     def do_show_overlayed(self, args):
         """list overlayed recipes (where there is a recipe in another layer that has a higher layer priority)
-- 
1.7.4.1



