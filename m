Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f171.google.com (mail-we0-f171.google.com
	[74.125.82.171])
	by mail.openembedded.org (Postfix) with ESMTP id 3871D7377A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 21:42:25 +0000 (UTC)
Received: by wevm14 with SMTP id m14so15012724wev.13
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 13:42:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=scRE4NMlTYyUH6JnyZ2ebPUuojatcgNPb/cIEq4nGL8=;
	b=Bvsj3eZoTO9TP37KgBF/VGHGtduMJlOj5aCiSSGGy2pWXfnaQFfxgDTCe18VuXh88t
	o90ucwMEhQatQpW1XfS8QtMTNpNOozgMWwRWwbod84m32S4EOE86LQoMc2f8mz7FrXqe
	R610CcZg7jmoccZZRiuVU6TCD4eSDrL+quQWbcSS/KMvmDd865shVI4xvuRnpUUTraO9
	sIJvVcAaLfyNwzwT/zlBHfZMP7KODIzW9+1CNn8OHXzIS9jUE+VNSG2U/rg93B7/wYyr
	xuuQhsTpCtr6QBaazYFWH5lQkcM3Qy46F8l+mXFXL7PfcJV1HV/HitpY5R8RIl4sj/9M
	LaUA==
X-Gm-Message-State: ALoCoQkqnQauS3fSW2ZwD5W6aVchFdbbGZ7YStpAV4agri4e0SOdgG0e5qIfnXVhNFNMZBwBR7Uv
X-Received: by 10.194.6.228 with SMTP id e4mr20687217wja.63.1424986946739;
	Thu, 26 Feb 2015 13:42:26 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id hi6sm3148084wjc.34.2015.02.26.13.42.24
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 26 Feb 2015 13:42:24 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id C65B1561783; Thu, 26 Feb 2015 21:42:02 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Feb 2015 21:42:00 +0000
Message-Id: <2c4bf423c8cb01f5b361bcd6abb0938be8835800.1424986746.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <21cb6ea0acdaec4a3aa133790a17c7055b9a1348.1424986746.git.alexandru.damian@intel.com>
References: <21cb6ea0acdaec4a3aa133790a17c7055b9a1348.1424986746.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424986746.git.alexandru.damian@intel.com>
References: <cover.1424986746.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 7/8] toaster: all projects data and sorts
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
X-List-Received-Date: Thu, 26 Feb 2015 21:42:26 -0000

From: David Reyna <David.Reyna@windriver.com>

Implement the 'last build' data methods, enhance variable display,
add empty page and empty sort support.

[YOCTO #6682]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/bldcontrol/models.py                   |  2 +-
 lib/toaster/orm/models.py                          | 63 ++++++++++++++
 .../toastergui/templates/managed_builds.html       | 22 ++---
 lib/toaster/toastergui/templates/projects.html     | 60 ++++++++++---
 lib/toaster/toastergui/views.py                    | 97 +++++++++++++++-------
 5 files changed, 190 insertions(+), 54 deletions(-)

diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index 25d94cd..02cfaf7 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -106,7 +106,7 @@ class BuildRequest(models.Model):
         (REQ_ARCHIVE, "archive"),
     )
 
-    search_allowed_fields = ("brtarget__target",)
+    search_allowed_fields = ("brtarget__target", "build__project__name")
 
     project     = models.ForeignKey(Project)
     build       = models.OneToOneField(Build, null = True)     # TODO: toasterui should set this when Build is created
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 4fa9f81..90e11d2 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -102,6 +102,69 @@ class Project(models.Model):
     def __unicode__(self):
         return "%s (%s, %s)" % (self.name, self.release, self.bitbake_version)
 
