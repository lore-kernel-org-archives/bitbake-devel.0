Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 70E1465CBA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 May 2016 13:50:50 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 16 May 2016 06:50:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,627,1455004800"; d="scan'208";a="977895250"
Received: from joerthel-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.28.80])
	by orsmga002.jf.intel.com with ESMTP; 16 May 2016 06:50:50 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 May 2016 14:50:41 +0100
Message-Id: <1463406641-20063-2-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1463406641-20063-1-git-send-email-elliot.smith@intel.com>
References: <1463406641-20063-1-git-send-email-elliot.smith@intel.com>
Subject: [PATCH 2/2] toaster: toastergui tests Fix toastertable tests
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
X-List-Received-Date: Mon, 16 May 2016 13:50:50 -0000

From: Michael Wood <michael.g.wood@intel.com>

After clean ups remove api assumptions. Our table data often contains
html snippets to display certain things such as dependency pop overs or
simply links to other parts of the UI. Take these into account when
testing the values of the table data.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/tests.py | 98 ++++++++++++++++++++++-----------
 1 file changed, 66 insertions(+), 32 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/tests.py b/bitbake/lib/toaster/toastergui/tests.py
index a4cab58..869c39d 100644
--- a/bitbake/lib/toaster/toastergui/tests.py
+++ b/bitbake/lib/toaster/toastergui/tests.py
@@ -83,8 +83,12 @@ class ViewTests(TestCase):
         self.assertEqual(data["error"], "ok")
         self.assertTrue("rows" in data)
 
-        self.assertTrue(self.project.name in [x["name"] for x in data["rows"]])
-        self.assertTrue("id" in data["rows"][0])
+        name_found = False
+        for row in data["rows"]:
+            name_found = row['name'].find(self.project.name)
+
+        self.assertTrue(name_found,
+                        "project name not found in projects table")
 
     def test_typeaheads(self):
         """Test typeahead ReST API"""
@@ -322,22 +326,24 @@ class ViewTests(TestCase):
         self.assertEqual(response.status_code, 200, 'should be 200 OK status')
 
         # check other columns have been populated correctly
-        self.assertEqual(row1['name'], self.recipe1.name)
-        self.assertEqual(row1['version'], self.recipe1.version)
-        self.assertEqual(row1['get_description_or_summary'],
-                         self.recipe1.description)
-        self.assertEqual(row1['layer_version__layer__name'],
-                         self.recipe1.layer_version.layer.name)
-        self.assertEqual(row2['name'], self.recipe2.name)
-        self.assertEqual(row2['version'], self.recipe2.version)
-        self.assertEqual(row2['get_description_or_summary'],
-                         self.recipe2.description)
-        self.assertEqual(row2['layer_version__layer__name'],
-                         self.recipe2.layer_version.layer.name)
+        self.assertTrue(self.recipe1.name in row1['name'])
+        self.assertTrue(self.recipe1.version in row1['version'])
+        self.assertTrue(self.recipe1.description in
+                        row1['get_description_or_summary'])
+
+        self.assertTrue(self.recipe1.layer_version.layer.name in
+                        row1['layer_version__layer__name'])
+
+        self.assertTrue(self.recipe2.name in row2['name'])
+        self.assertTrue(self.recipe2.version in row2['version'])
+        self.assertTrue(self.recipe2.description in
+                        row2['get_description_or_summary'])
+
+        self.assertTrue(self.recipe2.layer_version.layer.name in
+                        row2['layer_version__layer__name'])
 
     def test_toaster_tables(self):
         """Test all ToasterTables instances"""
-        current_recipes = self.project.get_available_recipes()
 
         def get_data(table, options={}):
             """Send a request and parse the json response"""
@@ -354,12 +360,30 @@ class ViewTests(TestCase):
                     'layerid': self.lver.pk,
                     'recipeid': self.recipe1.pk,
                     'recipe_id': image_recipe.pk,
-                    'custrecipeid': self.customr.pk
-                   }
+                    'custrecipeid': self.customr.pk}
 
             response = table.get(request, **args)
             return json.loads(response.content)
 
+        def get_text_from_td(td):
+            """If we have html in the td then extract the text portion"""
+            # just so we don't waste time parsing non html
+            if "<" not in td:
+                ret = td
+            else:
+                ret = BeautifulSoup(td).text
+
+            # We change the td into ascii as a way to remove characters
+            # such as \xa0 (non break space) which mess with the ordering
+            # comparisons
+            ret.strip().encode('ascii',
+                               errors='replace').replace('?', ' ')
+            # Case where the td is empty
+            if len(ret):
+                return "0"
+            else:
+                return ret
+
         # Get a list of classes in tables module
         tables = inspect.getmembers(toastergui.tables, inspect.isclass)
 
@@ -379,8 +403,10 @@ class ViewTests(TestCase):
                             "Cannot test on a %s table with < 1 row" % name)
 
             if table.default_orderby:
-                row_one = all_data['rows'][0][table.default_orderby.strip("-")]
-                row_two = all_data['rows'][1][table.default_orderby.strip("-")]
+                row_one = get_text_from_td(
+                    all_data['rows'][0][table.default_orderby.strip("-")])
+                row_two = get_text_from_td(
+                    all_data['rows'][1][table.default_orderby.strip("-")])
 
                 if '-' in table.default_orderby:
                     self.assertTrue(row_one >= row_two,
@@ -399,28 +425,36 @@ class ViewTests(TestCase):
                     # If a column is orderable test it in both order
                     # directions ordering on the columns field_name
                     ascending = get_data(table_cls(),
-                                         {"orderby" : column['field_name']})
+                                         {"orderby": column['field_name']})
 
-                    row_one = ascending['rows'][0][column['field_name']]
-                    row_two = ascending['rows'][1][column['field_name']]
+                    row_one = get_text_from_td(
+                        ascending['rows'][0][column['field_name']])
+                    row_two = get_text_from_td(
+                        ascending['rows'][1][column['field_name']])
 
                     self.assertTrue(row_one <= row_two,
-                                    "Ascending sort applied but row 0 is less "
-                                    "than row 1 %s %s " %
-                                    (column['field_name'], name))
-
+                                    "Ascending sort applied but row 0: \"%s\""
+                                    " is less than row 1: \"%s\" "
+                                    "%s %s " %
+                                    (row_one, row_two,
+                                     column['field_name'], name))
 
                     descending = get_data(table_cls(),
-                                          {"orderby" :
+                                          {"orderby":
                                            '-'+column['field_name']})
 
-                    row_one = descending['rows'][0][column['field_name']]
-                    row_two = descending['rows'][1][column['field_name']]
+                    row_one = get_text_from_td(
+                        descending['rows'][0][column['field_name']])
+                    row_two = get_text_from_td(
+                        descending['rows'][1][column['field_name']])
 
                     self.assertTrue(row_one >= row_two,
-                                    "Descending sort applied but row 0 is "
-                                    "greater than row 1 %s %s" %
-                                    (column['field_name'], name))
+                                    "Descending sort applied but row 0: %s"
+                                    "is greater than row 1: %s"
+                                    "field %s table %s" %
+                                    (row_one,
+                                     row_two,
+                                     column['field_name'], name))
 
                     # If the two start rows are the same we haven't actually
                     # changed the order
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


