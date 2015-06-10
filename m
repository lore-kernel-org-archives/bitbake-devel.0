Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id A1C23758E4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 14:39:53 +0000 (UTC)
Received: by wgme6 with SMTP id e6so37427883wgm.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 07:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=XiEXVesnQeV7ag6RWFoB9Y99IHFduOP2LLwBVuyjmxo=;
	b=CqcnGiXn6JQKpT8q44imU9NLqPzrErT53IlBRHm5FM2sRzhZiFVoNSztpSJki+fYBP
	Jz0PcB49HoJn2cg3COEPgbXfEhBvMrq8aOdxMGBPqlD4GE8pfVs+2y3XewvBx52Arc4g
	CZsdHjXvCvE/W8gOER/sNT7AzS7fWru2rne4SsAvIuwqwegJgEBgn2ST1pQNoF4RXi9/
	ZVAkc0YfHcsc//Pbsm7ClOAvRZMkncdUJLu3DvMIzkR+jhKAqks52rbB5gJs7LFjsHVu
	k51LJTo2fCQgLhlOGwD1T0Q2uz49ueYMuNTZVxAUkI3rWjqyADAKA7Yu/ADfgggHiE/2
	T8vw==
X-Gm-Message-State: ALoCoQm8ha/ZA6guR8lzSvFIJXKWzZBQxrMrItYilADdpE6z0x5lTL3HuHZoul9aaB0vejTEnJgx
X-Received: by 10.180.106.195 with SMTP id gw3mr9139697wib.25.1433947194728;
	Wed, 10 Jun 2015 07:39:54 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id df1sm8294717wib.12.2015.06.10.07.39.53
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Jun 2015 07:39:53 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 1F781561215; Wed, 10 Jun 2015 15:39:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jun 2015 15:39:01 +0100
Message-Id: <a5bc29083d4f85a5695f3f62d5badb783c6f7224.1433946742.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
References: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1433946742.git.alexandru.damian@intel.com>
References: <cover.1433946742.git.alexandru.damian@intel.com>
Subject: [PATCH 13/19] toaster: fixes after refactoring
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
X-List-Received-Date: Wed, 10 Jun 2015 14:39:54 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes issues brought in by refactoring:

* the New Build button is working with pre-set projects
* the xhr_datatypeahead is exposed for calls that are not
mapable to the REST objects
* a new table returing recipes provided by layers currently
selected in the project is used to provide recipe suggestions
* the field names in json are switched from "list" to "rows" as
to maintain consistency with the ToasterTables
* the "value" field in xhr_ calls is now named "search" to maintain
consistency

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/orm/models.py                      |   5 +-
 lib/toaster/toastergui/static/js/base.js       | 104 +++++++++++++++----------
 lib/toaster/toastergui/static/js/libtoaster.js |   2 +-
 lib/toaster/toastergui/static/js/projectapp.js |  24 ++++--
 lib/toaster/toastergui/tables.py               |  10 ++-
 lib/toaster/toastergui/templates/base.html     |   7 +-
 lib/toaster/toastergui/templates/project.html  |   3 +-
 lib/toaster/toastergui/urls.py                 |   8 ++
 lib/toaster/toastergui/views.py                |  17 ++--
 9 files changed, 116 insertions(+), 64 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 8e73ee1..8819450 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -180,13 +180,12 @@ class Project(models.Model):
             queryset = queryset.filter(layer__name = layer_name)
 
         # order by layer version priority
-        queryset = queryset.filter(Q(layer_source=None) | Q(layer_source__releaselayersourcepriority__release = release)).select_related('layer_source', 'layer', 'up_branch').annotate(prio=Avg("layer_source__releaselayersourcepriority__priority")).order_by("-prio")
+        queryset = queryset.filter(Q(layer_source=None) | Q(layer_source__releaselayersourcepriority__release = release)).select_related('layer_source', 'layer', 'up_branch', "layer_source__releaselayersourcepriority__priority").order_by("-layer_source__releaselayersourcepriority__priority")
 
         return queryset
 
