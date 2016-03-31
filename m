Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
	by mail.openembedded.org (Postfix) with ESMTP id 238CA65C8A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Mar 2016 18:56:04 +0000 (UTC)
Received: by mail-wm0-f50.google.com with SMTP id f198so13465187wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Mar 2016 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=J/StokK0CzmmBI4HHsUdn5SV6PmWcCeylqPNHof+31M=;
	b=1zwDLSTPiFbjCOadweBMyhk7mCV7ZwBg4bW1A73kd3bbuN/PJn1FwRfQUtJkAbLQUd
	3TyoStwDHW0kjeIhT8A/6TK/GWFv6aYWBDqVa0ASVxXtLJSxlIso1PfuM6KieEBU3UXX
	jzW8RuoBBCV35W5BFsfigC+RfeOWWP72YutNLW76JlFYbpVP6BUWlX2PE1xHo6DkuyNI
	zTfdXLHSPwOUSlaYFJw0cPqP+b96AT+2TShJ92YH9I2mJ7+BsLm9Q5XXHixMi9g1O8zb
	Ojv0KZik3KeXxVW5F8BAtWe2zzW375Ab4n+AB5cafjW1UvOidfs1VLpuLo+KMUe6/ni7
	Lv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=J/StokK0CzmmBI4HHsUdn5SV6PmWcCeylqPNHof+31M=;
	b=f7+8EedkWfVgIBybeOXqoqCahJSE5Uh0fGwQcYF2Z81peOXhV+hbAdukvPLK+rE3J4
	YJOfS0GHQrrtrb95bTX+zz90Ol2xhXmgwwl5inHnAOpMOwmUhazM/txIKlOR+XdKn7mT
	GR7ZHNv4+1qtAm61nc3C3aGVKRhnHXY4nqbgrVr/vaQyhUmm2kkkJl0aOmTP1WWZs28r
	G6pBXQg5l/+FbasLSQHQNAQAtOu/SbBEnz57kyNKR8stNYTWPhyyktdFNt3Wd43QjklH
	2ExICQxhhTQOkQ8cbSbG7P+qqk/qtRnVQuNPINeicf2fkwUViwydQgVloIFRZILfW7DE
	re+w==
X-Gm-Message-State: AD7BkJKkmg/WfrWNCWD8/AGoc9He6j1vTNohKB94bQwwlMd/WW3whqASCCHjqFiB7+SAQJB5
X-Received: by 10.28.184.194 with SMTP id i185mr504821wmf.90.1459450565004;
	Thu, 31 Mar 2016 11:56:05 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	fv6sm10406288wjc.12.2016.03.31.11.56.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 31 Mar 2016 11:56:04 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Mar 2016 19:55:45 +0100
Message-Id: <1459450547-26248-3-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1459450547-26248-1-git-send-email-michael.g.wood@intel.com>
References: <1459450547-26248-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 3/5] toaster: tests Migrate project builds page tests to Selenium
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
X-List-Received-Date: Thu, 31 Mar 2016 18:56:06 -0000

From: Elliot Smith <elliot.smith@intel.com>

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 .../tests/browser/test_project_builds_page.py      | 168 +++++++++++++++++++++
 lib/toaster/toastergui/tests.py                    | 133 ----------------
 2 files changed, 168 insertions(+), 133 deletions(-)
 create mode 100644 lib/toaster/tests/browser/test_project_builds_page.py

