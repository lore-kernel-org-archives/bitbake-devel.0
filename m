Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id CC42776FF2
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Sep 2015 10:05:59 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga103.fm.intel.com with ESMTP; 04 Sep 2015 03:06:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,468,1437462000"; d="scan'208";a="797677880"
Received: from unknown (HELO lp.ger.corp.intel.com) ([10.252.26.200])
	by orsmga002.jf.intel.com with ESMTP; 04 Sep 2015 03:05:59 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Sep 2015 11:05:19 +0100
Message-Id: <1441361119-30697-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: Changes to navigation
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
X-List-Received-Date: Fri, 04 Sep 2015 10:06:02 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

This patch:

* Changes the breadcrumb to provide access to either
the project builds or the project configuration, as
appropriate

* Changes the left navigation in the project configuration
to reflect the hierarchical relationship between the
basic configuration and all other configuration pages

* Changes the left navigation in the build history to bring
it in line with the changes in the project configuration

This way the breadcrumb explicitly exposes the hierarchy
of the application, which is its correct behaviour, making it
easier to move around within Toaster.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/static/css/default.css         |  5 +++++
 .../lib/toaster/toastergui/templates/basebuilddetailpage.html |  5 +++--
 bitbake/lib/toaster/toastergui/templates/basebuildpage.html   | 11 +++++++++--
 bitbake/lib/toaster/toastergui/templates/baseprojectpage.html |  6 +++---
 bitbake/lib/toaster/toastergui/templates/layerdetails.html    |  5 +++--
 5 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/static/css/default.css b/bitbake/lib/toaster/toastergui/static/css/default.css
index 9723db3..cce3e31 100644
--- a/bitbake/lib/toaster/toastergui/static/css/default.css
+++ b/bitbake/lib/toaster/toastergui/static/css/default.css
@@ -10,6 +10,7 @@
 
 /* Style the breadcrumb */
 .breadcrumb { display: inline-block; background-color: transparent; }
