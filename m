Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S16gK-0007vM-Lh
	for bitbake-devel@lists.openembedded.org;
	Sat, 25 Feb 2012 02:44:16 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 24 Feb 2012 17:34:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="110607572"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.27])
	by azsmga001.ch.intel.com with ESMTP; 24 Feb 2012 17:34:47 -0800
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Feb 2012 17:34:43 -0800
Message-Id: <2f12aba7bb8438c9dd976972f79524dc143dbe7a.1330133412.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <03fda55b89fdc2ddb45a7bc08015989fc0eccb91.1330133412.git.josh@linux.intel.com>
References: <03fda55b89fdc2ddb45a7bc08015989fc0eccb91.1330133412.git.josh@linux.intel.com>
In-Reply-To: <cover.1330133412.git.josh@linux.intel.com>
References: <cover.1330133412.git.josh@linux.intel.com>
Subject: [PATCH 6/6] crumbs/hig: tweak UI and layout of LayerSelectionDialog
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
X-List-Received-Date: Sat, 25 Feb 2012 01:44:16 -0000

Several minor tweaks for appearance:
* Try to rework the labels so that the English flows better
* Fix spacing
* Remove the separator - it's not needed

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hig.py |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index abc4a55..bd611bc 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -518,9 +518,9 @@ class LayerSelectionDialog (CrumbsDialog):
         self.vbox.pack_start(hbox_top, expand=False, fill=False)
 
         if self.split_model:
-            label = HobWidget.gen_label_widget("<span weight=\"bold\" font_desc='12'>Select Layers:</span>\n(Available layers under '${COREBASE}/layers/' directory)")
+            label = HobWidget.gen_label_widget("<b>Select Layers:</b>\n(Available layers under '${COREBASE}/layers/' directory)")
         else:
-            label = HobWidget.gen_label_widget("<span weight=\"bold\" font_desc='12'>Select Layers:</span>")
+            label = HobWidget.gen_label_widget("<b>Select Layers:</b>")
         hbox_top.pack_start(label, expand=False, fill=False)
 
         tooltip = "Layer is a collection of bb files and conf files"
@@ -534,17 +534,9 @@ class LayerSelectionDialog (CrumbsDialog):
 
         self.vbox.pack_start(layer_widget, expand=True, fill=True)
 
-        separator = gtk.HSeparator()
-        self.vbox.pack_start(separator, False, True, 5)
-        separator.show()
-
-        hbox_button = gtk.HBox()
-        self.vbox.pack_end(hbox_button, expand=False, fill=False)
-        hbox_button.show()
-
-        label = HobWidget.gen_label_widget("<i>'meta' is Core layer for Yocto images</i>\n"
-        "<span weight=\"bold\">Please do not remove it</span>")
-        hbox_button.pack_start(label, expand=False, fill=False)
+        label = HobWidget.gen_label_widget("<b>Note:</b> '<i>meta</i>' is the Core layer for Yocto images please do not remove it.")
+        label.show()
+        self.vbox.pack_end(label, expand=False, fill=False)
 
         self.show_all()
 
-- 
1.7.7.6



