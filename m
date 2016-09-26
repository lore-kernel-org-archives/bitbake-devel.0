Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 8E5A960807
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 11:00:31 +0000 (UTC)
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by orsmga101.jf.intel.com with ESMTP; 26 Sep 2016 04:00:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,399,1470726000"; d="scan'208";a="13279009"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga005.fm.intel.com with ESMTP; 26 Sep 2016 04:00:32 -0700
Received: from ed.fi.intel.com (ed.fi.intel.com [10.237.72.179])
	by linux.intel.com (Postfix) with ESMTP id CD5786A4082
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 04:00:05 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Sep 2016 13:59:36 +0300
Message-Id: <8331841953d9c4fab04f63d7a342471e598cc69f.1474887106.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <cover.1474887106.git.ed.bartosh@linux.intel.com>
References: <cover.1474887106.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1474887106.git.ed.bartosh@linux.intel.com>
References: <cover.1474887106.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 09/10] toaster: customrecipe Add frontend feature to delete custom image recipe
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
X-List-Received-Date: Mon, 26 Sep 2016 11:00:31 -0000

From: Michael Wood <michael.g.wood@intel.com>

[YOCTO #8132]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/customrecipe.js   | 32 ++++++++++++++++++++
 lib/toaster/toastergui/templates/customrecipe.html | 35 +++++++++++++++++++---
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/customrecipe.js b/lib/toaster/toastergui/static/js/customrecipe.js
index 505a81c..9ea9602 100644
--- a/lib/toaster/toastergui/static/js/customrecipe.js
+++ b/lib/toaster/toastergui/static/js/customrecipe.js
@@ -281,4 +281,36 @@ function customRecipePageInit(ctx) {
         window.location.replace(libtoaster.ctx.projectBuildsUrl);
     });
   });
+
+  $("#delete-custom-recipe-confirmed").click(function(e){
+    e.preventDefault();
+    libtoaster.disableAjaxLoadingTimer();
+    $(this).find('[data-role="submit-state"]').hide();
+    $(this).find('[data-role="loading-state"]').show();
+    $(this).attr("disabled", "disabled");
+
+    $.ajax({
+        type: 'DELETE',
+        url: ctx.recipe.xhrCustomRecipeUrl,
+        headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
+        success: function (data) {
+          if (data.error !== "ok") {
+            console.warn(data.error);
+          } else {
+            var msg = $('<span>You have deleted <strong>1</strong> custom image: <strong id="deleted-custom-image-name"></strong></span>');
+            msg.find("#deleted-custom-image-name").text(ctx.recipe.name);
+
+            libtoaster.setNotification("custom-image-recipe-deleted",
+                                       msg.html());
+
+            window.location.replace(data.gotoUrl);
+          }
+        },
+        error: function (data) {
+          console.warn(data);
+        }
+    });
+  });
+
+
 }
diff --git a/lib/toaster/toastergui/templates/customrecipe.html b/lib/toaster/toastergui/templates/customrecipe.html
index 8b61fb7..945fc97 100644
--- a/lib/toaster/toastergui/templates/customrecipe.html
+++ b/lib/toaster/toastergui/templates/customrecipe.html
@@ -28,6 +28,7 @@
         includedPackagesCount: {{recipe.includes_set.count}},
         baseRecipeId: {{recipe.base_recipe.pk}},
         xhrPackageListUrl: "{% url 'xhr_customrecipe_packages' recipe.pk %}",
+        xhrCustomRecipeUrl: "{% url 'xhr_customrecipe_id' recipe.pk %}",
       }
     };
 
@@ -39,6 +40,32 @@
     }
   });
 </script>
+
+<!-- Delete recipe modal -->
+<div id="delete-recipe-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
+  <div class="modal-dialog">
+    <div class="modal-content">
+      <div class="modal-body">
+        <p>Are you sure you want to delete the <strong>{{recipe.name}}</strong>
+         custom image?</p>
+      </div>
+      <div class="modal-footer">
+        <button type="button" class="btn btn-primary" id="delete-custom-recipe-confirmed">
+          <span data-role="submit-state">Delete custom image</span>
+          <span data-role="loading-state" style="display:none">
+            <span class="fa-pulse">
+            <i class="fa-pulse icon-spinner"></i>
+          </span>
+            &nbsp;Deleting custom image...
+          </span>
+        </button>
+        <button type="button" class="btn btn-link" data-dismiss="modal">Cancel</button>
+      </div>
+    </div><!-- /.modal-content -->
+  </div><!-- /.modal-dialog -->
+</div><!-- /.modal -->
+<!-- end delete recipe modal -->
+
 <!-- package dependencies modal -->
 <div id="package-deps-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
   <div class="modal-dialog">
@@ -229,10 +256,10 @@
         <span class="glyphicon glyphicon-question-sign get-help" title="All custom images have their license set to MIT. This is because the license applies only to the recipe (.bb) file, and not to the image itself. To see which licenses apply to the image you must check the license manifest generated with each build"></i>
         </dd>
       </dl>
-      <!--
-        <i class="icon-trash no-tooltip"></i>
-        <a href="#" class="error" id="delete">Delete custom image</a>
-      -->
+      <i class="icon-trash text-danger"></i>
+      <a href="#delete-recipe-modal" data-target="#delete-recipe-modal" data-toggle="modal" class="text-danger" id="delete-recipe">
+        Delete custom image
+      </a>
     </div>
   </div>
 </div>
-- 
2.6.6


