Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ioanax.grigoropol@intel.com>) id 1THdMr-00049r-JY
	for bitbake-devel@lists.openembedded.org;
	Fri, 28 Sep 2012 18:24:45 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 28 Sep 2012 09:11:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,502,1344236400"; d="scan'208";a="199416345"
Received: from ideapad (HELO localhost.localdomain) ([10.237.105.40])
	by orsmga001.jf.intel.com with ESMTP; 28 Sep 2012 09:11:33 -0700
From: Ioana Grigoropol <ioanax.grigoropol@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Sep 2012 19:06:57 +0300
Message-Id: <1348848417-8736-1-git-send-email-ioanax.grigoropol@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/image_details: Remove kernel info from details
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
X-List-Received-Date: Fri, 28 Sep 2012 16:24:45 -0000

- removed kernel information from image details

[Yocto #3002]

Signed-off-by: Ioana Grigoropol <ioanax.grigoropol@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index a843ad4..44f8987 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -329,18 +329,18 @@ class ImageDetailsPage (HobPage):
         # The default kernel box for the qemu images
         self.sel_kernel = ""
         self.kernel_detail = None
-        if 'qemu' in image_name:
-            self.sel_kernel = self.get_kernel_file_name()
-
-            varlist = ["Kernel: "]
-            vallist = []
-            vallist.append(self.sel_kernel)
-
-            change_kernel_button = HobAltButton("Change")
-            change_kernel_button.connect("clicked", self.change_kernel_cb)
-            change_kernel_button.set_tooltip_text("Change qemu kernel file")
-            self.kernel_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=change_kernel_button)
-            self.box_group_area.pack_start(self.kernel_detail, expand=True, fill=True)
+        #if 'qemu' in image_name:
+        #    self.sel_kernel = self.get_kernel_file_name()
+
+        #    varlist = ["Kernel: "]
+        #    vallist = []
+        #    vallist.append(self.sel_kernel)
+
+        #    change_kernel_button = HobAltButton("Change")
+        #    change_kernel_button.connect("clicked", self.change_kernel_cb)
+        #    change_kernel_button.set_tooltip_text("Change qemu kernel file")
+        #    self.kernel_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=change_kernel_button)
+        #    self.box_group_area.pack_start(self.kernel_detail, expand=True, fill=True)
 
         # Machine, Base image and Layers
         layer_num_limit = 15
-- 
1.7.9.5



