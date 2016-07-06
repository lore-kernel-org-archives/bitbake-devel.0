Return-Path: <elliot.smith@intel.com>
Received: from bongo.birch.relay.mailchannels.net
	(bongo.birch.relay.mailchannels.net [23.83.209.21])
	by mail.openembedded.org (Postfix) with ESMTP id C0AAA60119
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jul 2016 17:22:47 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A53D063B38;
	Wed,  6 Jul 2016 17:22:47 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-42-131-234.us-west-2.compute.internal [10.42.131.234])
	by relay.mailchannels.net (Postfix) with ESMTPA id EAC6A641BF;
	Wed,  6 Jul 2016 17:22:44 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.91.5.35])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.6.15); Wed, 06 Jul 2016 17:22:45 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1467825798443:2856261465
X-MC-Ingress-Time: 1467825798443
Received: from [176.251.41.101] (port=34404 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bKqZl-0000gg-CS; Wed, 06 Jul 2016 13:25:29 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Jul 2016 18:22:36 +0100
Message-Id: <2554ed0be16cfdf0f1cdbe2911c21cf4396cb156.1467825407.git.elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1467825407.git.elliot.smith@intel.com>
References: <cover.1467825407.git.elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 1/4] toaster: layerdetails api Fix saving of git revision of a layer
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
X-List-Received-Date: Wed, 06 Jul 2016 17:22:48 -0000

From: Michael Wood <michael.g.wood@intel.com>

Update, clean up and move the api for updating a layerversion from the
views to api. Also update the layerdetails page to include the
layerversion id in the url getter.

