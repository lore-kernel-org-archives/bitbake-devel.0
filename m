Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id C8E8076AE8
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 13:21:47 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga102.fm.intel.com with ESMTP; 07 Oct 2015 06:21:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,649,1437462000"; d="scan'208";a="575844097"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 07 Oct 2015 06:21:47 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id E50616A4083;
	Wed,  7 Oct 2015 06:20:46 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 16:20:48 +0300
Message-Id: <65fcdfeab12e129a1e9913c897095af8fa1cad49.1444223946.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <b8bbed3da4991f25019c6e0319fb5880b7f403bd.1444223946.git.ed.bartosh@linux.intel.com>
References: <b8bbed3da4991f25019c6e0319fb5880b7f403bd.1444223946.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1444223946.git.ed.bartosh@linux.intel.com>
References: <cover.1444223946.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 03/10] toaster: Show 'not applicable' for default project machine and release
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
X-List-Received-Date: Wed, 07 Oct 2015 13:21:48 -0000

From: Elliot Smith <elliot.smith@intel.com>

The machine and release for the default project should show as
'not applicable' on the all projects page, as that information
isn't available for command-line builds.

Modify the templates with some conditionals to check for the
default project row, plus some data-* attributes to mark
where that data is to make testing possible.

Add some tests for the all projects page to ensure that
the correct machine/release are still shown for non-default projects,
and 'not applicable' for the default project.

