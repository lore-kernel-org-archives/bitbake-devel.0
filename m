Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id 4386076903
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:44:07 +0000 (UTC)
Received: by pacex6 with SMTP id ex6so194496121pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=Af4vp73n3jGooS8sURMMtqNajZzZpg1mZcc5XuVzz1I=;
	b=g5NDiIx1Yyvj9c7vIUxb8KY3OWUxiQt3oD56DKQSc8+dC52XIfPe3cM3Zxb/kJXaPs
	SMlg3pIs+JlwcA9tDcxfUnrtvXOXYjSwZxv+OYct8Xqhf2AemWjRlkAqZdZLR1h/W7aO
	XOJJuKmX6ozqVIC57oM3M81Z5ITKenr7qXtmHp+ucmBxUUmmtFFBsnsEPhbVpsazeXkM
	n6o9lC9ab0UYxS4zqOnLzZngGpfue7E/XR9d3tabw4tkYYjslWdk+W+MC+aCmcsNcwk2
	jZKT+3DS7uHRULdG4O0sltoIMTH8CVbEsc0CeRWozr67qddpsCoEn1PHf7nPDvSD4yRH
	5UAA==
X-Received: by 10.68.111.3 with SMTP id ie3mr30877191pbb.63.1443501847751;
	Mon, 28 Sep 2015 21:44:07 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	g5sm22686368pat.21.2015.09.28.21.44.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:44:07 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:25 -0700
Message-Id: <b2ed3978d493168140a596f284c24f74c0865db8.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
References: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443497922.git.avery.brian@gmail.com>
References: <cover.1443497922.git.avery.brian@gmail.com>
Subject: [PATCH 15/22] toaster: Add test cases for new Image customisation features
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
X-List-Received-Date: Tue, 29 Sep 2015 04:44:09 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

- Adds tests for new ToasterTables
- Adds tests for new ReST API

co-author: Elliot Smith <elliot.smith@intel.com>
           Michael Wood <michael.g.wood@intel.com>

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/tests.py | 187 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 182 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 53012b4..5d15ac9 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -24,13 +24,21 @@
 import re
 
 from django.test import TestCase
+from django.test.client import RequestFactory
 from django.core.urlresolvers import reverse
 from django.utils import timezone
-from orm.models import Project, Release, BitbakeVersion, ProjectTarget
+
+from orm.models import Project, Release, BitbakeVersion, Build, Package
 from orm.models import ReleaseLayerSourcePriority, LayerSource, Layer, Build
 from orm.models import Layer_Version, Recipe, Machine, ProjectLayer, Target
+from orm.models import CustomImageRecipe
+from orm.models import Branch
+
+from toastergui.tables import SoftwareRecipesTable
+from django.utils import timezone
 import json
 from bs4 import BeautifulSoup
+import re
 
 PROJECT_NAME = "test project"
 
@@ -41,27 +49,58 @@ class ViewTests(TestCase):
         bbv = BitbakeVersion.objects.create(name="test bbv", giturl="/tmp/",
                                             branch="master", dirpath="")
         release = Release.objects.create(name="test release",
+                                         branch_name="master",
                                          bitbake_version=bbv)
         self.project = Project.objects.create_project(name=PROJECT_NAME,
                                                       release=release)
+        now = timezone.now()
+
+        build = Build.objects.create(project=self.project,
+                                     started_on=now,
+                                     completed_on=now)
+
         layersrc = LayerSource.objects.create(sourcetype=LayerSource.TYPE_IMPORTED)
         self.priority = ReleaseLayerSourcePriority.objects.create(release=release,
                                                                   layer_source=layersrc)
         layer = Layer.objects.create(name="base-layer", layer_source=layersrc,
                                      vcs_url="/tmp/")
 
+        branch = Branch.objects.create(name="master", layer_source=layersrc)
+
         lver = Layer_Version.objects.create(layer=layer, project=self.project,
-                                            layer_source=layersrc, commit="master")
+                                            layer_source=layersrc, commit="master",
+                                            up_branch=branch)
 
