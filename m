Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 139EA76FD7
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 13:22:46 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 07 Oct 2015 06:22:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,649,1437462000"; d="scan'208";a="821409342"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 07 Oct 2015 06:22:47 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 225C76A4083;
	Wed,  7 Oct 2015 06:21:48 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 16:20:52 +0300
Message-Id: <1f5cbdb2bbf847611cc24e00979753c73565a6b3.1444223946.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <b8bbed3da4991f25019c6e0319fb5880b7f403bd.1444223946.git.ed.bartosh@linux.intel.com>
References: <b8bbed3da4991f25019c6e0319fb5880b7f403bd.1444223946.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1444223946.git.ed.bartosh@linux.intel.com>
References: <cover.1444223946.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 07/10] toaster: More linting of tests
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
X-List-Received-Date: Wed, 07 Oct 2015 13:22:47 -0000

From: Elliot Smith <elliot.smith@intel.com>

Fix some more lint errors on the tests for toastergui.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/tests.py | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 1e67d1a..7078c9a 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -433,6 +433,18 @@ class AllProjectsPageTests(TestCase):
 
     MACHINE_NAME = 'delorean'
 
+    def setUp(self):
+        """ Add default project manually """
+        project = Project.objects.create_project(CLI_BUILDS_PROJECT_NAME, None)
+        self.default_project = project
+        self.default_project.is_default = True
+        self.default_project.save()
+
+        # this project is only set for some of the tests
+        self.project = None
+
+        self.release = None
+
     def _add_build_to_default_project(self):
         """ Add a build to the default project (not used in all tests) """
         now = timezone.now()
@@ -458,16 +470,6 @@ class AllProjectsPageTests(TestCase):
                                                      value=self.MACHINE_NAME)
         project_var.save()
 
-    def setUp(self):
-        """ Add default project manually """
-        project = Project.objects.create_project(CLI_BUILDS_PROJECT_NAME, None)
-        self.default_project = project
-        self.default_project.is_default = True
-        self.default_project.save()
-
-        # this project is only set for some of the tests
-        self.project = None
-
     def test_default_project_hidden(self):
         """ The default project should be hidden if it has no builds """
         params = {"count": 10, "orderby": "updated:-", "page": 1}
@@ -573,17 +575,15 @@ class AllProjectsPageTests(TestCase):
         # link for default project
         row = soup.find('tr', attrs={'data-project': self.default_project.id})
         cell = row.find('td', attrs={'data-project-field': 'name'})
-        url = cell.find('a')['href']
         expected_url = reverse('projectbuilds', args=(self.default_project.id,))
-        self.assertEqual(url, expected_url,
+        self.assertEqual(cell.find('a')['href'], expected_url,
                          'link on default project name should point to builds')
 
         # link for other project
         row = soup.find('tr', attrs={'data-project': self.project.id})
         cell = row.find('td', attrs={'data-project-field': 'name'})
-        url = cell.find('a')['href']
         expected_url = reverse('project', args=(self.project.id,))
-        self.assertEqual(url, expected_url,
+        self.assertEqual(cell.find('a')['href'], expected_url,
                          'link on project name should point to configuration')
 
 class ProjectBuildsPageTests(TestCase):
@@ -640,13 +640,6 @@ class ProjectBuildsPageTests(TestCase):
             "outcome": Build.IN_PROGRESS
         }
 
-        self.default_project_build_success = {
-            "project": self.default_project,
-            "started_on": now,
-            "completed_on": now,
-            "outcome": Build.SUCCEEDED
-        }
-
     def _get_rows_for_project(self, project_id):
         """ Helper to retrieve HTML rows for a project """
         url = reverse("projectbuilds", args=(project_id,))
-- 
2.1.4


