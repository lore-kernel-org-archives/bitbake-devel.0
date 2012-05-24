Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SXW0C-0005W8-BA
	for bitbake-devel@lists.openembedded.org;
	Thu, 24 May 2012 13:14:44 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 24 May 2012 04:04:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="147864382"
Received: from hp.sh.intel.com ([10.239.47.6])
	by orsmga002.jf.intel.com with ESMTP; 24 May 2012 04:04:32 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 May 2012 19:07:10 +0800
Message-Id: <e542927a55e5ef77e6f84ef78eea634a453e4602.1337857307.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1337857307.git.limingx.l.an@intel.com>
References: <cover.1337857307.git.limingx.l.an@intel.com>
Subject: [PATCH 1/1] Hob:fixed the issue of primary button is not an 'orange hob button'
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
X-List-Received-Date: Thu, 24 May 2012 11:14:44 -0000

In image detail page, the primary button should be an 'orange hob
button', there has a primary button is not, so change it.

[YOCTO #2326]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |   27 +++++++++++++++----------
 meta/conf/machine/include/qemu.inc           |    2 +-
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 5d85491..9d57dc0 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -411,15 +411,6 @@ class ImageDetailsPage (HobPage):
             self.details_bottom_buttons.pack_end(run_button, expand=False, fill=False)
             created = True
 
-        if not packed:
-            box = gtk.HBox(False, 6)
-            box.show()
-            subbox = gtk.HBox(False, 0)
-            subbox.set_size_request(205, 49)
-            subbox.show()
-            box.add(subbox)
-            self.details_bottom_buttons.pack_end(box, False, False)
-
         name = "Save as template"
         if name in buttonlist:
             if created == True:
@@ -427,14 +418,28 @@ class ImageDetailsPage (HobPage):
                 label = gtk.Label(" or ")
                 self.details_bottom_buttons.pack_end(label, expand=False, fill=False)
 
-            # create button "Save as template"
-            save_button = HobAltButton("Save as template")
+                # create button "Save as template"
+                save_button = HobAltButton("Save as template")
+            else:
+                save_button = HobButton("Save as template")
+                save_button.set_size_request(205, 49)
+                save_button.set_flags(gtk.CAN_DEFAULT)
+                packed = True
             save_button.set_tooltip_text("Save the image configuration for reuse")
             button_id = save_button.connect("clicked", self.save_button_clicked_cb)
             self.button_ids[button_id] = save_button
             self.details_bottom_buttons.pack_end(save_button, expand=False, fill=False)
             create = True
 
+        if not packed:
+            box = gtk.HBox(False, 6)
+            box.show()
+            subbox = gtk.HBox(False, 0)
+            subbox.set_size_request(205, 49)
+            subbox.show()
+            box.add(subbox)
+            self.details_bottom_buttons.pack_end(box, False, False)
+
         name = "Build new image"
         if name in buttonlist:
             # create button "Build new image"
diff --git a/meta/conf/machine/include/qemu.inc b/meta/conf/machine/include/qemu.inc
index 5d59a7f..dc7f839 100644
--- a/meta/conf/machine/include/qemu.inc
+++ b/meta/conf/machine/include/qemu.inc
@@ -10,7 +10,7 @@ XSERVER ?= "xserver-xorg \
 
 MACHINE_FEATURES = "apm alsa pcmcia bluetooth irda usbgadget screen"
 
-IMAGE_FSTYPES += "tar.bz2 ext3"
+IMAGE_FSTYPES += "tar.bz2"
 
 ROOT_FLASH_SIZE = "280"
 
-- 
1.7.5.4



