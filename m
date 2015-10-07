Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id F21D876AC5
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 13:21:18 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga102.fm.intel.com with ESMTP; 07 Oct 2015 06:21:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,649,1437462000"; d="scan'208";a="821305544"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 07 Oct 2015 06:21:12 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 188D56A4083;
	Wed,  7 Oct 2015 06:20:12 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 16:20:46 +0300
Message-Id: <b8bbed3da4991f25019c6e0319fb5880b7f403bd.1444223946.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1444223946.git.ed.bartosh@linux.intel.com>
References: <cover.1444223946.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 01/10] toaster: Reorganise and lint tests
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
X-List-Received-Date: Wed, 07 Oct 2015 13:21:19 -0000

From: Elliot Smith <elliot.smith@intel.com>

Get test suite ready to accommodate new tests for how command line
builds are shown on various pages.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/tests.py | 83 ++++++++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 34 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 95790a2..7b1f9b5 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -21,23 +21,20 @@
 
 """Test cases for Toaster GUI and ReST."""
 
-import re
-
 from django.test import TestCase
 from django.test.client import RequestFactory
 from django.core.urlresolvers import reverse
 from django.utils import timezone
 
-from orm.models import Project, Release, BitbakeVersion, Build, Package
+from orm.models import Project, Release, BitbakeVersion, Package
 from orm.models import ReleaseLayerSourcePriority, LayerSource, Layer, Build
 from orm.models import Layer_Version, Recipe, Machine, ProjectLayer, Target
 from orm.models import CustomImageRecipe
 from orm.models import Branch
 
 from toastergui.tables import SoftwareRecipesTable
-from django.utils import timezone
-import json
 from bs4 import BeautifulSoup
+import json
 import re
 
 PROJECT_NAME = "test project"
@@ -72,11 +69,11 @@ class ViewTests(TestCase):
                                             up_branch=branch)
 
         self.recipe1 = Recipe.objects.create(layer_source=layersrc,
-                                       name="base-recipe",
-                                       version="1.2",
-                                       summary="one recipe",
-                                       description="recipe",
-                                       layer_version=lver)
+                                             name="base-recipe",
+                                             version="1.2",
+                                             summary="one recipe",
+                                             description="recipe",
+                                             layer_version=lver)
 
         Machine.objects.create(layer_version=lver, name="wisk",
                                description="wisking machine")
@@ -337,11 +334,7 @@ class ViewTests(TestCase):
 
         rows = data['rows']
         row1 = next(x for x in rows if x['name'] == self.recipe1.name)
-        row1_btns = row1['static:add-del-layers']
-        row1_btns_data = row1['add-del-layers']
         row2 = next(x for x in rows if x['name'] == self.recipe2.name)
-        row2_btns = row2['static:add-del-layers']
-        row2_btns_data = row2['add-del-layers']
 
         self.assertEqual(response.status_code, 200, 'should be 200 OK status')
         self.assertEqual(len(rows), 2, 'should be 2 recipes')
@@ -472,7 +465,7 @@ class ProjectsPageTests(TestCase):
         self.assertTrue(self.PROJECT_NAME in response.content,
                         'default project "cli builds" should be in page')
 
-class ProjectBuildsDisplayTest(TestCase):
+class ProjectBuildsPageTests(TestCase):
     """ Test data at /project/X/builds is displayed correctly """
 
     def setUp(self):
@@ -517,6 +510,7 @@ class ProjectBuildsDisplayTest(TestCase):
         }
 
     def _get_rows_for_project(self, project_id):
+        """ Helper to retrieve HTML rows for a project """
         url = reverse("projectbuilds", args=(project_id,))
         response = self.client.get(url, follow=True)
         soup = BeautifulSoup(response.content)
@@ -524,52 +518,73 @@ class ProjectBuildsDisplayTest(TestCase):
 
     def test_show_builds_for_project(self):
         """ Builds for a project should be displayed """
