Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id B95A360017
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Mar 2016 08:28:46 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 23 Mar 2016 01:28:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,381,1455004800"; d="scan'208";a="769709412"
Received: from rmoran-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.1.250])
	by orsmga003.jf.intel.com with ESMTP; 23 Mar 2016 01:28:46 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Mar 2016 08:28:37 +0000
Message-Id: <ca8be3af517a2c6ead264f9aae0e2c42a9438253.1458721297.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <867f3199ac6e68411ba49fc0f20e6ad8f9a743f7.1458721297.git.elliot.smith@intel.com>
References: <867f3199ac6e68411ba49fc0f20e6ad8f9a743f7.1458721297.git.elliot.smith@intel.com>
In-Reply-To: <cover.1458721297.git.elliot.smith@intel.com>
References: <cover.1458721297.git.elliot.smith@intel.com>
Subject: [PATCH 2/5] toaster: orm Add a constant for the CustomImageRecipe's layer name
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
X-List-Received-Date: Wed, 23 Mar 2016 08:28:46 -0000

From: Michael Wood <michael.g.wood@intel.com>

Use a constant to define the name for the toaster custom images layer;
this constant is then used to identify this layer in various places.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/bb/ui/buildinfohelper.py    | 4 ++--
 lib/toaster/orm/models.py       | 4 ++++
 lib/toaster/toastergui/views.py | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 28c7353..7b8b1a5 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -42,7 +42,7 @@ from orm.models import Variable, VariableHistory
 from orm.models import Package, Package_File, Target_Installed_Package, Target_File
 from orm.models import Task_Dependency, Package_Dependency
 from orm.models import Recipe_Dependency, Provides
-from orm.models import Project, CustomImagePackage
+from orm.models import Project, CustomImagePackage, CustomImageRecipe
 
 from bldcontrol.models import BuildEnvironment, BuildRequest
 
@@ -344,7 +344,7 @@ class ORMWrapper(object):
             # Special case the toaster-custom-images layer which is created
             # on the fly so don't update the values which may cause the layer
             # to be duplicated on a future get_or_create
-            if layer_obj.layer.name == "toaster-custom-images":
+            if layer_obj.layer.name == CustomImageRecipe.LAYER_NAME:
                 return layer_obj
             # We already found our layer version for this build so just
             # update it with the new build information
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 3c98c0b..a8b0408 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1448,6 +1448,10 @@ class ProjectLayer(models.Model):
         unique_together = (("project", "layercommit"),)
 
 class CustomImageRecipe(Recipe):
+
+    # CustomImageRecipe's belong to layers called:
+    LAYER_NAME = "toaster-custom-images"
+
     search_allowed_fields = ['name']
     base_recipe = models.ForeignKey(Recipe, related_name='based_on_recipe')
     project = models.ForeignKey(Project)
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 85ca9be..15760b3 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2407,7 +2407,7 @@ if True:
 
             # create layer 'Custom layer' and verion if needed
             layer = Layer.objects.get_or_create(
-                name="toaster-custom-images",
+                name=CustomImageRecipe.LAYER_NAME,
                 summary="Layer for custom recipes",
                 vcs_url="file:///toaster_created_layer")[0]
 
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


