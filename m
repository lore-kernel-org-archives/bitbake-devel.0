Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SJ0cy-0008TT-8S
	for bitbake-devel@lists.openembedded.org;
	Sat, 14 Apr 2012 12:54:48 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 14 Apr 2012 03:45:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="130858387"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 14 Apr 2012 03:45:24 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 14 Apr 2012 18:42:28 +0800
Message-Id: <7b1ddfde60e26188b04e63fad95be111ef012da5.1334400003.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1334400003.git.dongxiao.xu@intel.com>
References: <cover.1334400003.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1334400003.git.dongxiao.xu@intel.com>
References: <cover.1334400003.git.dongxiao.xu@intel.com>
Subject: [PATCH 2/4] Hob: Save the original image name into template
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
X-List-Received-Date: Sat, 14 Apr 2012 10:54:48 -0000

Previously we use the template file name as the image name. This commit
changes to use the original selected image into template file.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index f414bc7..5e90219 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -153,7 +153,7 @@ class Configuration:
         self.cvs_proxy_host = template.getVar("CVS_PROXY_HOST")
         self.cvs_proxy_port = template.getVar("CVS_PROXY_PORT")
 
-    def save(self, template, filename):
+    def save(self, template):
         # bblayers.conf
         template.setVar("BBLAYERS", " ".join(self.layers))
         # local.conf
@@ -175,7 +175,6 @@ class Configuration:
         template.setVar("TOOLCHAIN_BUILD", self.toolchain_build)
         template.setVar("IMAGE_FSTYPES", self.image_fstypes)
         # image/recipes/packages
-        self.selected_image = filename
         template.setVar("__SELECTED_IMAGE__", self.selected_image)
         template.setVar("DEPENDS", self.selected_recipes)
         template.setVar("IMAGE_INSTALL", self.user_selected_packages)
@@ -447,7 +446,7 @@ class Builder(gtk.Window):
 
         self.template = TemplateMgr()
         self.template.open(filename, path)
-        self.configuration.save(self.template, filename)
+        self.configuration.save(self.template)
 
         self.template.save()
         self.template.destroy()
@@ -627,10 +626,6 @@ class Builder(gtk.Window):
         selected_recipes = self.configuration.selected_recipes[:]
         selected_packages = self.configuration.selected_packages[:]
 
-        self.recipe_model.image_list_append(selected_image,
-                                            " ".join(selected_recipes),
-                                            " ".join(selected_packages))
-
         self.image_configuration_page.update_image_combo(self.recipe_model, selected_image)
         self.image_configuration_page.update_image_desc(selected_image)
         self.update_recipe_model(selected_image, selected_recipes)
-- 
1.7.4.1



