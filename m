Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 0B2916CB1F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:10 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 24 Sep 2013 09:50:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="408442579"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga002.jf.intel.com with ESMTP; 24 Sep 2013 09:53:10 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 01F8D56237B; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:19 +0100
Message-Id: <3615b8e272d9bac6920b9f711ee1371bd68830d5.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 50/94] bitbake: webhob: add simple viewer for package information
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:10 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

If the target built is an image, we add a link to
a page which lists all the packages built for this build,
with sizes, version names and recipes linked in.
The package dependency information is also shown.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/templates/build.html  |  2 +-
 .../lib/webhob/bldviewer/templates/package.html    | 42 ++++++++++++++++++++++
 bitbake/lib/webhob/bldviewer/urls.py               |  1 +
 bitbake/lib/webhob/bldviewer/views.py              | 18 +++++++++-
 4 files changed, 61 insertions(+), 2 deletions(-)
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/package.html

diff --git a/bitbake/lib/webhob/bldviewer/templates/build.html b/bitbake/lib/webhob/bldviewer/templates/build.html
index 8ee3800..15d88a0 100644
--- a/bitbake/lib/webhob/bldviewer/templates/build.html
+++ b/bitbake/lib/webhob/bldviewer/templates/build.html
@@ -30,7 +30,7 @@
             <td>{{build.started_on}}</td>
             <td>{{build.completed_on}}</td>
             <td>{{build.target}}</td>
-            <td>{{build.is_image}}</td>
+            <td>{% if build.is_image %} <a href="/simple/build/{{build.id}}/package/">{{build.is_image}}</a>{% else %} {{build.is_image}} {% endif %}</td>
             <td>{{build.machine.name}}</td>
             <td>{% time_difference build.started_on build.completed_on %}</td>
             <td>{{build.errors_no}}</td>
diff --git a/bitbake/lib/webhob/bldviewer/templates/package.html b/bitbake/lib/webhob/bldviewer/templates/package.html
new file mode 100644
index 0000000..d31ecbb
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templates/package.html
@@ -0,0 +1,42 @@
+{% extends "base.html" %}
+
+{% block pagecontent %}
+    <h1>WebHob Packages</h1>
+
+    {% if not packages %}
+        <p>No packages were build in this build!</p>
+    {% else %}
+
+        <table border="1">
+
+            <tr>
+            <th>Name</th>
+            <th>Version</th>
+            <th>Size (in KiB)</th>
+            <th>Recipe</th>
+            <th>Depends on</th>
+            </tr>
+
+            {% for package in packages %}
+
+                <tr>
+                <td><a name="#{{package.name}}">{{package.name}}</a></td>
+                <td>{{package.version}}</td>
+                <td>{{package.size}}</td>
+                <td><a name="{{package.recipe.name}}.{{package.package_name}}">
+                <a href="/simple/layerversions/{{package.recipe.layer_version_id}}/recipes/#{{package.recipe.name}}">{{package.recipe.name}}</a>{{package.package_name}}</a></td>
+                <td>
+            <div style="height: 3em; overflow:auto">
+                    {% for d in package.depends_on %}
+                    <a href="#{{d.name}}">{{d.name}}</a><br/>
+                    {% endfor %} 
+            </div>
+                </td>
+            
+            {% endfor %}        
+
+        </table>
+
+    {% endif %}
+
+{% endblock %}
diff --git a/bitbake/lib/webhob/bldviewer/urls.py b/bitbake/lib/webhob/bldviewer/urls.py
index 5f07161..8b8b5c3 100644
--- a/bitbake/lib/webhob/bldviewer/urls.py
+++ b/bitbake/lib/webhob/bldviewer/urls.py
@@ -4,6 +4,7 @@ from django.views.generic.simple import redirect_to
 urlpatterns = patterns('bldviewer.views',
         url(r'^build/$', 'build', name='build'),
         url(r'^build/(?P<build_id>\d+)/task/$', 'task', name='task'),
+        url(r'^build/(?P<build_id>\d+)/package/$', 'package', name='package'),
         url(r'^layer/$', 'layer', name='layer'),
         url(r'^layerversions/(?P<layerversion_id>\d+)/recipes/.*$', 'layer_versions_recipes', name='layer_versions_recipes'),
         url(r'^$', redirect_to, {'url': 'build/'}),
diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index 4f7b46c..99e4b99 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -2,7 +2,7 @@ import operator
 
 from django.db.models import Q
 from django.shortcuts import render
-from orm.models import Build, Task, Layer, Layer_Version, Task_Dependency, Recipe, Package
+from orm.models import Build, Task, Layer, Layer_Version, Task_Dependency, Recipe, Package, Package_Dependency
 
 
 def build(request):
@@ -29,6 +29,22 @@ def task(request, build_id):
 
     return render(request, template, context)
 
+def package(request, build_id):
+    template = 'package.html'
+
+    packages = Package.objects.filter(build=build_id)
+    package_depends = Package_Dependency.objects.filter(package__in=packages)
+
+    for t in packages:
+        t.depends_on = []
+        for k in package_depends:
+            if t == k.package:
+                t.depends_on.append(k.depends_on)
+
+    context = {'packages': packages}
+
+    return render(request, template, context)
+
 def layer(request):
     template = 'layer.html'
     layer_info = Layer.objects.all()
-- 
1.8.1.2


