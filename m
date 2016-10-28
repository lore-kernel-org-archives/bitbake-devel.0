Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 7D37571DC0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Oct 2016 15:49:47 +0000 (UTC)
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga104.fm.intel.com with ESMTP; 28 Oct 2016 08:49:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,410,1473145200"; d="scan'208";a="24866258"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga005.fm.intel.com with ESMTP; 28 Oct 2016 08:49:49 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id C76D56A4082;
	Fri, 28 Oct 2016 08:49:13 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Oct 2016 18:48:49 +0300
Message-Id: <f324163bb29833463cea1eacf9f856886310e25f.1477669487.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <9f194bc2e4eb2c366782ae6ac9a111c6157d8b01.1477669486.git.ed.bartosh@linux.intel.com>
References: <9f194bc2e4eb2c366782ae6ac9a111c6157d8b01.1477669486.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1477669486.git.ed.bartosh@linux.intel.com>
References: <cover.1477669486.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 8/8] toaster: tests builds test_core_image_min Clean ups
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
X-List-Received-Date: Fri, 28 Oct 2016 15:49:47 -0000

From: Michael Wood <michael.g.wood@intel.com>

Instead of searching for the build for each test just use the returned
value of the completed build.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/tests/builds/test_core_image_min.py | 50 ++++++++++---------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/lib/toaster/tests/builds/test_core_image_min.py b/lib/toaster/tests/builds/test_core_image_min.py
index dec0bfa..586f4a8 100644
--- a/lib/toaster/tests/builds/test_core_image_min.py
+++ b/lib/toaster/tests/builds/test_core_image_min.py
@@ -31,14 +31,14 @@ from orm.models import Package_Dependency, Recipe_Dependency, Build
 from orm.models import Task_Dependency, Package, Target, Recipe
 from orm.models import CustomImagePackage
 
-from buildtest import BuildTest
+from tests.builds.buildtest import BuildTest
 
 
 class BuildCoreImageMinimal(BuildTest):
     """Build core-image-minimal and test the results"""
 
     def setUp(self):
-        self.build("core-image-minimal")
+        self.completed_build = self.build("core-image-minimal")
 
     # Check if build name is unique - tc_id=795
     def test_Build_Unique_Name(self):
@@ -59,38 +59,29 @@ class BuildCoreImageMinimal(BuildTest):
 
     # Check if task order is unique for one build - tc=824
     def test_Task_Unique_Order(self):
-        builds = Build.objects.values('id')
-        cnt_err = []
-
-        for build in builds:
-            total_task_order = Task.objects.filter(
-                build=build['id']).values('order').count()
-            distinct_task_order = Task.objects.filter(
-                build=build['id']).values('order').distinct().count()
+        total_task_order = Task.objects.filter(
+            build=self.built).values('order').count()
+        distinct_task_order = Task.objects.filter(
+            build=self.completed_build).values('order').distinct().count()
 
-            if (total_task_order != distinct_task_order):
-                cnt_err.append(build['id'])
-
-        self.assertEqual(len(cnt_err),
-                         0,
-                         msg='Errors for build id: %s' % cnt_err)
+        self.assertEqual(total_task_order,
+                         distinct_task_order,
+                         msg='Errors task order is not unique')
 
     # Check task order sequence for one build - tc=825
     def test_Task_Order_Sequence(self):
-        builds = builds = Build.objects.values('id')
         cnt_err = []
-        for build in builds:
-            tasks = Task.objects.filter(
-                Q(build=build['id']),
-                ~Q(order=None),
-                ~Q(task_name__contains='_setscene')
-            ).values('id', 'order').order_by("order")
+        tasks = Task.objects.filter(
+            Q(build=self.completed_build),
+            ~Q(order=None),
+            ~Q(task_name__contains='_setscene')
+        ).values('id', 'order').order_by("order")
 
-            cnt_tasks = 0
-            for task in tasks:
-                cnt_tasks += 1
-                if (task['order'] != cnt_tasks):
-                    cnt_err.append(task['id'])
+        cnt_tasks = 0
+        for task in tasks:
+            cnt_tasks += 1
+            if (task['order'] != cnt_tasks):
+                cnt_err.append(task['id'])
         self.assertEqual(
             len(cnt_err), 0, msg='Errors for task id: %s' % cnt_err)
 
@@ -126,8 +117,7 @@ class BuildCoreImageMinimal(BuildTest):
                     task['sstate_result'] != Task.SSTATE_MISS):
                 cnt_err.append({'id': task['id'],
                                 'name': task['task_name'],
-                                'sstate_result': task['sstate_result'],
-                               })
+                                'sstate_result': task['sstate_result']})
 
         self.assertEqual(len(cnt_err),
                          0,
-- 
2.1.4


