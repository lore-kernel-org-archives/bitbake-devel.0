Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id B479775A1B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:34:14 +0000 (UTC)
Received: by wguu7 with SMTP id u7so58663951wgu.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Joqtj6t9WwDexYP6BWVrBxwqmRBs4y4bUeEU04LuCMA=;
	b=ivwTka0SDo5krpCfydrnYYoB7+QZxSeCSfwcCOfifn1+ztvIoSNghGJM8v6EEHkvPy
	js9d7NGEbfhytrBa0JUNAK9DAY7ZQJfVRFmcBKFlzRGdhzaD2CLZd3KbWb7MUcnSywMK
	EouCpOvRM6V4aZecdR618gTK/6Jm/ZC2DQMxJHM51ecJDHrZb9u9N9bywWGEOqDo7SIV
	jboGTJ5cDChfTv20HWoBLZ4SFtigCVgJm+AOETyUmqSzd0v5zu2tb7OWoMlQs964g5sJ
	DJvK+uLz3pVxMa+Qo0xjrRfN37LCUcE2dBj3A+Yh2+YlW29ehnFBaqPRHFwqZfUBLclw
	Nadw==
X-Gm-Message-State: ALoCoQkYCYWRbRyiY6ZPVc7M3dlvedko/dy9+blfP3nHSA6nASCprFX+rKj47SxYLyUr41TTO5vw
X-Received: by 10.180.86.168 with SMTP id q8mr4342375wiz.80.1435228452233;
	Thu, 25 Jun 2015 03:34:12 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id m4sm45128547wjb.37.2015.06.25.03.34.11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:34:11 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id C0A24561FA0; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:42 +0100
Message-Id: <0ac02d3775106b485e29496b62f31e91fd3f9387.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
References: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
Subject: [PATCH 05/23] toaster: remove MANAGED references
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
X-List-Received-Date: Thu, 25 Jun 2015 10:34:17 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We conflate the managed and analysis modes by
deleting alternative code paths, favouring the MANAGED mode,
always considering the MANAGED variable True.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/orm/models.py                          |   4 +-
 lib/toaster/toastergui/templates/base.html         |   9 +-
 .../toastergui/templates/basebuilddetailpage.html  |   4 +-
 .../toastergui/templates/basebuildpage.html        |   6 +-
 .../templates/basetable_top_buildprojects.html     |   2 -
 .../templates/basetable_top_projectbuilds.html     |   2 -
 lib/toaster/toastergui/templates/bpackage.html     |   3 -
 lib/toaster/toastergui/templates/build.html        |   8 --
 .../toastergui/templates/builddashboard.html       |  16 ----
 lib/toaster/toastergui/views.py                    | 103 +--------------------
 10 files changed, 8 insertions(+), 149 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 8819450..422f2bf 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -288,9 +288,7 @@ class BuildArtifact(models.Model):
 
 
     def is_available(self):
-        if settings.MANAGED and build.project is not None:
-            return build.buildrequest.environment.has_artifact(file_path)
-        return False
+        return build.buildrequest.environment.has_artifact(file_path)
 
 class ProjectTarget(models.Model):
     project = models.ForeignKey(Project)
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 3f3253d..7430338 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -48,7 +48,6 @@
   };
 </script>
 <script src="{% static 'js/base.js' %}"></script>
-{%if MANAGED %}
 <script>
   $(document).ready(function () {
     /* Vars needed for base.js */
@@ -59,10 +58,6 @@
     basePageInit(ctx);
   });
 </script>
-{% endif %}
-<script>
-
-</script>
 
 {% block extraheadcontent %}
 {% endblock %}
@@ -80,14 +75,13 @@
             <span class="brand">
                 <a href="/">Toaster</a>
                 {% if DEBUG %}
