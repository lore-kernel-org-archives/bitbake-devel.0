Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id 0D6CB71D7F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Dec 2016 16:53:05 +0000 (UTC)
Received: by mail-wm0-f53.google.com with SMTP id f82so32577044wmf.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 09 Dec 2016 08:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=O9eF0ncMqbSmG+orMfF3bUQRqh2I+kRT6a1i9QlzMJQ=;
	b=ZJk+UqcfunNumQHxKVVrsDuDxFns4id3IJxsX2O8QqWZvM6ry//wNB6+sO6ItuarO5
	oIOYyHUm7aOpToSEJBo5dsRNWD6wOeq4D1207qEUZDZSr93EUzEQFPPGC9CzGhdL04my
	R6/xleKdH3bNOPNWmFuTjctduaB+TJsIAfBxgeMQ0bg5YjiWzyRLVvaeJbJCysRvNEDc
	dsv+oKDmVbuho2LIiBOPsBoEzLSbwDISmDXx3QCu96VQ/ZdZ4cXkZ1QV0dA715js9lAo
	ESENrX3L+mlf5mWyttR8mTjQruzG9C7nGxD+oPpgb3eOCL3u+riaqBiK25zqp5HG+QmG
	Whrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=O9eF0ncMqbSmG+orMfF3bUQRqh2I+kRT6a1i9QlzMJQ=;
	b=hLEp+h09D50Fr9CSSqisiU2Fav5NcISKpgWWwkS+zP8iZkK3MuHlItCPw/MU8IXo7W
	VIhL0ncngd9gDPCUctn9lQZojaLxbDeZ8A68LgOf8opAVWdBlKtVC94XI3vg85RF62pr
	hxDz9TRABr3Fu7kCP2XimB0ViNqrHqtlQKTBo8pCrWMz0z44xGh7xU0LnqqnDm7KF2H8
	DtKw10HlQ3Xg/URE56z7B1btPGLIekaVqlr7Ngw4dunk1AUzctsGOZgvcywExNMmjKI5
	k6gEw3rwM6jFhbq6xt7bC90PwSauXSJDZlNvb8mZmLBD1lvaeI+v46qFby85IhlWn2wt
	OqzQ==
X-Gm-Message-State: AKaTC00L8Y+oKchnBP8SqJVtO2s0YLoNF+BtVDpkU203xUjWzjcG7ZBS17YAnkGgPnMuR7j4
X-Received: by 10.28.131.72 with SMTP id f69mr7457569wmd.135.1481302387160;
	Fri, 09 Dec 2016 08:53:07 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	ke6sm43170601wjb.21.2016.12.09.08.53.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 09 Dec 2016 08:53:06 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Dec 2016 16:52:45 +0000
Message-Id: <1481302375-7985-5-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
References: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 04/14] toaster: api Add layer Add api
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
X-List-Received-Date: Fri, 09 Dec 2016 16:53:06 -0000

Add layer adding REST api and remove old views method.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/api.py                     | 101 ++++++++++++++++++-
 lib/toaster/toastergui/templates/importlayer.html |   2 +-
 lib/toaster/toastergui/urls.py                    |   6 +-
 lib/toaster/toastergui/views.py                   | 115 ----------------------
 4 files changed, 103 insertions(+), 121 deletions(-)

diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index 4851047..5be633e 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -20,6 +20,7 @@
 
 import re
 import logging
+import json
 from collections import Counter
 
 from orm.models import Project, ProjectTarget, Build, Layer_Version
@@ -136,14 +137,17 @@ class XhrBuildRequest(View):
 
 
 class XhrLayer(View):
