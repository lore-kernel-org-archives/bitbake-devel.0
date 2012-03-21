Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SALFM-0003Qs-Ue
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 14:06:37 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 21 Mar 2012 05:57:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="121495254"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 21 Mar 2012 05:57:44 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 20:55:16 +0800
Message-Id: <933fba7835d0fe5fa3b76bc62327d6b09b44240e.1332334068.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
Subject: [PATCH 12/17] Hob: Move "Create your own image" to the bottom of image list
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
X-List-Received-Date: Wed, 21 Mar 2012 13:06:37 -0000

Move "Create your own image" item to the bottom of base image list.
Besides, remove an un-used hob list entry.

This fixes [YOCTO #2104]

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hoblistmodel.py           |    3 +--
 lib/bb/ui/crumbs/imageconfigurationpage.py |    5 ++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
index 74b2a17..61f2911 100644
--- a/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/lib/bb/ui/crumbs/hoblistmodel.py
@@ -412,7 +412,7 @@ class RecipeListModel(gtk.ListStore):
     """
     (COL_NAME, COL_DESC, COL_LIC, COL_GROUP, COL_DEPS, COL_BINB, COL_TYPE, COL_INC, COL_IMG, COL_INSTALL, COL_PN) = range(11)
 
-    __dummy_image__ = "Start from scratch"
+    __dummy_image__ = "Create your own image"
 
     __gsignals__ = {
         "recipe-selection-changed" : (gobject.SIGNAL_RUN_LAST,
@@ -434,7 +434,6 @@ class RecipeListModel(gtk.ListStore):
                                 gobject.TYPE_BOOLEAN,
                                 gobject.TYPE_BOOLEAN,
                                 gobject.TYPE_STRING,
-                                gobject.TYPE_STRING,
                                 gobject.TYPE_STRING)
 
     """
diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index 076b2c0..b0f0213 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -330,12 +330,15 @@ class ImageConfigurationPage (HobPage):
         # append and set active
         while it:
             path = image_model.get_path(it)
+            it = image_model.iter_next(it)
             image_name = image_model[path][recipe_model.COL_NAME]
+            if image_name == self.builder.recipe_model.__dummy_image__:
+                continue
             self.image_combo.append_text(image_name)
             if image_name == selected_image:
                 active = cnt
-            it = image_model.iter_next(it)
             cnt = cnt + 1
+        self.image_combo.append_text(self.builder.recipe_model.__dummy_image__)
         self._image_combo_connect_signal()
 
         self.image_combo.set_active(-1)
-- 
1.7.4.1



