Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SCNG7-0004Nk-3f
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 05:39:47 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 26 Mar 2012 20:30:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="145976527"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.109])
	by fmsmga002.fm.intel.com with ESMTP; 26 Mar 2012 20:30:42 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Mar 2012 20:30:38 -0700
Message-Id: <15d2ce9a832995d58e3ace666db791df5e147e06.1332818913.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332818913.git.josh@linux.intel.com>
References: <cover.1332818913.git.josh@linux.intel.com>
In-Reply-To: <cover.1332818913.git.josh@linux.intel.com>
References: <cover.1332818913.git.josh@linux.intel.com>
Subject: [PATCH 4/4] lib/bb/ui/crumbs/imagedetails: use secondary button style for 'View files'
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
X-List-Received-Date: Tue, 27 Mar 2012 03:39:47 -0000

Use HobAltButton, rather than gtk.LinkButton, for the 'View files'
button.

Use xdg-open to display the folders contents.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/imagedetailspage.py |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/imagedetailspage.py b/lib/bb/ui/crumbs/imagedetailspage.py
index 5a5ec3f..276281d 100755
--- a/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/lib/bb/ui/crumbs/imagedetailspage.py
@@ -185,7 +185,8 @@ class ImageDetailsPage (HobPage):
         image_table.set_model(self.image_store)
         image_size = self._size_to_string(os.stat(os.path.join(image_addr, image_names[0])).st_size)
         image_table.connect("toggled", self.toggled_cb)
-        view_files_button = gtk.LinkButton("file://%s" % image_addr, "View files")
+        view_files_button = HobAltButton("View files")
+        view_files_button.connect("clicked", self.view_files_clicked_cb, image_addr)
         self.box_group_area.pack_start(self.DetailBox(widget=image_table, button=view_files_button), expand=True, fill=True)
 
         # Machine, Base image and Layers
@@ -239,6 +240,9 @@ class ImageDetailsPage (HobPage):
 
         self.show_all()
 
+    def view_files_clicked_cb(self, button, image_addr):
+        os.system("xdg-open /%s" % image_addr)
+
     def refresh_package_detail_box(self, image_size):
         self.package_detail.update_line_widgets("Total image size: ", image_size)
 
-- 
1.7.7.6



