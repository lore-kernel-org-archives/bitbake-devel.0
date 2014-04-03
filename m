Return-Path: <marius.avram@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id E9F356F61F
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Apr 2014 12:15:49 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 03 Apr 2014 05:15:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,786,1389772800"; d="scan'208";a="486482081"
Received: from mavram-vostro.rb.intel.com ([10.237.105.50])
	by orsmga001.jf.intel.com with ESMTP; 03 Apr 2014 05:15:48 -0700
From: Marius Avram <marius.avram@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  3 Apr 2014 15:15:59 +0300
Message-Id: <1396527360-25682-1-git-send-email-marius.avram@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: fix customization of empty image recipe
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 03 Apr 2014 12:15:54 -0000

This fixes a problem which happened when you tried to build an
image by selecting 'Start with an empty image recipe' from the
Image configuration page of hob.

The reason on of the bug was that the name of the resulting image
was threated the same way as ordinary custom images, when in fact
they should use the default name: "hob-image", because they do not
derive from any other recipe.

[YOCTO #6102]

Signed-off-by: Marius Avram <marius.avram@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py         |    3 ++-
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    9 +++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 9adb1f7..3033e77 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -739,7 +739,8 @@ class Builder(gtk.Window):
 
     def set_base_image(self):
         self.configuration.initial_selected_image = self.configuration.selected_image
-        self.hob_image = self.configuration.selected_image + "-edited"
+        if self.configuration.selected_image != self.recipe_model.__custom_image__:
+            self.hob_image = self.configuration.selected_image + "-edited"
 
     def reset(self):
         self.configuration.curr_mach = ""
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 890e05f..62c4704 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -171,10 +171,11 @@ class HobHandler(gobject.GObject):
                 self.generate_hob_base_image(target)
                 self.set_var_in_file("LINGUAS_INSTALL", "", "local.conf")
                 hobImage = self.runCommand(["matchFile", target + ".bb"])
-                baseImage = self.runCommand(["matchFile", self.base_image + ".bb"])
-                version = self.runCommand(["generateNewImage", hobImage, baseImage, self.package_queue, True, ""])
-                target += version
-                self.recipe_model.set_custom_image_version(version)
+                if self.base_image != self.recipe_model.__custom_image__:
+                    baseImage = self.runCommand(["matchFile", self.base_image + ".bb"])
+                    version = self.runCommand(["generateNewImage", hobImage, baseImage, self.package_queue, True, ""])
+                    target += version
+                    self.recipe_model.set_custom_image_version(version)
 
             targets = [target]
             if self.toolchain_packages:
-- 
1.7.9.5


