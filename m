Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id B48606E250
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Dec 2013 19:07:46 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 09 Dec 2013 11:07:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,859,1378882800"; d="scan'208";a="449360023"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.25])
	by orsmga002.jf.intel.com with ESMTP; 09 Dec 2013 11:07:40 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Dec 2013 19:07:16 +0000
Message-Id: <d4f075c050ad9ecebe750420d49961a7f30d090b.1386615747.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1386615747.git.paul.eggleton@linux.intel.com>
References: <cover.1386615747.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1386615747.git.paul.eggleton@linux.intel.com>
References: <cover.1386615747.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 10/11] toaster: add pagination to the Simple UI
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
X-List-Received-Date: Mon, 09 Dec 2013 19:07:46 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

In an effort to make the Simple UI more usable and
reponsive, this patch adds pagination support for the
pages with lots of entries: Builds, Configuration and
Tasks.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldviewer/templates/basetable.html     | 22 +++++++++-
 lib/toaster/bldviewer/templates/bfile.html         |  6 +--
 lib/toaster/bldviewer/templates/bpackage.html      |  6 +--
 lib/toaster/bldviewer/templates/build.html         |  2 +-
 lib/toaster/bldviewer/templates/configuration.html |  2 +-
 lib/toaster/bldviewer/templates/layer.html         |  2 +-
 lib/toaster/bldviewer/templates/package.html       |  4 +-
 lib/toaster/bldviewer/templates/recipe.html        |  2 +-
 lib/toaster/bldviewer/templates/task.html          |  4 +-
 lib/toaster/bldviewer/views.py                     | 47 ++++++++++++++++------
 10 files changed, 69 insertions(+), 28 deletions(-)

