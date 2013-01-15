Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1Tv81O-0006nK-3O
	for bitbake-devel@lists.openembedded.org;
	Tue, 15 Jan 2013 16:01:59 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 15 Jan 2013 06:46:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,473,1355126400"; d="scan'208";a="244151893"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by azsmga001.ch.intel.com with ESMTP; 15 Jan 2013 06:46:27 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 15 Jan 2013 16:50:39 +0200
Message-Id: <1358261439-1943-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: combo box updated correctly
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
X-List-Received-Date: Tue, 15 Jan 2013 15:01:59 -0000

The 'select a base image' option is no longer displayed once
an image is selected

[YOCTO #3671]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index b94f35c..e28d416 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -363,7 +363,7 @@ class ImageConfigurationPage (HobPage):
         image_model = recipe_model.tree_model(filter)
         image_model.set_sort_column_id(recipe_model.COL_NAME, gtk.SORT_ASCENDING)
         active = 0
-        cnt = 1
+        cnt = 0
 
         white_pattern = []
         if self.builder.parameters.image_white_pattern:
@@ -381,7 +381,10 @@ class ImageConfigurationPage (HobPage):
         model = self.image_combo.get_model()
         model.clear()
         # Set a indicator text to combo store when first open
-        self.image_combo.append_text(self.__dummy_image__)
+        if not selected_image:
+            self.image_combo.append_text(self.__dummy_image__)
+            cnt = cnt + 1
+
         # append and set active
         while it:
             path = image_model.get_path(it)
-- 
1.7.9.5