-                    <i class="icon-info-sign" title="<strong>Toaster version information</strong>" data-content="<dl><dt>Branch</dt><dd>{{TOASTER_BRANCH}}</dd><dt>Revision</dt><dd>{{TOASTER_REVISION}}</dd><dt>Mode</dt><dd>{%if MANAGED%}Build{%else%}Analysis{%endif%}</dd></dl>"></i>
+                    <i class="icon-info-sign" title="<strong>Toaster version information</strong>" data-content="<dl><dt>Branch</dt><dd>{{TOASTER_BRANCH}}</dd><dt>Revision</dt><dd>{{TOASTER_REVISION}}</dd></dl>"></i>
                 {% endif %}
             </span>
             <a class="pull-right manual" target="_blank" href="http://www.yoctoproject.org/docs/latest/toaster-manual/toaster-manual.html">
                 <i class="icon-book"></i>
                 Toaster manual
             </a>
-            {%if MANAGED %}
             <div class="btn-group pull-right">
                   <a class="btn" id="new-project-button" href="{% url 'newproject' %}">New project</a>
             </div>
@@ -132,7 +126,6 @@
               </ul>
             </div>
 
-            {%endif%}
 
     </div>
 </div>
diff --git a/lib/toaster/toastergui/templates/basebuilddetailpage.html b/lib/toaster/toastergui/templates/basebuilddetailpage.html
index c8e217e..d324c90 100644
--- a/lib/toaster/toastergui/templates/basebuilddetailpage.html
+++ b/lib/toaster/toastergui/templates/basebuilddetailpage.html
@@ -7,10 +7,8 @@
     <div class="section">
         <ul class="breadcrumb" id="breadcrumb">
             <li><a href="{% url 'all-builds' %}">All builds</a></li>
-      {% if MANAGED and build.project %}
             <li><a href="{% url 'project' build.project.id %}">{{build.project.name}}</a></li>
