Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SCvao-0005xg-Jy
	for bitbake-devel@lists.openembedded.org;
	Wed, 28 Mar 2012 18:19:26 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 28 Mar 2012 09:10:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="147020218"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 28 Mar 2012 09:10:23 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 00:36:56 +0800
Message-Id: <d4802510e9752f110a5f44b7c1e1a0174e54bc64.1332952559.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <ba0cac313670c2e9f5c77d04e1eb07ef3aec9352.1332952559.git.shane.wang@intel.com>
References: <ba0cac313670c2e9f5c77d04e1eb07ef3aec9352.1332952559.git.shane.wang@intel.com>
In-Reply-To: <cover.1332952559.git.shane.wang@intel.com>
References: <cover.1332952559.git.shane.wang@intel.com>
Subject: [PATCH 3/5] Hob: change some words on image configuration screen to make them consistent
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
X-List-Received-Date: Wed, 28 Mar 2012 16:19:27 -0000

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index 9ad1ea4..f9a432f 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -200,7 +200,7 @@ class ImageConfigurationPage (HobPage):
         # button to view recipes
         icon_file = hic.ICON_RCIPE_DISPLAY_FILE
         hover_file = hic.ICON_RCIPE_HOVER_FILE
-        self.view_recipes_button = HobImageButton("View Recipes",
+        self.view_recipes_button = HobImageButton("View recipes",
                                         "Add/remove recipes and tasks",
                                         icon_file, hover_file)
         self.view_recipes_button.connect("clicked", self.view_recipes_button_clicked_cb)
@@ -208,7 +208,7 @@ class ImageConfigurationPage (HobPage):
         # button to view packages
         icon_file = hic.ICON_PACKAGES_DISPLAY_FILE
         hover_file = hic.ICON_PACKAGES_HOVER_FILE
-        self.view_packages_button = HobImageButton("View Packages",
+        self.view_packages_button = HobImageButton("View packages",
                                         "Add/remove previously built packages",
                                         icon_file, hover_file)
         self.view_packages_button.connect("clicked", self.view_packages_button_clicked_cb)
@@ -241,7 +241,7 @@ class ImageConfigurationPage (HobPage):
         button_box.pack_end(label, expand=False, fill=False)
 
         # create button "Build Packages"
-        build_packages_button = HobAltButton("Build Packages")
+        build_packages_button = HobAltButton("Build packages")
         build_packages_button.connect("clicked", self.build_packages_button_clicked_cb)
         button_box.pack_end(build_packages_button, expand=False, fill=False)
 
-- 
1.7.6



