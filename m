Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id A65CF7665F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:27 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 15 Jan 2016 04:58:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="881987213"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2016 04:58:28 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 0B9486A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:23 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:00:58 +0200
Message-Id: <39c56d946a077c7029ad8c4a188a4237a3d68bd5.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 15/23] toaster: toastergui: streamline construction of filter objects
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
X-List-Received-Date: Fri, 15 Jan 2016 12:58:27 -0000

From: Elliot Smith <elliot.smith@intel.com>

In line with comments from review, remove the QuerysetFilter
class (redundant) and convert ProjectFilters into a class
with static methods.

[YOCTO #8738]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/querysetfilter.py | 24 --------------------
 lib/toaster/toastergui/tablefilter.py    | 38 +++++++++++++-------------------
 lib/toaster/toastergui/tables.py         | 35 ++++++++++++++---------------
 lib/toaster/toastergui/widgets.py        |  1 -
 4 files changed, 32 insertions(+), 66 deletions(-)
 delete mode 100644 bitbake/lib/toaster/toastergui/querysetfilter.py

diff --git a/lib/toaster/toastergui/querysetfilter.py b/lib/toaster/toastergui/querysetfilter.py
deleted file mode 100644
index 10cc988..0000000
--- a/lib/toaster/toastergui/querysetfilter.py
+++ /dev/null
@@ -1,24 +0,0 @@
-class QuerysetFilter(object):
-    """ Filter for a queryset """
-
-    def __init__(self, criteria=None):
-        self.criteria = None
-        if criteria:
-            self.set_criteria(criteria)
-
-    def set_criteria(self, criteria):
-        """
-        criteria is an instance of django.db.models.Q;
-        see https://docs.djangoproject.com/en/1.9/ref/models/querysets/#q-objects
-        """
-        self.criteria = criteria
-
-    def filter(self, queryset):
-        """
-        Filter queryset according to the criteria for this filter,
-        returning the filtered queryset
-        """
-        if self.criteria:
-            return queryset.filter(self.criteria)
-        else:
-            return queryset
diff --git a/lib/toaster/toastergui/tablefilter.py b/lib/toaster/toastergui/tablefilter.py
index bd8decd..9d15bcf 100644
--- a/lib/toaster/toastergui/tablefilter.py
+++ b/lib/toaster/toastergui/tablefilter.py
@@ -22,7 +22,6 @@
 from django.db.models import Q, Max, Min
 from django.utils import dateparse, timezone
 from datetime import timedelta
-from querysetfilter import QuerysetFilter
 
 class TableFilter(object):
     """
@@ -118,10 +117,10 @@ class TableFilterAction(object):
     ToasterTable
     """
 
-    def __init__(self, name, title, queryset_filter):
+    def __init__(self, name, title, criteria):
         self.name = name
         self.title = title
-        self.queryset_filter = queryset_filter
+        self.criteria = criteria
 
         # set in subclasses
         self.type = None
@@ -132,11 +131,13 @@ class TableFilterAction(object):
         the structure of this string depends on the type of action;
         it's ignored for a toggle filter action, which is just on or off
         """
-        if not params:
-            return
+        pass
 
     def filter(self, queryset):
-        return self.queryset_filter.filter(queryset)
+        if self.criteria:
+            return queryset.filter(self.criteria)
+        else:
+            return queryset
 
     def to_json(self, queryset):
         """ Dump as a JSON object """
@@ -167,16 +168,12 @@ class TableFilterActionDay(TableFilterAction):
     YESTERDAY = 'yesterday'
 
     def __init__(self, name, title, field, day,
-    queryset_filter = QuerysetFilter(), query_helper = TableFilterQueryHelper()):
+    query_helper = TableFilterQueryHelper()):
         """
         field: (string) the datetime field to filter by
         day: (string) "today" or "yesterday"
         """
-        super(TableFilterActionDay, self).__init__(
-            name,
-            title,
-            queryset_filter
-        )
+        super(TableFilterActionDay, self).__init__(name, title, None)
         self.type = 'day'
         self.field = field
         self.day = day
@@ -189,8 +186,6 @@ class TableFilterActionDay(TableFilterAction):
         depending on when the filtering is applied
         """
 
-        criteria = None
-        date_str = None
         now = timezone.now()
 
         if self.day == self.YESTERDAY:
@@ -201,15 +196,13 @@ class TableFilterActionDay(TableFilterAction):
 
         wanted_date_str = wanted_date.strftime('%Y-%m-%d')
 
-        criteria = self.query_helper.dateStringsToQ(
+        self.criteria = self.query_helper.dateStringsToQ(
             self.field,
             wanted_date_str,
             wanted_date_str
         )
 
-        self.queryset_filter.set_criteria(criteria)
-
-        return self.queryset_filter.filter(queryset)
+        return queryset.filter(self.criteria)
 
 class TableFilterActionDateRange(TableFilterAction):
     """
@@ -218,14 +211,14 @@ class TableFilterActionDateRange(TableFilterAction):
     """
 
     def __init__(self, name, title, field,
-    queryset_filter = QuerysetFilter(), query_helper = TableFilterQueryHelper()):
+    query_helper = TableFilterQueryHelper()):
         """
         field: (string) the field to find the max/min range from in the queryset
         """
         super(TableFilterActionDateRange, self).__init__(
             name,
             title,
-            queryset_filter
+            None
         )
 
         self.type = 'daterange'
@@ -248,17 +241,16 @@ class TableFilterActionDateRange(TableFilterAction):
         try:
             date_from_str, date_to_str = params.split(',')
         except ValueError:
-            self.queryset_filter.set_criteria(None)
+            self.criteria = None
             return
 
         # one of the values required for the filter is missing, so set
         # it to the one which was supplied
-        criteria = self.query_helper.dateStringsToQ(
+        self.criteria = self.query_helper.dateStringsToQ(
             self.field,
             date_from_str,
             date_to_str
         )
-        self.queryset_filter.set_criteria(criteria)
 
     def to_json(self, queryset):
         """ Dump as a JSON object """
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index d0ed496..b7d977e 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -20,7 +20,6 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from toastergui.widgets import ToasterTable
-from toastergui.querysetfilter import QuerysetFilter
 from orm.models import Recipe, ProjectLayer, Layer_Version, Machine, Project
 from orm.models import CustomImageRecipe, Package, Build, LogMessage, Task
 from orm.models import ProjectTarget
@@ -37,9 +36,13 @@ from toastergui.tablefilter import TableFilterActionDateRange
 from toastergui.tablefilter import TableFilterActionDay
 
 class ProjectFilters(object):
-    def __init__(self, project_layers):
-        self.in_project = QuerysetFilter(Q(layer_version__in=project_layers))
-        self.not_in_project = QuerysetFilter(~Q(layer_version__in=project_layers))
+    @staticmethod
+    def in_project(project_layers):
+        return Q(layer_version__in=project_layers)
+
+    @staticmethod
+    def not_in_project(project_layers):
+        return ~(ProjectFilters.in_project(project_layers))
 
 class LayersTable(ToasterTable):
     """Table of layers in Toaster"""
@@ -71,13 +74,13 @@ class LayersTable(ToasterTable):
         in_project_action = TableFilterActionToggle(
             "in_project",
             "Layers added to this project",
-            QuerysetFilter(criteria)
+            criteria
         )
 
         not_in_project_action = TableFilterActionToggle(
             "not_in_project",
             "Layers not added to this project",
-            QuerysetFilter(~criteria)
+            ~criteria
         )
 
         in_current_project_filter.add_action(in_project_action)
@@ -217,8 +220,6 @@ class MachinesTable(ToasterTable):
     def setup_filters(self, *args, **kwargs):
         project = Project.objects.get(pk=kwargs['pid'])
 
-        project_filters = ProjectFilters(self.project_layers)
-
         in_current_project_filter = TableFilter(
             "in_current_project",
             "Filter by project machines"
@@ -227,13 +228,13 @@ class MachinesTable(ToasterTable):
         in_project_action = TableFilterActionToggle(
             "in_project",
             "Machines provided by layers added to this project",
-            project_filters.in_project
+            ProjectFilters.in_project(self.project_layers)
         )
 
         not_in_project_action = TableFilterActionToggle(
             "not_in_project",
             "Machines provided by layers not added to this project",
-            project_filters.not_in_project
+            ProjectFilters.not_in_project(self.project_layers)
         )
 
         in_current_project_filter.add_action(in_project_action)
@@ -350,8 +351,6 @@ class RecipesTable(ToasterTable):
         return context
 
     def setup_filters(self, *args, **kwargs):
-        project_filters = ProjectFilters(self.project_layers)
-
         table_filter = TableFilter(
             'in_current_project',
             'Filter by project recipes'
@@ -360,13 +359,13 @@ class RecipesTable(ToasterTable):
         in_project_action = TableFilterActionToggle(
             'in_project',
             'Recipes provided by layers added to this project',
-            project_filters.in_project
+            ProjectFilters.in_project(self.project_layers)
         )
 
         not_in_project_action = TableFilterActionToggle(
             'not_in_project',
             'Recipes provided by layers not added to this project',
-            project_filters.not_in_project
+            ProjectFilters.not_in_project(self.project_layers)
         )
 
         table_filter.add_action(in_project_action)
@@ -1140,13 +1139,13 @@ class BuildsTable(ToasterTable):
         successful_builds_action = TableFilterActionToggle(
             'successful_builds',
             'Successful builds',
-            QuerysetFilter(Q(outcome=Build.SUCCEEDED))
+            Q(outcome=Build.SUCCEEDED)
         )
 
         failed_builds_action = TableFilterActionToggle(
             'failed_builds',
             'Failed builds',
-            QuerysetFilter(Q(outcome=Build.FAILED))
+            Q(outcome=Build.FAILED)
         )
 
         outcome_filter.add_action(successful_builds_action)
@@ -1226,13 +1225,13 @@ class BuildsTable(ToasterTable):
         with_failed_tasks_action = TableFilterActionToggle(
             'with_failed_tasks',
             'Builds with failed tasks',
-            QuerysetFilter(criteria)
+            criteria
         )
 
         without_failed_tasks_action = TableFilterActionToggle(
             'without_failed_tasks',
             'Builds without failed tasks',
-            QuerysetFilter(~criteria)
+            ~criteria
         )
 
         failed_tasks_filter.add_action(with_failed_tasks_action)
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index bc081b8..d9328d4 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -32,7 +32,6 @@ from django.template import Context, Template
 from django.core.serializers.json import DjangoJSONEncoder
 from django.core.exceptions import FieldError
 from django.conf.urls import url, patterns
-from toastergui.querysetfilter import QuerysetFilter
 
 import types
 import json
-- 
2.1.4


