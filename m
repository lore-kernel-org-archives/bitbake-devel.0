Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1U2NeN-00057O-Vf
	for bitbake-devel@lists.openembedded.org;
	Mon, 04 Feb 2013 16:08:05 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 04 Feb 2013 06:52:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,600,1355126400"; d="scan'208";a="198494000"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by AZSMGA002.ch.intel.com with ESMTP; 04 Feb 2013 06:52:13 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  4 Feb 2013 16:56:00 +0200
Message-Id: <1359989760-16394-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: remove parsing warnings when machine is changed
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
X-List-Received-Date: Mon, 04 Feb 2013 15:08:19 -0000

When the machine is changed, the warnings list is emptied and the warnings
bar is hidden.

[YOCTO #3830]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index df7a017..956f5ce 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -173,6 +173,11 @@ class ImageConfigurationPage (HobPage):
 
         return warnings_bar
 
+    def disable_warnings_bar(self):
+        if self.builder.parsing_warnings:
+            self.warnings_bar.hide_all()
+            self.builder.parsing_warnings = []
+
     def create_config_machine(self):
         self.machine_title = gtk.Label()
         self.machine_title.set_alignment(0.0, 0.5)
@@ -319,6 +324,7 @@ class ImageConfigurationPage (HobPage):
         self.builder.populate_recipe_package_info_async()
 
     def update_machine_combo(self):
+        self.disable_warnings_bar()
         all_machines = [self.__dummy_machine__] + self.builder.parameters.all_machines
 
         model = self.machine_combo.get_model()
@@ -328,6 +334,7 @@ class ImageConfigurationPage (HobPage):
         self.machine_combo.set_active(0)
 
     def switch_machine_combo(self):
+        self.disable_warnings_bar()
         self.machine_combo_changed_by_manual = False
         model = self.machine_combo.get_model()
         active = 0
-- 
1.7.9.5



