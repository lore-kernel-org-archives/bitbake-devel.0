Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 517DA76803
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:33 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 15 Jan 2016 04:58:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; 
	d="scan'208,217";a="893808909"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2016 04:58:34 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id DEF0D6A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:30 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:01:04 +0200
Message-Id: <adba2b3442a41309fb4bd0eaaa73ff80f86f500b.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 21/23] toaster: toastergui: remove unused views and template code
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
X-List-Received-Date: Fri, 15 Jan 2016 12:58:34 -0000

From: Elliot Smith <elliot.smith@intel.com>

The code in views.py for setting up the template context for
old non-ToasterTable views is no longer necessary, as this
is now implemented in tables.py.

The template files for these views have also been removed.

[YOCTO #8738]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/templates/builds.html   | 125 -------
 lib/toaster/toastergui/templates/projects.html |  92 ------
 lib/toaster/toastergui/views.py                | 430 -------------------------
 3 files changed, 647 deletions(-)
 delete mode 100644 bitbake/lib/toaster/toastergui/templates/builds.html
 delete mode 100644 bitbake/lib/toaster/toastergui/templates/projects.html

diff --git a/lib/toaster/toastergui/templates/builds.html b/lib/toaster/toastergui/templates/builds.html
deleted file mode 100644
index c3cc266..0000000
--- a/lib/toaster/toastergui/templates/builds.html
+++ /dev/null
@@ -1,125 +0,0 @@
-{% extends "base.html" %}
-
-{% load static %}
-{% load projecttags %}
-{% load project_url_tag %}
-{% load humanize %}
-
-{% block title %} All builds - Toaster {% endblock %}
-{% block extraheadcontent %}
-<link rel="stylesheet" href="/static/css/jquery-ui.min.css" type='text/css'>
-<link rel="stylesheet" href="/static/css/jquery-ui.structure.min.css" type='text/css'>
-<link rel="stylesheet" href="/static/css/jquery-ui.theme.min.css" type='text/css'>
-<script src="/static/js/jquery-ui.min.js"></script>
-<script src="/static/js/filtersnippet.js"></script>
-{% endblock %}
-
-{% block pagecontent %}
-
-{% if last_date_from and last_date_to %}
-<script>
-    // initialize the date range controls
-    $(document).ready(function () {
-        date_init('started_on','{{last_date_from}}','{{last_date_to}}','{{dateMin_started_on}}','{{dateMax_started_on}}','{{daterange_selected}}');
-        date_init('completed_on','{{last_date_from}}','{{last_date_to}}','{{dateMin_completed_on}}','{{dateMax_completed_on}}','{{daterange_selected}}');
-    });
-</script>
-{%endif%} {# last_date_from and last_date_to #}
-
-<div class="row-fluid">
-
-  {% include "mrb_section.html" %}
-
-  <div class="page-header top-air">
-     <h1>
-      {% if request.GET.filter and objects.paginator.count > 0 or request.GET.search and objects.paginator.count > 0 %}
-          {{objects.paginator.count}} build{{objects.paginator.count|pluralize}} found
-      {%elif request.GET.filter and objects.paginator.count == 0 or request.GET.search and objects.paginator.count == 0 %}
-          No builds found
-      {%else%}
-          All builds
-      {%endif%}
-     </h1>
-  </div>
-
-  {% if objects.paginator.count == 0 %}
-    <div class="row-fluid">
-      <div class="alert">
-        <form class="no-results input-append" id="searchform">
-            <input id="search" name="search" class="input-xxlarge" type="text" value="
-            {% if request.GET.search %}
-                {{request.GET.search}}
-        {% endif %}"/>
-            {% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
-            <button class="btn" type="submit" value="Search">Search</button>
-            <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all builds</button>
-        </form>
-      </div>
-    </div>
-  {% else %}
-  {% include "basetable_top.html" %}
-        <!-- Table data rows; the order needs to match the order of "tablecols" definitions; and the <td class value needs to match the tablecols clclass value for show/hide buttons to work -->
-        {% for build in objects %}
-        <tr class="data" data-table-build-result="{{ build.id }}">
-            <td class="outcome">
-                <a href="{% url "builddashboard" build.id %}">{%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a>
-                {% if build.cooker_log_path %}
-                  &nbsp;
-                  <a href="{% url 'build_artifact' build.id "cookerlog" build.id %}">
-                    <i class="icon-download-alt" title="Download build log"></i>
-                  </a>
-                {% endif %}
-            </td>
-            <td class="target">
-                {% for t in build.target_set.all %}
-                    <a href="{% url "builddashboard" build.id %}">
-                        {% if t.task %}
-                            {{t.target}}:{{t.task}}
-                        {% else %}
-                            {{t.target}}
-                        {% endif %}
-                    </a> <br />
-                {% endfor %}
-            </td>
-            <td class="machine"><a href="{% url "builddashboard" build.id %}">{{build.machine}}</a></td>
-            <td class="started_on"><a href="{% url "builddashboard" build.id %}">{{build.started_on|date:"d/m/y H:i"}}</a></td>
-            <td class="completed_on"><a href="{% url "builddashboard" build.id %}">{{build.completed_on|date:"d/m/y H:i"}}</a></td>
-            <td class="failed_tasks error">
-                {% query build.task_build outcome=4 order__gt=0 as exectask%}
-                    {% if exectask.count == 1 %}
-                        <a href="{% url "task" build.id exectask.0.id %}">{{exectask.0.recipe.name}}.{{exectask.0.task_name}}</a>
-                        <a href="{% url 'build_artifact' build.id "tasklogfile" exectask.0.id %}">
-                            <i class="icon-download-alt" title="" data-original-title="Download task log file"></i>
-                        </a>
-                    {% elif exectask.count > 1%}
-                        <a href="{% url "tasks" build.id %}?filter=outcome%3A4">{{exectask.count}} task{{exectask.count|pluralize}}</a>
-                    {%endif%}
-            </td>
-            <td class="errors.count errors_no">
-                {% if  build.errors.count %}
-                    <a class="errors.count error" href="{% url "builddashboard" build.id %}#errors">{{build.errors.count}} error{{build.errors.count|pluralize}}</a>
-                {%endif%}
-            </td>
-            <td class="warnings.count warnings_no">{% if  build.warnings.count %}<a class="warnings.count warning" href="{% url "builddashboard" build.id %}#warnings">{{build.warnings.count}} warning{{build.warnings.count|pluralize}}</a>{%endif%}</td>
-            <td class="time"><a href="{% url "buildtime" build.id %}">{{build.timespent_seconds|sectohms}}</a></td>
-            <td class="output">
-              {% if build.outcome == build.SUCCEEDED %}
-              <a href="{%url "builddashboard" build.id%}#images">{{fstypes|get_dict_value:build.id}}</a>
-              {% endif %}
-            </td>
-            <td class="project-name">
-                <a href="{% project_url build.project %}">{{build.project.name}}</a>
-                {% if build.project.is_default %}
-                    <i class="icon-question-sign get-help hover-help" title="" data-original-title="This project shows information about the builds you start from the command line while Toaster is running" style="visibility: hidden;"></i>
-                {% endif %}
-            </td>
-        </tr>
-
-        {% endfor %}
-
-
-  {% include "basetable_bottom.html" %}
-  {% endif %} {# objects.paginator.count #}
-</div><!-- end row-fluid-->
-
-{% endblock %}
diff --git a/lib/toaster/toastergui/templates/projects.html b/lib/toaster/toastergui/templates/projects.html
deleted file mode 100644
index 678a796..0000000
--- a/lib/toaster/toastergui/templates/projects.html
+++ /dev/null
@@ -1,92 +0,0 @@
-{% extends "base.html" %}
-
-{% load static %}
-{% load projecttags %}
-{% load project_url_tag %}
-{% load humanize %}
-
-{% block title %} All projects - Toaster {% endblock %}
-
-{% block pagecontent %}
-
-
-  <div class="page-header top-air">
-      <h1>
-      {% if request.GET.filter and objects.paginator.count > 0 or request.GET.search and objects.paginator.count > 0 %}
-          {{objects.paginator.count}} project{{objects.paginator.count|pluralize}} found
-      {%elif request.GET.filter and objects.paginator.count == 0 or request.GET.search and objects.paginator.count == 0 %}
-          No projects found
-      {%else%}
-          All projects
-      {%endif%}
-       </h1>
-  </div>
-
-  {% if objects.paginator.count == 0 %}
-    <div class="row-fluid">
-      <div class="alert">
-        <form class="no-results input-append" id="searchform">
-            <input id="search" name="search" class="input-xxlarge" type="text" value="
-                {% if request.GET.search %}
-                    {{request.GET.search}}
-                {% endif %}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
-            <button class="btn" type="submit" value="Search">Search</button>
-            <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all projects</button>
-        </form>
-      </div>
-    </div>
-
-  {% else %} {# We have builds to display #}
-  {% include "basetable_top.html" %}
-  {% for o in objects %}
-    <tr class="data" data-project="{{ o.id }}">
-      <td data-project-field="name">
-          <a href="{% project_url o %}">{{o.name}}</a>
-      </td>
-      <td class="updated"><a href="{% project_url o %}">{{o.updated|date:"d/m/y H:i"}}</a></td>
-      <td data-project-field="release">
-        {% if o.release %}
-            <a href="{% url 'project' o.id %}#project-details">{{o.release.name}}</a>
-        {% elif o.is_default %}
-            <span class="muted">Not applicable</span>
-            <i class="icon-question-sign get-help hover-help" title="" data-original-title="This project does not have a release set. It simply collects information about the builds you start from the command line while Toaster is running" style="visibility: hidden;"></i>
-        {% else %}
-            No release available
-        {% endif %}
-      </td>
-      <td data-project-field="machine">
-        {% if o.is_default %}
-            <span class="muted">Not applicable</span>
-            <i class="icon-question-sign get-help hover-help" title="" data-original-title="This project does not have a machine set. It simply collects information about the builds you start from the command line while Toaster is running" style="visibility: hidden;"></i>
-        {% else %}
-            <a href="{% url 'project' o.id %}#machine-distro">{{o.get_current_machine_name}}</a>
-        {% endif %}
-      </td>
-      {% if o.get_number_of_builds == 0 %}
-      <td class="muted">{{o.get_number_of_builds}}</td>
-      <td class="loutcome"></td>
-      <td class="ltarget"></td>
-      <td class="lerrors"></td>
-      <td class="lwarnings"></td>
-      <td class="limagefiles"></td>
-      {% else %}
-      <td><a href="{% url 'projectbuilds' o.id %}">{{o.get_number_of_builds}}</a></td>
-      <td class="loutcome"><a href="{% url "builddashboard" o.get_last_build_id %}">{%if o.get_last_outcome == build_SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif o.get_last_outcome == build_FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a></td>
-      <td class="ltarget"><a href="{% url "builddashboard" o.get_last_build_id %}">{{o.get_last_target}} </a></td>
-      <td class="lerrors">{% if o.get_last_errors %}<a class="errors.count error" href="{% url "builddashboard" o.get_last_build_id %}#errors">{{o.get_last_errors}} error{{o.get_last_errors|pluralize}}</a>{%endif%}</td>
-      <td class="lwarnings">{% if o.get_last_warnings %}<a class="warnings.count warning" href="{% url "builddashboard" o.get_last_build_id %}#warnings">{{o.get_last_warnings}} warning{{o.get_last_warnings|pluralize}}</a>{%endif%}</td>
-      <td class="limagefiles">
-        {% if o.get_last_outcome == build_SUCCEEDED %}
-        <a href="{%url "builddashboard" o.get_last_build_id %}#images">{{fstypes|get_dict_value:o.id}}</a>
-        {% endif %}
-      </td>
-
-      {% endif %}
-    </tr>
-  {% endfor %}
-  {% include "basetable_bottom.html" %}
-  {% endif %} {# empty #}
-
-{% endblock %}
-
-
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 3e8a66b..4f7b50f 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -92,50 +92,6 @@ def landing(request):
 
     return render(request, 'landing.html', context)
 
-"""
-# returns a list for most recent builds;
-def _get_latest_builds(prj=None):
-    queryset = Build.objects.all()
-
-    if prj is not None:
-        queryset = queryset.filter(project = prj)
-
-    return list(itertools.chain(
-        queryset.filter(outcome=Build.IN_PROGRESS).order_by("-started_on"),
-        queryset.filter(outcome__lt=Build.IN_PROGRESS).order_by("-started_on")[:3] ))
-"""
-
-"""
-# a JSON-able dict of recent builds; for use in the Project page, xhr_ updates,  and other places, as needed
-def _project_recent_build_list(prj):
-    data = []
-    # take the most recent 3 completed builds, plus any builds in progress
-    for x in _get_latest_builds(prj):
-        d = {
-            "id":  x.pk,
-            "targets" : map(lambda y: {"target": y.target, "task": y.task }, x.target_set.all()), # TODO: create the task entry in the Target table
-            "status": x.get_current_status(),
-            "errors": map(lambda y: {"type": y.lineno, "msg": y.message, "tb": y.pathname}, (x.logmessage_set.filter(level__gte=LogMessage.WARNING)|x.logmessage_set.filter(level=LogMessage.EXCEPTION))),
-            "updated": x.completed_on.strftime('%s')+"000",
-            "command_time": (x.completed_on - x.started_on).total_seconds(),
-            "br_page_url": reverse('builddashboard', args=(x.pk,) ),
-            "build" : map( lambda y: {"id": y.pk,
-                        "status": y.get_outcome_display(),
-                        "completed_on" : y.completed_on.strftime('%s')+"000",
-                        "build_time" : (y.completed_on - y.started_on).total_seconds(),
-                        "build_page_url" : reverse('builddashboard', args=(y.pk,)),
-                        'build_time_page_url': reverse('buildtime', args=(y.pk,)),
-                        "errors": y.errors.count(),
-                        "warnings": y.warnings.count(),
-                        "completeper": y.completeper() if y.outcome == Build.IN_PROGRESS else "0",
-                        "eta": y.eta().strftime('%s')+"000" if y.outcome == Build.IN_PROGRESS else "0",
-                        }, [x]),
-            }
-        data.append(d)
-
-    return data
-"""
-
 def objtojson(obj):
     from django.db.models.query import QuerySet
     from django.db.models import Model
@@ -1919,215 +1875,6 @@ if True:
         ''' The exception raised on invalid POST requests '''
         pass
 
-    """
-    # helper function, to be used on "all builds" and "project builds" pages
-    def _build_list_helper(request, queryset_all, redirect_page, pid=None):
-        default_orderby = 'completed_on:-'
-        (pagesize, orderby) = _get_parameters_values(request, 10, default_orderby)
-        mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
-        retval = _verify_parameters( request.GET, mandatory_parameters )
-        if retval:
-            params = {}
-            if pid:
-                params = {'pid': pid}
-            raise RedirectException(redirect_page,
-                                    request.GET,
-                                    mandatory_parameters,
-                                    **params)
-
-        # boilerplate code that takes a request for an object type and returns a queryset
-        # for that object type. copypasta for all needed table searches
-        (filter_string, search_term, ordering_string) = _search_tuple(request, Build)
-
-        # post-process any date range filters
-        filter_string, daterange_selected = _modify_date_range_filter(filter_string)
-
-        # don't show "in progress" builds in "all builds" or "project builds"
-        queryset_all = queryset_all.exclude(outcome = Build.IN_PROGRESS)
-
-        # append project info
-        queryset_all = queryset_all.select_related("project")
-
-        # annotate with number of ERROR and EXCEPTION log messages
-        queryset_all = queryset_all.annotate(
-            errors_no = Count(
-                'logmessage',
-                only=Q(logmessage__level=LogMessage.ERROR) |
-                     Q(logmessage__level=LogMessage.EXCEPTION)
-            )
-        )
-
-        # annotate with number of warnings
-        q_warnings = Q(logmessage__level=LogMessage.WARNING)
-        queryset_all = queryset_all.annotate(
-            warnings_no = Count('logmessage', only=q_warnings)
-        )
-
-        queryset_with_search = _get_queryset(Build, queryset_all,
-                                             None, search_term,
-                                             ordering_string, '-completed_on')
-
-        queryset = _get_queryset(Build, queryset_all,
-                                 filter_string, search_term,
-                                 ordering_string, '-completed_on')
-
-        # retrieve the objects that will be displayed in the table; builds a paginator and gets a page range to display
-        build_info = _build_page_range(Paginator(queryset, pagesize), request.GET.get('page', 1))
-
-        # build view-specific information; this is rendered specifically in the builds page, at the top of the page (i.e. Recent builds)
-        build_mru = _get_latest_builds()[:3]
-
-        # calculate the exact begining of local today and yesterday, append context
-        context_date,today_begin,yesterday_begin = _add_daterange_context(queryset_all, request, {'started_on','completed_on'})
-
-        # set up list of fstypes for each build
-        fstypes_map = {}
-
-        for build in build_info:
-            fstypes_map[build.id] = build.get_image_file_extensions()
-
-        # send the data to the template
-        context = {
-                # specific info for
-                    'mru' : build_mru,
-                # TODO: common objects for all table views, adapt as needed
-                    'objects' : build_info,
-                    'objectname' : "builds",
-                    'default_orderby' : default_orderby,
-                    'fstypes' : fstypes_map,
-                    'search_term' : search_term,
-                    'total_count' : queryset_with_search.count(),
-                    'daterange_selected' : daterange_selected,
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
-                    {'name': 'Recipe',                                                 # default column, disabled box, with just the name in the list
-                     'qhelp': "What you built (i.e. one or more recipes or image recipes)",
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
-                     'orderkey' : "started_on",
-                     'filter' : {'class' : 'started_on',
-                                 'label': 'Show:',
-                                 'options' : [
-                                             ("Today's builds" , 'started_on__gte:'+today_begin.strftime("%Y-%m-%d"), queryset_all.filter(started_on__gte=today_begin).count()),
-                                             ("Yesterday's builds",
-                                                 'started_on__gte!started_on__lt:'
-                                                     +yesterday_begin.strftime("%Y-%m-%d")+'!'
-                                                     +today_begin.strftime("%Y-%m-%d"),
-                                                 queryset_all.filter(
-                                                     started_on__gte=yesterday_begin,
-                                                     started_on__lt=today_begin
-                                                     ).count()),
-                                             ("Build date range", 'daterange', 1, '', 'started_on'),
-                                             ]
-                                }
-                     },
-                    {'name': 'Completed on',
-                     'qhelp': "The date and time the build finished",
-                     'orderfield': _get_toggle_order(request, "completed_on", True),
-                     'ordericon':_get_toggle_order_icon(request, "completed_on"),
-                     'orderkey' : 'completed_on',
-                     'filter' : {'class' : 'completed_on',
-                                 'label': 'Show:',
-                                 'options' : [
-                                             ("Today's builds" , 'completed_on__gte:'+today_begin.strftime("%Y-%m-%d"), queryset_all.filter(completed_on__gte=today_begin).count()),
-                                             ("Yesterday's builds",
-                                                 'completed_on__gte!completed_on__lt:'
-                                                     +yesterday_begin.strftime("%Y-%m-%d")+'!'
-                                                     +today_begin.strftime("%Y-%m-%d"),
-                                                 queryset_all.filter(
-                                                     completed_on__gte=yesterday_begin,
-                                                     completed_on__lt=today_begin
-                                                     ).count()),
-                                             ("Build date range", 'daterange', 1, '', 'completed_on'),
-                                             ]
-                                }
-                    },
-                    {'name': 'Failed tasks', 'clclass': 'failed_tasks',                # specifing a clclass will enable the checkbox
-                     'qhelp': "How many tasks failed during the build",
-                     'filter' : {'class' : 'failed_tasks',
-                                 'label': 'Show:',
-                                 'options' : [
-                                             ('Builds with failed tasks', 'task_build__outcome:4', queryset_with_search.filter(task_build__outcome=4).count()),
-                                             ('Builds without failed tasks', 'task_build__outcome:NOT4', queryset_with_search.filter(~Q(task_build__outcome=4)).count()),
-                                             ]
-                                }
-                    },
-                    {'name': 'Errors', 'clclass': 'errors_no',
-                     'qhelp': "How many errors were encountered during the build (if any)",
-                     # Comment out sorting and filter until YOCTO #8131 is fixed
-                     #'orderfield': _get_toggle_order(request, "errors_no", True),
-                     #'ordericon':_get_toggle_order_icon(request, "errors_no"),
-                     #'orderkey' : 'errors_no',
-                     #'filter' : {'class' : 'errors_no',
-                     #            'label': 'Show:',
-                     #            'options' : [
-                     #                        ('Builds with errors', 'errors_no__gte:1', queryset_with_search.filter(errors_no__gte=1).count()),
-                     #                        ('Builds without errors', 'errors_no:0', queryset_with_search.filter(errors_no=0).count()),
-                     #                        ]
-                     #           }
-                    },
-                    {'name': 'Warnings', 'clclass': 'warnings_no',
-                     'qhelp': "How many warnings were encountered during the build (if any)",
-                     # Comment out sorting and filter until YOCTO #8131 is fixed
-                     #'orderfield': _get_toggle_order(request, "warnings_no", True),
-                     #'ordericon':_get_toggle_order_icon(request, "warnings_no"),
-                     #'orderkey' : 'warnings_no',
-                     #'filter' : {'class' : 'warnings_no',
-                     #            'label': 'Show:',
-                     #            'options' : [
-                     #                        ('Builds with warnings','warnings_no__gte:1', queryset_with_search.filter(warnings_no__gte=1).count()),
-                     #                        ('Builds without warnings','warnings_no:0', queryset_with_search.filter(warnings_no=0).count()),
-                     #                        ]
-                     #           }
-                    },
-                    {'name': 'Time', 'clclass': 'time', 'hidden' : 1,
-                     'qhelp': "How long it took the build to finish",
-                     # Comment out sorting until YOCTO #8131 is fixed
-                     #'orderfield': _get_toggle_order(request, "timespent", True),
-                     #'ordericon':_get_toggle_order_icon(request, "timespent"),
-                     #'orderkey' : 'timespent',
-                    },
-                    {'name': 'Image files', 'clclass': 'output',
-                     'qhelp': "The root file system types produced by the build. You can find them in your <code>/build/tmp/deploy/images/</code> directory",
-                        # TODO: compute image fstypes from Target_Image_File
-                    }
-                    ]
-                }
-
-        # merge daterange values
-        context.update(context_date)
-        return context, pagesize, orderby
-    """
-
-
-
     # new project
     def newproject(request):
         template = "newproject.html"
@@ -2829,64 +2576,6 @@ if True:
 
         return context
 
-    # WARNING _build_list_helper() may raise a RedirectException, which
-    # will set the GET parameters and redirect back to the
-    # all-builds or projectbuilds page as appropriate;
-    # TODO don't use exceptions to control program flow
-    """
-    def projectbuilds(request, pid):
-        if request.method == "POST":
-            # process any build request
-
-            if 'buildCancel' in request.POST:
-                for i in request.POST['buildCancel'].strip().split(" "):
-                    try:
-                        br = BuildRequest.objects.select_for_update().get(project = prj, pk = i, state__lte = BuildRequest.REQ_QUEUED)
-                        br.state = BuildRequest.REQ_DELETED
-                        br.save()
-                    except BuildRequest.DoesNotExist:
-                        pass
-
-            if 'buildDelete' in request.POST:
-                for i in request.POST['buildDelete'].strip().split(" "):
-                    try:
-                        BuildRequest.objects.select_for_update().get(project = prj, pk = i, state__lte = BuildRequest.REQ_DELETED).delete()
-                    except BuildRequest.DoesNotExist:
-                        pass
-
-            if 'targets' in request.POST:
-                ProjectTarget.objects.filter(project = prj).delete()
-                s = str(request.POST['targets'])
-                for t in s.translate(None, ";%|\"").split(" "):
-                    if ":" in t:
-                        target, task = t.split(":")
-                    else:
-                        target = t
-                        task = ""
-                    ProjectTarget.objects.create(project = prj,
-                                                 target = target,
-                                                 task = task)
-                prj.schedule_build()
-
-        queryset = Build.objects.filter(project_id = pid)
-
-        redirect_page = resolve(request.path_info).url_name
-
-        context, pagesize, orderby = _build_list_helper(request,
-                                                        queryset,
-                                                        redirect_page,
-                                                        pid)
-
-        context['project'] = prj
-        _set_parameters_values(pagesize, orderby, request)
-
-        # add the most recent builds for this project
-        context['mru'] = _get_latest_builds(prj)
-
-        return context
-    """
-
-
     def _file_name_for_artifact(b, artifact_type, artifact_id):
         file_name = None
         # Target_Image_File file_name
@@ -2962,122 +2651,3 @@ if True:
                 'build' : Build.objects.get(pk = build_id),
             }
             return render(request, "unavailable_artifact.html", context)
-
-    """
-    @_template_renderer("projects.html")
-    def projects(request):
-        (pagesize, orderby) = _get_parameters_values(request, 10, 'updated:-')
-        mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
-        retval = _verify_parameters( request.GET, mandatory_parameters )
-        if retval:
-            raise RedirectException( 'all-projects', request.GET, mandatory_parameters )
-
-        queryset_all = Project.objects.all()
-
-        # annotate each project with its number of builds
-        queryset_all = queryset_all.annotate(num_builds=Count('build'))
-
-        # exclude the command line builds project if it has no builds
-        q_default_with_builds = Q(is_default=True) & Q(num_builds__gt=0)
-        queryset_all = queryset_all.filter(Q(is_default=False) |
-                                           q_default_with_builds)
-
-        # boilerplate code that takes a request for an object type and returns a queryset
-        # for that object type. copypasta for all needed table searches
-        (filter_string, search_term, ordering_string) = _search_tuple(request, Project)
-        queryset_with_search = _get_queryset(Project, queryset_all, None, search_term, ordering_string, '-updated')
-        queryset = _get_queryset(Project, queryset_all, filter_string, search_term, ordering_string, '-updated')
-
-        # retrieve the objects that will be displayed in the table; projects a paginator and gets a page range to display
-        project_info = _build_page_range(Paginator(queryset, pagesize), request.GET.get('page', 1))
-
-        # add fields needed in JSON dumps for API call support
-        for p in project_info.object_list:
-            p.id = p.pk
-            p.projectPageUrl = reverse('project', args=(p.id,))
-            p.layersTypeAheadUrl = reverse('xhr_layerstypeahead', args=(p.id,))
-            p.recipesTypeAheadUrl = reverse('xhr_recipestypeahead', args=(p.id,))
-            p.projectBuildsUrl = reverse('projectbuilds', args=(p.id,))
-
-        # build view-specific information; this is rendered specifically in the builds page, at the top of the page (i.e. Recent builds)
-        build_mru = _get_latest_builds()
-
-        # translate the project's build target strings
-        fstypes_map = {};
-        for project in project_info:
-            try:
-                targets = Target.objects.filter( build_id = project.get_last_build_id() )
-                comma = "";
-                extensions = "";
-                for t in targets:
-                    if ( not t.is_image ):
-                        continue
-                    tif = Target_Image_File.objects.filter( target_id = t.id )
-                    for i in tif:
-                        s=re.sub('.*tar.bz2', 'tar.bz2', i.file_name)
-                        if s == i.file_name:
-                            s=re.sub('.*\.', '', i.file_name)
-                        if None == re.search(s,extensions):
-                            extensions += comma + s
-                            comma = ", "
-                fstypes_map[project.id]=extensions
-            except (Target.DoesNotExist,IndexError):
-                fstypes_map[project.id]=project.get_last_imgfiles
-
-        context = {
-                'mru' : build_mru,
-
-                'objects' : project_info,
-                'objectname' : "projects",
-                'default_orderby' : 'id:-',
-                'search_term' : search_term,
-                'total_count' : queryset_with_search.count(),
-                'fstypes' : fstypes_map,
-                'build_FAILED' : Build.FAILED,
-                'build_SUCCEEDED' : Build.SUCCEEDED,
-                'tablecols': [
-                    {'name': 'Project',
-                    'orderfield': _get_toggle_order(request, "name"),
-                    'ordericon':_get_toggle_order_icon(request, "name"),
-                    'orderkey' : 'name',
-                    },
-                    {'name': 'Last activity on',
-                    'clclass': 'updated',
-                    'qhelp': "Shows the starting date and time of the last project build. If the project has no builds, it shows the date the project was created",
-                    'orderfield': _get_toggle_order(request, "updated", True),
-                    'ordericon':_get_toggle_order_icon(request, "updated"),
-                    'orderkey' : 'updated',
-                    },
-                    {'name': 'Release',
-                    'qhelp' : "The version of the build system used by the project",
-                    'orderfield': _get_toggle_order(request, "release__name"),
-                    'ordericon':_get_toggle_order_icon(request, "release__name"),
-                    'orderkey' : 'release__name',
-                    },
-                    {'name': 'Machine',
-                    'qhelp': "The hardware currently selected for the project",
-                    },
-                    {'name': 'Number of builds',
-                    'qhelp': "How many builds have been run for the project",
-                    },
-                    {'name': 'Last build outcome', 'clclass': 'loutcome',
-                    'qhelp': "Tells you if the last project build completed successfully or failed",
-                    },
-                    {'name': 'Recipe', 'clclass': 'ltarget',
-                    'qhelp': "The last recipe that was built in this project",
-                    },
-                    {'name': 'Errors', 'clclass': 'lerrors',
-                    'qhelp': "How many errors were encountered during the last project build (if any)",
-                    },
-                    {'name': 'Warnings', 'clclass': 'lwarnings',
-                    'qhelp': "How many warnigns were encountered during the last project build (if any)",
-                    },
-                    {'name': 'Image files', 'clclass': 'limagefiles', 'hidden': 1,
-                    'qhelp': "The root file system types produced by the last project build",
-                    },
-                    ]
-            }
-
-        _set_parameters_values(pagesize, orderby, request)
-        return context
-    """
-- 
2.1.4


