Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 328FC7570D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Feb 2016 09:08:51 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 22 Feb 2016 01:08:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,483,1449561600"; d="scan'208";a="921077062"
Received: from mmisiak-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.31.233])
	by fmsmga002.fm.intel.com with ESMTP; 22 Feb 2016 01:08:51 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Feb 2016 09:08:37 +0000
Message-Id: <f842db1edc1b7845f8091d593ff55f16f1d1e487.1456131920.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <6a8294aab59563cd1d747764d140787648218458.1456131920.git.elliot.smith@intel.com>
References: <6a8294aab59563cd1d747764d140787648218458.1456131920.git.elliot.smith@intel.com>
In-Reply-To: <cover.1456131920.git.elliot.smith@intel.com>
References: <cover.1456131920.git.elliot.smith@intel.com>
Subject: [PATCH 6/9] toaster: link to configuration in all breadcrumbs
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
X-List-Received-Date: Mon, 22 Feb 2016 09:08:51 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The existing breadcrumb does not always provide a link to the project
configuration page. When you are in the build history pages, you must go
back to the builds information first, and from there access the project
configuration. That feels very long.

Change the breadcrumb so that the project name item always provides a
link to the project configuration.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/static/css/default.css             |  1 -
 lib/toaster/toastergui/static/js/layerdetails.js          | 15 ---------------
 lib/toaster/toastergui/templates/basebuilddetailpage.html |  4 ++--
 lib/toaster/toastergui/templates/basebuildpage.html       |  4 ++--
 lib/toaster/toastergui/templates/layerdetails.html        |  4 +---
 lib/toaster/toastergui/templates/recipedetails.html       |  5 +----
 6 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index c1cb93c..ae9fa06 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -10,7 +10,6 @@
 
 /* Style the breadcrumb */
 .breadcrumb { display: inline-block; background-color: transparent; }
-.breadcrumb li:first-child { padding-right: 10px; }
 
 /* Styles for the help information */
 .get-help { color: #CCCCCC; }
diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index 8c2ec4c..663b3c6 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -32,21 +32,6 @@ function layerDetailsPageInit (ctx) {
     }
   });
 
-
-  $(".breadcrumb li:first a").click(function(e){
-    e.preventDefault();
-    /* By default this link goes to the project configuration page. However
-     * if we have some builds we go there instead of the default href
-     */
-    libtoaster.getProjectInfo(libtoaster.ctx.projectPageUrl, function(prjInfo){
-      if (prjInfo.builds && prjInfo.builds.length > 0) {
-        window.location.replace(libtoaster.ctx.projectBuildsUrl);
-      } else {
-        window.location.replace(libtoaster.ctx.projectPageUrl);
-      }
-    });
-  });
-
   function addRemoveDep(depLayerId, add, doneCb) {
     var data = { layer_version_id : ctx.layerVersion.id };
     if (add)
diff --git a/lib/toaster/toastergui/templates/basebuilddetailpage.html b/lib/toaster/toastergui/templates/basebuilddetailpage.html
index ffe7aa4..e350c1a 100644
--- a/lib/toaster/toastergui/templates/basebuilddetailpage.html
+++ b/lib/toaster/toastergui/templates/basebuilddetailpage.html
@@ -6,7 +6,7 @@
 <!-- Breadcrumbs -->
     <div class="section">
         <ul class="breadcrumb" id="breadcrumb">
-            <li class="muted">{{build.project.name}}:</li>
+            <li><a href="{% url 'project' build.project.id %}">{{build.project.name}}</a></li>
             <li><a href="{% url 'projectbuilds' build.project.id %}">Builds</a></li>
             <li><a href="{%url 'builddashboard' build.pk%}">{{build.get_sorted_target_list.0.target}} {%if build.target_set.all.count > 1%}(+{{build.target_set.all.count|add:"-1"}}){%endif%} {{build.machine}} ({{build.completed_on|date:"d/m/y H:i"}})</a></li>
             {% block localbreadcrumb %}{% endblock %}
@@ -15,7 +15,7 @@
         $( function () {
             $('#breadcrumb > li').append('<span class="divider">&rarr;</span>');
             $('#breadcrumb > li:last').addClass("active");
-            $('#breadcrumb > li:last > span, #breadcrumb > li:first > span').remove();
+            $('#breadcrumb > li:last > span').remove();
         });
         </script>
     </div> <!--section-->
diff --git a/lib/toaster/toastergui/templates/basebuildpage.html b/lib/toaster/toastergui/templates/basebuildpage.html
index a9048d3..3571869 100644
--- a/lib/toaster/toastergui/templates/basebuildpage.html
+++ b/lib/toaster/toastergui/templates/basebuildpage.html
@@ -8,7 +8,7 @@
 <!-- Breadcrumbs -->
     <div class="section">
         <ul class="breadcrumb" id="breadcrumb">
-            <li class="muted">{{build.project.name}}:</li>
+            <li><a href="{% url 'project' build.project.id %}">{{build.project.name}}</a></li>
             <li><a href="{% url 'projectbuilds' build.project.id %}">Builds</a></li>
             <li>
             {% block parentbreadcrumb %}
@@ -23,7 +23,7 @@
         $( function () {
             $('#breadcrumb > li').append('<span class="divider">&rarr;</span>');
             $('#breadcrumb > li:last').addClass("active");
-            $('#breadcrumb > li:last > span, #breadcrumb > li:first > span').remove();
+            $('#breadcrumb > li:last > span').remove();
         });
         </script>
     </div>
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 7fe365d..61ae52c 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -8,9 +8,8 @@
 
 <div class="section">
   <ul class="breadcrumb">
-    <li class="muted">{{project.name}}:</li>
     <li>
-      <a href="{% url 'project' project.id %}">Configuration</a>
+      <a href="{% url 'project' project.id %}">{{project.name}}</a>
       <span class="divider">&rarr;</span>
     </li>
     <li><a href="{% url 'projectlayers' project.id %}">Compatible layers</a>
@@ -46,7 +45,6 @@
 
   $(document).ready(function (){
     var ctx = {
-      projectBuildsUrl : "{% url 'projectbuilds' project.id %}",
       xhrUpdateLayerUrl : "{% url 'xhr_updatelayer' %}",
       layerVersion : {
         name : "{{layerversion.layer.name}}",
diff --git a/lib/toaster/toastergui/templates/recipedetails.html b/lib/toaster/toastergui/templates/recipedetails.html
index aed0492..23aa171 100644
--- a/lib/toaster/toastergui/templates/recipedetails.html
+++ b/lib/toaster/toastergui/templates/recipedetails.html
@@ -6,11 +6,8 @@
 
 <div class="section">
   <ul class="breadcrumb">
-    <li class="muted">
-      {{project.name}}
-    </li>
     <li>
-      <a href="{% url 'project' project.id %}">Configuration</a>
+      <a href="{% url 'project' project.id %}">{{project.name}}</a>
       <span class="divider">&rarr;</span>
     </li>
     <li>
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


