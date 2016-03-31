Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id 965BA65C8A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Mar 2016 18:56:03 +0000 (UTC)
Received: by mail-wm0-f52.google.com with SMTP id p65so126282465wmp.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Mar 2016 11:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=/Ne0ReKffYze1PGC8RXc+260kg13gQM/IagBPXaGqzw=;
	b=sJxItV2oelXLS8pnhAV3/cAeECAM6tax1a9x0ueUUyd+i4ZLR2R6VetU8MRsyLr5ra
	Z+L75OTHahEoYteyDIC3ByhpNDBUBRfdmFq/6q/JGNMCP9JAvz0apAvNON4kcdTM8fLH
	EAKR+TeanBpUlxaowZ/mRkKHOEWRM+k3wGHfU8vRHN0swAWSsYVkltY9a0BFE5VG9t2m
	+NlJ9ZDdAzY59OtD3QNN3zVs/u3Ui1DjQ5bF0WF06vloAhcy2Wu8oUXTeRM75ukhWU2q
	5/nDDyUmiF43QJQKl8A/7/YIp4Au90epufC17iKufjMIKib6xlT1QFPnGLwgLUDn5nlE
	mF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=/Ne0ReKffYze1PGC8RXc+260kg13gQM/IagBPXaGqzw=;
	b=LJtcj7/rDF8No57zc6C/wFCp437ARfjgNH6DUk4hHgYMXaetyBLTlnW1zGPemJ/9bC
	3c+Q2zVh2qRQdoAlcw8b8PCXFSl1qNeo1fQl0ENVaOwa3SJBdEotkx/A0CVPZ6z1hHd/
	EIoavzooIa+sF/Kxv749OiExG3tXlf34QmEixyuJjmVVEK+Gt1qSOhxhraSmQKHwdesg
	YFfAdpWw8xwNbelZxjLcKYVdTGMtITJZGb/uMA5EP2BAhOFliG9t8yCkrNJCkftWrTcC
	/ZG0ccQ55HHuOXCiIYFknhKu7ijqK3DcZairuE2W1NySWoQU4BMHoBWoASyfZ1UK4NrV
	zuEA==
X-Gm-Message-State: AD7BkJIB/BervzAWUE7kxVXFAmAPWud91E9YtSJWyplwLZcg0v2l5Rb/Os0ZWADauhYEkZtN
X-Received: by 10.28.22.74 with SMTP id 71mr2010894wmw.47.1459450564068;
	Thu, 31 Mar 2016 11:56:04 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	fv6sm10406288wjc.12.2016.03.31.11.56.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 31 Mar 2016 11:56:03 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Mar 2016 19:55:44 +0100
Message-Id: <1459450547-26248-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1459450547-26248-1-git-send-email-michael.g.wood@intel.com>
References: <1459450547-26248-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 2/5] toaster: tests Migrate all builds page and project page tests to Selenium
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
X-List-Received-Date: Thu, 31 Mar 2016 18:56:04 -0000

From: Elliot Smith <elliot.smith@intel.com>

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/tests/browser/test_all_builds_page.py | 143 ++++++++++++++++++++++
 lib/toaster/tests/browser/test_project_page.py    |  59 +++++++++
 lib/toaster/toastergui/tests.py                   | 140 ---------------------
 3 files changed, 202 insertions(+), 140 deletions(-)
 create mode 100644 lib/toaster/tests/browser/test_all_builds_page.py
 create mode 100644 lib/toaster/tests/browser/test_project_page.py

