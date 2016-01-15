Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id BA74776A51
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:34 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 15 Jan 2016 04:58:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="861139117"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 15 Jan 2016 04:58:37 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 0972A6A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:31 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:01:05 +0200
Message-Id: <8d598f21d8c2d209dff7f14453971c376669df3c.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 22/23] toaster: tests: fix Django tests for new ToasterTable pages
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
X-List-Received-Date: Fri, 15 Jan 2016 12:58:35 -0000

From: Elliot Smith <elliot.smith@intel.com>

The Django command-line tests can no longer test the content
of the projects/, builds/ and projectbuilds/ pages, as
ToasterTable pages are populated by JavaScript.

Fix/remove affected tests by converting them to tests on the
JSON returned by the ToasterTable.

[YOCTO #8738]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/tests.py | 265 +++++++++++++++++++++++++++-------------
 1 file changed, 180 insertions(+), 85 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index c927fe1..0987721 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -38,11 +38,14 @@ import toastergui
 
 from toastergui.tables import SoftwareRecipesTable
 import json
+from datetime import timedelta
 from bs4 import BeautifulSoup
 import re
 import string
+import json
 
 PROJECT_NAME = "test project"
+PROJECT_NAME2 = "test project 2"
 CLI_BUILDS_PROJECT_NAME = 'Command line builds'
 
 class ViewTests(TestCase):
@@ -54,14 +57,46 @@ class ViewTests(TestCase):
         release = Release.objects.create(name="test release",
                                          branch_name="master",
                                          bitbake_version=bbv)
+        release2 = Release.objects.create(name="test release 2",
+                                          branch_name="master",
+                                          bitbake_version=bbv)
+
         self.project = Project.objects.create_project(name=PROJECT_NAME,
                                                       release=release)
+
+        self.project2 = Project.objects.create_project(name=PROJECT_NAME2,
+                                                       release=release2)
+
         now = timezone.now()
+        later = now + timedelta(days=1)
 
         build = Build.objects.create(project=self.project,
                                      started_on=now,
                                      completed_on=now)
 
+        # for testing BuildsTable
+        build1 = Build.objects.create(project=self.project,
+                                      started_on=now,
+                                      completed_on=now,
+                                      outcome=Build.SUCCEEDED,
+                                      machine="raspberrypi2")
+
+        Build.objects.create(project=self.project,
+                             started_on=later,
+                             completed_on=later,
+                             outcome=Build.FAILED,
+                             machine="qemux86")
+
+        Build.objects.create(project=self.project2,
+                             started_on=later,
+                             completed_on=later,
+                             outcome=Build.SUCCEEDED,
+                             machine="qemux86")
+
+        # to test sorting by errors and warnings in BuildsTable
+        LogMessage.objects.create(build=build1, level=LogMessage.WARNING)
+        LogMessage.objects.create(build=build1, level=LogMessage.ERROR)
+
         layersrc = LayerSource.objects.create(sourcetype=LayerSource.TYPE_IMPORTED)
         self.priority = ReleaseLayerSourcePriority.objects.create(release=release,
                                                                   layer_source=layersrc)
@@ -172,8 +207,7 @@ class ViewTests(TestCase):
         response = self.client.get(reverse('all-projects'), follow=True)
         self.assertEqual(response.status_code, 200)
         self.assertTrue(response['Content-Type'].startswith('text/html'))
-        self.assertTemplateUsed(response, "projects.html")
-        self.assertTrue(PROJECT_NAME in response.content)
+        self.assertTemplateUsed(response, "projects-toastertable.html")
 
     def test_get_json_call_returns_json(self):
         """Test for all projects output in json format"""
@@ -191,13 +225,6 @@ class ViewTests(TestCase):
         self.assertTrue(PROJECT_NAME in [x["name"] for x in data["rows"]])
         self.assertTrue("id" in data["rows"][0])
 
-        self.assertEqual(sorted(data["rows"][0]),
-                         ['bitbake_version_id', 'created', 'id',
-                          'is_default', 'layersTypeAheadUrl', 'name',
-                          'num_builds', 'projectBuildsUrl', 'projectPageUrl',
-                          'recipesTypeAheadUrl', 'release_id',
-                          'short_description', 'updated', 'user_id'])
-
     def test_typeaheads(self):
         """Test typeahead ReST API"""
         layers_url = reverse('xhr_layerstypeahead', args=(self.project.id,))
@@ -450,7 +477,7 @@ class ViewTests(TestCase):
             all_data = get_data(table)
 
             self.assertTrue(len(all_data['rows']) > 1,
-                            "Cannot test on a table with < 1 row")
+                            "Cannot test on the table %s with < 1 row" % name)
 
             if table.default_orderby:
                 row_one = all_data['rows'][0][table.default_orderby.strip("-")]
