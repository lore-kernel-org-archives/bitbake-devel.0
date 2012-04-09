Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SHAMQ-00076o-HL
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 10:54:07 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 09 Apr 2012 01:44:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="128643009"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 09 Apr 2012 01:44:48 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Apr 2012 16:42:00 +0800
Message-Id: <a278771f3438ff7cfbf8e5127760fb61b36d0437.1333960654.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333960654.git.dongxiao.xu@intel.com>
References: <cover.1333960654.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333960654.git.dongxiao.xu@intel.com>
References: <cover.1333960654.git.dongxiao.xu@intel.com>
Subject: [PATCH 4/6] Hob: Fix tooltips in image configuration page
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
X-List-Received-Date: Mon, 09 Apr 2012 08:54:07 -0000

This fixes [YOCTO #2228]

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/imageconfigurationpage.py |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index 5c2539d..9013e1e 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -49,19 +49,19 @@ class ImageConfigurationPage (HobPage):
             "Templates",
             hic.ICON_TEMPLATES_DISPLAY_FILE,
             hic.ICON_TEMPLATES_HOVER_FILE,
-            "Load a hob building template saved before",
+            "Load a previously saved template",
             self.template_button_clicked_cb)
         my_images_button = self.append_toolbar_button(self.toolbar,
-            "My images",
+            "Images",
             hic.ICON_IMAGES_DISPLAY_FILE,
             hic.ICON_IMAGES_HOVER_FILE,
-            "Open images built out previously for running or deployment",
+            "Open previously built images",
             self.my_images_button_clicked_cb)
         settings_button = self.append_toolbar_button(self.toolbar,
             "Settings",
             hic.ICON_SETTINGS_DISPLAY_FILE,
             hic.ICON_SETTINGS_HOVER_FILE,
-            "Other advanced settings for build",
+            "View additional build settings",
             self.settings_button_clicked_cb)
 
         self.config_top_button = self.add_onto_top_bar(self.toolbar)
@@ -138,7 +138,7 @@ class ImageConfigurationPage (HobPage):
 
         self.machine_title_desc = gtk.Label()
         self.machine_title_desc.set_alignment(0.0, 0.5)
-        mark = ("<span %s>This is the profile of the target machine for which you"
+        mark = ("<span %s>Your selection is the profile of the target machine for which you"
         " are building the image.\n</span>") % (self.span_tag('medium'))
         self.machine_title_desc.set_markup(mark)
 
@@ -155,8 +155,8 @@ class ImageConfigurationPage (HobPage):
         markup = "Layers are a powerful mechanism to extend the Yocto Project "
         markup += "with your own functionality.\n"
         markup += "For more on layers, check the <a href=\""
-        markup += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
-        markup += "poky-ref-manual.html#usingpoky-changes-layers\">reference manual</a>."
+        markup += "http://www.yoctoproject.org/docs/current/dev-manual/"
+        markup += "dev-manual.html#understanding-and-using-layers\">reference manual</a>."
         self.layer_info_icon = HobInfoButton(markup, self.get_parent())
 
         self.progress_box = gtk.HBox(False, 6)
@@ -235,7 +235,7 @@ class ImageConfigurationPage (HobPage):
         # create button "Build image"
         just_bake_button = HobButton("Build image")
         just_bake_button.set_size_request(205, 49)
-        just_bake_button.set_tooltip_text("Build image to get your target image")
+        just_bake_button.set_tooltip_text("Build target image")
         just_bake_button.connect("clicked", self.just_bake_button_clicked_cb)
         button_box.pack_end(just_bake_button, expand=False, fill=False)
 
@@ -245,6 +245,7 @@ class ImageConfigurationPage (HobPage):
         # create button "Build Packages"
         build_packages_button = HobAltButton("Build packages")
         build_packages_button.connect("clicked", self.build_packages_button_clicked_cb)
+        build_packages_button.set_tooltip_text("Build recipes into packages")
         button_box.pack_end(build_packages_button, expand=False, fill=False)
 
         return button_box
-- 
1.7.4.1



