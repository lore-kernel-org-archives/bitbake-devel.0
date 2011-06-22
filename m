Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QZNYH-0000KS-Ms
	for bitbake-devel@lists.openembedded.org;
	Wed, 22 Jun 2011 15:33:06 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 22 Jun 2011 06:28:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,406,1304319600"; d="scan'208";a="16815099"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.17.16])
	by azsmga001.ch.intel.com with ESMTP; 22 Jun 2011 06:28:24 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 Jun 2011 14:28:17 +0100
Message-Id: <4cf8b884528d89b60aede19bda9f291840ce1c34.1308749155.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1308749155.git.paul.eggleton@linux.intel.com>
References: <cover.1308749155.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1308749155.git.paul.eggleton@linux.intel.com>
References: <cover.1308749155.git.paul.eggleton@linux.intel.com>
Subject: [RFC PATCH 2/3] bitbake-layers: add show_overlayed action
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
X-List-Received-Date: Wed, 22 Jun 2011 13:33:06 -0000

Add a show_overlayed action to list overlayed recipes.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 6b5ad5a..fdf6d40 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -73,6 +73,16 @@ class Commands(cmd.Cmd):
     def do_show_layers(self, args):
         logger.info(str(self.config_data.getVar('BBLAYERS', True)))
 
+    def do_show_overlayed(self, args):
+        if self.cooker.overlayedlist:
+            logger.info('Overlayed recipes:')
+            for f in self.cooker.overlayedlist.iterkeys():
+                logger.info('%s' % f)
+                for of in self.cooker.overlayedlist[f]:
+                    logger.info('  %s' % of)
+        else:
+            logger.info('No overlayed recipes found')
+
     def do_show_appends(self, args):
         if not self.cooker_data.appends:
             logger.info('No append files found')
-- 
1.7.4.1



