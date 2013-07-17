Return-Path: <cristiana.voicu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 500666B27B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Jul 2013 10:33:47 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 17 Jul 2013 03:31:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,683,1367996400"; d="scan'208";a="366549984"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2013 03:33:47 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 17 Jul 2013 13:35:41 +0300
Message-Id: <1374057344-19708-12-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1374057344-19708-1-git-send-email-cristiana.voicu@intel.com>
References: <1374057344-19708-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH 11/14] hob: retrieve file name of an image
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 17 Jul 2013 10:33:47 -0000

The entire file name (with the path) is needed to know
if the image is located in the "build" directory or it comes
from layers. According to this information, the image is placed
differently in the combobox.

[YOCTO #4193]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |    7 +++++--
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    5 +++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index e371bbd..1f941c5 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -474,7 +474,7 @@ class RecipeListModel(gtk.ListStore):
     provide filtered views of the data.
     """
     (COL_NAME, COL_DESC, COL_LIC, COL_GROUP, COL_DEPS, COL_BINB, COL_TYPE, COL_INC, COL_IMG, COL_INSTALL, COL_PN, COL_FADE_INC, COL_SUMMARY, COL_VERSION,
-     COL_REVISION, COL_HOMEPAGE, COL_BUGTRACKER) = range(17)
+     COL_REVISION, COL_HOMEPAGE, COL_BUGTRACKER, COL_FILE) = range(18)
 
     __custom_image__ = "Create a new base image"
 
@@ -504,6 +504,7 @@ class RecipeListModel(gtk.ListStore):
                                 gobject.TYPE_STRING,
                                 gobject.TYPE_STRING,
                                 gobject.TYPE_STRING,
+                                gobject.TYPE_STRING,
                                 gobject.TYPE_STRING)
         self.sort_column_id, self.sort_order = RecipeListModel.COL_NAME, gtk.SORT_ASCENDING
 
@@ -692,6 +693,7 @@ class RecipeListModel(gtk.ListStore):
             revision = event_model["pn"][item]["revision"]
             homepage = event_model["pn"][item]["homepage"]
             bugtracker = event_model["pn"][item]["bugtracker"]
+            filename = event_model["pn"][item]["filename"]
             install = []
 
             depends = event_model["depends"].get(item, []) + event_model["rdepends-pn"].get(item, [])
@@ -715,7 +717,8 @@ class RecipeListModel(gtk.ListStore):
                      self.COL_TYPE, atype, self.COL_INC, False,
                      self.COL_IMG, False, self.COL_INSTALL, " ".join(install), self.COL_PN, item,
                      self.COL_SUMMARY, summary, self.COL_VERSION, version, self.COL_REVISION, revision,
-                     self.COL_HOMEPAGE, homepage, self.COL_BUGTRACKER, bugtracker)
+                     self.COL_HOMEPAGE, homepage, self.COL_BUGTRACKER, bugtracker,
+                     self.COL_FILE, filename)
 
         self.pn_path = {}
         it = self.get_iter_first()
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index 60d9eba..b0a5e7a 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -437,6 +437,7 @@ class ImageConfigurationPage (HobPage):
         self.image_combo.append_text(self.builder.recipe_model.__custom_image__)
         self.image_combo.append_text("--Separator--")
 
+        topdir = self.builder.get_topdir()
         # append and set active
         while it:
             path = image_model.get_path(it)
@@ -460,6 +461,10 @@ class ImageConfigurationPage (HobPage):
             else:
                 allow = True
 
+            file_name = image_model[path][recipe_model.COL_FILE]
+            if file_name and topdir in file_name:
+                allow = False
+
             if allow:
                 self.image_combo.append_text(image_name)
                 if image_name == selected_image:
-- 
1.7.9.5


