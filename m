Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 95C6860125
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 11:00:05 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga101.fm.intel.com with ESMTP; 26 Sep 2016 04:00:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,399,1470726000"; d="scan'208";a="1056684708"
Received: from linux.intel.com ([10.54.29.200])
	by orsmga002.jf.intel.com with ESMTP; 26 Sep 2016 04:00:06 -0700
Received: from ed.fi.intel.com (ed.fi.intel.com [10.237.72.179])
	by linux.intel.com (Postfix) with ESMTP id 7380F6A4006
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 03:59:39 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Sep 2016 13:59:28 +0300
Message-Id: <455fd90c384ec8267b15b300ca325ab2799d8407.1474887106.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <cover.1474887106.git.ed.bartosh@linux.intel.com>
References: <cover.1474887106.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1474887106.git.ed.bartosh@linux.intel.com>
References: <cover.1474887106.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 01/10] toaster: Clean up and convert to rest api project edit and get calls
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
X-List-Received-Date: Mon, 26 Sep 2016 11:00:06 -0000

From: Michael Wood <michael.g.wood@intel.com>

Convert the project xhr calls into proper rest api and port the client
side calls to use the new API. Fix all the pyflakes identified issues
and clean up unused fields.

Also remove the api and client side code for changing release on the fly
as this is no longer supported.

