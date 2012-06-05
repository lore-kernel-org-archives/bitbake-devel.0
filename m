Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1SbkkA-0003tl-6v
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Jun 2012 05:47:42 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q553bE3N007749
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 4 Jun 2012 20:37:14 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Mon, 4 Jun 2012 20:37:13 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <dvhart@linux.intel.com>
Date: Tue, 5 Jun 2012 11:37:11 +0800
Message-ID: <bbe60345d083624fd2fd6bc4a60c2cb948fe2993.1338866958.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1338866958.git.kai.kang@windriver.com>
References: <cover.1338866958.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, zhenfeng.zhao@windriver.com
Subject: [PATCH 1/2] hob2: update DeployImageDialog for seperated tool
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
X-List-Received-Date: Tue, 05 Jun 2012 03:47:42 -0000
Content-Type: text/plain

Part of [Yocto 2388]

Update class DeployImageDialog that could be used by a standalone
deploy image tool.

Update the method to get all usb device to avoid runtime error, and
get the deploy image process exit status then give user a information
dialog.

Remove some extra spaces at same time.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |   82 ++++++++++++++++++++++++++++++++-------
 1 files changed, 68 insertions(+), 14 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 7c9e73f..7d8daad 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -20,6 +20,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
+import glob
 import gtk
 import gobject
 import hashlib
@@ -63,7 +64,7 @@ class CrumbsMessageDialog(CrumbsDialog):
     """
     def __init__(self, parent=None, label="", icon=gtk.STOCK_INFO):
         super(CrumbsMessageDialog, self).__init__("", parent, gtk.DIALOG_DESTROY_WITH_PARENT)
-        
+
         self.set_border_width(6)
         self.vbox.set_property("spacing", 12)
         self.action_area.set_property("spacing", 12)
@@ -748,21 +749,28 @@ class DeployImageDialog (CrumbsDialog):
 
     __dummy_usb__ = "--select a usb drive--"
 
-    def __init__(self, title, image_path, parent, flags, buttons=None):
+    def __init__(self, title, image_path, parent, flags, buttons=None, singleton=False):
         super(DeployImageDialog, self).__init__(title, parent, flags, buttons)
 
         self.image_path = image_path
+        self.singleton = singleton
 
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
@@ -770,11 +778,26 @@ class DeployImageDialog (CrumbsDialog):
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
+        if self.singleton:
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
@@ -789,7 +812,7 @@ class DeployImageDialog (CrumbsDialog):
         for usb in self.find_all_usb_devices():
             self.usb_combo.append_text("/dev/" + usb)
         self.usb_combo.set_active(0)
-        self.vbox.pack_start(self.usb_combo, expand=True, fill=True)
+        self.vbox.pack_start(self.usb_combo, expand=False, fill=False)
         self.vbox.pack_start(self.usb_desc, expand=False, fill=False, padding=2)
 
         self.progress_bar = HobProgressBar()
@@ -800,13 +823,19 @@ class DeployImageDialog (CrumbsDialog):
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
 
     def find_all_usb_devices(self):
         usb_devs = [ os.readlink(u)
-            for u in self.popen_read('ls /dev/disk/by-id/usb*').split()
+            for u in glob.glob('/dev/disk/by-id/usb*')
             if not re.search(r'part\d+', u) ]
         return [ '%s' % u[u.rfind('/')+1:] for u in usb_devs ]
 
@@ -815,6 +844,9 @@ class DeployImageDialog (CrumbsDialog):
             (self.popen_read('cat /sys/class/block/%s/device/vendor' % dev),
             self.popen_read('cat /sys/class/block/%s/device/model' % dev))
 
+    def select_image_button_clicked_cb(self, button):
+            self.emit('select_image_clicked')
+
     def usb_combo_changed_cb(self, usb_combo):
         combo_item = self.usb_combo.get_active_text()
         if not combo_item or combo_item == self.__dummy_usb__:
@@ -826,12 +858,34 @@ class DeployImageDialog (CrumbsDialog):
 
     def response_cb(self, dialog, response_id):
         if response_id == gtk.RESPONSE_YES:
+            lbl = ''
             combo_item = self.usb_combo.get_active_text()
-            if combo_item and combo_item != self.__dummy_usb__:
+            if combo_item and combo_item != self.__dummy_usb__ and self.image_path:
                 cmdline = bb.ui.crumbs.utils.which_terminal()
                 if cmdline:
-                    cmdline += "\"sudo dd if=" + self.image_path + " of=" + combo_item + "\""
-                    bb.process.Popen(shlex.split(cmdline))
+                    tmpname = os.tmpnam()
+                    cmdline += "\"sudo dd if=" + self.image_path + " of=" + combo_item + "; echo $? > " + tmpname + "\""
+                    deploy_process = bb.process.Popen(shlex.split(cmdline))
+                    deploy_process.wait()
+                    tmpfile = open(tmpname)
+                    if int(tmpfile.readline().strip()) == 0:
+                        lbl = "<b>Deploy image successfully</b>"
+                    else:
+                        lbl = "<b>Deploy image failed</b>\nPlease try again"
+                    tmpfile.close()
+                    os.remove(tmpname)
+
+            else:
+                if not self.image_path:
+                    lbl = "<b>No selection made</b>\nYou have not selected image to deploy"
+                else:
+                    lbl = "<b>No selection made</b>\nYou have not selected USB device"
+            if len(lbl):
+                crumbs_dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+                button = crumbs_dialog.add_button("Close", gtk.RESPONSE_OK)
+                HobButton.style_button(button)
+                crumbs_dialog.run()
+                crumbs_dialog.destroy()
 
     def update_progress_bar(self, title, fraction, status=None):
         self.progress_bar.update(fraction)
@@ -1035,7 +1089,7 @@ class LayerSelectionDialog (CrumbsDialog):
         # create visual elements on the dialog
         self.create_visual_elements()
         self.connect("response", self.response_cb)
-                
+
     def create_visual_elements(self):
         layer_widget, self.layer_store = self.gen_layer_widget(self.layers, self.all_layers, self, None)
         layer_widget.set_size_request(450, 250)
@@ -1210,7 +1264,7 @@ class ImageSelectionDialog (CrumbsDialog):
                         if f.endswith('.' + real_image_type):
                             imageset.add(f.rsplit('.' + real_image_type)[0].rsplit('.rootfs')[0])
                             self.image_list.append(f)
-        
+
         for image in imageset:
             self.image_store.set(self.image_store.append(), 0, image, 1, False)
 
@@ -1226,7 +1280,7 @@ class ImageSelectionDialog (CrumbsDialog):
                     for f in self.image_list:
                         if f.startswith(self.image_store[path][0] + '.'):
                             self.image_names.append(f)
-                    break            
+                    break
                 iter = self.image_store.iter_next(iter)
 
 class ProxyDetailsDialog (CrumbsDialog):
-- 
1.7.5.4



