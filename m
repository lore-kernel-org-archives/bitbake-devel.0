Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 714A8738AE
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 11:53:58 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga103.fm.intel.com with ESMTP; 01 Apr 2016 04:53:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,427,1455004800"; d="scan'208";a="923334591"
Received: from cmjones2-mobl3.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.22.222])
	by orsmga001.jf.intel.com with ESMTP; 01 Apr 2016 04:53:57 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Apr 2016 12:53:55 +0100
Message-Id: <1459511635-1788-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: buildinfohelper Add additional metadata to the built layer
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
X-List-Received-Date: Fri, 01 Apr 2016 11:53:58 -0000

From: Michael Wood <michael.g.wood@intel.com>

Add additional metadata to the layer created for build history to be
able to identify the layer and recipe later on. Specifically this is the
branch and release to which the recipe and layer are associated with
enabling differentiation of two recipes which are local release and
master and 'master' release.

[YOCTO #8528]
[YOCTO #8545]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 7b8b1a5..5a33d53 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -355,12 +355,17 @@ class ORMWrapper(object):
 
             # create a new copy of this layer version as a snapshot for
             # historical purposes
-            layer_copy, c = Layer_Version.objects.get_or_create(build=build_obj,
-                            layer=layer_obj.layer,
-                            commit=layer_version_information['commit'],
-                            local_path = layer_version_information['local_path'],
-                            )
-            logger.info("created new historical layer version %d", layer_copy.pk)
+            layer_copy, c = Layer_Version.objects.get_or_create(
+                build=build_obj,
+                layer=layer_obj.layer,
+                up_branch=layer_obj.up_branch,
+                branch=layer_version_information['branch'],
+                commit=layer_version_information['commit'],
+                local_path=layer_version_information['local_path'],
+            )
+
+            logger.info("created new historical layer version %d",
+                        layer_copy.pk)
 
             self.layer_version_built.append(layer_copy)
 
@@ -581,11 +586,15 @@ class ORMWrapper(object):
                 packagedict[p]['object'].package_dependencies_target.all().delete()
                 packagedict[p]['object'].package_dependencies_source.all().delete()
                 try:
-                    recipe = self._cached_get(Recipe,
-                                              name=built_recipe.name,
-                                              layer_version__build=None,
-                                              file_path=built_recipe.file_path,
-                                              version=built_recipe.version)
+                    recipe = self._cached_get(
+                        Recipe,
+                        name=built_recipe.name,
+                        layer_version__build=None,
+                        layer_version__up_branch=
+                        built_recipe.layer_version.up_branch,
+                        file_path=built_recipe.file_path,
+                        version=built_recipe.version
+                    )
                 except (Recipe.DoesNotExist,
                         Recipe.MultipleObjectsReturned) as e:
                     logger.info("We did not find one recipe for the"
@@ -1293,6 +1302,9 @@ class BuildInfoHelper(object):
                 for cls in event._depgraph['pn'][pn]['inherits']:
                     if cls.endswith('/image.bbclass'):
                         recipe.is_image = True
+                        recipe_info['is_image'] = True
+                        # Save the is_image state to the relevant recipe objects
+                        self.orm_wrapper.get_update_recipe_object(recipe_info)
                         break
             if recipe.is_image:
                 for t in self.internal_state['targets']:
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