diff --git a/lib/toaster/tests/browser/test_all_builds_page.py b/lib/toaster/tests/browser/test_all_builds_page.py
new file mode 100644
index 0000000..e4223f4
--- /dev/null
+++ b/lib/toaster/tests/browser/test_all_builds_page.py
@@ -0,0 +1,143 @@
+#! /usr/bin/env python
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Toaster Implementation
+#
+# Copyright (C) 2013-2016 Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import re
+
+from django.core.urlresolvers import reverse
+from django.utils import timezone
+from tests.browser.selenium_helpers import SeleniumTestCase
+
+from orm.models import BitbakeVersion, Release, Project, Build, Target
+
+class TestAllBuildsPage(SeleniumTestCase):
+    """ Tests for all builds page /builds/ """
+
+    PROJECT_NAME = 'test project'
+    CLI_BUILDS_PROJECT_NAME = 'command line builds'
+
+    def setUp(self):
+        bbv = BitbakeVersion.objects.create(name='bbv1', giturl='/tmp/',
+                                            branch='master', dirpath='')
+        release = Release.objects.create(name='release1',
+                                         bitbake_version=bbv)
+        self.project1 = Project.objects.create_project(name=self.PROJECT_NAME,
+                                                       release=release)
+        self.default_project = Project.objects.create_project(
+            name=self.CLI_BUILDS_PROJECT_NAME,
+            release=release
+        )
+        self.default_project.is_default = True
+        self.default_project.save()
+
+        # parameters for builds to associate with the projects
+        now = timezone.now()
+
+        self.project1_build_success = {
+            'project': self.project1,
+            'started_on': now,
+            'completed_on': now,
+            'outcome': Build.SUCCEEDED
+        }
+
+        self.default_project_build_success = {
+            'project': self.default_project,
+            'started_on': now,
+            'completed_on': now,
+            'outcome': Build.SUCCEEDED
+        }
+
+    def test_show_tasks_with_suffix(self):
+        """ Task should be shown as suffix on build name """
+        build = Build.objects.create(**self.project1_build_success)
+        target = 'bash'
+        task = 'clean'
+        Target.objects.create(build=build, target=target, task=task)
+
+        url = reverse('all-builds')
+        self.get(url)
+        self.wait_until_present('td[class="target"]')
+
+        cell = self.find('td[class="target"]')
+        content = cell.get_attribute('innerHTML')
+        expected_text = '%s:%s' % (target, task)
+
+        self.assertTrue(re.search(expected_text, content),
+                        '"target" cell should contain text %s' % expected_text)
+
+    def test_rebuild_buttons(self):
+        """
+        Test 'Rebuild' buttons in recent builds section
+
+        'Rebuild' button should not be shown for command-line builds,
+        but should be shown for other builds
+        """
+        build1 = Build.objects.create(**self.project1_build_success)
+        default_build = Build.objects.create(**self.default_project_build_success)
+
+        url = reverse('all-builds')
+        self.get(url)
+
+        # shouldn't see a run again button for command-line builds
+        selector = 'div[data-latest-build-result="%s"] button' % default_build.id
+        run_again_button = self.find_all(selector)
+        self.assertEqual(len(run_again_button), 0,
+                         'should not see a run again button for cli builds')
+
+        # should see a run again button for non-command-line builds
+        selector = 'div[data-latest-build-result="%s"] button' % build1.id
+        run_again_button = self.find_all(selector)
+        self.assertEqual(len(run_again_button), 1,
+                         'should see a run again button for non-cli builds')
+
+    def test_tooltips_on_project_name(self):
+        """
+        Test tooltips shown next to project name in the main table
+
+        A tooltip should be present next to the command line
+        builds project name in the all builds page, but not for
+        other projects
+        """
+        Build.objects.create(**self.project1_build_success)
+        Build.objects.create(**self.default_project_build_success)
+
+        url = reverse('all-builds')
+        self.get(url)
+
+        # get the project name cells from the table
+        cells = self.find_all('#allbuildstable td[class="project"]')
+
+        selector = 'i.get-help'
+
+        for cell in cells:
+            content = cell.get_attribute('innerHTML')
+            help_icons = cell.find_elements_by_css_selector(selector)
+
+            if re.search(self.PROJECT_NAME, content):
+                # no help icon next to non-cli project name
+                msg = 'should not be a help icon for non-cli builds name'
+                self.assertEqual(len(help_icons), 0, msg)
+            elif re.search(self.CLI_BUILDS_PROJECT_NAME, content):
+                # help icon next to cli project name
+                msg = 'should be a help icon for cli builds name'
+                self.assertEqual(len(help_icons), 1, msg)
+            else:
+                msg = 'found unexpected project name cell in all builds table'
+                self.fail(msg)
diff --git a/lib/toaster/tests/browser/test_project_page.py b/lib/toaster/tests/browser/test_project_page.py
new file mode 100644
index 0000000..786bef1
--- /dev/null
+++ b/lib/toaster/tests/browser/test_project_page.py
@@ -0,0 +1,59 @@
+#! /usr/bin/env python
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Toaster Implementation
+#
+# Copyright (C) 2013-2016 Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+from django.core.urlresolvers import reverse
+from django.utils import timezone
+from tests.browser.selenium_helpers import SeleniumTestCase
+
+from orm.models import Build, Project
+
+class TestProjectPage(SeleniumTestCase):
+    """ Test project data at /project/X/ is displayed correctly """
+
+    CLI_BUILDS_PROJECT_NAME = 'Command line builds'
+
+    def test_cli_builds_in_progress(self):
+        """
+        In progress builds should not cause an error to be thrown
+        when navigating to "command line builds" project page;
+        see https://bugzilla.yoctoproject.org/show_bug.cgi?id=8277
+        """
+
+        # add the "command line builds" default project; this mirrors what
+        # we do with get_or_create_default_project()
+        default_project = Project.objects.create_project(self.CLI_BUILDS_PROJECT_NAME, None)
+        default_project.is_default = True
+        default_project.save()
+
+        # add an "in progress" build for the default project
+        now = timezone.now()
+        Build.objects.create(project=default_project,
+                             started_on=now,
+                             completed_on=now,
+                             outcome=Build.IN_PROGRESS)
+
+        # navigate to the project page for the default project
+        url = reverse("project", args=(default_project.id,))
+        self.get(url)
+
+        # check that we get a project page with the correct heading
+        project_name = self.find('#project-name').text.strip()
+        self.assertEqual(project_name, self.CLI_BUILDS_PROJECT_NAME)
diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 6b05916..78b7c04 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -897,146 +897,6 @@ class ProjectBuildsPageTests(TestCase):
         self.assertEqual(len(tabs), 1,
                          'should be a top bar shown for non-command-line builds')
 
