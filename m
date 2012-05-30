Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SZhhj-0003oJ-K9
	for bitbake-devel@lists.openembedded.org;
	Wed, 30 May 2012 14:08:43 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 30 May 2012 04:58:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="149445109"
Received: from hp.sh.intel.com ([10.239.47.6])
	by azsmga001.ch.intel.com with ESMTP; 30 May 2012 04:58:24 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 30 May 2012 20:01:11 +0800
Message-Id: <433b599051655ff565d42e949cf351d5436b3294.1338379209.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <b362fa18604b2fb5ab1053800b7e76693b094d3a.1338379209.git.limingx.l.an@intel.com>
References: <b362fa18604b2fb5ab1053800b7e76693b094d3a.1338379209.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1338379209.git.limingx.l.an@intel.com>
References: <cover.1338379209.git.limingx.l.an@intel.com>
Subject: [PATCH 2/2] Hob: add the 'build new' be as the primary action for 'Image detail' page
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
X-List-Received-Date: Wed, 30 May 2012 12:08:43 -0000

As ui design, we should set at least one primary action for 'My Image' and
'Image detail' screen as the differnt selected image. if no 'run image' or
no 'save as template' or no 'deploy image' we should set 'build new image'

[YOCTO #2326]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 9d57dc0..deb053c 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -431,23 +431,20 @@ class ImageDetailsPage (HobPage):
             self.details_bottom_buttons.pack_end(save_button, expand=False, fill=False)
             create = True
 
-        if not packed:
-            box = gtk.HBox(False, 6)
-            box.show()
-            subbox = gtk.HBox(False, 0)
-            subbox.set_size_request(205, 49)
-            subbox.show()
-            box.add(subbox)
-            self.details_bottom_buttons.pack_end(box, False, False)
-
         name = "Build new image"
         if name in buttonlist:
             # create button "Build new image"
-            build_new_button = HobAltButton("Build new image")
+            if packed:
+                build_new_button = HobAltButton("Build new image")
+                self.details_bottom_buttons.pack_start(build_new_button, expand=False, fill=False)
+            else:
+                build_new_button = HobButton("Build new image")
+                build_new_button.set_size_request(205, 49)
+                build_new_button.set_flags(gtk.CAN_DEFAULT)
+                self.details_bottom_buttons.pack_end(build_new_button, expand=False, fill=False)
             build_new_button.set_tooltip_text("Create a new image from scratch")
             button_id = build_new_button.connect("clicked", self.build_new_button_clicked_cb)
             self.button_ids[button_id] = build_new_button
-            self.details_bottom_buttons.pack_start(build_new_button, expand=False, fill=False)
 
     def get_kernel_file_name(self, image_name):
         name_list = []
-- 
1.7.5.4



