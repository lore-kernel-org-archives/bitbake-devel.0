Return-Path: <cristiana.voicu@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 5E2466A901
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:14:36 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga101.ch.intel.com with ESMTP; 20 Jun 2013 04:14:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,904,1363158000"; d="scan'208";a="352865968"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga001.fm.intel.com with ESMTP; 20 Jun 2013 04:14:57 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Jun 2013 14:16:01 +0300
Message-Id: <1371726961-30138-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: check if imageconfiguration page has the attribute 'warnings_bar'
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
X-List-Received-Date: Thu, 20 Jun 2013 11:14:37 -0000

[YOCTO #4571]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index c018d70..1f7453a 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -169,7 +169,8 @@ class ImageConfigurationPage (HobPage):
 
     def disable_warnings_bar(self):
         if self.builder.parsing_warnings:
-            self.warnings_bar.hide_all()
+            if hasattr(self, 'warnings_bar'):
+                self.warnings_bar.hide_all()
             self.builder.parsing_warnings = []
 
     def create_config_machine(self):
-- 
1.7.9.5


