Return-Path: <brian.avery@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 4E57A731CD
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jul 2016 22:53:56 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 12 Jul 2016 15:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,354,1464678000"; d="scan'208";a="1015672987"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga002.jf.intel.com with ESMTP; 12 Jul 2016 15:53:44 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Jul 2016 15:54:58 -0700
Message-Id: <5d26b89dab09d52eeec9c6b6635d5a0dbab5c738.1468363530.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
References: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
In-Reply-To: <cover.1468363530.git.brian.avery@intel.com>
References: <cover.1468363530.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 17/17] toaster-tests: package count/size shouldn't show for non-image builds
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
X-List-Received-Date: Tue, 12 Jul 2016 22:53:58 -0000

From: Elliot Smith <elliot.smith@intel.com>

If a build doesn't produce any image files, the package count
and size shouldn't be shown.

Also add some metadata to build dashboard elements so it is clear
what they're for, and so they can be queried by the tests.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 .../browser/test_builddashboard_page_artifacts.py  | 42 +++++++++++++++++++++-
 .../toastergui/templates/builddashboard.html       | 29 +++++++++++----
 2 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py b/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
index 18e4475..39b0e20 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
@@ -24,8 +24,9 @@ from django.utils import timezone
 
 from tests.browser.selenium_helpers import SeleniumTestCase
 
-from orm.models import Project, Release, BitbakeVersion, Build, Target
+from orm.models import Project, Release, BitbakeVersion, Build, Target, Package
 from orm.models import Target_Image_File, TargetSDKFile, TargetKernelFile
+from orm.models import Target_Installed_Package
 
 class TestBuildDashboardPageArtifacts(SeleniumTestCase):
     """ Tests for artifacts on the build dashboard /build/X """
@@ -86,6 +87,8 @@ class TestBuildDashboardPageArtifacts(SeleniumTestCase):
         """
         If a build produced SDK artifacts, they should be shown, but the section
         for image files and the images menu option should be hidden.
+
+        The packages count and size should also be hidden.
         """
         now = timezone.now()
         build = Build.objects.create(project=self.project,
@@ -120,11 +123,28 @@ class TestBuildDashboardPageArtifacts(SeleniumTestCase):
         self.assertEqual(len(sdk_artifact_links), 2,
             'should be links to 2 SDK artifacts')
 
+        # package count and size should not be visible, no link on
+        # target name
+        selector = '[data-value="target-package-count"]'
+        self.assertFalse(self.element_exists(selector),
+            'package count should not be shown for non-image builds')
+
+        selector = '[data-value="target-package-size"]'
+        self.assertFalse(self.element_exists(selector),
+            'package size should not be shown for non-image builds')
+
+        selector = '[data-link="target-packages"]'
+        self.assertFalse(self.element_exists(selector),
+            'link to target packages should not be on target heading')
+
     def test_image_artifacts(self):
         """
         If a build produced image files, kernel artifacts, and manifests,
         they should all be shown, as well as the image link in the left-hand
         menu.
+
+        The packages count and size should be shown, with a link to the
+        package display page.
         """
         now = timezone.now()
         build = Build.objects.create(project=self.project,
@@ -145,6 +165,11 @@ class TestBuildDashboardPageArtifacts(SeleniumTestCase):
         kernel_file2 = TargetKernelFile.objects.create(target=target,
             file_name='/home/foo/bzImage', file_size=2000)
 
+        package = Package.objects.create(build=build, name='foo', size=1024,
+            installed_name='foo1')
+        installed_package = Target_Installed_Package.objects.create(
+            target=target, package=package)
+
         self._get_build_dashboard(build)
 
         # check build artifacts heading
@@ -175,3 +200,18 @@ class TestBuildDashboardPageArtifacts(SeleniumTestCase):
         selector = 'a[data-link="package-manifest"]'
         self.assertTrue(self.element_exists(selector),
             'should be a link to the package manifest (selector %s)' % selector)
+
+        # check package count and size, link on target name
+        selector = '[data-value="target-package-count"]'
+        element = self.find(selector)
+        self.assertEquals(element.text, '1',
+            'package count should be shown for image builds')
+
+        selector = '[data-value="target-package-size"]'
+        element = self.find(selector)
+        self.assertEquals(element.text, '1.0 KB',
+            'package size should be shown for image builds')
+
+        selector = '[data-link="target-packages"]'
+        self.assertTrue(self.element_exists(selector),
+            'link to target packages should be on target heading')
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index bc41e23..07fc26c 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -74,13 +74,28 @@
     {% for target in targets %}
         {% if target.target.is_image %}
     <div class="well well-transparent dashboard-section" data-artifacts-for-target="{{target.target.pk}}">
-        <h3><a href="{% url 'target' build.pk target.target.pk %}">{{target.target.target}}</a></h3>
-        <dl class="dl-horizontal">
-            <dt>Packages included</dt>
-            <dd><a href="{% url 'target' build.pk target.target.pk %}">{{target.npkg}}</a></dd>
-            <dt>Total package size</dt>
-            <dd>{{target.pkgsz|filtered_filesizeformat}}</dd>
-        </dl>
+        {% if target.npkg > 0 %}
+            <h3>
+                <a href="{% url 'target' build.pk target.target.pk %}" data-link="target-packages">
+                  {{target.target.target}}
+                </a>
+            </h3>
+            <dl class="dl-horizontal">
+                <dt>Packages included</dt>
+                <dd>
+                    <a href="{% url 'target' build.pk target.target.pk %}">
+                        <span data-value="target-package-count">{{target.npkg}}</span>
+                    </a>
+                </dd>
+                <dt>Total package size</dt>
+                <dd>
+                    <span data-value="target-package-size">{{target.pkgsz|filtered_filesizeformat}}</span>
+                </dd>
+            </dl>
+        {% else %}
+            <h3>{{target.target.target}}</h3>
+        {% endif %}
+
         {% if target.targetHasImages %}
           <dl class="dl-horizontal">
             <dt>
-- 
1.9.1


