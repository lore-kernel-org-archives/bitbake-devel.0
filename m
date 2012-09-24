Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TG8w5-0002oa-Db
	for bitbake-devel@lists.openembedded.org;
	Mon, 24 Sep 2012 15:42:57 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 24 Sep 2012 06:30:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,476,1344236400"; d="scan'208";a="225752279"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by fmsmga001.fm.intel.com with ESMTP; 24 Sep 2012 06:30:07 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Sep 2012 16:30:59 +0300
Message-Id: <1348493459-18620-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/packageselectionpage:cancel button should redirect to Image conf screen
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
X-List-Received-Date: Mon, 24 Sep 2012 13:42:57 -0000

Cancel button brings you to Image configuration page.

[YOCTO #3105]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 7e7828b..46bd014 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -187,12 +187,12 @@ class PackageSelectionPage (HobPage):
         self.builder.build_image()
 
     def back_button_clicked_cb(self, button):
-        if self.builder.current_step ==  self.builder.PACKAGE_GENERATED:
-            self.builder.show_configuration()
-        elif self.builder.previous_step ==  self.builder.IMAGE_GENERATED:
+        if self.builder.previous_step ==  self.builder.IMAGE_GENERATED:
             self.builder.restore_initial_selected_packages()
             self.refresh_selection()
             self.builder.show_image_details()
+        else:
+            self.builder.show_configuration()
 
     def _expand_all(self):
         for tab in self.tables:
-- 
1.7.9.5



