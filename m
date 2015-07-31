Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id E639F73D13
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 12:09:33 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga103.jf.intel.com with ESMTP; 31 Jul 2015 05:09:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,584,1432623600"; d="scan'208";a="773999959"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 31 Jul 2015 05:09:33 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 9E2836A4083
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 05:08:48 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 15:09:03 +0300
Message-Id: <d1c6fac696e6d0285a7aeea81aa018c91a70ab3d.1438343854.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 02/22] bitbake: toastergui: Implement new project navigation
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
X-List-Received-Date: Fri, 31 Jul 2015 12:09:34 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michael Wood <michael.g.wood@intel.com>

Change the structure of the project page to include a navigation menu
and top tab navigation. Remove old breadcrumb method.

[YOCTO #7329]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/css/default.css      |  1 -
 lib/toaster/toastergui/static/js/base.js           | 54 ++++++++++++------
 lib/toaster/toastergui/static/js/layerdetails.js   | 13 +++++
 lib/toaster/toastergui/templates/base.html         |  5 +-
 .../templates/baseprojectbuildspage.html           | 15 +++++
 .../toastergui/templates/baseprojectpage.html      | 64 ++++++++++------------
 .../toastergui/templates/basetable_top.html        |  1 -
 .../templates/basetable_top_buildprojects.html     | 14 -----
 .../toastergui/templates/buildrequestdetails.html  |  3 -
 lib/toaster/toastergui/templates/builds.html       |  2 +-
 .../templates/generic-toastertable-page.html       | 19 +++----
 lib/toaster/toastergui/templates/importlayer.html  | 11 +---
 lib/toaster/toastergui/templates/layerdetails.html | 27 ++++++---
 lib/toaster/toastergui/templates/project.html      | 38 +++----------
 .../toastergui/templates/projectbuilds.html        |  5 +-
 lib/toaster/toastergui/templates/projectconf.html  |  8 +--
 .../toastergui/templates/projecttopbar.html        | 38 +++++++++++++
 lib/toaster/toastergui/urls.py                     |  6 +-
 lib/toaster/toastergui/views.py                    |  1 +
 19 files changed, 180 insertions(+), 145 deletions(-)
 create mode 100644 bitbake/lib/toaster/toastergui/templates/baseprojectbuildspage.html
 delete mode 100644 bitbake/lib/toaster/toastergui/templates/basetable_top_buildprojects.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/projecttopbar.html

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index da78f47..072a71d 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -179,7 +179,6 @@ table { table-layout: fixed; word-wrap: break-word; }
 .well-alert > .lead { color: #C09853; padding-bottom: .75em; }
 .configuration-alert { margin-bottom: 0px; padding: 8px 14px; }
 .configuration-alert p { margin-bottom: 0px; }
-fieldset { padding-left: 19px; }
 .project-form { margin-top: 10px; }
 .add-layers .btn-block + .btn-block, .build .btn-block + .btn-block { margin-top: 0px; }
 input.huge { font-size: 17.5px; padding: 11px 19px; }
diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index f1711c1..6fd77ea 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -3,33 +3,57 @@
 function basePageInit(ctx) {
 
   var newBuildButton = $("#new-build-button");
-  /* Hide the button if we're on the project,newproject or importlyaer page
+  var newBuildTargetInput;
+  var newBuildTargetBuildBtn;
+
+  var selectedProject = libtoaster.ctx;
+  var selectedTarget;
+
+  var newBuildProjectInput = $("#new-build-button #project-name-input");
+  var newBuildProjectSaveBtn = $("#new-build-button #save-project-button");
+
+  $("#config-nav .nav li a").each(function(){
+    if (window.location.pathname === $(this).attr('href'))
+      $(this).parent().addClass('active');
+    else
+      $(this).parent().removeClass('active');
+  });
+
+  if ($(".total-builds").length !== 0){
+    libtoaster.getProjectInfo(libtoaster.ctx.projectPageUrl, function(prjInfo){
+      if (prjInfo.builds)
+        $(".total-builds").text(prjInfo.builds.length);
+    });
+  }
+
+    /* Hide the button if we're on the project,newproject or importlyaer page
    * or if there are no projects yet defined
+   * only show if there isn't already a build-target-input already
    */
-  if (ctx.numProjects === 0 || ctx.currentUrl.search('newproject|project/\\d$|importlayer$') > 0) {
-    newBuildButton.hide();
+  if (ctx.numProjects > 0 &&
+      ctx.currentUrl.search('newproject') < 0 &&
+      $(".build-target-input").length === 1) {
+
+    newBuildTargetInput = $("#new-build-button .build-target-input");
+    newBuildTargetBuildBtn = $("#new-build-button .build-button");
+
+    newBuildButton.show();
+    _setupNewBuildButton();
+  } else if ($(".build-target-input").length > 0) {
+    newBuildTargetInput = $("#project-topbar .build-target-input");
+    newBuildTargetBuildBtn = $("#project-topbar .build-button");
+  } else {
     return;
   }
 
-  var selectedProject = libtoaster.ctx;
-  var selectedTarget;
 
   /* Hide the change project icon when there is only one project */
   if (ctx.numProjects === 1) {
     $('#project .icon-pencil').hide();
   }
 
-  newBuildButton.show().removeAttr("disabled");
-
-
-  var newBuildProjectInput = $("#new-build-button #project-name-input");
-  var newBuildTargetBuildBtn = $("#new-build-button #build-button");
-  var newBuildTargetInput = $("#new-build-button #build-target-input");
-  var newBuildProjectSaveBtn = $("#new-build-button #save-project-button");
-
 
   _checkProjectBuildable();
-  _setupNewBuildButton();
 
 
   function _checkProjectBuildable() {
@@ -57,8 +81,6 @@ function basePageInit(ctx) {
             selectedProject.projectName = item.name;
             selectedProject.projectId = item.id;
             selectedProject.projectBuildsUrl = item.projectBuildsUrl;
-
-
           });
 
         }
diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index 0accd97..e522373 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -15,6 +15,19 @@ function layerDetailsPageInit (ctx) {
     layerDepBtn.removeAttr("disabled");
   });
 
+  $(".breadcrumb li:first a").click(function(e){
+    /* By default this link goes to the project configuration page. However
+     * if we have some builds we go there instead of the default href
+     */
+    libtoaster.getProjectInfo(libtoaster.ctx.projectPageUrl, function(prjInfo){
+      if (prjInfo.builds && prjInfo.builds.length > 0) {
+        window.location.replace(libtoaster.ctx.projectBuildsUrl);
+        e.preventDefault();
+        return;
+      }
+    });
+  });
+
   function addRemoveDep(depLayerId, add, doneCb) {
     var data = { layer_version_id : ctx.layerVersion.id };
     if (add)
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index b34e6c3..6c3e1a3 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -80,7 +80,6 @@
                 {% endif %}
             </span>
 <ul class="nav">
-
   <li {% if "builds" in  request.path  %}
        class="active"
       {% endif %}>
@@ -105,7 +104,7 @@
                   <a class="btn" id="new-project-button" href="{% url 'newproject' %}">New project</a>
             </div>
             <!-- New build popover -->
-            <div class="btn-group pull-right" id="new-build-button">
+            <div class="btn-group pull-right" id="new-build-button" style="display:none">
               <button class="btn dropdown-toggle" data-toggle="dropdown">
                 New build
                 <i class="icon-caret-down"></i>
@@ -136,7 +135,7 @@
                   <li id="targets-form">
                     <h6>Recipe(s):</h6>
                     <form>
-                      <input type="text" class="input-xlarge" id="build-target-input" placeholder="Type a recipe name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead" disabled/>
+                      <input type="text" class="input-xlarge build-target-input" placeholder="Type a recipe name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead" disabled/>
                       <div>
                         <button class="btn btn-primary" id="build-button" disabled>Build</button>
                       </div>
diff --git a/lib/toaster/toastergui/templates/baseprojectbuildspage.html b/lib/toaster/toastergui/templates/baseprojectbuildspage.html
new file mode 100644
index 0000000..8b043d1
--- /dev/null
+++ b/lib/toaster/toastergui/templates/baseprojectbuildspage.html
@@ -0,0 +1,15 @@
+{% extends "base.html" %}
+{% load projecttags %}
+{% load humanize %}
+{% block pagecontent %}
+
+{% include "projecttopbar.html" %}
+
+<!-- Begin main page container -->
+<div class="row-fluid">
+    {% block projectinfomain %}{% endblock %}
+</div>
+<!-- End main container -->
+
+{% endblock %}
+
diff --git a/lib/toaster/toastergui/templates/baseprojectpage.html b/lib/toaster/toastergui/templates/baseprojectpage.html
index c8a7743..ac32dea 100644
--- a/lib/toaster/toastergui/templates/baseprojectpage.html
+++ b/lib/toaster/toastergui/templates/baseprojectpage.html
@@ -3,44 +3,40 @@
 {% load humanize %}
 {% block pagecontent %}
 
+{% include "projecttopbar.html" %}
+<script type="text/javascript">
+  $(document).ready(function(){
+     $("#config-nav .nav li a").each(function(){
+       if (window.location.pathname === $(this).attr('href'))
+         $(this).parent().addClass('active');
+       else
+         $(this).parent().removeClass('active');
+     });
 
- <div class="row-fluid">
-<!-- Breadcrumbs -->
-    <div class="section">
-        <ul class="breadcrumb" id="breadcrumb">
-            <li><a href="{% url 'all-builds' %}">All builds</a></li>
-            {% block parentbreadcrumb %}
-        {% if project %}
-          {% if project_html %}
-            <li>
-                {{project.name}}
-            </li>
-          {% else %}
-            <li>
-                <a href="{%url 'project' project.id %}"><span id="project_name">{{project.name}}</span>
-                </a>
-            </li>
-          {% endif %}
-        {% endif %}
-            {% endblock %}
-            {% block localbreadcrumb %}{% endblock %}
-        </ul>
-        <script>
-        $( function () {
-            $('#breadcrumb > li').append("<span class=\"divider\">→</span>");
-            $('#breadcrumb > li:last').addClass("active");
-            $('#breadcrumb > li:last > span').remove();
-        });
-        </script>
-    </div>
+     $("#topbar-configuration-tab").addClass("active")
+  });
+</script>
 
-    <!-- Begin main page container -->
-    <div style="padding: 0px, margin: 0px, display: inline">
+<div class="row-fluid">
+  <!-- only on config pages -->
+  <div id="config-nav" class="span2">
+    <ul class="nav nav-list well">
+      <li class="nav-header">Configuration</li>
+      <li><a href="{% url 'project' project.id %}">Basic configuration</a></li>
+      <li><a href="{% url 'projectconf' project.id %}">BitBake variables</a></li>
+      <li class="nav-header">Compatible metadata</li>
+<!--  <li><a href="all-image-recipes.html">Image recipes</a></li> -->
+      <li><a href="{% url 'projecttargets' project.id %}">Recipes</a></li>
+      <li><a href="{% url 'projectmachines' project.id %}">Machines</a></li>
+      <li><a href="{% url 'projectlayers' project.id %}">Layers</a></li>
+      <li class="nav-header">Actions</li>
+      <li><a href="{% url 'importlayer' project.id %}">Import layer</a></li>
+    </ul>
+  </div>
+  <div class="span10">
     {% block projectinfomain %}{% endblock %}
-    </div>
-    <!-- End main container -->
   </div>
-
+</div>
 
 {% endblock %}
 
diff --git a/lib/toaster/toastergui/templates/basetable_top.html b/lib/toaster/toastergui/templates/basetable_top.html
index 8dd56ed..d4bac36 100644
--- a/lib/toaster/toastergui/templates/basetable_top.html
+++ b/lib/toaster/toastergui/templates/basetable_top.html
@@ -168,7 +168,6 @@
             <button class="btn" type="submit" value="Search">Search</button>
         </form>
         <div class="pull-right">
-            {% block custombuttons%} {% endblock %}
 {% if tablecols %}
             <div class="btn-group">
                 <button class="btn dropdown-toggle" data-toggle="dropdown">Edit columns
diff --git a/lib/toaster/toastergui/templates/basetable_top_buildprojects.html b/lib/toaster/toastergui/templates/basetable_top_buildprojects.html
deleted file mode 100644
index 7b19f4b..0000000
--- a/lib/toaster/toastergui/templates/basetable_top_buildprojects.html
+++ /dev/null
@@ -1,14 +0,0 @@
-{% extends "basetable_top.html" %}
-
-{%block custombuttons %}
-  <div class="btn-group builds-projects">
-    <button class="btn dropdown-toggle" data-toggle="dropdown">
-        <span class="selection">Show all builds</span>
-        <i class="icon-caret-down"></i>
-    </button>
-    <ul class="dropdown-menu">
-        <li><a href="{% url 'all-builds'%}">Show all builds</a></li>
-        <li><a href="{% url 'all-projects'%}">Show all projects</a></li>
-    </ul>
-  </div>
-{%endblock%}
diff --git a/lib/toaster/toastergui/templates/buildrequestdetails.html b/lib/toaster/toastergui/templates/buildrequestdetails.html
index 9bb9bc1..70fa1fb 100644
--- a/lib/toaster/toastergui/templates/buildrequestdetails.html
+++ b/lib/toaster/toastergui/templates/buildrequestdetails.html
@@ -4,9 +4,6 @@
 {% load projecttags %}
 {% load humanize %}
 
-{% block localbreadcrumb %}
-<li> {{buildrequest.get_sorted_target_list.0.target}} {%if buildrequest.brtarget_set.all.count > 1%}(+ {{buildrequest.brtarget_set.all.count|add:"-1"}}){%endif%} {{buildrequest.get_machine}} ({{buildrequest.updated|date:"d/m/y H:i"}}) </li>
-{% endblock %}
 
 {% block projectinfomain %}
       <!-- begin content -->
diff --git a/lib/toaster/toastergui/templates/builds.html b/lib/toaster/toastergui/templates/builds.html
index 00d1d4e..b68fa6f 100644
--- a/lib/toaster/toastergui/templates/builds.html
+++ b/lib/toaster/toastergui/templates/builds.html
@@ -59,7 +59,7 @@
 
 
   {% else %}
-  {% include "basetable_top_buildprojects.html" %}
+  {% include "basetable_top.html" %}
         <!-- Table data rows; the order needs to match the order of "tablecols" definitions; and the <td class value needs to match the tablecols clclass value for show/hide buttons to work -->
         {% for build in objects %}
         <tr class="data">
diff --git a/lib/toaster/toastergui/templates/generic-toastertable-page.html b/lib/toaster/toastergui/templates/generic-toastertable-page.html
index 78e942c..654cdf4 100644
--- a/lib/toaster/toastergui/templates/generic-toastertable-page.html
+++ b/lib/toaster/toastergui/templates/generic-toastertable-page.html
@@ -3,19 +3,13 @@
 {% load humanize %}
 {% load static %}
 
-{% block localbreadcrumb %}
-
-
-<li>{{title}}</li>{% endblock %}
-
 {% block projectinfomain %}
-<div class="page-header">
-  <h1>{{title}} (<span class="table-count-{{table_name}}"></span>)
-    {% if project.release %}
-    <i class="icon-question-sign get-help heading-help" title="This page lists {{title}} compatible with the release selected for this project, which is {{project.release.description}}"></i>
-    {% endif %}
-  </h1>
-</div>
+
+<h2>{{title}} (<span class="table-count-{{table_name}}"></span>)
+  {% if project.release %}
+  <i class="icon-question-sign get-help heading-help" title="This page lists {{title}} compatible with the release selected for this project, which is {{project.release.description}}"></i>
+  {% endif %}
+</h2>
 <div id="zone1alerts" style="display:none">
   <div class="alert alert-info lead">
     <button type="button" class="close" id="hide-alert">&times;</button>
@@ -24,4 +18,5 @@
 </div>
 {% url table_name project.id as xhr_table_url %}
 {% include "toastertable.html" %}
+
 {% endblock %}
diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
index 6a5d412d..d6984bc 100644
--- a/lib/toaster/toastergui/templates/importlayer.html
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -3,9 +3,6 @@
 {% load humanize %}
 {% load static %}
 
-{% block localbreadcrumb %}
-<li>Import layer</li>
-{% endblock %}
 
 {% block projectinfomain %}
 
@@ -27,12 +24,10 @@
                     });
                   </script>
 
-                <div class="page-header">
-                    <h1>Import layer</h1>
-                </div>
+                <h2>Import layer</h2>
 
                 <form>
-                    <span class="help-block" style="padding-left:19px;">The layer you are importing must be compatible with <strong>{{project.release.description}}</strong>, which is the release you are using in this project.</span>
+                    <span class="help-block">The layer you are importing must be compatible with <strong>{{project.release.description}}</strong>, which is the release you are using in this project.</span>
                    <fieldset class="air">
                       <legend>Layer repository information</legend>
                       <div class="alert alert-error" id="import-error" style="display:none">
@@ -123,7 +118,7 @@
                         </div>
                         <span class="help-inline">You can only add layers Toaster knows about</span>
                     </fieldset>
-                    <div class="form-actions" id="form-actions">
+                    <div class="air" id="form-actions">
                       <button class="btn btn-primary btn-large" data-toggle="modal" id="import-and-add-btn" data-target="#dependencies-message" disabled>Import and add to project</button>
                         <span class="help-inline" id="import-and-add-hint" style="vertical-align: middle;">To import a layer you need to enter a layer name, a Git repository URL and a revision (branch, tag or commit)</span>
                     </div>
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 7d81b14..6269b36 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -1,14 +1,25 @@
-{% extends "baseprojectpage.html" %}
+{% extends "base.html" %}
 {% load projecttags %}
 {% load humanize %}
 {% load static %}
-{% block localbreadcrumb %}
-<li><a href="{% url 'projectlayers' project.id %}">All compatible layers</a></li>
-<li>
-  {{layerversion.layer.name}} ({{layerversion.get_vcs_reference|truncatechars:13}})
-</li>
-{% endblock %}
-{% block projectinfomain %}
+
+{% block pagecontent %}
+
+<div class="section">
+  <ul class="breadcrumb">
+    <li>
+      <a href="{% url 'project' project.id %}">{{project.name}}</a>
+      <span class="divider">→</span>
+    </li>
+    <li><a href="{% url 'projectlayers' project.id %}">Compatible layers</a>
+      <span class="divider">→</span>
+    </li>
+    <li>
+      {{layerversion.layer.name}} ({{layerversion.get_vcs_reference|truncatechars:13}})
+    </li>
+  </ul>
+</div>
+
 {# If this is not an imported layer then hide the edit ui #}
 {% if not layerversion.layer_source_id or layerversion.layer_source.sourcetype != layerversion.layer_source.TYPE_IMPORTED %}
 <style scoped>
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index b5d97cb..0fbfb59 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -30,12 +30,7 @@ vim: expandtab tabstop=2
 
 {%else%}
 
-<div id="main" role="main" data-ng-app="project" data-ng-controller="prjCtrl" class="top-padded" data-ng-cloak>
-
-  <!-- project name -->
-  <div class="page-header">
-    <h1>{[project.name]}</h1>
-  </div>
+<div id="main" role="main" data-ng-app="project" data-ng-controller="prjCtrl" data-ng-cloak>
 
   <!-- alerts section 1-->
   <div data-ng-repeat="a in zone1alerts">
@@ -120,27 +115,6 @@ vim: expandtab tabstop=2
   </script>
 
 
-  <!-- build form -->
-  <div class="well">
-    <form class="build-form" data-ng-submit="buildNamedTarget()">
-      <div class="input-append controls">
-        <input type="text" class="huge input-xxlarge" placeholder="Type the recipe(s) you want to build" autocomplete="off" data-ng-model="targetName" data-typeahead="a.name for a in getRecipesAutocompleteSuggestions($viewValue)" data-typeahead-template-url="recipes_suggestion_details" data-ng-disabled="!project.release || !layers.length"/>
-        <button type="submit" class="btn btn-large btn-primary" data-ng-disabled="!targetName.length">
-        Build
-        </button>
-      </div>
-      <i class="icon-question-sign get-help get-help-blue" title="Type the name of one or more recipes you want to build, separated by a space. You can also specify a task by appending a semicolon and a task name to a recipe name, like so: <code>core-image-minimal:do_build</code>"></i>
-      <p>
-        <a href="{% url 'projecttargets' project.id %}">View all compatible recipes</a>
-        <i class="icon-question-sign get-help get-help-blue heading-help" title="View all the recipes you can build with the release selected for this project, which is {[project.release.desc]}"></i>
-        {% if completedbuilds.count %}
-          | <a href="{% url 'projectbuilds' project.id %}">View all project builds ({{completedbuilds.count}})</a>
-        {% endif %}
-      </p>
-    </form>
-  </div>
-
-
   <!-- latest builds list -->
 
   <a id="buildslist"></a>
@@ -290,7 +264,7 @@ vim: expandtab tabstop=2
       </div>
       <form data-ng-submit="layerAdd()">
         <div class="input-append">
-          <input type="text" class="input-xlarge" id="layer" autocomplete="off" placeholder="Type a layer name" data-minLength="1" data-ng-model="layerAddName" data-typeahead="e for e in getLayersAutocompleteSuggestions($viewValue)" data-typeahead-template-url="layers_suggestion_details" data-typeahead-on-select="onLayerSelect($item, $model, $label)" data-typeahead-editable="false" data-ng-class="{ 'has-error': layerAddName.$invalid }" data-ng-disabled="!project.release" />
+          <input type="text" style="width: 100%" id="layer" autocomplete="off" placeholder="Type a layer name" data-minLength="1" data-ng-model="layerAddName" data-typeahead="e for e in getLayersAutocompleteSuggestions($viewValue)" data-typeahead-template-url="layers_suggestion_details" data-typeahead-on-select="onLayerSelect($item, $model, $label)" data-typeahead-editable="false" data-ng-class="{ 'has-error': layerAddName.$invalid }" data-ng-disabled="!project.release" />
           <input type="submit" id="add-layer" class="btn" value="Add" data-ng-disabled="!layerAddName.length"/>
         </div>
         {% csrf_token %}
@@ -317,7 +291,7 @@ vim: expandtab tabstop=2
       </h3>
         <form data-ng-submit="buildNamedTarget()">
           <div class="input-append">
-            <input type="text" class="input-xlarge" placeholder="Type the recipe(s) you want to build" autocomplete="off" data-minLength="1"  data-ng-model="targetName1" data-typeahead="a.name for a in getRecipesAutocompleteSuggestions($viewValue)" data-typeahead-template-url="recipes_suggestion_details" data-ng-disabled="!project.release || !layers.length">
+            <input type="text" style="width: 100%" placeholder="Type the recipe(s) you want to build" autocomplete="off" data-minLength="1"  data-ng-model="targetName1" data-typeahead="a.name for a in getRecipesAutocompleteSuggestions($viewValue)" data-typeahead-template-url="recipes_suggestion_details" data-ng-disabled="!project.release || !layers.length">
             <button type="submit" class="btn btn-primary" data-ng-disabled="!targetName1.length">
               Build </button>
           </div>
@@ -420,8 +394,10 @@ vim: expandtab tabstop=2
     </div>
   </div>
 
-<!-- end main -->
-</div>
+</div> <!-- end main -->
+
+</div> <!-- end row -->
+
 
 
 <!-- load application logic !-->
diff --git a/lib/toaster/toastergui/templates/projectbuilds.html b/lib/toaster/toastergui/templates/projectbuilds.html
index ac87d8c..646755b 100644
--- a/lib/toaster/toastergui/templates/projectbuilds.html
+++ b/lib/toaster/toastergui/templates/projectbuilds.html
@@ -1,10 +1,7 @@
-{% extends "baseprojectpage.html" %}
+{% extends "baseprojectbuildspage.html" %}
 {% load projecttags %}
 {% load humanize %}
 
-{% block localbreadcrumb %}
-<li>Project builds</li>
-{% endblock %}
 
 {% block extraheadcontent %}
 <link rel="stylesheet" href="/static/css/jquery-ui.min.css" type='text/css'>
diff --git a/lib/toaster/toastergui/templates/projectconf.html b/lib/toaster/toastergui/templates/projectconf.html
index 01ece24..4c5a188 100644
--- a/lib/toaster/toastergui/templates/projectconf.html
+++ b/lib/toaster/toastergui/templates/projectconf.html
@@ -2,14 +2,10 @@
 {% load projecttags %}
 {% load humanize %}
 
-{% block localbreadcrumb %}
-<li>Configuration variables</li>
-{% endblock %}
 
 {% block projectinfomain %}
-    <div class="page-header">
-        <h1>Configuration variables</h1>
-    </div>
+
+<h2>Bitbake variables</h2>
 
     <div style="padding-left:19px;">
 
diff --git a/lib/toaster/toastergui/templates/projecttopbar.html b/lib/toaster/toastergui/templates/projecttopbar.html
new file mode 100644
index 0000000..46473cb
--- /dev/null
+++ b/lib/toaster/toastergui/templates/projecttopbar.html
@@ -0,0 +1,38 @@
+<!-- project name -->
+<div class="row-fluid page-header">
+  <h1>{{project.name}}</h1>
+</div>
+
+<div class="row-fluid" id="project-topbar">
+  <ul class="nav nav-pills">
+    <li>
+      <a href="{% url 'projectbuilds' project.id %}">
+        Builds (<span class="total-builds"></span>)
+      </a>
+    </li>
+    <li id="topbar-configuration-tab">
+      <a href="{% url 'project' project.id %}">
+        Configuration
+      </a>
+    </li>
+    <!-- Coming soon
+    <li>
+      <a href="my-image-recipes.html">
+        My image recipes
+      </a>
+    </li>
+    -->
+    <li class="pull-right">
+      <form class="form-inline" style="margin-bottom: 0">
+
+        <i class="icon-question-sign get-help heading-help" data-placement="left" title="" data-original-title="Type the name of one or more recipes you want to build, separated by a space. You can also specify a task by appending a semicolon and a task name to the recipe name, like so: <code>busybox:clean</code>">
+        </i>
+        <div class="input-append">
+          <input type="text" class="input-xlarge build-target-input" placeholder="Type the recipe you want to build" autocomplete="off">
+            <button class="btn btn-primary build-button" data-project-id="{{project.id}}" disabled>Build
+            </button>
+          </div>
+        </form>
+      </li>
+    </ul>
+</div>
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index feb1513..beb4303 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -87,13 +87,13 @@ urlpatterns = patterns('toastergui.views',
         url(r'^project/(?P<pid>\d+)/machines/$',
             tables.MachinesTable.as_view(template_name="generic-toastertable-page.html"),
             { 'table_name': tables.MachinesTable.__name__.lower(),
-              'title' : 'All compatible machines' },
+              'title' : 'Compatible machines' },
             name="projectmachines"),
 
         url(r'^project/(?P<pid>\d+)/recipes/$',
             tables.RecipesTable.as_view(template_name="generic-toastertable-page.html"),
             { 'table_name': tables.RecipesTable.__name__.lower(),
-              'title' : 'All compatible recipes' },
+              'title' : 'Compatible recipes' },
             name="projecttargets"),
 
         url(r'^project/(?P<pid>\d+)/availablerecipes/$',
@@ -105,7 +105,7 @@ urlpatterns = patterns('toastergui.views',
         url(r'^project/(?P<pid>\d+)/layers/$',
             tables.LayersTable.as_view(template_name="generic-toastertable-page.html"),
             { 'table_name': tables.LayersTable.__name__.lower(),
-              'title' : 'All compatible layers' },
+              'title' : 'Compatible layers' },
             name="projectlayers"),
 
         url(r'^project/(?P<pid>\d+)/layer/(?P<layerid>\d+)$',
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 82650d0..9c63aae 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2627,6 +2627,7 @@ if True:
         except InvalidRequestException as e:
             raise RedirectException('projectbuilds', request.GET, e.response, pid = pid)
 
+        context['project'] = prj
         _set_parameters_values(pagesize, orderby, request)
 
         return context
-- 
2.1.4


