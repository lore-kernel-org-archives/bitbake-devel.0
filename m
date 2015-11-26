Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 7CD4565D4A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Nov 2015 16:44:50 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 26 Nov 2015 08:44:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,347,1444719600"; d="scan'208";a="860355515"
Received: from snwijaya-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.16.69])
	by fmsmga002.fm.intel.com with ESMTP; 26 Nov 2015 08:44:50 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Nov 2015 16:44:35 +0000
Message-Id: <1e996bc1b394b769f445b79a5451f32b427a418e.1448556172.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <7a60315f7183a0792c24c7e5a2c4b5688e6f18c8.1448556172.git.elliot.smith@intel.com>
References: <7a60315f7183a0792c24c7e5a2c4b5688e6f18c8.1448556172.git.elliot.smith@intel.com>
In-Reply-To: <cover.1448556172.git.elliot.smith@intel.com>
References: <cover.1448556172.git.elliot.smith@intel.com>
Subject: [PATCH 5/5] toaster: toastergui tests Add generic test for ToasterTables widget
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
X-List-Received-Date: Thu, 26 Nov 2015 16:44:50 -0000

From: Michael Wood <michael.g.wood@intel.com>

For each of the ToasterTables defined test:
 - Data returned
 - Search
 - Order by
 - Limit
 - Paginate
 - Filter

These tests test that the functions on all tables work, it does not
validate the content of the data in the tables themselves, this needs
to be done in table specific tests.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/tests.py | 223 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 212 insertions(+), 11 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 9e6c46a..a631203 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -33,11 +33,14 @@ from orm.models import CustomImageRecipe, ProjectVariable
 from orm.models import Branch
 
 import toastermain
+import inspect
+import toastergui
 
 from toastergui.tables import SoftwareRecipesTable
 import json
 from bs4 import BeautifulSoup
 import re
+import string
 
 PROJECT_NAME = "test project"
 CLI_BUILDS_PROJECT_NAME = 'Command line builds'
@@ -69,32 +72,68 @@ class ViewTests(TestCase):
         layer = Layer.objects.create(name="base-layer", layer_source=layersrc,
                                      vcs_url="/tmp/")
 
+        layer_two = Layer.objects.create(name="z-layer",
+                                         layer_source=layersrc,
+                                         vcs_url="git://two/")
+
+
         branch = Branch.objects.create(name="master", layer_source=layersrc)
 
-        lver = Layer_Version.objects.create(layer=layer, project=self.project,
-                                            layer_source=layersrc, commit="master",
-                                            up_branch=branch)
+        self.lver = Layer_Version.objects.create(layer=layer,
+                                                 project=self.project,
+                                                 layer_source=layersrc,
+                                                 commit="master",
+                                                 up_branch=branch)
+
+        lver_two = Layer_Version.objects.create(layer=layer_two,
+                                                layer_source=layersrc,
+                                                commit="master",
+                                                up_branch=branch)
+
+        Recipe.objects.create(layer_source=layersrc,
+                              name="z recipe",
+                              version="5.2",
+                              summary="z recipe",
+                              description="G recipe",
+                              license="Z GPL",
+                              section="h section",
+                              layer_version=lver_two)
 
         self.recipe1 = Recipe.objects.create(layer_source=layersrc,
                                              name="base-recipe",
                                              version="1.2",
                                              summary="one recipe",
                                              description="recipe",
-                                             layer_version=lver)
+                                             section="A section",
+                                             license="Apache",
+                                             layer_version=self.lver)
 
