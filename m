Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SEJrC-00046R-ER
	for bitbake-devel@lists.openembedded.org;
	Sun, 01 Apr 2012 14:26:06 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 01 Apr 2012 05:16:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="127498336"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 01 Apr 2012 05:16:58 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  1 Apr 2012 20:14:16 +0800
Message-Id: <f25626adfda64c6d85ee1f562c67554b8d927942.1333269705.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333269705.git.dongxiao.xu@intel.com>
References: <cover.1333269705.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333269705.git.dongxiao.xu@intel.com>
References: <cover.1333269705.git.dongxiao.xu@intel.com>
Subject: [PATCH 08/10] Hob: Check "dummy" image while update_image_combo
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
X-List-Received-Date: Sun, 01 Apr 2012 12:26:06 -0000

We also need to check if the selected image is "Create your own image"
and set it as active.

Besides, to avoid the impact of set_active(), we need to move the
connect signal in the end of the update_image_combo() function.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/imageconfigurationpage.py |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index 30f8979..9271c48 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -338,11 +338,17 @@ class ImageConfigurationPage (HobPage):
                 active = cnt
             cnt = cnt + 1
         self.image_combo.append_text(self.builder.recipe_model.__dummy_image__)
-        self._image_combo_connect_signal()
+        if selected_image == self.builder.recipe_model.__dummy_image__:
+            active = cnt
 
         self.image_combo.set_active(-1)
         self.image_combo.set_active(active)
 
+        if active != -1:
+            self.show_baseimg_selected()
+
+        self._image_combo_connect_signal()
+
     def layer_button_clicked_cb(self, button):
         # Create a layer selection dialog
         self.builder.show_layer_selection_dialog()
-- 
1.7.4.1



