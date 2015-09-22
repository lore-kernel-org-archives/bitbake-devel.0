Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id A9FBC76417
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Sep 2015 09:35:06 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 22 Sep 2015 02:35:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,572,1437462000"; d="scan'208";a="810261548"
Received: from martinbu-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.21.229])
	by fmsmga002.fm.intel.com with ESMTP; 22 Sep 2015 02:35:07 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 22 Sep 2015 10:34:53 +0100
Message-Id: <f6ab9669f3a95f52aa1233d4186ae2de33867cca.1442914166.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <adee73e311b4f4c21718045b2720affb5de61342.1442914166.git.elliot.smith@intel.com>
References: <adee73e311b4f4c21718045b2720affb5de61342.1442914166.git.elliot.smith@intel.com>
In-Reply-To: <cover.1442914166.git.elliot.smith@intel.com>
References: <cover.1442914166.git.elliot.smith@intel.com>
Subject: [PATCH 2/4] toaster: don't re-create Target objects
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
X-List-Received-Date: Tue, 22 Sep 2015 09:35:06 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Due to re-creating Target objects from bitbake events task information
stored in original objects is lost.

There is no valid reason to remove existing objects. It's safer to query
them instead of re-creating as original object contain more information
than events coming from bitbake.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 6e313fe..e5f1e09 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -161,8 +161,6 @@ class ORMWrapper(object):
             build.bitbake_version=build_info['bitbake_version']
             build.save()
 
-            Target.objects.filter(build = build).delete()
-
         else:
             build = Build.objects.create(
                                     project = prj,
@@ -183,19 +181,6 @@ class ORMWrapper(object):
 
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
-
     def update_build_object(self, build, errors, warnings, taskfailures):
         assert isinstance(build,Build)
         assert isinstance(errors, int)
@@ -869,7 +854,7 @@ class BuildInfoHelper(object):
         target_information['targets'] = event._pkgs
         target_information['build'] = build_obj
 
-        self.internal_state['targets'] = self.orm_wrapper.create_target_objects(target_information)
+        self.internal_state['targets'] = Target.objects.filter(build=target_information['build'])
 
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


