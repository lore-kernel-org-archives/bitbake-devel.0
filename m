Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 88C636CB2A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:08 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 24 Sep 2013 09:50:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; 
	d="scan'208,217";a="408442568"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga002.jf.intel.com with ESMTP; 24 Sep 2013 09:53:09 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id D25AF561B9F; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:05 +0100
Message-Id: <d96e94e94169a6e0a9bb4b1ce3ca72a449042149.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 36/94] bitbake: webhob: add simple pages for Recipes
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:08 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add simple pages to display database information
about Layer versions and Recipes.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/templates/layer.html  |  8 ++++
 bitbake/lib/webhob/bldviewer/templates/recipe.html | 48 ++++++++++++++++++++++
 bitbake/lib/webhob/bldviewer/urls.py               |  4 +-
 bitbake/lib/webhob/bldviewer/views.py              | 15 ++++++-
 4 files changed, 72 insertions(+), 3 deletions(-)
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/recipe.html

diff --git a/bitbake/lib/webhob/bldviewer/templates/layer.html b/bitbake/lib/webhob/bldviewer/templates/layer.html
index 905a781..24bd86b 100644
--- a/bitbake/lib/webhob/bldviewer/templates/layer.html
+++ b/bitbake/lib/webhob/bldviewer/templates/layer.html
@@ -15,6 +15,7 @@
 			<th>Name</th>
 			<th>Local Path</th>
 			<th>Layer Index URL</th>
+            <th>Known Versions</th>
 		</tr>
 
 		{% for layer in layers %}
@@ -23,6 +24,13 @@
 			<td>{{layer.name}}</td>
 			<td>{{layer.local_path}}</td>
 			<td><a href='{{layer.layer_index_url}}'>{{layer.layer_index_url}}</a></td>
+            <td><table>
+            {% for lv in layer.versions %}
+                <tr><td>
+        <a href="/simple/layerversions/{{lv.id}}/recipes">{{lv.branch}}:{{lv.commit}} ({{lv.count}} recipes)</a>
+                </td></tr>
+            {% endfor %}
+            </table></td>
 		</tr>
 
 		{% endfor %}
diff --git a/bitbake/lib/webhob/bldviewer/templates/recipe.html b/bitbake/lib/webhob/bldviewer/templates/recipe.html
new file mode 100644
index 0000000..8f5dcb3
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templates/recipe.html
@@ -0,0 +1,48 @@
+<html>
+
+	<head>
+		<title>WebHob Recipe page</title>
+	</head>
+
+<body>
+	<h1>WebHob Recipes for a Layer</h1>
+
+	<table border="1">
+
+	{% load projecttags %}
+
+		<tr>
+		</tr>
+			<th>Name</th>
+			<th>Version</th>
+			<th>Summary</th>
+			<th>Description</th>
+	        <th>Section</th>
+			<th>License</th>
+			<th>Homepage</th>
+			<th>Bugtracker</th>
+			<th>Author</th>
+			<th>File_path</th>
+
+		{% for recipe in recipes %}
+
+		<tr>
+			<td>{{recipe.name}}</td>
+			<td>{{recipe.version}}</td>
+			<td>{{recipe.summary}}</td>
+			<td>{{recipe.description}}</td>
+	        <td>{{recipe.section}}</td>
+			<td>{{recipe.license}}</td>
+			<td>{{recipe.homepage}}</td>
+			<td>{{recipe.bugtracker}}</td>
+			<td>{{recipe.author}}</td>
+			<td>{{recipe.file_path}}</td>
+		</tr>
+
+		{% endfor %}
+
+	</table>
+
+</body>
+
+</html>
diff --git a/bitbake/lib/webhob/bldviewer/urls.py b/bitbake/lib/webhob/bldviewer/urls.py
index 756b3fa..b6c6796 100644
--- a/bitbake/lib/webhob/bldviewer/urls.py
+++ b/bitbake/lib/webhob/bldviewer/urls.py
@@ -1,10 +1,10 @@
 from django.conf.urls import patterns, include, url
 from django.views.generic.simple import redirect_to
 
-
 urlpatterns = patterns('bldviewer.views',
         url(r'^build/$', 'build', name='build'),
-        url(r'^layers/$', 'layer', name='layer'),
         url(r'^build/(?P<build_id>\d+)/task/$', 'task', name='task'),
+        url(r'^layer/$', 'layer', name='layer'),
+        url(r'^layerversions/(?P<layerversion_id>\d+)/recipes$', 'layer_versions_recipes', name='layer_versions_recipes'),
         url(r'^$', redirect_to, {'url': 'build/'}),
 )
diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index 58d9444..de89b84 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -1,5 +1,5 @@
 from django.shortcuts import render
-from orm.models import Build, Task, Layer, Task_Dependency
+from orm.models import Build, Task, Layer, Layer_Version, Task_Dependency, Recipe
 
 
 def build(request):
@@ -30,11 +30,24 @@ def layer(request):
     template = 'layer.html'
     layer_info = Layer.objects.all()
 
+    for li in layer_info:
+        li.versions = Layer_Version.objects.filter(layer = li)
+        for liv in li.versions:
+            liv.count = Recipe.objects.filter(layer_version__id = liv.id).count()
+
     context = {'layers': layer_info}
 
     return render(request, template, context)
 
 
+def layer_versions_recipes(request, layerversion_id):
+    template = 'recipe.html'
+    recipes = Recipe.objects.filter(layer_version__id = layerversion_id)
+    
+    context = {'recipes': recipes}
+    
+    return render(request, template, context)
+
 #### API
 
 import json
-- 
1.8.1.2


