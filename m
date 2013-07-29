Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id C0770612D1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jul 2013 08:19:54 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 29 Jul 2013 01:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,767,1367996400"; d="scan'208";a="378174465"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.206])
	by orsmga002.jf.intel.com with ESMTP; 29 Jul 2013 01:19:54 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Jul 2013 09:19:41 +0100
Message-Id: <6bfd753b6957f1423f22dd5613d3086dd767b3b7.1375085732.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1375085732.git.paul.eggleton@linux.intel.com>
References: <cover.1375085732.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1375085732.git.paul.eggleton@linux.intel.com>
References: <cover.1375085732.git.paul.eggleton@linux.intel.com>
Subject: [1.18][PATCH 1/2] hob: save the base image name for the customized images
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
X-List-Received-Date: Mon, 29 Jul 2013 08:19:54 -0000

From: Cristiana Voicu <cristiana.voicu@intel.com>

Building an image, after customizing it, was failing because the base
image was not saved.

[YOCTO #4751]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 66cb7ff..8452273 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -288,6 +288,7 @@ class PackageSelectionPage (HobPage):
         self.refresh_selection()
         if not self.builder.customized:
             self.builder.customized = True
+            self.builder.configuration.initial_selected_image = self.builder.configuration.selected_image
             self.builder.configuration.selected_image = self.recipe_model.__custom_image__
             self.builder.rcppkglist_populated()
 
-- 
1.8.1.2


