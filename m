Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 11FB971D7D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Oct 2016 15:49:22 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga104.fm.intel.com with ESMTP; 28 Oct 2016 08:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,410,1473145200"; d="scan'208";a="779107317"
Received: from linux.intel.com ([10.54.29.200])
	by FMSMGA003.fm.intel.com with ESMTP; 28 Oct 2016 08:49:24 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id 7861C6A4006;
	Fri, 28 Oct 2016 08:48:48 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Oct 2016 18:48:42 +0300
Message-Id: <9f194bc2e4eb2c366782ae6ac9a111c6157d8b01.1477669486.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1477669486.git.ed.bartosh@linux.intel.com>
References: <cover.1477669486.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 1/8] toaster: views Tests fix all pyflake identified issues
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
X-List-Received-Date: Fri, 28 Oct 2016 15:49:23 -0000

From: Michael Wood <michael.g.wood@intel.com>

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/tests.py | 95 ++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 48 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 2b5894f..c20b3fe 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -24,31 +24,26 @@
 from django.test import TestCase
 from django.test.client import RequestFactory
 from django.core.urlresolvers import reverse
-from django.utils import timezone
 from django.db.models import Q
 
-from orm.models import Project, Release, BitbakeVersion, Package, LogMessage
-from orm.models import LayerSource, Layer, Build
-from orm.models import Layer_Version, Recipe, Machine, ProjectLayer, Target
-from orm.models import CustomImageRecipe, ProjectVariable
+from orm.models import Project, Package
+from orm.models import Layer_Version, Recipe
+from orm.models import CustomImageRecipe
 from orm.models import CustomImagePackage
 
-import toastermain
 import inspect
 import toastergui
 
 from toastergui.tables import SoftwareRecipesTable
 import json
-from datetime import timedelta
 from bs4 import BeautifulSoup
-import re
 import string
-import json
 
 PROJECT_NAME = "test project"
 PROJECT_NAME2 = "test project 2"
 CLI_BUILDS_PROJECT_NAME = 'Command line builds'
 
+
 class ViewTests(TestCase):
     """Tests to verify view APIs."""
 
@@ -75,7 +70,8 @@ class ViewTests(TestCase):
         url = reverse('all-projects')
         response = self.client.get(url, {"format": "json"}, follow=True)
         self.assertEqual(response.status_code, 200)
-        self.assertTrue(response['Content-Type'].startswith('application/json'))
+        self.assertTrue(response['Content-Type'].startswith(
+            'application/json'))
 
         data = json.loads(response.content.decode('utf-8'))
 
@@ -98,13 +94,13 @@ class ViewTests(TestCase):
         urls = [layers_url,
                 prj_url,
                 reverse('xhr_recipestypeahead', args=(self.project.id,)),
-                reverse('xhr_machinestypeahead', args=(self.project.id,)),
-               ]
+                reverse('xhr_machinestypeahead', args=(self.project.id,))]
 
         def basic_reponse_check(response, url):
             """Check data structure of http response."""
             self.assertEqual(response.status_code, 200)
-            self.assertTrue(response['Content-Type'].startswith('application/json'))
+            self.assertTrue(response['Content-Type'].startswith(
+                'application/json'))
 
             data = json.loads(response.content.decode('utf-8'))
 
@@ -133,7 +129,6 @@ class ViewTests(TestCase):
 
             return False
 
-
         for url in urls:
             results = False
 
@@ -149,31 +144,31 @@ class ViewTests(TestCase):
 
     def test_xhr_import_layer(self):
         """Test xhr_importlayer API"""
-        #Test for importing an already existing layer
-        args = {'vcs_url' : "git://git.example.com/test",
-                'name' : "base-layer",
+        # Test for importing an already existing layer
+        args = {'vcs_url': "git://git.example.com/test",
+                'name': "base-layer",
                 'git_ref': "c12b9596afd236116b25ce26dbe0d793de9dc7ce",
                 'project_id': self.project.id,
                 'local_source_dir': "",
-                'dir_path' : "/path/in/repository"}
+                'dir_path': "/path/in/repository"}
         response = self.client.post(reverse('xhr_importlayer'), args)
         data = json.loads(response.content.decode('utf-8'))
         self.assertEqual(response.status_code, 200)
         self.assertEqual(data["error"], "ok")
 
-        #Test to verify import of a layer successful
+        # Test to verify import of a layer successful
         args['name'] = "meta-oe"
         response = self.client.post(reverse('xhr_importlayer'), args)
         data = json.loads(response.content.decode('utf-8'))
         self.assertTrue(data["error"], "ok")
 
-        #Test for html tag in the data
+        # Test for html tag in the data
         args['<'] = "testing html tag"
         response = self.client.post(reverse('xhr_importlayer'), args)
         data = json.loads(response.content.decode('utf-8'))
         self.assertNotEqual(data["error"], "ok")
 
-        #Empty data passed
+        # Empty data passed
         args = {}
         response = self.client.post(reverse('xhr_importlayer'), args)
         data = json.loads(response.content.decode('utf-8'))
