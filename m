Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TO5QZ-0007Yj-BC
	for bitbake-devel@lists.openembedded.org;
	Tue, 16 Oct 2012 13:35:15 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 16 Oct 2012 04:21:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,593,1344236400"; d="scan'208";a="234467245"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by fmsmga001.fm.intel.com with ESMTP; 16 Oct 2012 04:21:56 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 16 Oct 2012 14:23:27 +0300
Message-Id: <1350386607-21309-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/imageconfigurationpage: progress bar shows when recipe parsing is stopped
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
X-List-Received-Date: Tue, 16 Oct 2012 11:35:15 -0000

-when the recipe parsing process is stopped, the progress bar shows
"Stopping recipe parsing"

[YOCTO #3259]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index 8988df0..37a3e15 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -45,6 +45,7 @@ class ImageConfigurationPage (HobPage):
         # or by manual. If by manual, all user's recipe selection and package selection are
         # cleared.
         self.machine_combo_changed_by_manual = True
+        self.stopping = False
         self.create_visual_elements()
 
     def create_visual_elements(self):
@@ -114,9 +115,10 @@ class ImageConfigurationPage (HobPage):
         self.show_all()
 
     def update_progress_bar(self, title, fraction, status=None):
-        self.progress_bar.update(fraction)
-        self.progress_bar.set_title(title)
-        self.progress_bar.set_rcstyle(status)
+        if self.stopping == False:
+            self.progress_bar.update(fraction)
+            self.progress_bar.set_title(title)
+            self.progress_bar.set_rcstyle(status)
 
     def show_info_populating(self):
         self._pack_components(pack_config_build_button = False)
@@ -248,9 +250,13 @@ class ImageConfigurationPage (HobPage):
         return button_box
 
     def stop_button_clicked_cb(self, button):
+        self.stopping = True
+        self.progress_bar.set_text("Stopping recipe parsing")
+        self.progress_bar.set_rcstyle("stop")
         self.builder.cancel_parse_sync()
 
     def machine_combo_changed_cb(self, machine_combo):
+        self.stopping = False
         combo_item = machine_combo.get_active_text()
         if not combo_item or combo_item == self.__dummy_machine__:
             return
-- 
1.7.9.5



