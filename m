Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 42E9E731CA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 16:00:10 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga104.fm.intel.com with ESMTP; 21 Jul 2016 09:00:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,399,1464678000"; d="scan'208";a="1011345084"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2016 09:00:12 -0700
Received: from ed.fi.intel.com (ed.fi.intel.com [10.237.72.179])
	by linux.intel.com (Postfix) with ESMTP id 257CB6A4006
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 09:00:00 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2016 18:58:40 +0300
Message-Id: <4543441cd3cef170bfcb5cfe803988989d500ed6.1469116389.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <cover.1469116389.git.ed.bartosh@linux.intel.com>
References: <cover.1469116389.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1469116389.git.ed.bartosh@linux.intel.com>
References: <cover.1469116389.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 3/3] toaster-tests: add tasks and recipes sub-page tests
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
X-List-Received-Date: Thu, 21 Jul 2016 16:00:10 -0000

From: Elliot Smith <elliot.smith@intel.com>

Add tests for the tasks and recipes sub-pages of the build
dashboard.

[YOCTO #9833]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 .../browser/test_builddashboard_page_recipes.py    | 66 ++++++++++++++++++++++
 .../browser/test_builddashboard_page_tasks.py      | 65 +++++++++++++++++++++
 2 files changed, 131 insertions(+)
 create mode 100644 bitbake/lib/toaster/tests/browser/test_builddashboard_page_recipes.py
 create mode 100644 bitbake/lib/toaster/tests/browser/test_builddashboard_page_tasks.py

diff --git a/bitbake/lib/toaster/tests/browser/test_builddashboard_page_recipes.py b/bitbake/lib/toaster/tests/browser/test_builddashboard_page_recipes.py
new file mode 100644
index 0000000..ed18324
--- /dev/null
+++ b/bitbake/lib/toaster/tests/browser/test_builddashboard_page_recipes.py
@@ -0,0 +1,66 @@
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
+from orm.models import Project, Build, Recipe, Task, Layer, Layer_Version
+from orm.models import Target
+
+class TestBuilddashboardPageRecipes(SeleniumTestCase):
+    """ Test build dashboard recipes sub-page """
+
+    def setUp(self):
+        project = Project.objects.get_or_create_default_project()
+
+        now = timezone.now()
+
+        self.build = Build.objects.create(project=project,
+                                          started_on=now,
+                                          completed_on=now)
+
+        layer = Layer.objects.create()
+
+        layer_version = Layer_Version.objects.create(layer=layer,
+            build=self.build)
+
+        recipe = Recipe.objects.create(layer_version=layer_version)
+
+        task = Task.objects.create(build=self.build, recipe=recipe, order=1)
+
+        Target.objects.create(build=self.build, task=task, target='do_build')
+
+    def test_build_recipes_columns(self):
+        """
+        Check that non-hideable columns of the table on the recipes sub-page
+        are disabled on the edit columns dropdown.
+        """
+        url = reverse('recipes', args=(self.build.id,))
+        self.get(url)
+
+        self.wait_until_visible('#edit-columns-button')
+
+        # check that options for the non-hideable columns are disabled
+        non_hideable = ['name', 'version']
+
+        for column in non_hideable:
+            selector = 'input#checkbox-%s[disabled="disabled"]' % column
+            self.wait_until_present(selector)
diff --git a/bitbake/lib/toaster/tests/browser/test_builddashboard_page_tasks.py b/bitbake/lib/toaster/tests/browser/test_builddashboard_page_tasks.py
new file mode 100644
index 0000000..da50f16
--- /dev/null
+++ b/bitbake/lib/toaster/tests/browser/test_builddashboard_page_tasks.py
@@ -0,0 +1,65 @@
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
+from orm.models import Project, Build, Recipe, Task, Layer, Layer_Version
+from orm.models import Target
+
+class TestBuilddashboardPageTasks(SeleniumTestCase):
+    """ Test build dashboard tasks sub-page """
+
+    def setUp(self):
+        project = Project.objects.get_or_create_default_project()
+
+        now = timezone.now()
+
+        self.build = Build.objects.create(project=project,
+                                          started_on=now,
+                                          completed_on=now)
+
+        layer = Layer.objects.create()
+
+        layer_version = Layer_Version.objects.create(layer=layer)
+
+        recipe = Recipe.objects.create(layer_version=layer_version)
+
+        task = Task.objects.create(build=self.build, recipe=recipe, order=1)
+
+        Target.objects.create(build=self.build, task=task, target='do_build')
+
+    def test_build_tasks_columns(self):
+        """
+        Check that non-hideable columns of the table on the tasks sub-page
+        are disabled on the edit columns dropdown.
+        """
+        url = reverse('tasks', args=(self.build.id,))
+        self.get(url)
+
+        self.wait_until_visible('#edit-columns-button')
+
+        # check that options for the non-hideable columns are disabled
+        non_hideable = ['order', 'task_name', 'recipe__name']
+
+        for column in non_hideable:
+            selector = 'input#checkbox-%s[disabled="disabled"]' % column
+            self.wait_until_present(selector)
-- 
2.6.6


