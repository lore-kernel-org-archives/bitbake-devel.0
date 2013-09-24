Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 3CA566CB06
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:21 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; d="scan'208";a="364948555"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:12 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 433E95628D6; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:43 +0100
Message-Id: <8fbb83eb3a7c811d0bfb092f9da2a28d260e3356.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 74/94] bitbake: webhob: navigation in the Simple interface
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:25 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Modifies the navigation in the Simple interface to
allow new multiple targets per build model.

Refactoring the code to load relationships as to be
based on Django's RelationshipManager automatic follower.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/templates/base.html   |  4 ++--
 .../webhob/bldviewer/templates/configuration.html  | 13 ++----------
 .../lib/webhob/bldviewer/templates/package.html    |  2 +-
 bitbake/lib/webhob/bldviewer/templates/task.html   | 19 +++++-------------
 bitbake/lib/webhob/bldviewer/urls.py               | 10 +++++-----
 bitbake/lib/webhob/bldviewer/views.py              | 23 +++++-----------------
 bitbake/lib/webhob/orm/models.py                   |  6 +++++-
 bitbake/lib/webhob/whbmain/urls.py                 |  2 +-
 8 files changed, 26 insertions(+), 53 deletions(-)

diff --git a/bitbake/lib/webhob/bldviewer/templates/base.html b/bitbake/lib/webhob/bldviewer/templates/base.html
index 31abeb1..1a2278a 100644
--- a/bitbake/lib/webhob/bldviewer/templates/base.html
+++ b/bitbake/lib/webhob/bldviewer/templates/base.html
@@ -14,8 +14,8 @@
 <div style="width:100%; height: 100%; position:absolute">
 <div style="width: 100%; height: 3em" class="nav">
     <ul class="nav nav-tabs">
-        <li><a href="/simple/build/">All Builds</a></li>
-        <li><a href="/simple/layer/">All Layers</a></li>
+        <li><a href="/simple/builds/">All Builds</a></li>
+        <li><a href="/simple/layers/">All Layers</a></li>
     </ul>
 </div>
 
diff --git a/bitbake/lib/webhob/bldviewer/templates/configuration.html b/bitbake/lib/webhob/bldviewer/templates/configuration.html
index 4db4765..052c37c 100644
--- a/bitbake/lib/webhob/bldviewer/templates/configuration.html
+++ b/bitbake/lib/webhob/bldviewer/templates/configuration.html
@@ -1,15 +1,6 @@
-{% extends "basetable.html" %}
-
-{% block pagename %}
-<ul class="nav nav-tabs" style="display: inline-block">
-  <li><a>Build {{build}} : </a></li>
-  <li><a href="/simple/build/{{build}}/task/"> Tasks </a></li>
-  <li><a href="/simple/build/{{build}}/package/"> Package </a> </li>
-  <li><a href="/simple/build/{{build}}/configuration/"> Configuration </a> </li>
-</ul>
-     <h1>Toaster - Build Configuration </h1>
-{% endblock %}
+{% extends "basebuildpage.html" %}
 
+{% block pagetitle %}Configuration{% endblock %}
 {% block pagetable %}
 
             <tr>
diff --git a/bitbake/lib/webhob/bldviewer/templates/package.html b/bitbake/lib/webhob/bldviewer/templates/package.html
index 7764f05..cba21e1 100644
--- a/bitbake/lib/webhob/bldviewer/templates/package.html
+++ b/bitbake/lib/webhob/bldviewer/templates/package.html
@@ -1,4 +1,4 @@
-{% extends "basetable.html" %}
+{% extends "basebuildpage.html" %}
 
 {% block pagename %}
 <ul class="nav nav-tabs" style="display: inline-block">
diff --git a/bitbake/lib/webhob/bldviewer/templates/task.html b/bitbake/lib/webhob/bldviewer/templates/task.html
index 9736b4a..65d75cb 100644
--- a/bitbake/lib/webhob/bldviewer/templates/task.html
+++ b/bitbake/lib/webhob/bldviewer/templates/task.html
@@ -1,15 +1,6 @@
-{% extends "basetable.html" %}
-
-{% block pagename %}
-<ul class="nav nav-tabs" style="display: inline-block">
-  <li><a>Build {{build}} : </a></li>
-  <li><a href="/simple/build/{{build}}/task/"> Tasks </a></li>
-  <li><a href="/simple/build/{{build}}/package/"> Package </a> </li>
-  <li><a href="/simple/build/{{build}}/configuration/"> Configuration </a> </li>
-</ul>
-    <h1>Toaster - Tasks</h1>
-{% endblock %}
+{% extends "basebuildpage.html" %}
 
+{% block pagetitle %}Tasks{% endblock %}
 {% block pagetable %}
     {% if not tasks %}
         <p>No tasks were executed in this build!</p>
@@ -55,9 +46,9 @@
                 <td><a target="_fileview" href="file:///{{task.recipe.file_path}}">{{task.recipe.file_path}}</a></td>
                 <td>
             <div style="height: 3em; overflow:auto">