-        Machine.objects.create(layer_version=lver, name="wisk",
+        Machine.objects.create(layer_version=self.lver, name="wisk",
                                description="wisking machine")
+        Machine.objects.create(layer_version=self.lver, name="zap",
+                               description="zap machine")
+        Machine.objects.create(layer_version=lver_two, name="xray",
+                               description="xray machine")
+
 
-        ProjectLayer.objects.create(project=self.project, layercommit=lver)
+
+        ProjectLayer.objects.create(project=self.project, layercommit=self.lver)
 
 
         self.customr = CustomImageRecipe.objects.create(\
                            name="custom recipe", project=self.project,
                            base_recipe=self.recipe1)
 
-        self.package = Package.objects.create(name='pkg1', recipe=self.recipe1,
+        CustomImageRecipe.objects.create(name="z custom recipe",
+                                         project=self.project,
+                                         base_recipe=self.recipe1)
+
+        self.package = Package.objects.create(name='pkg1',
+                                              size=999,
+                                              recipe=self.recipe1,
                                               build=build)
 
+        Package.objects.create(name='zpkg1', recipe=self.recipe1, build=build)
 
         # recipe with project for testing AvailableRecipe table
         self.recipe2 = Recipe.objects.create(layer_source=layersrc,
@@ -102,10 +141,35 @@ class ViewTests(TestCase):
                                              version="1.4",
                                              summary="a fancy recipe",
                                              description="fancy recipe",
-                                             layer_version=lver,
+                                             license="MIT",
+                                             layer_version=self.lver,
+                                             section="Z section",
                                              file_path='/home/foo')
 
-        self.assertTrue(lver in self.project.compatible_layerversions())
+        Recipe.objects.create(layer_source=layersrc,
+                              is_image=True,
+                              name="Test image one",
+                              version="1.2",
+                              summary="one recipe",
+                              description="recipe",
+                              section="A",
+                              license="A",
+                              file_path="/one/",
+                              layer_version=self.lver)
+
+        Recipe.objects.create(layer_source=layersrc,
+                              is_image=True,
+                              name="Z Test image two",
+                              version="1.3",
+                              summary="two image recipe",
+                              description="recipe two",
+                              section="B",
+                              license="Z",
+                              file_path="/two/",
+                              layer_version=lver_two)
+
+
+
 
     def test_get_base_call_returns_html(self):
         """Basic test for all-projects view"""
@@ -181,7 +245,6 @@ class ViewTests(TestCase):
 
             return False
 
-        import string
 
         for url in urls:
             results = False
@@ -344,7 +407,7 @@ class ViewTests(TestCase):
         row2 = next(x for x in rows if x['name'] == self.recipe2.name)
 
         self.assertEqual(response.status_code, 200, 'should be 200 OK status')
-        self.assertEqual(len(rows), 2, 'should be 2 recipes')
+        self.assertTrue(row2, 'should be 2 recipes')
 
         # check other columns have been populated correctly
         self.assertEqual(row1['name'], self.recipe1.name)
@@ -360,6 +423,144 @@ class ViewTests(TestCase):
         self.assertEqual(row2['layer_version__layer__name'],
                          self.recipe2.layer_version.layer.name)
 
+    def test_toaster_tables(self):
+        """Test all ToasterTables instances"""
+
+        def get_data(table, options={}):
+            """Send a request and parse the json response"""
+            options['format'] = "json"
+            options['nocache'] = "true"
+            request = RequestFactory().get('/', options)
+            # Add any kwargs that are needed by any of the possible tables
+            response = table.get(request,
+                                 pid=self.project.id,
+                                 layerid=self.lver.pk,
+                                 recipeid=self.recipe1.pk)
+            return json.loads(response.content)
+
+        # Get a list of classes in tables module
+        tables = inspect.getmembers(toastergui.tables, inspect.isclass)
+
+        for name, table_cls in tables:
+            # Filter out the non ToasterTables from the tables module
+            if not issubclass(table_cls, toastergui.widgets.ToasterTable) or \
+                table_cls == toastergui.widgets.ToasterTable:
+                continue
+
+            # Get the table data without any options, this also does the
+            # initialisation of the table i.e. setup_columns,
+            # setup_filters and setup_queryset that we can use later
+            table = table_cls()
+            all_data = get_data(table)
+
+            self.assertTrue(len(all_data['rows']) > 1,
+                            "Cannot test on a table with < 1 row")
+
+            if table.default_orderby:
+                row_one = all_data['rows'][0][table.default_orderby.strip("-")]
+                row_two = all_data['rows'][1][table.default_orderby.strip("-")]
+
+                if '-' in table.default_orderby:
+                    self.assertTrue(row_one >= row_two,
+                                    "Default ordering not working on %s" % name)
+                else:
+                    self.assertTrue(row_one <= row_two,
+                                    "Default ordering not working on %s" % name)
+
+            # Test the column ordering and filtering functionality
+            for column in table.columns:
+                if column['orderable']:
+                    # If a column is orderable test it in both order
+                    # directions ordering on the columns field_name
+                    ascending = get_data(table_cls(),
+                                         {"orderby" : column['field_name']})
+
+                    row_one = ascending['rows'][0][column['field_name']]
+                    row_two = ascending['rows'][1][column['field_name']]
+
+                    self.assertTrue(row_one <= row_two,
+                                    "Ascending sort applied but row 0 is less "
+                                    "than row 1")
+
+                    descending = get_data(table_cls(),
+                                          {"orderby" :
+                                           '-'+column['field_name']})
+
+                    row_one = descending['rows'][0][column['field_name']]
+                    row_two = descending['rows'][1][column['field_name']]
+
+                    self.assertTrue(row_one >= row_two,
+                                    "Descending sort applied but row 0 is "
+                                    "greater than row 1")
+
+                    # If the two start rows are the same we haven't actually
+                    # changed the order
+                    self.assertNotEqual(ascending['rows'][0],
+                                        descending['rows'][0],
+                                        "An orderby %s has not changed the "
+                                        "order of the data in table %s" %
+                                        (column['field_name'], name))
+
+                if column['filter_name']:
+                    # If a filter is available for the column get the filter
+                    # info. This contains what filter actions are defined.
+                    filter_info = get_data(table_cls(),
+                                           {"cmd": "filterinfo",
+                                            "name": column['filter_name']})
+                    self.assertTrue(len(filter_info['filter_actions']) > 0,
+                                    "Filter %s was defined but no actions "
+                                    "added to it" % column['filter_name'])
+
+                    for filter_action in filter_info['filter_actions']:
+                        # filter string to pass as the option
+                        # This is the name of the filter:action
+                        # e.g. project_filter:not_in_project
+                        filter_string = "%s:%s" % (column['filter_name'],
+                                                   filter_action['name'])
+                        # Now get the data with the filter applied
+                        filtered_data = get_data(table_cls(),
+                                                 {"filter" : filter_string})
+                        self.assertEqual(len(filtered_data['rows']),
+                                         int(filter_action['count']),
+                                         "We added a table filter for %s but "
+                                         "the number of rows returned was not "
+                                         "what the filter info said there "
+                                         "would be" % name)
+
+
+            # Test search functionality on the table
+            something_found = False
+            for search in list(string.ascii_letters):
+                search_data = get_data(table_cls(), {'search' : search})
+
+                if len(search_data['rows']) > 0:
+                    something_found = True
+                    break
+
+            self.assertTrue(something_found,
+                            "We went through the whole alphabet and nothing"
+                            " was found for the search of table %s" % name)
+
+            # Test the limit functionality on the table
+            limited_data = get_data(table_cls(), {'limit' : "1"})
+            self.assertEqual(len(limited_data['rows']),
+                             1,
+                             "Limit 1 set on table %s but not 1 row returned"
+                             % name)
+
+            # Test the pagination functionality on the table
+            page_one_data = get_data(table_cls(), {'limit' : "1",
+                                                   "page": "1"})['rows'][0]
+
+            page_two_data = get_data(table_cls(), {'limit' : "1",
+                                                   "page": "2"})['rows'][0]
+
+            self.assertNotEqual(page_one_data,
+                                page_two_data,
+                                "Changed page on table %s but first row is the "
+                                "same as the previous page" % name)
+
+
 class LandingPageTests(TestCase):
     """ Tests for redirects on the landing page """
     # disable bogus pylint message error:
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


