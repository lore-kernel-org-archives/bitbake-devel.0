Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S16gK-0007uz-JZ
	for bitbake-devel@lists.openembedded.org;
	Sat, 25 Feb 2012 02:44:16 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 24 Feb 2012 17:34:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="110607570"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.27])
	by azsmga001.ch.intel.com with ESMTP; 24 Feb 2012 17:34:46 -0800
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Feb 2012 17:34:42 -0800
Message-Id: <214726b459dd4bff0c96496dc0c067b31234e646.1330133412.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <03fda55b89fdc2ddb45a7bc08015989fc0eccb91.1330133412.git.josh@linux.intel.com>
References: <03fda55b89fdc2ddb45a7bc08015989fc0eccb91.1330133412.git.josh@linux.intel.com>
In-Reply-To: <cover.1330133412.git.josh@linux.intel.com>
References: <cover.1330133412.git.josh@linux.intel.com>
Subject: [PATCH 5/6] hig: try to avoid setting explicit dialogue sizes
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

Gtk+ does a good job of creating dialogues which fit all of the packed
widgets and respect the spacing. Let it do its job.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hig.py |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 6d9bc5c..abc4a55 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -160,8 +160,6 @@ class AdvancedSettingDialog (CrumbsDialog):
         self.connect("response", self.response_cb)
 
     def create_visual_elements(self):
-        self.set_size_request(500, 500)
-
         self.nb = gtk.Notebook()
         self.nb.set_show_tabs(True)
         self.nb.append_page(self.create_image_types_page(), gtk.Label("Image types"))
@@ -392,8 +390,6 @@ class DeployImageDialog (CrumbsDialog):
         self.connect("response", self.response_cb)
 
     def create_visual_elements(self):
-        self.set_default_size(500, 250)
-
         label = gtk.Label()
         label.set_alignment(0.0, 0.5)
         markup = "<span font_desc='12'>The image to be written into usb drive:</span>"
@@ -518,7 +514,6 @@ class LayerSelectionDialog (CrumbsDialog):
         self.connect("response", self.response_cb)
                 
     def create_visual_elements(self):
-        self.set_default_size(400, 250)
         hbox_top = gtk.HBox()
         self.vbox.pack_start(hbox_top, expand=False, fill=False)
 
@@ -535,6 +530,7 @@ class LayerSelectionDialog (CrumbsDialog):
         hbox_top.pack_end(image, expand=False, fill=False)
 
         layer_widget, self.layer_store = HobWidget.gen_layer_widget(self.split_model, self.layers, self.all_layers, self, None)
+        layer_widget.set_size_request(-1, 180)
 
         self.vbox.pack_start(layer_widget, expand=True, fill=True)
 
@@ -586,6 +582,7 @@ class ImageSelectionDialog (CrumbsDialog):
 
     def create_visual_elements(self):
         hbox = gtk.HBox(False, 6)
+
         self.vbox.pack_start(hbox, expand=False, fill=False)
 
         entry = gtk.Entry()
-- 
1.7.7.6



