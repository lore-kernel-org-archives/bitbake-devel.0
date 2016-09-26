Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 80CF160807
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 11:00:28 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga105.jf.intel.com with ESMTP; 26 Sep 2016 04:00:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,399,1470726000"; 
	d="scan'208,217";a="1045963213"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga001.fm.intel.com with ESMTP; 26 Sep 2016 04:00:31 -0700
Received: from ed.fi.intel.com (ed.fi.intel.com [10.237.72.179])
	by linux.intel.com (Postfix) with ESMTP id 9A6BB6A4006
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 04:00:03 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Sep 2016 13:59:34 +0300
Message-Id: <2ef4dca5b3bb1abfd1a9f066419c001a695a0870.1474887106.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <cover.1474887106.git.ed.bartosh@linux.intel.com>
References: <cover.1474887106.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1474887106.git.ed.bartosh@linux.intel.com>
References: <cover.1474887106.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 07/10] toaster: Add front end controls for deleting a build
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
X-List-Received-Date: Mon, 26 Sep 2016 11:00:29 -0000

From: Michael Wood <michael.g.wood@intel.com>

Add front end modal and controls for deleting a build from the build
dashboard.

Also convert the Actions list to links instead of buttons as per the
design.

[YOCTO #6238]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 .../toastergui/templates/basebuildpage.html        | 138 ++++++++++++++++-----
 .../toastergui/templates/builddashboard.html       |   2 +-
 2 files changed, 105 insertions(+), 35 deletions(-)

diff --git a/lib/toaster/toastergui/templates/basebuildpage.html b/lib/toaster/toastergui/templates/basebuildpage.html
index 01d3117..0b6ef56 100644
--- a/lib/toaster/toastergui/templates/basebuildpage.html
+++ b/lib/toaster/toastergui/templates/basebuildpage.html
@@ -3,8 +3,88 @@
 {% load project_url_tag %}
 {% load objects_to_dictionaries_filter %}
 {% load humanize %}
+{% load field_values_filter %}
 {% block pagecontent %}
 
+ <script>
+  var configVarUrl = "{% url 'configvars' build.id %}";
+
+  $(document).ready(function(){
+
+    $("#delete-build-confirm").click(function(){
+      libtoaster.disableAjaxLoadingTimer();
+      $(this).find('[data-role="submit-state"]').hide();
+      $(this).find('[data-role="loading-state"]').show();
+      $(this).attr("disabled", "disabled");
+
+      /* Make the modal non cancelable while delete is in progress */
+      $('#delete-build-modal button[data-dismiss="modal"]').hide();
+
+      $.ajax({
+          type: 'DELETE',
+          url: "{% url 'xhr_build' build.id %}",
+          headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
+          success: function (data) {
+            if (data.error !== "ok") {
+              console.warn(data.error);
+            } else {
+             window.location.replace(data.gotoUrl);
+            }
+          },
+          error: function (data) {
+            console.warn(data);
+        }
+      });
+    });
+
+
+    $('#breadcrumb > li').append('<span class="divider">&rarr;</span>');
+    $('#breadcrumb > li:last').addClass("active");
+    $('#breadcrumb > li:last > span').remove();
+
+    $("#build-menu li a").each(function(){
+      /* Set the page active state in the Build menu */
+      var currentUrl = window.location.href.split('?')[0];
+      if (currentUrl === $(this).prop("href")){
+        $(this).parent().addClass("active");
+      } else {
+      /* Special case the configvar as this is part of configuration
+       * page but is a separate url
+       */
+      if (window.location.pathname === configVarUrl){
+          $("#menu-configuration").addClass("active");
+        } else {
+          $(this).parent().removeClass("active");
+        }
+      }
+    });
+  });
+ </script>
+
+
+
+<div class="modal fade" tabindex="-1" role="dialog" id="delete-build-modal" style="display: none;" data-backdrop="static" data-keyboard="false">
+  <div class="modal-dialog">
+    <div class="modal-content">
+      <div class="modal-body">
+        <p>Are you sure you want to delete the build <strong>{{build.get_sorted_target_list|field_values:"target"|join:", "}} {{build.machine}}</strong> completed on <strong>{{build.completed_on|date:"d/m/y H:i"}}</strong>?</p>
+      </div>
+      <div class="modal-footer">
+        <button id="delete-build-confirm" class="btn btn-primary btn-large">
+          <span data-role="submit-state">Delete build</span>
+          <span data-role="loading-state" style="display:none">
+            <span class="fa-pulse">
+              <i class="icon-spinner"></i>
+            </span>
+              &nbsp;Deleting build...
+          </span>
+        </button>
+        <button type="button" class="btn btn-link" data-dismiss="modal">Cancel</button>
+      </div>
+    </div><!-- /.modal-content -->
+  </div><!-- /.modal-dialog -->
+</div> <!-- / modal -->
+
 <div class="row">
   <!-- breadcrumbs -->
   <div class="col-md-12">
@@ -22,36 +102,6 @@
       </li>
       {% block localbreadcrumb %}{% endblock %}
     </ul>
-    <script>
-
-      var configVarUrl = "{% url 'configvars' build.id %}";
-
-      $(document).ready(function(){
-        $('#breadcrumb > li').append('<span class="divider">&rarr;</span>');
-        $('#breadcrumb > li:last').addClass("active");
-        $('#breadcrumb > li:last > span').remove();
-
-        $("#build-menu li a").each(function(){
-          /* Set the page active state in the Build menu */
-          var currentUrl = window.location.href.split('?')[0];
-          if (currentUrl === $(this).prop("href")){
-            $(this).parent().addClass("active");
-          } else {
-            /* Special case the configvar as this is part of configuration
-             * page but is a separate url, and the direct links to errors
-             * and warnings, which are part of the build dashboard
-             */
-            if (window.location.pathname === configVarUrl){
-              $("#menu-configuration").addClass("active");
-            } else if (currentUrl.indexOf('error') > 1 || currentUrl.indexOf('warning') > 1){
-              $("#menu-dashboard").addClass("active");
-            } else {
-              $(this).parent().removeClass("active");
-            }
-          }
-        });
-      });
-    </script>
   </div>
 </div>
 
@@ -86,13 +136,22 @@
             <li><a href="{% url 'cputime' build.pk %}">CPU usage</a></li>
             <li><a href="{% url 'diskio' build.pk %}">Disk I/O</a></li>
 
-	  <li class="nav-header">Actions</li>
-         	<a class="btn btn-default btn-block navbar-btn" href="{% url 'build_artifact' build.id 'cookerlog' build.id %}">Download build log</a>
+          <li class="nav-header">Actions</li>
+          <li>
+            <a href="{% url 'build_artifact' build.id 'cookerlog' build.id %}">
+              <span class="glyphicon glyphicon-download-alt"></span>
+            Download build log
+            </a>
+          </li>
 
           {% with build.get_custom_image_recipes as custom_image_recipes %}
             {% if custom_image_recipes.count > 0 %}
               <!-- edit custom image built during this build -->
-                <button class="btn btn-default btn-block navbar-btn" data-role="edit-custom-image-trigger">Edit custom image</button>
+              <li>
+                <a href="#" data-role="edit-custom-image-trigger">
+                  <span class="glyphicon glyphicon-edit"></span>
+                  Edit custom image
+                </a>
                 {% include 'editcustomimage_modal.html' %}
                 <script>
                   var editableCustomImageRecipes = {{ custom_image_recipes | objects_to_dictionaries:"id,name" | json }};
@@ -117,12 +176,17 @@
                     });
                   });
                 </script>
