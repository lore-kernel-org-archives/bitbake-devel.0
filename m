Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qomj7-0000xE-3r
	for bitbake-devel@lists.openembedded.org;
	Thu, 04 Aug 2011 03:27:57 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 03 Aug 2011 18:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,313,1309762800"; d="scan'208";a="34155902"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.173])
	by orsmga002.jf.intel.com with ESMTP; 03 Aug 2011 18:23:30 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  3 Aug 2011 18:23:22 -0700
Message-Id: <5f079f11ca626a4a11ad728c56bde21009ddd7c8.1312420894.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312420894.git.josh@linux.intel.com>
References: <cover.1312420894.git.josh@linux.intel.com>
In-Reply-To: <cover.1312420894.git.josh@linux.intel.com>
References: <cover.1312420894.git.josh@linux.intel.com>
Subject: [PATCH 6/6] bb/ui/hob: be clear that the image contents are an estimate
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
X-List-Received-Date: Thu, 04 Aug 2011 01:27:57 -0000

Partially addresses [YOCTO #1263]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 5a4ac78..a38868f 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -804,6 +804,14 @@ class MainWindow (gtk.Window):
         menubar.show_all()
 
         return menubar
+
+    def info_button_clicked_cb(self, button):
+        info = "We cannot accurately predict the image contents before they are built so instead a best"
+        info = info + "  attempt at estimating what the image will contain is listed."
+        dialog = CrumbsDialog(self, info, gtk.STOCK_DIALOG_INFO)
+        dialog.add_buttons(gtk.STOCK_CLOSE, gtk.RESPONSE_OK)
+        resp = dialog.run()
+        dialog.destroy()
     
     def create_build_gui(self):
         vbox = gtk.VBox(False, 12)
@@ -847,11 +855,19 @@ class MainWindow (gtk.Window):
         ins.set_current_page(0)
         ins.show_all()
 
-        label = gtk.Label("Image contents:")
+        hbox = gtk.HBox(False, 1)
+        hbox.show()
+        label = gtk.Label("Estimated image contents:")
         self.model.connect("contents-changed", self.update_package_count_cb, label)
         label.set_property("xalign", 0.00)
         label.show()
-        vbox.pack_start(label, expand=False, fill=False, padding=6)
+        hbox.pack_start(label, expand=False, fill=False, padding=6)
+        info = gtk.Button("?")
+        info.set_tooltip_text("What does this mean?")
+        info.show()
+        info.connect("clicked", self.info_button_clicked_cb)
+        hbox.pack_start(info, expand=False, fill=False, padding=6)
+        vbox.pack_start(hbox, expand=False, fill=False, padding=6)
         con = self.contents()
         con.show()
         vbox.pack_start(con, expand=True, fill=True)
@@ -873,7 +889,7 @@ class MainWindow (gtk.Window):
         return vbox
 
     def update_package_count_cb(self, model, count, label):
-        lbl = "Image contents (%s packages):" % count
+        lbl = "Estimated image contents (%s packages):" % count
         label.set_text(lbl)
 
     def contents(self):
-- 
1.7.6



