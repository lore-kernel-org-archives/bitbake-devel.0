Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id A41106E7D7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 16:50:02 +0000 (UTC)
Received: by mail-wg0-f41.google.com with SMTP id n12so2691757wgh.12
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 09:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=U7vRH51ojVbV6IlFy2w8kBonJmvjTDx7I/rYOK/rNWw=;
	b=HQnQLttEpaAxpZdwY3eg70VnJBE7+EJxCNSjzvoNvkt3J6DJQAWoGjd/FiY/bwUOfK
	1CZToSJNM6WieU1osa6fE/nQxEUuZuXSqXy5GFOGfHCGvvVJ9bTNsnN3FyPCHXHV5htN
	BpZCpO+Cv7H057nA82FcnBCfW+5pg9EdvDCKoQQe0HjQkUs2P1JkWuE+ElesCIh0NQSt
	PCMZvakQZM+ABlppA2Qq2tgDgIzKisDIXE8O0vrpEdK7hUAXfJNEaSLO5Vtviw3IjOeD
	AgMkeZh2zjhVlFrQSE0m58l6izbCiB8nnBARrxT5CFc6dzQZtam8vO07a6TKCK3KkNc9
	ht7g==
X-Gm-Message-State: ALoCoQmF0PtMxqRRJshkJho7IRA7CLZ14zAoW/siIf7w8oR3LZr8Qh3dTpMYoVmwbEYNtcN8S0ej
X-Received: by 10.180.188.66 with SMTP id fy2mr6356457wic.45.1395939003628;
	Thu, 27 Mar 2014 09:50:03 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	qg3sm13898256wic.10.2014.03.27.09.50.02 for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 27 Mar 2014 09:50:02 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 7AA3D5602F4; Thu, 27 Mar 2014 16:50:02 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Mar 2014 16:49:53 +0000
Message-Id: <30647848c4c202df4537eb2c1810ec0999dab4bd.1395938903.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <cover.1395938903.git.alexandru.damian@intel.com>
References: <cover.1395938903.git.alexandru.damian@intel.com>
Cc: Farrell Wymore <farrell.wymore@windriver.com>,
	David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 1/9] toaster: add Image detail and multiple targets to dashboard
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
X-List-Received-Date: Thu, 27 Mar 2014 16:50:05 -0000

From: David Reyna <David.Reyna@windriver.com>

Filled in the Image section detail information and allow for multiple targets.
Each target has a separate section. Added license manifest display. Changed the
target of the license manifest link. Added Tasks failed in the build summary.
The target lists required filters to create sorted lists.