@@ -512,16 +539,20 @@ class ViewTests(TestCase):
                         # This is the name of the filter:action
                         # e.g. project_filter:not_in_project
                         filter_string = "%s:%s" % (column['filter_name'],
-                                                   filter_action['name'])
+                                                   filter_action['action_name'])
                         # Now get the data with the filter applied
                         filtered_data = get_data(table_cls(),
                                                  {"filter" : filter_string})
-                        self.assertEqual(len(filtered_data['rows']),
-                                         int(filter_action['count']),
-                                         "We added a table filter for %s but "
-                                         "the number of rows returned was not "
-                                         "what the filter info said there "
-                                         "would be" % name)
+
+                        # date range filter actions can't specify the
+                        # number of results they return, so their count is 0
+                        if filter_action['count'] != None:
+                            self.assertEqual(len(filtered_data['rows']),
+                                             int(filter_action['count']),
+                                             "We added a table filter for %s but "
+                                             "the number of rows returned was not "
+                                             "what the filter info said there "
+                                             "would be" % name)
 
 
             # Test search functionality on the table
@@ -673,6 +704,10 @@ class AllProjectsPageTests(TestCase):
                                                      value=self.MACHINE_NAME)
         project_var.save()
 
+    def _get_row_for_project(self, data, project_id):
+        """ Get the object representing the table data for a project """
+        return [row for row in data['rows'] if row['id'] == project_id][0]
+
     def test_default_project_hidden(self):
         """ The default project should be hidden if it has no builds """
         params = {"count": 10, "orderby": "updated:-", "page": 1}
@@ -688,11 +723,20 @@ class AllProjectsPageTests(TestCase):
         self._add_build_to_default_project()
 
         params = {"count": 10, "orderby": "updated:-", "page": 1}
-        response = self.client.get(reverse('all-projects'), params)
 
-        self.assertTrue('tr class="data"' in response.content,
-                        'should be a project row in the page')
-        self.assertTrue(CLI_BUILDS_PROJECT_NAME in response.content,
+        response = self.client.get(
+            reverse('all-projects'),
+            {'format': 'json'},
+            params
+        )
+
+        data = json.loads(response.content)
+
+        # find the row for the default project
+        default_project_row = self._get_row_for_project(data, self.default_project.id)
+
+        # check its name template has the correct text
+        self.assertEqual(default_project_row['name'], CLI_BUILDS_PROJECT_NAME,
                         'default project "cli builds" should be in page')
 
     def test_default_project_release(self):
@@ -706,24 +750,32 @@ class AllProjectsPageTests(TestCase):
         # another project to test, which should show release
         self._add_non_default_project()
 
-        response = self.client.get(reverse('all-projects'), follow=True)
-        soup = BeautifulSoup(response.content)
+        response = self.client.get(
+            reverse('all-projects'),
+            {'format': 'json'},
+            follow=True
+        )
 
-        # check the release cell for the default project
-        attrs = {'data-project': str(self.default_project.id)}
-        rows = soup.find_all('tr', attrs=attrs)
-        self.assertEqual(len(rows), 1, 'should be one row for default project')
-        cells = rows[0].find_all('td', attrs={'data-project-field': 'release'})
-        self.assertEqual(len(cells), 1, 'should be one release cell')
-        text = cells[0].select('span.muted')[0].text
+        data = json.loads(response.content)
+
+        # used to find the correct span in the template output
+        attrs = {'data-project-field': 'release'}
+
+        # find the row for the default project
+        default_project_row = self._get_row_for_project(data, self.default_project.id)
+
+        # check the release text for the default project
+        soup = BeautifulSoup(default_project_row['static:release'])
+        text = soup.find('span', attrs=attrs).select('span.muted')[0].text
         self.assertEqual(text, 'Not applicable',
                          'release should be not applicable for default project')
 
+        # find the row for the default project
+        other_project_row = self._get_row_for_project(data, self.project.id)
+
         # check the link in the release cell for the other project
-        attrs = {'data-project': str(self.project.id)}
-        rows = soup.find_all('tr', attrs=attrs)
-        cells = rows[0].find_all('td', attrs={'data-project-field': 'release'})
-        text = cells[0].select('a')[0].text
+        soup = BeautifulSoup(other_project_row['static:release'])
+        text = soup.find('span', attrs=attrs).select('a')[0].text.strip()
         self.assertEqual(text, self.release.name,
                          'release name should be shown for non-default project')
 
@@ -738,24 +790,32 @@ class AllProjectsPageTests(TestCase):
         # another project to test, which should show machine
         self._add_non_default_project()
 
-        response = self.client.get(reverse('all-projects'), follow=True)
-        soup = BeautifulSoup(response.content)
+        response = self.client.get(
+            reverse('all-projects'),
+            {'format': 'json'},
+            follow=True
+        )
+
+        data = json.loads(response.content)
+
+        # used to find the correct span in the template output
+        attrs = {'data-project-field': 'machine'}
+
+        # find the row for the default project
+        default_project_row = self._get_row_for_project(data, self.default_project.id)
 
         # check the machine cell for the default project
-        attrs = {'data-project': str(self.default_project.id)}
-        rows = soup.find_all('tr', attrs=attrs)
-        self.assertEqual(len(rows), 1, 'should be one row for default project')
-        cells = rows[0].find_all('td', attrs={'data-project-field': 'machine'})
-        self.assertEqual(len(cells), 1, 'should be one machine cell')
-        text = cells[0].select('span.muted')[0].text
+        soup = BeautifulSoup(default_project_row['static:machine'])
+        text = soup.find('span', attrs=attrs).select('span.muted')[0].text.strip()
         self.assertEqual(text, 'Not applicable',
-                         'machine should be not applicable for default project')
+            'machine should be not applicable for default project')
+
+        # find the row for the default project
+        other_project_row = self._get_row_for_project(data, self.project.id)
 
         # check the link in the machine cell for the other project
