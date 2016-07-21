Return-Path: <elliot.smith@intel.com>
Received: from bird.oak.relay.mailchannels.net
	(bird.oak.relay.mailchannels.net [23.83.215.17])
	by mail.openembedded.org (Postfix) with ESMTP id 0460A731C6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 13:39:32 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 90DA9101460;
	Thu, 21 Jul 2016 13:39:33 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-120-4-226.us-west-2.compute.internal [10.120.4.226])
	by relay.mailchannels.net (Postfix) with ESMTPA id 13989101461;
	Thu, 21 Jul 2016 13:39:33 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.132.194.146])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.1); Thu, 21 Jul 2016 13:39:33 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1469108373409:2818421976
X-MC-Ingress-Time: 1469108373409
Received: from [176.249.240.35] (port=56876 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bQECJ-00012R-T6; Thu, 21 Jul 2016 09:39:32 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2016 14:39:07 +0100
Message-Id: <1469108352-12098-5-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1469108352-12098-1-git-send-email-elliot.smith@intel.com>
References: <1469108352-12098-1-git-send-email-elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 05/10] toaster: Replace references to LayerSource models
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
X-List-Received-Date: Thu, 21 Jul 2016 13:39:33 -0000

From: Michael Wood <michael.g.wood@intel.com>

Replace references to the now deprecated layersource models across
Toaster with the new enums for layer source types.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bitbake/lib/toaster/bldcontrol/tests.py            | 19 --------
 bitbake/lib/toaster/orm/models.py                  |  8 ++++
 .../tests/browser/test_layerdetails_page.py        |  3 --
 bitbake/lib/toaster/toastergui/api.py              |  6 +--
 .../toaster/toastergui/static/js/layerdetails.js   |  2 +-
 .../toaster/toastergui/templates/layerdetails.html | 16 +++----
 bitbake/lib/toaster/toastergui/views.py            | 56 +++++++++++++++-------
 7 files changed, 57 insertions(+), 53 deletions(-)

diff --git a/bitbake/lib/toaster/bldcontrol/tests.py b/bitbake/lib/toaster/bldcontrol/tests.py
index 32985c3..475ac0a 100644
--- a/bitbake/lib/toaster/bldcontrol/tests.py
+++ b/bitbake/lib/toaster/bldcontrol/tests.py
@@ -139,22 +139,3 @@ class RunBuildsCommandTests(TestCase):
         self.assertTrue(br.state == BuildRequest.REQ_INPROGRESS, "Request is not updated")
         # no more selections possible here
         self.assertRaises(IndexError, command._selectBuildRequest)
-
-
-class UtilityTests(TestCase):
-    def test_reduce_path(self):
-        from bldcontrol.management.commands.loadconf import _reduce_canon_path, _get_id_for_sourcetype
-
-        self.assertTrue( _reduce_canon_path("/") == "/")
-        self.assertTrue( _reduce_canon_path("/home/..") == "/")
-        self.assertTrue( _reduce_canon_path("/home/../ana") == "/ana")
-        self.assertTrue( _reduce_canon_path("/home/../ana/..") == "/")
-        self.assertTrue( _reduce_canon_path("/home/ana/mihai/../maria") == "/home/ana/maria")
-
-    def test_get_id_for_sorucetype(self):
-        from bldcontrol.management.commands.loadconf import _reduce_canon_path, _get_id_for_sourcetype
-        self.assertTrue( _get_id_for_sourcetype("layerindex") == 1)
-        self.assertTrue( _get_id_for_sourcetype("local") == 0)
-        self.assertTrue( _get_id_for_sourcetype("imported") == 2)
-        with self.assertRaises(Exception):
-            _get_id_for_sourcetype("unknown")
diff --git a/bitbake/lib/toaster/orm/models.py b/bitbake/lib/toaster/orm/models.py
index 1daec9c..34ea28c 100644
--- a/bitbake/lib/toaster/orm/models.py
+++ b/bitbake/lib/toaster/orm/models.py
@@ -1287,6 +1287,14 @@ class LayerSource(object):
         (TYPE_BUILD, "build"),
     )
 
+    def types_dict():
+        """ Turn the TYPES enums into a simple dictionary """
+        dictionary = {}
+        for key in LayerSource.__dict__:
+            if "TYPE" in key:
+                dictionary[key] = getattr(LayerSource, key)
+        return dictionary
+
 
 class Layer(models.Model):
 
diff --git a/bitbake/lib/toaster/tests/browser/test_layerdetails_page.py b/bitbake/lib/toaster/tests/browser/test_layerdetails_page.py
index fb1007f..71c5c12 100644
--- a/bitbake/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/bitbake/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -49,9 +49,6 @@ class TestLayerDetailsPage(SeleniumTestCase):
         # project to add new custom images to
         self.project = Project.objects.create(name='foo', release=release)
 
-        layer_source = LayerSource.objects.create(
-            sourcetype=LayerSource.TYPE_IMPORTED)
-
         name = "meta-imported"
         vcs_url = "git://example.com/meta-imported"
         subdir = "/layer"
