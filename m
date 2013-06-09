Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id F25CB621CA
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Jun 2013 10:15:36 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 09 Jun 2013 03:15:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,831,1363158000"; d="scan'208";a="347086930"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.244])
	by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2013 03:16:02 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  9 Jun 2013 11:15:34 +0100
Message-Id: <1370772935-12586-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH 1/2] tinfoil: fix for move of data attribute to cooker
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
X-List-Received-Date: Sun, 09 Jun 2013 10:15:37 -0000

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tinfoil.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 45bac5e..751a2d7 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -49,7 +49,7 @@ class Tinfoil:
         self.config.setConfigParameters(configparams)
         self.config.setServerRegIdleCallback(self.register_idle_function)
         self.cooker = BBCooker(self.config)
-        self.config_data = self.cooker.configuration.data
+        self.config_data = self.cooker.data
         bb.providers.logger.setLevel(logging.ERROR)
         self.cooker_data = None
 
-- 
1.8.1.2


