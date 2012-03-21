Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SALFP-0003UK-DK
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 14:06:39 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 21 Mar 2012 05:57:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="131476505"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2012 05:57:47 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 20:55:18 +0800
Message-Id: <bffae0ba6b7a4d3336dfe8a43ed275d44fc8e374.1332334068.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
Subject: [PATCH 14/17] Hob: Change "View Packages" description
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
X-List-Received-Date: Wed, 21 Mar 2012 13:06:39 -0000

From: Shane Wang <shane.wang@intel.com>

Change 'View Packages' button description from 'Add/remove packages' to 'Add/remove previously built packages to/from your image'.
And we adjust the size to make "View Packages" button fit into the window.

[Yocto #2146]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 lib/bb/ui/crumbs/imageconfigurationpage.py |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index b0f0213..c1372ad 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -200,7 +200,7 @@ class ImageConfigurationPage (HobPage):
         icon_file = hic.ICON_PACKAGES_DISPLAY_FILE
         hover_file = hic.ICON_PACKAGES_HOVER_FILE
         self.view_packages_button = HobXpmLabelButtonBox(icon_file, hover_file,
-            "View Packages", "Add/remove packages")
+            "View Packages", "Add/remove previously built packages to/from your image")
         self.view_packages_button.connect("button-release-event", self.view_packages_button_clicked_cb)
 
         self.image_separator = gtk.HSeparator()
@@ -213,8 +213,8 @@ class ImageConfigurationPage (HobPage):
         self.gtable.attach(self.image_separator, 0, 40, 35, 36)
 
     def set_rcppkg_layout(self):
-        self.gtable.attach(self.view_recipes_button, 0, 20, 28, 32)
-        self.gtable.attach(self.view_packages_button, 20, 40, 28, 32)
+        self.gtable.attach(self.view_recipes_button, 0, 18, 28, 32)
+        self.gtable.attach(self.view_packages_button, 18, 40, 28, 32)
 
     def create_config_build_button(self):
         # Create the "Build packages" and "Just bake" buttons at the bottom
-- 
1.7.4.1