-        attrs = {'data-project': str(self.project.id)}
-        rows = soup.find_all('tr', attrs=attrs)
-        cells = rows[0].find_all('td', attrs={'data-project-field': 'machine'})
-        text = cells[0].select('a')[0].text
+        soup = BeautifulSoup(other_project_row['static:machine'])
+        text = soup.find('span', attrs=attrs).find('a').text.strip()
         self.assertEqual(text, self.MACHINE_NAME,
                          'machine name should be shown for non-default project')
 
@@ -769,24 +829,33 @@ class AllProjectsPageTests(TestCase):
         # need a build, otherwise project doesn't display at all
         self._add_build_to_default_project()
 
-        # another project to test, which should show machine
+        # another project to test
         self._add_non_default_project()
 
-        response = self.client.get(reverse('all-projects'), follow=True)
-        soup = BeautifulSoup(response.content)
+        response = self.client.get(
+            reverse('all-projects'),
+            {'format': 'json'},
+            follow=True
+        )
+
+        data = json.loads(response.content)
 
-        # link for default project
-        row = soup.find('tr', attrs={'data-project': self.default_project.id})
-        cell = row.find('td', attrs={'data-project-field': 'name'})
+        # find the row for the default project
+        default_project_row = self._get_row_for_project(data, self.default_project.id)
+
+        # check the link on the name field
+        soup = BeautifulSoup(default_project_row['static:name'])
         expected_url = reverse('projectbuilds', args=(self.default_project.id,))
