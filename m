Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 26BE26CB29
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:14 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 24 Sep 2013 09:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="298814590"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by AZSMGA002.ch.intel.com with ESMTP; 24 Sep 2013 09:53:10 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id E39F0562248; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:12 +0100
Message-Id: <3656778790aa9961cc42132aabd885ddb5333506.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 43/94] bitbake: webhob: add more models to webhob API
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:15 -0000

From: Calin Dragomir <calinx.l.dragomir@intel.com>

This patch enables webhob API to support recipe, layer and
layer_version models.

Signed-off-by: Calin Dragomir <calinx.l.dragomir@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/api.py   | 3 +++
 bitbake/lib/webhob/bldviewer/views.py | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/webhob/bldviewer/api.py b/bitbake/lib/webhob/bldviewer/api.py
index 3b2d7d2..9fa701c 100644
--- a/bitbake/lib/webhob/bldviewer/api.py
+++ b/bitbake/lib/webhob/bldviewer/api.py
@@ -5,4 +5,7 @@ urlpatterns = patterns('bldviewer.views',
         url(r'^builds/$', 'model_explorer',  {'model_name':'build'}, name='builds'),
         url(r'^tasks/$', 'model_explorer', {'model_name':'task'}, name='task'),
         url(r'^packages/$', 'model_explorer', {'model_name':'package'}, name='package'),
+        url(r'^layers/$', 'model_explorer', {'model_name':'layer'}, name='layer'),
+        url(r'^recipes/$', 'model_explorer', {'model_name':'recipe'}, name='recipe'),
+        url(r'^layersversions/$', 'model_explorer', {'model_name':'layerversion'}, name='layerversion'),
 )
diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index 647a1f2..3ef6940 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -43,9 +43,9 @@ def layer(request):
 def layer_versions_recipes(request, layerversion_id):
     template = 'recipe.html'
     recipes = Recipe.objects.filter(layer_version__id = layerversion_id)
-    
+
     context = {'recipes': recipes}
-    
+
     return render(request, template, context)
 
 #### API
@@ -63,6 +63,9 @@ def model_explorer(request, model_name):
         'build': Build,
         'task': Task,
         'package': Package,
+        'layer': Layer,
+        'layerversion': Layer_Version,
+        'recipe': Recipe,
         }
 
     if model_name not in model_mapping.keys():
-- 
1.8.1.2