-        build1a = Build.objects.create(**self.project1_build_success)
-        build1b = Build.objects.create(**self.project1_build_success)
+        Build.objects.create(**self.project1_build_success)
+        Build.objects.create(**self.project1_build_success)
         build_rows = self._get_rows_for_project(self.project1.id)
         self.assertEqual(len(build_rows), 2)
 
-    def test_show_builds_for_project_only(self):
+    def test_show_builds_project_only(self):
         """ Builds for other projects should be excluded """
-        build1a = Build.objects.create(**self.project1_build_success)
-        build1b = Build.objects.create(**self.project1_build_success)
-        build1c = Build.objects.create(**self.project1_build_success)
+        Build.objects.create(**self.project1_build_success)
+        Build.objects.create(**self.project1_build_success)
+        Build.objects.create(**self.project1_build_success)
 
         # shouldn't see these two
-        build2a = Build.objects.create(**self.project2_build_success)
-        build2b = Build.objects.create(**self.project2_build_in_progress)
+        Build.objects.create(**self.project2_build_success)
+        Build.objects.create(**self.project2_build_in_progress)
 
         build_rows = self._get_rows_for_project(self.project1.id)
         self.assertEqual(len(build_rows), 3)
 
-    def test_show_builds_exclude_in_progress(self):
+    def test_builds_exclude_in_progress(self):
         """ "in progress" builds should not be shown """
-        build1a = Build.objects.create(**self.project1_build_success)
-        build1b = Build.objects.create(**self.project1_build_success)
+        Build.objects.create(**self.project1_build_success)
+        Build.objects.create(**self.project1_build_success)
 
         # shouldn't see this one
-        build1c = Build.objects.create(**self.project1_build_in_progress)
+        Build.objects.create(**self.project1_build_in_progress)
 
         # shouldn't see these two either, as they belong to a different project
-        build2a = Build.objects.create(**self.project2_build_success)
-        build2b = Build.objects.create(**self.project2_build_in_progress)
+        Build.objects.create(**self.project2_build_success)
+        Build.objects.create(**self.project2_build_in_progress)
 
         build_rows = self._get_rows_for_project(self.project1.id)
         self.assertEqual(len(build_rows), 2)
 
-    def test_show_tasks_in_projectbuilds(self):
+    def test_tasks_in_projectbuilds(self):
+        """ Task should be shown as suffix on build name """
         build = Build.objects.create(**self.project1_build_success)
-        target = Target.objects.create(build=build, target='bash',
-                                       task='clean')
+        Target.objects.create(build=build, target='bash', task='clean')
         url = reverse("projectbuilds", args=(self.project1.id,))
         response = self.client.get(url, follow=True)
         result = re.findall('^ +bash:clean$', response.content, re.MULTILINE)
         self.assertEqual(len(result), 2)
 
+class AllBuildsPageTests(TestCase):
+    """ Tests for all builds page """
+
+    def setUp(self):
+        bbv = BitbakeVersion.objects.create(name="bbv1", giturl="/tmp/",
+                                            branch="master", dirpath="")
+        release = Release.objects.create(name="release1",
+                                         bitbake_version=bbv)
+        self.project1 = Project.objects.create_project(name=PROJECT_NAME,
+                                                       release=release)
+
+        # parameters for builds to associate with the projects
+        now = timezone.now()
+
+        self.project1_build_success = {
+            "project": self.project1,
+            "started_on": now,
+            "completed_on": now,
+            "outcome": Build.SUCCEEDED
+        }
+
     def test_show_tasks_in_allbuilds(self):
+        """ Task should be shown as suffix on build name """
         build = Build.objects.create(**self.project1_build_success)
-        target = Target.objects.create(build=build, target='bash',
-                                       task='clean')
+        Target.objects.create(build=build, target='bash', task='clean')
         url = reverse("all-builds")
         response = self.client.get(url, follow=True)
         result = re.findall('bash:clean', response.content, re.MULTILINE)
-- 
2.1.4