-        self.assertEqual(cell.find('a')['href'], expected_url,
+        self.assertEqual(soup.find('a')['href'], expected_url,
                          'link on default project name should point to builds')
 
-        # link for other project
-        row = soup.find('tr', attrs={'data-project': self.project.id})
-        cell = row.find('td', attrs={'data-project-field': 'name'})
+        # find the row for the other project
+        other_project_row = self._get_row_for_project(data, self.project.id)
+
+        # check the link for the other project
+        soup = BeautifulSoup(other_project_row['static:name'])
         expected_url = reverse('project', args=(self.project.id,))
-        self.assertEqual(cell.find('a')['href'], expected_url,
+        self.assertEqual(soup.find('a')['href'], expected_url,
                          'link on project name should point to configuration')
 
 class ProjectBuildsPageTests(TestCase):
@@ -846,9 +915,9 @@ class ProjectBuildsPageTests(TestCase):
     def _get_rows_for_project(self, project_id):
         """ Helper to retrieve HTML rows for a project """
         url = reverse("projectbuilds", args=(project_id,))
-        response = self.client.get(url, follow=True)
-        soup = BeautifulSoup(response.content)
-        return soup.select('tr[class="data"]')
+        response = self.client.get(url, {'format': 'json'}, follow=True)
+        data = json.loads(response.content)
+        return data['rows']
 
     def test_show_builds_for_project(self):
         """ Builds for a project should be displayed """
@@ -889,10 +958,14 @@ class ProjectBuildsPageTests(TestCase):
         """ Task should be shown as suffix on build name """
         build = Build.objects.create(**self.project1_build_success)
         Target.objects.create(build=build, target='bash', task='clean')
-        url = reverse("projectbuilds", args=(self.project1.id,))
-        response = self.client.get(url, follow=True)
-        result = re.findall('^ +bash:clean$', response.content, re.MULTILINE)
-        self.assertEqual(len(result), 2)
+
+        url = reverse('projectbuilds', args=(self.project1.id,))
+        response = self.client.get(url, {'format': 'json'}, follow=True)
+        data = json.loads(response.content)
+        cell = data['rows'][0]['static:target']
+
+        result = re.findall('^ +bash:clean', cell, re.MULTILINE)
+        self.assertEqual(len(result), 1)
 
     def test_cli_builds_hides_tabs(self):
         """
@@ -952,32 +1025,46 @@ class AllBuildsPageTests(TestCase):
             "outcome": Build.SUCCEEDED
         }
 
+    def _get_row_for_build(self, data, build_id):
+        """ Get the object representing the table data for a project """
+        return [row for row in data['rows']
+                    if row['id'] == build_id][0]
+
     def test_show_tasks_in_allbuilds(self):
         """ Task should be shown as suffix on build name """
         build = Build.objects.create(**self.project1_build_success)
         Target.objects.create(build=build, target='bash', task='clean')
+
         url = reverse('all-builds')
-        response = self.client.get(url, follow=True)
-        result = re.findall('bash:clean', response.content, re.MULTILINE)
-        self.assertEqual(len(result), 3)
+        response = self.client.get(url, {'format': 'json'}, follow=True)
+        data = json.loads(response.content)
+        cell = data['rows'][0]['static:target']
 
-    def test_no_run_again_for_cli_build(self):
-        """ "Run again" button should not be shown for command-line builds """
-        build = Build.objects.create(**self.default_project_build_success)
+        result = re.findall('bash:clean', cell, re.MULTILINE)
+        self.assertEqual(len(result), 1)
+
+    def test_run_again(self):
+        """
+        "Run again" button should not be shown for command-line builds,
+        but should be shown for other builds
+        """
+        build1 = Build.objects.create(**self.project1_build_success)
+        default_build = Build.objects.create(**self.default_project_build_success)
         url = reverse('all-builds')
         response = self.client.get(url, follow=True)
         soup = BeautifulSoup(response.content)
 
-        attrs = {'data-latest-build-result': build.id}
-        result = soup.find('div', attrs=attrs)
-
         # shouldn't see a run again button for command-line builds
+        attrs = {'data-latest-build-result': default_build.id}
+        result = soup.find('div', attrs=attrs)
         run_again_button = result.select('button')
         self.assertEqual(len(run_again_button), 0)
 
-        # should see a help icon for command-line builds
-        help_icon = result.select('i.get-help-green')
-        self.assertEqual(len(help_icon), 1)
+        # should see a run again button for non-command-line builds
+        attrs = {'data-latest-build-result': build1.id}
+        result = soup.find('div', attrs=attrs)
+        run_again_button = result.select('button')
+        self.assertEqual(len(run_again_button), 1)
 
     def test_tooltips_on_project_name(self):
         """
@@ -989,20 +1076,28 @@ class AllBuildsPageTests(TestCase):
         default_build = Build.objects.create(**self.default_project_build_success)
 
         url = reverse('all-builds')
-        response = self.client.get(url, follow=True)
-        soup = BeautifulSoup(response.content)
+        response = self.client.get(url, {'format': 'json'}, follow=True)
+        data = json.loads(response.content)
+
+        # get the data row for the non-command-line builds project
+        other_project_row = self._get_row_for_build(data, build1.id)
+
+        # make sure there is some HTML
+        soup = BeautifulSoup(other_project_row['static:project'])
+        self.assertEqual(len(soup.select('a')), 1,
+                         'should be a project name link')
 
         # no help icon on non-default project name
-        result = soup.find('tr', attrs={'data-table-build-result': build1.id})
-        name = result.select('td.project-name')[0]
-        icons = name.select('i.get-help')
+        icons = soup.select('i.get-help')
         self.assertEqual(len(icons), 0,
                          'should not be a help icon for non-cli builds name')
 
+        # get the data row for the command-line builds project
+        default_project_row = self._get_row_for_build(data, default_build.id)
+
         # help icon on default project name
-        result = soup.find('tr', attrs={'data-table-build-result': default_build.id})
-        name = result.select('td.project-name')[0]
-        icons = name.select('i.get-help')
+        soup = BeautifulSoup(default_project_row['static:project'])
+        icons = soup.select('i.get-help')
         self.assertEqual(len(icons), 1,
                          'should be a help icon for cli builds name')
 
-- 
2.1.4


