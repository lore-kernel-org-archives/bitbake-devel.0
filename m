Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 8C3ED6CB63
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:11 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 24 Sep 2013 09:50:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="408442594"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga002.jf.intel.com with ESMTP; 24 Sep 2013 09:53:12 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 3B57F5628D3; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:40 +0100
Message-Id: <be46d5f7739973c711fd4ea8f397ee8f76302ad6.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 71/94] bitbake: webhob: add navigation links Simple interface
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:13 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding a couple of navigation links on top of pages
so that we provide easier movement between pages and
a bit more context.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/templates/build.html         | 2 +-
 bitbake/lib/webhob/bldviewer/templates/configuration.html | 1 +
 bitbake/lib/webhob/bldviewer/templates/package.html       | 1 +
 bitbake/lib/webhob/bldviewer/templates/recipe.html        | 3 +++
 bitbake/lib/webhob/bldviewer/templates/task.html          | 1 +
 bitbake/lib/webhob/bldviewer/views.py                     | 6 ++++--
 6 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/webhob/bldviewer/templates/build.html b/bitbake/lib/webhob/bldviewer/templates/build.html
index 53271a7..bbd283e 100644
--- a/bitbake/lib/webhob/bldviewer/templates/build.html
+++ b/bitbake/lib/webhob/bldviewer/templates/build.html
@@ -24,7 +24,7 @@
         </tr>
         {% for build in builds %}
         <tr class="data">
-            <td><a href="/simple/build/{{build.id}}/task/">{{build.get_outcome_display}}</a></td>
+            <td><a href="/simple/build/{{build.id}}/configuration/">{{build.get_outcome_display}}</a></td>
             <td>{{build.started_on}}</td>
             <td>{{build.completed_on}}</td>
             <td>{{build.target}}</td>
diff --git a/bitbake/lib/webhob/bldviewer/templates/configuration.html b/bitbake/lib/webhob/bldviewer/templates/configuration.html
index 2f197c0..4db4765 100644
--- a/bitbake/lib/webhob/bldviewer/templates/configuration.html
+++ b/bitbake/lib/webhob/bldviewer/templates/configuration.html
@@ -2,6 +2,7 @@
 
 {% block pagename %}
 <ul class="nav nav-tabs" style="display: inline-block">
+  <li><a>Build {{build}} : </a></li>
   <li><a href="/simple/build/{{build}}/task/"> Tasks </a></li>
   <li><a href="/simple/build/{{build}}/package/"> Package </a> </li>
   <li><a href="/simple/build/{{build}}/configuration/"> Configuration </a> </li>
diff --git a/bitbake/lib/webhob/bldviewer/templates/package.html b/bitbake/lib/webhob/bldviewer/templates/package.html
index 339b411..b4091c6 100644
--- a/bitbake/lib/webhob/bldviewer/templates/package.html
+++ b/bitbake/lib/webhob/bldviewer/templates/package.html
@@ -2,6 +2,7 @@
 
 {% block pagename %}
 <ul class="nav nav-tabs" style="display: inline-block">
+  <li><a>Build {{build}} : </a></li>
   <li><a href="/simple/build/{{build}}/task/"> Tasks </a></li>
   <li><a href="/simple/build/{{build}}/package/"> Package </a> </li>
   <li><a href="/simple/build/{{build}}/configuration/"> Configuration </a> </li>
diff --git a/bitbake/lib/webhob/bldviewer/templates/recipe.html b/bitbake/lib/webhob/bldviewer/templates/recipe.html
index e855625..32fcdb8 100644
--- a/bitbake/lib/webhob/bldviewer/templates/recipe.html
+++ b/bitbake/lib/webhob/bldviewer/templates/recipe.html
@@ -1,6 +1,9 @@
 {% extends "basetable.html" %}
 
 {% block pagename %}
+<ul class="nav nav-tabs" style="display: inline-block">
+  <li><a>Layer  {{layer_version.layer.name}}&nbsp;:&nbsp;{{layer_version.branch}}&nbsp;:&nbsp;{{layer_version.commit}}</a></li>
+</ul>
     <h1>Toaster - Recipes for a Layer</h1>
 {% endblock %}
 
diff --git a/bitbake/lib/webhob/bldviewer/templates/task.html b/bitbake/lib/webhob/bldviewer/templates/task.html
index 4939531..9736b4a 100644
--- a/bitbake/lib/webhob/bldviewer/templates/task.html
+++ b/bitbake/lib/webhob/bldviewer/templates/task.html
@@ -2,6 +2,7 @@
 
 {% block pagename %}
 <ul class="nav nav-tabs" style="display: inline-block">
+  <li><a>Build {{build}} : </a></li>
   <li><a href="/simple/build/{{build}}/task/"> Tasks </a></li>
   <li><a href="/simple/build/{{build}}/package/"> Package </a> </li>
   <li><a href="/simple/build/{{build}}/configuration/"> Configuration </a> </li>
diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index 77be08b..cb7cfc7 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -12,7 +12,7 @@ def build(request):
     build_info = Build.objects.all()
     logs = LogMessage.objects.all()
 
-    context = {'builds': build_info, 'logs': logs , 
+    context = {'builds': build_info, 'logs': logs ,
         'hideshowcols' : [
                 {'name': 'Output', 'order':10},
                 {'name': 'Log', 'order':11},
@@ -76,7 +76,9 @@ def layer_versions_recipes(request, layerversion_id):
     template = 'recipe.html'
     recipes = Recipe.objects.filter(layer_version__id = layerversion_id)
 
-    context = {'recipes': recipes}
+    context = {'recipes': recipes,
+            'layer_version' : Layer_Version.objects.filter( id = layerversion_id )[0]
+    }
 
     return render(request, template, context)
 
-- 
1.8.1.2


