Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 9559265C8A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Mar 2016 18:56:06 +0000 (UTC)
Received: by mail-wm0-f41.google.com with SMTP id 191so136482341wmq.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Mar 2016 11:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=mphOLs3GIXTlW2gfxNrIyVB8fZr8NvHZsvIJoWsbHHI=;
	b=A4HVFrgpcVSmDSnsyC+L5d4tBa6RFexLOmOG+1dUqtH1ENBiNiq2q7VCX3vaWOHG7m
	+on0+Lj+eDQWtw9z3fLYJtTr2kI2tDeDnuaAKjAslynBMZCpeBZrTa5B/15knrfxRDTo
	r8eMhyqxfCoIsyyQpNXuExLfS+saKlc5d71ev/F8BKnk3QVI9cWWxLlxh2CQzNmjL2C2
	XrIKucbcUE/FP/K6ZBRAf4Qlc5eOfNf4KvYyC6rofSASEQqW73fKxbT2J8kdUs79jRI6
	jgKxNjSfj1PFidNtgbeYqzlHLSdD+yxm4eyhfa+z1ByZ3bMhTBPxT9n+yxLwUwXe7xrp
	zGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=mphOLs3GIXTlW2gfxNrIyVB8fZr8NvHZsvIJoWsbHHI=;
	b=KaS4iVC9U7iWlxLqAw2HwUUJdHsv9bFd4vJnFuBF0GkzJYSiFwNdvCmjzDauBGLxG0
	FCy8UPfOz2WpA14nzwqXL1JMyY6JxNGnEFXBWuAq6qLiY4fI80VhkRO3I5CklzJXazGG
	vnaktjAxZCe2zDMkSSESiHGqME2B3R2eRHWpMEe6iptpKY+eUPmOZLvw3Sx5lkDpkjdv
	n6i1paMimocrsn6mYYz3bsl89mDbGw18IouiTzpD9WJbAE00h98OBarc3ru6DMgIfaW6
	Dydexs3mw6cBSX/rNtntntsYKrMKxlBqvnSiVc56XfyBEuoC2Iyvzb8Daq7W1X2XvjCb
	e/xA==
X-Gm-Message-State: AD7BkJLhOVh+97NMxfe9fMMqRFs3qpZIxv4jwPBV5MkjRB2XVj/jC7QqFa1bSjILjxTiIOG6
X-Received: by 10.28.48.147 with SMTP id w141mr1069286wmw.85.1459450566147;
	Thu, 31 Mar 2016 11:56:06 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	fv6sm10406288wjc.12.2016.03.31.11.56.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 31 Mar 2016 11:56:05 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Mar 2016 19:55:46 +0100
Message-Id: <1459450547-26248-4-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1459450547-26248-1-git-send-email-michael.g.wood@intel.com>
References: <1459450547-26248-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 4/5] toaster: tests Migrate all projects page tests to Selenium
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
X-List-Received-Date: Thu, 31 Mar 2016 18:56:07 -0000

From: Elliot Smith <elliot.smith@intel.com>

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 .../tests/browser/test_all_projects_page.py        | 214 +++++++++++++++++++++
 lib/toaster/toastergui/tests.py                    | 197 -------------------
 2 files changed, 214 insertions(+), 197 deletions(-)
 create mode 100644 lib/toaster/tests/browser/test_all_projects_page.py

