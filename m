Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id 3FC2865C8A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Mar 2016 18:56:06 +0000 (UTC)
Received: by mail-wm0-f51.google.com with SMTP id 20so125427498wmh.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Mar 2016 11:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=9B0EuEzd0gTNLWAhI3m7ha5GBMdOHVGJcLu3H0UL9AM=;
	b=BBFP4Aoba56zTDaPeGrDYGctL1SAuYzkPQsjr8Sq/Za0fpovFDnWG6hvYONGGVZWpb
	vvrbGx9a62kKuhkVdxzgnxhlaJB8d2vUhkX04BlcuT0N+iDMiBiu3+m5yfyhceC7u6xR
	lEpCIVN7kFA5OA7DSU4DJcu8jOIJiH2jiiQym/2XVv2O3XQaWhZtC6IsTozu2hbMh/3Z
	6dJfbNQiqhaWff6PdslF+q/TqHWNJ+mQRFOPoNoPoLUAg8B15f4p/itogPXoZinKoY8T
	LThj6vIaQb2NhkyzHL+g5CCbu0W5tyEQ7OJeoXU+l3Eigy6kF3h6gT/KCOk1OE9OIABF
	OqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=9B0EuEzd0gTNLWAhI3m7ha5GBMdOHVGJcLu3H0UL9AM=;
	b=GtnOkC5zWW/KIbBxTifZbdGbPLgr0bzxAX/zw2U4IScIrzhcKlQbICvJ4Fxr28XfCD
	0NKPr98B/nMAm4LFr7QyEUmBAMeqOInK8hYHelmVciSq6Iz+f90pN974wmt+CdkJ36Ks
	cX4lwzo3rtXGJMOsazv1IuCNZiuaiCQK7F6VZyQM8SrD1T/Vs3aULl3yVgOawsDplAnw
	tNUDjmFUhRdL2B/ZBSF1OWZhTyeA9C8kn35gvf0uZxj2yHu2+TPeN+GrJnvjlmuUlT1U
	kqCRW7G1R1HvRs678DZlXQjJJaLaeQF9OL2zwaP2MDSThL05cTpQTSNQIbfUs/L3oe8u
	fGjw==
X-Gm-Message-State: AD7BkJJgnjZpw+nfZsgYqEbMTQUKGToil0M/QThzloSwdEssre5ONOtbD879cYE4phegClFZ
X-Received: by 10.28.186.196 with SMTP id k187mr3765165wmf.17.1459450567256;
	Thu, 31 Mar 2016 11:56:07 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	fv6sm10406288wjc.12.2016.03.31.11.56.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 31 Mar 2016 11:56:06 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Mar 2016 19:55:47 +0100
Message-Id: <1459450547-26248-5-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1459450547-26248-1-git-send-email-michael.g.wood@intel.com>
References: <1459450547-26248-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 5/5] toaster: tests Migrate landing page tests to Selenium
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
 lib/toaster/tests/browser/test_landing_page.py | 108 +++++++++++++++++++++++++
 lib/toaster/toastergui/tests.py                |  74 -----------------
 2 files changed, 108 insertions(+), 74 deletions(-)
 create mode 100644 lib/toaster/tests/browser/test_landing_page.py

diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster/tests/browser/test_landing_page.py
new file mode 100644
index 0000000..4d4cd66
--- /dev/null
+++ b/lib/toaster/tests/browser/test_landing_page.py
@@ -0,0 +1,108 @@
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
+from orm.models import Project, Build
+
+class TestLandingPage(SeleniumTestCase):
+    """ Tests for redirects on the landing page """
+
+    PROJECT_NAME = 'test project'
+    LANDING_PAGE_TITLE = 'This is Toaster'
+    CLI_BUILDS_PROJECT_NAME = 'command line builds'
+
+    def setUp(self):
+        """ Add default project manually """
+        self.project = Project.objects.create_project(
+            self.CLI_BUILDS_PROJECT_NAME,
+            None
+        )
+        self.project.is_default = True
+        self.project.save()
+
+    def test_only_default_project(self):
+        """
+        No projects except default
+        => should see the landing page
+        """
+        self.get(reverse('landing'))
+        self.assertTrue(self.LANDING_PAGE_TITLE in self.get_page_source())
+
+    def test_default_project_has_build(self):
+        """
+        Default project has a build, no other projects
+        => should see the builds page
+        """
+        now = timezone.now()
+        build = Build.objects.create(project=self.project,
+                                     started_on=now,
+                                     completed_on=now)
+        build.save()
+
+        self.get(reverse('landing'))
+
+        elements = self.find_all('#allbuildstable')
+        self.assertEqual(len(elements), 1, 'should redirect to builds')
+        content = self.get_page_source()
+        self.assertFalse(self.PROJECT_NAME in content,
+                         'should not show builds for project %s' % self.PROJECT_NAME)
+        self.assertTrue(self.CLI_BUILDS_PROJECT_NAME in content,
+                        'should show builds for cli project')
+
+    def test_user_project_exists(self):
+        """
+        User has added a project (without builds)
+        => should see the projects page
+        """
+        user_project = Project.objects.create_project('foo', None)
+        user_project.save()
+
+        self.get(reverse('landing'))
+
+        elements = self.find_all('#projectstable')
+        self.assertEqual(len(elements), 1, 'should redirect to projects')
+
+    def test_user_project_has_build(self):
+        """
+        User has added a project (with builds), command line builds doesn't
+        => should see the builds page
+        """
+        user_project = Project.objects.create_project(self.PROJECT_NAME, None)
+        user_project.save()
+
+        now = timezone.now()
+        build = Build.objects.create(project=user_project,
+                                     started_on=now,
+                                     completed_on=now)
+        build.save()
+
+        self.get(reverse('landing'))
+
+        elements = self.find_all('#allbuildstable')
+        self.assertEqual(len(elements), 1, 'should redirect to builds')
+        content = self.get_page_source()
+        self.assertTrue(self.PROJECT_NAME in content,
+                        'should show builds for project %s' % self.PROJECT_NAME)
+        self.assertFalse(self.CLI_BUILDS_PROJECT_NAME in content,
+                         'should not show builds for cli project')
diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 6975ac1..eebd1b7 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -493,80 +493,6 @@ class ViewTests(TestCase):
                                 "Changed page on table %s but first row is the "
                                 "same as the previous page" % name)
 
-class LandingPageTests(TestCase):
-    """ Tests for redirects on the landing page """
-    # disable bogus pylint message error:
-    # "Instance of 'WSGIRequest' has no 'url' member (no-member)"
-    # (see https://github.com/landscapeio/pylint-django/issues/42)
-    # pylint: disable=E1103
-
-    LANDING_PAGE_TITLE = 'This is Toaster'
-
-    def setUp(self):
-        """ Add default project manually """
-        self.project = Project.objects.create_project('foo', None)
-        self.project.is_default = True
-        self.project.save()
-
-    def test_only_default_project(self):
-        """
-        No projects except default
-        => get the landing page
-        """
-        response = self.client.get(reverse('landing'))
-        self.assertTrue(self.LANDING_PAGE_TITLE in response.content)
-
-    def test_default_project_has_build(self):
-        """
-        Default project has a build, no other projects
-        => get the builds page
-        """
-        now = timezone.now()
-        build = Build.objects.create(project=self.project,
-                                     started_on=now,
-                                     completed_on=now)
-        build.save()
-
-        response = self.client.get(reverse('landing'))
-        self.assertEqual(response.status_code, 302,
-                         'response should be a redirect')
-        self.assertTrue('/builds' in response.url,
-                        'should redirect to builds')
-
-    def test_user_project_exists(self):
-        """
-        User has added a project (without builds)
-        => get the projects page
-        """
-        user_project = Project.objects.create_project('foo', None)
-        user_project.save()
-
-        response = self.client.get(reverse('landing'))
-        self.assertEqual(response.status_code, 302,
-                         'response should be a redirect')
-        self.assertTrue('/projects' in response.url,
-                        'should redirect to projects')
-
-    def test_user_project_has_build(self):
-        """
-        User has added a project (with builds)
-        => get the builds page
-        """
-        user_project = Project.objects.create_project('foo', None)
-        user_project.save()
-
-        now = timezone.now()
-        build = Build.objects.create(project=user_project,
-                                     started_on=now,
-                                     completed_on=now)
-        build.save()
-
-        response = self.client.get(reverse('landing'))
-        self.assertEqual(response.status_code, 302,
-                         'response should be a redirect')
-        self.assertTrue('/builds' in response.url,
-                        'should redirect to builds')
-
 class BuildDashboardTests(TestCase):
     """ Tests for the build dashboard /build/X """
 
-- 
2.1.4


