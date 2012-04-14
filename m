Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SJ1H1-0000y7-N3
	for bitbake-devel@lists.openembedded.org;
	Sat, 14 Apr 2012 13:36:11 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 14 Apr 2012 04:26:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="153602484"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga002.fm.intel.com with ESMTP; 14 Apr 2012 04:26:48 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 14 Apr 2012 19:23:53 +0800
Message-Id: <14a9da66fe08d181f45853c52e0c9f14773070a8.1334402345.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1334402345.git.dongxiao.xu@intel.com>
References: <cover.1334402345.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1334402345.git.dongxiao.xu@intel.com>
References: <cover.1334402345.git.dongxiao.xu@intel.com>
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
X-List-Received-Date: Sat, 14 Apr 2012 11:36:11 -0000

Previously we use the template file name as the image name. This commit
changes to use the original selected image into template file.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py      |    9 ++-------
 lib/bb/ui/crumbs/hoblistmodel.py |   16 ----------------
 2 files changed, 2 insertions(+), 23 deletions(-)

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
diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
index dd93e2a..e7836c5 100644
--- a/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/lib/bb/ui/crumbs/hoblistmodel.py
@@ -618,22 +618,6 @@ class RecipeListModel(gtk.ListStore):
         return self[item_path][self.COL_INC]
 
     """
-    Append a certain image into the combobox
-    """
-    def image_list_append(self, name, deps, install):
-        # check whether a certain image is there
-        if not name or self.find_path_for_item(name):
-            return
-        it = self.append()
-        self.set(it, self.COL_NAME, name, self.COL_DESC, "",
-                 self.COL_LIC, "", self.COL_GROUP, "",
-                 self.COL_DEPS, deps, self.COL_BINB, "",
-                 self.COL_TYPE, "image", self.COL_INC, False,
-                 self.COL_IMG, False, self.COL_INSTALL, install,
-                 self.COL_PN, name)
-        self.pn_path[name] = self.get_path(it)
-
-    """
     Add this item, and any of its dependencies, to the image contents
     """
     def include_item(self, item_path, binb="", image_contents=False):
-- 
1.7.4.1



