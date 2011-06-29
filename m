Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Qbzhe-0000gm-QU
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Jun 2011 20:41:34 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 29 Jun 2011 11:37:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,444,1304319600"; d="scan'208";a="24396424"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.17.126])
	by fmsmga001.fm.intel.com with ESMTP; 29 Jun 2011 11:37:48 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Jun 2011 19:37:38 +0100
Message-Id: <79e83e4d654aa28de6072d3bc82e9106da7f8bbe.1309372176.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1309372176.git.paul.eggleton@linux.intel.com>
References: <cover.1309372176.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1309372176.git.paul.eggleton@linux.intel.com>
References: <cover.1309372176.git.paul.eggleton@linux.intel.com>
Subject: [RFC PATCH 2/5] bitbake-layers: add show_overlayed action
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
X-List-Received-Date: Wed, 29 Jun 2011 18:41:35 -0000

Add a show_overlayed action to list overlayed recipes.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 6b5ad5a..fced88e 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -73,6 +73,16 @@ class Commands(cmd.Cmd):
     def do_show_layers(self, args):
         logger.info(str(self.config_data.getVar('BBLAYERS', True)))
 
+    def do_show_overlayed(self, args):
+        if self.cooker.overlayed:
+            logger.info('Overlayed recipes:')
+            for f in self.cooker.overlayed.iterkeys():
+                logger.info('%s' % f)
+                for of in self.cooker.overlayed[f]:
+                    logger.info('  %s' % of)
+        else:
+            logger.info('No overlayed recipes found')
+
     def do_show_appends(self, args):
         if not self.cooker_data.appends:
             logger.info('No append files found')
-- 
1.7.4.1