diff --git a/lib/toaster/bldviewer/templates/basetable.html b/lib/toaster/bldviewer/templates/basetable.html
index 083bcb8..16628ea 100644
--- a/lib/toaster/bldviewer/templates/basetable.html
+++ b/lib/toaster/bldviewer/templates/basetable.html
@@ -26,7 +26,7 @@ function filterTableRows(test) {
 
     {% block pagename %}
     {% endblock %}
-    <div align="left" style="display:inline-block; width: 40%; margin-left: 2em"> Search: <input type="search" id="filterstring" style="width: 80%" onkeyup="filterTableRows($('#filterstring').val())" autocomplete="off">
+    <div align="left" style="display:inline-block; width: 40%; margin-left: 2em"> Filter: <input type="search" id="filterstring" style="width: 80%" onkeyup="filterTableRows($('#filterstring').val())" autocomplete="off">
     </div>
     {% if hideshowcols %}
     <div align="right" style="display: inline-block; width: 40%">Show/Hide columns:
@@ -36,7 +36,25 @@ function filterTableRows(test) {
     </div>
     {% endif %}
 </div>
-<div>
+
+   <div style="display: block; float:right; margin-left: auto; margin-right:5em"><span class="pagination" style="vertical-align: top; margin-right: 3em">Showing {{objects.start_index}} to {{objects.end_index}} out of {{objects.paginator.count}} entries.&nbsp;</span>
+   <ul class="pagination" style="display: block-inline">
+{%if objects.has_previous %}
+  <li><a href="?page={{objects.previous_page_number}}">&laquo;</a></li>
+{%else%}
+  <li class="disabled"><a href="#">&laquo;</a></li>
+{%endif%}
+{% for i in objects.page_range %}
+  <li{%if i == objects.number %} class="active" {%endif%}><a href="?page={{i}}">{{i}}</a></li>
+{% endfor %}
+{%if objects.has_next%}
+  <li><a href="?page={{objects.next_page_number}}">&raquo;</a></li>
+{%else%}
+  <li class="disabled"><a href="#">&raquo;</a></li>
+{%endif%}
+  </ul>
+</div>
+
     <table class="table table-striped table-condensed" style="width:95%">
 {% block pagetable %}
 {% endblock %}
diff --git a/lib/toaster/bldviewer/templates/bfile.html b/lib/toaster/bldviewer/templates/bfile.html
index d90f4fb..c7f5943 100644
--- a/lib/toaster/bldviewer/templates/bfile.html
+++ b/lib/toaster/bldviewer/templates/bfile.html
@@ -1,8 +1,8 @@
 {% extends "basebuildpage.html" %}
 
-{% block pagetitle %}Files for package {{files.0.bpackage.name}} {% endblock %}
+{% block pagetitle %}Files for package {{objects.0.bpackage.name}} {% endblock %}
 {% block pagetable %}
-    {% if not files %}
+    {% if not objects %}
         <p>No files were recorded for this package!</p>
     {% else %}
 
@@ -11,7 +11,7 @@
             <th>Size (Bytes)</th>
             </tr>
 
-            {% for file in files %}
+            {% for file in objects %}
 
             <tr class="data">
             <td>{{file.path}}</td>
diff --git a/lib/toaster/bldviewer/templates/bpackage.html b/lib/toaster/bldviewer/templates/bpackage.html
index 07d0792..67fc65c 100644
--- a/lib/toaster/bldviewer/templates/bpackage.html
+++ b/lib/toaster/bldviewer/templates/bpackage.html
@@ -2,7 +2,7 @@
 
 {% block pagetitle %}Packages{% endblock %}
 {% block pagetable %}
-    {% if not packages %}
+    {% if not objects %}
         <p>No packages were recorded for this target!</p>
     {% else %}
 
@@ -18,12 +18,12 @@
             <th>Dependencies List (all)</th>
             </tr>
 
-            {% for package in packages %}
+            {% for package in objects %}
 
             <tr class="data">
                 <td><a name="#{{package.name}}" href="{% url "bfile" build.pk package.pk %}">{{package.name}} ({{package.filelist_bpackage.count}} files)</a></td>
                 <td>{{package.version}}-{{package.revision}}</td>
-                <td><a href="{% url "layer_versions_recipes" package.recipe.layer_version_id %}#{{package.recipe.name}}">{{package.recipe.name}}</a>{{package.package_name}}</a></td>
+                <td>{%if package.recipe%}<a href="{% url "layer_versions_recipes" package.recipe.layer_version_id %}#{{package.recipe.name}}">{{package.recipe.name}}</a>{{package.package_name}}</a>{%endif%}</td>
 
             <td>{{package.summary}}</td>
             <td>{{package.section}}</td>
diff --git a/lib/toaster/bldviewer/templates/build.html b/lib/toaster/bldviewer/templates/build.html
index 5653cca..4fa87d5 100644
--- a/lib/toaster/bldviewer/templates/build.html
+++ b/lib/toaster/bldviewer/templates/build.html
@@ -21,7 +21,7 @@
             <th>Bitbake Version</th>
             <th>Build Name</th>
         </tr>
-        {% for build in builds %}
+        {% for build in objects %}
         <tr class="data">
             <td><a href="{% url "configuration" build.id %}">{{build.get_outcome_display}}</a></td>
             <td>{{build.started_on}}</td>
diff --git a/lib/toaster/bldviewer/templates/configuration.html b/lib/toaster/bldviewer/templates/configuration.html
index 8db35e0..521620f 100644
--- a/lib/toaster/bldviewer/templates/configuration.html
+++ b/lib/toaster/bldviewer/templates/configuration.html
@@ -10,7 +10,7 @@
             <th>Value</th>
             </tr>
 
-            {% for variable in configuration %}
+            {% for variable in objects %}
 
             <tr class="data">
                 <td>{{variable.variable_name}}</td>
diff --git a/lib/toaster/bldviewer/templates/layer.html b/lib/toaster/bldviewer/templates/layer.html
index c5034de..410d766 100644
--- a/lib/toaster/bldviewer/templates/layer.html
+++ b/lib/toaster/bldviewer/templates/layer.html
@@ -14,7 +14,7 @@
             <th>Known Versions</th>
         </tr>
 
-        {% for layer in layers %}
+        {% for layer in objects %}
 
         <tr class="data">
             <td>{{layer.name}}</td>
diff --git a/lib/toaster/bldviewer/templates/package.html b/lib/toaster/bldviewer/templates/package.html
index fda9dab..1ba3726 100644
--- a/lib/toaster/bldviewer/templates/package.html
+++ b/lib/toaster/bldviewer/templates/package.html
@@ -1,7 +1,7 @@
 {% extends "basebuildpage.html" %}
 
 {% block pagetable %}
-    {% if not packages %}
+    {% if not objects %}
         <p>No packages were recorded for this target!</p>
     {% else %}
 
@@ -13,7 +13,7 @@
             <th>Depends on</th>
             </tr>
 
-            {% for package in packages %}
+            {% for package in objects %}
 
             <tr class="data">
                 <td><a name="#{{package.name}}">{{package.name}}</a></td>
diff --git a/lib/toaster/bldviewer/templates/recipe.html b/lib/toaster/bldviewer/templates/recipe.html
index 7d5fbf4..d7f57eb 100644
--- a/lib/toaster/bldviewer/templates/recipe.html
+++ b/lib/toaster/bldviewer/templates/recipe.html
@@ -25,7 +25,7 @@
             <th style="width: 30em">Recipe Dependency</th>
 
 
-        {% for recipe in recipes %}
+        {% for recipe in objects %}
 
         <tr class="data">
             <td><a name="{{recipe.name}}">{{recipe.name}}</a></td>
diff --git a/lib/toaster/bldviewer/templates/task.html b/lib/toaster/bldviewer/templates/task.html
index 5d9887e..6a9979e 100644
--- a/lib/toaster/bldviewer/templates/task.html
+++ b/lib/toaster/bldviewer/templates/task.html
@@ -2,7 +2,7 @@
 
 {% block pagetitle %}Tasks{% endblock %}
 {% block pagetable %}
-    {% if not tasks %}
+    {% if not objects %}
         <p>No tasks were executed in this build!</p>
     {% else %}
 
@@ -23,7 +23,7 @@
             <th>Depends</th>
             </tr>
 
-            {% for task in tasks %}
+            {% for task in objects %}
 
             <tr class="data">
                 <td>{{task.order}}</td>
diff --git a/lib/toaster/bldviewer/views.py b/lib/toaster/bldviewer/views.py
index 3eb785b..7cb9b42 100644
--- a/lib/toaster/bldviewer/views.py
+++ b/lib/toaster/bldviewer/views.py
@@ -24,15 +24,38 @@ from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe, LogMes
 from orm.models import Task_Dependency, Recipe_Dependency, Package, Package_File, Package_Dependency
 from orm.models import Target_Installed_Package
 from django.views.decorators.cache import cache_control
+from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
+
+
+def _build_page_range(paginator, index = 1):
+    try:
+        page = paginator.page(index)
+    except PageNotAnInteger:
+        page = paginator.page(1)
+    except  EmptyPage:
+        page = paginator.page(paginator.num_pages)
+
+    page.page_range = [page.number]
+    crt_range = 0
+    for i in range(1,5):
+        if (page.number + i) <= paginator.num_pages:
+            page.page_range = page.page_range + [ page.number + i]
+            crt_range +=1
+        if (page.number - i) > 0:
+            page.page_range =  [page.number -i] + page.page_range
+            crt_range +=1
+        if crt_range == 4:
+            break
+    return page
 
 @cache_control(no_store=True)
 def build(request):
     template = 'build.html'
-    build_info = Build.objects.all()
-
     logs = LogMessage.objects.all()
 
-    context = {'builds': build_info, 'logs': logs ,
+    build_info = _build_page_range(Paginator(Build.objects.order_by("-id"), 10),request.GET.get('page', 1))
+
+    context = {'objects': build_info, 'logs': logs ,
         'hideshowcols' : [
                 {'name': 'Output', 'order':10},
                 {'name': 'Log', 'order':11},
@@ -61,38 +84,38 @@ def _find_task_provider(task):
 def task(request, build_id):
     template = 'task.html'
 
-    tasks = Task.objects.filter(build=build_id)
+    tasks = _build_page_range(Paginator(Task.objects.filter(build=build_id), 100),request.GET.get('page', 1))
 
     for t in tasks:
         if t.outcome == Task.OUTCOME_COVERED:
             t.provider = _find_task_provider(t)
 
-    context = {'build': Build.objects.filter(pk=build_id)[0], 'tasks': tasks}
+    context = {'build': Build.objects.filter(pk=build_id)[0], 'objects': tasks}
 
     return render(request, template, context)
 
 def configuration(request, build_id):
     template = 'configuration.html'
-    variables = Variable.objects.filter(build=build_id)
-    context = {'build': Build.objects.filter(pk=build_id)[0], 'configuration' : variables}
+    variables = _build_page_range(Paginator(Variable.objects.filter(build=build_id), 50), request.GET.get('page', 1))
+    context = {'build': Build.objects.filter(pk=build_id)[0], 'objects' : variables}
     return render(request, template, context)
 
 def bpackage(request, build_id):
     template = 'bpackage.html'
     packages = Package.objects.filter(build = build_id)
-    context = {'build': Build.objects.filter(pk=build_id)[0], 'packages' : packages}
+    context = {'build': Build.objects.filter(pk=build_id)[0], 'objects' : packages}
     return render(request, template, context)
 
 def bfile(request, build_id, package_id):
     template = 'bfile.html'
     files = Package_File.objects.filter(package = package_id)
-    context = {'build': Build.objects.filter(pk=build_id)[0], 'files' : files}
+    context = {'build': Build.objects.filter(pk=build_id)[0], 'objects' : files}
     return render(request, template, context)
 
 def tpackage(request, build_id, target_id):
     template = 'package.html'
     packages = map(lambda x: x.package, list(Target_Installed_Package.objects.filter(target=target_id)))
-    context = {'build': Build.objects.filter(pk=build_id)[0], 'packages' : packages}
+    context = {'build': Build.objects.filter(pk=build_id)[0], 'objects' : packages}
     return render(request, template, context)
 
 def layer(request):
@@ -104,7 +127,7 @@ def layer(request):
         for liv in li.versions:
             liv.count = Recipe.objects.filter(layer_version__id = liv.id).count()
 
-    context = {'layers': layer_info}
+    context = {'objects': layer_info}
 
     return render(request, template, context)
 
@@ -113,7 +136,7 @@ def layer_versions_recipes(request, layerversion_id):
     template = 'recipe.html'
     recipes = Recipe.objects.filter(layer_version__id = layerversion_id)
 
-    context = {'recipes': recipes,
+    context = {'objects': recipes,
             'layer_version' : Layer_Version.objects.filter( id = layerversion_id )[0]
     }
 
-- 
1.8.1.2


