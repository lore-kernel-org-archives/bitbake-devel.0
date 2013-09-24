Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 64E066CB86
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:14 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 24 Sep 2013 09:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="298814629"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by AZSMGA002.ch.intel.com with ESMTP; 24 Sep 2013 09:53:12 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 38BF05628D1; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:39 +0100
Message-Id: <9c6b8b0827b70d2f46f2c0007ba5bd0363c74561.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 70/94] bitbake: webhob: add Configuration visualisation in Simple
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

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add a page to show the build configuration variables
in the Simple display.

We add a bit of navigation menu to allow moving between
pages of the same build.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 .../webhob/bldviewer/templates/configuration.html  | 28 ++++++++++++++++++++++
 .../lib/webhob/bldviewer/templates/package.html    |  7 +++++-
 bitbake/lib/webhob/bldviewer/templates/task.html   |  5 ++++
 bitbake/lib/webhob/bldviewer/urls.py               |  1 +
 bitbake/lib/webhob/bldviewer/views.py              | 12 +++++++---
 5 files changed, 49 insertions(+), 4 deletions(-)
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/configuration.html

diff --git a/bitbake/lib/webhob/bldviewer/templates/configuration.html b/bitbake/lib/webhob/bldviewer/templates/configuration.html
new file mode 100644
index 0000000..2f197c0
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templates/configuration.html
@@ -0,0 +1,28 @@
+{% extends "basetable.html" %}
+
+{% block pagename %}
+<ul class="nav nav-tabs" style="display: inline-block">
+  <li><a href="/simple/build/{{build}}/task/"> Tasks </a></li>
+  <li><a href="/simple/build/{{build}}/package/"> Package </a> </li>
+  <li><a href="/simple/build/{{build}}/configuration/"> Configuration </a> </li>
+</ul>
+     <h1>Toaster - Build Configuration </h1>
+{% endblock %}
+
+{% block pagetable %}
+
+            <tr>
+            <th>Name</th>
+            <th>Value</th>
+            <th>Description</th>
+            </tr>
+
+            {% for variable in configuration %}
+
+            <tr class="data">
+                <td>{{variable.variable_name}}</td>
+                <td>{{variable.variable_value}}</td>
+                <td>{% if variable.description %}{{variable.description}}{% endif %}</td>
+            {% endfor %}
+
+{% endblock %}
diff --git a/bitbake/lib/webhob/bldviewer/templates/package.html b/bitbake/lib/webhob/bldviewer/templates/package.html
index 622c23d..339b411 100644
--- a/bitbake/lib/webhob/bldviewer/templates/package.html
+++ b/bitbake/lib/webhob/bldviewer/templates/package.html
@@ -1,7 +1,12 @@
 {% extends "basetable.html" %}
 
 {% block pagename %}
-    <h1>Toaster - Packages</h1>
+<ul class="nav nav-tabs" style="display: inline-block">
+  <li><a href="/simple/build/{{build}}/task/"> Tasks </a></li>
+  <li><a href="/simple/build/{{build}}/package/"> Package </a> </li>
+  <li><a href="/simple/build/{{build}}/configuration/"> Configuration </a> </li>
+</ul>
+     <h1>Toaster - Packages</h1>
 {% endblock %}
 
 {% block pagetable %}
diff --git a/bitbake/lib/webhob/bldviewer/templates/task.html b/bitbake/lib/webhob/bldviewer/templates/task.html
index 05d8e12..4939531 100644
--- a/bitbake/lib/webhob/bldviewer/templates/task.html
+++ b/bitbake/lib/webhob/bldviewer/templates/task.html
@@ -1,6 +1,11 @@
 {% extends "basetable.html" %}
 
 {% block pagename %}
+<ul class="nav nav-tabs" style="display: inline-block">
+  <li><a href="/simple/build/{{build}}/task/"> Tasks </a></li>
+  <li><a href="/simple/build/{{build}}/package/"> Package </a> </li>
+  <li><a href="/simple/build/{{build}}/configuration/"> Configuration </a> </li>
+</ul>
     <h1>Toaster - Tasks</h1>
 {% endblock %}
 
diff --git a/bitbake/lib/webhob/bldviewer/urls.py b/bitbake/lib/webhob/bldviewer/urls.py
index 8b8b5c3..8f9bc0d 100644
--- a/bitbake/lib/webhob/bldviewer/urls.py
+++ b/bitbake/lib/webhob/bldviewer/urls.py
@@ -5,6 +5,7 @@ urlpatterns = patterns('bldviewer.views',
         url(r'^build/$', 'build', name='build'),
         url(r'^build/(?P<build_id>\d+)/task/$', 'task', name='task'),
         url(r'^build/(?P<build_id>\d+)/package/$', 'package', name='package'),
+        url(r'^build/(?P<build_id>\d+)/configuration/$', 'configuration', name='configuration'),
         url(r'^layer/$', 'layer', name='layer'),
         url(r'^layerversions/(?P<layerversion_id>\d+)/recipes/.*$', 'layer_versions_recipes', name='layer_versions_recipes'),
         url(r'^$', redirect_to, {'url': 'build/'}),
diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index 2ef905a..77be08b 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -2,7 +2,7 @@ import operator
 
 from django.db.models import Q
 from django.shortcuts import render
-from orm.models import Build, Task, Layer, Layer_Version, Recipe, Package, LogMessage
+from orm.models import Build, Task, Layer, Layer_Version, Recipe, Package, LogMessage, Variable
 from orm.models import Task_Dependency, Package_Dependency
 from django.views.decorators.cache import cache_control
 
@@ -32,10 +32,16 @@ def task(request, build_id):
             if t == k.task:
                 t.depends_on.append(k.depends_on)
 
-    context = {'tasks': tasks}
+    context = {'build': build_id, 'tasks': tasks}
 
     return render(request, template, context)
 
+def configuration(request, build_id):
+    template = 'configuration.html'
+    variables = Variable.objects.filter(build=build_id)
+    context = {'build': build_id, 'configuration' : variables}
+    return render(request, template, context)
+
 def package(request, build_id):
     template = 'package.html'
 
@@ -48,7 +54,7 @@ def package(request, build_id):
             if t == k.package:
                 t.depends_on.append(k.depends_on)
 
-    context = {'packages': packages}
+    context = {'build' : build_id ,'packages': packages}
 
     return render(request, template, context)
 
-- 
1.8.1.2


