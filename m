Return-Path: <brian.avery@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 3A3AD731E3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jul 2016 22:53:56 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 12 Jul 2016 15:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,354,1464678000"; d="scan'208";a="1015672982"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga002.jf.intel.com with ESMTP; 12 Jul 2016 15:53:44 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Jul 2016 15:54:56 -0700
Message-Id: <50991db21dadcf54a04a9528db6676cbb1a08544.1468363530.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
References: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
In-Reply-To: <cover.1468363530.git.brian.avery@intel.com>
References: <cover.1468363530.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 15/17] toaster-tests: add tests for build artifact display on build dashboard
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

Add tests for display of image, kernel and SDK artifacts on the
build dashboard, checking that the "Images" option in the left-hand
menu and the "Build artifacts" section display correctly for
different types of build.

Also add metadata to elements on the build dashboard so it's clearer
what they represent, and to assist in finding them in the tests.

Add a method to the test helper to make it more convenient to check
whether a single element matching a selector exists.

[YOCTO #8556]
[YOCTO #8563]
[YOCTO #9500]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 lib/toaster/tests/browser/selenium_helpers.py      |   7 +
 .../browser/test_builddashboard_page_artifacts.py  | 177 +++++++++++++++++++++
 .../toastergui/templates/basebuildpage.html        |   2 +-
 .../toastergui/templates/builddashboard.html       |  12 +-
 4 files changed, 191 insertions(+), 7 deletions(-)
 create mode 100644 bitbake/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py

diff --git a/lib/toaster/tests/browser/selenium_helpers.py b/lib/toaster/tests/browser/selenium_helpers.py
index 000937f..ef07858 100644
--- a/lib/toaster/tests/browser/selenium_helpers.py
+++ b/lib/toaster/tests/browser/selenium_helpers.py
@@ -163,6 +163,13 @@ class SeleniumTestCase(StaticLiveServerTestCase):
         """ Find all elements matching CSS selector """
         return self.driver.find_elements_by_css_selector(selector)
 
+    def element_exists(self, selector):
+        """
+        Return True if one element matching selector exists,
+        False otherwise
+        """
+        return len(self.find_all(selector)) == 1
+
     def focused_element(self):
         """ Return the element which currently has focus on the page """
         return self.driver.switch_to.active_element
diff --git a/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py b/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
new file mode 100644
index 0000000..18e4475
--- /dev/null
+++ b/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
@@ -0,0 +1,177 @@
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
+
+from tests.browser.selenium_helpers import SeleniumTestCase
+
+from orm.models import Project, Release, BitbakeVersion, Build, Target
+from orm.models import Target_Image_File, TargetSDKFile, TargetKernelFile
+
+class TestBuildDashboardPageArtifacts(SeleniumTestCase):
+    """ Tests for artifacts on the build dashboard /build/X """
+
+    def setUp(self):
+        bbv = BitbakeVersion.objects.create(name='bbv1', giturl='/tmp/',
+                                            branch='master', dirpath="")
+        release = Release.objects.create(name='release1',
+                                         bitbake_version=bbv)
+        self.project = Project.objects.create_project(name='test project',
+                                                      release=release)
+
+    def _get_build_dashboard(self, build):
+        """
+        Navigate to the build dashboard for build
+        """
+        url = reverse('builddashboard', args=(build.id,))
+        self.get(url)
+
+    def _has_build_artifacts_heading(self):
+        """
+        Check whether the "Build artifacts" heading is visible (True if it
+        is, False otherwise).
+        """
+        return self.element_exists('[data-heading="build-artifacts"]')
+
+    def _has_images_menu_option(self):
+        """
+        Try to get the "Images" list element from the left-hand menu in the
+        build dashboard, and return True if it is present, False otherwise.
+        """
+        return self.element_exists('li.nav-header[data-menu-heading="images"]')
+
+    def test_no_artifacts(self):
+        """
+        If a build produced no artifacts, the artifacts heading and images
+        menu option shouldn't show.
+        """
+        now = timezone.now()
+        build = Build.objects.create(project=self.project,
+            started_on=now, completed_on=now, outcome=Build.SUCCEEDED)
+
+        Target.objects.create(is_image=False, build=build, task='',
+            target='mpfr-native')
+
+        self._get_build_dashboard(build)
+
+        # check build artifacts heading
+        msg = 'Build artifacts heading should not be displayed for non-image' \
+            'builds'
+        self.assertFalse(self._has_build_artifacts_heading(), msg)
+
+        # check "Images" option in left-hand menu (should not be there)
+        msg = 'Images option should not be shown in left-hand menu'
+        self.assertFalse(self._has_images_menu_option(), msg)
+
+    def test_sdk_artifacts(self):
+        """
+        If a build produced SDK artifacts, they should be shown, but the section
+        for image files and the images menu option should be hidden.
+        """
+        now = timezone.now()
+        build = Build.objects.create(project=self.project,
+            started_on=now, completed_on=timezone.now(),
+            outcome=Build.SUCCEEDED)
+
+        target = Target.objects.create(is_image=True, build=build,
+            task='populate_sdk', target='core-image-minimal')
+
+        sdk_file1 = TargetSDKFile.objects.create(target=target,
+            file_size=100000,
+            file_name='/home/foo/core-image-minimal.toolchain.sh')
+
+        sdk_file2 = TargetSDKFile.objects.create(target=target,
+            file_size=120000,
+            file_name='/home/foo/x86_64.toolchain.sh')
+
+        self._get_build_dashboard(build)
+
+        # check build artifacts heading
+        msg = 'Build artifacts heading should be displayed for SDK ' \
+            'builds which generate artifacts'
+        self.assertTrue(self._has_build_artifacts_heading(), msg)
+
+        # check "Images" option in left-hand menu (should not be there)
+        msg = 'Images option should not be shown in left-hand menu for ' \
+            'builds which didn\'t generate an image file'
+        self.assertFalse(self._has_images_menu_option(), msg)
+
+        # check links to SDK artifacts
+        sdk_artifact_links = self.find_all('[data-links="sdk-artifacts"] li')
+        self.assertEqual(len(sdk_artifact_links), 2,
+            'should be links to 2 SDK artifacts')
+
+    def test_image_artifacts(self):
+        """
+        If a build produced image files, kernel artifacts, and manifests,
+        they should all be shown, as well as the image link in the left-hand
+        menu.
+        """
+        now = timezone.now()
+        build = Build.objects.create(project=self.project,
+            started_on=now, completed_on=timezone.now(),
+            outcome=Build.SUCCEEDED)
+
+        target = Target.objects.create(is_image=True, build=build,
+            task='', target='core-image-minimal',
+            license_manifest_path='/home/foo/license.manifest',
+            package_manifest_path='/home/foo/package.manifest')
+
+        image_file = Target_Image_File.objects.create(target=target,
+            file_name='/home/foo/core-image-minimal.ext4', file_size=9000)
+
+        kernel_file1 = TargetKernelFile.objects.create(target=target,
+            file_name='/home/foo/bzImage', file_size=2000)
+
+        kernel_file2 = TargetKernelFile.objects.create(target=target,
+            file_name='/home/foo/bzImage', file_size=2000)
+
+        self._get_build_dashboard(build)
+
+        # check build artifacts heading
+        msg = 'Build artifacts heading should be displayed for image ' \
+            'builds'
+        self.assertTrue(self._has_build_artifacts_heading(), msg)
+
+        # check "Images" option in left-hand menu (should be there)
+        msg = 'Images option should be shown in left-hand menu for image builds'
+        self.assertTrue(self._has_images_menu_option(), msg)
+
+        # check link to image file
+        selector = '[data-links="image-artifacts"] li'
+        self.assertTrue(self.element_exists(selector),
+            'should be a link to the image file (selector %s)' % selector)
+
+        # check links to kernel artifacts
+        kernel_artifact_links = \
+            self.find_all('[data-links="kernel-artifacts"] li')
+        self.assertEqual(len(kernel_artifact_links), 2,
+            'should be links to 2 kernel artifacts')
+
+        # check manifest links
+        selector = 'a[data-link="license-manifest"]'
+        self.assertTrue(self.element_exists(selector),
+            'should be a link to the license manifest (selector %s)' % selector)
+
+        selector = 'a[data-link="package-manifest"]'
+        self.assertTrue(self.element_exists(selector),
+            'should be a link to the package manifest (selector %s)' % selector)
diff --git a/lib/toaster/toastergui/templates/basebuildpage.html b/lib/toaster/toastergui/templates/basebuildpage.html
index eb709bb..44749bf 100644
--- a/lib/toaster/toastergui/templates/basebuildpage.html
+++ b/lib/toaster/toastergui/templates/basebuildpage.html
@@ -63,7 +63,7 @@
           <a  href="{% url 'builddashboard' build.pk %}">Build summary</a>
         </li>
         {% if build.has_images and build.outcome == build.SUCCEEDED %}
-          <li class="nav-header">Images</li>
+          <li class="nav-header" data-menu-heading="images">Images</li>
           {% block nav-target %}
             {% for t in build.get_sorted_target_list %}
               {% if t.has_images %}
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index 36c28b7..bc41e23 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -70,7 +70,7 @@
 {%if build.outcome == build.SUCCEEDED%}
 <!-- built images -->
   {% if hasArtifacts %}
-    <h2>Build artifacts</h2>
+    <h2 data-heading="build-artifacts">Build artifacts</h2>
     {% for target in targets %}
         {% if target.target.is_image %}
     <div class="well well-transparent dashboard-section" data-artifacts-for-target="{{target.target.pk}}">
@@ -88,12 +88,12 @@
             </dt>
 
             <dd>
-              <a href="{% url 'build_artifact' build.pk 'licensemanifest' target.target.pk %}">License manifest</a>
+              <a data-link="license-manifest" href="{% url 'build_artifact' build.pk 'licensemanifest' target.target.pk %}">License manifest</a>
             </dd>
 
             {% if target.target.package_manifest_path %}
               <dd>
-                <a href="{% url 'build_artifact' build.pk 'packagemanifest' target.target.pk %}">Package manifest</a>
+                <a data-link="package-manifest" href="{% url 'build_artifact' build.pk 'packagemanifest' target.target.pk %}">Package manifest</a>
               </dd>
             {% endif %}
           </dl>
@@ -104,7 +104,7 @@
                 Image files
             </dt>
             <dd>
-                <ul class="list-unstyled">
+                <ul class="list-unstyled" data-links="image-artifacts">
                     {% for i in target.imageFiles|dictsort:"suffix" %}
                         <li>
                             <a href="{% url 'build_artifact' build.pk 'imagefile' i.id %}">
@@ -119,7 +119,7 @@
                 Kernel artifacts
             </dt>
             <dd>
-                <ul class="list-unstyled">
+                <ul class="list-unstyled" data-links="kernel-artifacts">
                     {% for artifact in target.target_kernel_artifacts|dictsort:"basename" %}
                         <li>
                             <a href="{% url 'build_artifact' build.id 'targetkernelartifact' artifact.id %}">{{artifact.basename}}</a>
@@ -136,7 +136,7 @@
               SDK artifacts
             </dt>
             <dd>
-              <ul class="list-unstyled">
+              <ul class="list-unstyled" data-links="sdk-artifacts">
                 {% for artifact in target.target_sdk_artifacts|dictsort:"basename" %}
                 <li>
                   <a href="{% url 'build_artifact' build.id 'targetsdkartifact' artifact.id %}">{{artifact.basename}}</a>
-- 
1.9.1