-      {%endif%}
-            <li><a href="{%url 'builddashboard' build.pk%}">{{build.target_set.all.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%}{%if not MANAGED %}{{build.machine}}{%endif%} ({{build.completed_on|date:"d/m/y H:i"}})</a></li>
+            <li><a href="{%url 'builddashboard' build.pk%}">{{build.target_set.all.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%} ({{build.completed_on|date:"d/m/y H:i"}})</a></li>
             {% block localbreadcrumb %}{% endblock %}
         </ul>
         <script>
diff --git a/lib/toaster/toastergui/templates/basebuildpage.html b/lib/toaster/toastergui/templates/basebuildpage.html
index c03f1b4..b7a4dd2 100644
--- a/lib/toaster/toastergui/templates/basebuildpage.html
+++ b/lib/toaster/toastergui/templates/basebuildpage.html
@@ -8,14 +8,12 @@
 <!-- Breadcrumbs -->
     <div class="section">
         <ul class="breadcrumb" id="breadcrumb">
-              <li><a href="{% url 'all-builds' %}">All builds</a></li>
-          {% if MANAGED and build.project %}
+            <li><a href="{% url 'all-builds' %}">All builds</a></li>
             <li><a href="{% url 'project' build.project.id %}">{{build.project.name}}</a></li>
-          {%endif%}
             <li>
             {% block parentbreadcrumb %}
             <a href="{%url 'builddashboard' build.pk%}">
-                {{build.get_sorted_target_list.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%} {%if not MANAGED %}{{build.machine}}{% endif %} ({{build.completed_on|date:"d/m/y H:i"}})
+                {{build.get_sorted_target_list.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%} ({{build.completed_on|date:"d/m/y H:i"}})
             </a>
             {% endblock %}
             </li>
diff --git a/lib/toaster/toastergui/templates/basetable_top_buildprojects.html b/lib/toaster/toastergui/templates/basetable_top_buildprojects.html
index d517179..7b19f4b 100644
--- a/lib/toaster/toastergui/templates/basetable_top_buildprojects.html
+++ b/lib/toaster/toastergui/templates/basetable_top_buildprojects.html
@@ -1,7 +1,6 @@
 {% extends "basetable_top.html" %}
 
 {%block custombuttons %}
-{% if MANAGED %}
   <div class="btn-group builds-projects">
     <button class="btn dropdown-toggle" data-toggle="dropdown">
         <span class="selection">Show all builds</span>
@@ -12,5 +11,4 @@
         <li><a href="{% url 'all-projects'%}">Show all projects</a></li>
     </ul>
   </div>
-{% endif %}
 {%endblock%}
diff --git a/lib/toaster/toastergui/templates/basetable_top_projectbuilds.html b/lib/toaster/toastergui/templates/basetable_top_projectbuilds.html
index bfefff5..f5b01c8 100644
--- a/lib/toaster/toastergui/templates/basetable_top_projectbuilds.html
+++ b/lib/toaster/toastergui/templates/basetable_top_projectbuilds.html
@@ -1,7 +1,6 @@
 {% extends "basetable_top.html" %}
 
 {%block custombuttons %}
-{% if MANAGED %}
   <div class="btn-group builds-projects">
     <button class="btn dropdown-toggle" data-toggle="dropdown">
         <span class="selection">Show all projects</span>
@@ -12,5 +11,4 @@
         <li><a href="{% url 'all-projects'%}">Show all projects</a></li>
     </ul>
   </div>
-{% endif %}
 {%endblock%}
diff --git a/lib/toaster/toastergui/templates/bpackage.html b/lib/toaster/toastergui/templates/bpackage.html
index 1c47354..d775fec 100644
--- a/lib/toaster/toastergui/templates/bpackage.html
+++ b/lib/toaster/toastergui/templates/bpackage.html
@@ -88,9 +88,6 @@
                 </a>
             </td>
             <!-- Layer directory -->
-            {% if not MANAGED or not build.project %}
-                <td class="recipe__layer_version__local_path">{{package.recipe.layer_version.local_path}}</td>
-            {% endif %}
         {%else%}
             <td class="recipe__name"></td>
             <td class="recipe__version"></td>
diff --git a/lib/toaster/toastergui/templates/build.html b/lib/toaster/toastergui/templates/build.html
index f7ad2f4..f0b5ea5 100644
--- a/lib/toaster/toastergui/templates/build.html
+++ b/lib/toaster/toastergui/templates/build.html
@@ -68,11 +68,9 @@
                 {% query build.task_build outcome=4 order__gt=0 as exectask%}
                     {% if exectask.count == 1 %}
                         <a href="{% url "task" build.id exectask.0.id %}">{{exectask.0.recipe.name}}.{{exectask.0.task_name}}</a>
-                      {% if MANAGED and build.project %}
                         <a href="{% url 'build_artifact' build.id "tasklogfile" exectask.0.id %}">
                             <i class="icon-download-alt" title="" data-original-title="Download task log file"></i>
                         </a>
-                      {% endif %}
                     {% elif exectask.count > 1%}
                         <a href="{% url "tasks" build.id %}?filter=outcome%3A4">{{exectask.count}} task{{exectask.count|pluralize}}</a>
                     {%endif%}
@@ -84,21 +82,15 @@
             </td>
             <td class="warnings_no">{% if  build.warnings_no %}<a class="warnings_no warning" href="{% url "builddashboard" build.id %}#warnings">{{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a>{%endif%}</td>
             <td class="time"><a href="{% url "buildtime" build.id %}">{{build.timespent|sectohms}}</a></td>
-            {% if not MANAGED or not build.project %}
-                <td class="log">{{build.cooker_log_path}}</td>
-            {% endif %}
             <td class="output">
               {% if build.outcome == build.SUCCEEDED %}
               <a href="{%url "builddashboard" build.id%}#images">{{fstypes|get_dict_value:build.id}}</a>
               {% endif %}
             </td>
-   {% if MANAGED %}
-            <td class="project">
             {% if build.project %}
                 <a href="{% url 'project' build.project.id %}">{{build.project.name}}</a>
             {% endif %}
             </td>
-   {% endif %}
         </tr>
 
         {% endfor %}
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index ad497e6..47b8d7a 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -37,9 +37,7 @@
     <span > <i class="icon-warning-sign yellow"></i><strong><a href="#warnings" class="warning show-warnings"> {{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a></strong></span>
 {% endif %}
             <span class="pull-right">Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent|sectohms }}</a>
-      {% if MANAGED and build.project %}
             <a class="btn {%if build.outcome == build.SUCCEEDED%}btn-success{%else%}btn-danger{%endif%} pull-right log" href="{% url 'build_artifact' build.id "cookerlog" build.id %}">Download build log</a>
-      {% endif %}
             </span>
 {%endif%}
     </div>
@@ -117,19 +115,11 @@
             <dt>
                 <i class="icon-question-sign get-help" title="The location in disk of the license manifest, a document listing all packages installed in your image and their licenses"></i>
 
-            {% if MANAGED and build.project %}
                 License manifest
-            {% else %}
-                <a href="{% url 'targetpkg' build.pk target.target.pk %}">License manifest</a>
-            {% endif %}
             </dt>
-            {% if MANAGED and build.project %}
             <dd>
                 <a href="{% url 'targetpkg' build.pk target.target.pk %}">View in Toaster</a> |
                 <a href="{% url 'build_artifact' build.pk 'licensemanifest' target.target.pk %}">Download</a></dd>
-            {% else %}
-            <dd><code>{{target.target.license_manifest_path}}</code></dd>
-            {% endif %}
             <dt>
                 <i class="icon-question-sign get-help" title="Image files are stored in <code>/build/tmp/deploy/images/</code>"></i>
                 Image files
@@ -170,13 +160,9 @@
                 Other artifacts</dt>
             <dd><div>
               {% for ba in build.buildartifact_set.all|dictsort:"file_name" %}
-                {% if MANAGED and build.project %}
                 <a href="{%url 'build_artifact' build.id 'buildartifact' ba.id %}">
-                {% endif %}
                     {{ba.get_local_file_name}}
-                {% if MANAGED and build.project %}
                 </a>
-                {% endif %}
 
                 ({{ba.file_size|filtered_filesizeformat}}) <br/>
               {% endfor %}
@@ -211,11 +197,9 @@
                         <span class="task-name">{{exectask.0.task_name}}</span>
                     </a>
 
-                      {% if MANAGED and build.project %}
                         <a href="{% url 'build_artifact' build.id "tasklogfile" exectask.0.id %}">
                             <i class="icon-download-alt" title="" data-original-title="Download task log file"></i>
                         </a>
-                      {% endif %}
 
                 {% elif exectask.count > 1%}
                     <a class="error" href="{% url "tasks" build.id %}?filter=outcome%3A4">{{exectask.count}}</a>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 4dac62c..bfae304 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -807,18 +807,6 @@ eans multiple licenses exist that cover different parts of the source',
                 ]
         }
 
-    if not toastermain.settings.MANAGED or build.project is None:
-
-        tc_layerDir = {
-            'name':'Layer directory',
-            'qhelp':'Location in disk of the layer providing the recipe that builds the package',
-            'orderfield' : _get_toggle_order( request, "recipe__layer_version__local_path" ),
-            'ordericon'  : _get_toggle_order_icon( request, "recipe__layer_version__local_path" ),
-            'orderkey'   : "recipe__layer_version__local_path",
-            'clclass'    : 'layer_directory',
-            'hidden'     : 1,
-        }
-        context['tablecols'].append(tc_layerDir)
 
     response = render(request, template, context)
     _set_parameters_values(pagesize, orderby, request)
@@ -1209,9 +1197,6 @@ def tasks_common(request, build_id, variant, task_anchor):
                 ]}
 
 
-    if not toastermain.settings.MANAGED or build.project is None:
-        context['tablecols'].append(tc_log)
-
     response = render(request, template, context)
     _set_parameters_values(pagesize, orderby, request)
     return response
@@ -1336,18 +1321,6 @@ def recipes(request, build_id):
             ]
         }
 