[YOCTO #4258]
[YOCTO #5936]

Signed-off-by: Farrell Wymore <farrell.wymore@windriver.com>
---
 lib/toaster/orm/models.py                          |  5 ++
 .../toastergui/templates/basebuildpage.html        |  7 +-
 .../toastergui/templates/builddashboard.html       | 87 +++++++++++++++++-----
 lib/toaster/toastergui/views.py                    | 49 +++++++++++-
 4 files changed, 122 insertions(+), 26 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 3059908..4975433 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -50,6 +50,11 @@ class Build(models.Model):
     build_name = models.CharField(max_length=100)
     bitbake_version = models.CharField(max_length=50)
 
+    def get_sorted_target_list(self):
+        tgts = Target.objects.filter(build_id = self.id).order_by( 'target' );
+        return( tgts );
+
+
 @python_2_unicode_compatible
 class Target(models.Model):
     search_allowed_fields = ['target', 'file_name']
diff --git a/lib/toaster/toastergui/templates/basebuildpage.html b/lib/toaster/toastergui/templates/basebuildpage.html
index 636fca2..0ce5dbd 100644
--- a/lib/toaster/toastergui/templates/basebuildpage.html
+++ b/lib/toaster/toastergui/templates/basebuildpage.html
@@ -1,4 +1,5 @@
 {% extends "base.html" %}
+{% load projecttags %}
 {% load humanize %}
 {% block pagecontent %}
 
@@ -8,7 +9,7 @@
     <div class="section">
         <ul class="breadcrumb" id="breadcrumb">
 <li><a href="{% url 'all-builds' %}">All builds</a></li>
-<li><a href="{%url 'builddashboard' build.pk%}">{{build.target_set.all.0.target}} {%if build.target_set.all.count > 1%}(+{{build.target_set.all.count|add:"-1"}}){%endif%} {{build.machine}} ({{build.completed_on|date:"d/m/y H:i"}})</a></li>
+<li><a href="{%url 'builddashboard' build.pk%}">{{build.get_sorted_target_list.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%} {{build.machine}} ({{build.completed_on|date:"d/m/y H:i"}})</a></li>
             {% block localbreadcrumb %}{% endblock %}
         </ul>
         <script>
@@ -25,10 +26,12 @@
         <!-- begin left sidebar container -->
         <div id="nav" class="span2">
             <ul class="nav nav-list well">
+              {% if build.target_set.all.0.is_image %}
                 <li class="nav-header">Images</li>
-            {% for t in build.target_set.all|dictsort:"target" %}
+            {% for t in build.get_sorted_target_list %}
                 <li><a href="{% url 'target' build.pk t.pk %}">{{t.target}}</a><li>
             {% endfor %}
+                  {% endif %}
                 <li class="nav-header">Build</li>
                 <li><a href="{% url 'configuration' build.pk %}">Configuration</a></li>
                 <li><a href="{% url 'tasks' build.pk %}">Tasks</a></li>
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index 763a28d..9d91f40 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -1,15 +1,12 @@
 {% extends "basebuildpage.html" %}
 {% load humanize %}
 {% load projecttags %}
-{% block localbreadcrumb %}
-<li>Dashboard</li>
-{% endblock %}
 
 {% block buildinfomain %}
 <!-- page title -->
 <div class="row-fluid span10">
  <div class="page-header">
-     <h1>{{build.target_set.all|join:" "}} {{build.machine}}</h1>
+     <h1>{{build.target_set.all|join:", "}} {{build.machine}}</h1>
  </div>
 </div>
 
@@ -17,13 +14,25 @@
 <div class="row-fluid span10 pull-right">
   <div class="alert {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%}">
     <div class="row-fluid lead">
-            <span class="pull-left"><strong>{%if build.outcome == build.SUCCEEDED%}Completed{%elif build.outcome == build.FAILED%}Failed{%else%}{%endif%}</strong> {{build.completed_on|date:"d/m/y H:i"}} with </span>{%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}{% if  build.errors_no %}
-            <span class="span2"><i class="icon-minus-sign red"></i><strong><a href="#errors" class="error"> {{build.errors_no}} error{{build.errors_no|pluralize}}</a></strong></span>
+            <span class="pull-left"><strong>
+                {%if build.outcome == build.SUCCEEDED%}Completed{%elif build.outcome == build.FAILED%}Failed{%else%}{%endif%}
+              </strong>
+            {{build.completed_on|date:"d/m/y H:i"}}
+</span>
+{% if  build.warnings_no or build.errors_no %}
+&nbsp;with
+{% endif %}
+{%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
+{% if  build.errors_no %}
+     <span > <i class="icon-minus-sign red"></i><strong><a href="#errors" class="error"> {{build.errors_no}} error{{build.errors_no|pluralize}}</a></strong></span>
 {% endif %}
 {% if  build.warnings_no %}
-            <span class="span2"><i class="icon-warning-sign yellow"></i><strong><a href="#warnings" class="warning"> {{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a></strong></span>
+{% if  build.errors_no %}
+&nbsp;and
+{% endif %}
+    <span > <i class="icon-warning-sign yellow"></i><strong><a href="#warnings" class="warning"> {{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a></strong></span>
 {% endif %}
-            <span class="pull-right">Build time: <a href="build-time.html">{{ build.timespent|sectohms }}</a></span>
+            <span class="pull-right">Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent|sectohms }}</a></span>
 {%endif%}
     </div>
   </div>
@@ -58,10 +67,40 @@
 {%if build.outcome == build.SUCCEEDED%}
 <!-- built images -->
 <div class="row-fluid span10 pull-right">
-  <h2>Images</h2>
-
-<div class="well" style="background-color:transparent;">
-</div>
+  {% if hasImages %}
+	<h2>Images</h2>
+	{% for target in targets %}
+        {% if target.target.is_image %}
+	<div class="well" style="background-color:transparent;">
+		<h3><a href="{% url 'target' build.pk target.target.pk %}">{{target.target}}</a>
+                </h3>
+		<dl class="dl-horizontal">
+			<dt>Packages included</dt>
+			<dd><a href="{% url 'packages' build.pk %}">{{target.npkg}}</a></dd>
+			<dt>Total package size</dt>
+			<dd>{{target.pkgsz|filtered_filesizeformat}}</dd>
+			<dt>
+				<i class="icon-question-sign get-help" title="The location in disk of the license manifest, a document listing all packages installed in your image and their licenses"></i>
+				License manifest
+			</dt>
+			<dd><a href="{% url 'targetpackages' build.pk target.target.pk %}"><code>{{target.target.license_manifest_path}}</code></a></dd>
+			<dt>
+				<i class="icon-question-sign get-help" title="Image files are stored in <code style='background-color:transparent;color:#FFFFFF;font-weight:normal;border:none;'>/build/tmp/deploy/images/</code>"></i>
+				Image files
+			</dt>
+			<dd>
+				<ul>
+                                  {% for i in target.imageFiles %}
+					<li><strong>{{i.path}}</strong>
+					({{i.size|filtered_filesizeformat}})</li>
+                                  {% endfor %}
+				</ul>
+			</dd>
+		</dl>
+	</div>
+        {% endif %}
+	{% endfor %}
+  {% endif %}
 </div>
 
 {%else%}
@@ -75,24 +114,32 @@
         <h4><a href="{%url 'configuration' build.pk%}">Configuration</a></h4>
             <dl>
         <dt>Machine</dt><dd>{{build.machine}}</dd>
-        <dt>Distro</dt><dd></dd>
-        <dt>Layers</dt>{% for i in build.layer_version_build.all %}<dd>{{i.layer.name}}</dd>{%endfor%}
+        <dt>Distro</dt><dd>{{build.distro}}</dd>
+        <dt>Layers</dt>{% for i in build.layer_version_build.all|dictsort:"layer.name" %}<dd>{{i.layer.name}}</dd>{%endfor%}
             </dl>
     </div>
     <div class="well span4" style="background-color:transparent;">
         <h4><a href="{%url 'tasks' build.pk%}">Tasks</a></h4>
             <dl>
-        <dt>Total number of tasks</dt><dd>{{build.task_build.all.count}}</dd>
-        <dt>Tasks executed</dt><dd>{% query build.task_build task_executed=1 order__gt=0 as exectask%}{{exectask.count}}</dd>
-        <dt>Tasks prebuilt</dt><dd>{% query build.task_build task_executed=0 order__gt=0 as noexectask%}{{noexectask.count}}</dd>
-        <dt>Reuse</dt><dd>{% query build.task_build order__gt=0 as texec %}{{noexectask.count|multiply:100|divide:texec.count}}%</dd>
+        <dt>Total number of tasks</dt><dd><a href="{% url 'tasks' build.pk %}">{{build.task_build.all.count}}</a></dd>
+        <dt>Tasks executed</dt><dd><a href="{% url 'tasks' build.pk %}?filter=task_executed%3A1&amp;count=25&amp;search=&amp;page=1&amp;orderby=order%3A%2B">{% query build.task_build task_executed=1 order__gt=0 as exectask%}{{exectask.count}}</a></dd>
+        <dt>Tasks not executed</dt><dd><a href="{% url 'tasks' build.pk %}?filter=task_executed%3A0&amp;count=25&amp;search=&amp;page=1&amp;orderby=order%3A%2B">{% query build.task_build task_executed=0 order__gt=0 as noexectask%}{{noexectask.count}}</a></dd>
+        <dt>Reuse</dt><dd>
+{% query build.task_build order__gt=0 as texec %}
+{% if noexectask.count|multiply:100|divide:texec.count < 0 %}
+0
+{% else %}
+{{noexectask.count|multiply:100|divide:texec.count}}
+{% endif %}
+%
+        </dd>
             </dl>
     </div>
     <div class="well span4" style="background-color:transparent;">
         <h4><a href="{% url 'recipes' build.pk %}">Recipes</a> & <a href="{% url 'packages' build.pk %}">Packages</a></h4>
             <dl>
-        <dt>Recipes used</dt><dd>{{recipecount}}</dd>
-        <dt>Packages built</dt><dd>{{build.package_set.all.count}}</dd>
+        <dt>Recipes built</dt><dd><a href="{% url 'recipes' build.pk %}">{{recipecount}}</a></dd>
+        <dt>Packages built</dt><dd><a href="{% url 'packages' build.pk %}">{{build.package_set.all.count}}</a></dd>
             </dl>
     </div>
 </div>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index d1234fe..4f31ddb 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -25,7 +25,7 @@ from django.db.models import Q, Sum
 from django.shortcuts import render, redirect
 from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe, LogMessage, Variable
 from orm.models import Task_Dependency, Recipe_Dependency, Package, Package_File, Package_Dependency
-from orm.models import Target_Installed_Package, Target_File
+from orm.models import Target_Installed_Package, Target_Image_File
 from django.views.decorators.cache import cache_control
 from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
 from django.http import HttpResponseBadRequest
@@ -350,18 +350,59 @@ def builds(request):
     return render(request, template, context)
 
 
+##
 # build dashboard for a single build, coming in as argument
+# Each build may contain multiple targets and each target
+# may generate multiple image files. display them all.
+#
 def builddashboard(request, build_id):
     template = "builddashboard.html"
     if Build.objects.filter(pk=build_id).count() == 0 :
         return redirect(builds)
+    build = Build.objects.filter(pk = build_id)[0];
+    layerVersionId = Layer_Version.objects.filter( build = build_id );
+    recipeCount = Recipe.objects.filter( layer_version__id__in = layerVersionId ).count( );
+    tgts = Target.objects.filter( build_id = build_id ).order_by( 'target' );
+
+    # set up custom target list with computed package and image data
+    targets = [ ];
+    ntargets = 0;
+    hasImages = False;
+    for t in tgts:
+        elem = { };
+        elem[ 'target' ] = t;
+        if ( t.is_image ):
+            hasImages = True;
+        npkg = 0;
+        pkgsz = 0;
+        pid= 0;
+        tp = Target_Installed_Package.objects.filter( target_id = t.id );
+        package = None;
+        for p in tp:
+            pid = p.package_id;
+            package = Package.objects.get( pk = p.package_id )
+            pkgsz = pkgsz + package.size;
+            npkg = npkg + 1;
+        elem[ 'npkg' ] = npkg;
+        elem[ 'pkgsz' ] = pkgsz;
+        ti = Target_Image_File.objects.filter( target_id = t.id );
+        imageFiles = [ ];
+        for i in ti:
+            imageFiles.append({ 'path': i.file_name, 'size' : i.file_size });
+        elem[ 'imageFiles' ] = imageFiles;
+        targets.append( elem );
+
     context = {
-            'build' : Build.objects.filter(pk=build_id)[0],
-            'recipecount' : Recipe.objects.filter(layer_version__id__in=Layer_Version.objects.filter(build=build_id)).count(),
-            'logmessages' : LogMessage.objects.filter(build=build_id),
+            'build'           : build,
+            'hasImages'       : hasImages,
+            'ntargets'        : ntargets,
+            'targets'         : targets,
+            'recipecount'     : recipeCount,
+            'logmessages'     : LogMessage.objects.filter(build=build_id),
     }
     return render(request, template, context)
 
+
 def task(request, build_id, task_id):
     template = "task.html"
     if Task.objects.filter(pk=task_id).count() == 0 :
-- 
1.8.3.2