-class AllBuildsPageTests(TestCase):
-    """ Tests for all builds page /builds/ """
-
-    def setUp(self):
-        bbv = BitbakeVersion.objects.create(name="bbv1", giturl="/tmp/",
-                                            branch="master", dirpath="")
-        release = Release.objects.create(name="release1",
-                                         bitbake_version=bbv)
-        self.project1 = Project.objects.create_project(name=PROJECT_NAME,
-                                                       release=release)
-        self.default_project = Project.objects.create_project(
-            name=CLI_BUILDS_PROJECT_NAME,
-            release=release
-        )
-        self.default_project.is_default = True
-        self.default_project.save()
-
-        # parameters for builds to associate with the projects
-        now = timezone.now()
-
-        self.project1_build_success = {
-            "project": self.project1,
-            "started_on": now,
-            "completed_on": now,
-            "outcome": Build.SUCCEEDED
-        }
-
-        self.default_project_build_success = {
-            "project": self.default_project,
-            "started_on": now,
-            "completed_on": now,
-            "outcome": Build.SUCCEEDED
-        }
-
-    def _get_row_for_build(self, data, build_id):
-        """ Get the object representing the table data for a project """
-        return [row for row in data['rows']
-                    if row['id'] == build_id][0]
-
-    def test_show_tasks_in_allbuilds(self):
-        """ Task should be shown as suffix on build name """
-        build = Build.objects.create(**self.project1_build_success)
-        Target.objects.create(build=build, target='bash', task='clean')
-
-        url = reverse('all-builds')
-        response = self.client.get(url, {'format': 'json'}, follow=True)
-        data = json.loads(response.content)
-        cell = data['rows'][0]['static:target']
-
-        result = re.findall('bash:clean', cell, re.MULTILINE)
-        self.assertEqual(len(result), 1)
-
-    def test_run_again(self):
-        """
-        "Rebuild" button should not be shown for command-line builds,
-        but should be shown for other builds
-        """
-        build1 = Build.objects.create(**self.project1_build_success)
-        default_build = Build.objects.create(**self.default_project_build_success)
-        url = reverse('all-builds')
-        response = self.client.get(url, follow=True)
-        soup = BeautifulSoup(response.content)
-
-        # shouldn't see a run again button for command-line builds
-        attrs = {'data-latest-build-result': default_build.id}
-        result = soup.find('div', attrs=attrs)
-        run_again_button = result.select('button')
-        self.assertEqual(len(run_again_button), 0)
-
-        # should see a run again button for non-command-line builds
-        attrs = {'data-latest-build-result': build1.id}
-        result = soup.find('div', attrs=attrs)
-        run_again_button = result.select('button')
-        self.assertEqual(len(run_again_button), 1)
-
-    def test_tooltips_on_project_name(self):
-        """
-        A tooltip should be present next to the command line
-        builds project name in the all builds page, but not for
-        other projects
-        """
-        build1 = Build.objects.create(**self.project1_build_success)
-        default_build = Build.objects.create(**self.default_project_build_success)
-
-        url = reverse('all-builds')
-        response = self.client.get(url, {'format': 'json'}, follow=True)
-        data = json.loads(response.content)
-
-        # get the data row for the non-command-line builds project
-        other_project_row = self._get_row_for_build(data, build1.id)
-
-        # make sure there is some HTML
-        soup = BeautifulSoup(other_project_row['static:project'])
-        self.assertEqual(len(soup.select('a')), 1,
-                         'should be a project name link')
-
-        # no help icon on non-default project name
-        icons = soup.select('i.get-help')
-        self.assertEqual(len(icons), 0,
-                         'should not be a help icon for non-cli builds name')
-
-        # get the data row for the command-line builds project
-        default_project_row = self._get_row_for_build(data, default_build.id)
-
-        # help icon on default project name
-        soup = BeautifulSoup(default_project_row['static:project'])
-        icons = soup.select('i.get-help')
-        self.assertEqual(len(icons), 1,
-                         'should be a help icon for cli builds name')
-
-class ProjectPageTests(TestCase):
-    """ Test project data at /project/X/ is displayed correctly """
-    CLI_BUILDS_PROJECT_NAME = 'Command line builds'
-
-    def test_command_line_builds_in_progress(self):
-        """
-        In progress builds should not cause an error to be thrown
-        when navigating to "command line builds" project page;
-        see https://bugzilla.yoctoproject.org/show_bug.cgi?id=8277
-        """
-
-        # add the "command line builds" default project; this mirrors what
-        # we do in migration 0026_set_default_project.py
-        default_project = Project.objects.create_project(self.CLI_BUILDS_PROJECT_NAME, None)
-        default_project.is_default = True
-        default_project.save()
-
-        # add an "in progress" build for the default project
-        now = timezone.now()
-        build = Build.objects.create(project=default_project,
-                                     started_on=now,
-                                     completed_on=now,
-                                     outcome=Build.IN_PROGRESS)
-
-        # navigate to the project page for the default project
-        url = reverse("project", args=(default_project.id,))
-        response = self.client.get(url, follow=True)
-
-        self.assertEqual(response.status_code, 200)
-
 class BuildDashboardTests(TestCase):
     """ Tests for the build dashboard /build/X """
 
-- 
2.1.4


