Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1T6C1Z-0004Uk-QN
	for bitbake-devel@lists.openembedded.org;
	Tue, 28 Aug 2012 04:59:30 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q7S2lEKR026479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 27 Aug 2012 19:47:14 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.2.309.2; Mon, 27 Aug 2012 19:47:14 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <richard.purdie@linuxfoundation.org>
Date: Tue, 28 Aug 2012 10:47:19 +0800
Message-ID: <b743a0b2a413107d6139f0161de130c215c2aa54.1346121294.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1346121294.git.kai.kang@windriver.com>
References: <cover.1346121294.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/3] hob2: remove the hard-coded images map
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
X-List-Received-Date: Tue, 28 Aug 2012 02:59:30 -0000
Content-Type: text/plain

[Yocto #2795]

When a new image type added, the hob will crash because the new type is
not in the hard-coded image dictionary.

For most of the image types, they are same with the image file's
extension name. So use variable "IMAGE_EXTENSION_difftype" to map the
image type which is diff with the image file extension name, such as
type "live". And the variable(s) will be set in image_types.bbclass.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |   22 +++++++++++++++++++---
 bitbake/lib/bb/ui/crumbs/hig.py     |    9 +++++++--
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 7de4798..5421fb6 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -893,8 +893,13 @@ class Builder(gtk.Window):
                 linkname = 'hob-image-' + self.configuration.curr_mach
             else:
                 linkname = selected_image + '-' + self.configuration.curr_mach
+            image_extension = self.get_image_extension()
             for image_type in self.parameters.image_types:
-                for real_image_type in hcc.SUPPORTED_IMAGE_TYPES[image_type]:
+                if image_type in image_extension:
+                    real_types = image_extension[image_type]
+                else:
+                    real_types = [image_type]
+                for real_image_type in real_types:
                     linkpath = self.parameters.image_addr + '/' + linkname + '.' + real_image_type
                     if os.path.exists(linkpath):
                         self.parameters.image_names.append(os.readlink(linkpath))
@@ -1114,10 +1119,21 @@ class Builder(gtk.Window):
             self.save_template(path)
         dialog.destroy()
 
+    def get_image_extension(self):
+        image_extension = {}
+        for type in self.parameters.image_types:
+            ext = self.handler.runCommand(["getVariable", "IMAGE_EXTENSION_%s" % type])
+            if ext:
+                image_extension[type] = ext.split(' ')
+
+        return image_extension
+
     def show_load_my_images_dialog(self):
+        image_extension = self.get_image_extension()
         dialog = ImageSelectionDialog(self.parameters.image_addr, self.parameters.image_types,
                                       "Open My Images", self,
-                                       gtk.FILE_CHOOSER_ACTION_SAVE)
+                                       gtk.FILE_CHOOSER_ACTION_SAVE, None,
+                                       image_extension)
         button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
         HobAltButton.style_button(button)
         button = dialog.add_button("Open", gtk.RESPONSE_YES)
@@ -1334,4 +1350,4 @@ class Builder(gtk.Window):
             format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
             self.consolelog.setFormatter(format)
 
-            self.logger.addHandler(self.consolelog)
\ No newline at end of file
+            self.logger.addHandler(self.consolelog)
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 2001ff4..6829927 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -1172,7 +1172,7 @@ class ImageSelectionDialog (CrumbsDialog):
     }]
 
 
-    def __init__(self, image_folder, image_types, title, parent, flags, buttons=None):
+    def __init__(self, image_folder, image_types, title, parent, flags, buttons=None, image_extension = {}):
         super(ImageSelectionDialog, self).__init__(title, parent, flags, buttons)
         self.connect("response", self.response_cb)
 
@@ -1180,6 +1180,7 @@ class ImageSelectionDialog (CrumbsDialog):
         self.image_types  = image_types
         self.image_list = []
         self.image_names = []
+        self.image_extension = image_extension
 
         # create visual elements on the dialog
         self.create_visual_elements()
@@ -1265,7 +1266,11 @@ class ImageSelectionDialog (CrumbsDialog):
             dirs[:] = []
             for f in files:
                 for image_type in self.image_types:
-                    for real_image_type in hcc.SUPPORTED_IMAGE_TYPES[image_type]:
+                    if image_type in self.image_extension:
+                        real_types = self.image_extension[image_type]
+                    else:
+                        real_types = [image_type]
+                    for real_image_type in real_types:
                         if f.endswith('.' + real_image_type):
                             imageset.add(f.rsplit('.' + real_image_type)[0].rsplit('.rootfs')[0])
                             self.image_list.append(f)
-- 
1.7.5.4