[YOCTO #8231]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/templates/projects.html |  16 +++-
 lib/toaster/toastergui/tests.py                | 108 ++++++++++++++++++++++---
 2 files changed, 111 insertions(+), 13 deletions(-)

diff --git a/lib/toaster/toastergui/templates/projects.html b/lib/toaster/toastergui/templates/projects.html
index c2d77b5..a7192c2 100644
--- a/lib/toaster/toastergui/templates/projects.html
+++ b/lib/toaster/toastergui/templates/projects.html
@@ -36,17 +36,27 @@
   {% else %} {# We have builds to display #}
   {% include "basetable_top.html" %}
   {% for o in objects %}
-    <tr class="data">
+    <tr class="data" data-project="{{ o.id }}">
       <td><a href="{% url 'project' o.id %}">{{o.name}}</a></td>
       <td class="updated"><a href="{% url 'project' o.id %}">{{o.updated|date:"d/m/y H:i"}}</a></td>
-      <td>
+      <td data-project-field="release">
         {% if o.release %}
             <a href="{% url 'project' o.id %}#project-details">{{o.release.name}}</a>
+        {% elif o.is_default %}
+            <span class="muted">Not applicable</span>
+            <i class="icon-question-sign get-help hover-help" title="" data-original-title="This project does not have a release set. It simply collects information about the builds you start from the command line while Toaster is running" style="visibility: hidden;"></i>
         {% else %}
             No release available
         {% endif %}
       </td>
-      <td><a href="{% url 'project' o.id %}#machine-distro">{{o.get_current_machine_name}}</a></td>
+      <td data-project-field="machine">
+        {% if o.is_default %}
+            <span class="muted">Not applicable</span>
+            <i class="icon-question-sign get-help hover-help" title="" data-original-title="This project does not have a machine set. It simply collects information about the builds you start from the command line while Toaster is running" style="visibility: hidden;"></i>
+        {% else %}
+            <a href="{% url 'project' o.id %}#machine-distro">{{o.get_current_machine_name}}</a>
+        {% endif %}
+      </td>
       {% if o.get_number_of_builds == 0 %}
       <td class="muted">{{o.get_number_of_builds}}</td>
       <td class="loutcome"></td>
diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 00ae9d4..0b85d4f 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -29,7 +29,7 @@ from django.utils import timezone
 from orm.models import Project, Release, BitbakeVersion, Package
 from orm.models import ReleaseLayerSourcePriority, LayerSource, Layer, Build
 from orm.models import Layer_Version, Recipe, Machine, ProjectLayer, Target
-from orm.models import CustomImageRecipe
+from orm.models import CustomImageRecipe, ProjectVariable
 from orm.models import Branch
 
 from toastergui.tables import SoftwareRecipesTable
@@ -431,15 +431,43 @@ class LandingPageTests(TestCase):
 class ProjectsPageTests(TestCase):
     """ Tests for projects page """
 
-    PROJECT_NAME = 'cli builds'
+    MACHINE_NAME = 'delorean'
+
+    def _add_build_to_default_project(self):
+        """ Add a build to the default project (not used in all tests) """
+        now = timezone.now()
+        build = Build.objects.create(project=self.default_project,
+                                     started_on=now,
+                                     completed_on=now)
+        build.save()
+
+    def _add_non_default_project(self):
+        """ Add another project """
+        bbv = BitbakeVersion.objects.create(name="test bbv", giturl="/tmp/",
+                                            branch="master", dirpath="")
+        self.release = Release.objects.create(name="test release",
+                                              branch_name="master",
+                                              bitbake_version=bbv)
+        self.project = Project.objects.create_project(PROJECT_NAME, self.release)
+        self.project.is_default = False
+        self.project.save()
+
+        # fake the MACHINE variable
+        project_var = ProjectVariable.objects.create(project=self.project,
+                                                     name='MACHINE',
+                                                     value=self.MACHINE_NAME)
+        project_var.save()
 
     def setUp(self):
         """ Add default project manually """
-        project = Project.objects.create_project(self.PROJECT_NAME, None)
+        project = Project.objects.create_project(CLI_BUILDS_PROJECT_NAME, None)
         self.default_project = project
         self.default_project.is_default = True
         self.default_project.save()
 
+        # this project is only set for some of the tests
+        self.project = None
+
     def test_default_project_hidden(self):
         """ The default project should be hidden if it has no builds """
         params = {"count": 10, "orderby": "updated:-", "page": 1}
@@ -447,25 +475,85 @@ class ProjectsPageTests(TestCase):
 
         self.assertTrue(not('tr class="data"' in response.content),
                         'should be no project rows in the page')
-        self.assertTrue(not(self.PROJECT_NAME in response.content),
+        self.assertTrue(not(CLI_BUILDS_PROJECT_NAME in response.content),
                         'default project "cli builds" should not be in page')
 
     def test_default_project_has_build(self):
         """ The default project should be shown if it has builds """
-        now = timezone.now()
-        build = Build.objects.create(project=self.default_project,
-                                     started_on=now,
-                                     completed_on=now)
-        build.save()
+        self._add_build_to_default_project()
 
         params = {"count": 10, "orderby": "updated:-", "page": 1}
         response = self.client.get(reverse('all-projects'), params)
 
         self.assertTrue('tr class="data"' in response.content,
                         'should be a project row in the page')
-        self.assertTrue(self.PROJECT_NAME in response.content,
+        self.assertTrue(CLI_BUILDS_PROJECT_NAME in response.content,
                         'default project "cli builds" should be in page')
 
+    def test_default_project_release(self):
+        """
+        The release for the default project should display as
+        'Not applicable'
+        """
+        # need a build, otherwise project doesn't display at all
+        self._add_build_to_default_project()
+
+        # another project to test, which should show release
+        self._add_non_default_project()
+
+        response = self.client.get(reverse('all-projects'), follow=True)
+        soup = BeautifulSoup(response.content)
+
+        # check the release cell for the default project
+        attrs = {'data-project': str(self.default_project.id)}
+        rows = soup.find_all('tr', attrs=attrs)
+        self.assertEqual(len(rows), 1, 'should be one row for default project')
+        cells = rows[0].find_all('td', attrs={'data-project-field': 'release'})
+        self.assertEqual(len(cells), 1, 'should be one release cell')
+        text = cells[0].select('span.muted')[0].text
+        self.assertEqual(text, 'Not applicable',
+                         'release should be not applicable for default project')
+
+        # check the link in the release cell for the other project
+        attrs = {'data-project': str(self.project.id)}
+        rows = soup.find_all('tr', attrs=attrs)
+        cells = rows[0].find_all('td', attrs={'data-project-field': 'release'})
+        text = cells[0].select('a')[0].text
+        self.assertEqual(text, self.release.name,
+                         'release name should be shown for non-default project')
+
+    def test_default_project_machine(self):
+        """
+        The machine for the default project should display as
+        'Not applicable'
+        """
+        # need a build, otherwise project doesn't display at all
+        self._add_build_to_default_project()
+
+        # another project to test, which should show machine
+        self._add_non_default_project()
+
+        response = self.client.get(reverse('all-projects'), follow=True)
+        soup = BeautifulSoup(response.content)
+
+        # check the machine cell for the default project
+        attrs = {'data-project': str(self.default_project.id)}
+        rows = soup.find_all('tr', attrs=attrs)
+        self.assertEqual(len(rows), 1, 'should be one row for default project')
+        cells = rows[0].find_all('td', attrs={'data-project-field': 'machine'})
+        self.assertEqual(len(cells), 1, 'should be one machine cell')
+        text = cells[0].select('span.muted')[0].text
+        self.assertEqual(text, 'Not applicable',
+                         'machine should be not applicable for default project')
+
+        # check the link in the machine cell for the other project
+        attrs = {'data-project': str(self.project.id)}
+        rows = soup.find_all('tr', attrs=attrs)
+        cells = rows[0].find_all('td', attrs={'data-project-field': 'machine'})
+        text = cells[0].select('a')[0].text
+        self.assertEqual(text, self.MACHINE_NAME,
+                         'machine name should be shown for non-default project')
+
 class ProjectBuildsPageTests(TestCase):
     """ Test data at /project/X/builds is displayed correctly """
 
-- 
2.1.4


