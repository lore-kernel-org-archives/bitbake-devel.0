Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SACbN-0002sp-GY
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 04:52:45 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 20 Mar 2012 20:43:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="123228093"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 20 Mar 2012 20:43:50 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 12:05:33 +0800
Message-Id: <448d48cbec1c05edaf739d1ce054aba7d6353852.1332302662.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0217085648fc2b46bac296491a8af9b1a3363aca.1332302662.git.shane.wang@intel.com>
References: <0217085648fc2b46bac296491a8af9b1a3363aca.1332302662.git.shane.wang@intel.com>
In-Reply-To: <cover.1332302662.git.shane.wang@intel.com>
References: <cover.1332302662.git.shane.wang@intel.com>
Subject: [PATCH 2/5] Hob: Change "View Packages" description
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
X-List-Received-Date: Wed, 21 Mar 2012 03:52:45 -0000

Change 'View Packages' button description from 'Add/remove packages' to 'Add/remove previously built packages to/from your image'.
And we adjust the size to make "View Packages" button fit into the window.

[Yocto #2146]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index b0c5daa..9f4e4ea 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
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
1.7.6