+.breadcrumb li:first-child { padding-right: 10px; }
 
 /* Styles for the help information */
 .get-help { color: #CCCCCC; }
@@ -112,6 +113,10 @@ th > a, th > span { font-weight: normal; }
 .btn-group + .btn-group { margin-right: 10px; }
 .navbar-inner > .btn-group { margin-top: 6px; }
 
+/* Styles for the parent item in the left navigation */
+
+.nav > li > a.nav-parent { font-size: 18px; line-height: 25px;  }
+
 /* Other styles */
 .dropdown-menu { padding: 10px; }
 select { width: auto; }
diff --git a/bitbake/lib/toaster/toastergui/templates/basebuilddetailpage.html b/bitbake/lib/toaster/toastergui/templates/basebuilddetailpage.html
index 8657845..22ca50c 100644
--- a/bitbake/lib/toaster/toastergui/templates/basebuilddetailpage.html
+++ b/bitbake/lib/toaster/toastergui/templates/basebuilddetailpage.html
@@ -6,7 +6,8 @@
 <!-- Breadcrumbs -->
     <div class="section">
         <ul class="breadcrumb" id="breadcrumb">
-            <li><a href="{% url 'project' build.project.id %}">{{build.project.name}}</a></li>
+            <li class="muted">{{build.project.name}}:</li>
+            <li><a href="{% url 'projectbuilds' build.project.id %}">Builds</a></li>
             <li><a href="{%url 'builddashboard' build.pk%}">{{build.target_set.all.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%} ({{build.completed_on|date:"d/m/y H:i"}})</a></li>
             {% block localbreadcrumb %}{% endblock %}
         </ul>
@@ -14,7 +15,7 @@
         $( function () {
             $('#breadcrumb > li').append('<span class="divider">&rarr;</span>');
             $('#breadcrumb > li:last').addClass("active");
-            $('#breadcrumb > li:last > span').remove();
+            $('#breadcrumb > li:last > span, #breadcrumb > li:first > span').remove();
         });
         </script>
     </div> <!--section-->
diff --git a/bitbake/lib/toaster/toastergui/templates/basebuildpage.html b/bitbake/lib/toaster/toastergui/templates/basebuildpage.html
index f399ba4..d441df8 100644
--- a/bitbake/lib/toaster/toastergui/templates/basebuildpage.html
+++ b/bitbake/lib/toaster/toastergui/templates/basebuildpage.html
@@ -8,7 +8,8 @@
 <!-- Breadcrumbs -->
     <div class="section">
         <ul class="breadcrumb" id="breadcrumb">
-            <li><a href="{% url 'project' build.project.id %}">{{build.project.name}}</a></li>
+            <li class="muted">{{build.project.name}}:</li>
+            <li><a href="{% url 'projectbuilds' build.project.id %}">Builds</a></li>
             <li>
             {% block parentbreadcrumb %}
             <a href="{%url 'builddashboard' build.pk%}">
@@ -22,7 +23,7 @@
         $( function () {
             $('#breadcrumb > li').append('<span class="divider">&rarr;</span>');
             $('#breadcrumb > li:last').addClass("active");
-            $('#breadcrumb > li:last > span').remove();
+            $('#breadcrumb > li:last > span, #breadcrumb > li:first > span').remove();
 	    console.log("done");
         });
         </script>
@@ -33,6 +34,12 @@
         <!-- begin left sidebar container -->
         <div id="nav" class="span2">
             <ul class="nav nav-list well">
+              <li
+                {% if request.resolver_match.url_name == 'builddashboard'  %}
+                  class="active"
+                {% endif %} >
+                <a class="nav-parent" href="{% url 'builddashboard' build.pk %}">Build summary</a>
+              </li>
               {% if build.target_set.all.0.is_image and build.outcome == 0 %}
                 <li class="nav-header">Images</li>
                 {% block nav-target %}
diff --git a/bitbake/lib/toaster/toastergui/templates/baseprojectpage.html b/bitbake/lib/toaster/toastergui/templates/baseprojectpage.html
index 0db06a8..668e0bf 100644
--- a/bitbake/lib/toaster/toastergui/templates/baseprojectpage.html
+++ b/bitbake/lib/toaster/toastergui/templates/baseprojectpage.html
@@ -21,14 +21,14 @@
   <!-- only on config pages -->
   <div id="config-nav" class="span2">
     <ul class="nav nav-list well">
-      <li class="nav-header">Configuration</li>
-      <li><a href="{% url 'project' project.id %}">Basic configuration</a></li>
-      <li><a href="{% url 'projectconf' project.id %}">BitBake variables</a></li>
+      <li><a class="nav-parent" href="{% url 'project' project.id %}">Configuration</a></li>
       <li class="nav-header">Compatible metadata</li>
 <!--  <li><a href="all-image-recipes.html">Image recipes</a></li> -->
       <li><a href="{% url 'projecttargets' project.id %}">Recipes</a></li>
       <li><a href="{% url 'projectmachines' project.id %}">Machines</a></li>
       <li><a href="{% url 'projectlayers' project.id %}">Layers</a></li>
+      <li class="nav-header">Extra configuration</li>
+      <li><a href="{% url 'projectconf' project.id %}">BitBake variables</a></li>
     </ul>
   </div>
   <div class="span10">
diff --git a/bitbake/lib/toaster/toastergui/templates/layerdetails.html b/bitbake/lib/toaster/toastergui/templates/layerdetails.html
index f7f5685..7dd3db2 100644
--- a/bitbake/lib/toaster/toastergui/templates/layerdetails.html
+++ b/bitbake/lib/toaster/toastergui/templates/layerdetails.html
@@ -7,14 +7,15 @@
 
 <div class="section">
   <ul class="breadcrumb">
+    <li class="muted">{{project.name}}:</li>
     <li>
-      <a href="{% url 'project' project.id %}">{{project.name}}</a>
+      <a href="{% url 'project' project.id %}">Configuration</a>
       <span class="divider">&rarr;</span>
     </li>
     <li><a href="{% url 'projectlayers' project.id %}">Compatible layers</a>
       <span class="divider">&rarr;</span>
     </li>
-    <li>
+    <li class="active">
       {{layerversion.layer.name}} ({{layerversion.get_vcs_reference|truncatechars:13}})
     </li>
   </ul>
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


