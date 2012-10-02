Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TJ3IA-0003Fb-OJ
	for bitbake-devel@lists.openembedded.org;
	Tue, 02 Oct 2012 16:17:47 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 02 Oct 2012 07:04:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,523,1344236400"; d="scan'208";a="151512215"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by AZSMGA002.ch.intel.com with ESMTP; 02 Oct 2012 07:04:45 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  2 Oct 2012 17:05:51 +0300
Message-Id: <1349186751-22197-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/settings: alignment and spacing fixes on "Shared state" tab
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
X-List-Received-Date: Tue, 02 Oct 2012 14:17:47 -0000

-alignment and separation on vertical and horizontal axis
-change controls width
[YOCTO #3188]

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |   72 +++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 2ef8e36..8ef1249 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -112,17 +112,18 @@ class SettingsUIHelper():
         hbox = gtk.HBox(False, 12)
         entry = gtk.Entry()
         entry.set_text(content)
+        entry.set_size_request(350,30)
 
         if need_button:
-            table = gtk.Table(1, 10, True)
+            table = gtk.Table(1, 10, False)
             hbox.pack_start(table, expand=True, fill=True)
-            table.attach(entry, 0, 9, 0, 1)
+            table.attach(entry, 0, 9, 0, 1, xoptions=gtk.SHRINK)
             image = gtk.Image()
             image.set_from_stock(gtk.STOCK_OPEN,gtk.ICON_SIZE_BUTTON)
             open_button = gtk.Button()
             open_button.set_image(image)
             open_button.connect("clicked", self.entry_widget_select_path_cb, parent, entry)
-            table.attach(open_button, 9, 10, 0, 1)
+            table.attach(open_button, 9, 10, 0, 1, xoptions=gtk.SHRINK)
         else:
             hbox.pack_start(entry, expand=True, fill=True)
 
@@ -134,19 +135,29 @@ class SettingsUIHelper():
         return hbox, entry
 
     def gen_mirror_entry_widget(self, content, index, match_content=""):
-        hbox = gtk.HBox(False, 12)
+        hbox = gtk.HBox(False)
         entry = gtk.Entry()
         content = content[:-2]
         entry.set_text(content)
+        entry.set_size_request(350,30)
+
         entry_match = gtk.Entry()
         entry_match.set_text(match_content)
+        entry_match.set_size_request(100,30)
 
-        table = gtk.Table(2, 6, True)
+        table = gtk.Table(2, 5, False)
+        table.set_row_spacings(12)
+        table.set_col_spacings(6)
         hbox.pack_start(table, expand=True, fill=True)
+
         label_configuration = gtk.Label("Configuration")
+        label_configuration.set_alignment(0.0,0.5)
         label_mirror_url = gtk.Label("Mirror URL")
+        label_mirror_url.set_alignment(0.0,0.5)
         label_match = gtk.Label("Match")
+        label_match.set_alignment(0.0,0.5)
         label_replace_with = gtk.Label("Replace with")
+        label_replace_with.set_alignment(0.0,0.5)
 
         combo = gtk.combo_box_new_text()
         combo.append_text("Standard")
@@ -156,29 +167,31 @@ class SettingsUIHelper():
         else:
             combo.set_active(1)
         combo.connect("changed", self.on_combo_changed, index)
+        combo.set_size_request(100,30)
 
         delete_button = HobAltButton("Delete")
         delete_button.connect("clicked", self.delete_cb, index, entry)
         if content == "":
             delete_button.set_sensitive(False)
+        delete_button.set_size_request(100, 30)
 
         entry_match.connect("changed", self.insert_entry_match_cb, index)
         entry.connect("changed", self.insert_entry_cb, index, delete_button)
 
         if match_content == "":
-            table.attach(label_configuration, 0, 1, 0, 1)
-            table.attach(label_mirror_url, 1, 2, 0, 1)
-            table.attach(combo, 0, 1, 1, 2)
-            table.attach(entry, 1, 5, 1, 2)
-            table.attach(delete_button, 5, 6, 1, 2)
+            table.attach(label_configuration, 1, 2, 0, 1, xoptions=gtk.SHRINK|gtk.FILL)
+            table.attach(label_mirror_url, 2, 3, 0, 1, xoptions=gtk.SHRINK|gtk.FILL)
+            table.attach(combo, 1, 2, 1, 2, xoptions=gtk.SHRINK)
+            table.attach(entry, 2, 3, 1, 2, xoptions=gtk.SHRINK)
+            table.attach(delete_button, 3, 4, 1, 2, xoptions=gtk.SHRINK)
         else:
-            table.attach(label_configuration, 0, 1, 0, 1)
-            table.attach(label_match, 1, 2, 0, 1)
-            table.attach(label_replace_with, 2, 3, 0, 1)
-            table.attach(combo, 0, 1, 1, 2)
-            table.attach(entry_match, 1, 2, 1, 2)
-            table.attach(entry, 2, 5, 1, 2)
-            table.attach(delete_button, 5, 6, 1, 2)
+            table.attach(label_configuration, 1, 2, 0, 1, xoptions=gtk.SHRINK|gtk.FILL)
+            table.attach(label_match, 2, 3, 0, 1, xoptions=gtk.SHRINK|gtk.FILL)
+            table.attach(label_replace_with, 3, 4, 0, 1, xoptions=gtk.SHRINK|gtk.FILL)
+            table.attach(combo, 1, 2, 1, 2, xoptions=gtk.SHRINK)
+            table.attach(entry_match, 2, 3, 1, 2, xoptions=gtk.SHRINK)
+            table.attach(entry, 3, 4, 1, 2, xoptions=gtk.SHRINK)
+            table.attach(delete_button, 4, 5, 1, 2, xoptions=gtk.SHRINK)
 
         hbox.show_all()
         return hbox
@@ -519,19 +532,19 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         return advanced_vbox
 
     def create_shared_state_page(self):
-        advanced_vbox = gtk.VBox(False, 6)
-        advanced_vbox.set_border_width(6)
+        advanced_vbox = gtk.VBox(False)
+        advanced_vbox.set_border_width(12)
 
-        sub_vbox = gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        content = "<span weight=\"bold\">Shared state directory</span>"
+        sub_vbox = gtk.VBox(False)
+        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False, padding=24)
+        content = "<span>Shared state directory</span>"
         tooltip = "Select a folder that caches your prebuilt results"
         label = self.gen_label_info_widget(content, tooltip)
         sstatedir_widget, self.sstatedir_text = self.gen_entry_widget(self.configuration.sstatedir, self)
         sub_vbox.pack_start(label, expand=False, fill=False)
