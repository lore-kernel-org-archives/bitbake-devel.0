Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1T7Pku-0007Dr-2Q
	for bitbake-devel@lists.openembedded.org;
	Fri, 31 Aug 2012 13:51:20 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 31 Aug 2012 04:37:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,346,1344236400"; d="scan'208";a="187332011"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by azsmga001.ch.intel.com with ESMTP; 31 Aug 2012 04:37:46 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Aug 2012 14:37:58 +0300
Message-Id: <1346413079-3056-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/imageconfigurationpage: Set secondary action for "Edit image" button
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
X-List-Received-Date: Fri, 31 Aug 2012 11:51:20 -0000

The image configuration screen should have only one primary action.
"Edit image" button has now secondary action, and also I have removed
"or" label.

[YOCTO #3010]

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index 6aeb6dc..cecaacb 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -229,12 +229,8 @@ class ImageConfigurationPage (HobPage):
         self.just_bake_button.connect("clicked", self.just_bake_button_clicked_cb)
         button_box.pack_end(self.just_bake_button, expand=False, fill=False)
 
-        # create separator label
-        self.or_label = gtk.Label(" or ")
-        button_box.pack_end(self.or_label, expand=False, fill=False)
-
         # create button "Edit Image"
-        self.edit_image_button = HobButton("Edit image")
+        self.edit_image_button = HobAltButton("Edit image")
         self.edit_image_button.set_size_request(205, 49)
         self.edit_image_button.set_tooltip_text("Edit target image")
         self.edit_image_button.connect("clicked", self.edit_image_button_clicked_cb)
-- 
1.7.9.5