-    """ Get and Update Layer information """
+    """ Delete, Get, Add and Update Layer information
+
+        Methods: POST DELETE PUT
+    """
 
     def post(self, request, *args, **kwargs):
         """
           Update a layer
 
-          Entry point: /xhr_layer/<layerversion_id>
           Method: POST
+          Entry point: /xhr_layer/<layerversion_id>
 
           Args:
               vcs_url, dirpath, commit, up_branch, summary, description,
@@ -201,9 +205,100 @@ class XhrLayer(View):
             return error_response("Could not update layer version entry: %s"
                                   % e)
 
-        return JsonResponse({"error": "ok"})
+        return error_response("ok")
+
+    def put(self, request, *args, **kwargs):
+        """ Add a new layer
+
+        Method: PUT
+        Entry point: /xhr_layer/
+        Args:
+            project_id, name,
+            [vcs_url, dir_path, git_ref], [local_source_dir], [layer_deps
+            (csv)]
+
+        """
+        try:
+            project = Project.objects.get(pk=kwargs['pid'])
+
+            layer_data = json.loads(request.body.decode('utf-8'))
+
+            # We require a unique layer name as otherwise the lists of layers
+            # becomes very confusing
+            existing_layers = \
+                project.get_all_compatible_layer_versions().values_list(
+                    "layer__name",
+                    flat=True)
+
+            add_to_project = False
+            layer_deps_added = []
+            if 'add_to_project' in layer_data:
+                add_to_project = True
+
+            if layer_data['name'] in existing_layers:
+                return JsonResponse({"error": "layer-name-exists"})
+
+            layer = Layer.objects.create(name=layer_data['name'])
+
+            layer_version = Layer_Version.objects.create(
+                layer=layer,
+                project=project,
+                layer_source=LayerSource.TYPE_IMPORTED)
+
+            # Local layer
+            if 'local_source_dir' in layer_data:
+                layer.local_source_dir = layer_data['local_source_dir']
+            # git layer
+            elif 'vcs_url' in layer_data:
+                layer.vcs_url = layer_data['vcs_url']
+                layer_version.dirpath = layer_data['dir_path']
+                layer_version.commit = layer_data['get_ref']
+                layer_version.branch = layer_data['get_ref']
+
+            layer.save()
+            layer_version.save()
+
+            if add_to_project:
+                ProjectLayer.objects.get_or_create(
+                    layercommit=layer_version, project=project)
+
+            # Add the layer dependencies
+            if 'layer_deps' in layer_data:
+                for layer_dep_id in layer_data['layer_deps'].split(","):
+                    layer_dep = Layer_Version.objects.get(pk=layer_dep_id)
+                    LayerVersionDependency.objects.get_or_create(
+                        layer_version=layer_version, depends_on=layer_dep)
+
+                    # Add layer deps to the project if specified
+                    if add_to_project:
+                        created, pl = ProjectLayer.objects.get_or_create(
+                            layercommit=layer_dep, project=project)
+                        layer_deps_added.append(
+                            {'name': layer_dep.layer.name,
+                             'layerdetailurl':
+                             layer_dep.get_detailspage_url(project.pk)})
+
+        except Layer_Version.DoesNotExist:
+            return error_response("layer-dep-not-found")
+        except Project.DoesNotExist:
+            return error_response("project-not-found")
+        except KeyError:
+            return error_response("incorrect-parameters")
+
+        return JsonResponse({'error': "ok",
+                             'imported_layer': {
+                                 'name': layer.name,
+                                 'layerdetailurl':
+                                 layer_version.get_detailspage_url()},
+                             'deps_added': layer_deps_added})
 
     def delete(self, request, *args, **kwargs):
+        """ Delete an imported layer
+
+        Method: DELETE
+        Entry point: /xhr_layer/<layerversion_id>
+
+        """
         try:
             # We currently only allow Imported layers to be deleted
             layer_version = Layer_Version.objects.get(
diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
index 1f42696..bd507b5 100644
--- a/lib/toaster/toastergui/templates/importlayer.html
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -13,7 +13,7 @@
   <script>
   $(document).ready(function (){
     var ctx = {
-      xhrImportLayerUrl : "{% url 'xhr_importlayer' %}",
+      xhrLayerUrl : "{% url 'xhr_layer' project.id %}",
     };
 
     try {
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index ece9ac1..29f0d96 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -190,12 +190,14 @@ urlpatterns = patterns('toastergui.views',
         url(r'^xhr_configvaredit/(?P<pid>\d+)$', 'xhr_configvaredit',
             name='xhr_configvaredit'),
 
-        url(r'^xhr_importlayer/$', 'xhr_importlayer', name='xhr_importlayer'),
-
         url(r'^xhr_layer/(?P<pid>\d+)/(?P<layerversion_id>\d+)$',
             api.XhrLayer.as_view(),
             name='xhr_layer'),
 
+        url(r'^xhr_layer/(?P<pid>\d+)$',
+            api.XhrLayer.as_view(),
+            name='xhr_layer'),
+
         # JS Unit tests
         url(r'^js-unit-tests/$', 'jsunittests', name='js-unit-tests'),
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 2efb0fd..94b630a 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1509,121 +1509,6 @@ if True:
             return HttpResponse(json.dumps({"error":str(e) + "\n" + traceback.format_exc()}), content_type = "application/json")
 
 
-    def xhr_importlayer(request):
-        if ('vcs_url' not in request.POST or
-            'name' not in request.POST or
-            'git_ref' not in request.POST or
-            'project_id' not in request.POST):
-          return HttpResponse(jsonfilter({"error": "Missing parameters; requires vcs_url, name, git_ref and project_id"}), content_type = "application/json")
-
-        layers_added = [];
-
-        # Rudimentary check for any possible html tags
-        for val in request.POST.values():
-            if "<" in val:
-                return HttpResponse(jsonfilter(
-                    {"error": "Invalid character <"}),
-                    content_type="application/json")
-
-        prj = Project.objects.get(pk=request.POST['project_id'])
-
-        # Strip trailing/leading whitespace from all values
-        # put into a new dict because POST one is immutable.
-        post_data = dict()
-        for key,val in request.POST.items():
-          post_data[key] = val.strip()
-
-
-        try:
-            layer, layer_created = Layer.objects.get_or_create(name=post_data['name'])
-        except MultipleObjectsReturned:
-            return HttpResponse(jsonfilter({"error": "hint-layer-exists"}), content_type = "application/json")
-
-        if layer:
-            if layer_created:
-                layer.vcs_url = post_data.get('vcs_url')
-                layer.local_source_dir = post_data.get('local_source_dir')
-                layer.up_date = timezone.now()
-                layer.save()
-            else:
-                # We have an existing layer by this name, let's see if the git
-                # url is the same, if it is then we can just create a new layer
-                # version for this layer. Otherwise we need to bail out.
-                if layer.vcs_url != post_data['vcs_url']:
-                    return HttpResponse(jsonfilter({"error": "hint-layer-exists-with-different-url" , "current_url" : layer.vcs_url, "current_id": layer.id }), content_type = "application/json")
-
-            layer_version, version_created = \
-                Layer_Version.objects.get_or_create(
-                        layer_source=LayerSource.TYPE_IMPORTED,
-                        layer=layer, project=prj,
-                        release=prj.release,
-                        branch=post_data['git_ref'],
-                        commit=post_data['git_ref'],
-                        dirpath=post_data['dir_path'])
-
-            if layer_version:
-                if not version_created:
-                    return HttpResponse(jsonfilter({"error":
-                                                    "hint-layer-version-exists",
-                                                    "existing_layer_version":
-                                                    layer_version.id }),
-                                        content_type = "application/json")
-
-                layer_version.layer_source = LayerSource.TYPE_IMPORTED
-
-                layer_version.up_date = timezone.now()
-                layer_version.save()
-
-                # Add the dependencies specified for this new layer
-                if ('layer_deps' in post_data and
-                    version_created and
-                    len(post_data["layer_deps"]) > 0):
-                    for layer_dep_id in post_data["layer_deps"].split(","):
-
-                        layer_dep_obj = Layer_Version.objects.get(pk=layer_dep_id)
-                        LayerVersionDependency.objects.get_or_create(layer_version=layer_version, depends_on=layer_dep_obj)
-                        # Now add them to the project, we could get an execption
-                        # if the project now contains the exact
-                        # dependency already (like modified on another page)
-                        try:
-                            prj_layer, prj_layer_created = ProjectLayer.objects.get_or_create(layercommit=layer_dep_obj, project=prj)
-                        except IntegrityError as e:
-                            logger.warning("Integrity error while saving Project Layers: %s (original %s)" % (e, e.__cause__))
-                            continue
-
-                        if prj_layer_created:
-                            layerdepdetailurl = reverse('layerdetails', args=(prj.id, layer_dep_obj.pk))
-                            layers_added.append({'id': layer_dep_obj.id, 'name': Layer.objects.get(id=layer_dep_obj.layer_id).name, 'layerdetailurl': layerdepdetailurl })
-
-
-                # If an old layer version exists in our project then remove it
-                for prj_layers in ProjectLayer.objects.filter(project=prj):
-                    dup_layer_v = Layer_Version.objects.filter(id=prj_layers.layercommit_id, layer_id=layer.id)
-                    if len(dup_layer_v) >0 :
-                        prj_layers.delete()
-
-                # finally add the imported layer (version id) to the project
-                ProjectLayer.objects.create(layercommit=layer_version, project=prj,optional=1)
-
-            else:
-                # We didn't create a layer version so back out now and clean up.
-                if layer_created:
-                    layer.delete()
-
-                return HttpResponse(jsonfilter({"error": "Uncaught error: Could not create layer version"}), content_type = "application/json")
-
-        layerdetailurl = reverse('layerdetails', args=(prj.id, layer_version.pk))
-
-        json_response = {"error": "ok",
-                         "imported_layer" : {
-                           "name" : layer.name,
-                           "id": layer_version.id,
-                           "layerdetailurl": layerdetailurl,
-                         },
-                         "deps_added": layers_added }
-
-        return HttpResponse(jsonfilter(json_response), content_type = "application/json")
-
     def customrecipe_download(request, pid, recipe_id):
         recipe = get_object_or_404(CustomImageRecipe, pk=recipe_id)
 
-- 
2.7.4


