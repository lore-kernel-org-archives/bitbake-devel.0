Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SK3rR-00057Y-VL
	for bitbake-devel@lists.openembedded.org;
	Tue, 17 Apr 2012 10:34:06 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 17 Apr 2012 01:24:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="131810607"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 17 Apr 2012 01:24:40 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 17 Apr 2012 16:21:38 +0800
Message-Id: <8ff5c44cb638a4aa9e2fc5581e15863bc9fcb516.1334650694.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1334650694.git.dongxiao.xu@intel.com>
References: <cover.1334650694.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1334650694.git.dongxiao.xu@intel.com>
References: <cover.1334650694.git.dongxiao.xu@intel.com>
Subject: [PATCH 3/4] Hob: Enlarge the upper value of image size
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
X-List-Received-Date: Tue, 17 Apr 2012 08:34:06 -0000

Originally the upper value for image size and extra size is 1024M, which
is relatively small. Enlarge it to 64GB.

Besides, fix tooltip for toolchain build.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hig.py |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index a85b478..93a4fbc 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -423,15 +423,15 @@ class AdvancedSettingDialog (CrumbsDialog):
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">Image rootfs size: (MB)</span>")
         tooltip = "Sets the basic size of your target image.\nThis is the basic size of your target image unless your selected package size exceeds this value or you select \'Image Extra Size\'."
-        rootfs_size_widget, self.rootfs_size_spinner = self.gen_spinner_widget(int(self.configuration.image_rootfs_size*1.0/1024), 0, 1024, tooltip)
+        rootfs_size_widget, self.rootfs_size_spinner = self.gen_spinner_widget(int(self.configuration.image_rootfs_size*1.0/1024), 0, 65536, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(rootfs_size_widget, expand=False, fill=False)
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">Image extra size: (MB)</span>")
-        tooltip = "Sets the extra free space of your target image.\nBy default, the system reserves 30% of your image size as free space. If your image contains zypper, it brings in 50MB more space. The maximum free space is 1024MB."
-        extra_size_widget, self.extra_size_spinner = self.gen_spinner_widget(int(self.configuration.image_extra_size*1.0/1024), 0, 1024, tooltip)
+        tooltip = "Sets the extra free space of your target image.\nBy default, the system reserves 30% of your image size as free space. If your image contains zypper, it brings in 50MB more space. The maximum free space is 64GB."
+        extra_size_widget, self.extra_size_spinner = self.gen_spinner_widget(int(self.configuration.image_extra_size*1.0/1024), 0, 65536, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(extra_size_widget, expand=False, fill=False)
 
@@ -450,7 +450,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         self.toolchain_checkbox.set_active(self.configuration.toolchain_build)
         sub_hbox.pack_start(self.toolchain_checkbox, expand=False, fill=False)
 
-        tooltip = "Selects the Host platform for which you want to run the toolchain"
+        tooltip = "Selects the host platform for which you want to run the toolchain"
         sdk_machine_widget, self.sdk_machine_combo = self.gen_combo_widget(self.configuration.curr_sdk_machine, self.all_sdk_machines, tooltip)
         sub_hbox.pack_start(sdk_machine_widget, expand=False, fill=False)
 
-- 
1.7.4.1



