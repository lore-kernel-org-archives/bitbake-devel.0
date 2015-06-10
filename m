Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
	[209.85.212.180])
	by mail.openembedded.org (Postfix) with ESMTP id 0558C758C9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 14:39:22 +0000 (UTC)
Received: by wifx6 with SMTP id x6so49698590wif.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 07:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=IKo5C9CWVa6j3O9cJ2qpBuRRjh1zBB7JpkAaqwZp1uU=;
	b=kI+PcCOJPDfTSZDh1x5Iy3GFcHSU/0lwjd0qqkkrRzaxI/9zB3sYpKwZ7fBY7UrCsr
	INuAkoPbhff9SwzcG2egmqqA/rNC+BXBpafAZsJqydXyq5h5hShfj8QhgTvd+8LqjCUr
	xyZdpVkDxziWNLIg8/tf05mGChKrXbsm6r+p4vAYSefDqKOxS2HNS+0RTJeHdGI8eifb
	jNdpAWgUySa4vHpek4abinaL7OEGxm0gOu6rTMaVyudDP7bR5TrhTWNx4w5R3XkQsvhL
	udnxZpKHt0AUc0Qjf13voZwywMmHNuoM2aDKFJe5WM5xhrhdyUIJHZiw4vv4KBDtMolJ
	wP0g==
X-Gm-Message-State: ALoCoQnf5lnnsf6TtlEr5ficQWTHy5kTGYZwVgE3Nh87cpW7ursS7OiND4bXTkiZnFgbRjDHIGjP
X-Received: by 10.194.97.196 with SMTP id ec4mr6966176wjb.3.1433947163537;
	Wed, 10 Jun 2015 07:39:23 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id n6sm8257374wic.16.2015.06.10.07.39.22
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Jun 2015 07:39:22 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 0FD9A56110C; Wed, 10 Jun 2015 15:39:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jun 2015 15:38:53 +0100
Message-Id: <6ad3078bd2be1a8cda99040acaa9bb81d77f0013.1433946742.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
References: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1433946742.git.alexandru.damian@intel.com>
References: <cover.1433946742.git.alexandru.damian@intel.com>
Subject: [PATCH 05/19] toastergui: remove xhr_projectedit and xhr_projectinfo URLs
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
X-List-Received-Date: Wed, 10 Jun 2015 14:39:23 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch removes the xhr_projectedit and xhr_projectinfo URLs
in favour of REST calls to the Project page.

The project page takes now the POST requests to modify project
settings. All usages of removed URLs are now changed to point to the
project page, using the json format.

The interface call specs have not modified.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/contrib/tts/urllist.py             |   3 -
 lib/toaster/toastergui/static/js/base.js       |   3 +-
 lib/toaster/toastergui/static/js/libtoaster.js |   8 +-
 lib/toaster/toastergui/static/js/projectapp.js |  73 +++++++++++++---
 lib/toaster/toastergui/templates/base.html     |   3 -
 lib/toaster/toastergui/templates/project.html  |   2 +-
 lib/toaster/toastergui/tests.py                |   1 -
 lib/toaster/toastergui/urls.py                 |   2 -
 lib/toaster/toastergui/views.py                | 110 +++++++++----------------
 9 files changed, 108 insertions(+), 97 deletions(-)