+    def get_current_machine_name(self):
+        try:
+            return self.projectvariable_set.get(name="MACHINE").value
+        except (ProjectVariable.DoesNotExist,IndexError):
+            return( "None" );
+
+    def get_number_of_builds(self):
+        try:
+            return len(Build.objects.filter( project = self.id ))
+        except (Build.DoesNotExist,IndexError):
+            return( 0 )
+
+    def get_last_build_id(self):
+        try:
+            return Build.objects.filter( project = self.id ).order_by('-completed_on')[0].id
+        except (Build.DoesNotExist,IndexError):
+            return( -1 )
+
+    def get_last_outcome(self):
+        build_id = self.get_last_build_id
+        if (-1 == build_id):
+            return( "" )
+        try:
+            return Build.objects.filter( id = self.get_last_build_id )[ 0 ].outcome
+        except (Build.DoesNotExist,IndexError):
+            return( "not_found" )
+
+    def get_last_target(self):
+        build_id = self.get_last_build_id
+        if (-1 == build_id):
+            return( "" )
+        try:
+            return Target.objects.filter(build = build_id)[0].target
+        except (Target.DoesNotExist,IndexError):
+            return( "not_found" )
+
+    def get_last_errors(self):
+        build_id = self.get_last_build_id
+        if (-1 == build_id):
+            return( 0 )
+        try:
+            return Build.objects.filter(id = build_id)[ 0 ].errors_no
+        except (Build.DoesNotExist,IndexError):
+            return( "not_found" )
+
+    def get_last_warnings(self):
+        build_id = self.get_last_build_id
+        if (-1 == build_id):
+            return( 0 )
+        try:
+            return Build.objects.filter(id = build_id)[ 0 ].warnings_no
+        except (Build.DoesNotExist,IndexError):
+            return( "not_found" )
+
+    def get_last_imgfiles(self):
+        build_id = self.get_last_build_id
+        if (-1 == build_id):
+            return( "" )
+        try:
+            return Variable.objects.filter(build = build_id, variable_name = "IMAGE_FSTYPES")[ 0 ].variable_value
+        except (Variable.DoesNotExist,IndexError):
+            return( "not_found" )
+
     # returns a queryset of compatible layers for a project
     def compatible_layerversions(self, release = None, layer_name = None):
         if release == None:
diff --git a/lib/toaster/toastergui/templates/managed_builds.html b/lib/toaster/toastergui/templates/managed_builds.html
index a4db55b..e23b832 100644
--- a/lib/toaster/toastergui/templates/managed_builds.html
+++ b/lib/toaster/toastergui/templates/managed_builds.html
@@ -56,6 +56,13 @@
             </td>
             <td class="target">{% for t in build.target_set.all %} <a href="{% url "builddashboard" build.id %}"> {{t.target}} </a> <br />{% endfor %}</td>
             <td class="machine"><a href="{% url "builddashboard" build.id %}">{{build.machine}}</a></td>
+   {% if MANAGED %}
+            <td class="project">
+            {% if build.project %}
+                <a href="{% url 'project' build.project.id %}">{{build.project.name}}</a>
+            {% endif %}
+            </td>
+   {% endif %}
             <td class="started_on"><a href="{% url "builddashboard" build.id %}">{{build.started_on|date:"d/m/y H:i"}}</a></td>
             <td class="completed_on"><a href="{% url "builddashboard" build.id %}">{{build.completed_on|date:"d/m/y H:i"}}</a></td>
             <td class="failed_tasks error">
@@ -91,13 +98,6 @@
               <a href="{%url "builddashboard" build.id%}#images">{{fstypes|get_dict_value:build.id}}</a>
               {% endif %}
             </td>
-   {% if MANAGED %}
-            <td class="project">
-            {% if build.project %}
-                <a href="{% url 'project' build.project.id %}">{{build.project.name}}</a>
-            {% endif %}
-            </td>
-   {% endif %}
         </tr>
 
 
@@ -114,6 +114,11 @@
             <td class="machine">
                 <a href="{% url "buildrequestdetails" buildrequest.project.id buildrequest.id %}">{{buildrequest.machine}}</a>
             </td>
+   {% if MANAGED %}
+            <td class="project">
+                <a href="{% url 'project' buildrequest.project.id %}">{{buildrequest.project.name}}</a>
+            </td>
+   {% endif %}
             <td class="started_on">
                 <a href="{% url "buildrequestdetails" buildrequest.project.id buildrequest.id %}">{{buildrequest.created|date:"d/m/y H:i"}}</a>
             </td>
