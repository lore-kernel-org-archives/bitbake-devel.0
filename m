Return-Path: <cristiana.voicu@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id E5E056B451
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Jul 2013 11:57:34 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 30 Jul 2013 04:57:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,778,1367996400"; d="scan'208";a="338975165"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by azsmga001.ch.intel.com with ESMTP; 30 Jul 2013 04:57:33 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Jul 2013 15:00:08 +0300
Message-Id: <1375185608-18951-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/packageslist: change image size label to estimated image size
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
X-List-Received-Date: Tue, 30 Jul 2013 11:57:35 -0000

On the "Edit packages list" page, the image size may be computed before
building. We didn't find another way to give a more accurate size, so
we have agreed to inform the user that this an estimated size.

[YOCTO #4388]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 70caa48..780f026 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -278,7 +278,7 @@ class PackageSelectionPage (HobPage):
                 image_total_size += (51200 * 1024)
             image_total_size_str = HobPage._size_to_string(image_total_size)
 
-        self.label.set_label("Packages included: %s\nSelected packages size: %s\nTotal image size: %s" %
+        self.label.set_label("Packages included: %s\nSelected packages size: %s\nEstimated image size: %s" %
                             (selected_packages_num, selected_packages_size_str, image_total_size_str))
         self.ins.show_indicator_icon("Included packages", selected_packages_num)
 
-- 
1.7.9.5