-    if not toastermain.settings.MANAGED or build.project is None:
-        context['tablecols'].append(
-            {
-                'name':'Layer directory',
-                'qhelp':'Path to the layer prodiving the recipe',
-                'orderfield': _get_toggle_order(request, "layer_version__local_path"),
-                'ordericon':_get_toggle_order_icon(request, "layer_version__local_path"),
-                'orderkey' : 'layer_version__local_path',
-                'clclass': 'layer_version__local_path', 'hidden': 1,
-            })
-
-
     response = render(request, template, context)
     _set_parameters_values(pagesize, orderby, request)
     return response
@@ -1550,18 +1523,6 @@ def bpackage(request, build_id):
             ]
         }
 
-    if not toastermain.settings.MANAGED or build.project is None:
-
-        tc_layerDir = {
-                'name':'Layer directory',
-                'qhelp':'Path to the layer providing the recipe that builds the package',
-                'orderfield': _get_toggle_order(request, "recipe__layer_version__local_path"),
-                'ordericon':_get_toggle_order_icon(request, "recipe__layer_version__local_path"),
-                'orderkey' : 'recipe__layer_version__local_path',
-                'clclass': 'recipe__layer_version__local_path', 'hidden': 1,
-        }
-        context['tablecols'].append(tc_layerDir)
-
     response = render(request, template, context)
     _set_parameters_values(pagesize, orderby, request)
     return response
