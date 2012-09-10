Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TAzt6-0005Og-Ib
	for bitbake-devel@lists.openembedded.org;
	Mon, 10 Sep 2012 11:02:36 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 10 Sep 2012 01:49:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,396,1344236400"; d="scan'208";a="200653162"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by orsmga002.jf.intel.com with ESMTP; 10 Sep 2012 01:49:01 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Sep 2012 11:49:27 +0300
Message-Id: <1347266967-18969-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/imageconfigurationpage: remove or_label reference
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
X-List-Received-Date: Mon, 10 Sep 2012 09:02:36 -0000

When or_label was removed, I forgot to remove also the references to it.

[YOCTO #3010]

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    2 --
 1 file changed, 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index cecaacb..65c88cd 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -138,7 +138,6 @@ class ImageConfigurationPage (HobPage):
         self.show_all()
         if self.builder.recipe_model.get_selected_image() == self.builder.recipe_model.__custom_image__:
             self.just_bake_button.hide()
-            self.or_label.hide()
 
     def create_config_machine(self):
         self.machine_title = gtk.Label()
@@ -329,7 +328,6 @@ class ImageConfigurationPage (HobPage):
 
         if selected_image == self.builder.recipe_model.__custom_image__:
             self.just_bake_button.hide()
-            self.or_label.hide()
 
         glib.idle_add(self.image_combo_changed_idle_cb, selected_image, selected_recipes, selected_packages)
 
-- 
1.7.9.5



