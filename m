Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id D2FC260807
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 11:00:25 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga104.jf.intel.com with ESMTP; 26 Sep 2016 04:00:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,399,1470726000"; d="scan'208";a="173219807"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga004.fm.intel.com with ESMTP; 26 Sep 2016 04:00:27 -0700
Received: from ed.fi.intel.com (ed.fi.intel.com [10.237.72.179])
	by linux.intel.com (Postfix) with ESMTP id 543B66A4006
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 04:00:00 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Sep 2016 13:59:31 +0300
Message-Id: <054da11ce4e669e4b8687c9878feeda859d36636.1474887106.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <cover.1474887106.git.ed.bartosh@linux.intel.com>
References: <cover.1474887106.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1474887106.git.ed.bartosh@linux.intel.com>
References: <cover.1474887106.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 04/10] toaster: project page Implement front end feature to delete project
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
X-List-Received-Date: Mon, 26 Sep 2016 11:00:26 -0000

From: Michael Wood <michael.g.wood@intel.com>

Add confirm modal and api calls to delete a project from the project
dashboard.

[YOCTO #6238]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/api.py                      | 15 +++++++---
 lib/toaster/toastergui/static/js/projectpage.js    | 30 ++++++++++++++++++-
 lib/toaster/toastergui/static/js/projecttopbar.js  |  6 ++--
 .../toastergui/templates/baseprojectpage.html      |  6 ++++
 lib/toaster/toastergui/templates/project.html      | 35 +++++++++++++---------
 .../toastergui/templates/projecttopbar.html        |  2 +-
 6 files changed, 71 insertions(+), 23 deletions(-)

diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index 5589118..856918b 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -393,7 +393,7 @@ class XhrCustomRecipeId(View):
         """ Get Custom Image recipe or return an error response"""
         try:
             custom_recipe = \
-                    CustomImageRecipe.objects.get(pk=recipe_id)
+                CustomImageRecipe.objects.get(pk=recipe_id)
             return custom_recipe, None
 
         except CustomImageRecipe.DoesNotExist:
@@ -418,8 +418,12 @@ class XhrCustomRecipeId(View):
         if error:
             return error
 
+        project = custom_recipe.project
+
         custom_recipe.delete()
-        return JsonResponse({"error": "ok"})
+        return JsonResponse({"error": "ok",
+                             "gotoUrl": reverse("projectcustomimages",
+                                                args=(project.pk,))})
 
 
 class XhrCustomRecipePackages(View):
@@ -820,8 +824,11 @@ class XhrProject(View):
 
     def delete(self, request, *args, **kwargs):
         try:
-            Project.objects.get(kwargs['project_id']).delete()
+            Project.objects.get(pk=kwargs['project_id']).delete()
         except Project.DoesNotExist:
             return error_response("Project %s does not exist" %
                                   kwargs['project_id'])
-        return JsonResponse({"error": "ok"})
+        return JsonResponse({
+            "error": "ok",
+            "gotoUrl": reverse("all-projects", args=[])
+        })
diff --git a/lib/toaster/toastergui/static/js/projectpage.js b/lib/toaster/toastergui/static/js/projectpage.js
index 3bf3cba..7f19c0d 100644
--- a/lib/toaster/toastergui/static/js/projectpage.js
+++ b/lib/toaster/toastergui/static/js/projectpage.js
@@ -45,6 +45,9 @@ function projectPageInit(ctx) {
 
    /* Now we're really ready show the page */
     $("#project-page").show();
+
+    /* Set the project name in the delete modal */
+    $("#delete-project-modal .project-name").text(prjInfo.name);
   });
 
   (function notificationRequest(){
@@ -328,7 +331,32 @@ function projectPageInit(ctx) {
 
   $("#delete-project-confirmed").click(function(e){
     e.preventDefault();
-  
+    libtoaster.disableAjaxLoadingTimer();
+    $(this).find('[data-role="submit-state"]').hide();
+    $(this).find('[data-role="loading-state"]').show();
+    $(this).attr("disabled", "disabled");
+    $('#delete-project-modal [data-dismiss="modal"]').hide();
+
+    $.ajax({
+        type: 'DELETE',
+        url: libtoaster.ctx.xhrProjectUrl,
+        headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
+        success: function (data) {
+          if (data.error !== "ok") {
+            console.warn(data.error);
+          } else {
+            var msg =  $('<span>You have deleted <strong>1</strong> project: <strong id="project-deleted"></strong></span>');
+
+            msg.find("#project-deleted").text(libtoaster.ctx.projectName);
+            libtoaster.setNotification("project-deleted", msg.html());
+
+            window.location.replace(data.gotoUrl);
+          }
+        },
+        error: function (data) {
+          console.warn(data);
+        }
+    });
   });
 
 }
diff --git a/lib/toaster/toastergui/static/js/projecttopbar.js b/lib/toaster/toastergui/static/js/projecttopbar.js
index f0cd18b..92ab2d6 100644
--- a/lib/toaster/toastergui/static/js/projecttopbar.js
+++ b/lib/toaster/toastergui/static/js/projecttopbar.js
@@ -4,7 +4,7 @@ function projectTopBarInit(ctx) {
 
   var projectNameForm = $("#project-name-change-form");
   var projectNameContainer = $("#project-name-container");
-  var projectName = $("#project-name");
+  var projectName = $(".project-name");
   var projectNameFormToggle = $("#project-change-form-toggle");
   var projectNameChangeCancel = $("#project-name-change-cancel");
 
@@ -25,14 +25,14 @@ function projectTopBarInit(ctx) {
     e.preventDefault();
     projectNameForm.hide();
     projectNameContainer.fadeIn();
-    $("#project-name-change-input").val(projectName.text());
+    $("#project-name-change-input").val(projectName.first().text());
   });
 
   $("#project-name-change-btn").click(function(){
     var newProjectName = $("#project-name-change-input").val();
 
     libtoaster.editCurrentProject({ projectName: newProjectName }, function (){
-      projectName.html(newProjectName);
+      projectName.text(newProjectName);
       libtoaster.ctx.projectName = newProjectName;
       projectNameChangeCancel.click();
     });
diff --git a/lib/toaster/toastergui/templates/baseprojectpage.html b/lib/toaster/toastergui/templates/baseprojectpage.html
index b3b6f1c..8427d25 100644
--- a/lib/toaster/toastergui/templates/baseprojectpage.html
+++ b/lib/toaster/toastergui/templates/baseprojectpage.html
@@ -34,6 +34,12 @@ $(document).ready(function(){
       <li><a href="{% url 'projectlayers' project.id %}">Layers</a></li>
       <li class="nav-header">Extra configuration</li>
       <li><a href="{% url 'projectconf' project.id %}">BitBake variables</a></li>
+
+      <li class="nav-header">Actions</li>
+      <li>
+        <a href="#delete-project-modal" role="button" class="text-danger" data-toggle="modal" data-target="#delete-project-modal">
+          <i class="icon-trash text-danger"></i> Delete project</a>
+      </li>
     </ul>
   </div>
   <div class="col-md-10">
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 30ee93a..7644dad 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -24,30 +24,37 @@
   });
 </script>
 
-{% comment %}
-<!-- Comment out the ability to change the project release, until we decide what to do this functionality -->
-<div id="change-release-modal" class="modal hide fade in" tabindex="-1" role="dialog" aria-labelledby="change-release-modal" aria-hidden="false">
+<div id="delete-project-modal" class="modal fade" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
   <div class="modal-dialog">
     <div class="modal-content">
-
       <div class="modal-header">
-	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
-	<h3>Changing Yocto Project release to <span class="proposed-release-change-name"></span></h3>
+        <h4>Are you sure you want to delete this project?</h4>
       </div>
       <div class="modal-body">
-	<p>The following added layers do not exist for <span class="proposed-release-change-name"></span>: </p>
-	<ul id="layers-to-remove-list">
-	</ul>
-	<p>If you change the Yocto Project release to <span class="proposed-release-change-name"></span>, the above layers will be deleted from your added layers.</p>
+        <p>Deleting the <strong class="project-name"></strong> project will remove forever:</p>
+        <ul>
+          <li>Its configuration information</li>
+          <li>Its imported layers</li>
+          <li>Its custom images</li>
+          <li>All its build information</li>
+        </ul>
       </div>
       <div class="modal-footer">
-	<button id="change-release-and-rm-layers" data-dismiss="modal" type="submit" class="btn btn-primary">Change release and delete layers</button>
-	<button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
+        <button type="button" class="btn btn-primary" id="delete-project-confirmed">
+          <span data-role="submit-state">Delete project</span>
+          <span data-role="loading-state" style="display:none">
+            <span class="fa-pulse">
+            <i class="fa-pulse icon-spinner"></i>
+          </span>
+            &nbsp;Deleting project...
+          </span>
+        </button>
+        <button type="button" class="btn btn-link" data-dismiss="modal">Cancel</button>
       </div>
     </div><!-- /.modal-content -->
   </div><!-- /.modal-dialog -->
-</div><!-- /.modal -->
-{% endcomment %}
+</div>
+
 
 <div class="row" id="project-page" style="display:none">
   <div class="col-md-6">
diff --git a/lib/toaster/toastergui/templates/projecttopbar.html b/lib/toaster/toastergui/templates/projecttopbar.html
index 2734af0..768ca94 100644
--- a/lib/toaster/toastergui/templates/projecttopbar.html
+++ b/lib/toaster/toastergui/templates/projecttopbar.html
@@ -24,7 +24,7 @@
   <!-- project name -->
   <div class="page-header">
     <h1 id="project-name-container">
-      <span id="project-name">{{project.name}}</span>
+      <span class="project-name">{{project.name}}</span>
 
       <span class="glyphicon glyphicon-edit" id="project-change-form-toggle"></i>
 
-- 
2.6.6