diff --git a/lib/toaster/tests/browser/test_project_builds_page.py b/lib/toaster/tests/browser/test_project_builds_page.py
new file mode 100644
index 0000000..9fe91ab
--- /dev/null
+++ b/lib/toaster/tests/browser/test_project_builds_page.py
@@ -0,0 +1,168 @@
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
+class TestProjectBuildsPage(SeleniumTestCase):
+    """ Test data at /project/X/builds is displayed correctly """
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
+        self.project1.save()
+
+        self.project2 = Project.objects.create_project(name=self.PROJECT_NAME,
+                                                       release=release)
+        self.project2.save()
+
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
+        self.project1_build_in_progress = {
+            'project': self.project1,
+            'started_on': now,
+            'completed_on': now,
+            'outcome': Build.IN_PROGRESS
+        }
+
+        self.project2_build_success = {
+            'project': self.project2,
+            'started_on': now,
+            'completed_on': now,
+            'outcome': Build.SUCCEEDED
+        }
+
+        self.project2_build_in_progress = {
+            'project': self.project2,
+            'started_on': now,
+            'completed_on': now,
+            'outcome': Build.IN_PROGRESS
+        }
+
+    def _get_rows_for_project(self, project_id):
+        """
+        Helper to retrieve HTML rows for a project's builds,
+        as shown in the main table of the page
+        """
+        url = reverse('projectbuilds', args=(project_id,))
+        self.get(url)
+        self.wait_until_present('#projectbuildstable tbody tr')
+        return self.find_all('#projectbuildstable tbody tr')
+
+    def test_show_builds_for_project(self):
+        """ Builds for a project should be displayed in the main table """
+        Build.objects.create(**self.project1_build_success)
+        Build.objects.create(**self.project1_build_success)
+        build_rows = self._get_rows_for_project(self.project1.id)
+        self.assertEqual(len(build_rows), 2)
+
+    def test_show_builds_project_only(self):
+        """ Builds for other projects should be excluded """
+        Build.objects.create(**self.project1_build_success)
+        Build.objects.create(**self.project1_build_success)
+        Build.objects.create(**self.project1_build_success)
+
+        # shouldn't see these two
+        Build.objects.create(**self.project2_build_success)
+        Build.objects.create(**self.project2_build_in_progress)
+
+        build_rows = self._get_rows_for_project(self.project1.id)
+        self.assertEqual(len(build_rows), 3)
+
+    def test_builds_exclude_in_progress(self):
+        """ "in progress" builds should not be shown in main table """
+        Build.objects.create(**self.project1_build_success)
+        Build.objects.create(**self.project1_build_success)
+
+        # shouldn't see this one
+        Build.objects.create(**self.project1_build_in_progress)
+
+        # shouldn't see these two either, as they belong to a different project
+        Build.objects.create(**self.project2_build_success)
+        Build.objects.create(**self.project2_build_in_progress)
+
+        build_rows = self._get_rows_for_project(self.project1.id)
+        self.assertEqual(len(build_rows), 2)
+
+    def test_show_tasks_with_suffix(self):
+        """ Task should be shown as suffixes on build names """
+        build = Build.objects.create(**self.project1_build_success)
+        target = 'bash'
+        task = 'clean'
+        Target.objects.create(build=build, target=target, task=task)
+
+        url = reverse('projectbuilds', args=(self.project1.id,))
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
+    def test_cli_builds_hides_tabs(self):
+        """
+        Display for command line builds should hide tabs
+        """
+        url = reverse('projectbuilds', args=(self.default_project.id,))
+        self.get(url)
+        tabs = self.find_all('#project-topbar')
+        self.assertEqual(len(tabs), 0,
+                         'should be no top bar shown for command line builds')
+
+    def test_non_cli_builds_has_tabs(self):
+        """
+        Non-command-line builds projects should show the tabs
+        """
+        url = reverse('projectbuilds', args=(self.project1.id,))
+        self.get(url)
+        tabs = self.find_all('#project-topbar')
+        self.assertEqual(len(tabs), 1,
+                         'should be a top bar shown for non-command-line builds')
diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 78b7c04..7192947 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -764,139 +764,6 @@ class AllProjectsPageTests(TestCase):
         self.assertEqual(soup.find('a')['href'], expected_url,
                          'link on project name should point to configuration')
 
