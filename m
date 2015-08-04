Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 92E867653B
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Aug 2015 19:46:55 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga101.fm.intel.com with ESMTP; 04 Aug 2015 12:46:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,610,1432623600"; 
	d="scan'208,217";a="777766521"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 04 Aug 2015 12:46:56 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 9E7336A4083;
	Tue,  4 Aug 2015 12:46:09 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Aug 2015 22:46:36 +0300
Message-Id: <23a4ef7d7e3fdfbc4c59919c3689b885df34b2e6.1438717072.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <691696f2b87d41540b14b10ef08762f8529b4909.1438717072.git.ed.bartosh@linux.intel.com>
References: <691696f2b87d41540b14b10ef08762f8529b4909.1438717072.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438717072.git.ed.bartosh@linux.intel.com>
References: <cover.1438717072.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 08/12] bitbake: toasterui: views Remove unused xhr_typeahead view definition
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
X-List-Received-Date: Tue, 04 Aug 2015 19:46:56 -0000

From: Michael Wood <michael.g.wood@intel.com>

The one thing left being used in this definition was a response which
contains the list of layers which would be deleted if you change the
project release. This patch moves that to it's own url/endpoint and
updates the frontend reference which is using it.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/projectpage.js |  4 +-
 lib/toaster/toastergui/templates/project.html   |  3 +-
 lib/toaster/toastergui/urls.py                  |  8 +++-
 lib/toaster/toastergui/views.py                 | 60 ++++++++++---------------
 4 files changed, 32 insertions(+), 43 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/projectpage.js b/lib/toaster/toastergui/static/js/projectpage.js
index b82f740..146319e 100644
--- a/lib/toaster/toastergui/static/js/projectpage.js
+++ b/lib/toaster/toastergui/static/js/projectpage.js
@@ -406,8 +406,8 @@ function projectPageInit(ctx) {
 
     var newRelease = releaseForm.find("option:selected").data('release');
 
-    $.getJSON(ctx.typeaheadUrl,
-      { search: newRelease.id, type: "versionlayers" },
+    $.getJSON(ctx.testReleaseChangeUrl,
+      { new_release_id: newRelease.id },
       function(layers) {
         if (layers.rows.length === 0){
           /* No layers to change for this release */
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index aad79b4..4cabad4 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -11,8 +11,7 @@
 <script>
   $(document).ready(function (){
     var ctx = {
-      typeaheadUrl : "{% url 'xhr_datatypeahead' project.id %}",
-
+      testReleaseChangeUrl: "{% url 'xhr_testreleasechange' project.id %}",
     };
 
     try {
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index b44c42f..d65ad2b 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -126,8 +126,6 @@ urlpatterns = patterns('toastergui.views',
             name=tables.LayerMachinesTable.__name__.lower()),
 
 
-        url(r'^xhr_datatypeahead/(?P<pid>\d+)$', 'xhr_datatypeahead', name='xhr_datatypeahead'),
-        url(r'^xhr_configvaredit/(?P<pid>\d+)$', 'xhr_configvaredit', name='xhr_configvaredit'),
         # typeahead api end points
         url(r'^xhr_typeahead/(?P<pid>\d+)/layers$',
             typeaheads.LayersTypeAhead.as_view(), name='xhr_layerstypeahead'),
@@ -139,6 +137,12 @@ urlpatterns = patterns('toastergui.views',
             typeaheads.ProjectsTypeAhead.as_view(), name='xhr_projectstypeahead'),
 
 
+
+        url(r'^xhr_testreleasechange/(?P<pid>\d+)$', 'xhr_testreleasechange',
+            name='xhr_testreleasechange'),
+        url(r'^xhr_configvaredit/(?P<pid>\d+)$', 'xhr_configvaredit',
+            name='xhr_configvaredit'),
+
         url(r'^xhr_importlayer/$', 'xhr_importlayer', name='xhr_importlayer'),
         url(r'^xhr_updatelayer/$', 'xhr_updatelayer', name='xhr_updatelayer'),
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index b7bfb9a..6a219ed 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2257,51 +2257,37 @@ if True:
 
     from django.views.decorators.csrf import csrf_exempt
     @csrf_exempt
-    def xhr_datatypeahead(request, pid):
+    def xhr_testreleasechange(request, pid):
+        def response(data):
+            return HttpResponse(jsonfilter(data),
+                                content_type="application/json")
+
+        """ returns layer versions that would be deleted on the new
+        release__pk """
         try:
             prj = Project.objects.get(pk = pid)
+            new_release_id = request.GET['new_release_id']
 
+            # If we're already on this project do nothing
+            if prj.release.pk == int(new_release_id):
+                return reponse({"error": "ok", "rows": []})
 
-            # returns layer versions that would be deleted on the new release__pk
-            if request.GET.get('type', None) == "versionlayers":
-                # If we're already on this project do nothing
-                if prj.release.pk == int(request.GET.get('search', -1)):
-                    return HttpResponse(jsonfilter({"error": "ok", "rows": []}), content_type="application/json")
-
-                retval = []
-
-                for i in prj.projectlayer_set.all():
-                    lv = prj.compatible_layerversions(release = Release.objects.get(pk=request.GET.get('search', None))).filter(layer__name = i.layercommit.layer.name)
-                    # there is no layer_version with the new release id, and the same name
-                    if lv.count() < 1:
-                        retval.append(i)
-
-                return HttpResponse(jsonfilter( {"error":"ok",
-                    "rows" : map( _lv_to_dict(prj),  map(lambda x: x.layercommit, retval ))
-                    }), content_type = "application/json")
+            retval = []
 
+            for i in prj.projectlayer_set.all():
+                lv = prj.compatible_layerversions(release = Release.objects.get(pk=new_release_id)).filter(layer__name = i.layercommit.layer.name)
+                # there is no layer_version with the new release id,
+                # and the same name
+                if lv.count() < 1:
+                    retval.append(i)
 
-            # returns layer versions that provide the named targets
-            if request.GET.get('type', None) == "layers4target":
-                # we return data only if the recipe can't be provided by the current project layer set
-                if reduce(lambda x, y: x + y, [x.recipe_layer_version.filter(name=request.GET.get('search', None)).count() for x in prj.projectlayer_equivalent_set()], 0):
-                    final_list = []
-                else:
-                    queryset_all = prj.compatible_layerversions().filter(recipe_layer_version__name = request.GET.get('search', None))
+            return response({"error":"ok",
+                             "rows" : map( _lv_to_dict(prj),
+                                          map(lambda x: x.layercommit, retval ))
+                            })
 
-                    # exclude layers in the project
-                    queryset_all = queryset_all.exclude(pk__in = [x.id for x in prj.projectlayer_equivalent_set()])
-
-                    # and show only the selected layers for this project
-                    final_list = set([x.get_equivalents_wpriority(prj)[0] for x in queryset_all])
-
-                return HttpResponse(jsonfilter( { "error":"ok",  "rows" : map( _lv_to_dict(prj), final_list) }), content_type = "application/json")
-
-
-            raise Exception("Unknown request! " + request.GET.get('type', "No parameter supplied"))
         except Exception as e:
-            return HttpResponse(jsonfilter({"error":str(e) + "\n" + traceback.format_exc()}), content_type = "application/json")
-
+            return response({"error": str(e) })
 
     def xhr_configvaredit(request, pid):
         try:
-- 
2.1.4


