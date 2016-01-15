Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 7CA1373212
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:11 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 15 Jan 2016 04:58:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="881987091"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2016 04:58:12 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 151C16A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:07 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:00:44 +0200
Message-Id: <8ad398a5ea04aaa8ef8a90b125c5f3b288e58a76.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 01/23] toaster: toastergui: use ToasterTable for projects page
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
X-List-Received-Date: Fri, 15 Jan 2016 12:58:11 -0000

From: Elliot Smith <elliot.smith@intel.com>

The projects page uses the old approach for showing tables,
which means a template for each table. This means that applying
changes to ToasterTable (which is used for most tables) has
no effect on the layout, styling and behaviour for these older
tables, and requires additional duplicated effort.

Move the projects page to use ToasterTable instead, to remove
the duplication of effort.

[YOCTO #8738]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/tables.py                   | 226 ++++++++++++++++++++-
 .../templates/projects-toastertable.html           |  36 ++++
 lib/toaster/toastergui/urls.py                     |   6 +
 3 files changed, 265 insertions(+), 3 deletions(-)
 create mode 100644 bitbake/lib/toaster/toastergui/templates/projects-toastertable.html

diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 3808820..e5cab48 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -21,13 +21,12 @@
 
 from toastergui.widgets import ToasterTable
 from orm.models import Recipe, ProjectLayer, Layer_Version, Machine, Project
-from orm.models import CustomImageRecipe, Package
-from django.db.models import Q, Max
+from orm.models import CustomImageRecipe, Package, Build
+from django.db.models import Q, Max, Count
 from django.conf.urls import url
 from django.core.urlresolvers import reverse
 from django.views.generic import TemplateView
 
-
 class ProjectFiltersMixin(object):
     """Common mixin for recipe, machine in project filters"""
 
@@ -633,3 +632,224 @@ class SelectPackagesTable(ToasterTable):
                         "the package content of you custom image",
                         static_data_name="add_rm_pkg_btn",
                         static_data_template='{% include "pkg_add_rm_btn.html" %}')
