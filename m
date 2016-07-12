Return-Path: <brian.avery@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 0FA14731D3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jul 2016 22:53:55 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 12 Jul 2016 15:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,354,1464678000"; 
	d="scan'208,217";a="1015672967"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga002.jf.intel.com with ESMTP; 12 Jul 2016 15:53:44 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Jul 2016 15:54:51 -0700
Message-Id: <87c8705bdbdb5241e6fe186f72dc7eb728872925.1468363530.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
References: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
In-Reply-To: <cover.1468363530.git.brian.avery@intel.com>
References: <cover.1468363530.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 10/17] toaster: only show "New custom image" button for builds with image targets
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

Add a has_image_targets() method to Build, and use that to hide
the "New custom image" button on the build dashboard if a build
has no targets which build images.

[YOCTO #9514]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 lib/toaster/orm/models.py                          | 13 +++++++
 .../toastergui/templates/basebuildpage.html        | 42 +++++++++++-----------
 2 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 0443a45..a111916 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -449,6 +449,19 @@ class Build(models.Model):
                 break
         return has_images
 
+    def has_image_targets(self):
+        """
+        Returns True if a build has any targets which were built from
+        image recipes.
+        """
+        targets = Target.objects.filter(build_id=self.id)
+        has_image_targets = False
+        for target in targets:
+            if target.is_image:
+                has_image_targets = True
+                break
+        return has_image_targets
+
     def get_image_file_extensions(self):
         """
         Get string of file name extensions for images produced by this build;
diff --git a/lib/toaster/toastergui/templates/basebuildpage.html b/lib/toaster/toastergui/templates/basebuildpage.html
index e9927eb..8d7c562 100644
--- a/lib/toaster/toastergui/templates/basebuildpage.html
+++ b/lib/toaster/toastergui/templates/basebuildpage.html
@@ -117,30 +117,32 @@
         {% endwith %}
 
           <!-- new custom image from image recipe in this build -->
-          <button class="btn btn-default btn-block navbar-btn" data-role="new-custom-image-trigger">New custom image</button>
-          {% include 'newcustomimage_modal.html' %}
-          <script>
-            // imageRecipes includes both custom image recipes and built-in
-            // image recipes, any of which can be used as the basis for a
-            // new custom image
-            var imageRecipes = {{ build.get_image_recipes | objects_to_dictionaries:"id,name" | json }};
+          {% if build.has_image_targets %}
+            <button class="btn btn-default btn-block navbar-btn" data-role="new-custom-image-trigger">New custom image</button>
+            {% include 'newcustomimage_modal.html' %}
+            <script>
+              // imageRecipes includes both custom image recipes and built-in
+              // image recipes, any of which can be used as the basis for a
+              // new custom image
+              var imageRecipes = {{ build.get_image_recipes | objects_to_dictionaries:"id,name" | json }};
 
-            $(document).ready(function () {
-              var newCustomImageModal = $('#new-custom-image-modal');
-              var newCustomImageTrigger = $('[data-role="new-custom-image-trigger"]');
+              $(document).ready(function () {
+                var newCustomImageModal = $('#new-custom-image-modal');
+                var newCustomImageTrigger = $('[data-role="new-custom-image-trigger"]');
 
-              // show create new custom image modal to select an image built
-              // during this build as the basis for the custom recipe
-              newCustomImageTrigger.click(function () {
-                if (!imageRecipes.length) {
-                  return;
-                }
+                // show create new custom image modal to select an image built
+                // during this build as the basis for the custom recipe
+                newCustomImageTrigger.click(function () {
+                  if (!imageRecipes.length) {
+                    return;
+                  }
 
-                newCustomImageModalSetRecipes(imageRecipes);
-                newCustomImageModal.modal('show');
+                  newCustomImageModalSetRecipes(imageRecipes);
+                  newCustomImageModal.modal('show');
+                });
               });
-            });
-          </script>
+            </script>
+          {% endif %}
       </ul>
 
     </div>
-- 
1.9.1