-        Recipe.objects.create(layer_source=layersrc, name="base-recipe",
-                              version="1.2", summary="one recipe",
-                              description="recipe", layer_version=lver)
+        self.recipe1 = Recipe.objects.create(layer_source=layersrc,
+                                       name="base-recipe",
+                                       version="1.2",
+                                       summary="one recipe",
+                                       description="recipe",
+                                       layer_version=lver)
 
         Machine.objects.create(layer_version=lver, name="wisk",
                                description="wisking machine")
 
         ProjectLayer.objects.create(project=self.project, layercommit=lver)
 
+
+        self.customr = CustomImageRecipe.objects.create(\
+                           name="custom recipe", project=self.project,
+                           base_recipe=self.recipe1)
+
+        self.package = Package.objects.create(name='pkg1', recipe=self.recipe1,
+                                              build=build)
+
+
+        # recipe with project for testing AvailableRecipe table
+        self.recipe2 = Recipe.objects.create(layer_source=layersrc,
+                                             name="fancy-recipe",
+                                             version="1.4",
+                                             summary="a fancy recipe",
+                                             description="fancy recipe",
+                                             layer_version=lver,
+                                             file_path='/home/foo')
+
         self.assertTrue(lver in self.project.compatible_layerversions())
 
     def test_get_base_call_returns_html(self):
@@ -183,6 +222,144 @@ class ViewTests(TestCase):
         data = json.loads(response.content)
         self.assertNotEqual(data["error"], "ok")
 