-    # returns a set of layer-equivalent set of layers already in project
     def projectlayer_equivalent_set(self):
-        return [j for i in [x.layercommit.get_equivalents_wpriority(self) for x in self.projectlayer_set.all().select_related("up_branch")] for j in i]
+        return self.compatible_layerversions().filter(layer__name__in = [x.layercommit.layer.name for x in self.projectlayer_set.all()]).select_related("up_branch")
 
     def schedule_build(self):
         from bldcontrol.models import BuildRequest, BRTarget, BRLayer, BRVariable, BRBitbake
diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index 747442c..06d0676 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -1,100 +1,118 @@
+'use strict';
 
-
-function basePageInit (ctx) {
+function basePageInit(ctx) {
 
   var newBuildButton = $("#new-build-button");
   /* Hide the button if we're on the project,newproject or importlyaer page
    * or if there are no projects yet defined
    */
-  if (ctx.numProjects == 0 || ctx.currentUrl.search('newproject|project/\\d$|importlayer$') > 0){
-      newBuildButton.hide();
-      return;
+  if (ctx.numProjects === 0 || ctx.currentUrl.search('newproject|project/\\d$|importlayer$') > 0) {
+    newBuildButton.hide();
+    return;
   }
 
   var currentProjectId = libtoaster.ctx.projectId;
 
   /* Hide the change project icon when there is only one project */
-  if (ctx.numProjects == 1){
-     $('#project .icon-pencil').hide();
+  if (ctx.numProjects === 1) {
+    $('#project .icon-pencil').hide();
   }
 
   newBuildButton.show().removeAttr("disabled");
 
 
-  _checkProjectBuildable()
+  var newBuildProjectInput = $("#new-build-button #project-name-input");
+  var newBuildTargetBuildBtn = $("#new-build-button #build-button");
+  var newBuildTargetInput = $("#new-build-button #build-target-input");
+  var newBuildProjectSaveBtn = $("#new-build-button #save-project-button");
+
+
+  var selectedTarget;
+
+  _checkProjectBuildable();
   _setupNewBuildButton();
 
 
-  function _checkProjectBuildable(){
-    if (libtoaster.ctx.projectId == undefined)
+  function _checkProjectBuildable() {
+    if (libtoaster.ctx.projectId === undefined) {
       return;
+    }
 
     libtoaster.getProjectInfo(libtoaster.ctx.projectPageUrl,
-      function(data){
-        if (data.machine.name == undefined || data.layers.length == 0) {
+      function (data) {
+        if (data.machine.name === undefined || data.layers.length === 0) {
           /* we can't build anything with out a machine and some layers */
           $("#new-build-button #targets-form").hide();
           $("#new-build-button .alert").show();
         } else {
           $("#new-build-button #targets-form").show();
           $("#new-build-button .alert").hide();
+
+          /* we can build this project; enable input fields */
+          newBuildTargetInput.prop("disabled", false);
+          newBuildTargetBuildBtn.prop("disabled", false);
+
+          libtoaster.makeTypeahead(newBuildTargetInput, libtoaster.ctx.projectTargetsUrl, { format: "json" }, function (item) {
+            /* successfully selected a target */
+            selectedTarget = item;
+          });
+
         }
-    }, null);
+      }, null);
   }
 
   function _setupNewBuildButton() {
     /* Setup New build button */
-    var newBuildProjectInput = $("#new-build-button #project-name-input");
-    var newBuildTargetBuildBtn = $("#new-build-button #build-button");
-    var newBuildTargetInput = $("#new-build-button #build-target-input");
-    var newBuildProjectSaveBtn = $("#new-build-button #save-project-button");
-    var selectedTarget;
     var selectedProject;
 
     /* If we don't have a current project then present the set project
      * form.
      */
-    if (libtoaster.ctx.projectId == undefined) {
+    if (libtoaster.ctx.projectId === undefined) {
       $('#change-project-form').show();
       $('#project .icon-pencil').hide();
     }
 
 
-    libtoaster.makeTypeahead(newBuildProjectInput, libtoaster.ctx.projectsUrl, { format : "json" }, function(item){
-        /* successfully selected a project */
-        newBuildProjectSaveBtn.removeAttr("disabled");
-        selectedProject = item;
+    libtoaster.makeTypeahead(newBuildProjectInput, libtoaster.ctx.projectsUrl, { format : "json" }, function (item) {
+      /* successfully selected a project */
+      newBuildProjectSaveBtn.removeAttr("disabled");
+      selectedProject = item;
     });
 
     /* Any typing in the input apart from enter key is going to invalidate
      * the value that has been set by selecting a suggestion from the typeahead
      */
-    newBuildProjectInput.on('input', function(event) {
-        if (event.keyCode == 13)
-          return;
-        newBuildProjectSaveBtn.attr("disabled", "disabled");
+    newBuildProjectInput.on('input', function (event) {
+      if (event.keyCode === 13) {
+        return;
+      }
+      newBuildProjectSaveBtn.attr("disabled", "disabled");
     });
 
-    newBuildTargetInput.on('input', function() {
-      if ($(this).val().length == 0)
+    newBuildTargetInput.on('input', function () {
+      if ($(this).val().length === 0) {
         newBuildTargetBuildBtn.attr("disabled", "disabled");
-      else
+      } else {
         newBuildTargetBuildBtn.removeAttr("disabled");
+      }
     });
 
-    newBuildTargetBuildBtn.click(function() {
-      if (!newBuildTargetInput.val())
+    newBuildTargetBuildBtn.click(function () {
+      if (!newBuildTargetInput.val()) {
         return;
+      }
 
-      if (!selectedTarget)
+      if (!selectedTarget) {
         selectedTarget = { name: newBuildTargetInput.val() };
+      }
       /* fire and forget */
-      libtoaster.startABuild(ctx.projectBuildsUrl, libtoaster.ctx.projectId, selectedTarget.name, null, null);
+      libtoaster.startABuild(libtoaster.ctx.projectBuildsUrl, libtoaster.ctx.projectId, selectedTarget.name, null, null);
       window.location.replace(libtoaster.ctx.projectPageUrl);
     });
 
-    newBuildProjectSaveBtn.click(function() {
-      libtoaster.ctx.projectId = selectedProject.pk
+    newBuildProjectSaveBtn.click(function () {
+      libtoaster.ctx.projectId = selectedProject.pk;
       /* Update the typeahead project_id paramater */
       _checkProjectBuildable();
 
@@ -111,10 +129,10 @@ function basePageInit (ctx) {
       newBuildTargetInput.prop("disabled", false);
       newBuildTargetBuildBtn.prop("disabled", false);
 
-      libtoaster.makeTypeahead(newBuildTargetInput, selectedProject.projectTargetsUrl, { format: "json" }, function(item){
+      libtoaster.makeTypeahead(newBuildTargetInput, selectedProject.projectTargetsUrl, { format: "json" }, function (item) {
         /* successfully selected a target */
         selectedTarget = item;
-	    });
+      });
 
       newBuildTargetInput.val("");
 
@@ -123,12 +141,12 @@ function basePageInit (ctx) {
       $("#new-build-button .alert a").attr('href', libtoaster.ctx.projectPageUrl);
       $("#project .icon-pencil").show();
 
-      $("#change-project-form").slideUp({ 'complete' : function() {
+      $("#change-project-form").slideUp({ 'complete' : function () {
           $("#new-build-button #project").show();
       }});
     });
 
-    $('#new-build-button #project .icon-pencil').click(function() {
+    $('#new-build-button #project .icon-pencil').click(function () {
       newBuildProjectSaveBtn.attr("disabled", "disabled");
       newBuildProjectInput.val($("#new-build-button #project a").text());
       $("#cancel-change-project").show();
@@ -136,8 +154,8 @@ function basePageInit (ctx) {
       $("#change-project-form").slideDown();
     });
 
-    $("#new-build-button #cancel-change-project").click(function() {
-      $("#change-project-form").hide(function(){
+    $("#new-build-button #cancel-change-project").click(function () {
+      $("#change-project-form").hide(function () {
         $('#new-build-button #project').show();
       });
 
@@ -146,7 +164,7 @@ function basePageInit (ctx) {
     });
 
     /* Keep the dropdown open even unless we click outside the dropdown area */
-    $(".new-build").click (function(event) {
+    $(".new-build").click (function (event) {
       event.stopPropagation();
     });
   };
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index b1038cf..23755a7 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -25,7 +25,7 @@ var libtoaster = (function (){
               return;
             }
 
-            return process (data.list);
+            return process (data.rows);
           });
         },
         updater: function(item) {
diff --git a/lib/toaster/toastergui/static/js/projectapp.js b/lib/toaster/toastergui/static/js/projectapp.js
index a915278..44e244d 100644
--- a/lib/toaster/toastergui/static/js/projectapp.js
+++ b/lib/toaster/toastergui/static/js/projectapp.js
@@ -217,13 +217,13 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
     $scope.getAutocompleteSuggestions = function(type, currentValue) {
         var deffered = $q.defer();
 
-        $http({method:"GET", url: $scope.urls.xhr_datatypeahead, params : { type: type, value: currentValue}})
+        $http({method:"GET", url: $scope.urls.xhr_datatypeahead, params : { type: type, search: currentValue}})
             .success(function (_data) {
                 if (_data.error != "ok") {
                     console.warn(_data.error);
                     deffered.reject(_data.error);
                 }
-                deffered.resolve(_data.list);
+                deffered.resolve(_data.rows);
             });
 
         return deffered.promise;
@@ -534,8 +534,17 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
              if (_data.error != "ok") {
                  console.warn(_data.error);
              } else {
-                 console.log("got layer deps", _data.layerdeps.list);
-                 if (_data.layerdeps.list.length > 0) {
+                /* filter out layers that are already in the project */
+                var filtered_list = [];
+                var projectlayers_ids = $scope.layers.map(function (e) { return e.id });
+                for (var i = 0; i < _data.layerdeps.list.length; i++) {
+                    if (projectlayers_ids.indexOf(_data.layerdeps.list[i].id) == -1) {
+                        filtered_list.push( _data.layerdeps.list[i]);
+                    }
+                }
+
+                _data.layerdeps.list = filtered_list;
+                if (_data.layerdeps.list.length > 0) {
                      // activate modal
                      console.log("listing modals");
                      var modalInstance = $modal.open({
@@ -575,7 +584,6 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                      console.log("built modal instance", modalInstance);
 
                      modalInstance.result.then(function (selectedArray) {
-                         console.log("layer to add", $scope.layerToAdd)
                          selectedArray.push($scope.layerToAdd.id);
                          console.warn("TRC6: selected", selectedArray);
 
@@ -634,13 +642,13 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
     $scope.testProjectSettingsChange = function(elementid) {
         if (elementid != '#change-project-version') throw "Not implemented";
 
-        $http({method:"GET", url: $scope.urls.xhr_datatypeahead, params : { type: "versionlayers", value: $scope.projectVersion }}).
+        $http({method:"GET", url: $scope.urls.xhr_datatypeahead, params : { type: "versionlayers", search: $scope.projectVersion }}).
         success(function (_data) {
             if (_data.error != "ok") {
                 alert (_data.error);
             }
             else {
-                 if (_data.list.length > 0) {
+                 if (_data.rows.length > 0) {
                      // activate modal
                      var modalInstance = $modal.open({
                        templateUrl: 'change_version_modal',
@@ -660,7 +668,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                        },
                        resolve: {
                          items: function () {
-                             return _data.list;
+                             return _data.rows;
                          },
                          releaseName: function () {
                              return $scope.releases.filter(function (e) { if (e.id == $scope.projectVersion) return e;})[0].name;
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 003b924..b85527e 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -287,7 +287,7 @@ class RecipesTable(ToasterTable):
     def setup_queryset(self, *args, **kwargs):
         prj = Project.objects.get(pk = kwargs['pid'])
 
-        self.queryset = Recipe.objects.filter(Q(layer_version__up_branch__name= prj.release.name) | Q(layer_version__build__in = prj.build_set.all())).filter(name__regex=r'.{1,}.*')
+        self.queryset = Recipe.objects.filter(layer_version__in = prj.compatible_layerversions())
 
         search_maxids = map(lambda i: i[0], list(self.queryset.values('name').distinct().annotate(max_id=Max('id')).values_list('max_id')))
 
@@ -392,3 +392,11 @@ class LayerRecipesTable(RecipesTable):
         self.add_column(title="Build recipe",
                         static_data_name="add-del-layers",
                         static_data_template=build_recipe_template)
+
+class ProjectLayersRecipesTable(RecipesTable):
+    """ Table that lists only recipes available for layers added to the project """
+
+    def setup_queryset(self, *args, **kwargs):
+        super(ProjectLayersRecipesTable, self).setup_queryset(*args, **kwargs)
+        prj = Project.objects.get(pk = kwargs['pid'])
+        self.queryset = self.queryset.filter(layer_version__in = prj.projectlayer_equivalent_set())
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 7fee26e..6cdc5e8 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -1,5 +1,6 @@
 <!DOCTYPE html>
 {% load static %}
+{% load projecttags %}
 <html lang="en">
     <head>
         <title>{% if objectname %} {{objectname|title}} - {% endif %}Toaster</title>
@@ -33,8 +34,10 @@
     htmlUrl : "{% static 'html/' %}",
     projectsUrl : "{% url 'all-projects' %}",
     {% if project.id %}
-      projectPageUrl : "{% url 'project' project.id %}",
-      projectName : "{{project.name}}",
+      projectPageUrl : {% url 'project' project.id as purl%}{{purl|json}},
+      projectName : {{project.name|json}},
+      projectTargetsUrl: {% url 'projectavailabletargets' project.id as paturl%}{{paturl|json}},
+      projectBuildsUrl: {% url 'projectbuilds' project.id as pburl %}{{pburl|json}},
       projectId : {{project.id}},
     {% else %}
       projectPageUrl : undefined,
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 7225363..bca703a 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -452,9 +452,10 @@ angular.element(document).ready(function() {
   scope.urls.xhr_build = "{% url 'projectbuilds' project.id %}";
   scope.urls.xhr_edit = "{% url 'project' project.id %}?format=json";
   scope.urls.layers = "{% url 'projectlayers' project.id %}";
-  scope.urls.targets = "{% url 'projecttargets' project.id %}";
+  scope.urls.targets = "{% url 'projectavailabletargets' project.id %}";
   scope.urls.machines = "{% url 'projectmachines' project.id %}";
   scope.urls.importlayer = "{% url 'importlayer' project.id %}";
+  scope.urls.xhr_datatypeahead = {% url 'xhr_datatypeahead' project.id as xhrdta %}{{xhrdta|json}};
   scope.project = {{prj|json}};
   scope.builds = {{builds|json}};
   scope.layers = {{layers|json}};
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 5a79f88..bd3eb40 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -96,6 +96,12 @@ urlpatterns = patterns('toastergui.views',
               'title' : 'All compatible recipes' },
             name="projecttargets"),
 
+        url(r'^project/(?P<pid>\d+)/availablerecipes/$',
+            tables.ProjectLayersRecipesTable.as_view(template_name="generic-toastertable-page.html"),
+            { 'table_name': tables.ProjectLayersRecipesTable.__name__.lower(),
+              'title' : 'Recipes available for layers in the current project' },
+            name="projectavailabletargets"),
+
         url(r'^project/(?P<pid>\d+)/layers/$',
             tables.LayersTable.as_view(template_name="generic-toastertable-page.html"),
             { 'table_name': tables.LayersTable.__name__.lower(),
@@ -118,6 +124,8 @@ urlpatterns = patterns('toastergui.views',
               'title' : 'All machines in layer' },
             name=tables.LayerMachinesTable.__name__.lower()),
 
+
+        url(r'^xhr_datatypeahead/(?P<pid>\d+)$', 'xhr_datatypeahead', name='xhr_datatypeahead'),
         url(r'^xhr_configvaredit/(?P<pid>\d+)$', 'xhr_configvaredit', name='xhr_configvaredit'),
 
         url(r'^xhr_importlayer/$', 'xhr_importlayer', name='xhr_importlayer'),
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index b2b263b..4dac62c 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -129,9 +129,9 @@ def _template_renderer(template):
 
             if request.GET.get('format', None) == 'json':
                 # objects is a special keyword - it's a Page, but we need the actual objects here
-                # in XHR, the objects come in the "list" property
+                # in XHR, the objects come in the "rows" property
                 if "objects" in context:
-                    context["list"] = context["objects"].object_list
+                    context["rows"] = context["objects"].object_list
                     del context["objects"]
 
                 # we're about to return; to keep up with the XHR API, we set the error to OK
@@ -2340,7 +2340,7 @@ if toastermain.settings.MANAGED:
                         retval.append(i)
 
                 return HttpResponse(jsonfilter( {"error":"ok",
-                    "list" : map( _lv_to_dict(prj),  map(lambda x: x.layercommit, retval ))
+                    "rows" : map( _lv_to_dict(prj),  map(lambda x: x.layercommit, retval ))
                     }), content_type = "application/json")
 
 
@@ -2358,7 +2358,7 @@ if toastermain.settings.MANAGED:
                     # and show only the selected layers for this project
                     final_list = set([x.get_equivalents_wpriority(prj)[0] for x in queryset_all])
 
-                return HttpResponse(jsonfilter( { "error":"ok",  "list" : map( _lv_to_dict(prj), final_list) }), content_type = "application/json")
+                return HttpResponse(jsonfilter( { "error":"ok",  "rows" : map( _lv_to_dict(prj), final_list) }), content_type = "application/json")
 
 
             raise Exception("Unknown request! " + request.GET.get('type', "No parameter supplied"))
@@ -2845,7 +2845,7 @@ if toastermain.settings.MANAGED:
             p.projectPageUrl = reverse('project', args=(p.id,))
             p.projectLayersUrl = reverse('projectlayers', args=(p.id,))
             p.projectBuildsUrl = reverse('projectbuilds', args=(p.id,))
-            p.projectTargetsUrl = reverse('projecttargets', args=(p.id,))
+            p.projectTargetsUrl = reverse('projectavailabletargets', args=(p.id,))
 
         # build view-specific information; this is rendered specifically in the builds page, at the top of the page (i.e. Recent builds)
         build_mru = _managed_get_latest_builds()
@@ -3144,6 +3144,13 @@ else:
     def project(request, pid):
         return {}
 
+    from django.views.decorators.csrf import csrf_exempt
+    @csrf_exempt
+    @_template_renderer('landing_not_managed.html')
+    def xhr_datatypeahead(request, pid):
+        return {}
+
+
     @_template_renderer('landing_not_managed.html')
     def xhr_configvaredit(request, pid):
         return {}
-- 
1.9.1


