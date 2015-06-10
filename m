Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id 6C5AA758D6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 14:39:49 +0000 (UTC)
Received: by wifx6 with SMTP id x6so49713514wif.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 07:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=5dqoX1KvS6pS7Ql1B1xkfqiLDpti8gudQ0OZ9C21KN8=;
	b=MbnHF8tP9pOUTvnMDzUqwBl72k9sK0zftaTbTDZjJo8xehzUXrpJxuDIfetoTZrHLP
	YTDKfoGKYzop4chZ5c4fWqkbNBDTxPkWphM4MjKurx46JoU7UBfJ6xu9QgCMgslUNJxi
	mTXAG0h/uHQvw/SpCaDrAwXoP+0I/o7sYEauUYKHnvgvxIucNiKlx/CA3qaPhZg9I3wt
	lU5sA/UJ7leggVm7UvYrxZwPKfBzZGwYVZBFBkJv1ncOctHm/en44zRiWlHKwGBt7br0
	Ncisylm0OnwINyzcFtUXWzAqMyeDEruzo+OHaTi22mtLF5pg13vdLO92zPRFNGkF7G0G
	EzwA==
X-Gm-Message-State: ALoCoQnrsomsfqWonleOFMGpcj6zaWmne3VnUaJhj8ukpmf15+sZ6fI1VMG8VwaXA85KvnZ3i8no
X-Received: by 10.180.231.4 with SMTP id tc4mr9246114wic.27.1433947190921;
	Wed, 10 Jun 2015 07:39:50 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id ny7sm8295069wic.11.2015.06.10.07.39.49
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Jun 2015 07:39:49 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 1DA29560FDA; Wed, 10 Jun 2015 15:39:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jun 2015 15:39:00 +0100
Message-Id: <33d2b87aca667d72262a3928deaf35414b46a7c1.1433946742.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
References: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1433946742.git.alexandru.damian@intel.com>
References: <cover.1433946742.git.alexandru.damian@intel.com>
Subject: [PATCH 12/19] toastergui: remove xhr_datatypeahaed layerdeps call
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
X-List-Received-Date: Wed, 10 Jun 2015 14:39:50 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch removes the url-constructing calls to get the layer details
in favor of embedding the look-up URL in the JSON data on the
layer list page.