+    def test_custom_ok(self):
+        """Test successful return from ReST API xhr_customrecipe"""
+        url = reverse('xhr_customrecipe')
+        params = {'name': 'custom', 'project': self.project.id,
+                  'base': self.recipe1.id}
+        response = self.client.post(url, params)
+        self.assertEqual(response.status_code, 200)
+        data = json.loads(response.content)
+        self.assertEqual(data['error'], 'ok')
+        self.assertTrue('url' in data)
+        # get recipe from the database
+        recipe = CustomImageRecipe.objects.get(project=self.project,
+                                               name=params['name'])
+        args = (self.project.id, recipe.id,)
+        self.assertEqual(reverse('customrecipe', args=args), data['url'])
+
+    def test_custom_incomplete_params(self):
+        """Test not passing all required parameters to xhr_customrecipe"""
+        url = reverse('xhr_customrecipe')
+        for params in [{}, {'name': 'custom'},
+                       {'name': 'custom', 'project': self.project.id}]:
+            response = self.client.post(url, params)
+            self.assertEqual(response.status_code, 200)
+            data = json.loads(response.content)
+            self.assertNotEqual(data["error"], "ok")
+
+    def test_xhr_custom_wrong_project(self):
+        """Test passing wrong project id to xhr_customrecipe"""
+        url = reverse('xhr_customrecipe')
+        params = {'name': 'custom', 'project': 0, "base": self.recipe1.id}
+        response = self.client.post(url, params)
+        self.assertEqual(response.status_code, 200)
+        data = json.loads(response.content)
+        self.assertNotEqual(data["error"], "ok")
+
+    def test_xhr_custom_wrong_base(self):
+        """Test passing wrong base recipe id to xhr_customrecipe"""
+        url = reverse('xhr_customrecipe')
+        params = {'name': 'custom', 'project': self.project.id, "base": 0}
+        response = self.client.post(url, params)
+        self.assertEqual(response.status_code, 200)
+        data = json.loads(response.content)
+        self.assertNotEqual(data["error"], "ok")
+
+    def test_xhr_custom_details(self):
+        """Test getting custom recipe details"""
+        name = "custom recipe"
+        url = reverse('xhr_customrecipe_id', args=(self.customr.id,))
+        response = self.client.get(url)
+        self.assertEqual(response.status_code, 200)
+        expected = {"error": "ok",
+                    "info": {'id': self.customr.id,
+                             'name': name,
+                             'base_recipe_id': self.recipe1.id,
+                             'project_id': self.project.id,
+                            }
+                   }
+        self.assertEqual(json.loads(response.content), expected)
+
+    def test_xhr_custom_del(self):
+        """Test deleting custom recipe"""
+        name = "to be deleted"
+        recipe = CustomImageRecipe.objects.create(\
+                     name=name, project=self.project,
+                     base_recipe=self.recipe1)
+        url = reverse('xhr_customrecipe_id', args=(recipe.id,))
+        response = self.client.delete(url)
+        self.assertEqual(response.status_code, 200)
+        self.assertEqual(json.loads(response.content), {"error": "ok"})
+        # try to delete not-existent recipe
+        url = reverse('xhr_customrecipe_id', args=(recipe.id,))
+        response = self.client.delete(url)
+        self.assertEqual(response.status_code, 200)
+        self.assertNotEqual(json.loads(response.content)["error"], "ok")
+
+    def test_xhr_custom_packages(self):
+        """Test adding and deleting package to a custom recipe"""
+        url = reverse('xhr_customrecipe_packages',
+                      args=(self.customr.id, self.package.id))
+        # add self.package1 to recipe
+        response = self.client.put(url)
+        self.assertEqual(response.status_code, 200)
+        self.assertEqual(json.loads(response.content), {"error": "ok"})
+        self.assertEqual(self.customr.packages.all()[0].id, self.package.id)
+        # delete it
+        response = self.client.delete(url)
+        self.assertEqual(response.status_code, 200)
+        self.assertEqual(json.loads(response.content), {"error": "ok"})
+        self.assertFalse(self.customr.packages.all())
+        # delete it again to test error condition
+        response = self.client.delete(url)
+        self.assertEqual(response.status_code, 200)
+        self.assertNotEqual(json.loads(response.content)["error"], "ok")
+
+    def test_xhr_custom_packages_err(self):
+        """Test error conditions of xhr_customrecipe_packages"""
+        # test calls with wrong recipe id and wrong package id
+        for args in [(0, self.package.id), (self.customr.id, 0)]:
+            url = reverse('xhr_customrecipe_packages', args=args)
+            # test put and delete methods
+            for method in (self.client.put, self.client.delete):
+                response = method(url)
+                self.assertEqual(response.status_code, 200)
+                self.assertNotEqual(json.loads(response.content),
+                                    {"error": "ok"})
+
+    def test_software_recipes_table(self):
+        """Test structure returned for Software RecipesTable"""
+        table = SoftwareRecipesTable()
+        request = RequestFactory().get('/foo/', {'format': 'json'})
+        response = table.get(request, pid=self.project.id)
+        data = json.loads(response.content)
+
+        rows = data['rows']
+        row1 = next(x for x in rows if x['name'] == self.recipe1.name)
+        row1_btns = row1['static:add-del-layers']
+        row1_btns_data = row1['add-del-layers']
+        row2 = next(x for x in rows if x['name'] == self.recipe2.name)
+        row2_btns = row2['static:add-del-layers']
+        row2_btns_data = row2['add-del-layers']
+
+        self.assertEqual(response.status_code, 200, 'should be 200 OK status')
+        self.assertEqual(len(rows), 2, 'should be 2 recipes')
+
+        # check other columns have been populated correctly
+        self.assertEqual(row1['name'], self.recipe1.name)
+        self.assertEqual(row1['version'], self.recipe1.version)
+        self.assertEqual(row1['get_description_or_summary'],
+                         self.recipe1.description)
+        self.assertEqual(row1['layer_version__layer__name'],
+                         self.recipe1.layer_version.layer.name)
+        self.assertEqual(row2['name'], self.recipe2.name)
+        self.assertEqual(row2['version'], self.recipe2.version)
+        self.assertEqual(row2['get_description_or_summary'],
+                         self.recipe2.description)
+        self.assertEqual(row2['layer_version__layer__name'],
+                         self.recipe2.layer_version.layer.name)
+
 class LandingPageTests(TestCase):
     """ Tests for redirects on the landing page """
     # disable bogus pylint message error:
-- 
1.9.1