@@ -232,15 +227,14 @@ class ViewTests(TestCase):
                     "info": {'id': self.customr.id,
                              'name': self.customr.name,
                              'base_recipe_id': self.recipe1.id,
-                             'project_id': self.project.id,
-                            }
-                   }
-        self.assertEqual(json.loads(response.content.decode('utf-8')), expected)
+                             'project_id': self.project.id}}
+        self.assertEqual(json.loads(response.content.decode('utf-8')),
+                         expected)
 
     def test_xhr_custom_del(self):
         """Test deleting custom recipe"""
         name = "to be deleted"
-        recipe = CustomImageRecipe.objects.create(\
+        recipe = CustomImageRecipe.objects.create(
                      name=name, project=self.project,
                      base_recipe=self.recipe1,
                      file_path="/tmp/testing",
@@ -259,7 +253,8 @@ class ViewTests(TestCase):
         url = reverse('xhr_customrecipe_id', args=(recipe.id,))
         response = self.client.delete(url)
         self.assertEqual(response.status_code, 200)
-        self.assertNotEqual(json.loads(response.content.decode('utf-8'))["error"], "ok")
+        self.assertNotEqual(json.loads(
+            response.content.decode('utf-8'))["error"], "ok")
 
     def test_xhr_custom_packages(self):
         """Test adding and deleting package to a custom recipe"""
@@ -280,7 +275,8 @@ class ViewTests(TestCase):
 
         response = self.client.delete(del_url)
         self.assertEqual(response.status_code, 200)
-        self.assertEqual(json.loads(response.content.decode('utf-8')), {"error": "ok"})
+        self.assertEqual(json.loads(response.content.decode('utf-8')),
+                         {"error": "ok"})
         all_packages = self.customr.get_all_packages().values_list('pk',
                                                                    flat=True)
 
@@ -292,7 +288,8 @@ class ViewTests(TestCase):
 
         response = self.client.delete(del_url)
         self.assertEqual(response.status_code, 200)
-        self.assertNotEqual(json.loads(response.content.decode('utf-8'))["error"], "ok")
+        self.assertNotEqual(json.loads(
+            response.content.decode('utf-8'))["error"], "ok")
 
     def test_xhr_custom_packages_err(self):
         """Test error conditions of xhr_customrecipe_packages"""
@@ -303,8 +300,9 @@ class ViewTests(TestCase):
             for method in (self.client.put, self.client.delete):
                 response = method(url)
                 self.assertEqual(response.status_code, 200)
-                self.assertNotEqual(json.loads(response.content.decode('utf-8')),
-                                    {"error": "ok"})
+                self.assertNotEqual(json.loads(
+                    response.content.decode('utf-8')),
+                    {"error": "ok"})
 
     def test_download_custom_recipe(self):
         """Download the recipe file generated for the custom image"""
@@ -490,27 +488,28 @@ class ViewTests(TestCase):
                         # filter string to pass as the option
                         # This is the name of the filter:action
                         # e.g. project_filter:not_in_project
-                        filter_string = "%s:%s" % (column['filter_name'],
-                                                   filter_action['action_name'])
+                        filter_string = "%s:%s" % (
+                            column['filter_name'],
+                            filter_action['action_name'])
                         # Now get the data with the filter applied
                         filtered_data = get_data(table_cls(),
-                                                 {"filter" : filter_string})
+                                                 {"filter": filter_string})
 
                         # date range filter actions can't specify the
                         # number of results they return, so their count is 0
-                        if filter_action['count'] != None:
-                            self.assertEqual(len(filtered_data['rows']),
-                                             int(filter_action['count']),
-                                             "We added a table filter for %s but "
-                                             "the number of rows returned was not "
-                                             "what the filter info said there "
-                                             "would be" % name)
-
+                        if filter_action['count'] is not None:
+                            self.assertEqual(
+                                len(filtered_data['rows']),
+                                int(filter_action['count']),
+                                "We added a table filter for %s but "
+                                "the number of rows returned was not "
+                                "what the filter info said there "
+                                "would be" % name)
 
             # Test search functionality on the table
             something_found = False
             for search in list(string.ascii_letters):
-                search_data = get_data(table_cls(), {'search' : search})
+                search_data = get_data(table_cls(), {'search': search})
 
                 if len(search_data['rows']) > 0:
                     something_found = True
@@ -521,20 +520,20 @@ class ViewTests(TestCase):
                             " was found for the search of table %s" % name)
 
             # Test the limit functionality on the table
-            limited_data = get_data(table_cls(), {'limit' : "1"})
+            limited_data = get_data(table_cls(), {'limit': "1"})
             self.assertEqual(len(limited_data['rows']),
                              1,
                              "Limit 1 set on table %s but not 1 row returned"
                              % name)
 
             # Test the pagination functionality on the table
-            page_one_data = get_data(table_cls(), {'limit' : "1",
+            page_one_data = get_data(table_cls(), {'limit': "1",
                                                    "page": "1"})['rows'][0]
 
-            page_two_data = get_data(table_cls(), {'limit' : "1",
+            page_two_data = get_data(table_cls(), {'limit': "1",
                                                    "page": "2"})['rows'][0]
 
             self.assertNotEqual(page_one_data,
                                 page_two_data,
-                                "Changed page on table %s but first row is the "
-                                "same as the previous page" % name)
+                                "Changed page on table %s but first row is"
+                                " the same as the previous page" % name)
-- 
2.1.4


