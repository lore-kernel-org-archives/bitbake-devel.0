Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1ScD4s-0002pE-6Y
	for bitbake-devel@lists.openembedded.org;
	Wed, 06 Jun 2012 12:02:58 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q569qTMX008795
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 6 Jun 2012 02:52:29 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Wed, 6 Jun 2012 02:52:29 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <dvhart@linux.intel.com>
Date: Wed, 6 Jun 2012 17:52:27 +0800
Message-ID: <d747392a7c89b78719690974b00ec4a2d8c42fcd.1338976258.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1338976258.git.kai.kang@windriver.com>
References: <cover.1338976258.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, zhenfeng.zhao@windriver.com
Subject: [PATCH 5/6] hob2: update DeployImageDialog for seperated tool
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
X-List-Received-Date: Wed, 06 Jun 2012 10:02:58 -0000
Content-Type: text/plain

Part of [Yocto 2388]

Update class DeployImageDialog to get ready for a standalone deploy
image tool. The standalone tool can be run directly without hob, and
add a button to select image file. So adjust the layout of
DeployImageDialog.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |   43 +++++++++++++++++++++++++++++++++-----
 1 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 97a3b22..3b50f68 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -749,21 +749,28 @@ class DeployImageDialog (CrumbsDialog):
 
     __dummy_usb__ = "--select a usb drive--"
 
-    def __init__(self, title, image_path, parent, flags, buttons=None):
+    def __init__(self, title, image_path, parent, flags, buttons=None, standalone=False):
         super(DeployImageDialog, self).__init__(title, parent, flags, buttons)
 
         self.image_path = image_path
+        self.standalone = standalone
 
         self.create_visual_elements()
         self.connect("response", self.response_cb)
 
     def create_visual_elements(self):
+        self.set_size_request(600, 400)
         label = gtk.Label()
         label.set_alignment(0.0, 0.5)
         markup = "<span font_desc='12'>The image to be written into usb drive:</span>"
         label.set_markup(markup)
         self.vbox.pack_start(label, expand=False, fill=False, padding=2)
 
+        table = gtk.Table(2, 10, False)
+        table.set_col_spacings(5)
+        table.set_row_spacings(5)
+        self.vbox.pack_start(table, expand=True, fill=True)
+
         scroll = gtk.ScrolledWindow()
         scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_AUTOMATIC)
         scroll.set_shadow_type(gtk.SHADOW_IN)
@@ -771,11 +778,26 @@ class DeployImageDialog (CrumbsDialog):
         tv.set_editable(False)
         tv.set_wrap_mode(gtk.WRAP_WORD)
         tv.set_cursor_visible(False)
-        buf = gtk.TextBuffer()
-        buf.set_text(self.image_path)
-        tv.set_buffer(buf)
+        self.buf = gtk.TextBuffer()
+        self.buf.set_text(self.image_path)
+        tv.set_buffer(self.buf)
         scroll.add(tv)
-        self.vbox.pack_start(scroll, expand=True, fill=True)
+        table.attach(scroll, 0, 10, 0, 1)
+
+        if self.standalone:
+                gobject.signal_new("select_image_clicked", self, gobject.SIGNAL_RUN_FIRST,
+                                   gobject.TYPE_NONE, ())
+                icon = gtk.Image()
+                pix_buffer = gtk.gdk.pixbuf_new_from_file(hic.ICON_IMAGES_DISPLAY_FILE)
+                icon.set_from_pixbuf(pix_buffer)
+                button = gtk.Button("Select Image")
+                button.set_image(icon)
+                button.set_size_request(140, 50)
+                table.attach(button, 9, 10, 1, 2, gtk.FILL, 0, 0, 0)
+                button.connect("clicked", self.select_image_button_clicked_cb)
+
+        separator = gtk.HSeparator()
+        self.vbox.pack_start(separator, expand=False, fill=False, padding=10)
 
         self.usb_desc = gtk.Label()
         self.usb_desc.set_alignment(0.0, 0.5)
@@ -790,7 +812,7 @@ class DeployImageDialog (CrumbsDialog):
         for usb in self.find_all_usb_devices():
             self.usb_combo.append_text("/dev/" + usb)
         self.usb_combo.set_active(0)
-        self.vbox.pack_start(self.usb_combo, expand=True, fill=True)
+        self.vbox.pack_start(self.usb_combo, expand=False, fill=False)
         self.vbox.pack_start(self.usb_desc, expand=False, fill=False, padding=2)
 
         self.progress_bar = HobProgressBar()
@@ -801,6 +823,12 @@ class DeployImageDialog (CrumbsDialog):
         self.vbox.show_all()
         self.progress_bar.hide()
 
+    def set_image_text_buffer(self, image_path):
+        self.buf.set_text(image_path)
+
+    def set_image_path(self, image_path):
+        self.image_path = image_path
+
     def popen_read(self, cmd):
         tmpout, errors = bb.process.run("%s" % cmd)
         return tmpout.strip()
@@ -816,6 +844,9 @@ class DeployImageDialog (CrumbsDialog):
             (self.popen_read('cat /sys/class/block/%s/device/vendor' % dev),
             self.popen_read('cat /sys/class/block/%s/device/model' % dev))
 
+    def select_image_button_clicked_cb(self, button):
+            self.emit('select_image_clicked')
+
     def usb_combo_changed_cb(self, usb_combo):
         combo_item = self.usb_combo.get_active_text()
         if not combo_item or combo_item == self.__dummy_usb__:
-- 
1.7.5.4



