Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 31A0F6CB6B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:20 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 24 Sep 2013 09:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; d="scan'208";a="364948564"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:13 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 4DB395629F6; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:47 +0100
Message-Id: <39406e6234dabd4034ec04263dcdcdd8f2d1120e.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 78/94] bitbake: webhob: simple visualisation for package files
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:23 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding a simple table visualisation for data collected
for package content - file names and file sizes.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/templates/bfile.html  | 24 ++++++++++++++++++++++
 .../lib/webhob/bldviewer/templates/bpackage.html   |  7 +++----
 bitbake/lib/webhob/bldviewer/urls.py               |  1 +
 bitbake/lib/webhob/bldviewer/views.py              |  9 ++++++--
 4 files changed, 35 insertions(+), 6 deletions(-)
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/bfile.html

diff --git a/bitbake/lib/webhob/bldviewer/templates/bfile.html b/bitbake/lib/webhob/bldviewer/templates/bfile.html
new file mode 100644
index 0000000..d4943c0
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templates/bfile.html
@@ -0,0 +1,24 @@
+{% extends "basebuildpage.html" %}
+
+{% block pagetitle %}Files for package {{files.0.bpackage.name}} {% endblock %}
+{% block pagetable %}
+    {% if not files %}
+        <p>No files were recorded for this package!</p>
+    {% else %}
+
+            <tr>
+            <th>Name</th>
+            <th>Size</th>
+            </tr>
+
+            {% for file in files %}
+
+            <tr class="data">
+            <td>{{file.path}}</td>
+            <td>{{file.size}}</td>
+
+            {% endfor %}
+
+    {% endif %}
+
+{% endblock %}
diff --git a/bitbake/lib/webhob/bldviewer/templates/bpackage.html b/bitbake/lib/webhob/bldviewer/templates/bpackage.html
index 4e6cb00..91e5f6f 100644
--- a/bitbake/lib/webhob/bldviewer/templates/bpackage.html
+++ b/bitbake/lib/webhob/bldviewer/templates/bpackage.html
@@ -1,5 +1,6 @@
 {% extends "basebuildpage.html" %}
 
+{% block pagetitle %}Packages{% endblock %}
 {% block pagetable %}
     {% if not packages %}
         <p>No packages were recorded for this target!</p>
@@ -8,7 +9,6 @@
             <tr>
             <th>Name</th>
             <th>Version</th>
-            <th>Revision</th>
             <th>Recipe</th>
             <th>Summary</th>
             <th>Section</th>
@@ -19,9 +19,8 @@
             {% for package in packages %}
 
             <tr class="data">
-                <td><a name="#{{package.name}}">{{package.name}}</a></td>
-                <td>{{package.version}}</td>
-                <td>{{package.revision}}</td>
+                <td><a name="#{{package.name}}" href="/simple/build/{{build.pk}}/package/{{package.pk}}/files/">{{package.name}} ({{package.filelist_bpackage.count}} files)</a></td>
+                <td>{{package.version}}-{{package.revision}}</td>
                 <td><a href="/simple/layerversions/{{package.recipe.layer_version_id}}/recipes/#{{package.recipe.name}}">{{package.recipe.name}}</a>{{package.package_name}}</a></td>
                 
             <td>{{package.summary}}</td>
diff --git a/bitbake/lib/webhob/bldviewer/urls.py b/bitbake/lib/webhob/bldviewer/urls.py
index d49f8a5..d6dd280 100644
--- a/bitbake/lib/webhob/bldviewer/urls.py
+++ b/bitbake/lib/webhob/bldviewer/urls.py
@@ -5,6 +5,7 @@ urlpatterns = patterns('bldviewer.views',
         url(r'^builds/$', 'build', name='build'),
         url(r'^build/(?P<build_id>\d+)/task/$', 'task', name='task'),
         url(r'^build/(?P<build_id>\d+)/packages/$', 'bpackage', name='bpackage'),
+        url(r'^build/(?P<build_id>\d+)/package/(?P<package_id>\d+)/files/$', 'bfile', name='bfile'),
         url(r'^build/(?P<build_id>\d+)/target/(?P<target_id>\d+)/packages/$', 'tpackage', name='tpackage'),
         url(r'^build/(?P<build_id>\d+)/configuration/$', 'configuration', name='configuration'),
         url(r'^layers/$', 'layer', name='layer'),
diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index a1da8b3..4ff23d3 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -3,7 +3,7 @@ import operator
 from django.db.models import Q
 from django.shortcuts import render
 from orm.models import Build, Task, Layer, Layer_Version, Recipe, Target_Package, LogMessage, Variable
-from orm.models import Task_Dependency, Target_Package_Dependency, Build_Package
+from orm.models import Task_Dependency, Target_Package_Dependency, Build_Package, Build_File
 from django.views.decorators.cache import cache_control
 
 @cache_control(no_store=True)
@@ -36,13 +36,18 @@ def configuration(request, build_id):
     context = {'build': Build.objects.filter(pk=build_id)[0], 'configuration' : variables}
     return render(request, template, context)
 
-
 def bpackage(request, build_id):
     template = 'bpackage.html'
     packages = Build_Package.objects.filter(build = build_id)
     context = {'build': Build.objects.filter(pk=build_id)[0], 'packages' : packages}
     return render(request, template, context)
 
+def bfile(request, build_id, package_id):
+    template = 'bfile.html'
+    files = Build_File.objects.filter(bpackage = package_id)
+    context = {'build': Build.objects.filter(pk=build_id)[0], 'files' : files}
+    return render(request, template, context)
+
 def tpackage(request, build_id, target_id):
     template = 'package.html'
 
-- 
1.8.1.2