diff --git a/lib/toaster/tests/browser/test_all_projects_page.py b/lib/toaster/tests/browser/test_all_projects_page.py
new file mode 100644
index 0000000..ed8e620
--- /dev/null
+++ b/lib/toaster/tests/browser/test_all_projects_page.py
@@ -0,0 +1,214 @@
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
+from orm.models import BitbakeVersion, Release, Project, Build
+from orm.models import ProjectVariable
+
+class TestAllProjectsPage(SeleniumTestCase):
+    """ Browser tests for projects page /projects/ """
+
+    PROJECT_NAME = 'test project'
+    CLI_BUILDS_PROJECT_NAME = 'command line builds'
+    MACHINE_NAME = 'delorean'
+
+    def setUp(self):
+        """ Add default project manually """
+        project = Project.objects.create_project(self.CLI_BUILDS_PROJECT_NAME, None)
+        self.default_project = project
+        self.default_project.is_default = True
+        self.default_project.save()
+
+        # this project is only set for some of the tests
+        self.project = None
+
+        self.release = None
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
+        bbv = BitbakeVersion.objects.create(name='test bbv', giturl='/tmp/',
+                                            branch='master', dirpath='')
+        self.release = Release.objects.create(name='test release',
+                                              branch_name='master',
+                                              bitbake_version=bbv)
+        self.project = Project.objects.create_project(self.PROJECT_NAME, self.release)
+        self.project.is_default = False
+        self.project.save()
+
+        # fake the MACHINE variable
+        project_var = ProjectVariable.objects.create(project=self.project,
+                                                     name='MACHINE',
+                                                     value=self.MACHINE_NAME)
+        project_var.save()
+
+    def _get_row_for_project(self, project_name):
+        """ Get the HTML row for a project, or None if not found """
+        self.wait_until_present('#projectstable tbody tr')
+        rows = self.find_all('#projectstable tbody tr')
+
+        # find the row with a project name matching the one supplied
+        found_row = None
+        for row in rows:
+            if re.search(project_name, row.get_attribute('innerHTML')):
+                found_row = row
+                break
+
+        return found_row
+
+    def test_default_project_hidden(self):
+        """
+        The default project should be hidden if it has no builds
+        and we should see the "no results" area
+        """
+        url = reverse('all-projects')
+        self.get(url)
+        self.wait_until_visible('#no-results-projectstable')
+
+        rows = self.find_all('#projectstable tbody tr')
+        self.assertEqual(len(rows), 0, 'should be no projects displayed')
+
+    def test_default_project_has_build(self):
+        """ The default project should be shown if it has builds """
+        self._add_build_to_default_project()
+
+        url = reverse('all-projects')
+        self.get(url)
+
+        default_project_row = self._get_row_for_project(self.default_project.name)
+
+        self.assertNotEqual(default_project_row, None,
+                            'default project "cli builds" should be in page')
+
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
+        self.get(reverse('all-projects'))
+
+        # find the row for the default project
+        default_project_row = self._get_row_for_project(self.default_project.name)
+
+        # check the release text for the default project
+        selector = 'span[data-project-field="release"] span.muted'
+        element = default_project_row.find_element_by_css_selector(selector)
+        text = element.text.strip()
+        self.assertEqual(text, 'Not applicable',
+                         'release should be "not applicable" for default project')
+
+        # find the row for the default project
+        other_project_row = self._get_row_for_project(self.project.name)
+
+        # check the link in the release cell for the other project
+        selector = 'span[data-project-field="release"] a'
+        element = other_project_row.find_element_by_css_selector(selector)
+        text = element.text.strip()
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
+        self.get(reverse('all-projects'))
+
+        # find the row for the default project
+        default_project_row = self._get_row_for_project(self.default_project.name)
+
+        # check the machine cell for the default project
+        selector = 'span[data-project-field="machine"] span.muted'
+        element = default_project_row.find_element_by_css_selector(selector)
+        text = element.text.strip()
+        self.assertEqual(text, 'Not applicable',
+                         'machine should be not applicable for default project')
+
+        # find the row for the default project
+        other_project_row = self._get_row_for_project(self.project.name)
+
+        # check the link in the machine cell for the other project
+        selector = 'span[data-project-field="machine"] a'
+        element = other_project_row.find_element_by_css_selector(selector)
+        text = element.text.strip()
+        self.assertEqual(text, self.MACHINE_NAME,
+                         'machine name should be shown for non-default project')
+
+    def test_project_page_links(self):
+        """
+        Test that links for the default project point to the builds
+        page /projects/X/builds for that project, and that links for
+        other projects point to their configuration pages /projects/X/
+        """
+
+        # need a build, otherwise project doesn't display at all
+        self._add_build_to_default_project()
+
+        # another project to test
+        self._add_non_default_project()
+
+        self.get(reverse('all-projects'))
+
+        # find the row for the default project
+        default_project_row = self._get_row_for_project(self.default_project.name)
+
+        # check the link on the name field
+        selector = 'span[data-project-field="name"] a'
+        element = default_project_row.find_element_by_css_selector(selector)
+        link_url = element.get_attribute('href').strip()
+        expected_url = reverse('projectbuilds', args=(self.default_project.id,))
+        msg = 'link on default project name should point to builds but was %s' % link_url
+        self.assertTrue(link_url.endswith(expected_url), msg)
+
+        # find the row for the other project
+        other_project_row = self._get_row_for_project(self.project.name)
+
+        # check the link for the other project
+        selector = 'span[data-project-field="name"] a'
+        element = other_project_row.find_element_by_css_selector(selector)
+        link_url = element.get_attribute('href').strip()
+        expected_url = reverse('project', args=(self.project.id,))
+        msg = 'link on project name should point to configuration but was %s' % link_url
+        self.assertTrue(link_url.endswith(expected_url), msg)
diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 7192947..6975ac1 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -493,7 +493,6 @@ class ViewTests(TestCase):
                                 "Changed page on table %s but first row is the "
                                 "same as the previous page" % name)
 
