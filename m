Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
	[74.125.82.170])
	by mail.openembedded.org (Postfix) with ESMTP id C0AA972C08
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Jan 2015 16:42:45 +0000 (UTC)
Received: by mail-we0-f170.google.com with SMTP id w61so21261374wes.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Jan 2015 08:42:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=hQjBx9CpZ8xMAqmVBE+EgexsZsVlPPVACEdz7xtTAtE=;
	b=RJLh+H1YM1+VuiVwOiH5ZD37EmSCN/IgWxkXw6RuMsWGEjrwQ8CCVdQ7yH+hBGldj7
	2z6Dh3hymz/n5cPUzUjxzPui8q8WmRjZ2MCV3X7wCtAMyGIVlJJoe+dGEnoPb/4pvZDZ
	9jisC8RSEfVQ0hTupC/mZxts603LqazBEQ0KCPBOS+W6JVjvCy/Fy/GFCbN8EJa3HPCD
	wPmKfijWV1dJDNavgsZtAQbOKwr5yrdhsj8LVmo6JwLE/5asYshyBKpXGHlKklfVtLbi
	yZ0O7C+sIuarKQxx/XB4zPRBZg5/mpMGyMTjY5RTdh9Ah30iUHFJpAJVYr6mcB6+vG0x
	Vq/Q==
X-Gm-Message-State: ALoCoQljpqbul3RTjHsgtKrRFwzjYxz7emLf5oFfvuaxvgWpVjNFqzd+aQUFlP2LmpQo5R6SXDaX
X-Received: by 10.180.19.138 with SMTP id f10mr7936233wie.56.1421426562412;
	Fri, 16 Jan 2015 08:42:42 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id jp3sm3663091wid.9.2015.01.16.08.42.40
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 16 Jan 2015 08:42:41 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id C34B3560DB7; Fri, 16 Jan 2015 16:42:41 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Jan 2015 16:42:40 +0000
Message-Id: <2b40432da9df3a1b35a4ddb5500c8bcaeb0c2285.1421426452.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1421426452.git.alexandru.damian@intel.com>
References: <cover.1421426452.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/2] toaster: project builds page
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
X-List-Received-Date: Fri, 16 Jan 2015 16:42:48 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This is a complete re-write of the "Project builds" page
based on the "All builds" page in managed mode.

[YOCTO #6589]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldcontrol/models.py                   |   2 +
 .../toastergui/templates/projectbuilds.html        | 118 +++++++--
 lib/toaster/toastergui/views.py                    | 270 +++++----------------
 3 files changed, 160 insertions(+), 230 deletions(-)

diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index cab4463..2386d23 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -104,6 +104,8 @@ class BuildRequest(models.Model):
         (REQ_DELETED, "deleted"),
     )
 
+    search_allowed_fields = ("brtarget__target",)
+
     project     = models.ForeignKey(Project)
     build       = models.OneToOneField(Build, null = True)     # TODO: toasterui should set this when Build is created
     environment = models.ForeignKey(BuildEnvironment, null = True)
diff --git a/lib/toaster/toastergui/templates/projectbuilds.html b/lib/toaster/toastergui/templates/projectbuilds.html
index 8c5942c..8f9172c 100644
--- a/lib/toaster/toastergui/templates/projectbuilds.html
+++ b/lib/toaster/toastergui/templates/projectbuilds.html
@@ -9,40 +9,72 @@
 {% block projectinfomain %}
                 <div class="page-header">
                     <h1>
-                        All builds
-                        <i class="icon-question-sign get-help heading-help" title="This page lists all the layers compatible with Yocto Project 1.7 'Dxxxx' that Toaster knows about. They include community-created layers suitable for use on top of OpenEmbedded Core and any layers you have imported"></i>
-                     </h1>
-                </div>
-                <!--div class="alert">
-                    <div class="input-append" style="margin-bottom:0px;">
-                        <input class="input-xxlarge" type="text" placeholder="Search layers" value="browser" />
-                        <a class="add-on btn">
-                            <i class="icon-remove"></i>
-                        </a>
-                        <button class="btn" type="button">Search</button>
-                        <a class="btn btn-link" href="#">Show all layers</a>
-                    </div>
-                </div-->
-                <div id="layer-added" class="alert alert-info lead" style="display:none;"></div>
-                <div id="layer-removed" class="alert alert-info lead" style="display:none;">
-                    <button type="button" class="close" data-dismiss="alert">&times;</button>
-                    <strong>1</strong> layer deleted from <a href="project-with-targets.html">your project</a>: <a href="#">meta-aarch64</a>
+ {% if objects.paginator.count == 0 %}
+                     No builds found
+
+ {% else %}
+	{% if  request.GET.filter or request.GET.search  %}
+			{{objects.paginator.count}} builds found
+	{% else %}
+                        Project builds <small>({{objects.paginator.count}})</small>
+	{% endif %}
+ {% endif %}
+                        <i class="icon-question-sign get-help heading-help" title="This page lists all the builds for the current project"></i>
+                    </h1>
                 </div>
 
 