[YOCTO #8952]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/api.py                      | 99 +++++++++++++++++++++-
 lib/toaster/toastergui/templates/layerdetails.html |  2 +-
 lib/toaster/toastergui/urls.py                     |  5 +-
 lib/toaster/toastergui/views.py                    | 43 ----------
 4 files changed, 103 insertions(+), 46 deletions(-)

diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index 961b594..a024748 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -20,11 +20,14 @@
 # Temporary home for the UI's misc API
 import re
 
-from orm.models import Project, ProjectTarget, Build
+from orm.models import Project, ProjectTarget, Build, Layer_Version
+from orm.models import LayerVersionDependency, LayerSource, ProjectLayer
 from bldcontrol.models import BuildRequest
 from bldcontrol import bbcontroller
 from django.http import HttpResponse, JsonResponse
 from django.views.generic import View
+from django.core.urlresolvers import reverse
+
 
 
 class XhrBuildRequest(View):
@@ -109,3 +112,97 @@ class XhrBuildRequest(View):
         response = HttpResponse()
         response.status_code = 500
         return response
+
+
+class XhrLayer(View):
+    """ Get and Update Layer information """
+
+    def post(self, request, *args, **kwargs):
+        """
+          Update a layer
+
+          Entry point: /xhr_layer/<layerversion_id>
+          Method: POST
+
+          Args:
+              vcs_url, dirpath, commit, up_branch, summary, description
+
+              add_dep = append a layerversion_id as a dependency
+              rm_dep = remove a layerversion_id as a depedency
+          Returns:
+              {"error": "ok"}
+            or
+              {"error": <error message>}
+        """
+
+        def error_response(error):
+            return JsonResponse({"error": error})
+
+        try:
+            # We currently only allow Imported layers to be edited
+            layer_version = Layer_Version.objects.get(
+                id=kwargs['layerversion_id'],
+                project=kwargs['pid'],
+                layer_source__sourcetype=LayerSource.TYPE_IMPORTED)
+
+        except Layer_Version.DoesNotExist:
+            return error_response("Cannot find imported layer to update")
+
+        if "vcs_url" in request.POST:
+            layer_version.layer.vcs_url = request.POST["vcs_url"]
+        if "dirpath" in request.POST:
+            layer_version.dirpath = request.POST["dirpath"]
+        if "commit" in request.POST:
+            layer_version.commit = request.POST["commit"]
+            layer_version.branch = request.POST["commit"]
+        if "up_branch" in request.POST:
+            layer_version.up_branch_id = int(request.POST["up_branch"])
+        if "summary" in request.POST:
+            layer_version.layer.summary = request.POST["summary"]
+        if "description" in request.POST:
+            layer_version.layer.description = request.POST["description"]
+
+        if "add_dep" in request.POST:
+            lvd = LayerVersionDependency(
+                layer_version=layer_version,
+                depends_on_id=request.POST["add_dep"])
+            lvd.save()
+
+        if "rm_dep" in request.POST:
+            rm_dep = LayerVersionDependency.objects.get(
+                layer_version=layer_version,
+                depends_on_id=request.POST["rm_dep"])
+            rm_dep.delete()
+
+        try:
+            layer_version.layer.save()
+            layer_version.save()
+        except Exception as e:
+            return error_response("Could not update layer version entry: %s"
+                                  % e)
+
+        return JsonResponse({"error": "ok"})
+
+    def delete(self, request, *args, **kwargs):
+        try:
+            # We currently only allow Imported layers to be deleted
+            layer_version = Layer_Version.objects.get(
+                id=kwargs['layerversion_id'],
+                project=kwargs['pid'],
+                layer_source__sourcetype=LayerSource.TYPE_IMPORTED)
+        except Layer_Version.DoesNotExist:
+            return error_response("Cannot find imported layer to delete")
+
+        try:
+            ProjectLayer.objects.get(project=kwargs['pid'],
+                                     layercommit=layer_version).delete()
+        except ProjectLayer.DoesNotExist:
+            pass
+
+        layer_version.layer.delete()
+        layer_version.delete()
+
+        return JsonResponse({
+            "error": "ok",
+            "redirect": reverse('project', args=(kwargs['pid'],))
+        })
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 0f0b2b4..143ec25 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -44,7 +44,7 @@
 
     $(document).ready(function(){
       var ctx = {
-        xhrUpdateLayerUrl : "{% url 'xhr_updatelayer' %}",
+        xhrUpdateLayerUrl : "{% url 'xhr_layer' layerversion.pk %}",
         layerVersion : {
           name : "{{layerversion.layer.name}}",
           id : {{layerversion.id}},
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 9510a38..15b1063 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -190,7 +190,10 @@ urlpatterns = patterns('toastergui.views',
             name='xhr_configvaredit'),
 
         url(r'^xhr_importlayer/$', 'xhr_importlayer', name='xhr_importlayer'),
-        url(r'^xhr_updatelayer/$', 'xhr_updatelayer', name='xhr_updatelayer'),
+
+        url(r'^xhr_layer/(?P<layerversion_id>\d+)$',
+            api.XhrLayer.as_view(),
+            name='xhr_layer'),
 
         # JS Unit tests
         url(r'^js-unit-tests/$', 'jsunittests', name='js-unit-tests'),
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 2db68bd..ad85faf 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1739,49 +1739,6 @@ if True:
 
         return HttpResponse(jsonfilter(json_response), content_type = "application/json")
 
-    def xhr_updatelayer(request):
-
-        def error_response(error):
-            return HttpResponse(jsonfilter({"error": error}), content_type = "application/json")
-
-        if "layer_version_id" not in request.POST:
-            return error_response("Please specify a layer version id")
-        try:
-            layer_version_id = request.POST["layer_version_id"]
-            layer_version = Layer_Version.objects.get(id=layer_version_id)
-        except Layer_Version.DoesNotExist:
-            return error_response("Cannot find layer to update")
-
-
-        if "vcs_url" in request.POST:
-            layer_version.layer.vcs_url = request.POST["vcs_url"]
-        if "dirpath" in request.POST:
-            layer_version.dirpath = request.POST["dirpath"]
-        if "commit" in request.POST:
-            layer_version.commit = request.POST["commit"]
-        if "up_branch" in request.POST:
-            layer_version.up_branch_id = int(request.POST["up_branch"])
-
-        if "add_dep" in request.POST:
-            lvd = LayerVersionDependency(layer_version=layer_version, depends_on_id=request.POST["add_dep"])
-            lvd.save()
-
-        if "rm_dep" in request.POST:
-            rm_dep = LayerVersionDependency.objects.get(layer_version=layer_version, depends_on_id=request.POST["rm_dep"])
-            rm_dep.delete()
-
-        if "summary" in request.POST:
-            layer_version.layer.summary = request.POST["summary"]
-        if "description" in request.POST:
-            layer_version.layer.description = request.POST["description"]
-
-        try:
-            layer_version.layer.save()
-            layer_version.save()
-        except Exception as e:
-            return error_response("Could not update layer version entry: %s" % e)
-
-        return HttpResponse(jsonfilter({"error": "ok",}), content_type = "application/json")
 
     @xhr_response
     def xhr_customrecipe(request):
-- 
2.7.4