-
 class LandingPageTests(TestCase):
     """ Tests for redirects on the landing page """
     # disable bogus pylint message error:
@@ -568,202 +567,6 @@ class LandingPageTests(TestCase):
         self.assertTrue('/builds' in response.url,
                         'should redirect to builds')
 
-class AllProjectsPageTests(TestCase):
-    """ Tests for projects page /projects/ """
-
-    MACHINE_NAME = 'delorean'
-
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
-        self.release = None
-
-    def _add_build_to_default_project(self):
-        """ Add a build to the default project (not used in all tests) """
-        now = timezone.now()
-        build = Build.objects.create(project=self.default_project,
-                                     started_on=now,
-                                     completed_on=now)
-        build.save()
-
-    def _add_non_default_project(self):
-        """ Add another project """
-        bbv = BitbakeVersion.objects.create(name="test bbv", giturl="/tmp/",
-                                            branch="master", dirpath="")
-        self.release = Release.objects.create(name="test release",
-                                              branch_name="master",
-                                              bitbake_version=bbv)
-        self.project = Project.objects.create_project(PROJECT_NAME, self.release)
-        self.project.is_default = False
-        self.project.save()
-
-        # fake the MACHINE variable
-        project_var = ProjectVariable.objects.create(project=self.project,
-                                                     name='MACHINE',
-                                                     value=self.MACHINE_NAME)
-        project_var.save()
-
-    def _get_row_for_project(self, data, project_id):
-        """ Get the object representing the table data for a project """
-        return [row for row in data['rows'] if row['id'] == project_id][0]
-
-    def test_default_project_hidden(self):
-        """ The default project should be hidden if it has no builds """
-        params = {"count": 10, "orderby": "updated:-", "page": 1}
-        response = self.client.get(reverse('all-projects'), params)
-
-        self.assertTrue(not('tr class="data"' in response.content),
-                        'should be no project rows in the page')
-        self.assertTrue(not(CLI_BUILDS_PROJECT_NAME in response.content),
-                        'default project "cli builds" should not be in page')
-
-    def test_default_project_has_build(self):
-        """ The default project should be shown if it has builds """
-        self._add_build_to_default_project()
-
-        params = {"count": 10, "orderby": "updated:-", "page": 1}
-
-        response = self.client.get(
-            reverse('all-projects'),
-            {'format': 'json'},
-            params
-        )
-
-        data = json.loads(response.content)
-
-        # find the row for the default project
-        default_project_row = self._get_row_for_project(data, self.default_project.id)
-
-        # check its name template has the correct text
-        self.assertEqual(default_project_row['name'], CLI_BUILDS_PROJECT_NAME,
-                        'default project "cli builds" should be in page')
-
-    def test_default_project_release(self):
-        """
-        The release for the default project should display as
-        'Not applicable'
-        """
-        # need a build, otherwise project doesn't display at all
-        self._add_build_to_default_project()
-
-        # another project to test, which should show release
-        self._add_non_default_project()
-
-        response = self.client.get(
-            reverse('all-projects'),
-            {'format': 'json'},
-            follow=True
-        )
-
-        data = json.loads(response.content)
-
-        # used to find the correct span in the template output
-        attrs = {'data-project-field': 'release'}
-
-        # find the row for the default project
-        default_project_row = self._get_row_for_project(data, self.default_project.id)
-
-        # check the release text for the default project
-        soup = BeautifulSoup(default_project_row['static:release'])
-        text = soup.find('span', attrs=attrs).select('span.muted')[0].text
-        self.assertEqual(text, 'Not applicable',
-                         'release should be not applicable for default project')
-
-        # find the row for the default project
-        other_project_row = self._get_row_for_project(data, self.project.id)
-
-        # check the link in the release cell for the other project
-        soup = BeautifulSoup(other_project_row['static:release'])
-        text = soup.find('span', attrs=attrs).select('a')[0].text.strip()
-        self.assertEqual(text, self.release.name,
-                         'release name should be shown for non-default project')
-
-    def test_default_project_machine(self):
-        """
-        The machine for the default project should display as
-        'Not applicable'
-        """
-        # need a build, otherwise project doesn't display at all
-        self._add_build_to_default_project()
-
-        # another project to test, which should show machine
-        self._add_non_default_project()
-
-        response = self.client.get(
-            reverse('all-projects'),
-            {'format': 'json'},
-            follow=True
-        )
-
-        data = json.loads(response.content)
-
-        # used to find the correct span in the template output
-        attrs = {'data-project-field': 'machine'}
-
-        # find the row for the default project
-        default_project_row = self._get_row_for_project(data, self.default_project.id)
-
-        # check the machine cell for the default project
-        soup = BeautifulSoup(default_project_row['static:machine'])
-        text = soup.find('span', attrs=attrs).select('span.muted')[0].text.strip()
-        self.assertEqual(text, 'Not applicable',
-            'machine should be not applicable for default project')
-
-        # find the row for the default project
-        other_project_row = self._get_row_for_project(data, self.project.id)
-
-        # check the link in the machine cell for the other project
-        soup = BeautifulSoup(other_project_row['static:machine'])
-        text = soup.find('span', attrs=attrs).find('a').text.strip()
-        self.assertEqual(text, self.MACHINE_NAME,
-                         'machine name should be shown for non-default project')
-
-    def test_project_page_links(self):
-        """
-        Test that links for the default project point to the builds
-        page /projects/X/builds for that project, and that links for
-        other projects point to their configuration pages /projects/X/
-        """
-
-        # need a build, otherwise project doesn't display at all
-        self._add_build_to_default_project()
-
-        # another project to test
-        self._add_non_default_project()
-
-        response = self.client.get(
-            reverse('all-projects'),
-            {'format': 'json'},
-            follow=True
-        )
-
-        data = json.loads(response.content)
-
-        # find the row for the default project
-        default_project_row = self._get_row_for_project(data, self.default_project.id)
-
-        # check the link on the name field
-        soup = BeautifulSoup(default_project_row['static:name'])
-        expected_url = reverse('projectbuilds', args=(self.default_project.id,))
-        self.assertEqual(soup.find('a')['href'], expected_url,
-                         'link on default project name should point to builds')
-
-        # find the row for the other project
-        other_project_row = self._get_row_for_project(data, self.project.id)
-
-        # check the link for the other project
-        soup = BeautifulSoup(other_project_row['static:name'])
-        expected_url = reverse('project', args=(self.project.id,))
-        self.assertEqual(soup.find('a')['href'], expected_url,
-                         'link on project name should point to configuration')
-
 class BuildDashboardTests(TestCase):
     """ Tests for the build dashboard /build/X """
 
-- 
2.1.4


