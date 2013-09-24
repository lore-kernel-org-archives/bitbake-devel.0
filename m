Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id E30C86CB46
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:12 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 24 Sep 2013 09:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="408442601"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga002.jf.intel.com with ESMTP; 24 Sep 2013 09:53:13 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 5BF24562CDD; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:53 +0100
Message-Id: <5e6dc71033aa34e071755d20778db3f200d6aba4.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 84/94] bitbake: webhob: update API endpoints
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:14 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Updating the API endpoints as described by the documentation.

The documentation updated here:
https://wiki.yoctoproject.org/wiki/REST_API_Contracts

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/api.py   | 20 ++++++++++++++------
 bitbake/lib/webhob/bldviewer/views.py | 15 ++++++++++++---
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/webhob/bldviewer/api.py b/bitbake/lib/webhob/bldviewer/api.py
index 9fa701c..2e58313 100644
--- a/bitbake/lib/webhob/bldviewer/api.py
+++ b/bitbake/lib/webhob/bldviewer/api.py
@@ -2,10 +2,18 @@ from django.conf.urls import patterns, include, url
 
 
 urlpatterns = patterns('bldviewer.views',
-        url(r'^builds/$', 'model_explorer',  {'model_name':'build'}, name='builds'),
-        url(r'^tasks/$', 'model_explorer', {'model_name':'task'}, name='task'),
-        url(r'^packages/$', 'model_explorer', {'model_name':'package'}, name='package'),
-        url(r'^layers/$', 'model_explorer', {'model_name':'layer'}, name='layer'),
-        url(r'^recipes/$', 'model_explorer', {'model_name':'recipe'}, name='recipe'),
-        url(r'^layersversions/$', 'model_explorer', {'model_name':'layerversion'}, name='layerversion'),
+        url(r'^builds$', 'model_explorer',  {'model_name':'build'}, name='builds'),
+        url(r'^targets$', 'model_explorer',  {'model_name':'target'}, name='targets'),
+        url(r'^tasks$', 'model_explorer', {'model_name':'task'}, name='task'),
+        url(r'^task_dependencies$', 'model_explorer',  {'model_name':'task_dependency'}, name='task_dependencies'),
+        url(r'^packages$', 'model_explorer',  {'model_name':'build_package'}, name='build_packages'),
+        url(r'^package_dependencies$', 'model_explorer',  {'model_name':'build_package_dependency'}, name='build_package_dependencies'),
+        url(r'^target_packages$', 'model_explorer',  {'model_name':'target_package'}, name='target_packages'),
+        url(r'^package_files$', 'model_explorer',  {'model_name':'build_file'}, name='build_files'),
+        url(r'^layers$', 'model_explorer', {'model_name':'layer'}, name='layer'),
+        url(r'^layerversions$', 'model_explorer', {'model_name':'layerversion'}, name='layerversion'),
+        url(r'^recipes$', 'model_explorer', {'model_name':'recipe'}, name='recipe'),
+        url(r'^recipe_dependencies$', 'model_explorer',  {'model_name':'recipe_dependency'}, name='recipe_dependencies'),
+        url(r'^variables$', 'model_explorer',  {'model_name':'variable'}, name='variables'),
+        url(r'^logmessages$', 'model_explorer',  {'model_name':'logmessage'}, name='logmessages'),
 )
diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index 4ff23d3..98099ee 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -2,8 +2,8 @@ import operator
 
 from django.db.models import Q
 from django.shortcuts import render
-from orm.models import Build, Task, Layer, Layer_Version, Recipe, Target_Package, LogMessage, Variable
-from orm.models import Task_Dependency, Target_Package_Dependency, Build_Package, Build_File
+from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe, Target_Package, LogMessage, Variable
+from orm.models import Task_Dependency, Recipe_Dependency, Build_Package, Build_File, Build_Package_Dependency
 from django.views.decorators.cache import cache_control
 
 @cache_control(no_store=True)
@@ -95,11 +95,20 @@ def model_explorer(request, model_name):
     response_data = {}
     model_mapping = {
         'build': Build,
+        'target': Target,
+        'target_package': Target_Package,
         'task': Task,
-        'package': Target_Package,
+        'task_dependency': Task_Dependency,
+        'package': Build_Package,
         'layer': Layer,
         'layerversion': Layer_Version,
         'recipe': Recipe,
+        'recipe_dependency': Recipe_Dependency,
+        'build_package': Build_Package,
+        'build_package_dependency': Build_Package_Dependency,
+        'build_file': Build_File,
+        'variable': Variable,
+        'logmessage': LogMessage,
         }
 
     if model_name not in model_mapping.keys():
-- 
1.8.1.2


