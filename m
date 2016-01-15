Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 92B7673232
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:23 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP; 15 Jan 2016 04:58:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="633907051"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 15 Jan 2016 04:58:24 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 8DBBC6A4007
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:20 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:00:55 +0200
Message-Id: <ff9692fbf53e2277b70188b0cad3b957a338daad.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 12/23] toaster: toastergui: convert project builds page to ToasterTable
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
X-List-Received-Date: Fri, 15 Jan 2016 12:58:23 -0000

From: Elliot Smith <elliot.smith@intel.com>

Use the all builds ToasterTable as the basis for the project builds
ToasterTable.

[YOCTO #8738]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/projecttopbar.js  |   9 +
 lib/toaster/toastergui/static/js/table.js          |  13 +-
 lib/toaster/toastergui/tables.py                   | 184 +++++++++++++++++----
 .../toastergui/templates/baseprojectpage.html      |   1 +
 lib/toaster/toastergui/templates/mrb_section.html  |   2 +-
 .../templates/projectbuilds-toastertable.html      |  56 +++++++
 lib/toaster/toastergui/urls.py                     |   6 +-
 lib/toaster/toastergui/views.py                    |  16 +-
 lib/toaster/toastergui/widgets.py                  |   1 -
 9 files changed, 239 insertions(+), 49 deletions(-)
 create mode 100644 bitbake/lib/toaster/toastergui/templates/projectbuilds-toastertable.html

diff --git a/lib/toaster/toastergui/static/js/projecttopbar.js b/lib/toaster/toastergui/static/js/projecttopbar.js
index b6ad380..58a32a0 100644
--- a/lib/toaster/toastergui/static/js/projecttopbar.js
+++ b/lib/toaster/toastergui/static/js/projecttopbar.js
@@ -7,7 +7,10 @@ function projectTopBarInit(ctx) {
   var projectName = $("#project-name");
   var projectNameFormToggle = $("#project-change-form-toggle");
   var projectNameChangeCancel = $("#project-name-change-cancel");
+
+  // this doesn't exist for command-line builds
   var newBuildTargetInput = $("#build-input");
+
   var newBuildTargetBuildBtn = $("#build-button");
   var selectedTarget;
 
@@ -42,6 +45,12 @@ function projectTopBarInit(ctx) {
       $(this).parent().removeClass('active');
   });
 
+  if (!newBuildTargetInput.length) {
+    return;
+  }
+
+  /* the following only applies for non-command-line projects */
+
   /* Recipe build input functionality */
   if (ctx.numProjectLayers > 0 && ctx.machine){
     newBuildTargetInput.removeAttr("disabled");
diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index afe16b5..7ac4ed5 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -33,6 +33,10 @@ function tableInit(ctx){
 
   loadData(tableParams);
 
+  // clicking on this set of elements removes the search
+  var clearSearchElements = $('.remove-search-btn-'+ctx.tableName +
+                              ', .show-all-'+ctx.tableName);
+
   function loadData(tableParams){
     $.ajax({
         type: "GET",
@@ -62,9 +66,9 @@ function tableInit(ctx){
     paginationBtns.html("");
 
     if (tableParams.search)
-      $('.remove-search-btn-'+ctx.tableName).show();
+      clearSearchElements.show();
     else
-      $('.remove-search-btn-'+ctx.tableName).hide();
+      clearSearchElements.hide();
 
     $('.table-count-' + ctx.tableName).text(tableData.total);
     tableTotal = tableData.total;
@@ -230,9 +234,8 @@ function tableInit(ctx){
 
       } else {
         /* Not orderable */
-        header.addClass("muted");
         header.css("font-weight", "normal");
-        header.append(col.title+' ');
+        header.append('<span class="muted">' + col.title + '</span> ');
       }
 
       /* Setup the filter button */
@@ -665,7 +668,7 @@ function tableInit(ctx){
     loadData(tableParams);
   });
 
-  $('.remove-search-btn-'+ctx.tableName).click(function(e){
+  clearSearchElements.click(function(e){
     e.preventDefault();
 
     tableParams.page = 1;
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 58abe36..d0ed496 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -23,9 +23,11 @@ from toastergui.widgets import ToasterTable
 from toastergui.querysetfilter import QuerysetFilter
 from orm.models import Recipe, ProjectLayer, Layer_Version, Machine, Project
 from orm.models import CustomImageRecipe, Package, Build, LogMessage, Task
+from orm.models import ProjectTarget
 from django.db.models import Q, Max, Count
 from django.conf.urls import url
-from django.core.urlresolvers import reverse
+from django.core.urlresolvers import reverse, resolve
+from django.http import HttpResponse
 from django.views.generic import TemplateView
 import itertools
 
@@ -775,7 +777,7 @@ class ProjectsTable(ToasterTable):
         '''
 
         errors_template = '''
-        {% if data.get_number_of_builds > 0 %}
+        {% if data.get_number_of_builds > 0 and data.get_last_errors > 0 %}
           <a class="errors.count error"
              href="{% url "builddashboard" data.get_last_build_id %}#errors">
             {{data.get_last_errors}} error{{data.get_last_errors | pluralize}}
@@ -784,7 +786,7 @@ class ProjectsTable(ToasterTable):
         '''
 
         warnings_template = '''
-        {% if data.get_number_of_builds > 0 %}
+        {% if data.get_number_of_builds > 0 and data.get_last_warnings > 0 %}
           <a class="warnings.count warning"
              href="{% url "builddashboard" data.get_last_build_id %}#warnings">
             {{data.get_last_warnings}} warning{{data.get_last_warnings | pluralize}}
@@ -886,30 +888,45 @@ class BuildsTable(ToasterTable):
     def __init__(self, *args, **kwargs):
         super(BuildsTable, self).__init__(*args, **kwargs)
         self.default_orderby = '-completed_on'
-        self.title = 'All builds'
         self.static_context_extra['Build'] = Build
         self.static_context_extra['Task'] = Task
 
+        # attributes that are overridden in subclasses
+
+        # title for the page
+        self.title = ''
+
+        # 'project' or 'all'; determines how the mrb (most recent builds)
+        # section is displayed
+        self.mrb_type = ''
+
+    def get_builds(self):
+        """
+        overridden in ProjectBuildsTable to return builds for a
+        single project
+        """
+        return Build.objects.all()
+
     def get_context_data(self, **kwargs):
         context = super(BuildsTable, self).get_context_data(**kwargs)
 
         # for the latest builds section
-        queryset = Build.objects.all()
+        builds = self.get_builds()
 
         finished_criteria = Q(outcome=Build.SUCCEEDED) | Q(outcome=Build.FAILED)
 
         latest_builds = itertools.chain(
-            queryset.filter(outcome=Build.IN_PROGRESS).order_by("-started_on"),
-            queryset.filter(finished_criteria).order_by("-completed_on")[:3]
+            builds.filter(outcome=Build.IN_PROGRESS).order_by("-started_on"),
+            builds.filter(finished_criteria).order_by("-completed_on")[:3]
         )
 
         context['mru'] = list(latest_builds)
-        context['mrb_type'] = 'all'
+        context['mrb_type'] = self.mrb_type
 
         return context
 
     def setup_queryset(self, *args, **kwargs):
-        queryset = Build.objects.all()
+        queryset = self.get_builds()
 
         # don't include in progress builds
         queryset = queryset.exclude(outcome=Build.IN_PROGRESS)
@@ -949,7 +966,8 @@ class BuildsTable(ToasterTable):
         {% if data.cooker_log_path %}
             &nbsp;
             <a href="{% url "build_artifact" data.id "cookerlog" data.id %}">
-               <i class="icon-download-alt" title="Download build log"></i>
+               <i class="icon-download-alt get-help"
+               data-original-title="Download build log"></i>
             </a>
         {% endif %}
         '''
@@ -1031,19 +1049,6 @@ class BuildsTable(ToasterTable):
         {% endif %}
         '''
 
-        project_template = '''
-        {% load project_url_tag %}
-        <a href="{% project_url data.project %}">
-            {{data.project.name}}
-        </a>
-        {% if data.project.is_default %}
-            <i class="icon-question-sign get-help hover-help" title=""
-               data-original-title="This project shows information about
-               the builds you start from the command line while Toaster is
-               running" style="visibility: hidden;"></i>
-        {% endif %}
-        '''
-
         self.add_column(title='Outcome',
                         help_text='Final state of the build (successful \
                                    or failed)',
@@ -1098,16 +1103,16 @@ class BuildsTable(ToasterTable):
                         help_text='The number of errors encountered during \
                                    the build (if any)',
                         hideable=True,
-                        orderable=False,
-                        static_data_name='errors',
+                        orderable=True,
+                        static_data_name='errors_no',
                         static_data_template=errors_template)
 
         self.add_column(title='Warnings',
                         help_text='The number of warnings encountered during \
                                    the build (if any)',
                         hideable=True,
-                        orderable=False,
-                        static_data_name='warnings',
+                        orderable=True,
+                        static_data_name='warnings_no',
                         static_data_template=warnings_template)
 
         self.add_column(title='Time',
@@ -1125,12 +1130,6 @@ class BuildsTable(ToasterTable):
                         static_data_name='image_files',
                         static_data_template=image_files_template)
 
-        self.add_column(title='Project',
-                        hideable=True,
-                        orderable=False,
-                        static_data_name='project-name',
-                        static_data_template=project_template)
-
     def setup_filters(self, *args, **kwargs):
         # outcomes
         outcome_filter = TableFilter(
@@ -1239,3 +1238,122 @@ class BuildsTable(ToasterTable):
         failed_tasks_filter.add_action(with_failed_tasks_action)
         failed_tasks_filter.add_action(without_failed_tasks_action)
         self.add_filter(failed_tasks_filter)
+
+    def post(self, request, *args, **kwargs):
+        """ Process HTTP POSTs which make build requests """
+
+        project = Project.objects.get(pk=kwargs['pid'])
+
+        if 'buildCancel' in request.POST:
+            for i in request.POST['buildCancel'].strip().split(" "):
+                try:
+                    br = BuildRequest.objects.select_for_update().get(project = project, pk = i, state__lte = BuildRequest.REQ_QUEUED)
+                    br.state = BuildRequest.REQ_DELETED
+                    br.save()
+                except BuildRequest.DoesNotExist:
+                    pass
+
+        if 'buildDelete' in request.POST:
+            for i in request.POST['buildDelete'].strip().split(" "):
+                try:
+                    BuildRequest.objects.select_for_update().get(project = project, pk = i, state__lte = BuildRequest.REQ_DELETED).delete()
+                except BuildRequest.DoesNotExist:
+                    pass
+
+        if 'targets' in request.POST:
+            ProjectTarget.objects.filter(project = project).delete()
+            s = str(request.POST['targets'])
+            for t in s.translate(None, ";%|\"").split(" "):
+                if ":" in t:
+                    target, task = t.split(":")
+                else:
+                    target = t
+                    task = ""
+                ProjectTarget.objects.create(project = project,
+                                             target = target,
+                                             task = task)
+            project.schedule_build()
+
+        # redirect back to builds page so any new builds in progress etc.
+        # are visible
+        response = HttpResponse()
+        response.status_code = 302
+        response['Location'] = request.build_absolute_uri()
+        return response
+
+class AllBuildsTable(BuildsTable):
+    """ Builds page for all builds """
+
+    def __init__(self, *args, **kwargs):
+        super(AllBuildsTable, self).__init__(*args, **kwargs)
+        self.title = 'All builds'
+        self.mrb_type = 'all'
+
+    def setup_columns(self, *args, **kwargs):
+        """
+        All builds page shows a column for the project
+        """
+
+        super(AllBuildsTable, self).setup_columns(*args, **kwargs)
+
+        project_template = '''
+        {% load project_url_tag %}
+        <a href="{% project_url data.project %}">
+            {{data.project.name}}
+        </a>
+        {% if data.project.is_default %}
+            <i class="icon-question-sign get-help hover-help" title=""
+               data-original-title="This project shows information about
+               the builds you start from the command line while Toaster is
+               running" style="visibility: hidden;"></i>
+        {% endif %}
+        '''
+
+        self.add_column(title='Project',
+                        hideable=True,
+                        orderable=True,
+                        static_data_name='project',
+                        static_data_template=project_template)
+
+class ProjectBuildsTable(BuildsTable):
+    """
+    Builds page for a single project; a BuildsTable, with the queryset
+    filtered by project
+    """
+
+    def __init__(self, *args, **kwargs):
+        super(ProjectBuildsTable, self).__init__(*args, **kwargs)
+        self.title = 'All project builds'
+        self.mrb_type = 'project'
+
+        # set from the querystring
+        self.project_id = None
+
+    def setup_queryset(self, *args, **kwargs):
+        """
+        NOTE: self.project_id must be set before calling super(),
+        as it's used in setup_queryset()
+        """
+        self.project_id = kwargs['pid']
+        super(ProjectBuildsTable, self).setup_queryset(*args, **kwargs)
+
+        project = Project.objects.get(pk=self.project_id)
+        self.queryset = self.queryset.filter(project=project)
+
+    def get_context_data(self, **kwargs):
+        """
+        NOTE: self.project_id must be set before calling super(),
+        as it's used in get_context_data()
+        """
+        self.project_id = kwargs['pid']
+
+        context = super(ProjectBuildsTable, self).get_context_data(**kwargs)
+        context['project'] = Project.objects.get(pk=self.project_id)
+
+        return context
+
+    def get_builds(self):
+        """ override: only return builds for the relevant project """
+
+        project = Project.objects.get(pk=self.project_id)
+        return Build.objects.filter(project=project)
diff --git a/lib/toaster/toastergui/templates/baseprojectpage.html b/lib/toaster/toastergui/templates/baseprojectpage.html
index 1f45be4..b143b78 100644
--- a/lib/toaster/toastergui/templates/baseprojectpage.html
+++ b/lib/toaster/toastergui/templates/baseprojectpage.html
@@ -1,4 +1,5 @@
 {% extends "base.html" %}
+
 {% load projecttags %}
 {% load humanize %}
 
diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index 52b3f1a..2f4820c 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -6,7 +6,7 @@
 {%if mru and mru.count > 0%}
 
   {%if mrb_type == 'project' %}
-      <h2>
+      <h2 class="page-header">
       Latest project builds
 
       {% if project.is_default %}
diff --git a/lib/toaster/toastergui/templates/projectbuilds-toastertable.html b/lib/toaster/toastergui/templates/projectbuilds-toastertable.html
new file mode 100644
index 0000000..6d7e10b
--- /dev/null
+++ b/lib/toaster/toastergui/templates/projectbuilds-toastertable.html
@@ -0,0 +1,56 @@
+{% extends 'base.html' %}
+
+{% load static %}
+
+{% block extraheadcontent %}
+  <link rel="stylesheet" href="{% static 'css/jquery-ui.min.css' %}" type='text/css'>
+  <link rel="stylesheet" href="{% static 'css/jquery-ui.structure.min.css' %}" type='text/css'>
+  <link rel="stylesheet" href="{% static 'css/jquery-ui.theme.min.css' %}" type='text/css'>
+  <script src="{% static 'js/jquery-ui.min.js' %}">
+  </script>
+{% endblock %}
+
+{% block title %} {{title}} - {{project.name}} - Toaster {% endblock %}
+
+{% block pagecontent %}
+
+  {% include "projecttopbar.html" %}
+
+  <div class="row-fluid">
+    {% with mru=mru mrb_type=mrb_type %}
+      {% include 'mrb_section.html' %}
+    {% endwith %}
+
+    <h2 class="page-header top-air" data-role="page-title"></h2>
+
+    {% url 'projectbuilds' project.id as xhr_table_url %}
+    {% include 'toastertable.html' %}
+  </div>
+
+  <script>
+    $(document).ready(function () {
+      // title
+      var tableElt = $("#{{table_name}}");
+      var titleElt = $("[data-role='page-title']");
+
+      tableElt.on("table-done", function (e, total, tableParams) {
+        var title = "All project builds";
+
+        if (tableParams.search || tableParams.filter) {
+          if (total === 0) {
+            title = "No project builds found";
+          }
+          else if (total > 0) {
+            title = total + " project build" + (total > 1 ? 's' : '') + " found";
+          }
+        }
+
+        titleElt.text(title);
+      });
+
+      // highlight builds tab
+      $("#topbar-builds-tab").addClass("active")
+    });
+  </script>
+
+{% endblock %}
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 707b7d5..c8c1c6a 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -28,7 +28,7 @@ urlpatterns = patterns('toastergui.views',
         url(r'^landing/$', 'landing', name='landing'),
 
         url(r'^builds/$',
-            tables.BuildsTable.as_view(template_name="builds-toastertable.html"),
+            tables.AllBuildsTable.as_view(template_name="builds-toastertable.html"),
             name='all-builds'),
 
         # build info navigation
@@ -83,7 +83,9 @@ urlpatterns = patterns('toastergui.views',
 
         url(r'^project/(?P<pid>\d+)/$', 'project', name='project'),
         url(r'^project/(?P<pid>\d+)/configuration$', 'projectconf', name='projectconf'),
-        url(r'^project/(?P<pid>\d+)/builds/$', 'projectbuilds', name='projectbuilds'),
+        url(r'^project/(?P<pid>\d+)/builds/$',
+            tables.ProjectBuildsTable.as_view(template_name="projectbuilds-toastertable.html"),
+            name='projectbuilds'),
 
         # the import layer is a project-specific functionality;
         url(r'^project/(?P<pid>\d+)/importlayer$', 'importlayer', name='importlayer'),
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 295773f..fbae36c 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -91,6 +91,7 @@ def landing(request):
 
     return render(request, 'landing.html', context)
 
+"""
 # returns a list for most recent builds;
 def _get_latest_builds(prj=None):
     queryset = Build.objects.all()
@@ -101,8 +102,9 @@ def _get_latest_builds(prj=None):
     return list(itertools.chain(
         queryset.filter(outcome=Build.IN_PROGRESS).order_by("-started_on"),
         queryset.filter(outcome__lt=Build.IN_PROGRESS).order_by("-started_on")[:3] ))
+"""
 
-
+"""
 # a JSON-able dict of recent builds; for use in the Project page, xhr_ updates,  and other places, as needed
 def _project_recent_build_list(prj):
     data = []
@@ -131,8 +133,7 @@ def _project_recent_build_list(prj):
         data.append(d)
 
     return data
-
-
+"""
 
 def objtojson(obj):
     from django.db.models.query import QuerySet
@@ -1915,6 +1916,7 @@ if True:
         ''' The exception raised on invalid POST requests '''
         pass
 
+    """
     # helper function, to be used on "all builds" and "project builds" pages
     def _build_list_helper(request, queryset_all, redirect_page, pid=None):
         default_orderby = 'completed_on:-'
@@ -2119,6 +2121,7 @@ if True:
         # merge daterange values
         context.update(context_date)
         return context, pagesize, orderby
+    """
 
 
 
@@ -2256,7 +2259,7 @@ if True:
             "completedbuilds": Build.objects.exclude(outcome = Build.IN_PROGRESS).filter(project_id = pid),
             "prj" : {"name": prj.name, },
             "buildrequests" : prj.build_set.filter(outcome=Build.IN_PROGRESS),
-            "builds" : _project_recent_build_list(prj),
+            #"builds" : _project_recent_build_list(prj),
             "layers" :  map(lambda x: {
                         "id": x.layercommit.pk,
                         "orderid": x.pk,
@@ -2827,10 +2830,8 @@ if True:
     # will set the GET parameters and redirect back to the
     # all-builds or projectbuilds page as appropriate;
     # TODO don't use exceptions to control program flow
-    @_template_renderer('projectbuilds.html')
+    """
     def projectbuilds(request, pid):
-        prj = Project.objects.get(id = pid)
-
         if request.method == "POST":
             # process any build request
 
@@ -2880,6 +2881,7 @@ if True:
         context['mru'] = _get_latest_builds(prj)
 
         return context
+    """
 
 
     def _file_name_for_artifact(b, artifact_type, artifact_id):
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 47de30d..bc081b8 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -61,7 +61,6 @@ class ToasterTable(TemplateView):
 
         self.total_count = 0
         self.static_context_extra = {}
-        self.filter_actions = {}
         self.empty_state = "Sorry - no data found"
         self.default_orderby = ""
 
-- 
2.1.4