+              </li>
             {% endif %}
           {% endwith %}
 
             <!-- new custom image from image recipe in this build -->
             {% if build.has_image_recipes %}
-              <button class="btn btn-default btn-block navbar-btn" data-role="new-custom-image-trigger">New custom image</button>
+            <li>
+              <a href="#"  data-role="new-custom-image-trigger">
+                <span class="glyphicon glyphicon-plus"></span>
+                New custom image
+              </a>
               {% include 'newcustomimage_modal.html' %}
               <script>
                 // imageRecipes includes both custom image recipes and built-in
@@ -147,6 +211,12 @@
                 });
               </script>
             {% endif %}
+
+            <li>
+            <a href="#delete-build-modal" id="delete-build" data-toggle="modal" data-target="#delete-build-modal" class="text-danger">
+              <span class="glyphicon glyphicon-trash"></span>
+              Delete build
+            </a>
         </ul>
       </div>
       <!-- end left sidebar container -->
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index 1c390cd..02a2981 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -34,7 +34,7 @@
 				<a href="#warnings" class="show-warnings"> {{build.warnings.count}} warning{{build.warnings.count|pluralize}}</a>
 			{% endif %}
 			{% if build.cooker_log_path %}
-			<a class="alert-link pull-right log" href="{% url 'build_artifact' build.id "cookerlog" build.id %}">Download build log</a>
+			<a class="pull-right log" href="{% url 'build_artifact' build.id "cookerlog" build.id %}">Download build log</a>
 			{% endif %}
 			<span class="pull-right">
 				Build time:
-- 
2.6.6