[YOCTO #9519]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/api.py                   | 161 ++++++++++++++++++++++++
 lib/toaster/toastergui/static/js/libtoaster.js  |   3 +-
 lib/toaster/toastergui/static/js/projectpage.js | 147 +---------------------
 lib/toaster/toastergui/static/js/tests/test.js  |   7 +-
 lib/toaster/toastergui/templates/base.html      |   1 +
 lib/toaster/toastergui/urls.py                  |   4 +
 lib/toaster/toastergui/views.py                 | 131 +------------------
 7 files changed, 179 insertions(+), 275 deletions(-)

diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index be18090..8876409 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -20,11 +20,13 @@
 
 import re
 import logging
+from collections import Counter
 
 from orm.models import Project, ProjectTarget, Build, Layer_Version
 from orm.models import LayerVersionDependency, LayerSource, ProjectLayer
 from orm.models import Recipe, CustomImageRecipe, CustomImagePackage
 from orm.models import Layer, Target, Package, Package_Dependency
+from orm.models import ProjectVariable
 from bldcontrol.models import BuildRequest
 from bldcontrol import bbcontroller
 
@@ -772,3 +774,162 @@ class XhrCustomRecipePackages(View):
         except CustomImageRecipe.DoesNotExist:
             return error_response("Tried to remove package that wasn't"
                                   " present")
+
+
+class XhrProject(View):
+    """ Create, delete or edit a project
+
+    Entry point: /xhr_project/<project_id>
+    """
+    def post(self, request, *args, **kwargs):
+        """
+          Edit project control
+
+          Args:
+              layerAdd = layer_version_id layer_version_id ...
+              layerDel = layer_version_id layer_version_id ...
+              projectName = new_project_name
+              machineName = new_machine_name
+
+          Returns:
+              {"error": "ok"}
+            or
+              {"error": <error message>}
+        """
+        try:
+            prj = Project.objects.get(pk=kwargs['project_id'])
+        except Project.DoesNotExist:
+            return error_response("No such project")
+
+        # Add layers
+        if 'layerAdd' in request.POST and len(request.POST['layerAdd']) > 0:
+            for layer_version_id in request.POST['layerAdd'].split(','):
+                try:
+                    lv = Layer_Version.objects.get(pk=int(layer_version_id))
+                    ProjectLayer.objects.get_or_create(project=prj,
+                                                       layercommit=lv)
+                except Layer_Version.DoesNotExist:
+                    return error_response("Layer version %s asked to add "
+                                          "doesn't exist" % layer_version_id)
+
+        # Remove layers
+        if 'layerDel' in request.POST and len(request.POST['layerDel']) > 0:
+            layer_version_ids = request.POST['layerDel'].split(',')
+            ProjectLayer.objects.filter(
+                project=prj,
+                layercommit_id__in=layer_version_ids).delete()
+
+        # Project name change
+        if 'projectName' in request.POST:
+            prj.name = request.POST['projectName']
+            prj.save()
+
+        # Machine name change
+        if 'machineName' in request.POST:
+            machinevar = prj.projectvariable_set.get(name="MACHINE")
+            machinevar.value = request.POST['machineName']
+            machinevar.save()
+
+        return JsonResponse({"error": "ok"})
+
+    def get(self, request, *args, **kwargs):
+        """
+        Returns:
+            json object representing the current project
+        or:
+            {"error": <error message>}
+        """
+
+        try:
+            project = Project.objects.get(pk=kwargs['project_id'])
+        except Project.DoesNotExist:
+            return error_response("Project %s does not exist" %
+                                  kwargs['project_id'])
+
+        # Create the frequently built targets list
+
+        freqtargets = Counter(Target.objects.filter(
+            Q(build__project=project),
+            ~Q(build__outcome=Build.IN_PROGRESS)
+        ).order_by("target").values_list("target", flat=True))
+
+        freqtargets = freqtargets.most_common(5)
+
+        # We now have the targets in order of frequency but if there are two
+        # with the same frequency then we need to make sure those are in
+        # alphabetical order without losing the frequency ordering
+
+        tmp = []
+        switch = None
+        for i, freqtartget in enumerate(freqtargets):
+            target, count = freqtartget
+            try:
+                target_next, count_next = freqtargets[i+1]
+                if count == count_next and target > target_next:
+                    switch = target
+                    continue
+            except IndexError:
+                pass
+
+            tmp.append(target)
+
+            if switch:
+                tmp.append(switch)
+                switch = None
+
+        freqtargets = tmp
+
+        layers = []
+        for layer in project.projectlayer_set.all():
+            layers.append({
+                "id": layer.layercommit.pk,
+                "name": layer.layercommit.layer.name,
+                "vcs_url": layer.layercommit.layer.vcs_url,
+                "local_source_dir": layer.layercommit.layer.local_source_dir,
+                "vcs_reference": layer.layercommit.get_vcs_reference(),
+                "url": layer.layercommit.layer.layer_index_url,
+                "layerdetailurl": layer.layercommit.get_detailspage_url(
+                    project.pk),
+                "layersource": layer.layercommit.layer_source
+            })
+
+        data = {
+            "name": project.name,
+            "layers": layers,
+            "freqtargets": freqtargets,
+        }
+
+        if project.release is not None:
+            data['release'] = {
+                "id": project.release.pk,
+                "name": project.release.name,
+                "description": project.release.description
+            }
+
+        try:
+            data["machine"] = {"name":
+                               project.projectvariable_set.get(
+                                   name="MACHINE").value}
+        except ProjectVariable.DoesNotExist:
+            data["machine"] = None
+        try:
+            data["distro"] = project.projectvariable_set.get(
+                name="DISTRO").value
+        except ProjectVariable.DoesNotExist:
+            data["distro"] = "-- not set yet"
+
+        data['error'] = "ok"
+
+        return JsonResponse(data)
+
+    def put(self, request, *args, **kwargs):
+        # TODO create new project api
+        return HttpResponse()
+
+    def delete(self, request, *args, **kwargs):
+        try:
+            Project.objects.get(kwargs['project_id']).delete()
+        except Project.DoesNotExist:
+            return error_response("Project %s does not exist" %
+                                  kwargs['project_id'])
+        return JsonResponse({"error": "ok"})
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index f56affd..b2099a6 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -167,7 +167,6 @@ var libtoaster = (function () {
   function _getProjectInfo(url, onsuccess, onfail){
     $.ajax({
         type: "GET",
-        data : { format: "json" },
         url: url,
         headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
         success: function (_data) {
@@ -194,7 +193,7 @@ var libtoaster = (function () {
   function _editCurrentProject(data, onSuccess, onFail){
     $.ajax({
         type: "POST",
-        url: libtoaster.ctx.projectPageUrl + "?format=json",
+        url: libtoaster.ctx.xhrProjectUrl,
         data: data,
         headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
         success: function (data) {
diff --git a/lib/toaster/toastergui/static/js/projectpage.js b/lib/toaster/toastergui/static/js/projectpage.js
index b75b3e1..3bf3cba 100644
--- a/lib/toaster/toastergui/static/js/projectpage.js
+++ b/lib/toaster/toastergui/static/js/projectpage.js
@@ -27,11 +27,10 @@ function projectPageInit(ctx) {
 
   var urlParams = libtoaster.parseUrlParams();
 
-  libtoaster.getProjectInfo(libtoaster.ctx.projectPageUrl, function(prjInfo){
+  libtoaster.getProjectInfo(libtoaster.ctx.xhrProjectUrl, function(prjInfo){
     updateProjectLayers(prjInfo.layers);
     updateFreqBuildRecipes(prjInfo.freqtargets);
     updateProjectRelease(prjInfo.release);
-    updateProjectReleases(prjInfo.releases, prjInfo.release);
 
     /* If we're receiving a machine set from the url and it's different from
      * our current machine then activate set machine sequence.
@@ -287,7 +286,9 @@ function projectPageInit(ctx) {
     machineNameTitle.text(machineName);
   }
 
-  libtoaster.makeTypeahead(machineChangeInput, libtoaster.ctx.machinesTypeAheadUrl, { }, function(item){
+  libtoaster.makeTypeahead(machineChangeInput,
+                           libtoaster.ctx.machinesTypeAheadUrl,
+                           { }, function(item){
     currentMachineAddSelection = item.name;
     machineChangeBtn.removeAttr("disabled");
   });
@@ -324,146 +325,10 @@ function projectPageInit(ctx) {
     releaseTitle.text(release.description);
   }
 
-  function updateProjectReleases(releases, current){
-    for (var i in releases){
-      var releaseOption = $("<option></option>");
 
-      releaseOption.val(releases[i].id);
-      releaseOption.text(releases[i].description);
-      releaseOption.data('release', releases[i]);
-
-      if (releases[i].id == current.id)
-        releaseOption.attr("selected", "selected");
-
-      releaseForm.children("select").append(releaseOption);
-    }
-  }
-
-  releaseChangeFormToggle.click(function(){
-    releaseForm.slideDown();
-    releaseTitle.hide();
-    $(this).hide();
-  });
-
-  cancelReleaseChange.click(function(e){
+  $("#delete-project-confirmed").click(function(e){
     e.preventDefault();
-    releaseForm.slideUp(function(){
-      releaseTitle.show();
-      releaseChangeFormToggle.show();
-    });
-  });
-
-  function changeProjectRelease(release, layersToRm){
-    libtoaster.editCurrentProject({ projectVersion : release.id },
-      function(){
-        /* Success */
-        /* Update layers list with new layers */
-        layersInPrjList.addClass('muted');
-        libtoaster.getProjectInfo(libtoaster.ctx.projectPageUrl,
-            function(prjInfo){
-              layersInPrjList.children().remove();
-              updateProjectLayers(prjInfo.layers);
-              layersInPrjList.removeClass('muted');
-              releaseChangedNotification(release, prjInfo.layers, layersToRm);
-        });
-        updateProjectRelease(release);
-        cancelReleaseChange.click();
-    });
-  }
-
-  /* Create a notification to show the changes to the layer configuration
-   * caused by changing a release.
-   */
-
-  function releaseChangedNotification(release, layers, layersToRm){
-
-    var message;
-
-    if (layers.length === 0 && layersToRm.length === 0){
-      message = $('<span><span class="lead">You have changed the project release to: <strong><span id="notify-release-name"></span></strong>.');
-      message.find("#notify-release-name").text(release.description);
-      libtoaster.showChangeNotification(message);
-      return;
-    }
-
-    /* Create the whitespace separated list of layers removed */
-    var layersDelList = "";
-
-    layersToRm.map(function(layer, i){
-      layersDelList += layer.name;
-      if (layersToRm[i+1] !== undefined)
-        layersDelList += ', ';
-    });
-
-    message = $('<span><span class="lead">You have changed the project release to: <strong><span id="notify-release-name"></span></strong>. This has caused the following changes in your project layers:</span><ul id="notify-layers-changed-list"></ul></span>');
-
-    var changedList = message.find("#notify-layers-changed-list");
-
-    message.find("#notify-release-name").text(release.description);
-
-    /* Manually construct the list item for changed layers */
-    var li = '<li><strong>'+layers.length+'</strong> layers changed to the <strong>'+release.name+'</strong> release: ';
-    for (var i in layers){
-      li += '<a href='+layers[i].layerdetailurl+'>'+layers[i].name+'</a>';
-      if (i !== 0)
-        li += ', ';
-    }
-
-    changedList.append($(li));
-
-    /* Layers removed */
-    if (layersToRm && layersToRm.length > 0){
-      if (layersToRm.length == 1)
-        li = '<li><strong>1</strong> layer removed: '+layersToRm[0].name+'</li>';
-      else
-        li = '<li><strong>'+layersToRm.length+'</strong> layers deleted: '+layersDelList+'</li>';
-
-      changedList.append($(li));
-    }
-
-    libtoaster.showChangeNotification(message);
-  }
-
-  /* Show the modal dialog which gives the option to remove layers which
-   * aren't compatible with the proposed release
-   */
-  function showReleaseLayerChangeModal(release, layers){
-    var layersToRmList = releaseModal.find("#layers-to-remove-list");
-    layersToRmList.text("");
-
-    releaseModal.find(".proposed-release-change-name").text(release.description);
-    releaseModal.data("layers", layers);
-    releaseModal.data("release", release);
-
-    for (var i in layers){
-      layersToRmList.append($("<li></li>").text(layers[i].name));
-    }
-    releaseModal.modal('show');
-  }
-
-  $("#change-release-btn").click(function(e){
-    e.preventDefault();
-
-    var newRelease = releaseForm.find("option:selected").data('release');
-
-    $.getJSON(ctx.testReleaseChangeUrl,
-      { new_release_id: newRelease.id },
-      function(layers) {
-        if (layers.rows.length === 0){
-          /* No layers to change for this release */
-          changeProjectRelease(newRelease, []);
-        } else {
-          showReleaseLayerChangeModal(newRelease, layers.rows);
-        }
-    });
-  });
-
-  /* Release change modal accept */
-  $("#change-release-and-rm-layers").click(function(){
-    var layers = releaseModal.data("layers");
-    var release =  releaseModal.data("release");
-
-    changeProjectRelease(release, layers);
+  
   });
 
 }
diff --git a/lib/toaster/toastergui/static/js/tests/test.js b/lib/toaster/toastergui/static/js/tests/test.js
index f8d566b..d7953de 100644
--- a/lib/toaster/toastergui/static/js/tests/test.js
+++ b/lib/toaster/toastergui/static/js/tests/test.js
@@ -42,9 +42,8 @@ QUnit.test("Layer alert notification", function(assert) {
 
 QUnit.test("Project info", function(assert){
   var done = assert.async();
-  libtoaster.getProjectInfo(libtoaster.ctx.projectPageUrl, function(prjInfo){
+  libtoaster.getProjectInfo(libtoaster.ctx.xhrProjectUrl, function(prjInfo){
     assert.ok(prjInfo.machine.name);
-    assert.ok(prjInfo.releases.length > 0);
     assert.ok(prjInfo.layers.length > 0);
     assert.ok(prjInfo.freqtargets);
     assert.ok(prjInfo.release);
@@ -82,11 +81,11 @@ QUnit.test("Add layer", function(assert){
   }, 200);
 
   /* Compare the number of layers before and after the add in the project */
-  libtoaster.getProjectInfo(libtoaster.ctx.projectPageUrl, function(prjInfo){
+  libtoaster.getProjectInfo(libtoaster.ctx.xhrProjectUrl, function(prjInfo){
     var origNumLayers = prjInfo.layers.length;
 
     libtoaster.addRmLayer(layer, true, function(deps){
-      libtoaster.getProjectInfo(libtoaster.ctx.projectPageUrl,
+      libtoaster.getProjectInfo(libtoaster.ctx.xhrProjectUrl,
         function(prjInfo){
         assert.ok(prjInfo.layers.length > origNumLayers,
           "Layer not added to project");
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 58491eb..c1b1417 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -44,6 +44,7 @@
         {% if project.id %}
         projectId : {{project.id}},
         projectPageUrl : {% url 'project' project.id as purl %}{{purl|json}},
+        xhrProjectUrl : {% url 'xhr_project' project.id as pxurl %}{{pxurl|json}},
         projectName : {{project.name|json}},
         recipesTypeAheadUrl: {% url 'xhr_recipestypeahead' project.id as paturl%}{{paturl|json}},
         layersTypeAheadUrl: {% url 'xhr_layerstypeahead' project.id as paturl%}{{paturl|json}},
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 9509cd5..1232611 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -220,6 +220,10 @@ urlpatterns = patterns('toastergui.views',
             api.XhrBuildRequest.as_view(),
             name='xhr_buildrequest'),
 
+        url(r'xhr_project/(?P<project_id>\d+)$',
+            api.XhrProject.as_view(),
+            name='xhr_project'),
+
         url(r'^mostrecentbuilds$', api.MostRecentBuildsView.as_view(),
             name='most_recent_builds'),
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 365a1e8..2efb0fd 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1361,136 +1361,11 @@ if True:
 
         raise Exception("Invalid HTTP method for this page")
 
-
-
     # Shows the edit project page
-    @_template_renderer('project.html')
     def project(request, pid):
-        prj = Project.objects.get(id = pid)
-
-        try:
-            puser = User.objects.get(id = prj.user_id)
-        except User.DoesNotExist:
-            puser = None
-
-        # execute POST requests
-        if request.method == "POST":
-            # add layers
-            if 'layerAdd' in request.POST and len(request.POST['layerAdd']) > 0:
-                for lc in Layer_Version.objects.filter(pk__in=[i for i in request.POST['layerAdd'].split(",") if len(i) > 0]):
-                    ProjectLayer.objects.get_or_create(project = prj, layercommit = lc)
-
-            # remove layers
-            if 'layerDel' in request.POST and len(request.POST['layerDel']) > 0:
-                for t in request.POST['layerDel'].strip().split(" "):
-                    pt = ProjectLayer.objects.filter(project = prj, layercommit_id = int(t)).delete()
-
-            if 'projectName' in request.POST:
-                prj.name = request.POST['projectName']
-                prj.save();
-
-            if 'projectVersion' in request.POST:
-                # If the release is the current project then return now
-                if prj.release.pk == int(request.POST.get('projectVersion',-1)):
-                    return {}
-
-                prj.release = Release.objects.get(pk = request.POST['projectVersion'])
-                # we need to change the bitbake version
-                prj.bitbake_version = prj.release.bitbake_version
-                prj.save()
-                # we need to change the layers
-                for project in prj.projectlayer_set.all():
-                    # find and add a similarly-named layer on the new branch
-                    try:
-                        layer_versions = prj.get_all_compatible_layer_versions()
-                        layer_versions = layer_versions.filter(layer__name = project.layercommit.layer.name)
-                        ProjectLayer.objects.get_or_create(project = prj, layercommit = layer_versions.first())
-                    except IndexError:
-                        pass
-                    finally:
-                        # get rid of the old entry
-                        project.delete()
-
-            if 'machineName' in request.POST:
-                machinevar = prj.projectvariable_set.get(name="MACHINE")
-                machinevar.value=request.POST['machineName']
-                machinevar.save()
-
-
-        # we use implicit knowledge of the current user's project to filter layer information, e.g.
-        pid = prj.id
-
-        from collections import Counter
-
-        freqtargets = Counter(Target.objects.filter(
-            Q(build__project=prj),
-            ~Q(build__outcome=Build.IN_PROGRESS)
-        ).order_by("target").values_list("target", flat=True))
-
-        freqtargets = freqtargets.most_common(5)
-
-        # We now have the targets in order of frequency but if there are two
-        # with the same frequency then we need to make sure those are in
-        # alphabetical order without losing the frequency ordering
-
-        tmp = []
-        switch = None
-        for i, freqtartget in enumerate(freqtargets):
-            target, count = freqtartget
-            try:
-                target_next, count_next = freqtargets[i+1]
-                if count == count_next and target > target_next:
-                    switch = target
-                    continue
-            except IndexError:
-                pass
-
-            tmp.append(target)
-
-            if switch:
-                tmp.append(switch)
-                switch = None
-
-        freqtargets = tmp
-
-        layers = [{"id": x.layercommit.pk, "orderid": x.pk, "name" : x.layercommit.layer.name,
-                   "vcs_url": x.layercommit.layer.vcs_url, "local_source_dir": x.layercommit.layer.local_source_dir, "vcs_reference" : x.layercommit.get_vcs_reference(),
-                   "url": x.layercommit.layer.layer_index_url, "layerdetailurl": x.layercommit.get_detailspage_url(prj.pk),
-                   "branch" : {"name" : x.layercommit.get_vcs_reference(),
-                               "layersource" : x.layercommit.layer_source }
-                   } for x in prj.projectlayer_set.all().order_by("id")]
-
-        context = {
-            "project" : prj,
-            "lvs_nos" : Layer_Version.objects.all().count(),
-            "completedbuilds": Build.objects.exclude(outcome = Build.IN_PROGRESS).filter(project_id = pid),
-            "prj" : {"name": prj.name, },
-            "buildrequests" : prj.build_set.filter(outcome=Build.IN_PROGRESS),
-            "builds" : Build.get_recent(prj),
-            "layers" : layers,
-            "targets" : [{"target" : x.target, "task" : x.task, "pk": x.pk} for x in prj.projecttarget_set.all()],
-            "variables": [(x.name, x.value) for x in prj.projectvariable_set.all()],
-            "freqtargets": freqtargets,
-            "releases": [{"id": x.pk, "name": x.name, "description":x.description} for x in Release.objects.all()],
-            "project_html": 1,
-            "recipesTypeAheadUrl": reverse('xhr_recipestypeahead', args=(prj.pk,)),
-            "projectBuildsUrl": reverse('projectbuilds', args=(prj.pk,)),
-        }
-
-        if prj.release is not None:
-            context['release'] = { "id": prj.release.pk, "name": prj.release.name, "description": prj.release.description}
-
-
-        try:
-            context["machine"] = {"name": prj.projectvariable_set.get(name="MACHINE").value}
-        except ProjectVariable.DoesNotExist:
-            context["machine"] = None
-        try:
-            context["distro"] = prj.projectvariable_set.get(name="DISTRO").value
-        except ProjectVariable.DoesNotExist:
-            context["distro"] = "-- not set yet"
-
-        return context
+        project = Project.objects.get(pk=pid)
+        context = {"project": project}
+        return render(request, "project.html", context)
 
     def jsunittests(request):
         """ Provides a page for the js unit tests """
-- 
2.6.6


