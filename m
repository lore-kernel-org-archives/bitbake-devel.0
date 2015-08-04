Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id E494C766D8
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Aug 2015 19:46:58 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga103.fm.intel.com with ESMTP; 04 Aug 2015 12:46:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,610,1432623600"; d="scan'208";a="619262034"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga003.jf.intel.com with ESMTP; 04 Aug 2015 12:46:59 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id B75916A4083;
	Tue,  4 Aug 2015 12:46:12 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Aug 2015 22:46:38 +0300
Message-Id: <e3b6da51cdf0de62f6469d33331629c79240b2e3.1438717072.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <691696f2b87d41540b14b10ef08762f8529b4909.1438717072.git.ed.bartosh@linux.intel.com>
References: <691696f2b87d41540b14b10ef08762f8529b4909.1438717072.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438717072.git.ed.bartosh@linux.intel.com>
References: <cover.1438717072.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 10/12] bitbake: toastergui: tests Fix and more comprehensive typeahead unittest
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
X-List-Received-Date: Tue, 04 Aug 2015 19:46:59 -0000

From: Michael Wood <michael.g.wood@intel.com>

Fix the currently broken unit test for typeaheads and add some
additional fields to check for in layers, projects, recipes and machines
typeaheads.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/tests.py | 88 ++++++++++++++++++++++++++++++++---------
 1 file changed, 69 insertions(+), 19 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 77e80fe..8a59af4 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -1,7 +1,8 @@
 from django.test import TestCase
 from django.core.urlresolvers import reverse
 from orm.models import Project, Release, BitbakeVersion, Build
-from orm.models import ReleaseLayerSourcePriority, LayerSource, Layer, Layer_Version
+from orm.models import ReleaseLayerSourcePriority, LayerSource, Layer, Layer_Version, Recipe, Machine, ProjectLayer
+import json
 
 class ProvisionedProjectTestCase(TestCase):
     TEST_PROJECT_NAME = "test project"
@@ -27,7 +28,6 @@ class AllProjectsViewTestCase(ProvisionedProjectTestCase):
         self.assertTrue(response['Content-Type'].startswith('application/json'))
 
         try:
-            import json
             data = json.loads(response.content)
         except:
             self.fail("Response %s is not json-loadable" % response.content)
@@ -44,6 +44,9 @@ class AllProjectsViewTestCase(ProvisionedProjectTestCase):
 
 class ProvisionedLayersProjectTestCase(ProvisionedProjectTestCase):
     LAYER_NAME = "base-layer"
+    RECIPE_NAME = "base-recipe"
+
+
     def setUp(self):
         super(ProvisionedLayersProjectTestCase, self).setUp()
         self.layersource, created = LayerSource.objects.get_or_create(sourcetype = LayerSource.TYPE_IMPORTED)
@@ -51,6 +54,13 @@ class ProvisionedLayersProjectTestCase(ProvisionedProjectTestCase):
         self.layer, created = Layer.objects.get_or_create(name=XHRDataTypeAheadTestCase.LAYER_NAME, layer_source=self.layersource, vcs_url="/tmp/")
         self.lv, created = Layer_Version.objects.get_or_create(layer = self.layer, project = self.project, layer_source=self.layersource, commit="master")
 
+        self.recipe, created = Recipe.objects.get_or_create(layer_source=self.layersource, name=ProvisionedLayersProjectTestCase.RECIPE_NAME, version="1.2", summary="one recipe", description="recipe", layer_version=self.lv)
+
+        self.machine, created = Machine.objects.get_or_create(layer_version=self.lv, name="wisk", description="wisking machine")
+
+        ProjectLayer.objects.get_or_create(project = self.project,
+                                           layercommit = self.lv)
+
 
 class XHRDataTypeAheadTestCase(ProvisionedLayersProjectTestCase):
 
@@ -58,20 +68,60 @@ class XHRDataTypeAheadTestCase(ProvisionedLayersProjectTestCase):
         super(XHRDataTypeAheadTestCase, self).setUp()
         self.assertTrue(self.lv in self.project.compatible_layerversions())
 
-    def test_xhr_datatypeahead_layer(self):
-        response = self.client.get(reverse('xhr_datatypeahead', args=(self.project.id,)), {"type": "layerdeps"})
-        self.assertEqual(response.status_code, 200)
-        self.assertTrue(response['Content-Type'].startswith('application/json'))
-
-        try:
-            import json
-            data = json.loads(response.content)
-        except:
-            self.fail("Response %s is not json-loadable" % response.content)
-
-        self.assertTrue("error" in data)
-        self.assertEqual(data["error"], "ok")
-        self.assertTrue("list" in data)
-        self.assertTrue(len(data["list"]) > 0)
-
-        self.assertTrue(XHRDataTypeAheadTestCase.LAYER_NAME in map(lambda x: x["name"], data["list"]))
+    def test_typeaheads(self):
+        layers_url = reverse('xhr_layerstypeahead', args=(self.project.id,))
+        prj_url = reverse('xhr_projectstypeahead')
+
+        urls = [ layers_url,
+                 prj_url,
+                 reverse('xhr_recipestypeahead', args=(self.project.id,)),
+                 reverse('xhr_machinestypeahead', args=(self.project.id,)),
+               ]
+
+        def basic_reponse_check(reponse, url):
+            self.assertEqual(response.status_code, 200)
+            self.assertTrue(response['Content-Type'].startswith('application/json'))
+
+            try:
+                data = json.loads(response.content)
+            except:
+                self.fail("Response %s is not json-loadable" % response.content)
+            self.assertTrue("error" in data)
+            self.assertEqual(data["error"], "ok")
+            self.assertTrue("results" in data)
+
+            # We got a result so now check the fields
+            if len(data['results']) > 0:
+                result = data['results'][0]
+
+                self.assertTrue(len(result['name']) > 0)
+                self.assertTrue("detail" in result)
+                self.assertTrue(result['id'] > 0)
+
+                # Special check for the layers typeahead's extra fields
+                if url == layers_url:
+                    self.assertTrue(len(result['layerdetailurl']) > 0)
+                    self.assertTrue(len(result['vcs_url']) > 0)
+                    self.assertTrue(len(result['vcs_reference']) > 0)
+                # Special check for project typeahead extra fields
+                elif url == prj_url:
+                    self.assertTrue(len(result['projectPageUrl']) > 0)
+
+                return True
+
+            return False
+
+        import string
+
+        for url in urls:
+            results = False
+
+            for typeing in list(string.ascii_letters):
+                response = self.client.get(url, { 'search' : typeing })
+                results = basic_reponse_check(response, url)
+                if results:
+                    break
+
+            # After "typeing" the alpabet we should have result true
+            # from each of the urls
+            self.assertTrue(results)
-- 
2.1.4


