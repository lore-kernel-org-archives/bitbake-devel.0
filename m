Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SCNG6-0004Nd-Ng
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 05:39:46 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 26 Mar 2012 20:30:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="145976526"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.109])
	by fmsmga002.fm.intel.com with ESMTP; 26 Mar 2012 20:30:42 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Mar 2012 20:30:37 -0700
Message-Id: <a283ae54ee1981618f435d6018dd14b172cb5fa0.1332818913.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332818913.git.josh@linux.intel.com>
References: <cover.1332818913.git.josh@linux.intel.com>
In-Reply-To: <cover.1332818913.git.josh@linux.intel.com>
References: <cover.1332818913.git.josh@linux.intel.com>
Subject: [PATCH 3/4] lib/bb/ui/crumbs/imageconfigurationpage: ensure widgets stay positioned
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
X-List-Received-Date: Tue, 27 Mar 2012 03:39:46 -0000

Tweak the table layout and insert some dummy widgets when the buttons
aren't drawn such that when the buttons do get drawn the existing widgets
don't all jump up.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/imageconfigurationpage.py |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index 8e0e9fc..d7437a9 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -88,8 +88,16 @@ class ImageConfigurationPage (HobPage):
         self.pack_start(self.group_align, expand=True, fill=True)
 
         self.box_group_area.pack_start(self.gtable, expand=True, fill=True)
-        if pack_config_build_button == True:
+        if pack_config_build_button:
             self.box_group_area.pack_end(self.config_build_button, expand=False, fill=False)
+        else:
+            box = gtk.HBox(False, 6)
+            box.show()
+            subbox = gtk.HBox(False, 0)
+            subbox.set_size_request(205, 49)
+            subbox.show()
+            box.add(subbox)
+            self.box_group_area.pack_end(box, False, False)
 
     def show_machine(self):
         self.progress_bar.reset()
@@ -209,14 +217,14 @@ class ImageConfigurationPage (HobPage):
 
     def set_config_baseimg_layout(self):
         self.gtable.attach(self.image_title, 0, 40, 13, 17)
-        self.gtable.attach(self.image_title_desc, 0, 40, 17, 22)
-        self.gtable.attach(self.image_combo, 0, 12, 22, 25)
-        self.gtable.attach(self.image_desc, 14, 38, 22, 27)
+        self.gtable.attach(self.image_title_desc, 0, 40, 18, 23)
+        self.gtable.attach(self.image_combo, 0, 12, 24, 27)
+        self.gtable.attach(self.image_desc, 14, 38, 24, 29)
         self.gtable.attach(self.image_separator, 0, 40, 35, 36)
 
     def set_rcppkg_layout(self):
-        self.gtable.attach(self.view_recipes_button, 0, 20, 27, 32)
-        self.gtable.attach(self.view_packages_button, 20, 40, 27, 32)
+        self.gtable.attach(self.view_recipes_button, 0, 20, 30, 35)
+        self.gtable.attach(self.view_packages_button, 20, 40, 30, 35)
 
     def create_config_build_button(self):
         # Create the "Build packages" and "Just bake" buttons at the bottom
-- 
1.7.7.6