-                {% for tt in task.depends_on %}
-                    <a href="#{{tt.recipe.name}}.{{tt.task_name}}">
-                    {{tt.recipe.name}}.{{tt.task_name}}</a><br/>
+                {% for tt in task.task_dependencies_task.all %}
+                    <a href="#{{tt.depends_on.recipe.name}}.{{tt.depends_on.task_name}}">
+                    {{tt.depends_on.recipe.name}}.{{tt.depends_on.task_name}}</a><br/>
                 {% endfor %}
             </div>
                 </td>
diff --git a/bitbake/lib/webhob/bldviewer/urls.py b/bitbake/lib/webhob/bldviewer/urls.py
index 11bdbe9..d49f8a5 100644
--- a/bitbake/lib/webhob/bldviewer/urls.py
+++ b/bitbake/lib/webhob/bldviewer/urls.py
@@ -2,12 +2,12 @@ from django.conf.urls import patterns, include, url
 from django.views.generic.simple import redirect_to
 
 urlpatterns = patterns('bldviewer.views',
-        url(r'^build/$', 'build', name='build'),
+        url(r'^builds/$', 'build', name='build'),
         url(r'^build/(?P<build_id>\d+)/task/$', 'task', name='task'),
-        url(r'^build/(?P<build_id>\d+)/targets/$', 'task', name='task'),
-        url(r'^build/(?P<build_id>\d+)/package/$', 'package', name='package'),
+        url(r'^build/(?P<build_id>\d+)/packages/$', 'bpackage', name='bpackage'),
+        url(r'^build/(?P<build_id>\d+)/target/(?P<target_id>\d+)/packages/$', 'tpackage', name='tpackage'),
         url(r'^build/(?P<build_id>\d+)/configuration/$', 'configuration', name='configuration'),
-        url(r'^layer/$', 'layer', name='layer'),
+        url(r'^layers/$', 'layer', name='layer'),
         url(r'^layerversions/(?P<layerversion_id>\d+)/recipes/.*$', 'layer_versions_recipes', name='layer_versions_recipes'),
-        url(r'^$', redirect_to, {'url': 'build/'}),
+        url(r'^$', redirect_to, {'url': 'builds/'}),
 )
diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index ab222ac..cfc2a89 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -25,37 +25,24 @@ def task(request, build_id):
     template = 'task.html'
 
     tasks = Task.objects.filter(build=build_id)
-    task_depends = Task_Dependency.objects.filter(task__in=tasks).select_related()
 
-    for t in tasks:
-        t.depends_on = []
-        for k in task_depends:
-            if t == k.task:
-                t.depends_on.append(k.depends_on)
-
-    context = {'build': build_id, 'tasks': tasks}
+    context = {'build': Build.objects.filter(pk=build_id)[0], 'tasks': tasks}
 
     return render(request, template, context)
 
 def configuration(request, build_id):
     template = 'configuration.html'
     variables = Variable.objects.filter(build=build_id)
-    context = {'build': build_id, 'configuration' : variables}
+    context = {'build': Build.objects.filter(pk=build_id)[0], 'configuration' : variables}
     return render(request, template, context)
 
-def package(request, build_id):
+def tpackage(request, build_id, target_id):
     template = 'package.html'
 
-    packages = Target_Package.objects.filter(build=build_id)
+    packages = Target_Package.objects.filter(target=target_id)
     package_depends = Target_Package_Dependency.objects.filter(package__in=packages)
 
-    for t in packages:
-        t.depends_on = []
-        for k in package_depends:
-            if t == k.package:
-                t.depends_on.append(k.depends_on)
-
-    context = {'build' : build_id ,'packages': packages}
+    context = {'build' : Build.objects.filter(pk=build_id)[0],'packages': packages}
 
     return render(request, template, context)
 
diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
index 4b5c413..f3d988e 100644
--- a/bitbake/lib/webhob/orm/models.py
+++ b/bitbake/lib/webhob/orm/models.py
@@ -1,4 +1,5 @@
 from django.db import models
+from django.utils.encoding import python_2_unicode_compatible
 
 
 class Build(models.Model):
@@ -27,7 +28,7 @@ class Build(models.Model):
     build_name = models.CharField(max_length=100)
     bitbake_version = models.CharField(max_length=50)
 
-
+@python_2_unicode_compatible
 class Target(models.Model):
     search_allowed_fields = ['target', 'image_fstypes', 'file_name']
     build = models.ForeignKey(Build)
@@ -37,6 +38,9 @@ class Target(models.Model):
     file_name = models.CharField(max_length=100)
     file_size = models.IntegerField()
 
+    def __str__(self):
+        return self.target
+
 
 class Task(models.Model):
 
diff --git a/bitbake/lib/webhob/whbmain/urls.py b/bitbake/lib/webhob/whbmain/urls.py
index 0e15eda..73f9370 100644
--- a/bitbake/lib/webhob/whbmain/urls.py
+++ b/bitbake/lib/webhob/whbmain/urls.py
@@ -10,7 +10,7 @@ urlpatterns = patterns('',
     url(r'^simple/', include('bldviewer.urls')),
     url(r'^api/1.0/', include('bldviewer.api')),
     url(r'^gui/', include('whbgui.urls')),
-    url(r'^$', redirect_to, {'url': '/gui/'}),
+    url(r'^$', redirect_to, {'url': '/simple/'}),
     # Examples:
     # url(r'^webhob/', include('webhob.foo.urls')),
 
-- 
1.8.1.2


