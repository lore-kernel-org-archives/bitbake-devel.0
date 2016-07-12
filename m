Return-Path: <brian.avery@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 456B2731CA
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jul 2016 22:53:56 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 12 Jul 2016 15:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,354,1464678000"; d="scan'208";a="1015672985"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga002.jf.intel.com with ESMTP; 12 Jul 2016 15:53:44 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Jul 2016 15:54:57 -0700
Message-Id: <50c1c1695436fe1bcc20114755ee63e9f679b127.1468363530.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
References: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
In-Reply-To: <cover.1468363530.git.brian.avery@intel.com>
References: <cover.1468363530.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 16/17] toaster-tests: new custom image button shouldn't show for non-image builds
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

[YOCTO #9514]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 .../tests/browser/test_builddashboard_page.py        | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/lib/toaster/tests/browser/test_builddashboard_page.py b/lib/toaster/tests/browser/test_builddashboard_page.py
index cdb0616..14e77a3 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page.py
@@ -48,6 +48,10 @@ class TestBuildDashboardPage(SeleniumTestCase):
                                            started_on=now,
                                            completed_on=now)
 
+        self.build3 = Build.objects.create(project=project,
+                                           started_on=now,
+                                           completed_on=now)
+
         # exception
         msg1 = 'an exception was thrown'
         self.exception_message = LogMessage.objects.create(
@@ -71,6 +75,11 @@ class TestBuildDashboardPage(SeleniumTestCase):
             layer=layer, build=self.build1
         )
 
+        # non-image recipes related to a build, for testing the new custom
+        # image button
+        layer_version2 = Layer_Version.objects.create(layer=layer,
+            build=self.build3)
+
         # image recipes
         self.image_recipe1 = Recipe.objects.create(
             name='recipeA',
@@ -248,3 +257,14 @@ class TestBuildDashboardPage(SeleniumTestCase):
         ]
 
         self._check_labels_in_modal(modal, expected_recipes)
+
+    def test_new_custom_image_button_no_image(self):
+        """
+        Check that a build which builds non-image recipes doesn't show
+        the new custom image button on the dashboard.
+        """
+        self._get_build_dashboard(self.build3)
+        selector = '[data-role="new-custom-image-trigger"]'
+        self.assertFalse(self.element_exists(selector),
+            'new custom image button should not show for builds which ' \
+            'don\'t have any image recipes')
-- 
1.9.1


