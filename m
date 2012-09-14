Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <constantinx.musca@intel.com>) id 1TCTk1-0002B5-Lw
	for bitbake-devel@lists.openembedded.org;
	Fri, 14 Sep 2012 13:07:22 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 14 Sep 2012 03:53:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,422,1344236400"; d="scan'208";a="145035212"
Received: from costin-desktop (HELO localhost.localdomain) ([10.237.105.66])
	by AZSMGA002.ch.intel.com with ESMTP; 14 Sep 2012 03:53:40 -0700
From: Constantin Musca <constantinx.musca@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Sep 2012 12:58:53 +0300
Message-Id: <1347616733-27180-1-git-send-email-constantinx.musca@intel.com>
X-Mailer: git-send-email 1.7.9.5
Cc: Constantin Musca <constantinx.musca@intel.com>
Subject: [PATCH] hob: rename 'View log' to 'Open log'
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
X-List-Received-Date: Fri, 14 Sep 2012 11:07:22 -0000

Rename all the 'View log' buttons to 'Open log' for
consistency.

[YOCTO #3045]
---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py     |   12 ++++++------
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index cb3ca86..1d26ad6 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -249,12 +249,12 @@ class ImageDetailsPage (HobPage):
         view_files_button = HobAltButton("View files")
         view_files_button.connect("clicked", self.view_files_clicked_cb, image_addr)
         view_files_button.set_tooltip_text("Open the directory containing the image files")
-        view_log_button = None
+        open_log_button = None
         if log_file:
-            view_log_button = HobAltButton("View log")
-            view_log_button.connect("clicked", self.view_log_clicked_cb, log_file)
-            view_log_button.set_tooltip_text("Open the building log files")
-        self.image_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=view_files_button, button2=view_log_button)
+            open_log_button = HobAltButton("Open log")
+            open_log_button.connect("clicked", self.open_log_clicked_cb, log_file)
+            open_log_button.set_tooltip_text("Open the build's log file")
+        self.image_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=view_files_button, button2=open_log_button)
         self.box_group_area.pack_start(self.image_detail, expand=False, fill=True)
 
         # The default kernel box for the qemu images
@@ -333,7 +333,7 @@ class ImageDetailsPage (HobPage):
     def view_files_clicked_cb(self, button, image_addr):
         subprocess.call("xdg-open /%s" % image_addr, shell=True)
 
-    def view_log_clicked_cb(self, button, log_file):
+    def open_log_clicked_cb(self, button, log_file):
         if log_file:
             os.system("xdg-open /%s" % log_file)
 
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index e3d35ef..edbafbd 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -165,7 +165,7 @@ class PackageSelectionPage (HobPage):
             if binb:
                 self.builder.show_binb_dialog(binb)
 
-    def view_log_clicked_cb(self, button, log_file):
+    def open_log_clicked_cb(self, button, log_file):
         if log_file:
             os.system("xdg-open /%s" % log_file)
 
@@ -173,13 +173,13 @@ class PackageSelectionPage (HobPage):
         children = self.button_box.get_children() or []
         for child in children:
             self.button_box.remove(child)
-        # re-packed the buttons as request, add the 'view log' button if build success
+        # re-packed the buttons as request, add the 'open log' button if build success
         self.button_box.pack_end(self.build_image_button, expand=False, fill=False)
         if log_file:
-            view_log_button = HobAltButton("View log")
-            view_log_button.connect("clicked", self.view_log_clicked_cb, log_file)
-            view_log_button.set_tooltip_text("Open the building log files")
-            self.button_box.pack_end(view_log_button, expand=False, fill=False)
+            open_log_button = HobAltButton("Open log")
+            open_log_button.connect("clicked", self.open_log_clicked_cb, log_file)
+            open_log_button.set_tooltip_text("Open the build's log file")
+            self.button_box.pack_end(open_log_button, expand=False, fill=False)
         self.button_box.pack_end(self.back_button, expand=False, fill=False)
         self.show_all()
 
-- 
1.7.9.5