diff --git a/bitbake/lib/toaster/toastergui/api.py b/bitbake/lib/toaster/toastergui/api.py
index 112ce58..414afce 100644
--- a/bitbake/lib/toaster/toastergui/api.py
+++ b/bitbake/lib/toaster/toastergui/api.py
@@ -147,7 +147,7 @@ class XhrLayer(View):
             layer_version = Layer_Version.objects.get(
                 id=kwargs['layerversion_id'],
                 project=kwargs['pid'],
-                layer_source__sourcetype=LayerSource.TYPE_IMPORTED)
+                layer_source=LayerSource.TYPE_IMPORTED)
 
         except Layer_Version.DoesNotExist:
             return error_response("Cannot find imported layer to update")
@@ -159,8 +159,6 @@ class XhrLayer(View):
         if "commit" in request.POST:
             layer_version.commit = request.POST["commit"]
             layer_version.branch = request.POST["commit"]
-        if "up_branch" in request.POST:
-            layer_version.up_branch_id = int(request.POST["up_branch"])
         if "summary" in request.POST:
             layer_version.layer.summary = request.POST["summary"]
         if "description" in request.POST:
@@ -193,7 +191,7 @@ class XhrLayer(View):
             layer_version = Layer_Version.objects.get(
                 id=kwargs['layerversion_id'],
                 project=kwargs['pid'],
-                layer_source__sourcetype=LayerSource.TYPE_IMPORTED)
+                layer_source=LayerSource.TYPE_IMPORTED)
         except Layer_Version.DoesNotExist:
             return error_response("Cannot find imported layer to delete")
 
