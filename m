Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1T4qAb-00065z-1H
	for bitbake-devel@lists.openembedded.org;
	Fri, 24 Aug 2012 11:27:13 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q7O9F359025653
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 24 Aug 2012 02:15:03 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.2.309.2; Fri, 24 Aug 2012 02:15:03 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <richard.purdie@linuxfoundation.org>
Date: Fri, 24 Aug 2012 17:15:09 +0800
Message-ID: <178d68426a55b988d9523dfa09f961fa4c43e073.1345799414.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1345799414.git.kai.kang@windriver.com>
References: <cover.1345799414.git.kai.kang@windriver.com>
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
X-List-Received-Date: Fri, 24 Aug 2012 09:27:13 -0000
Content-Type: text/plain

[Yocto #2795]

When a new image type added, because it is not in the hard-coded image
dictionary, then hob crashes.
Use a variable IMAGE_TYPES_MAP to present the image maps in a conf file.
If a new image type added, just update the IMAGE_TYPES_MAP.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py         |   33 ++++++++++++++++++++++++--
 bitbake/lib/bb/ui/crumbs/hig.py             |    7 ++++-
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    3 ++
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 7de4798..dde4214 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -451,8 +451,32 @@ class Builder(gtk.Window):
 
         self.handler.set_config_filter(hob_conf_filter)
 
+        self.get_image_types()
+
         self.initiate_new_build_async()
 
+    def get_image_types(self):
+        self.configuration.supported_image_types = {}
+        content = self.handler.get_image_types()
+        if content is None:
+            return
+
+        # format of variable IMAGE_TYPES_MAP should be:
+        # IMAGE_TYPES_MAP = "type1:name1 type2:name2,name3 ..."
+        content = content.strip()
+        content = re.sub("\s+", ' ', content)
+        content = re.sub("\s*:\s*", ':', content)
+        content = re.sub("\s*,\s*", ',', content)
+        items = content.split(' ')
+        for item in items:
+            try:
+                index = item.index(':')
+                typename = item[0:index]
+                realnames = item[index+1:]
+                self.configuration.supported_image_types[typename] = realnames.split(',')
+            except:
+                pass
+
     def create_visual_elements(self):
         self.set_title("Hob")
         self.set_icon_name("applications-development")
@@ -894,7 +918,9 @@ class Builder(gtk.Window):
             else:
                 linkname = selected_image + '-' + self.configuration.curr_mach
             for image_type in self.parameters.image_types:
-                for real_image_type in hcc.SUPPORTED_IMAGE_TYPES[image_type]:
+                if image_type not in self.configuration.supported_image_types:
+                    continue
+                for real_image_type in self.configuration.supported_image_types[image_type]:
                     linkpath = self.parameters.image_addr + '/' + linkname + '.' + real_image_type
                     if os.path.exists(linkpath):
                         self.parameters.image_names.append(os.readlink(linkpath))
@@ -1117,7 +1143,8 @@ class Builder(gtk.Window):
     def show_load_my_images_dialog(self):
         dialog = ImageSelectionDialog(self.parameters.image_addr, self.parameters.image_types,
                                       "Open My Images", self,
-                                       gtk.FILE_CHOOSER_ACTION_SAVE)
+                                       gtk.FILE_CHOOSER_ACTION_SAVE, None,
+                                       self.configuration.supported_image_types)
         button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
         HobAltButton.style_button(button)
         button = dialog.add_button("Open", gtk.RESPONSE_YES)
@@ -1334,4 +1361,4 @@ class Builder(gtk.Window):
             format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
             self.consolelog.setFormatter(format)
 
-            self.logger.addHandler(self.consolelog)
\ No newline at end of file
+            self.logger.addHandler(self.consolelog)
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 2001ff4..014ea98 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -1172,7 +1172,7 @@ class ImageSelectionDialog (CrumbsDialog):
     }]
 
 
-    def __init__(self, image_folder, image_types, title, parent, flags, buttons=None):
+    def __init__(self, image_folder, image_types, title, parent, flags, buttons=None, supported_image_types={}):
         super(ImageSelectionDialog, self).__init__(title, parent, flags, buttons)
         self.connect("response", self.response_cb)
 
@@ -1180,6 +1180,7 @@ class ImageSelectionDialog (CrumbsDialog):
         self.image_types  = image_types
         self.image_list = []
         self.image_names = []
+        self.supported_image_types = supported_image_types
 
         # create visual elements on the dialog
         self.create_visual_elements()
@@ -1265,7 +1266,9 @@ class ImageSelectionDialog (CrumbsDialog):
             dirs[:] = []
             for f in files:
                 for image_type in self.image_types:
-                    for real_image_type in hcc.SUPPORTED_IMAGE_TYPES[image_type]:
+                    if image_type not in self.supported_image_types:
+                        continue
+                    for real_image_type in self.supported_image_types[image_type]:
                         if f.endswith('.' + real_image_type):
                             imageset.add(f.rsplit('.' + real_image_type)[0].rsplit('.rootfs')[0])
                             self.image_list.append(f)
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 540dde0..16ab246 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -393,6 +393,9 @@ class HobHandler(gobject.GObject):
     def get_logfile(self):
         return self.server.runCommand(["getVariable", "BB_CONSOLELOG"])
 
+    def get_image_types(self):
+        return self.server.runCommand(["getVariable", "IMAGE_TYPES_MAP"])
+
     def _remove_redundant(self, string):
         ret = []
         for i in string.split():
-- 
1.7.5.4