diff --git a/lib/toaster/contrib/tts/urllist.py b/lib/toaster/contrib/tts/urllist.py
index a7d6d6e..433ac9f 100644
--- a/lib/toaster/contrib/tts/urllist.py
+++ b/lib/toaster/contrib/tts/urllist.py
@@ -40,10 +40,7 @@ URLS = [
 'toastergui/project/1/importlayer',
 'toastergui/project/1/targets/',
 'toastergui/project/1/machines/',
-'toastergui/xhr_build/',
 'toastergui/xhr_projectbuild/1/',
-'toastergui/xhr_projectinfo/',
-'toastergui/xhr_projectedit/1',
 'toastergui/xhr_configvaredit/1',
 'toastergui/xhr_datatypeahead/1',
 'toastergui/xhr_importlayer/',
diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index 9424b6c..9c8d01e 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -29,7 +29,7 @@ function basePageInit (ctx) {
     if (libtoaster.ctx.projectId == undefined)
       return;
 
-    libtoaster.getProjectInfo(ctx.projectInfoUrl, libtoaster.ctx.projectId,
+    libtoaster.getProjectInfo(libtoaster.ctx.projectPageUrl,
       function(data){
         if (data.machine.name == undefined || data.layers.length == 0) {
           /* we can't build anything with out a machine and some layers */
@@ -102,7 +102,6 @@ function basePageInit (ctx) {
       /* TBD: do we override even if we already have a context project ?? */
       /* TODO: replace global library context with references to the "selected" project */
       libtoaster.ctx.projectPageUrl = selectedProject.projectPageUrl;
-      libtoaster.ctx.xhrProjectEditUrl = selectedProject.xhrProjectEditUrl;
       libtoaster.ctx.projectName = selectedProject.name;
       libtoaster.ctx.projectId = selectedProject.id;
 
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 72fb0a93..8791029 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -120,11 +120,11 @@ var libtoaster = (function (){
   }
 
   /* Get a project's configuration info */
-  function _getProjectInfo(url, projectId, onsuccess, onfail){
+  function _getProjectInfo(url, onsuccess, onfail){
     $.ajax({
-        type: "POST",
+        type: "GET",
+        data : { format: "json" },
         url: url,
-        data: { project_id : projectId },
         headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
         success: function (_data) {
           if (_data.error !== "ok") {
@@ -150,7 +150,7 @@ var libtoaster = (function (){
   function _editCurrentProject(data, onSuccess, onFail){
     $.ajax({
         type: "POST",
-        url: libtoaster.ctx.xhrProjectEditUrl,
+        url: libtoaster.ctx.projectPageUrl + "?format=json",
         data: data,
         headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
         success: function (data) {
diff --git a/lib/toaster/toastergui/static/js/projectapp.js b/lib/toaster/toastergui/static/js/projectapp.js
index a3309c7..36c942f 100644
--- a/lib/toaster/toastergui/static/js/projectapp.js
+++ b/lib/toaster/toastergui/static/js/projectapp.js
@@ -156,6 +156,62 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
      * Retrieves text suggestions for text-edit drop down autocomplete boxes
      */
 
+    $scope.getLayersAutocompleteSuggestions = function(currentValue) {
+        var deffered = $q.defer();
+
+        $http({method:"GET", url: $scope.urls.layers, params : { search: currentValue, format: "json" }})
+            .success(function (_data) {
+                if (_data.error != "ok") {
+                    console.warn("error on data", _data.error);
+                    deffered.reject(_data.error);
+                }
+                deffered.resolve(_data.rows);
+            });
+
+        return deffered.promise;
+    }
+
+    $scope.filterProjectLayerIds = function () {
+        return $scope.layers.map(function (e) { return e.id; });
+    }
+
+    $scope.getMachinesAutocompleteSuggestions = function(currentValue) {
+        var deffered = $q.defer();
+
+        $http({method:"GET", url: $scope.urls.machines, params : { search: currentValue, format: "json" }})
+            .success(function (_data) {
+                if (_data.error != "ok") {
+                    console.warn("error on data", _data.error);
+                    deffered.reject(_data.error);
+                }
+                deffered.resolve(_data.rows);
+            });
+
+        return deffered.promise;
+    }
+
+    $scope.getRecipesAutocompleteSuggestions = function(currentValue) {
+        var deffered = $q.defer();
+
+        $http({method:"GET", url: $scope.urls.targets, params : { search: currentValue, format: "json" }})
+            .success(function (_data) {
+                if (_data.error != "ok") {
+                    console.warn("error on data", _data.error);
+                    deffered.reject(_data.error);
+                }
+                deffered.resolve(_data.rows);
+            });
+        return deffered.promise;
+    }
+
+    $scope.values = function() {
+        var deffered = $q.defer();
+
+        deffered.resolve(["mama", "tata"]);
+
+        return deffered.promise;
+    };
+
     $scope.getAutocompleteSuggestions = function(type, currentValue) {
         var deffered = $q.defer();
 
@@ -421,7 +477,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
 
 
     $scope.onLayerSelect = function (item) {
-        $scope.layerAddId = item.id;
+        $scope.layerToAdd = item;
     };
 
     $scope.machineSelect = function (machineName) {
@@ -443,14 +499,9 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
     };
 
 
-    $scope.layerAddById = function (id) {
-        $scope.layerAddId = id;
-        $scope.layerAdd();
-    };
-
     $scope.layerAdd = function() {
 
-        $http({method:"GET", url: $scope.urls.xhr_datatypeahead, params : { type: "layerdeps", value: $scope.layerAddId }})
+        $http({method:"GET", url: $scope.layerToAdd.layerdict.layerdetailurl, params : {}})
         .success(function (_data) {
              if (_data.error != "ok") {
                  console.warn(_data.error);
@@ -493,7 +544,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                      });
 
                      modalInstance.result.then(function (selectedArray) {
-                         selectedArray.push($scope.layerAddId);
+                         selectedArray.push($scope.layerToAdd.layerversion.id);
                          console.warn("TRC6: selected", selectedArray);
 
                          $scope._makeXHRCall({
@@ -512,7 +563,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                          $scope._makeXHRCall({
                              method: "POST", url: $scope.urls.xhr_edit,
                              data: {
-                                 layerAdd:  $scope.layerAddId,
+                                 layerAdd:  $scope.layerToAdd.layerversion.id,
                              }
                          }).then(function () {
                              $scope.layerAddName = undefined;
@@ -768,10 +819,8 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
 
 
         _cmdExecuteWithParam("/layeradd=", function (layer) {
-            angular.forEach(layer.split(","), function (l) {
-                $scope.layerAddId = l;
+                $scope.layerToAdd = layer;
                 $scope.layerAdd();
-            });
         });
     };
 
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index e10dc11..5d51bc3 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -34,13 +34,11 @@
     projectsUrl : "{% url 'all-projects' %}",
     {% if project.id %}
       xhrProjectDataTypeaheadUrl : "{% url 'xhr_datatypeahead' project.id %}",
-      xhrProjectEditUrl : "{% url 'xhr_projectedit' project.id %}",
       projectPageUrl : "{% url 'project' project.id %}",
       projectName : "{{project.name}}",
       projectId : {{project.id}},
     {% else %}
       xhrProjectDataTypeaheadUrl : undefined,
-      xhrProjectEditUrl : undefined,
       projectPageUrl : undefined,
       projectName : undefined,
       projectId : undefined,
@@ -53,7 +51,6 @@
   $(document).ready(function () {
     /* Vars needed for base.js */
     var ctx = {};
-    ctx.projectInfoUrl = "{% url 'xhr_projectinfo' %}";
     ctx.numProjects = {{projects|length}};
     ctx.currentUrl = "{{request.path|escapejs}}";
 
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 933da4f..e598631 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -430,7 +430,7 @@ angular.element(document).ready(function() {
   scope = angular.element("#main").scope();
   scope.urls = {};
   scope.urls.xhr_build = "{% url 'xhr_projectbuild' project.id %}";
-  scope.urls.xhr_edit = "{% url 'xhr_projectedit' project.id %}";
+  scope.urls.xhr_edit = "{% url 'project' project.id %}?format=json";
   scope.urls.xhr_datatypeahead = "{% url 'xhr_datatypeahead' project.id %}";
   scope.urls.layers = "{% url 'all-layers' project.id %}";
   scope.urls.targets = "{% url 'all-targets' project.id %}";
diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 0f10020..c92c5fe 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -40,7 +40,6 @@ class AllProjectsViewTestCase(ProvisionedProjectTestCase):
         self.assertTrue("id" in data["list"][0])
         self.assertTrue("xhrProjectDataTypeaheadUrl" in data["list"][0])
         self.assertTrue("projectPageUrl" in data["list"][0])
-        self.assertTrue("xhrProjectEditUrl" in data["list"][0])
         self.assertTrue("projectBuildUrl" in data["list"][0])
 
 class ProvisionedLayersProjectTestCase(ProvisionedProjectTestCase):
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index e10e0bb..d527be0 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -122,8 +122,6 @@ urlpatterns = patterns('toastergui.views',
             name=tables.LayerMachinesTable.__name__.lower()),
 
         url(r'^xhr_projectbuild/(?P<pid>\d+)$', 'xhr_projectbuild', name='xhr_projectbuild'),
-        url(r'^xhr_projectinfo/$', 'xhr_projectinfo', name='xhr_projectinfo'),
-        url(r'^xhr_projectedit/(?P<pid>\d+)$', 'xhr_projectedit', name='xhr_projectedit'),
         url(r'^xhr_configvaredit/(?P<pid>\d+)$', 'xhr_configvaredit', name='xhr_configvaredit'),
 
         url(r'^xhr_datatypeahead/(?P<pid>\d+)$', 'xhr_datatypeahead', name='xhr_datatypeahead'),
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 678e356..91c4fa2 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2210,6 +2210,45 @@ if toastermain.settings.MANAGED:
         except User.DoesNotExist:
             puser = None
 
+        # execute POST requests
+        if request.method == "POST":
+            # add layers
+            if 'layerAdd' in request.POST:
+                for lc in Layer_Version.objects.filter(pk__in=request.POST['layerAdd'].split(",")):
+                    ProjectLayer.objects.get_or_create(project = prj, layercommit = lc)
+
+            # remove layers
+            if 'layerDel' in request.POST:
+                for t in request.POST['layerDel'].strip().split(" "):
+                    pt = ProjectLayer.objects.filter(project = prj, layercommit_id = int(t)).delete()
+
+            if 'projectName' in request.POST:
+                prj.name = request.POST['projectName']
+                prj.save();
+
+            if 'projectVersion' in request.POST:
+                prj.release = Release.objects.get(pk = request.POST['projectVersion'])
+                # we need to change the bitbake version
+                prj.bitbake_version = prj.release.bitbake_version
+                prj.save()
+                # we need to change the layers
+                for i in prj.projectlayer_set.all():
+                    # find and add a similarly-named layer on the new branch
+                    try:
+                        lv = prj.compatible_layerversions(layer_name = i.layercommit.layer.name)[0]
+                        ProjectLayer.objects.get_or_create(project = prj, layercommit = lv)
+                    except IndexError:
+                        pass
+                    finally:
+                        # get rid of the old entry
+                        i.delete()
+
+            if 'machineName' in request.POST:
+                machinevar = prj.projectvariable_set.get(name="MACHINE")
+                machinevar.value=request.POST['machineName']
+                machinevar.save()
+
+
         # we use implicit knowledge of the current user's project to filter layer information, e.g.
         pid = prj.id
 
@@ -2241,10 +2280,12 @@ if toastermain.settings.MANAGED:
                         "branch" : { "name" : x.layercommit.get_vcs_reference(), "layersource" : x.layercommit.up_branch.layer_source.name if x.layercommit.up_branch != None else None}},
                     prj.projectlayer_set.all().order_by("id")),
             "targets" : map(lambda x: {"target" : x.target, "task" : x.task, "pk": x.pk}, prj.projecttarget_set.all()),
+            "variables": map(lambda x: (x.name, x.value), prj.projectvariable_set.all()),
             "freqtargets": freqtargets[:5],
             "releases": map(lambda x: {"id": x.pk, "name": x.name, "description":x.description}, Release.objects.all()),
             "project_html": 1,
         }
+
         try:
             context["machine"] = {"name": prj.projectvariable_set.get(name="MACHINE").value}
         except ProjectVariable.DoesNotExist:
@@ -2300,66 +2341,6 @@ if toastermain.settings.MANAGED:
         except Exception as e:
             return HttpResponse(jsonfilter({"error":str(e) + "\n" + traceback.format_exc()}), content_type = "application/json")
 
-    # This is a wraper for xhr_projectedit which allows for a project id
-    # which only becomes known client side
-    def xhr_projectinfo(request):
-        if request.POST.has_key("project_id") == False:
-            raise BadParameterException("invalid project id")
-
-        return xhr_projectedit(request, request.POST['project_id'])
-
-    def xhr_projectedit(request, pid):
-        try:
-            prj = Project.objects.get(id = pid)
-            # add layers
-            if 'layerAdd' in request.POST:
-                for lc in Layer_Version.objects.filter(pk__in=request.POST['layerAdd'].split(",")):
-                    ProjectLayer.objects.get_or_create(project = prj, layercommit = lc)
-
-            # remove layers
-            if 'layerDel' in request.POST:
-                for t in request.POST['layerDel'].strip().split(" "):
-                    pt = ProjectLayer.objects.filter(project = prj, layercommit_id = int(t)).delete()
-
-            if 'projectName' in request.POST:
-                prj.name = request.POST['projectName']
-                prj.save();
-
-            if 'projectVersion' in request.POST:
-                prj.release = Release.objects.get(pk = request.POST['projectVersion'])
-                # we need to change the bitbake version
-                prj.bitbake_version = prj.release.bitbake_version
-                prj.save()
-                # we need to change the layers
-                for i in prj.projectlayer_set.all():
-                    # find and add a similarly-named layer on the new branch
-                    try:
-                        lv = prj.compatible_layerversions(layer_name = i.layercommit.layer.name)[0]
-                        ProjectLayer.objects.get_or_create(project = prj, layercommit = lv)
-                    except IndexError:
-                        pass
-                    finally:
-                        # get rid of the old entry
-                        i.delete()
-
-            if 'machineName' in request.POST:
-                machinevar = prj.projectvariable_set.get(name="MACHINE")
-                machinevar.value=request.POST['machineName']
-                machinevar.save()
-
-            # return all project settings
-            return HttpResponse(jsonfilter( {
-                "error": "ok",
-                "layers" :  map(lambda x: {"id": x.layercommit.pk, "orderid" : x.pk, "name" : x.layercommit.layer.name, "giturl" : x.layercommit.layer.vcs_url, "url": x.layercommit.layer.layer_index_url, "layerdetailurl": reverse("layerdetails", args=(prj.id, x.layercommit.pk,)), "branch" : { "name" : x.layercommit.get_vcs_reference(), "layersource" : x.layercommit.up_branch.layer_source.name}}, prj.projectlayer_set.all().select_related("layer").order_by("id")),
-                "builds" : _project_recent_build_list(prj),
-                "variables": map(lambda x: (x.name, x.value), prj.projectvariable_set.all()),
-                "machine": {"name": prj.projectvariable_set.get(name="MACHINE").value},
-                "prj": {"name": prj.name, "release": { "id": prj.release.pk, "name": prj.release.name, "desc": prj.release.description}},
-                }), content_type = "application/json")
-
-        except Exception as e:
-            return HttpResponse(jsonfilter({"error":str(e) + "\n" + traceback.format_exc()}), content_type = "application/json")
-
 
     from django.views.decorators.csrf import csrf_exempt
     @csrf_exempt
@@ -2929,7 +2910,6 @@ if toastermain.settings.MANAGED:
             p.id = p.pk
             p.xhrProjectDataTypeaheadUrl = reverse('xhr_datatypeahead', args=(p.id,))
             p.projectPageUrl = reverse('project', args=(p.id,))
-            p.xhrProjectEditUrl = reverse('xhr_projectedit', args=(p.id,))
             p.projectBuildUrl = reverse('xhr_projectbuild', args=(p.id,))
 
         # build view-specific information; this is rendered specifically in the builds page, at the top of the page (i.e. Recent builds)
@@ -3234,14 +3214,6 @@ else:
         return {}
 
     @_template_renderer('landing_not_managed.html')
-    def xhr_projectinfo(request):
-        return {}
-
-    @_template_renderer('landing_not_managed.html')
-    def xhr_projectedit(request, pid):
-        return {}
-
-    @_template_renderer('landing_not_managed.html')
     def xhr_datatypeahead(request):
         return {}
 
-- 
1.9.1