This allows further removal of the XHR-specific code for layer dependencies
in favor of REST calls to layer details data.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/js/importlayer.js    |  8 +--
 lib/toaster/toastergui/static/js/layerdetails.js   |  2 +-
 lib/toaster/toastergui/static/js/libtoaster.js     |  9 ++--
 lib/toaster/toastergui/static/js/projectapp.js     | 61 ++++++++++++++++------
 lib/toaster/toastergui/tables.py                   | 23 +++++---
 lib/toaster/toastergui/templates/importlayer.html  |  1 -
 lib/toaster/toastergui/templates/layerdetails.html |  1 -
 lib/toaster/toastergui/templates/project.html      |  1 -
 lib/toaster/toastergui/urls.py                     |  3 --
 lib/toaster/toastergui/views.py                    | 11 +---
 10 files changed, 73 insertions(+), 47 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index e1fc5c5..e9d7ae8 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -48,7 +48,7 @@ function importLayerPageInit (ctx) {
     newLayerDep.children("span").tooltip();
 
     var link = newLayerDep.children("a");
-    link.attr("href", ctx.layerDetailsUrl+String(currentLayerDepSelection.id));
+    link.attr("href", currentLayerDepSelection.layerDetailsUrl);
     link.text(currentLayerDepSelection.name);
     link.tooltip({title: currentLayerDepSelection.tooltip, placement: "right"});
 
@@ -63,11 +63,11 @@ function importLayerPageInit (ctx) {
 
     $("#layer-deps-list").append(newLayerDep);
 
-    libtoaster.getLayerDepsForProject(libtoaster.ctx.projectId, currentLayerDepSelection.id, function (data){
+    libtoaster.getLayerDepsForProject(currentLayerDepSelection.layerDetailsUrl, function (data){
         /* These are the dependencies of the layer added as a dependency */
         if (data.list.length > 0) {
-          currentLayerDepSelection.url = ctx.layerDetailsUrl+currentLayerDepSelection.id;
-          layerDeps[currentLayerDepSelection.id].deps = data.list
+          currentLayerDepSelection.url = currentLayerDepSelection.layerDetailsUrl;
+          layerDeps[currentLayerDepSelection.id].deps = data.list;
         }
 
         /* Clear the current selection */
diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index ab78182..0accd97 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -65,7 +65,7 @@ function layerDetailsPageInit (ctx) {
       newLayerDep.children("span").tooltip();
 
       var link = newLayerDep.children("a");
-      link.attr("href", ctx.layerDetailsUrl+String(currentLayerDepSelection.id));
+      link.attr("href", currentLayerDepSelection.layerDetailsUrl);
       link.text(currentLayerDepSelection.name);
       link.tooltip({title: currentLayerDepSelection.tooltip, placement: "right"});
 
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 2a9a790..b1038cf 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -170,10 +170,10 @@ var libtoaster = (function (){
     });
   }
 
-  function _getLayerDepsForProject(projectId, layerId, onSuccess, onFail){
+  function _getLayerDepsForProject(url, onSuccess, onFail){
     /* Check for dependencies not in the current project */
-    $.getJSON(libtoaster.ctx.projectLayersUrl,
-      { format: 'json', search: layerId },
+    $.getJSON(url,
+      { format: 'json' },
       function(data) {
         if (data.error != "ok") {
           console.log(data.error);
@@ -225,8 +225,7 @@ var libtoaster = (function (){
   function _addRmLayer(layerObj, add, doneCb){
     if (add === true) {
       /* If adding get the deps for this layer */
-      libtoaster.getLayerDepsForProject(libtoaster.ctx.projectId,
-        layerObj.id,
+      libtoaster.getLayerDepsForProject(layerObj.url,
         function (layers) {
 
         /* got result for dependencies */
diff --git a/lib/toaster/toastergui/static/js/projectapp.js b/lib/toaster/toastergui/static/js/projectapp.js
index 36c942f..a915278 100644
--- a/lib/toaster/toastergui/static/js/projectapp.js
+++ b/lib/toaster/toastergui/static/js/projectapp.js
@@ -16,7 +16,9 @@
 //  with this program; if not, write to the Free Software Foundation, Inc.,
 //  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-angular_formpost = function($httpProvider) {
+'use strict';
+
+var angular_formpost = function($httpProvider) {
   // Use x-www-form-urlencoded Content-Type
   // By Ezekiel Victor, http://victorblog.com/2012/12/20/make-angularjs-http-service-behave-like-jquery-ajax/, no license, with attribution
   $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=utf-8';
@@ -127,10 +129,10 @@ projectApp.filter('timediff', function() {
             if (parseInt(j) < 10) {return "0" + j;}
             return j;
         }
-        seconds = parseInt(input);
-        minutes = Math.floor(seconds / 60);
+        var seconds = parseInt(input);
+        var minutes = Math.floor(seconds / 60);
         seconds = seconds - minutes * 60;
-        hours = Math.floor(seconds / 3600);
+        var hours = Math.floor(seconds / 3600);
         seconds = seconds - hours * 3600;
         return pad(hours) + ":" + pad(minutes) + ":" + pad(seconds);
     };
@@ -250,6 +252,31 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
         }
         var deffered = $q.defer();
 
+        /* we only talk in JSON to the server */
+        if (callparams.method == 'GET') {
+            if (callparams.data === undefined) {
+                callparams.data = {};
+            }
+            callparams.data.format = "json";
+        } else {
+            if (callparams.url.indexOf("?") > -1) {
+              callparams.url = callparams.url.split("?").map(function (element, index) {
+                if (index == 1) {
+                    var elements = [];
+                    if (element.indexOf("&")>-1) {
+                        elements = element.split("&");
+                    }
+                    elements.push("format=json");
+                    element = elements.join("&");
+                }
+                return element;
+              }).join("?");
+            } else {
+              callparams.url += "?format=json";
+            }
+        }
+
+
         if (undefined === callparams.headers) { callparams.headers = {}; }
         callparams.headers['X-CSRFToken'] = $cookies.csrftoken;
 
@@ -476,8 +503,9 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
     };
 
 
-    $scope.onLayerSelect = function (item) {
+    $scope.onLayerSelect = function (item, model, label) {
         $scope.layerToAdd = item;
+        $scope.layerAddName = item.layer__name;
     };
 
     $scope.machineSelect = function (machineName) {
@@ -501,20 +529,22 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
 
     $scope.layerAdd = function() {
 
-        $http({method:"GET", url: $scope.layerToAdd.layerdict.layerdetailurl, params : {}})
+        $http({method:"GET", url: $scope.layerToAdd.layerDetailsUrl, params : {format: "json"}})
         .success(function (_data) {
              if (_data.error != "ok") {
                  console.warn(_data.error);
              } else {
-                 if (_data.list.length > 0) {
+                 console.log("got layer deps", _data.layerdeps.list);
+                 if (_data.layerdeps.list.length > 0) {
                      // activate modal
+                     console.log("listing modals");
                      var modalInstance = $modal.open({
                        templateUrl: 'dependencies_modal',
                        controller: function ($scope, $modalInstance, items, layerAddName) {
                          $scope.items =  items;
                          $scope.layerAddName = layerAddName;
                          $scope.selectedItems = (function () {
-                                s = {};
+                                var s = {};
                                 for (var i = 0; i < items.length; i++)
                                     { s[items[i].id] = true; }
                                 return s;
@@ -535,16 +565,18 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                        },
                        resolve: {
                          items: function () {
-                             return _data.list;
+                             return _data.layerdeps.list;
                          },
                          layerAddName: function () {
                              return $scope.layerAddName;
                          },
                        }
                      });
+                     console.log("built modal instance", modalInstance);
 
                      modalInstance.result.then(function (selectedArray) {
-                         selectedArray.push($scope.layerToAdd.layerversion.id);
+                         console.log("layer to add", $scope.layerToAdd)
+                         selectedArray.push($scope.layerToAdd.id);
                          console.warn("TRC6: selected", selectedArray);
 
                          $scope._makeXHRCall({
@@ -563,7 +595,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                          $scope._makeXHRCall({
                              method: "POST", url: $scope.urls.xhr_edit,
                              data: {
-                                 layerAdd:  $scope.layerToAdd.layerversion.id,
+                                 layerAdd:  $scope.layerToAdd.id,
                              }
                          }).then(function () {
                              $scope.layerAddName = undefined;
@@ -772,8 +804,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
             return;
 
           if (imported.deps_added.length === 0) {
-            text = "You have imported <strong><a href=\""+$scope.urls.layer+
-              imported.imported_layer.id+"\">"+imported.imported_layer.name+
+            text = "You have imported <strong><a href=\""+imported.imported_layer.layerDetailsUrl+"\">"+imported.imported_layer.name+
               "</a></strong> and added it to your project.";
           } else {
             var links = "<a href=\""+$scope.urls.layer+
@@ -781,7 +812,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
               "</a>, ";
 
             imported.deps_added.map (function(item, index){
-              links +="<a href=\""+$scope.urls.layer+item.id+"\" >"+item.name+
+              links +="<a href=\""+item.layerDetailsUrl+"\" >"+item.name+
                 "</a>";
               /*If we're at the last element we don't want the trailing comma */
               if (imported.deps_added[index+1] !== undefined)
@@ -832,7 +863,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
         if (zone.maxid === undefined) { zone.maxid = 0; }
         var crtid = zone.maxid ++;
         angular.forEach(zone, function (o) { o.close(); });
-        o = {
+        var o = {
             id: crtid, text: text, type: type,
             close: function() {
                 zone.splice((function(id) {
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index e03aa76..003b924 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -23,6 +23,7 @@ from toastergui.widgets import ToasterTable, ToasterTemplateView
 from orm.models import Recipe, ProjectLayer, Layer_Version, Machine, Project
 from django.db.models import Q, Max
 from django.conf.urls import url
+from django.core.urlresolvers import reverse
 from django.views.generic import TemplateView
 
 class LayersTable(ToasterTable):
@@ -35,9 +36,9 @@ class LayersTable(ToasterTable):
     def get_context_data(self, **kwargs):
         context = super(LayersTable, self).get_context_data(**kwargs)
 
-        context['project'] = Project.objects.get(pk=kwargs['pid'])
-
-        context['projectlayers'] = map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=context['project']))
+        project = Project.objects.get(pk=kwargs['pid'])
+        context['project'] = project
+        context['projectlayers'] = map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=project))
 
         return context
 
@@ -142,6 +143,13 @@ class LayersTable(ToasterTable):
                         static_data_name="add-del-layers",
                         static_data_template='{% include "layer_btn.html" %}')
 
+        project = Project.objects.get(pk=kwargs['pid'])
+        self.add_column(title="LayerDetailsUrl",
+                        displayable = False,
+                        field_name="layerDetailsUrl",
+                        computation = lambda x: reverse('layerdetails', args=(project.id, x.id)))
+
+
 
 
 class LayerDetails(ToasterTemplateView):
@@ -152,7 +160,8 @@ class LayerDetails(ToasterTemplateView):
         context['project'] = Project.objects.get(pk=kwargs['pid'])
         context['layerversion'] = Layer_Version.objects.get(pk=kwargs['layerid'])
         context['layerdict'] = _lv_to_dict(context['project'], context['layerversion'])
-        context['layerdeps'] = {"list": [x.depends_on.get_equivalents_wpriority(context['project'])[0] for x in context['layerversion'].dependencies.all()]}
+        context['layerdeps'] = {"list": [
+            [{"id": y.id, "name": y.layer.name} for y in x.depends_on.get_equivalents_wpriority(context['project'])][0] for x in context['layerversion'].dependencies.all()]}
         context['projectlayers'] = map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=context['project']))
 
         self.context_entries = ['project', 'layerversion', 'projectlayers', 'layerdict', 'layerdeps']
@@ -265,9 +274,10 @@ class RecipesTable(ToasterTable):
         self.default_orderby = "name"
 
     def get_context_data(self, **kwargs):
+        project = Project.objects.get(pk=kwargs['pid'])
         context = super(RecipesTable, self).get_context_data(**kwargs)
 
-        context['project'] = Project.objects.get(pk=kwargs['pid'])
+        context['project'] = project
 
         context['projectlayers'] = map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=context['project']))
 
@@ -342,10 +352,11 @@ class RecipesTable(ToasterTable):
                         static_data_name="add-del-layers",
                         static_data_template='{% include "recipe_btn.html" %}')
 
+        project = Project.objects.get(pk=kwargs['pid'])
         self.add_column(title="Project compatible Layer ID",
                         displayable = False,
                         field_name = "projectcompatible_layer",
-                        computation = lambda x: (x.layer_version.get_equivalents_wpriority(Project.objects.get(pk=kwargs['pid']))[0]))
+                        computation = lambda x: (x.layer_version.get_equivalents_wpriority(project)[0]))
 
 class LayerRecipesTable(RecipesTable):
     """ Smaller version of the Recipes table for use in layer details """
diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
index af8f4f9..498a204 100644
--- a/lib/toaster/toastergui/templates/importlayer.html
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -14,7 +14,6 @@
                   <script>
                     $(document).ready(function (){
                       var ctx = {
-                        layerDetailsUrl : "{% url 'base_layerdetails' project.id %}",
                         xhrImportLayerUrl : "{% url 'xhr_importlayer' %}",
                       };
 
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index ef1795c..7d81b14 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -34,7 +34,6 @@
   $(document).ready(function (){
     var ctx = {
       projectBuildsUrl : "{% url 'projectbuilds' project.id %}",
-      layerDetailsUrl : "{% url 'base_layerdetails' project.id %}",
       xhrUpdateLayerUrl : "{% url 'xhr_updatelayer' %}",
       layerVersion : {
         name : "{{layerversion.layer.name}}",
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 63fbc40..7225363 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -455,7 +455,6 @@ angular.element(document).ready(function() {
   scope.urls.targets = "{% url 'projecttargets' project.id %}";
   scope.urls.machines = "{% url 'projectmachines' project.id %}";
   scope.urls.importlayer = "{% url 'importlayer' project.id %}";
-  scope.urls.layer = "{% url 'base_layerdetails' project.id %}";
   scope.project = {{prj|json}};
   scope.builds = {{builds|json}};
   scope.layers = {{layers|json}};
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index f1b74cd..5a79f88 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -80,12 +80,9 @@ urlpatterns = patterns('toastergui.views',
         url(r'^project/(?P<pid>\d+)/configuration$', 'projectconf', name='projectconf'),
         url(r'^project/(?P<pid>\d+)/builds/$', 'projectbuilds', name='projectbuilds'),
 
-        url(r'^project/(?P<pid>\d+)/layer/$', lambda x,pid: HttpResponseBadRequest(), name='base_layerdetails'),
-
         # the import layer is a project-specific functionality;
         url(r'^project/(?P<pid>\d+)/importlayer$', 'importlayer', name='importlayer'),
 
-
         # the table pages that have been converted to ToasterTable widget
         url(r'^project/(?P<pid>\d+)/machines/$',
             tables.MachinesTable.as_view(template_name="generic-toastertable-page.html"),
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 5221f1f..b2b263b 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2238,7 +2238,7 @@ if toastermain.settings.MANAGED:
         if request.method == "POST":
             # add layers
             if 'layerAdd' in request.POST:
-                for lc in Layer_Version.objects.filter(pk__in=request.POST['layerAdd'].split(",")):
+                for lc in Layer_Version.objects.filter(pk__in=[i for i in request.POST['layerAdd'].split(",") if len(i) > 0]):
                     ProjectLayer.objects.get_or_create(project = prj, layercommit = lc)
 
             # remove layers
@@ -2328,15 +2328,6 @@ if toastermain.settings.MANAGED:
         try:
             prj = Project.objects.get(pk = pid)
 
-            # returns layer dependencies for a layer, excluding current project layers
-            if request.GET.get('type', None) == "layerdeps":
-                queryset = prj.compatible_layerversions().exclude(pk__in = [x.id for x in prj.projectlayer_equivalent_set()]).filter(
-                    layer__name__in = [ x.depends_on.layer.name for x in LayerVersionDependency.objects.filter(layer_version_id = request.GET.get('search', None))])
-
-                final_list = set([x.get_equivalents_wpriority(prj)[0] for x in queryset])
-
-                return HttpResponse(jsonfilter( { "error":"ok", "list" : map( _lv_to_dict(prj), sorted(final_list, key = lambda x: x.layer.name)) }), content_type = "application/json")
-
 
             # returns layer versions that would be deleted on the new release__pk
             if request.GET.get('type', None) == "versionlayers":
-- 
1.9.1