@@ -132,9 +137,6 @@
             </td>
             <td class="output"> {# we have no output here #}
             </td>
-            <td class="project">
-                <a href="{% url 'project' buildrequest.project.id %}">{{buildrequest.project.name}}</a>
-            </td>
         </tr>
           {%endif%}
         {% endfor %}
diff --git a/lib/toaster/toastergui/templates/projects.html b/lib/toaster/toastergui/templates/projects.html
index 0396e25..88d5bd3 100644
--- a/lib/toaster/toastergui/templates/projects.html
+++ b/lib/toaster/toastergui/templates/projects.html
@@ -12,25 +12,61 @@
 
   <div class="page-header top-air">
       <h1>
-         All projects
+      {% if request.GET.filter and objects.paginator.count > 0 or request.GET.search and objects.paginator.count > 0 %}
+          {{objects.paginator.count}} project{{objects.paginator.count|pluralize}} found
+      {%elif request.GET.filter and objects.paginator.count == 0 or request.GET.search and objects.paginator.count == 0 %}
+          No projects found
+      {%else%}
+          All projects
+      {%endif%}
        </h1>
   </div>
 
-{% include "basetable_top_projectbuilds.html" %}
+  {% if objects.paginator.count == 0 %}
+    <div class="row-fluid">
+      <div class="alert">
+        <form class="no-results input-append" id="searchform">
+            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
+            <button class="btn" type="submit" value="Search">Search</button>
+            <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all projects</button>
+        </form>
+      </div>
+    </div>
+
+  {% else %} {# We have builds to display #}
+  {% include "basetable_top_projectbuilds.html" %}
   {% for o in objects %}
     <tr class="data">
       <td><a href="{% url 'project' o.id %}">{{o.name}}</a></td>
-      <td><a href="{% url 'project' o.id %}">{{o.release.name}}</a></td>
-      <td>{{o.get_current_machine_name}}</td>
-      <td>{{o.get_number_of_builds}}</td>
-      <td class="loutcome">{{o.get_last_outcome}}</td>
-      <td class="ltarget">{{o.get_last_target}}</td>
-      <td class="lerrors">{{o.get_last_errors}}</td>
-      <td class="lwarnings">{{o.get_last_warnings}}</td>
-      <td class="limagefiles">{{o.get_last_imgfiles}}</td>
-      <td class="updated">{{o.updated|date:"d/m/y H:i"}}</td>
+      <td><a href="{% url 'project' o.id %}#project-details">{{o.release.name}}</a></td>
+      <td><a href="{% url 'project' o.id %}#machine-distro">{{o.get_current_machine_name}}</a></td>
+      {% if o.get_number_of_builds == 0 %}
+      <td class="muted">{{o.get_number_of_builds}}</td>
+      <td class="updated"></td>
+      <td class="loutcome"></td>
+      <td class="ltarget"></td>
+      <td class="lerrors"></td>
+      <td class="lwarnings"></td>
+      <td class="limagefiles"></td>
+      {% else %}
+      <td><a href="{% url 'projectbuilds' o.id %}">{{o.get_number_of_builds}}</a></td>
+      <td class="updated"><a href="{% url "builddashboard" o.get_last_build_id %}">{{o.updated|date:"d/m/y H:i"}}</a></td>
+      <td class="loutcome"><a href="{% url "builddashboard" o.get_last_build_id %}">{%if o.get_last_outcome == build_SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif o.get_last_outcome == build_FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a></td>
+      <td class="ltarget"><a href="{% url "builddashboard" o.get_last_build_id %}">{{o.get_last_target}} </a></td>
+	  <td class="lerrors">{% if o.get_last_errors %}<a class="errors_no error" href="{% url "builddashboard" o.get_last_build_id %}#errors">{{o.get_last_errors}} error{{o.get_last_errors|pluralize}}</a>{%endif%}</td>
+	  <td class="lwarnings">{% if o.get_last_warnings %}<a class="warnings_no warning" href="{% url "builddashboard" o.get_last_build_id %}#warnings">{{o.get_last_warnings}} warning{{o.get_last_warnings|pluralize}}</a>{%endif%}</td>
+      <td class="limagefiles">
+	    {% if o.get_last_outcome == build_SUCCEEDED %}
+	    <a href="{%url "builddashboard" o.get_last_build_id %}#images">{{fstypes|get_dict_value:o.id}}</a>
+	    {% endif %}
+	  </td>
+
+      {% endif %}
     </tr>
   {% endfor %}
-{% include "basetable_bottom.html" %}
+  {% include "basetable_bottom.html" %}
+  {% endif %} {# empty #}
 
 {% endblock %}
+
+
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index a206f80..4f4ae67 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1758,20 +1758,10 @@ if toastermain.settings.MANAGED:
         buildrequests = BuildRequest.objects.exclude(state__lte = BuildRequest.REQ_INPROGRESS).exclude(state=BuildRequest.REQ_DELETED)
 
         try:
-            context, pagesize, orderby = _build_list_helper(request, buildrequests)
+            context, pagesize, orderby = _build_list_helper(request, buildrequests, True)
         except InvalidRequestException as e:
             return _redirect_parameters( builds, request.GET, e.response)
 
-        context['tablecols'].append(
-                    {'name': 'Project', 'clclass': 'projectx',
-                     'filter': {'class': 'project',
-                            'label': 'Project:',
-                            'options':  map(lambda x: (x.name,'project:%d' % x.id,x.build_set.filter(outcome__lt=BuildRequest.REQ_INPROGRESS).count()), Project.objects.all()),
-
-                           }
-                    }
-            )
-
         response = render(request, template, context)
         _save_parameters_cookies(response, pagesize, orderby, request)
         return response
@@ -1779,7 +1769,7 @@ if toastermain.settings.MANAGED:
 
 
     # helper function, to be used on "all builds" and "project builds" pages
-    def _build_list_helper(request, buildrequests):
+    def _build_list_helper(request, buildrequests, insert_projects):
         # ATTN: we use here the ordering parameters for interactive mode; the translation for BuildRequest fields will happen below
         default_orderby = 'completed_on:-'
         (pagesize, orderby) = _get_parameters_values(request, 10, default_orderby)
@@ -1893,6 +1883,16 @@ if toastermain.settings.MANAGED:
                      'ordericon':_get_toggle_order_icon(request, "build__machine"),
                      'dclass': 'span3'
                     },                           # a slightly wider column
+                    ]
+                }
+
+        if (insert_projects):
+            context['tablecols'].append(
+                    {'name': 'Project', 'clclass': 'project',
+                    }
+            )
+
+        context['tablecols'].append(
                     {'name': 'Started on', 'clclass': 'started_on', 'hidden' : 1,      # this is an unchecked box, which hides the column
                      'qhelp': "The date and time you started the build",
                      'orderfield': _get_toggle_order(request, "created", True),
@@ -1905,7 +1905,9 @@ if toastermain.settings.MANAGED:
                                              ("This week's builds", 'created__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_all.filter(created__gte=(timezone.now()-timedelta(days=7))).count()),
                                              ]
                                 }
-                    },
+                    }
+            )
+        context['tablecols'].append(
                     {'name': 'Completed on',
                      'qhelp': "The date and time the build finished",
                      'orderfield': _get_toggle_order(request, "updated", True),
@@ -1919,7 +1921,9 @@ if toastermain.settings.MANAGED:
                                              ("This week's builds", 'updated__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_all.filter(updated__gte=(timezone.now()-timedelta(days=7))).count()),
                                              ]
                                 }
-                    },
+                    }
+            )
+        context['tablecols'].append(
                     {'name': 'Failed tasks', 'clclass': 'failed_tasks',                # specifing a clclass will enable the checkbox
                      'qhelp': "How many tasks failed during the build",
                      'filter' : {'class' : 'failed_tasks',
@@ -1931,7 +1935,9 @@ if toastermain.settings.MANAGED:
                                                 queryset_all.filter(~Q(build__task_build__outcome=Task.OUTCOME_FAILED)).count()),
                                              ]
                                 }
