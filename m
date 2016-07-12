Return-Path: <brian.avery@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 2D8F2731DF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jul 2016 22:53:56 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 12 Jul 2016 15:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,354,1464678000"; d="scan'208";a="1015672979"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga002.jf.intel.com with ESMTP; 12 Jul 2016 15:53:44 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Jul 2016 15:54:55 -0700
Message-Id: <701957f6e427b810d0d374203fbf9e28faeb8976.1468363530.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
References: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
In-Reply-To: <cover.1468363530.git.brian.avery@intel.com>
References: <cover.1468363530.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 14/17] toaster: the customise image button shouldn't rely on targets
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
X-List-Received-Date: Tue, 12 Jul 2016 22:53:57 -0000

From: Elliot Smith <elliot.smith@intel.com>

The build dashboard customise image button (for creating a new
custom image based on an image recipe used by a build) shouldn't
rely on targets: whether a new custom image can be created or not
depends on whether any of the recipes used by the build are image
recipes.

Modify the method used to determine whether a build has customisable
images to look at the image recipes used during the build, rather
than whether the targets run by the build refer to image recipes.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 lib/toaster/orm/models.py                           | 11 +++--------
 lib/toaster/toastergui/templates/basebuildpage.html |  2 +-
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 8e40f0a..048399f 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -449,18 +449,13 @@ class Build(models.Model):
                 break
         return has_images
 
-    def has_image_targets(self):
+    def has_image_recipes(self):
         """
         Returns True if a build has any targets which were built from
         image recipes.
         """
-        targets = Target.objects.filter(build_id=self.id)
-        has_image_targets = False
-        for target in targets:
-            if target.is_image:
-                has_image_targets = True
-                break
-        return has_image_targets
+        image_recipes = self.get_image_recipes()
+        return len(image_recipes) > 0
 
     def get_image_file_extensions(self):
         """
diff --git a/lib/toaster/toastergui/templates/basebuildpage.html b/lib/toaster/toastergui/templates/basebuildpage.html
index 8d7c562..eb709bb 100644
--- a/lib/toaster/toastergui/templates/basebuildpage.html
+++ b/lib/toaster/toastergui/templates/basebuildpage.html
@@ -117,7 +117,7 @@
         {% endwith %}
 
           <!-- new custom image from image recipe in this build -->
-          {% if build.has_image_targets %}
+          {% if build.has_image_recipes %}
             <button class="btn btn-default btn-block navbar-btn" data-role="new-custom-image-trigger">New custom image</button>
             {% include 'newcustomimage_modal.html' %}
             <script>
-- 
1.9.1


