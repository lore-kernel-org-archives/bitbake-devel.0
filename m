Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1ScD4o-0002nu-3h
	for bitbake-devel@lists.openembedded.org;
	Wed, 06 Jun 2012 12:02:54 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q569qPNv008792
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 6 Jun 2012 02:52:25 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Wed, 6 Jun 2012 02:52:25 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <dvhart@linux.intel.com>
Date: Wed, 6 Jun 2012 17:52:25 +0800
Message-ID: <9cace04b4c18fc9275b927c6fe07884d470a5e6e.1338976258.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1338976258.git.kai.kang@windriver.com>
References: <cover.1338976258.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, zhenfeng.zhao@windriver.com
Subject: [PATCH 3/6] ui/crumbs/hig.py: remove extra spaces
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
X-List-Received-Date: Wed, 06 Jun 2012 10:02:54 -0000
Content-Type: text/plain

Remove extra spaces at the end of line or blank line.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 893fad4..cf73145 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -64,7 +64,7 @@ class CrumbsMessageDialog(CrumbsDialog):
     """
     def __init__(self, parent=None, label="", icon=gtk.STOCK_INFO):
         super(CrumbsMessageDialog, self).__init__("", parent, gtk.DIALOG_DESTROY_WITH_PARENT)
-        
+
         self.set_border_width(6)
         self.vbox.set_property("spacing", 12)
         self.action_area.set_property("spacing", 12)
@@ -208,7 +208,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         hbox.pack_start(port_entry, expand=False, fill=False)
 
         details_button = HobAltButton("Details")
-        details_button.connect("clicked", self.details_cb, parent, protocol) 
+        details_button.connect("clicked", self.details_cb, parent, protocol)
         hbox.pack_start(details_button, expand=False, fill=False)
 
         hbox.show_all()
@@ -1036,7 +1036,7 @@ class LayerSelectionDialog (CrumbsDialog):
         # create visual elements on the dialog
         self.create_visual_elements()
         self.connect("response", self.response_cb)
-                
+
     def create_visual_elements(self):
         layer_widget, self.layer_store = self.gen_layer_widget(self.layers, self.all_layers, self, None)
         layer_widget.set_size_request(450, 250)
@@ -1211,7 +1211,7 @@ class ImageSelectionDialog (CrumbsDialog):
                         if f.endswith('.' + real_image_type):
                             imageset.add(f.rsplit('.' + real_image_type)[0].rsplit('.rootfs')[0])
                             self.image_list.append(f)
-        
+
         for image in imageset:
             self.image_store.set(self.image_store.append(), 0, image, 1, False)
 
@@ -1227,7 +1227,7 @@ class ImageSelectionDialog (CrumbsDialog):
                     for f in self.image_list:
                         if f.startswith(self.image_store[path][0] + '.'):
                             self.image_names.append(f)
-                    break            
+                    break
                 iter = self.image_store.iter_next(iter)
 
 class ProxyDetailsDialog (CrumbsDialog):
-- 
1.7.5.4



