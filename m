Return-Path: <irina.patru@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id D77B36C742
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Jan 2014 09:46:01 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 23 Jan 2014 01:45:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,705,1384329600"; d="scan'208";a="463399791"
Received: from irina-vostro-460.rb.intel.com ([10.237.105.140])
	by fmsmga001.fm.intel.com with ESMTP; 23 Jan 2014 01:45:50 -0800
From: Irina Patru <irina.patru@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Jan 2014 11:49:43 +0200
Message-Id: <1390470583-30319-2-git-send-email-irina.patru@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1390470583-30319-1-git-send-email-irina.patru@intel.com>
References: <y>
 <1390470583-30319-1-git-send-email-irina.patru@intel.com>
Subject: [PATCH 2/2] hob: No need for enable_proxy and same_proxy in conf file
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 23 Jan 2014 09:46:02 -0000

Hob doesn't read these variable from file and bitbake doesn't use them,
so they shouldn't be set in conf file.

Signed-off-by: Irina Patru <irina.patru@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |    2 --
 1 file changed, 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 7bc3227..1e26d44 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -227,8 +227,6 @@ class Configuration:
             handler.set_var_in_file("DEPENDS", self.selected_recipes, "local.conf")
             handler.set_var_in_file("IMAGE_INSTALL", self.user_selected_packages, "local.conf")
         # proxy
-        handler.set_var_in_file("enable_proxy", self.enable_proxy, "local.conf")
-        handler.set_var_in_file("use_same_proxy", self.same_proxy, "local.conf")
         if self.enable_proxy == True:
             handler.set_var_in_file("http_proxy", self.combine_proxy("http"), "local.conf")
             handler.set_var_in_file("https_proxy", self.combine_proxy("https"), "local.conf")
-- 
1.7.9.5