-                    },
+                    }
+            )
+        context['tablecols'].append(
                     {'name': 'Errors', 'clclass': 'errors_no',
                      'qhelp': "How many errors were encountered during the build (if any)",
                      'orderfield': _get_toggle_order(request, "build__errors_no", True),
@@ -1946,7 +1952,9 @@ if toastermain.settings.MANAGED:
                                                 queryset_all.filter(build__errors_no=0).count()),
                                              ]
                                 }
-                    },
+                    }
+            )
+        context['tablecols'].append(
                     {'name': 'Warnings', 'clclass': 'warnings_no',
                      'qhelp': "How many warnings were encountered during the build (if any)",
                      'orderfield': _get_toggle_order(request, "build__warnings_no", True),
@@ -1959,19 +1967,23 @@ if toastermain.settings.MANAGED:
                                              ('Builds without warnings','build__warnings_no:0', queryset_all.filter(build__warnings_no=0).count()),
                                              ]
                                 }
-                    },
+                    }
+            )
+        context['tablecols'].append(
                     {'name': 'Time', 'clclass': 'time', 'hidden' : 1,
                      'qhelp': "How long it took the build to finish",
-#                     'orderfield': _get_toggle_order(request, "timespent", True),
-#                     'ordericon':_get_toggle_order_icon(request, "timespent"),
+#                    'orderfield': _get_toggle_order(request, "timespent", True),
+#                    'ordericon':_get_toggle_order_icon(request, "timespent"),
                      'orderkey' : 'timespent',
-                    },
+                    }
+            )
+        context['tablecols'].append(
                     {'name': 'Image files', 'clclass': 'output',
                      'qhelp': "The root file system types produced by the build. You can find them in your <code>/build/tmp/deploy/images/</code> directory",
                         # TODO: compute image fstypes from Target_Image_File
-                    },
-                    ]
-                }
+                    }
+            )
+
         return context, pagesize, orderby
 
     # new project
