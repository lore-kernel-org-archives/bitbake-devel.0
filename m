Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UZdCq-0000da-Ej
	for bitbake-devel@lists.openembedded.org;
	Tue, 07 May 2013 10:25:04 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 07 May 2013 01:03:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,627,1363158000"; d="scan'208";a="309420233"
Received: from adinu-vostro-460.rb.intel.com ([10.237.105.57])
	by orsmga001.jf.intel.com with ESMTP; 07 May 2013 01:05:43 -0700
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 May 2013 11:06:34 +0300
Message-Id: <1367913994-25475-1-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] Updated information in tooltips
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
X-List-Received-Date: Tue, 07 May 2013 08:25:05 -0000

Updated information for "Additional free space" and
"Image basic size" to match the description in the
manual.

[HOB #4354]
[HOB #4355]

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 .../lib/bb/ui/crumbs/hig/advancedsettingsdialog.py |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py b/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
index 2911906..bbcaba8 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
@@ -264,7 +264,7 @@ class AdvancedSettingsDialog (CrumbsDialog, SettingsUIHelper):
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("Image basic size (in MB)")
-        tooltip = "Sets the basic size of your target image.\nThis is the basic size of your target image unless your selected package size exceeds this value or you select \'Image Extra Size\'."
+        tooltip = "Defines the size for the generated image. The OpenEmbedded build system determines the final size for the generated image using an algorithm that takes into account the initial disk space used for the generated image, the Image basic size value, and the Additional free space value.\n\nFor more information, check the <a href=\"http://www.yoctoproject.org/docs/current/poky-ref-manual/poky-ref-manual.html#var-IMAGE_ROOTFS_SIZE\">Yocto Project Reference Manual</a>."
         rootfs_size_widget, self.rootfs_size_spinner = self.gen_spinner_widget(int(self.configuration.image_rootfs_size*1.0/1024), 0, 65536,"<b>Image basic size</b>" + "*" + tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(rootfs_size_widget, expand=False, fill=False)
@@ -272,7 +272,7 @@ class AdvancedSettingsDialog (CrumbsDialog, SettingsUIHelper):
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("Additional free space (in MB)")
-        tooltip = "Sets the extra free space of your target image.\nBy default, the system reserves 30% of your image size as free space. If your image contains zypper, it brings in 50MB more space. The maximum free space is 64GB."
+        tooltip = "Sets extra free disk space to be added to the generated image. Use this variable when you want to ensure that a specific amount of free disk space is available on a device after an image is installed and running."
         extra_size_widget, self.extra_size_spinner = self.gen_spinner_widget(int(self.configuration.image_extra_size*1.0/1024), 0, 65536,"<b>Additional free space</b>" + "*" + tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(extra_size_widget, expand=False, fill=False)
-- 
1.7.9.5



