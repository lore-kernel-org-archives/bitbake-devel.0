Return-Path: <ddalex@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id ABD6A6CB63
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:13 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 24 Sep 2013 09:53:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="406511909"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2013 09:53:13 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 487D056297A; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:45 +0100
Message-Id: <120c4325b3180b5930a16d709e6bf3bd5fb5c158.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 76/94] bitbake: webhob: Simple visualisation for the build-time packages
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

Adding pages and views to allow viewing the data collected
about the build-time packages.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 .../webhob/bldviewer/templates/basebuildpage.html  | 17 ++++++++++
 .../lib/webhob/bldviewer/templates/bpackage.html   | 36 ++++++++++++++++++++++
 .../lib/webhob/bldviewer/templates/package.html    | 10 ------
 bitbake/lib/webhob/bldviewer/views.py              |  9 +++++-
 4 files changed, 61 insertions(+), 11 deletions(-)
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/basebuildpage.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/bpackage.html

diff --git a/bitbake/lib/webhob/bldviewer/templates/basebuildpage.html b/bitbake/lib/webhob/bldviewer/templates/basebuildpage.html
new file mode 100644
index 0000000..478019b
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templates/basebuildpage.html
@@ -0,0 +1,17 @@
+{% extends "basetable.html" %}
+
+{% block pagename %}
+<ul class="nav nav-tabs" style="display: inline-block">
+  <li><a>Build {{build.target_set.all|join:"&nbsp;"}} at {{build.started_on}} : </a></li>
+  <li><a href="/simple/build/{{build.id}}/task/"> Tasks </a></li>
+  <li><a href="/simple/build/{{build.id}}/packages/"> Build Packages </a></li>
+    {% for t in build.target_set.all %}
+        {% if t.is_image %}
+  <li><a href="/simple/build/{{build.id}}/target/{{t.pk}}/packages/"> Packages for {{t.target}} </a> </li>
+        {% endif %}
+    {% endfor %}
+  <li><a href="/simple/build/{{build.id}}/configuration/"> Configuration </a> </li>
+</ul>
+     <h1>Toaster - Build {% block pagetitle %} {% endblock %}</h1>
+{% endblock %}
+
diff --git a/bitbake/lib/webhob/bldviewer/templates/bpackage.html b/bitbake/lib/webhob/bldviewer/templates/bpackage.html
new file mode 100644
index 0000000..4e6cb00
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templates/bpackage.html
@@ -0,0 +1,36 @@
+{% extends "basebuildpage.html" %}
+
+{% block pagetable %}
+    {% if not packages %}
+        <p>No packages were recorded for this target!</p>
+    {% else %}
+
+            <tr>
+            <th>Name</th>
+            <th>Version</th>
+            <th>Revision</th>
+            <th>Recipe</th>
+            <th>Summary</th>
+            <th>Section</th>
+            <th>Description</th>
+            <th>License</th>
+            </tr>
+
+            {% for package in packages %}
+
+            <tr class="data">
+                <td><a name="#{{package.name}}">{{package.name}}</a></td>
+                <td>{{package.version}}</td>
+                <td>{{package.revision}}</td>
+                <td><a href="/simple/layerversions/{{package.recipe.layer_version_id}}/recipes/#{{package.recipe.name}}">{{package.recipe.name}}</a>{{package.package_name}}</a></td>
+                
+            <td>{{package.summary}}</td>
+            <td>{{package.section}}</td>
+            <td>{{package.description}}</td>
+            <td>{{package.license}}</td>
+
+            {% endfor %}
+
+    {% endif %}
+
+{% endblock %}
diff --git a/bitbake/lib/webhob/bldviewer/templates/package.html b/bitbake/lib/webhob/bldviewer/templates/package.html
index cba21e1..4ce25ae 100644
--- a/bitbake/lib/webhob/bldviewer/templates/package.html
+++ b/bitbake/lib/webhob/bldviewer/templates/package.html
@@ -1,15 +1,5 @@
 {% extends "basebuildpage.html" %}
 
-{% block pagename %}
-<ul class="nav nav-tabs" style="display: inline-block">
-  <li><a>Build {{build}} : </a></li>
-  <li><a href="/simple/build/{{build}}/task/"> Tasks </a></li>
-  <li><a href="/simple/build/{{build}}/package/"> Package </a> </li>
-  <li><a href="/simple/build/{{build}}/configuration/"> Configuration </a> </li>
-</ul>
-     <h1>Toaster - Target Install Packages</h1>
-{% endblock %}
-
 {% block pagetable %}
     {% if not packages %}
         <p>No packages were recorded for this target!</p>
diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index cfc2a89..a1da8b3 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -3,7 +3,7 @@ import operator
 from django.db.models import Q
 from django.shortcuts import render
 from orm.models import Build, Task, Layer, Layer_Version, Recipe, Target_Package, LogMessage, Variable
-from orm.models import Task_Dependency, Target_Package_Dependency
+from orm.models import Task_Dependency, Target_Package_Dependency, Build_Package
 from django.views.decorators.cache import cache_control
 
 @cache_control(no_store=True)
@@ -36,6 +36,13 @@ def configuration(request, build_id):
     context = {'build': Build.objects.filter(pk=build_id)[0], 'configuration' : variables}
     return render(request, template, context)
 
+
+def bpackage(request, build_id):
+    template = 'bpackage.html'
+    packages = Build_Package.objects.filter(build = build_id)
+    context = {'build': Build.objects.filter(pk=build_id)[0], 'packages' : packages}
+    return render(request, template, context)
+
 def tpackage(request, build_id, target_id):
     template = 'package.html'
 
-- 
1.8.1.2


