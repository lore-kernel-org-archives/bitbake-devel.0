Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id A972C77046
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 12:49:19 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga102.fm.intel.com with ESMTP; 15 Oct 2015 05:49:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,685,1437462000"; d="scan'208";a="664924445"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga003.jf.intel.com with ESMTP; 15 Oct 2015 05:49:20 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id BC1956A4083
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 05:48:20 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Oct 2015 15:45:16 +0300
Message-Id: <355ebfff2a5145d117aa8122cb7efdf6917eeeeb.1444910218.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1444910218.git.ed.bartosh@linux.intel.com>
References: <cover.1444910218.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1444910218.git.ed.bartosh@linux.intel.com>
References: <cover.1444910218.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 4/4] toaster: Add tests for error message display on the build dashboard
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
X-List-Received-Date: Thu, 15 Oct 2015 12:49:19 -0000

From: Elliot Smith <elliot.smith@intel.com>

Add tests to ensure that log messages with CRITICAL level and
with EXCEPTION level are shown in the main errors display
on the build dashboard.

[YOCTO #8320]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/tests.py | 91 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 7c4bd39..29dd7fd 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -26,15 +26,15 @@ from django.test.client import RequestFactory
 from django.core.urlresolvers import reverse
 from django.utils import timezone
 
-from orm.models import Project, Release, BitbakeVersion, Package
+from orm.models import Project, Release, BitbakeVersion, Package, LogMessage
 from orm.models import ReleaseLayerSourcePriority, LayerSource, Layer, Build
 from orm.models import Layer_Version, Recipe, Machine, ProjectLayer, Target
 from orm.models import CustomImageRecipe, ProjectVariable
 from orm.models import Branch
 
 from toastergui.tables import SoftwareRecipesTable
-from bs4 import BeautifulSoup
 import json
+from bs4 import BeautifulSoup
 import re
 
 PROJECT_NAME = "test project"
@@ -832,3 +832,90 @@ class ProjectPageTests(TestCase):
         response = self.client.get(url, follow=True)
 
         self.assertEqual(response.status_code, 200)
+
+class BuildDashboardTests(TestCase):
+    """ Tests for the build dashboard /build/X """
+
+    def setUp(self):
+        bbv = BitbakeVersion.objects.create(name="bbv1", giturl="/tmp/",
+                                            branch="master", dirpath="")
+        release = Release.objects.create(name="release1",
+                                         bitbake_version=bbv)
+        project = Project.objects.create_project(name=PROJECT_NAME,
+                                                 release=release)
+
+        now = timezone.now()
+
+        self.build1 = Build.objects.create(project=project,
+                                           started_on=now,
+                                           completed_on=now)
+
+        # exception
+        msg1 = 'an exception was thrown'
+        self.exception_message = LogMessage.objects.create(
+            build=self.build1,
+            level=LogMessage.EXCEPTION,
+            message=msg1
+        )
+
+        # critical
+        msg2 = 'a critical error occurred'
+        self.critical_message = LogMessage.objects.create(
+            build=self.build1,
+            level=LogMessage.CRITICAL,
+            message=msg2
+        )
+
+    def _get_build_dashboard_errors(self):
+        """
+        Get a list of HTML fragments representing the errors on the
+        build dashboard
+        """
+        url = reverse('builddashboard', args=(self.build1.id,))
+        response = self.client.get(url)
+        soup = BeautifulSoup(response.content)
+        return soup.select('#errors div.alert-error')
+
+    def _check_for_log_message(self, log_message):
+        """
+        Check whether the LogMessage instance <log_message> is
+        represented as an HTML error in the build dashboard page
+        """
+        errors = self._get_build_dashboard_errors()
+        self.assertEqual(len(errors), 2)
+
+        expected_text = log_message.message
+        expected_id = str(log_message.id)
+
+        found = False
+        for error in errors:
+            error_text = error.find('pre').text
+            text_matches = (error_text == expected_text)
+
+            error_id = error['data-error']
+            id_matches = (error_id == expected_id)
+
+            if text_matches and id_matches:
+                found = True
+                break
+
+        template_vars = (expected_text, error_text,
+                         expected_id, error_id)
+        assertion_error_msg = 'exception not found as error: ' \
+            'expected text "%s" and got "%s"; ' \
+            'expected ID %s and got %s' % template_vars
+        self.assertTrue(found, assertion_error_msg)
+
+    def test_exceptions_show_as_errors(self):
+        """
+        LogMessages with level EXCEPTION should display in the errors
+        section of the page
+        """
+        self._check_for_log_message(self.exception_message)
+
+    def test_criticals_show_as_errors(self):
+        """
+        LogMessages with level CRITICAL should display in the errors
+        section of the page
+        """
+        self._check_for_log_message(self.critical_message)
-- 
2.1.4


