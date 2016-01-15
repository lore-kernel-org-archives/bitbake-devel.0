Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 82F1773232
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:16 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 15 Jan 2016 04:58:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="881987128"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2016 04:58:17 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id A75CD6A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:13 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:00:49 +0200
Message-Id: <6c6edb087013744c45df4fa9aa22590fbc8bc6df.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 06/23] toaster: toastergui: convert all builds page to ToasterTable
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
X-List-Received-Date: Fri, 15 Jan 2016 12:58:16 -0000

From: Elliot Smith <elliot.smith@intel.com>

For better long-term maintainability, use ToasterTable instead
of Django template and view code to display the all builds page.

NB the builds.html template has been left in, as this will
otherwise cause conflicts when merging the new theme.

[YOCTO #8738]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/orm/models.py                          |  32 +-
 lib/toaster/toastergui/querysetfilter.py           |  24 ++
 lib/toaster/toastergui/tables.py                   | 343 ++++++++++++++++++---
 .../toastergui/templates/builds-toastertable.html  |  62 ++++
 lib/toaster/toastergui/urls.py                     |   5 +-
 lib/toaster/toastergui/views.py                    |  32 --
 lib/toaster/toastergui/widgets.py                  |  16 +-
 7 files changed, 434 insertions(+), 80 deletions(-)
 create mode 100644 bitbake/lib/toaster/toastergui/querysetfilter.py
 create mode 100644 bitbake/lib/toaster/toastergui/templates/builds-toastertable.html

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index b7975ef..3dc4d6d 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -447,6 +447,12 @@ class Build(models.Model):
         return Build.BUILD_OUTCOME[int(self.outcome)][1]
 
     @property
+    def failed_tasks(self):
+        """ Get failed tasks for the build """
+        tasks = self.task_build.all()
+        return tasks.filter(order__gt=0, outcome=Task.OUTCOME_FAILED)
+
+    @property
     def errors(self):
         return (self.logmessage_set.filter(level=LogMessage.ERROR) |
                 self.logmessage_set.filter(level=LogMessage.EXCEPTION) |
@@ -457,8 +463,32 @@ class Build(models.Model):
         return self.logmessage_set.filter(level=LogMessage.WARNING)
 
     @property
+    def timespent(self):
+        return self.completed_on - self.started_on
+
+    @property
     def timespent_seconds(self):
-        return (self.completed_on - self.started_on).total_seconds()
+        return self.timespent.total_seconds()
+
+    @property
+    def target_labels(self):
+        """
+        Sorted (a-z) "target1:task, target2, target3" etc. string for all
+        targets in this build
+        """
+        targets = self.target_set.all()
+        target_labels = []
+        target_label = None
+
+        for target in targets:
+            target_label = target.target
+            if target.task:
+                target_label = target_label + ':' + target.task
+            target_labels.append(target_label)
+
+        target_labels.sort()
+
+        return target_labels
 
     def get_current_status(self):
         """
diff --git a/lib/toaster/toastergui/querysetfilter.py b/lib/toaster/toastergui/querysetfilter.py
new file mode 100644
index 0000000..62297e9
--- /dev/null
+++ b/lib/toaster/toastergui/querysetfilter.py
@@ -0,0 +1,24 @@
+class QuerysetFilter(object):
+    """ Filter for a queryset """
+
+    def __init__(self, criteria=None):
+        if criteria:
+            self.set_criteria(criteria)
+
+    def set_criteria(self, criteria):
+        """
+        criteria is an instance of django.db.models.Q;
+        see https://docs.djangoproject.com/en/1.9/ref/models/querysets/#q-objects
+        """
+        self.criteria = criteria
+
+    def filter(self, queryset):
+        """
+        Filter queryset according to the criteria for this filter,
+        returning the filtered queryset
+        """
+        return queryset.filter(self.criteria)
+
+    def count(self, queryset):
+        """ Returns a count of the elements in the filtered queryset """
+        return self.filter(queryset).count()
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 2e3c8a6..116cff3 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -20,29 +20,18 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from toastergui.widgets import ToasterTable
+from toastergui.querysetfilter import QuerysetFilter
 from orm.models import Recipe, ProjectLayer, Layer_Version, Machine, Project
-from orm.models import CustomImageRecipe, Package, Build
+from orm.models import CustomImageRecipe, Package, Build, LogMessage, Task
 from django.db.models import Q, Max, Count
 from django.conf.urls import url
 from django.core.urlresolvers import reverse
 from django.views.generic import TemplateView
 
-class ProjectFiltersMixin(object):
-    """Common mixin for recipe, machine in project filters"""
-
-    def filter_in_project(self, count_only=False):
-        query = self.queryset.filter(layer_version__in=self.project_layers)
-        if count_only:
-            return query.count()
-
-        self.queryset = query
-
-    def filter_not_in_project(self, count_only=False):
-        query = self.queryset.exclude(layer_version__in=self.project_layers)
-        if count_only:
-            return query.count()
-
-        self.queryset = query
+class ProjectFilters(object):
+    def __init__(self, project_layers):
+        self.in_project = QuerysetFilter(Q(layer_version__in=project_layers))
+        self.not_in_project = QuerysetFilter(~Q(layer_version__in=project_layers))
 
 class LayersTable(ToasterTable):
     """Table of layers in Toaster"""
@@ -60,34 +49,21 @@ class LayersTable(ToasterTable):
 
         return context
 
-
     def setup_filters(self, *args, **kwargs):
         project = Project.objects.get(pk=kwargs['pid'])
         self.project_layers = ProjectLayer.objects.filter(project=project)
 
+        criteria = Q(projectlayer__in=self.project_layers)
+        in_project_filter = QuerysetFilter(criteria)
+        not_in_project_filter = QuerysetFilter(~criteria)
 
         self.add_filter(title="Filter by project layers",
                         name="in_current_project",
                         filter_actions=[
-                            self.make_filter_action("in_project", "Layers added to this project", self.filter_in_project),
-                            self.make_filter_action("not_in_project", "Layers not added to this project", self.filter_not_in_project)
+                            self.make_filter_action("in_project", "Layers added to this project", in_project_filter),
+                            self.make_filter_action("not_in_project", "Layers not added to this project", not_in_project_filter)
                         ])
 
-    def filter_in_project(self, count_only=False):
-        query = self.queryset.filter(projectlayer__in=self.project_layers)
-        if count_only:
-            return query.count()
-
-        self.queryset = query
-
-    def filter_not_in_project(self, count_only=False):
-        query = self.queryset.exclude(projectlayer__in=self.project_layers)
-        if count_only:
-            return query.count()
-
-        self.queryset = query
-
-
     def setup_queryset(self, *args, **kwargs):
         prj = Project.objects.get(pk = kwargs['pid'])
         compatible_layers = prj.get_all_compatible_layer_versions()
@@ -204,7 +180,7 @@ class LayersTable(ToasterTable):
                         computation = lambda x: x.layer.name)
 
 
-class MachinesTable(ToasterTable, ProjectFiltersMixin):
+class MachinesTable(ToasterTable):
     """Table of Machines in Toaster"""
 
     def __init__(self, *args, **kwargs):
@@ -221,11 +197,13 @@ class MachinesTable(ToasterTable, ProjectFiltersMixin):
     def setup_filters(self, *args, **kwargs):
         project = Project.objects.get(pk=kwargs['pid'])
 
+        project_filters = ProjectFilters(self.project_layers)
+
         self.add_filter(title="Filter by project machines",
                         name="in_current_project",
                         filter_actions=[
-                            self.make_filter_action("in_project", "Machines provided by layers added to this project", self.filter_in_project),
-                            self.make_filter_action("not_in_project", "Machines provided by layers not added to this project", self.filter_not_in_project)
+                            self.make_filter_action("in_project", "Machines provided by layers added to this project", project_filters.in_project),
+                            self.make_filter_action("not_in_project", "Machines provided by layers not added to this project", project_filters.not_in_project)
                         ])
 
     def setup_queryset(self, *args, **kwargs):
@@ -313,7 +291,7 @@ class LayerMachinesTable(MachinesTable):
                         static_data_template=select_btn_template)
 
 
-class RecipesTable(ToasterTable, ProjectFiltersMixin):
+class RecipesTable(ToasterTable):
     """Table of All Recipes in Toaster"""
 
     def __init__(self, *args, **kwargs):
@@ -338,11 +316,13 @@ class RecipesTable(ToasterTable, ProjectFiltersMixin):
         return context
 
     def setup_filters(self, *args, **kwargs):
+        project_filters = ProjectFilters(self.project_layers)
+
         self.add_filter(title="Filter by project recipes",
                         name="in_current_project",
                         filter_actions=[
-                            self.make_filter_action("in_project", "Recipes provided by layers added to this project", self.filter_in_project),
-                            self.make_filter_action("not_in_project", "Recipes provided by layers not added to this project", self.filter_not_in_project)
+                            self.make_filter_action("in_project", "Recipes provided by layers added to this project", project_filters.in_project),
+                            self.make_filter_action("not_in_project", "Recipes provided by layers not added to this project", project_filters.not_in_project)
                         ])
 
     def setup_queryset(self, *args, **kwargs):
@@ -853,3 +833,284 @@ class ProjectsTable(ToasterTable):
                         orderable=False,
                         static_data_name='image_files',
                         static_data_template=image_files_template)
+
+class BuildsTable(ToasterTable):
+    """Table of builds in Toaster"""
+
+    def __init__(self, *args, **kwargs):
+        super(BuildsTable, self).__init__(*args, **kwargs)
+        self.default_orderby = '-completed_on'
+        self.title = 'All builds'
+        self.static_context_extra['Build'] = Build
+        self.static_context_extra['Task'] = Task
+
+    def get_context_data(self, **kwargs):
+        return super(BuildsTable, self).get_context_data(**kwargs)
+
+    def setup_queryset(self, *args, **kwargs):
+        queryset = Build.objects.all()
+
+        # don't include in progress builds
+        queryset = queryset.exclude(outcome=Build.IN_PROGRESS)
+
+        # sort
+        queryset = queryset.order_by(self.default_orderby)
+
+        # annotate with number of ERROR and EXCEPTION log messages
+        queryset = queryset.annotate(
+            errors_no = Count(
+                'logmessage',
+                only = Q(logmessage__level=LogMessage.ERROR) |
+                       Q(logmessage__level=LogMessage.EXCEPTION)
+            )
+        )
+
+        # annotate with number of WARNING log messages
+        queryset = queryset.annotate(
+            warnings_no = Count(
+                'logmessage',
+                only = Q(logmessage__level=LogMessage.WARNING)
+            )
+        )
+
+        self.queryset = queryset
+
+    def setup_columns(self, *args, **kwargs):
+        outcome_template = '''
+        <a href="{% url "builddashboard" data.id %}">
+            {% if data.outcome == data.SUCCEEDED %}
+                <i class="icon-ok-sign success"></i>
+            {% elif data.outcome == data.FAILED %}
+                <i class="icon-minus-sign error"></i>
+            {% endif %}
+        </a>
+
+        {% if data.cooker_log_path %}
+            &nbsp;
+            <a href="{% url "build_artifact" data.id "cookerlog" data.id %}">
+               <i class="icon-download-alt" title="Download build log"></i>
+            </a>
+        {% endif %}
+        '''
+
+        recipe_template = '''
+        {% for target_label in data.target_labels %}
+            <a href="{% url "builddashboard" data.id %}">
+                {{target_label}}
+            </a>
+            <br />
+        {% endfor %}
+        '''
+
+        machine_template = '''
+        <a href="{% url "builddashboard" data.id %}">
+            {{data.machine}}
+        </a>
+        '''
+
+        started_on_template = '''
+        <a href="{% url "builddashboard" data.id %}">
+            {{data.started_on | date:"d/m/y H:i"}}
+        </a>
+        '''
+
+        completed_on_template = '''
+        <a href="{% url "builddashboard" data.id %}">
+            {{data.completed_on | date:"d/m/y H:i"}}
+        </a>
+        '''
+
+        failed_tasks_template = '''
+        {% if data.failed_tasks.count == 1 %}
+            <a href="{% url "task" data.id data.failed_tasks.0.id %}">
+                <span class="error">
+                    {{data.failed_tasks.0.recipe.name}}.{{data.failed_tasks.0.task_name}}
+                </span>
+            </a>
+            <a href="{% url "build_artifact" data.id "tasklogfile" data.failed_tasks.0.id %}">
+                <i class="icon-download-alt"
+                   data-original-title="Download task log file">
+                </i>
+            </a>
+        {% elif data.failed_tasks.count > 1 %}
+            <a href="{% url "tasks" data.id %}?filter=outcome%3A{{extra.Task.OUTCOME_FAILED}}">
+                <span class="error">{{data.failed_tasks.count}} tasks</span>
+            </a>
+        {% endif %}
+        '''
+
+        errors_template = '''
+        {% if data.errors.count %}
+            <a class="errors.count error" href="{% url "builddashboard" data.id %}#errors">
+                {{data.errors.count}} error{{data.errors.count|pluralize}}
+            </a>
+        {% endif %}
+        '''
+
+        warnings_template = '''
+        {% if data.warnings.count %}
+            <a class="warnings.count warning" href="{% url "builddashboard" data.id %}#warnings">
+                {{data.warnings.count}} warning{{data.warnings.count|pluralize}}
+            </a>
+        {% endif %}
+        '''
+
+        time_template = '''
+        {% load projecttags %}
+        <a href="{% url "buildtime" data.id %}">
+            {{data.timespent_seconds | sectohms}}
+        </a>
+        '''
+
+        image_files_template = '''
+        {% if data.outcome == extra.Build.SUCCEEDED %}
+          <a href="{% url "builddashboard" data.id %}#images">
+            {{data.get_image_file_extensions}}
+          </a>
+        {% endif %}
+        '''
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
+        self.add_column(title='Outcome',
+                        help_text='Final state of the build (successful \
+                                   or failed)',
+                        hideable=False,
+                        orderable=True,
+                        filter_name='outcome_filter',
+                        static_data_name='outcome',
+                        static_data_template=outcome_template)
+
+        self.add_column(title='Recipe',
+                        help_text='What was built (i.e. one or more recipes \
+                                   or image recipes)',
+                        hideable=False,
+                        orderable=False,
+                        static_data_name='target',
+                        static_data_template=recipe_template)
+
+        self.add_column(title='Machine',
+                        help_text='Hardware for which you are building a \
+                                   recipe or image recipe',
+                        hideable=False,
+                        orderable=True,
+                        static_data_name='machine',
+                        static_data_template=machine_template)
+
+        self.add_column(title='Started on',
+                        help_text='The date and time when the build started',
+                        hideable=True,
+                        orderable=True,
+                        static_data_name='started_on',
+                        static_data_template=started_on_template)
+
+        self.add_column(title='Completed on',
+                        help_text='The date and time when the build finished',
+                        hideable=False,
+                        orderable=True,
+                        static_data_name='completed_on',
+                        static_data_template=completed_on_template)
+
+        self.add_column(title='Failed tasks',
+                        help_text='The number of tasks which failed during \
+                                   the build',
+                        hideable=True,
+                        orderable=False,
+                        filter_name='failed_tasks_filter',
+                        static_data_name='failed_tasks',
+                        static_data_template=failed_tasks_template)
+
+        self.add_column(title='Errors',
+                        help_text='The number of errors encountered during \
+                                   the build (if any)',
+                        hideable=True,
+                        orderable=False,
+                        static_data_name='errors',
+                        static_data_template=errors_template)
+
+        self.add_column(title='Warnings',
+                        help_text='The number of warnings encountered during \
+                                   the build (if any)',
+                        hideable=True,
+                        orderable=False,
+                        static_data_name='warnings',
+                        static_data_template=warnings_template)
+
+        self.add_column(title='Time',
+                        help_text='How long the build took to finish',
+                        hideable=False,
+                        orderable=False,
+                        static_data_name='time',
+                        static_data_template=time_template)
+
+        self.add_column(title='Image files',
+                        help_text='The root file system types produced by \
+                                   the build',
+                        hideable=True,
+                        orderable=False,
+                        static_data_name='image_files',
+                        static_data_template=image_files_template)
+
+        self.add_column(title='Project',
+                        hideable=True,
+                        orderable=False,
+                        static_data_name='project-name',
+                        static_data_template=project_template)
+
+    def setup_filters(self, *args, **kwargs):
+        # outcomes
+        filter_only_successful_builds = QuerysetFilter(Q(outcome=Build.SUCCEEDED))
+        successful_builds_filter = self.make_filter_action(
+            'successful_builds',
+            'Successful builds',
+            filter_only_successful_builds
+        )
+
+        filter_only_failed_builds = QuerysetFilter(Q(outcome=Build.FAILED))
+        failed_builds_filter = self.make_filter_action(
+            'failed_builds',
+            'Failed builds',
+            filter_only_failed_builds
+        )
+
+        self.add_filter(title='Filter builds by outcome',
+                        name='outcome_filter',
+                        filter_actions = [
+                            successful_builds_filter,
+                            failed_builds_filter
+                        ])
+
+        # failed tasks
+        criteria = Q(task_build__outcome=Task.OUTCOME_FAILED)
+        filter_only_builds_with_failed_tasks = QuerysetFilter(criteria)
+        with_failed_tasks_filter = self.make_filter_action(
+            'with_failed_tasks',
+            'Builds with failed tasks',
+            filter_only_builds_with_failed_tasks
+        )
+
+        criteria = ~Q(task_build__outcome=Task.OUTCOME_FAILED)
+        filter_only_builds_without_failed_tasks = QuerysetFilter(criteria)
+        without_failed_tasks_filter = self.make_filter_action(
+            'without_failed_tasks',
+            'Builds without failed tasks',
+            filter_only_builds_without_failed_tasks
+        )
+
+        self.add_filter(title='Filter builds by failed tasks',
+                        name='failed_tasks_filter',
+                        filter_actions = [
+                            with_failed_tasks_filter,
+                            without_failed_tasks_filter
+                        ])
diff --git a/lib/toaster/toastergui/templates/builds-toastertable.html b/lib/toaster/toastergui/templates/builds-toastertable.html
new file mode 100644
index 0000000..419d2b5
--- /dev/null
+++ b/lib/toaster/toastergui/templates/builds-toastertable.html
@@ -0,0 +1,62 @@
+{% extends 'base.html' %}
+
+{% block title %} All builds - Toaster {% endblock %}
+
+{% block pagecontent %}
+  <div class="page-header top-air">
+    <h1 data-role="page-title"></h1>
+  </div>
+
+  <div class="row-fluid">
+    {# TODO need to pass this data to context #}
+    {#% include 'mrb_section.html' %#}
+
+    {% url 'builds' as xhr_table_url %}
+    {% include 'toastertable.html' %}
+  </div>
+
+  <script>
+    $(document).ready(function () {
+      var tableElt = $("#{{table_name}}");
+      var titleElt = $("[data-role='page-title']");
+
+      tableElt.on("table-done", function (e, total, tableParams) {
+        var title = "All builds";
+
+        if (tableParams.search || tableParams.filter) {
+          if (total === 0) {
+            title = "No builds found";
+          }
+          else if (total > 0) {
+            title = total + " build" + (total > 1 ? 's' : '') + " found";
+          }
+        }
+
+        titleElt.text(title);
+      });
+
+      /* {% if last_date_from and last_date_to %}
+      // TODO initialize the date range controls;
+      // this will need to be added via ToasterTable
+      date_init(
+        "started_on",
+        "{{last_date_from}}",
+        "{{last_date_to}}",
+        "{{dateMin_started_on}}",
+        "{{dateMax_started_on}}",
+        "{{daterange_selected}}"
+      );
+
+      date_init(
+        "completed_on",
+        "{{last_date_from}}",
+        "{{last_date_to}}",
+        "{{dateMin_completed_on}}",
+        "{{dateMax_completed_on}}",
+        "{{daterange_selected}}"
+      );
+      {% endif %}
+      */
+    });
+  </script>
+{% endblock %}
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index b5e9a05..707b7d5 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -27,7 +27,10 @@ urlpatterns = patterns('toastergui.views',
         # landing page
         url(r'^landing/$', 'landing', name='landing'),
 
-        url(r'^builds/$', 'builds', name='all-builds'),
+        url(r'^builds/$',
+            tables.BuildsTable.as_view(template_name="builds-toastertable.html"),
+            name='all-builds'),
+
         # build info navigation
         url(r'^build/(?P<build_id>\d+)$', 'builddashboard', name="builddashboard"),
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index a79261d..295773f 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1915,34 +1915,6 @@ if True:
         ''' The exception raised on invalid POST requests '''
         pass
 
-    # shows the "all builds" page for managed mode; it displays build requests (at least started!) instead of actual builds
-    # WARNING _build_list_helper() may raise a RedirectException, which
-    # will set the GET parameters and redirect back to the
-    # all-builds or projectbuilds page as appropriate;
-    # TODO don't use exceptions to control program flow
-    @_template_renderer("builds.html")
-    def builds(request):
-        # define here what parameters the view needs in the GET portion in order to
-        # be able to display something.  'count' and 'page' are mandatory for all views
-        # that use paginators.
-
-        queryset = Build.objects.all()
-
-        redirect_page = resolve(request.path_info).url_name
-
-        context, pagesize, orderby = _build_list_helper(request,
-                                                        queryset,
-                                                        redirect_page)
-        # all builds page as a Project column
-        context['tablecols'].append({
-            'name': 'Project',
-            'clclass': 'project_column'
-        })
-
-        _set_parameters_values(pagesize, orderby, request)
-        return context
-
-
     # helper function, to be used on "all builds" and "project builds" pages
     def _build_list_helper(request, queryset_all, redirect_page, pid=None):
         default_orderby = 'completed_on:-'
@@ -1986,10 +1958,6 @@ if True:
             warnings_no = Count('logmessage', only=q_warnings)
         )
 
-        # add timespent field
-        timespent = 'completed_on - started_on'
-        queryset_all = queryset_all.extra(select={'timespent': timespent})
-
         queryset_with_search = _get_queryset(Build, queryset_all,
                                              None, search_term,
                                              ordering_string, '-completed_on')
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 6bb3889..71b29ea 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -32,6 +32,7 @@ from django.template import Context, Template
 from django.core.serializers.json import DjangoJSONEncoder
 from django.core.exceptions import FieldError
 from django.conf.urls import url, patterns
+from toastergui.querysetfilter import QuerysetFilter
 
 import types
 import json
@@ -113,7 +114,8 @@ class ToasterTable(TemplateView):
                               cls=DjangoJSONEncoder)
         else:
             for actions in self.filters[name]['filter_actions']:
-                actions['count'] = self.filter_actions[actions['name']](count_only=True)
+                queryset_filter = self.filter_actions[actions['name']]
+                actions['count'] = queryset_filter.count(self.queryset)
 
             # Add the "All" items filter action
             self.filters[name]['filter_actions'].insert(0, {
@@ -151,15 +153,18 @@ class ToasterTable(TemplateView):
           'filter_actions' : filter_actions,
         }
 
-    def make_filter_action(self, name, title, action_function):
-        """ Utility to make a filter_action """
+    def make_filter_action(self, name, title, queryset_filter):
+        """
+        Utility to make a filter_action; queryset_filter is an instance
+        of QuerysetFilter or a function
+        """
 
         action = {
           'title' : title,
           'name' : name,
         }
 
-        self.filter_actions[name] = action_function
+        self.filter_actions[name] = queryset_filter
 
         return action
 
@@ -222,7 +227,8 @@ class ToasterTable(TemplateView):
             return
 
         try:
-            self.filter_actions[filter_action]()
+            queryset_filter = self.filter_actions[filter_action]
+            self.queryset = queryset_filter.filter(self.queryset)
         except KeyError:
             # pass it to the user - programming error here
             raise
-- 
2.1.4


