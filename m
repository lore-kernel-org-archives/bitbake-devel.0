Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SDEeP-00082t-0m
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 14:40:25 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 29 Mar 2012 05:31:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="123076660"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 29 Mar 2012 05:31:22 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 20:54:52 +0800
Message-Id: <de98191e7ea239d9dc783f43df94d0b48aac5e9c.1333025491.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <ae31cc41fb985bdc59e784dbf973c522b666553a.1333025490.git.shane.wang@intel.com>
References: <ae31cc41fb985bdc59e784dbf973c522b666553a.1333025490.git.shane.wang@intel.com>
In-Reply-To: <cover.1333025490.git.shane.wang@intel.com>
References: <cover.1333025490.git.shane.wang@intel.com>
Subject: [PATCH 3/8] Hob: Change "Just bake" to "Build image" as required
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
X-List-Received-Date: Thu, 29 Mar 2012 12:40:25 -0000

[Yocto #2160]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index 0f59dd9..8914b1c 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -227,11 +227,11 @@ class ImageConfigurationPage (HobPage):
         self.gtable.attach(self.view_packages_button, 20, 40, 30, 35)
 
     def create_config_build_button(self):
-        # Create the "Build packages" and "Just bake" buttons at the bottom
+        # Create the "Build packages" and "Build image" buttons at the bottom
         button_box = gtk.HBox(False, 6)
 
-        # create button "Just bake"
-        just_bake_button = HobButton("Just bake")
+        # create button "Build image"
+        just_bake_button = HobButton("Build image")
         just_bake_button.set_size_request(205, 49)
         just_bake_button.set_tooltip_text("Build image to get your target image")
         just_bake_button.connect("clicked", self.just_bake_button_clicked_cb)
-- 
1.7.6



