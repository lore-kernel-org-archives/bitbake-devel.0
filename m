Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 0EE9473CBD
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 09:09:35 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 14 Oct 2015 02:09:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,681,1437462000"; d="scan'208";a="664041953"
Received: from marcinko-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.22.75])
	by orsmga003.jf.intel.com with ESMTP; 14 Oct 2015 02:09:33 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Oct 2015 10:09:12 +0100
Message-Id: <1444813752-27425-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: buildinfohelper Detect command line builds
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
X-List-Received-Date: Wed, 14 Oct 2015 09:09:36 -0000

From: Michael Wood <michael.g.wood@intel.com>

When we're building using toaster as just a listener to bitbake
(analysis mode) we need to handle the case where the toaster configuration data
isn't present so we don't need to try and update the existing information.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 2d76403..a8c884d 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -298,9 +298,13 @@ class ORMWrapper(object):
                 break
 
 
-
-        if created and must_exist:
-            raise NotExisting("Recipe object created when expected to exist", recipe_information)
+        # If we're in analysis mode then we are wholly responsible for the data
+        # and therefore we return the 'real' recipe rather than the build
+        # history copy of the recipe.
+        if  recipe_information['layer_version'].build is not None and \
+            recipe_information['layer_version'].build.project == \
+                Project.objects.get_default_project():
+            return recipe
 
         return built_recipe
 
@@ -333,14 +337,20 @@ class ORMWrapper(object):
         assert 'priority' in layer_version_information
         assert 'local_path' in layer_version_information
 
+        # If we're doing a command line build then associate this new layer with the
+        # project to avoid it 'contaminating' toaster data
+        project = None
+        if build_obj.project == Project.objects.get_default_project():
+            project = build_obj.project
+
         layer_version_object, _ = Layer_Version.objects.get_or_create(
-                                    build = build_obj,
-                                    layer = layer_obj,
-                                    branch = layer_version_information['branch'],
-                                    commit = layer_version_information['commit'],
-                                    priority = layer_version_information['priority'],
-                                    local_path = layer_version_information['local_path'],
-                                    )
+                                  build = build_obj,
+                                  layer = layer_obj,
+                                  branch = layer_version_information['branch'],
+                                  commit = layer_version_information['commit'],
+                                  priority = layer_version_information['priority'],
+                                  local_path = layer_version_information['local_path'],
+                                  project=project)
 
         self.layer_version_objects.append(layer_version_object)
 
@@ -845,7 +855,7 @@ class BuildInfoHelper(object):
         logger.warn("Could not match layer version for recipe path %s : %s", path, self.orm_wrapper.layer_version_objects)
 
         #mockup the new layer
-        unknown_layer, _ = Layer.objects.get_or_create(name="__FIXME__unidentified_layer", layer_index_url="")
+        unknown_layer, _ = Layer.objects.get_or_create(name="Unidentified layer", layer_index_url="")
         unknown_layer_version_obj, _ = Layer_Version.objects.get_or_create(layer = unknown_layer, build = self.internal_state['build'])
 
         # append it so we don't run into this error again and again
@@ -1067,7 +1077,7 @@ class BuildInfoHelper(object):
             task_information['disk_io'] = taskstats['disk_io']
             if 'elapsed_time' in taskstats:
                 task_information['elapsed_time'] = taskstats['elapsed_time']
-            self.orm_wrapper.get_update_task_object(task_information, True)  # must exist
+            self.orm_wrapper.get_update_task_object(task_information)
 
     def update_and_store_task(self, event):
         assert 'taskfile' in vars(event)
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


