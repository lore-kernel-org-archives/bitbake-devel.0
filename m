Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id BB708770A1
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Oct 2015 09:43:30 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga102.fm.intel.com with ESMTP; 05 Oct 2015 02:43:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,637,1437462000"; d="scan'208";a="784630507"
Received: from blynch-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.3.31])
	by orsmga001.jf.intel.com with ESMTP; 05 Oct 2015 02:43:31 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Oct 2015 10:43:16 +0100
Message-Id: <d6ff7fc0fdf7fa302fbcdff18bfed3af91d6c169.1444038048.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <04c22e69056969f61173107062a4eec82a4bc3ed.1444038048.git.elliot.smith@intel.com>
References: <04c22e69056969f61173107062a4eec82a4bc3ed.1444038048.git.elliot.smith@intel.com>
In-Reply-To: <cover.1444038048.git.elliot.smith@intel.com>
References: <cover.1444038048.git.elliot.smith@intel.com>
Subject: [PATCH 4/6] toaster: add get_or_create_targets API
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
X-List-Received-Date: Mon, 05 Oct 2015 09:43:30 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Target objects are created before the build if build is
started from UI in build mode. However, in analysis mode Target
objects don't exist and need to be created using information
from bitbake events.

Added new API call get_or_create_targets to retrive existing
target objects or create them if they don't exist yet.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 34a8694..793418a 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -162,8 +162,6 @@ class ORMWrapper(object):
             build.bitbake_version=build_info['bitbake_version']
             build.save()
 
-            Target.objects.filter(build = build).delete()
-
         else:
             build = Build.objects.create(
                                     project = prj,
@@ -184,18 +182,19 @@ class ORMWrapper(object):
 
         return build
 
-    def create_target_objects(self, target_info):
-        assert 'build' in target_info
-        assert 'targets' in target_info
-
-        targets = []
-        for tgt_name in target_info['targets']:
-            tgt_object = Target.objects.create( build = target_info['build'],
-                                    target = tgt_name,
-                                    is_image = False,
-                                    )
-            targets.append(tgt_object)
-        return targets
+    @staticmethod
+    def get_or_create_targets(target_info):
+        result = []
+        for target in target_info['targets']:
+            obj, created = Target.objects.get_or_create(build=target_info['build'],
+                                                        target=target)
+            if created:
+                obj.is_image = False
+                if target_info['task']:
+                    obj.task = target_info['task']
+                obj.save()
+            result.append(obj)
+        return result
 
     def update_build_object(self, build, errors, warnings, taskfailures):
         assert isinstance(build,Build)
@@ -932,7 +931,7 @@ class BuildInfoHelper(object):
             task = ''
         target_information['task'] = task
 
-        self.internal_state['targets'] = self.orm_wrapper.create_target_objects(target_information)
+        self.internal_state['targets'] = self.orm_wrapper.get_or_create_targets(target_information)
 
         # Save build configuration
         data = self.server.runCommand(["getAllKeysWithFlags", ["doc", "func"]])[0]
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


