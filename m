Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S2kIb-0005TM-DA
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 15:14:33 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 29 Feb 2012 06:05:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="113066705"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 29 Feb 2012 06:04:50 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Feb 2012 22:15:14 +0800
Message-Id: <eb98b6eb22a5eb8531923722f0c8afb9e24ccb48.1330523904.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
In-Reply-To: <cover.1330523904.git.shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
Subject: [PATCH 17/32] hig: try to avoid setting explicit dialogue sizes
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
X-List-Received-Date: Wed, 29 Feb 2012 14:14:33 -0000

Gtk+ does a good job of creating dialogues which fit all of the packed
widgets and respect the spacing. Let it do its job.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index ec9dbec..6776b3d 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -468,8 +468,6 @@ class AdvancedSettingDialog (CrumbsDialog):
         self.connect("response", self.response_cb)
 
     def create_visual_elements(self):
-        self.set_size_request(500, 500)
-
         self.nb = gtk.Notebook()
         self.nb.set_show_tabs(True)
         self.nb.append_page(self.create_image_types_page(), gtk.Label("Image types"))
@@ -700,8 +698,6 @@ class DeployImageDialog (CrumbsDialog):
         self.connect("response", self.response_cb)
 
     def create_visual_elements(self):
-        self.set_default_size(500, 250)
-
         label = gtk.Label()
         label.set_alignment(0.0, 0.5)
         markup = "<span font_desc='12'>The image to be written into usb drive:</span>"
@@ -947,7 +943,6 @@ class LayerSelectionDialog (CrumbsDialog):
         self.connect("response", self.response_cb)
                 
     def create_visual_elements(self):
-        self.set_default_size(400, 250)
         hbox_top = gtk.HBox()
         self.vbox.pack_start(hbox_top, expand=False, fill=False)
 
@@ -964,6 +959,7 @@ class LayerSelectionDialog (CrumbsDialog):
         hbox_top.pack_end(image, expand=False, fill=False)
 
         layer_widget, self.layer_store = self.gen_layer_widget(self.split_model, self.layers, self.all_layers, self, None)
+        layer_widget.set_size_request(-1, 180)
 
         self.vbox.pack_start(layer_widget, expand=True, fill=True)
 
@@ -1031,6 +1027,7 @@ class ImageSelectionDialog (CrumbsDialog):
 
     def create_visual_elements(self):
         hbox = gtk.HBox(False, 6)
+
         self.vbox.pack_start(hbox, expand=False, fill=False)
 
         entry = gtk.Entry()
-- 
1.7.6



