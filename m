Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
	by mail.openembedded.org (Postfix) with ESMTP id 755C473285
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 May 2016 23:02:02 +0000 (UTC)
Received: by mail-wm0-f50.google.com with SMTP id a17so211764379wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 May 2016 16:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=qSxIQQvlud4CHUU8PpCn5dUE6BCXxLKe8UOX4nN9jgM=;
	b=wn62S7SjyqSYiL7eZ8bBbAOnw1UA9ED3vM2N08Knhr4JD5YtmrdAgKbuih+1P9qujO
	S7uL/sXUgMsx/LuZc5/KJhm/ZGNyIpPSZTEh8rJrn/P6i9oYxwonmbOxKX59FUbAJ0Ft
	jQNRFwExJFDmyhPsAKEdi0ZJUlSJokxViiHo9Pk5ePWwUeWn1nWmDkztBImc1UaE1KsH
	uYsKq42BCoI3MfLK98lqbffdZDiLpz+CNBhzXL6bmZ96O6EIw/i5h+yeZbgBmEGY1ygl
	z9Gd1knanKr4Zh8kRiV0r5f1kj5SvpQx6wLb3W29UtF3re8zH5w2EgZnKtwvKlflooM3
	bz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=qSxIQQvlud4CHUU8PpCn5dUE6BCXxLKe8UOX4nN9jgM=;
	b=exPZ8TXGHPaNKUNF8+cA+HEfm8nulsOh86oi3CVTy5FQt6DdU+G/dFg9s3sFBE3fz4
	ggCTm+SUZJrYKlxGhoLQZsBfHAMhqft+M7MTL0jLPaufD/nvyU5L+f8U2AqHkkAxZcgS
	eMYrgVVq51e6SLO59MD8CIRqi2ONuP0I9ch3giK1pQ+ItkXbN0LrjJmekbeuvWeS+Di3
	p/1fytrFP8Vzyh/ReP0rN95wQZk2blM5FqWsxmVGH61MsZY2XIqZ/0962Uu1Zr9iEazt
	mwlxIm9sE5e+FxyR6jDsMytyXd8rf0lZlkvHi7R/JqM9VGZ+zishEu75yBP55vJ6n1aY
	5HLA==
X-Gm-Message-State: AOPr4FVZY888LRZ0hTYxH+ZhqOxFw5XulGB8CpwBLEQMoJDgm2XKGhHXcf01mGtTHkom61gr
X-Received: by 10.194.80.162 with SMTP id s2mr35710889wjx.116.1462834923397;
	Mon, 09 May 2016 16:02:03 -0700 (PDT)
Received: from orion.home (host109-151-244-175.range109-151.btcentralplus.com.
	[109.151.244.175]) by smtp.gmail.com with ESMTPSA id
	b22sm27111436wmb.9.2016.05.09.16.02.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 09 May 2016 16:02:02 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 May 2016 00:01:52 +0100
Message-Id: <1462834912-23449-6-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1462834912-23449-1-git-send-email-michael.g.wood@intel.com>
References: <1462834912-23449-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 5/5] toaster: tests browser Add test for creating a project
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
X-List-Received-Date: Mon, 09 May 2016 23:02:05 -0000

Add browser tests for creating a project and test validation of
duplicate project names.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/tests/browser/test_new_project_page.py | 109 +++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 lib/toaster/tests/browser/test_new_project_page.py

diff --git a/lib/toaster/tests/browser/test_new_project_page.py b/lib/toaster/tests/browser/test_new_project_page.py
new file mode 100644
index 0000000..1b038ac
--- /dev/null
+++ b/lib/toaster/tests/browser/test_new_project_page.py
@@ -0,0 +1,109 @@
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
+from tests.browser.selenium_helpers import SeleniumTestCase
+from selenium.webdriver.support.ui import Select
+
+from orm.models import Project, Release, BitbakeVersion
+
+
+class TestNewProjectPage(SeleniumTestCase):
+    """ Test project data at /project/X/ is displayed correctly """
+
+    def setUp(self):
+        bitbake, c = BitbakeVersion.objects.get_or_create(
+            name="master",
+            giturl="git://master",
+            branch="master",
+            dirpath="master")
+
+        release, c = Release.objects.get_or_create(name="msater",
+                                                   description="master"
+                                                   "release",
+                                                   branch_name="master",
+                                                   helptext="latest",
+                                                   bitbake_version=bitbake)
+
+        self.release, c = Release.objects.get_or_create(
+            name="msater2",
+            description="master2"
+            "release2",
+            branch_name="master2",
+            helptext="latest2",
+            bitbake_version=bitbake)
+
+    def test_create_new_project(self):
+        """ Test creating a project """
+
+        project_name = "masterproject"
+
+        url = reverse('newproject')
+        self.get(url)
+
+        self.enter_text('#new-project-name', project_name)
+
+        select = Select(self.find('#projectversion'))
+        select.select_by_value(str(self.release.pk))
+
+        self.click("#create-project-button")
+
+        # We should get redirected to the new project's page with the
+        # notification at the top
+        element = self.wait_until_visible('#project-created-notification')
+
+        self.assertTrue(project_name in element.text,
+                        "New project name not in new project notification")
+
+        self.assertTrue(Project.objects.filter(name=project_name).count(),
+                        "New project not found in database")
+
+    def test_new_duplicates_project_name(self):
+        """
+        Should not be able to create a new project whose name is the same
+        as an existing project
+       """
+
+        project_name = "dupproject"
+
+        Project.objects.create_project(name=project_name,
+                                       release=self.release)
+
+        url = reverse('newproject')
+        self.get(url)
+
+        self.enter_text('#new-project-name', project_name)
+
+        select = Select(self.find('#projectversion'))
+        select.select_by_value(str(self.release.pk))
+
+        element = self.wait_until_visible('#hint-error-project-name')
+
+        self.assertTrue(("Project names must be unique" in element.text),
+                        "Did not find unique project name error message")
+
+        # Try and click it anyway, if it submits we'll have a new project in
+        # the db and assert then
+        self.click("#create-project-button")
+
+        self.assertTrue(
+            (Project.objects.filter(name=project_name).count() == 1),
+            "New project not found in database")
-- 
2.7.4