@@ -1877,7 +1838,6 @@ def managedcontextprocessor(request):
     import subprocess
     ret = {
         "projects": Project.objects.all(),
-        "MANAGED" : toastermain.settings.MANAGED,
         "DEBUG" : toastermain.settings.DEBUG,
         "TOASTER_BRANCH": toastermain.settings.TOASTER_BRANCH,
         "TOASTER_REVISION" : toastermain.settings.TOASTER_REVISION,
@@ -1892,8 +1852,8 @@ from orm.models import Project, ProjectLayer, ProjectTarget, ProjectVariable
 
 # we have a set of functions if we're in managed mode, or
 # a default "page not available" simple functions for interactive mode
-if toastermain.settings.MANAGED:
 
+if True:
     from django.contrib.auth.models import User
     from django.contrib.auth import authenticate, login
     from django.contrib.auth.decorators import login_required
@@ -2937,11 +2897,8 @@ if toastermain.settings.MANAGED:
         return context
 
 
-else:
-    # shows the "all builds" page for interactive mode; this is the old code, simply moved
-
-    @_template_renderer('build.html')
-    def builds(request):
+    @_template_renderer('builds.html')
+    def builds_old(request):
         # define here what parameters the view needs in the GET portion in order to
         # be able to display something.  'count' and 'page' are mandatory for all views
         # that use paginators.
@@ -3132,57 +3089,3 @@ else:
         _set_parameters_values(pagesize, orderby, request)
 
         return context
-
-
-
-
-    @_template_renderer('landing_not_managed.html')
-    def newproject(request):
-        return {}
-
-    @_template_renderer('landing_not_managed.html')
-    def project(request, pid):
-        return {}
-
-    from django.views.decorators.csrf import csrf_exempt
-    @csrf_exempt
-    @_template_renderer('landing_not_managed.html')
-    def xhr_datatypeahead(request, pid):
-        return {}
-
-
-    @_template_renderer('landing_not_managed.html')
-    def xhr_configvaredit(request, pid):
-        return {}
-
-    @_template_renderer('landing_not_managed.html')
-    def importlayer(request):
-        return {}
-
-    @_template_renderer('landing_not_managed.html')
-    def projectconf(request, pid):
-        return {}
-
-    @_template_renderer('landing_not_managed.html')
-    def projectbuilds(request, pid):
-        return {}
-
-    @_template_renderer('landing_not_managed.html')
-    def build_artifact(request, build_id, artifact_type, artifact_id):
-        return {}
-
-    @_template_renderer('landing_not_managed.html')
-    def projects(request):
-        return {}
-
-    @_template_renderer('landing_not_managed.html')
-    def xhr_importlayer(request):
-        return {}
-
-    @_template_renderer('landing_not_managed.html')
-    def xhr_updatelayer(request):
-        return {}
-
-    @_template_renderer('landing_not_managed.html')
-    def buildrequestdetails(request, pid, brid):
-        return {}
-- 
1.9.1