-{% include "basetable_top.html" %}
-    {% for build in objects %}
+ {% if objects.paginator.count == 0 %}
+    <div class="row-fluid">
+      <div class="alert">
+        <form class="no-results input-append" id="searchform">
+            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
+            <button class="btn" type="submit" value="Search">Search</button>
+            <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all builds</button>
+        </form>
+      </div>
+    </div>
+
+
+ {% else %}
+
+  {% include "basetable_top.html" %}
+        <!-- Table data rows; the order needs to match the order of "tablecols" definitions; and the <td class value needs to match the tablecols clclass value for show/hide buttons to work -->
+        {% for br in objects %}{% if br.build %}  {% with build=br.build %} {# if we have a build, just display it #}
         <tr class="data">
             <td class="outcome"><a href="{% url "builddashboard" build.id %}">{%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a></td>
             <td class="target">{% for t in build.target_set.all %} <a href="{% url "builddashboard" build.id %}"> {{t.target}} </a> <br />{% endfor %}</td>
             <td class="machine"><a href="{% url "builddashboard" build.id %}">{{build.machine}}</a></td>
             <td class="started_on"><a href="{% url "builddashboard" build.id %}">{{build.started_on|date:"d/m/y H:i"}}</a></td>
             <td class="completed_on"><a href="{% url "builddashboard" build.id %}">{{build.completed_on|date:"d/m/y H:i"}}</a></td>
-            <td class="failed_tasks error">{% query build.task_build outcome=4 order__gt=0 as exectask%}{% if exectask.count == 1 %}<a href="{% url "task" build.id exectask.0.id %}">{{exectask.0.recipe.name}}.{{exectask.0.task_name}}</a>{% elif exectask.count > 1%}<a href="{% url "tasks" build.id %}?filter=outcome%3A4">{{exectask.count}}</a>{%endif%}</td>
-            <td class="errors_no">{% if  build.errors_no %}<a class="errors_no error" href="{% url "builddashboard" build.id %}#errors">{{build.errors_no}} error{{build.errors_no|pluralize}}</a>{%endif%}</td>
+            <td class="failed_tasks error">
+                {% query build.task_build outcome=4 order__gt=0 as exectask%}
+                    {% if exectask.count == 1 %}
+                        <a href="{% url "task" build.id exectask.0.id %}">{{exectask.0.recipe.name}}.{{exectask.0.task_name}}</a>
+                      {% if MANAGED and build.project %}
+                        <a href="{% url 'build_artifact' build.id "tasklogfile" exectask.0.id %}">
+                            <i class="icon-download-alt" title="" data-original-title="Download task log file"></i>
+                        </a>
+                      {% endif %}
+                    {% elif exectask.count > 1%}
+                        <a href="{% url "tasks" build.id %}?filter=outcome%3A4">{{exectask.count}} task{{exectask.count|pluralize}}</a>
+                    {%endif%}
+            </td>
+            <td class="errors_no">
+                {% if  build.errors_no %}
+                    <a class="errors_no error" href="{% url "builddashboard" build.id %}#errors">{{build.errors_no}} error{{build.errors_no|pluralize}}</a>
+                    {% if MANAGED and build.project %}
+                        <a href="{% url 'build_artifact' build.id "cookerlog" build.id %}">
+                            <i class="icon-download-alt" title="" data-original-title="Download build log"></i>
+                        </a>
+                    {% endif %}
+                {%endif%}
+            </td>
             <td class="warnings_no">{% if  build.warnings_no %}<a class="warnings_no warning" href="{% url "builddashboard" build.id %}#warnings">{{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a>{%endif%}</td>
             <td class="time"><a href="{% url "buildtime" build.id %}">{{build.timespent|sectohms}}</a></td>
-            <td class="log">{{build.cooker_log_path}}</td>
+            {% if not MANAGED or not build.project %}
+                <td class="log">{{build.cooker_log_path}}</td>
+            {% endif %}
             <td class="output">
               {% if build.outcome == build.SUCCEEDED %}
               <a href="{%url "builddashboard" build.id%}#images">{{fstypes|get_dict_value:build.id}}</a>
@@ -50,10 +82,44 @@
             </td>
         </tr>
 
-    {% endfor %}
-{% include "basetable_bottom.html" %}
 
-    <!-- Modals -->
+              {%endwith%}
+      {% else %} {# we don't have a build for this build request, mask the data with build request data #}
+
+
+
+        <tr class="data">
+            <td class="outcome">{% if buildrequest.state == buildrequest.REQ_FAILED %}<i class="icon-minus-sign error"></i>{%else%}FIXME_build_request_state{%endif%}</td>
+            <td class="target">
+                <span data-toggle="tooltip" {%if br.brtarget_set.all.count > 1%}title="Targets: {%for target in br.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{br.brtarget_set.all.0.target}} {%if br.brtarget_set.all.count > 1%}(+ {{br.brtarget_set.all.count|add:"-1"}}){%endif%} </span>
+            </td>
+            <td class="machine">
+                {{br.machine}}
+            </td>
+            <td class="started_on">
+                {{br.created|date:"d/m/y H:i"}}
+            </td>
+            <td class="completed_on">
+                {{br.updated|date:"d/m/y H:i"}}
+            </td>
+            <td class="failed_tasks error">
+                {{br.brerror_set.all.0.errmsg|whitespace_slice:":32"}}
+            </td>
+            <td class="errors_no">
+            </td>
+            <td class="warnings_no">
+            </td>
+            <td class="time">
+                {{br.timespent.total_seconds|sectohms}}
+            </td>
+            <td class="output"> {# we have no output here #}
+            </td>
+        </tr>
+          {%endif%}
+        {% endfor %}
+
 
+  {% include "basetable_bottom.html" %}
+{% endif %}
 
 {% endblock %}
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index e8e4927..4fae70b 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1705,6 +1705,11 @@ if toastermain.settings.MANAGED:
         return ret
 
 
+    class InvalidRequestException(Exception):
+        def __init__(self, response):
+            self.response = response
+
+
     # shows the "all builds" page for managed mode; it displays build requests (at least started!) instead of actual builds
     def builds(request):
         template = 'managed_builds.html'
@@ -1712,19 +1717,53 @@ if toastermain.settings.MANAGED:
         # be able to display something.  'count' and 'page' are mandatory for all views
         # that use paginators.
 
+        buildrequests = BuildRequest.objects.exclude(state__lte = BuildRequest.REQ_INPROGRESS).exclude(state=BuildRequest.REQ_DELETED)
+
+        try:
+            context, pagesize, orderby = _build_list_helper(request, buildrequests)
+        except InvalidRequestException as e:
+            return _redirect_parameters( builds, request.GET, e.response)
+
+        context['tablecols'].append(
+                    {'name': 'Project', 'clclass': 'project',
+                     'filter': {'class': 'project',
+                            'label': 'Project:',
+                            'options':  map(lambda x: (x.name,'',x.build_set.filter(outcome__lt=BuildRequest.REQ_INPROGRESS).count()), Project.objects.all()),
+
+                           }
+                    }
+            )
+
+        response = render(request, template, context)
+        _save_parameters_cookies(response, pagesize, orderby, request)
+        return response
+
+
+
+    # helper function, to be used on "all builds" and "project builds" pages
+    def _build_list_helper(request, buildrequests):
         # ATTN: we use here the ordering parameters for interactive mode; the translation for BuildRequest fields will happen below
         (pagesize, orderby) = _get_parameters_values(request, 10, 'completed_on:-')
         mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
         retval = _verify_parameters( request.GET, mandatory_parameters )
         if retval:
-            return _redirect_parameters( 'all-builds', request.GET, mandatory_parameters)
+            raise InvalidRequestException(mandatory_parameters)
 
+        orig_orderby = orderby
         # translate interactive mode ordering to managed mode ordering
         ordering_params = orderby.split(":")
         if ordering_params[0] == "completed_on":
             ordering_params[0] = "updated"
         if ordering_params[0] == "started_on":
-            ordering_params = "created"
+            ordering_params[0] = "created"
+        if ordering_params[0] == "errors_no":
+            ordering_params[0] = "build__errors_no"
+        if ordering_params[0] == "warnings_no":
+            ordering_params[0] = "build__warnings_no"
+        if ordering_params[0] == "machine":
+            ordering_params[0] = "build__machine"
+        if ordering_params[0] == "target__target":
+            ordering_params[0] = "brtarget__target"
 
         request.GET = request.GET.copy()        # get a mutable copy of the GET QueryDict
         request.GET['orderby'] = ":".join(ordering_params)
@@ -1733,7 +1772,7 @@ if toastermain.settings.MANAGED:
         # for that object type. copypasta for all needed table searches
         (filter_string, search_term, ordering_string) = _search_tuple(request, BuildRequest)
         # we don't display in-progress or deleted builds
-        queryset_all = BuildRequest.objects.exclude(state__lte = BuildRequest.REQ_INPROGRESS).exclude(state=BuildRequest.REQ_DELETED)
+        queryset_all = buildrequests
         queryset_with_search = _get_queryset(BuildRequest, queryset_all, None, search_term, ordering_string, '-updated')
         queryset = _get_queryset(BuildRequest, queryset_all, filter_string, search_term, ordering_string, '-updated')
 
@@ -1802,13 +1841,13 @@ if toastermain.settings.MANAGED:
                     },
                     {'name': 'Target',                                                 # default column, disabled box, with just the name in the list
                      'qhelp': "This is the build target or build targets (i.e. one or more recipes or image recipes)",
-                     'orderfield': _get_toggle_order(request, "target__target"),
-                     'ordericon':_get_toggle_order_icon(request, "target__target"),
+                     'orderfield': _get_toggle_order(request, "brtarget__target"),
+                     'ordericon':_get_toggle_order_icon(request, "brtarget__target"),
                     },
                     {'name': 'Machine',
                      'qhelp': "The machine is the hardware for which you are building a recipe or image recipe",
-                     'orderfield': _get_toggle_order(request, "machine"),
-                     'ordericon':_get_toggle_order_icon(request, "machine"),
+                     'orderfield': _get_toggle_order(request, "build__machine"),
+                     'ordericon':_get_toggle_order_icon(request, "build__machine"),
                      'dclass': 'span3'
                     },                           # a slightly wider column
                     {'name': 'Started on', 'clclass': 'started_on', 'hidden' : 1,      # this is an unchecked box, which hides the column
@@ -1843,21 +1882,21 @@ if toastermain.settings.MANAGED:
                      'filter' : {'class' : 'failed_tasks',
                                  'label': 'Show:',
                                  'options' : [
-                                             ('BuildRequests with failed tasks', 'build__task_build__outcome:4', queryset_with_search.filter(build__task_build__outcome=4).count()),
-                                             ('BuildRequests without failed tasks', 'build__task_build__outcome:NOT4', queryset_with_search.filter(~Q(build__task_build__outcome=4)).count()),
+                                             ('Build with failed tasks', 'build__task_build__outcome:4', queryset_with_search.filter(build__task_build__outcome=4).count()),
+                                             ('Build without failed tasks', 'build__task_build__outcome:NOT4', queryset_with_search.filter(~Q(build__task_build__outcome=4)).count()),
                                              ]
                                 }
                     },
                     {'name': 'Errors', 'clclass': 'errors_no',
                      'qhelp': "How many errors were encountered during the build (if any)",
-                     'orderfield': _get_toggle_order(request, "errors_no", True),
-                     'ordericon':_get_toggle_order_icon(request, "errors_no"),
+                     'orderfield': _get_toggle_order(request, "build__errors_no", True),
+                     'ordericon':_get_toggle_order_icon(request, "build__errors_no"),
                      'orderkey' : 'errors_no',
                      'filter' : {'class' : 'errors_no',
                                  'label': 'Show:',
                                  'options' : [
-                                             ('BuildRequests with errors', 'errors_no__gte:1', queryset_with_search.filter(build__errors_no__gte=1).count()),
-                                             ('BuildRequests without errors', 'errors_no:0', queryset_with_search.filter(build__errors_no=0).count()),
+                                             ('Build with errors', 'build__errors_no__gte:1', queryset_with_search.filter(build__errors_no__gte=1).count()),
+                                             ('Build without errors', 'build__errors_no:0', queryset_with_search.filter(build__errors_no=0).count()),
                                              ]
                                 }
                     },
@@ -1869,15 +1908,15 @@ if toastermain.settings.MANAGED:
                      'filter' : {'class' : 'build__warnings_no',
                                  'label': 'Show:',
                                  'options' : [
-                                             ('BuildRequests with warnings','build__warnings_no__gte:1', queryset_with_search.filter(build__warnings_no__gte=1).count()),
-                                             ('BuildRequests without warnings','build__warnings_no:0', queryset_with_search.filter(build__warnings_no=0).count()),
+                                             ('Build with warnings','build__warnings_no__gte:1', queryset_with_search.filter(build__warnings_no__gte=1).count()),
+                                             ('Build without warnings','build__warnings_no:0', queryset_with_search.filter(build__warnings_no=0).count()),
                                              ]
                                 }
                     },
                     {'name': 'Time', 'clclass': 'time', 'hidden' : 1,
                      'qhelp': "How long it took the build to finish",
-                     'orderfield': _get_toggle_order(request, "timespent", True),
-                     'ordericon':_get_toggle_order_icon(request, "timespent"),
+#                     'orderfield': _get_toggle_order(request, "timespent", True),
+#                     'ordericon':_get_toggle_order_icon(request, "timespent"),
                      'orderkey' : 'timespent',
                     },
                     {'name': 'Image files', 'clclass': 'output',
@@ -1886,38 +1925,7 @@ if toastermain.settings.MANAGED:
                     },
                     ]
                 }
-
-        if not toastermain.settings.MANAGED:
-            context['tablecols'].insert(-2,
-                    {'name': 'Log1',
-                     'dclass': "span4",
-                     'qhelp': "Path to the build main log file",
-                     'clclass': 'log', 'hidden': 1,
-                     'orderfield': _get_toggle_order(request, "cooker_log_path"),
-                     'ordericon':_get_toggle_order_icon(request, "cooker_log_path"),
-                     'orderkey' : 'cooker_log_path',
-                    }
-            )
-
-
-        if toastermain.settings.MANAGED:
-            context['tablecols'].append(
-                    {'name': 'Project', 'clclass': 'project',
-                     'filter': {'class': 'project',
-                            'label': 'Project:',
-                            'options':  map(lambda x: (x.name,'',x.build_set.filter(outcome__lt=BuildRequest.REQ_INPROGRESS).count()), Project.objects.all()),
-
-                           }
-                    }
-            )
-
-
-        response = render(request, template, context)
-        _save_parameters_cookies(response, pagesize, orderby, request)
-        return response
-
-
-
+        return context, pagesize, orderby
 
     # new project
     def newproject(request):
@@ -1957,7 +1965,7 @@ if toastermain.settings.MANAGED:
                 prj = Project.objects.create_project(name = request.POST['projectname'], release = Release.objects.get(pk = request.POST['projectversion']))
                 prj.user_id = request.user.pk
                 prj.save()
-                return redirect(reverse(project, args = (prj.pk,)) + "#/newproject")
+                return redirect(reverse(project, args=(prj.pk,)) + "#/newproject")
 
             except (IntegrityError, BadParameterException) as e:
                 # fill in page with previously submitted values
@@ -2738,163 +2746,17 @@ if toastermain.settings.MANAGED:
 
     def projectbuilds(request, pid):
         template = 'projectbuilds.html'
-        # define here what parameters the view needs in the GET portion in order to
-        # be able to display something.  'count' and 'page' are mandatory for all views
-        # that use paginators.
-        mandatory_parameters = { 'count': 10,  'page' : 1, 'orderby' : 'completed_on:-' };
-        retval = _verify_parameters( request.GET, mandatory_parameters )
-
-        # boilerplate code that takes a request for an object type and returns a queryset
-        # for that object type. copypasta for all needed table searches
-        (filter_string, search_term, ordering_string) = _search_tuple(request, Build)
-        queryset_all = Build.objects.all().exclude(outcome = Build.IN_PROGRESS)
-        queryset_with_search = _get_queryset(Build, queryset_all, None, search_term, ordering_string, '-completed_on')
-        queryset = _get_queryset(Build, queryset_all, filter_string, search_term, ordering_string, '-completed_on')
+        buildrequests = BuildRequest.objects.exclude(project_id = pid, state__lte = BuildRequest.REQ_INPROGRESS).exclude(state=BuildRequest.REQ_DELETED)
 
-        # retrieve the objects that will be displayed in the table; builds a paginator and gets a page range to display
-        build_info = _build_page_range(Paginator(queryset, request.GET.get('count', 10)),request.GET.get('page', 1))
-
-
-        # set up list of fstypes for each build
-        fstypes_map = {};
-        for build in build_info:
-            targets = Target.objects.filter( build_id = build.id )
-            comma = "";
-            extensions = "";
-            for t in targets:
-                if ( not t.is_image ):
-                    continue
-                tif = Target_Image_File.objects.filter( target_id = t.id )
-                for i in tif:
-                    s=re.sub('.*tar.bz2', 'tar.bz2', i.file_name)
-                    if s == i.file_name:
-                        s=re.sub('.*\.', '', i.file_name)
-                    if None == re.search(s,extensions):
-                        extensions += comma + s
-                        comma = ", "
-            fstypes_map[build.id]=extensions
+        try:
+            context, pagesize, orderby = _build_list_helper(request, buildrequests)
+        except InvalidRequestException as e:
+            return _redirect_parameters(projectbuilds, request.GET, e.response, pid = pid)
 
-        # send the data to the template
-        context = {
-                    'objects' : build_info,
-                    'objectname' : "builds",
-                    'default_orderby' : 'completed_on:-',
-                    'fstypes' : fstypes_map,
-                    'search_term' : search_term,
-                    'total_count' : queryset_with_search.count(),
-                # Specifies the display of columns for the table, appearance in "Edit columns" box, toggling default show/hide, and specifying filters for columns
-                    'tablecols' : [
-                    {'name': 'Outcome',                                                # column with a single filter
-                     'qhelp' : "The outcome tells you if a build successfully completed or failed",     # the help button content
-                     'dclass' : "span2",                                                # indication about column width; comes from the design
-                     'orderfield': _get_toggle_order(request, "outcome"),               # adds ordering by the field value; default ascending unless clicked from ascending into descending
-                     'ordericon':_get_toggle_order_icon(request, "outcome"),
-                      # filter field will set a filter on that column with the specs in the filter description
-                      # the class field in the filter has no relation with clclass; the control different aspects of the UI
-                      # still, it is recommended for the values to be identical for easy tracking in the generated HTML
-                     'filter' : {'class' : 'outcome',
-                                 'label': 'Show:',
-                                 'options' : [
-                                             ('Successful builds', 'outcome:' + str(Build.SUCCEEDED), queryset_with_search.filter(outcome=str(Build.SUCCEEDED)).count()),  # this is the field search expression
-                                             ('Failed builds', 'outcome:'+ str(Build.FAILED), queryset_with_search.filter(outcome=str(Build.FAILED)).count()),
-                                             ]
-                                }
-                    },
-                    {'name': 'Target',                                                 # default column, disabled box, with just the name in the list
-                     'qhelp': "This is the build target or build targets (i.e. one or more recipes or image recipes)",
-                     'orderfield': _get_toggle_order(request, "target__target"),
-                     'ordericon':_get_toggle_order_icon(request, "target__target"),
-                    },
-                    {'name': 'Machine',
-                     'qhelp': "The machine is the hardware for which you are building a recipe or image recipe",
-                     'orderfield': _get_toggle_order(request, "machine"),
-                     'ordericon':_get_toggle_order_icon(request, "machine"),
-                     'dclass': 'span3'
-                    },                           # a slightly wider column
-                    {'name': 'Started on', 'clclass': 'started_on', 'hidden' : 1,      # this is an unchecked box, which hides the column
-                     'qhelp': "The date and time you started the build",
-                     'orderfield': _get_toggle_order(request, "started_on", True),
-                     'ordericon':_get_toggle_order_icon(request, "started_on"),
-                     'filter' : {'class' : 'started_on',
-                                 'label': 'Show:',
-                                 'options' : [
-                                             ("Today's builds" , 'started_on__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=timezone.now()).count()),
-                                             ("Yesterday's builds", 'started_on__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=(timezone.now()-timedelta(hours=24))).count()),
-                                             ("This week's builds", 'started_on__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=(timezone.now()-timedelta(days=7))).count()),
-                                             ]
-                                }
-                    },
-                    {'name': 'Completed on',
-                     'qhelp': "The date and time the build finished",
-                     'orderfield': _get_toggle_order(request, "completed_on", True),
-                     'ordericon':_get_toggle_order_icon(request, "completed_on"),
-                     'orderkey' : 'completed_on',
-                     'filter' : {'class' : 'completed_on',
-                                 'label': 'Show:',
-                                 'options' : [
-                                             ("Today's builds", 'completed_on__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=timezone.now()).count()),
-                                             ("Yesterday's builds", 'completed_on__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=(timezone.now()-timedelta(hours=24))).count()),
-                                             ("This week's builds", 'completed_on__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=(timezone.now()-timedelta(days=7))).count()),
-                                             ]
-                                }
-                    },
-                    {'name': 'Failed tasks', 'clclass': 'failed_tasks',                # specifing a clclass will enable the checkbox
-                     'qhelp': "How many tasks failed during the build",
-                     'filter' : {'class' : 'failed_tasks',
-                                 'label': 'Show:',
-                                 'options' : [
-                                             ('Builds with failed tasks', 'build__task_build__outcome:4', queryset_with_search.filter(build__task_build__outcome=4).count()),
-                                             ('Builds without failed tasks', 'build__task_build__outcome:NOT4', queryset_with_search.filter(~Q(build__task_build__outcome=4)).count()),
-                                             ]
-                                }
-                    },
-                    {'name': 'Errors', 'clclass': 'errors_no',
-                     'qhelp': "How many errors were encountered during the build (if any)",
-                     'orderfield': _get_toggle_order(request, "build__errors_no", True),
-                     'ordericon':_get_toggle_order_icon(request, "build__errors_no"),
-                     'orderkey' : 'build__errors_no',
-                     'filter' : {'class' : 'build__errors_no',
-                                 'label': 'Show:',
-                                 'options' : [
-                                             ('Builds with errors', 'build__errors_no__gte:1', queryset_with_search.filter(build__errors_no__gte=1).count()),
-                                             ('Builds without errors', 'build__errors_no:0', queryset_with_search.filter(build__errors_no=0).count()),
-                                             ]
-                                }
-                    },
-                    {'name': 'Warnings', 'clclass': 'warnings_no',
-                     'qhelp': "How many warnings were encountered during the build (if any)",
-                     'orderfield': _get_toggle_order(request, "warnings_no", True),
-                     'ordericon':_get_toggle_order_icon(request, "warnings_no"),
-                     'orderkey' : 'warnings_no',
-                     'filter' : {'class' : 'warnings_no',
-                                 'label': 'Show:',
-                                 'options' : [
-                                             ('Builds with warnings','warnings_no__gte:1', queryset_with_search.filter(warnings_no__gte=1).count()),
-                                             ('Builds without warnings','warnings_no:0', queryset_with_search.filter(warnings_no=0).count()),
-                                             ]
-                                }
-                    },
-                    {'name': 'Time', 'clclass': 'time', 'hidden' : 1,
-                     'qhelp': "How long it took the build to finish",
-                     'orderfield': _get_toggle_order(request, "timespent", True),
-                     'ordericon':_get_toggle_order_icon(request, "timespent"),
-                     'orderkey' : 'timespent',
-                    },
-                    {'name': 'Log',
-                     'dclass': "span4",
-                     'qhelp': "Path to the build main log file",
-                     'clclass': 'log', 'hidden': 1,
-                     'orderfield': _get_toggle_order(request, "cooker_log_path"),
-                     'ordericon':_get_toggle_order_icon(request, "cooker_log_path"),
-                     'orderkey' : 'cooker_log_path',
-                    },
-                    {'name': 'Output', 'clclass': 'output',
-                     'qhelp': "The root file system types produced by the build. You can find them in your <code>/build/tmp/deploy/images/</code> directory",
-                    },
-                    ]
-                }
+        response = render(request, template, context)
+        _save_parameters_cookies(response, pagesize, orderby, request)
 
-        return render(request, template, context)
+        return response
 
 
     def _file_name_for_artifact(b, artifact_type, artifact_id):
-- 
1.9.1


