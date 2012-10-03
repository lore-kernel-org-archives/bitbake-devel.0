Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ioanax.grigoropol@intel.com>) id 1TJNBd-00060D-Ok
	for bitbake-devel@lists.openembedded.org;
	Wed, 03 Oct 2012 13:32:21 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 03 Oct 2012 04:19:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,527,1344236400"; d="scan'208";a="229395352"
Received: from ideapad (HELO localhost.localdomain) ([10.237.105.40])
	by fmsmga001.fm.intel.com with ESMTP; 03 Oct 2012 04:19:08 -0700
From: Ioana Grigoropol <ioanax.grigoropol@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  3 Oct 2012 14:13:18 +0300
Message-Id: <1349262798-9401-1-git-send-email-ioanax.grigoropol@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/image_details/run_image: Kernel must be set
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
X-List-Received-Date: Wed, 03 Oct 2012 11:32:22 -0000

- when displaying image details, even if the kernel information is not shown, the kernel value must be set (if dealing with qemu) otherwise running the image will throw an error
Signed-off-by: Ioana Grigoropol <ioanax.grigoropol@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 44f8987..03afc55 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -329,8 +329,8 @@ class ImageDetailsPage (HobPage):
         # The default kernel box for the qemu images
         self.sel_kernel = ""
         self.kernel_detail = None
-        #if 'qemu' in image_name:
-        #    self.sel_kernel = self.get_kernel_file_name()
+        if 'qemu' in image_name:
+            self.sel_kernel = self.get_kernel_file_name()
 
         #    varlist = ["Kernel: "]
         #    vallist = []
-- 
1.7.9.5



