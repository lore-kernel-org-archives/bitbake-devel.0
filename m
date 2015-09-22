Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 90F9876417
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Sep 2015 09:35:11 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 22 Sep 2015 02:35:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,572,1437462000"; d="scan'208";a="810261814"
Received: from martinbu-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.21.229])
	by fmsmga002.fm.intel.com with ESMTP; 22 Sep 2015 02:35:11 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 22 Sep 2015 10:34:55 +0100
Message-Id: <3b09e0df9c6724065b6ffa17513cb5edb5008d71.1442914166.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <adee73e311b4f4c21718045b2720affb5de61342.1442914166.git.elliot.smith@intel.com>
References: <adee73e311b4f4c21718045b2720affb5de61342.1442914166.git.elliot.smith@intel.com>
In-Reply-To: <cover.1442914166.git.elliot.smith@intel.com>
References: <cover.1442914166.git.elliot.smith@intel.com>
Subject: [PATCH 4/4] toaster: add 2 UI tests
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
X-List-Received-Date: Tue, 22 Sep 2015 09:35:11 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Tested that UI shows task names for the builds in
both all-builds and projectbuilds views.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/tests.py | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 4d1549b..53012b4 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -21,12 +21,14 @@
 
 """Test cases for Toaster GUI and ReST."""
 
+import re
+
 from django.test import TestCase
 from django.core.urlresolvers import reverse
 from django.utils import timezone
 from orm.models import Project, Release, BitbakeVersion, ProjectTarget
 from orm.models import ReleaseLayerSourcePriority, LayerSource, Layer, Build
-from orm.models import Layer_Version, Recipe, Machine, ProjectLayer
+from orm.models import Layer_Version, Recipe, Machine, ProjectLayer, Target
 import json
 from bs4 import BeautifulSoup
 
@@ -376,4 +378,22 @@ class ProjectBuildsDisplayTest(TestCase):
         build2b = Build.objects.create(**self.project2_build_in_progress)
 
         build_rows = self._get_rows_for_project(self.project1.id)
-        self.assertEqual(len(build_rows), 2)
\ No newline at end of file
+        self.assertEqual(len(build_rows), 2)
+
+    def test_show_tasks_in_projectbuilds(self):
+        build = Build.objects.create(**self.project1_build_success)
+        target = Target.objects.create(build=build, target='bash',
+                                       task='clean')
+        url = reverse("projectbuilds", args=(self.project1.id,))
+        response = self.client.get(url, follow=True)
+        result = re.findall('^ +bash:clean$', response.content, re.MULTILINE)
+        self.assertEqual(len(result), 1)
+
+    def test_show_tasks_in_allbuilds(self):
+        build = Build.objects.create(**self.project1_build_success)
+        target = Target.objects.create(build=build, target='bash',
+                                       task='clean')
+        url = reverse("all-builds")
+        response = self.client.get(url, follow=True)
+        result = re.findall('bash:clean', response.content, re.MULTILINE)
+        self.assertEqual(len(result), 3)
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


