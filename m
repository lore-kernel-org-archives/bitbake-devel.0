Return-Path: <cristiana.voicu@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 474AF6A49F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 14:19:37 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 20 Jun 2013 07:19:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,905,1363158000"; d="scan'208";a="320029271"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by azsmga001.ch.intel.com with ESMTP; 20 Jun 2013 07:19:36 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Jun 2013 17:21:16 +0300
Message-Id: <1371738077-13703-2-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1371738077-13703-1-git-send-email-cristiana.voicu@intel.com>
References: <1371738077-13703-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH_V3 2/3] hob: replace the init cooker with reset in order to keep the history
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
X-List-Received-Date: Thu, 20 Jun 2013 14:19:37 -0000

When the cooker initialization is called, the variables history is lost.
It need a reset, in order to load the configuration files.
Also, concatenated the value for INHERIT variable.

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 2f7c496..d5df60f 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -684,12 +684,11 @@ class Builder(gtk.Window):
         self.handler.set_sdk_machine(self.configuration.curr_sdk_machine)
         self.handler.set_image_fstypes(self.configuration.image_fstypes)
         self.handler.set_extra_config(self.configuration.extra_setting)
-        self.handler.set_extra_inherit("packageinfo")
-        self.handler.set_extra_inherit("image_types")
+        self.handler.set_extra_inherit("packageinfo image_types")
         self.set_user_config_proxies()
 
     def set_user_config(self):
-        self.handler.init_cooker()
+        self.handler.reset_cooker()
         # set bb layers
         self.handler.set_bblayers(self.configuration.layers)
         # set local configuration
-- 
1.7.9.5