-        sub_vbox.pack_start(sstatedir_widget, expand=False, fill=False)
+        sub_vbox.pack_start(sstatedir_widget, expand=False, fill=False, padding=12)
 
-        sub_vbox = gtk.VBox(False, 6)
+        sub_vbox = gtk.VBox(False)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         content = "<span weight=\"bold\">Shared state mirrors</span>"
         tooltip = "URLs pointing to pre-built mirrors that will speed your build. "
@@ -569,15 +582,16 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
                 sstatemirror_widget = self.gen_mirror_entry_widget(mirror[1], index)
             else:
                 sstatemirror_widget = self.gen_mirror_entry_widget(mirror[1], index, mirror[2])
-            sub_vbox.pack_start(sstatemirror_widget, expand=False, fill=False)
+            sub_vbox.pack_start(sstatemirror_widget, expand=False, fill=False, padding=9)
             index += 1
 
-        sub_vbox = gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
+        table = gtk.Table(1, 1, False)
+        table.set_col_spacings(6)
         add_mirror_button = HobAltButton("Add another mirror")
-        add_mirror_button.set_size_request(100, -1)
         add_mirror_button.connect("clicked", self.add_mirror)
-        sub_vbox.pack_start(add_mirror_button, expand=False, fill=False)
+        add_mirror_button.set_size_request(150,30)
+        table.attach(add_mirror_button, 1, 2, 0, 1, xoptions=gtk.SHRINK)
+        advanced_vbox.pack_start(table, expand=False, fill=False, padding=9)
 
         return advanced_vbox
 
-- 
1.7.9.5