diff --git a/bitbake/lib/toaster/toastergui/static/js/layerdetails.js b/bitbake/lib/toaster/toastergui/static/js/layerdetails.js
index 683486e..0d4240b 100644
--- a/bitbake/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/bitbake/lib/toaster/toastergui/static/js/layerdetails.js
@@ -366,7 +366,7 @@ function layerDetailsPageInit (ctx) {
     if ($(this).is("dt")) {
       var dd = $(this).next("dd");
       if (!dd.children("form:visible")|| !dd.find(".current-value").html()){
-        if (ctx.layerVersion.sourceId == 3){
+        if (ctx.layerVersion.layer_source == ctx.layerSourceTypes.TYPE_IMPORTED){
         /* There's no current value and the layer is editable
          * so show the "Not set" and hide the delete icon
          */
diff --git a/bitbake/lib/toaster/toastergui/templates/layerdetails.html b/bitbake/lib/toaster/toastergui/templates/layerdetails.html
index 4b51d1a..029c93b 100644
--- a/bitbake/lib/toaster/toastergui/templates/layerdetails.html
+++ b/bitbake/lib/toaster/toastergui/templates/layerdetails.html
@@ -36,7 +36,7 @@
     </ul>
 
     {# If this is not an imported layer then hide the edit ui #}
-    {% if not layerversion.layer_source_id or layerversion.layer_source.sourcetype != layerversion.layer_source.TYPE_IMPORTED %}
+    {% if layerversion.layer_source != layer_source.TYPE_IMPORTED %}
     <style scoped>
     .glyphicon-edit {
       display:none;
@@ -69,8 +69,9 @@
           inCurrentPrj : false,
           {% endif %}
           layerdetailurl : "{% url 'layerdetails' project.id layerversion.id  %}",
-          sourceId: {{layerversion.layer_source_id|json}},
-        }
+          layer_source: {{layerversion.layer_source|json}},
+        },
+        layerSourceTypes: {{layer_source|json}},
       };
 
       try {
@@ -89,7 +90,6 @@
         {% endif %}>({{layerversion.get_vcs_reference|truncatechars:13}})</small>
       </h1>
     </div>
-
     <div class="row">
       <!-- container for tabs -->
       <div class="col-md-8 tabbable">
@@ -277,15 +277,15 @@
             <span class="glyphicon glyphicon-edit"></span>
             <span class="glyphicon glyphicon-trash delete-current-value" data-toggle="tooltip" title="Delete"></span>
             </dd>
-            {% if layerversion.layer.up_id %}
+            {% if layerversion.layer_source == layer_source.TYPE_LAYERINDEX  %}
             <dt>Layer index</dt>
             <dd>
-            <a href="http://layers.openembedded.org/layerindex/branch/{{layerversion.up_branch.name}}/layer/{{layerversion.layer.name}}">layer index link</a>
-
+            <a href="http://layers.openembedded.org/layerindex/branch/{{layerversion.release.name}}/layer/{{layerversion.layer.name}}">Layer index {{layerversion.layer.name}}</a>
             </dd>
             {% endif %}
           </dl>
-          {% if layerversion.layer_source_id and layerversion.layer_source.sourcetype == layerversion.layer_source.TYPE_IMPORTED %}
+          {# Only show delete link for imported layers #}
+          {% if layerversion.layer_source == layer_source.TYPE_IMPORTED %}
           <i class="icon-trash text-danger"></i>
           <a href="#delete-layer-modal"  role="button" class="text-danger" data-toggle="modal" data-target="#delete-layer-modal">Delete {{layerversion.layer.name}}</a>
           {% endif %}
diff --git a/bitbake/lib/toaster/toastergui/views.py b/bitbake/lib/toaster/toastergui/views.py
index aab6536..d19815f 100755
--- a/bitbake/lib/toaster/toastergui/views.py
+++ b/bitbake/lib/toaster/toastergui/views.py
@@ -1452,9 +1452,8 @@ if True:
         layers = [{"id": x.layercommit.pk, "orderid": x.pk, "name" : x.layercommit.layer.name,
                    "vcs_url": x.layercommit.layer.vcs_url, "vcs_reference" : x.layercommit.get_vcs_reference(),
                    "url": x.layercommit.layer.layer_index_url, "layerdetailurl": x.layercommit.get_detailspage_url(prj.pk),
-                   # This branch name is actually the release
                    "branch" : {"name" : x.layercommit.get_vcs_reference(),
-                               "layersource" : x.layercommit.up_branch.layer_source.name if x.layercommit.up_branch != None else None}
+                               "layersource" : x.layercommit.layer_source }
                    } for x in prj.projectlayer_set.all().order_by("id")]
 
         context = {
@@ -1670,10 +1669,7 @@ if True:
 
         # We need to know what release the current project is so that we
         # can set the imported layer's up_branch_id
-        prj_branch_name = Release.objects.get(pk=prj.release_id).branch_name
-        up_branch, branch_created = Branch.objects.get_or_create(name=prj_branch_name, layer_source_id=LayerSource.TYPE_IMPORTED)
 
-        layer_source = LayerSource.objects.get(sourcetype=LayerSource.TYPE_IMPORTED)
         try:
             layer, layer_created = Layer.objects.get_or_create(name=post_data['name'])
         except MultipleObjectsReturned:
@@ -1681,7 +1677,6 @@ if True:
 
         if layer:
             if layer_created:
-                layer.layer_source = layer_source
                 layer.vcs_url = post_data['vcs_url']
                 layer.up_date = timezone.now()
                 layer.save()
@@ -1692,12 +1687,24 @@ if True:
                 if layer.vcs_url != post_data['vcs_url']:
                     return HttpResponse(jsonfilter({"error": "hint-layer-exists-with-different-url" , "current_url" : layer.vcs_url, "current_id": layer.id }), content_type = "application/json")
 
-
-            layer_version, version_created = Layer_Version.objects.get_or_create(layer_source=layer_source, layer=layer, project=prj, up_branch_id=up_branch.id,branch=post_data['git_ref'],  commit=post_data['git_ref'], dirpath=post_data['dir_path'])
+            layer_version, version_created = \
+                Layer_Version.objects.get_or_create(
+                        layer_source=LayerSource.TYPE_IMPORTED,
+                        layer=layer, project=prj,
+                        release=prj.release,
+                        branch=post_data['git_ref'],
+                        commit=post_data['git_ref'],
+                        dirpath=post_data['dir_path'])
 
             if layer_version:
                 if not version_created:
-                    return HttpResponse(jsonfilter({"error": "hint-layer-version-exists", "existing_layer_version": layer_version.id }), content_type = "application/json")
+                    return HttpResponse(jsonfilter({"error":
+                                                    "hint-layer-version-exists",
+                                                    "existing_layer_version":
+                                                    layer_version.id }),
+                                        content_type = "application/json")
+
+                layer_version.layer_source = LayerSource.TYPE_IMPORTED
 
                 layer_version.up_date = timezone.now()
                 layer_version.save()
@@ -2179,20 +2186,33 @@ if True:
         }
         return render(request, template, context)
 
+    # TODO merge with api pseudo api here is used for deps modal
     @_template_renderer('layerdetails.html')
     def layerdetails(request, pid, layerid):
         project = Project.objects.get(pk=pid)
         layer_version = Layer_Version.objects.get(pk=layerid)
 
-        context = {'project' : project,
-            'layerversion' : layer_version,
-            'layerdeps' : {"list": [{"id": dep.id,
-                "name": dep.layer.name,
-                "layerdetailurl": reverse('layerdetails', args=(pid, dep.pk)),
-                "vcs_url": dep.layer.vcs_url,
-                "vcs_reference": dep.get_vcs_reference()} \
-                for dep in layer_version.get_alldeps(project.id)]},
-            'projectlayers': [player.layercommit.id for player in ProjectLayer.objects.filter(project=project)]
+        project_layers = ProjectLayer.objects.filter(
+            project=project).values_list("layercommit_id",
+                                         flat=True)
+
+        context = {
+            'project': project,
+            'layer_source': LayerSource.types_dict(),
+            'layerversion': layer_version,
+            'layerdeps': {
+                "list": [
+                    {
+                        "id": dep.id,
+                        "name": dep.layer.name,
+                        "layerdetailurl": reverse('layerdetails',
+                                                  args=(pid, dep.pk)),
+                        "vcs_url": dep.layer.vcs_url,
+                        "vcs_reference": dep.get_vcs_reference()
+                    }
+                    for dep in layer_version.get_alldeps(project.id)]
+            },
+            'projectlayers': list(project_layers)
         }
 
         return context
-- 
2.7.4


