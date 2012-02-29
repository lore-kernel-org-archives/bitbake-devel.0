Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S2kIc-0005TM-7n
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 15:14:34 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 29 Feb 2012 06:05:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="113066711"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 29 Feb 2012 06:04:51 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Feb 2012 22:15:15 +0800
Message-Id: <2254c21172db997ffa4f30a5666a684db7911c3a.1330523904.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
In-Reply-To: <cover.1330523904.git.shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
Subject: [PATCH 18/32] crumbs/hig: tweak UI and layout of LayerSelectionDialog
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
X-List-Received-Date: Wed, 29 Feb 2012 14:14:34 -0000

Several minor tweaks for appearance:
* Try to rework the labels so that the English flows better
* Fix spacing
* Remove the separator - it's not needed

Signed-off-by: Joshua Lock <josh@linux.intel.com>
Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 6776b3d..9b96d8d 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -947,9 +947,9 @@ class LayerSelectionDialog (CrumbsDialog):
         self.vbox.pack_start(hbox_top, expand=False, fill=False)
 
         if self.split_model:
-            label = self.gen_label_widget("<span weight=\"bold\" font_desc='12'>Select Layers:</span>\n(Available layers under '${COREBASE}/layers/' directory)")
+            label = self.gen_label_widget("<b>Select Layers:</b>\n(Available layers under '${COREBASE}/layers/' directory)")
         else:
-            label = self.gen_label_widget("<span weight=\"bold\" font_desc='12'>Select Layers:</span>")
+            label = self.gen_label_widget("<b>Select Layers:</b>")
         hbox_top.pack_start(label, expand=False, fill=False)
 
         tooltip = "Layer is a collection of bb files and conf files"
@@ -960,20 +960,11 @@ class LayerSelectionDialog (CrumbsDialog):
 
         layer_widget, self.layer_store = self.gen_layer_widget(self.split_model, self.layers, self.all_layers, self, None)
         layer_widget.set_size_request(-1, 180)
-
         self.vbox.pack_start(layer_widget, expand=True, fill=True)
 
-        separator = gtk.HSeparator()
-        self.vbox.pack_start(separator, False, True, 5)
-        separator.show()
-
-        hbox_button = gtk.HBox()
-        self.vbox.pack_end(hbox_button, expand=False, fill=False)
-        hbox_button.show()
-
-        label = self.gen_label_widget("<i>'meta' is Core layer for Yocto images</i>\n"
-        "<span weight=\"bold\">Please do not remove it</span>")
-        hbox_button.pack_start(label, expand=False, fill=False)
+        label = self.gen_label_widget("<b>Note:</b> '<i>meta</i>' is the Core layer for Yocto images please do not remove it.")
+        label.show()
+        self.vbox.pack_end(label, expand=False, fill=False)
 
         self.show_all()
 
-- 
1.7.6



