Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 4079C6612D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Nov 2015 16:44:45 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 26 Nov 2015 08:44:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,347,1444719600"; d="scan'208";a="860355483"
Received: from snwijaya-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.16.69])
	by fmsmga002.fm.intel.com with ESMTP; 26 Nov 2015 08:44:45 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Nov 2015 16:44:33 +0000
Message-Id: <0a99be8e8cb9c48e51e3aeff5549d90ed3cf86e7.1448556172.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <7a60315f7183a0792c24c7e5a2c4b5688e6f18c8.1448556172.git.elliot.smith@intel.com>
References: <7a60315f7183a0792c24c7e5a2c4b5688e6f18c8.1448556172.git.elliot.smith@intel.com>
In-Reply-To: <cover.1448556172.git.elliot.smith@intel.com>
References: <cover.1448556172.git.elliot.smith@intel.com>
Subject: [PATCH 3/5] toaster: tables Add default_orderby field where it was missing or unset
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
X-List-Received-Date: Thu, 26 Nov 2015 16:44:45 -0000

From: Michael Wood <michael.g.wood@intel.com>

This value is used to set the default ordering of the model that is used
for ToasterTables, it is picked up client side to set the ordering
indicator.

[YOCTO #8695]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/tables.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index be8916c..44a89d9 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -295,6 +295,7 @@ class LayerMachinesTable(MachinesTable):
         MachinesTable.setup_queryset(self, *args, **kwargs)
 
         self.queryset = self.queryset.filter(layer_version__pk=int(kwargs['layerid']))
+        self.queryset = self.queryset.order_by(self.default_orderby)
         self.static_context_extra['in_prj'] = ProjectLayer.objects.filter(Q(project=kwargs['pid']) & Q(layercommit=kwargs['layerid'])).count()
 
     def setup_columns(self, *args, **kwargs):
@@ -319,7 +320,6 @@ class RecipesTable(ToasterTable, ProjectFiltersMixin):
     def __init__(self, *args, **kwargs):
         super(RecipesTable, self).__init__(*args, **kwargs)
         self.empty_state = "Toaster has no recipe information. To generate recipe information you can configure a layer source then run a build."
-        self.default_orderby = "name"
 
     build_col = { 'title' : "Build",
             'help_text' : "Add or delete recipes to and from your project",
@@ -356,7 +356,6 @@ class RecipesTable(ToasterTable, ProjectFiltersMixin):
         self.static_context_extra['current_layers'] = self.project_layers
 
         self.queryset = prj.get_all_compatible_recipes()
-        self.queryset = self.queryset.order_by(self.default_orderby)
 
 
     def setup_columns(self, *args, **kwargs):
@@ -414,6 +413,7 @@ class LayerRecipesTable(RecipesTable):
 
     def __init__(self, *args, **kwargs):
         super(LayerRecipesTable, self).__init__(*args, **kwargs)
+        self.default_orderby = "name"
 
     def get_context_data(self, **kwargs):
         context = super(LayerRecipesTable, self).get_context_data(**kwargs)
@@ -425,6 +425,7 @@ class LayerRecipesTable(RecipesTable):
         self.queryset = \
                 Recipe.objects.filter(layer_version__pk=int(kwargs['layerid']))
 
+        self.queryset = self.queryset.order_by(self.default_orderby)
         self.static_context_extra['in_prj'] = ProjectLayer.objects.filter(Q(project=kwargs['pid']) & Q(layercommit=kwargs['layerid'])).count()
 
     def setup_columns(self, *args, **kwargs):
@@ -451,6 +452,7 @@ class CustomImagesTable(ToasterTable):
     def __init__(self, *args, **kwargs):
         super(CustomImagesTable, self).__init__(*args, **kwargs)
         self.title = "Custom images"
+        self.default_orderby = "name"
 
     def get_context_data(self, **kwargs):
         context = super(CustomImagesTable, self).get_context_data(**kwargs)
@@ -462,7 +464,7 @@ class CustomImagesTable(ToasterTable):
     def setup_queryset(self, *args, **kwargs):
         prj = Project.objects.get(pk = kwargs['pid'])
         self.queryset = CustomImageRecipe.objects.filter(project=prj)
-        self.queryset = self.queryset.order_by('name')
+        self.queryset = self.queryset.order_by(self.default_orderby)
 
     def setup_columns(self, *args, **kwargs):
 
@@ -502,11 +504,13 @@ class ImageRecipesTable(RecipesTable):
     def __init__(self, *args, **kwargs):
         super(ImageRecipesTable, self).__init__(*args, **kwargs)
         self.title = "Compatible image recipes"
+        self.default_orderby = "name"
 
     def setup_queryset(self, *args, **kwargs):
         super(ImageRecipesTable, self).setup_queryset(*args, **kwargs)
 
         self.queryset = self.queryset.filter(is_image=True)
+        self.queryset = self.queryset.order_by(self.default_orderby)
 
 
     def setup_columns(self, *args, **kwargs):
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