@@ -2898,7 +2910,7 @@ if toastermain.settings.MANAGED:
         buildrequests = BuildRequest.objects.filter(project_id = pid).exclude(state__lte = BuildRequest.REQ_INPROGRESS).exclude(state=BuildRequest.REQ_DELETED)
 
         try:
-            context, pagesize, orderby = _build_list_helper(request, buildrequests)
+            context, pagesize, orderby = _build_list_helper(request, buildrequests, False)
         except InvalidRequestException as e:
             return _redirect_parameters(projectbuilds, request.GET, e.response, pid = pid)
 
@@ -3019,7 +3031,7 @@ if toastermain.settings.MANAGED:
     def projects(request):
         template="projects.html"
 
-        (pagesize, orderby) = _get_parameters_values(request, 10, 'updated:+')
+        (pagesize, orderby) = _get_parameters_values(request, 10, 'updated:-')
         mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
         retval = _verify_parameters( request.GET, mandatory_parameters )
         if retval:
@@ -3039,7 +3051,27 @@ if toastermain.settings.MANAGED:
         # build view-specific information; this is rendered specifically in the builds page, at the top of the page (i.e. Recent builds)
         build_mru = Build.objects.order_by("-started_on")[:3]
 
-
+        # translate the project's build target strings
+        fstypes_map = {};
+        for project in project_info:
+            try:
+                targets = Target.objects.filter( build_id = project.get_last_build_id() )
+                comma = "";
+                extensions = "";
+                for t in targets:
+                    if ( not t.is_image ):
+                        continue
+                    tif = Target_Image_File.objects.filter( target_id = t.id )
+                    for i in tif:
+                        s=re.sub('.*tar.bz2', 'tar.bz2', i.file_name)
+                        if s == i.file_name:
+                            s=re.sub('.*\.', '', i.file_name)
+                        if None == re.search(s,extensions):
+                            extensions += comma + s
+                            comma = ", "
+                fstypes_map[project.id]=extensions
+            except (Target.DoesNotExist,IndexError):
+                fstypes_map[project.id]=project.get_last_imgfiles
 
         context = {
                 'mru' : build_mru,
@@ -3049,6 +3081,9 @@ if toastermain.settings.MANAGED:
                 'default_orderby' : 'id:-',
                 'search_term' : search_term,
                 'total_count' : queryset_with_search.count(),
+                'fstypes' : fstypes_map,
+                'build_FAILED' : Build.FAILED,
+                'build_SUCCEEDED' : Build.SUCCEEDED,
                 'tablecols': [
                     {'name': 'Project',
                     'orderfield': _get_toggle_order(request, "name"),
@@ -3067,6 +3102,11 @@ if toastermain.settings.MANAGED:
                     {'name': 'Number of builds',
                     'qhelp': "How many builds have been run for the project",
                     },
+                    {'name': 'Last build', 'clclass': 'updated',
+                    'orderfield': _get_toggle_order(request, "updated", True),
+                    'ordericon':_get_toggle_order_icon(request, "updated"),
+                    'orderkey' : 'updated',
+                    },
                     {'name': 'Last outcome', 'clclass': 'loutcome',
                     'qhelp': "Tells you if the last project build completed successfully or failed",
                     },
@@ -3082,11 +3122,6 @@ if toastermain.settings.MANAGED:
                     {'name': 'Last image files', 'clclass': 'limagefiles', 'hidden': 1,
                     'qhelp': "The root file system types produced by the last project build",
                     },
-                    {'name': 'Last updated', 'clclass': 'updated',
-                    'orderfield': _get_toggle_order(request, "updated"),
-                    'ordericon':_get_toggle_order_icon(request, "updated"),
-                    'orderkey' : 'updated',
-                    }
                     ]
             }
         return render(request, template, context)
-- 
1.9.1