-class ProjectBuildsPageTests(TestCase):
-    """ Test data at /project/X/builds is displayed correctly """
-
-    def setUp(self):
-        bbv = BitbakeVersion.objects.create(name="bbv1", giturl="/tmp/",
-                                            branch="master", dirpath="")
-        release = Release.objects.create(name="release1",
-                                         bitbake_version=bbv)
-        self.project1 = Project.objects.create_project(name=PROJECT_NAME,
-                                                       release=release)
-        self.project1.save()
-
-        self.project2 = Project.objects.create_project(name=PROJECT_NAME,
-                                                       release=release)
-        self.project2.save()
-
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
-        self.project1_build_in_progress = {
-            "project": self.project1,
-            "started_on": now,
-            "completed_on": now,
-            "outcome": Build.IN_PROGRESS
-        }
-
-        self.project2_build_success = {
-            "project": self.project2,
-            "started_on": now,
-            "completed_on": now,
-            "outcome": Build.SUCCEEDED
-        }
-
-        self.project2_build_in_progress = {
-            "project": self.project2,
-            "started_on": now,
-            "completed_on": now,
-            "outcome": Build.IN_PROGRESS
-        }
-
-    def _get_rows_for_project(self, project_id):
-        """ Helper to retrieve HTML rows for a project """
-        url = reverse("projectbuilds", args=(project_id,))
-        response = self.client.get(url, {'format': 'json'}, follow=True)
-        data = json.loads(response.content)
-        return data['rows']
-
-    def test_show_builds_for_project(self):
-        """ Builds for a project should be displayed """
-        Build.objects.create(**self.project1_build_success)
-        Build.objects.create(**self.project1_build_success)
-        build_rows = self._get_rows_for_project(self.project1.id)
-        self.assertEqual(len(build_rows), 2)
-
-    def test_show_builds_project_only(self):
-        """ Builds for other projects should be excluded """
-        Build.objects.create(**self.project1_build_success)
-        Build.objects.create(**self.project1_build_success)
-        Build.objects.create(**self.project1_build_success)
-
-        # shouldn't see these two
-        Build.objects.create(**self.project2_build_success)
-        Build.objects.create(**self.project2_build_in_progress)
-
-        build_rows = self._get_rows_for_project(self.project1.id)
-        self.assertEqual(len(build_rows), 3)
-
-    def test_builds_exclude_in_progress(self):
-        """ "in progress" builds should not be shown """
-        Build.objects.create(**self.project1_build_success)
-        Build.objects.create(**self.project1_build_success)
-
-        # shouldn't see this one
-        Build.objects.create(**self.project1_build_in_progress)
-
-        # shouldn't see these two either, as they belong to a different project
-        Build.objects.create(**self.project2_build_success)
-        Build.objects.create(**self.project2_build_in_progress)
-
-        build_rows = self._get_rows_for_project(self.project1.id)
-        self.assertEqual(len(build_rows), 2)
-
-    def test_tasks_in_projectbuilds(self):
-        """ Task should be shown as suffix on build name """
-        build = Build.objects.create(**self.project1_build_success)
-        Target.objects.create(build=build, target='bash', task='clean')
-
-        url = reverse('projectbuilds', args=(self.project1.id,))
-        response = self.client.get(url, {'format': 'json'}, follow=True)
-        data = json.loads(response.content)
-        cell = data['rows'][0]['static:target']
-
-        result = re.findall('^ +bash:clean', cell, re.MULTILINE)
-        self.assertEqual(len(result), 1)
-
-    def test_cli_builds_hides_tabs(self):
-        """
-        Display for command line builds should hide tabs;
-        note that the latest builds section is already tested in
-        AllBuildsPageTests, as the template is the same
-        """
-        url = reverse("projectbuilds", args=(self.default_project.id,))
-        response = self.client.get(url, follow=True)
-        soup = BeautifulSoup(response.content)
-        tabs = soup.select('#project-topbar')
-        self.assertEqual(len(tabs), 0,
-                         'should be no top bar shown for command line builds')
-
-    def test_non_cli_builds_has_tabs(self):
-        """
-        Non-command-line builds projects should show the tabs
-        """
-        url = reverse("projectbuilds", args=(self.project1.id,))
-        response = self.client.get(url, follow=True)
-        soup = BeautifulSoup(response.content)
-        tabs = soup.select('#project-topbar')
-        self.assertEqual(len(tabs), 1,
-                         'should be a top bar shown for non-command-line builds')
-
 class BuildDashboardTests(TestCase):
     """ Tests for the build dashboard /build/X """
 
-- 
2.1.4