+
+class ProjectsTable(ToasterTable):
+    """Table of projects in Toaster"""
+
+    def __init__(self, *args, **kwargs):
+        super(ProjectsTable, self).__init__(*args, **kwargs)
+        self.default_orderby = 'updated'
+        self.title = 'All projects'
+        self.static_context_extra['Build'] = Build
+
+    def get_context_data(self, **kwargs):
+        return super(ProjectsTable, self).get_context_data(**kwargs)
+
+    def setup_queryset(self, *args, **kwargs):
+        queryset = Project.objects.all()
+
+        # annotate each project with its number of builds
+        queryset = queryset.annotate(num_builds=Count('build'))
+
+        # exclude the command line builds project if it has no builds
+        q_default_with_builds = Q(is_default=True) & Q(num_builds__gt=0)
+        queryset = queryset.filter(Q(is_default=False) |
+                                   q_default_with_builds)
+
+        # order rows
+        queryset = queryset.order_by(self.default_orderby)
+
+        self.queryset = queryset
+
+    # columns: last activity on (updated) - DEFAULT, project (name), release, machine, number of builds, last build outcome, recipe (name), errors, warnings, image files
+    def setup_columns(self, *args, **kwargs):
+        name_template = '''
+        {% load project_url_tag %}
+        <span data-project-field="name">
+          <a href="{% project_url data %}">
+            {{data.name}}
+          </a>
+        </span>
+        '''
+
+        last_activity_on_template = '''
+        {% load project_url_tag %}
+        <span data-project-field="updated">
+          <a href="{% project_url data %}">
+            {{data.updated | date:"d/m/y H:i"}}
+          </a>
+        </span>
+        '''
+
+        release_template = '''
+        <span data-project-field="release">
+          {% if data.release %}
+            <a href="{% url 'project' data.id %}#project-details">
+                {{data.release.name}}
+            </a>
+          {% elif data.is_default %}
+            <span class="muted">Not applicable</span>
+            <i class="icon-question-sign get-help hover-help"
+               data-original-title="This project does not have a release set.
+               It simply collects information about the builds you start from
+               the command line while Toaster is running"
+               style="visibility: hidden;">
+            </i>
+          {% else %}
+            No release available
+          {% endif %}
+        </span>
+        '''
+
+        machine_template = '''
+        <span data-project-field="machine">
+          {% if data.is_default %}
+            <span class="muted">Not applicable</span>
+            <i class="icon-question-sign get-help hover-help"
+               data-original-title="This project does not have a machine
+               set. It simply collects information about the builds you
+               start from the command line while Toaster is running"
+               style="visibility: hidden;"></i>
+          {% else %}
+            <a href="{% url 'project' data.id %}#machine-distro">
+              {{data.get_current_machine_name}}
+            </a>
+          {% endif %}
+        </span>
+        '''
+
+        number_of_builds_template = '''
+        {% if data.get_number_of_builds > 0 %}
+          <a href="{% url 'projectbuilds' data.id %}">
+            {{data.get_number_of_builds}}
+          </a>
+        {% else %}
+          <span class="muted">0</span>
+        {% endif %}
+        '''
+
+        last_build_outcome_template = '''
+        {% if data.get_number_of_builds > 0 %}
+          <a href="{% url 'builddashboard' data.get_last_build_id %}">
+            {% if data.get_last_outcome == extra.Build.SUCCEEDED %}
+              <i class="icon-ok-sign success"></i>
+            {% elif data.get_last_outcome == extra.Build.FAILED %}
+              <i class="icon-minus-sign error"></i>
+            {% endif %}
+          </a>
+        {% endif %}
+        '''
+
+        recipe_template = '''
+        {% if data.get_number_of_builds > 0 %}
+          <a href="{% url "builddashboard" data.get_last_build_id %}">
+            {{data.get_last_target}}
+          </a>
+        {% endif %}
+        '''
+
+        errors_template = '''
+        {% if data.get_number_of_builds > 0 %}
+          <a class="errors.count error"
+             href="{% url "builddashboard" data.get_last_build_id %}#errors">
+            {{data.get_last_errors}} error{{data.get_last_errors | pluralize}}
+          </a>
+        {% endif %}
+        '''
+
+        warnings_template = '''
+        {% if data.get_number_of_builds > 0 %}
+          <a class="warnings.count warning"
+             href="{% url "builddashboard" data.get_last_build_id %}#warnings">
+            {{data.get_last_warnings}} warning{{data.get_last_warnings | pluralize}}
+          </a>
+        {% endif %}
+        '''
+
+        image_files_template = '''
+        {% load projecttags %}
+        {% if data.get_number_of_builds > 0 and data.get_last_outcome == extra.Build.SUCCEEDED %}
+          <a href="{% url "builddashboard" data.get_last_build_id %}#images">
+            {{fstypes | get_dict_value:data.id}}
+          </a>
+        {% endif %}
+        '''
+
+        self.add_column(title='Project',
+                        hideable=False,
+                        orderable=True,
+                        static_data_name='name',
+                        static_data_template=name_template)
+
+        self.add_column(title='Last activity on',
+                        help_text='Starting date and time of the \
+                                   last project build. If the project has no \
+                                   builds, this shows the date the project was \
+                                   created.',
+                        hideable=True,
+                        orderable=True,
+                        static_data_name='updated',
+                        static_data_template=last_activity_on_template)
+
+        self.add_column(title='Release',
+                        help_text='The version of the build system used by \
+                                   the project',
+                        hideable=False,
+                        orderable=True,
+                        static_data_name='release',
+                        static_data_template=release_template)
+
+        self.add_column(title='Machine',
+                        help_text='The hardware currently selected for the \
+                                   project',
+                        hideable=False,
+                        orderable=False,
+                        static_data_name='machine',
+                        static_data_template=machine_template)
+
+        self.add_column(title='Number of builds',
+                        help_text='The number of builds which have been run \
+                                   for the project',
+                        hideable=True,
+                        orderable=False,
+                        static_data_name='number_of_builds',
+                        static_data_template=number_of_builds_template)
+
+        self.add_column(title='Last build outcome',
+                        help_text='Indicates whether the last project build \
+                                   completed successfully or failed',
+                        hideable=True,
+                        orderable=False,
+                        static_data_name='last_build_outcome',
+                        static_data_template=last_build_outcome_template)
+
+        self.add_column(title='Recipe',
+                        help_text='The last recipe which was built in this \
+                                   project',
+                        hideable=True,
+                        orderable=False,
+                        static_data_name='recipe_name',
+                        static_data_template=recipe_template)
+
+        self.add_column(title='Errors',
+                        help_text='The number of errors encountered during \
+                                   the last project build (if any)',
+                        hideable=True,
+                        orderable=False,
+                        static_data_name='errors',
+                        static_data_template=errors_template)
+
+        self.add_column(title='Warnings',
+                        help_text='The number of warnings encountered during \
+                                   the last project build (if any)',
+                        hideable=True,
+                        orderable=False,
+                        static_data_name='warnings',
+                        static_data_template=warnings_template)
+
+        self.add_column(title='Image files',
+                        help_text='',
+                        hideable=True,
+                        orderable=False,
+                        static_data_name='image_files',
+                        static_data_template=image_files_template)
diff --git a/lib/toaster/toastergui/templates/projects-toastertable.html b/lib/toaster/toastergui/templates/projects-toastertable.html
new file mode 100644
index 0000000..5814f32
--- /dev/null
+++ b/lib/toaster/toastergui/templates/projects-toastertable.html
@@ -0,0 +1,36 @@
+{% extends 'base.html' %}
+
+{% block title %} All projects - Toaster {% endblock %}
+
+{% block pagecontent %}
+
+  <div class="page-header top-air">
+    <h1 data-role="page-title"></h1>
+  </div>
+
+  {% url 'projects' as xhr_table_url %}
+  {% include 'toastertable.html' %}
+
+  <script>
+    $(document).ready(function () {
+      var tableElt = $("#{{table_name}}");
+      var titleElt = $("[data-role='page-title']");
+
+      tableElt.on("table-done", function (e, total, tableParams) {
+        var title = "All projects";
+
+        if (tableParams.search || tableParams.filter) {
+          if (total === 0) {
+            title = "No projects found";
+          }
+          else if (total > 0) {
+            title = total + " project" + (total > 1 ? 's' : '') + " found";
+          }
+        }
+
+        titleElt.text(title);
+      });
+    });
+  </script>
+
+{% endblock %}
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 2bf2d99..da97a31 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -75,8 +75,14 @@ urlpatterns = patterns('toastergui.views',
         url(r'^newproject/$', 'newproject', name='newproject'),
 
 
+        # TODO remove when new toaster table is ready
         url(r'^projects/$', 'projects', name='all-projects'),
 
+        # TODO move to /projects/ when new toaster table is ready
+        url(r'^projects-new/$',
+            tables.ProjectsTable.as_view(template_name="projects-toastertable.html"),
+            name='all-projects-new'),
+
         url(r'^project/(?P<pid>\d+)/$', 'project', name='project'),
         url(r'^project/(?P<pid>\d+)/configuration$', 'projectconf', name='projectconf'),
         url(r'^project/(?P<pid>\d+)/builds/$', 'projectbuilds', name='projectbuilds'),
-- 
2.1.4


