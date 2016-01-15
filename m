Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id A8E4B75894
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:17 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga104.fm.intel.com with ESMTP; 15 Jan 2016 04:58:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="893808828"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2016 04:58:18 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id C502C6A4006
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:14 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:00:50 +0200
Message-Id: <1ce78601176715503853b48e8e8e42ead72ef496.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 07/23] toaster: toastergui: refactor ToasterTable filtering
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
X-List-Received-Date: Fri, 15 Jan 2016 12:58:17 -0000

From: Elliot Smith <elliot.smith@intel.com>

The filter code for ToasterTable was difficult to follow
and inflexible (not allowing different types of filter, for example).

Refactor to a set of filter classes to make the structure cleaner
and provide the flexibility needed for other filter types
(e.g. date range filter).

[YOCTO #8738]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/querysetfilter.py  |   7 +-
 lib/toaster/toastergui/static/js/table.js |  80 +++++++++++++-----
 lib/toaster/toastergui/tablefilter.py     | 119 +++++++++++++++++++++++++++
 lib/toaster/toastergui/tables.py          | 132 ++++++++++++++++++++----------
 lib/toaster/toastergui/widgets.py         |  90 +++++++++-----------
 5 files changed, 310 insertions(+), 118 deletions(-)
 create mode 100644 bitbake/lib/toaster/toastergui/tablefilter.py

diff --git a/lib/toaster/toastergui/querysetfilter.py b/lib/toaster/toastergui/querysetfilter.py
index 62297e9..dbae239 100644
--- a/lib/toaster/toastergui/querysetfilter.py
+++ b/lib/toaster/toastergui/querysetfilter.py
@@ -5,7 +5,7 @@ class QuerysetFilter(object):
         if criteria:
             self.set_criteria(criteria)
 
-    def set_criteria(self, criteria):
+    def set_criteria(self, criteria = None):
         """
         criteria is an instance of django.db.models.Q;
         see https://docs.djangoproject.com/en/1.9/ref/models/querysets/#q-objects
@@ -17,7 +17,10 @@ class QuerysetFilter(object):
         Filter queryset according to the criteria for this filter,
         returning the filtered queryset
         """
-        return queryset.filter(self.criteria)
+        if self.criteria:
+            return queryset.filter(self.criteria)
+        else:
+            return queryset
 
     def count(self, queryset):
         """ Returns a count of the elements in the filtered queryset """
diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index c69c205..fa01ddf 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -415,38 +415,76 @@ function tableInit(ctx){
         data: params,
         headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
         success: function (filterData) {
-          var filterActionRadios = $('#filter-actions-'+ctx.tableName);
+          /*
+            filterData structure:
+
+            {
+              title: '<title for the filter popup>',
+              filter_actions: [
+                {
+                  title: '<label for radio button inside the popup>',
+                  name: '<name of the filter action>',
+                  count: <number of items this filter will show>
+                }
+              ]
+            }
 
-          $('#filter-modal-title-'+ctx.tableName).text(filterData.title);
+            each filter_action gets a radio button; the value of this is
+            set to filterName + ':' + filter_action.name; e.g.
 
-          filterActionRadios.text("");
+              in_current_project:in_project
 
-          for (var i in filterData.filter_actions){
-            var filterAction = filterData.filter_actions[i];
+            specifies the "in_project" action of the "in_current_project"
+            filter
 
-            var action = $('<label class="radio"><input type="radio" name="filter" value=""><span class="filter-title"></span></label>');
-            var actionTitle = filterAction.title + ' (' + filterAction.count + ')';
+            the filterName is set on the column filter icon, and corresponds
+            to a value in the table's filters property
 
-            var radioInput = action.children("input");
+            when the filter popup's "Apply" button is clicked, the
+            value for the radio button which is checked is passed in the
+            querystring and applied to the queryset on the table
+           */
 
-            if (Number(filterAction.count) == 0){
-              radioInput.attr("disabled", "disabled");
-            }
+          var filterActionRadios = $('#filter-actions-'+ctx.tableName);
 
-            action.children(".filter-title").text(actionTitle);
+          $('#filter-modal-title-'+ctx.tableName).text(filterData.title);
 
-            radioInput.val(filterName + ':' + filterAction.name);
+          filterActionRadios.text("");
 
-            /* Setup the current selected filter, default to 'all' if
-             * no current filter selected.
-             */
-            if ((tableParams.filter &&
-                tableParams.filter === radioInput.val()) ||
-                filterAction.name == 'all') {
-                radioInput.attr("checked", "checked");
+          for (var i in filterData.filter_actions) {
+            var filterAction = filterData.filter_actions[i];
+            var action = null;
+
+            if (filterAction.type === 'toggle') {
+              var actionTitle = filterAction.title + ' (' + filterAction.count + ')';
+
+              action = $('<label class="radio">' +
+                         '<input type="radio" name="filter" value="">' +
+                         '<span class="filter-title">' +
+                         actionTitle +
+                         '</span>' +
+                         '</label>');
+
+              var radioInput = action.children("input");
+              if (Number(filterAction.count) == 0) {
+                radioInput.attr("disabled", "disabled");
+              }
+
+              radioInput.val(filterData.name + ':' + filterAction.action_name);
+
+              /* Setup the current selected filter, default to 'all' if
+               * no current filter selected.
+               */
+              if ((tableParams.filter &&
+                  tableParams.filter === radioInput.val()) ||
+                  filterAction.action_name == 'all') {
+                  radioInput.attr("checked", "checked");
+              }
             }
 
-            filterActionRadios.append(action);
+            if (action) {
+              filterActionRadios.append(action);
+            }
           }
 
           $('#filter-modal-'+ctx.tableName).modal('show');
diff --git a/lib/toaster/toastergui/tablefilter.py b/lib/toaster/toastergui/tablefilter.py
new file mode 100644
index 0000000..b42fd52
--- /dev/null
+++ b/lib/toaster/toastergui/tablefilter.py
@@ -0,0 +1,119 @@
+#
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Toaster Implementation
+#
+# Copyright (C) 2015        Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+class TableFilter(object):
+    """
+    Stores a filter for a named field, and can retrieve the action
+    requested for that filter
+    """
+    def __init__(self, name, title):
+        self.name = name
+        self.title = title
+        self.__filter_action_map = {}
+
+    def add_action(self, action):
+        self.__filter_action_map[action.name] = action
+
+    def get_action(self, action_name):
+        return self.__filter_action_map[action_name]
+
+    def to_json(self, queryset):
+        """
+        Dump all filter actions as an object which can be JSON serialised;
+        this is used to generate the JSON for processing in
+        table.js / filterOpenClicked()
+        """
+        filter_actions = []
+
+        # add the "all" pseudo-filter action, which just selects the whole
+        # queryset
+        filter_actions.append({
+            'action_name' : 'all',
+            'title' : 'All',
+            'type': 'toggle',
+            'count' : queryset.count()
+        })
+
+        # add other filter actions
+        for action_name, filter_action in self.__filter_action_map.iteritems():
+            obj = filter_action.to_json(queryset)
+            obj['action_name'] = action_name
+            filter_actions.append(obj)
+
+        return {
+            'name': self.name,
+            'title': self.title,
+            'filter_actions': filter_actions
+        }
+
+class TableFilterActionToggle(object):
+    """
+    Stores a single filter action which will populate one radio button of
+    a ToasterTable filter popup; this filter can either be on or off and
+    has no other parameters
+    """
+
+    def __init__(self, name, title, queryset_filter):
+        self.name = name
+        self.title = title
+        self.__queryset_filter = queryset_filter
+        self.type = 'toggle'
+
+    def set_params(self, params):
+        """
+        params: (str) a string of extra parameters for the action;
+        the structure of this string depends on the type of action;
+        it's ignored for a toggle filter action, which is just on or off
+        """
+        pass
+
+    def filter(self, queryset):
+        return self.__queryset_filter.filter(queryset)
+
+    def to_json(self, queryset):
+        """ Dump as a JSON object """
+        return {
+            'title': self.title,
+            'type': self.type,
+            'count': self.__queryset_filter.count(queryset)
+        }
+
+class TableFilterMap(object):
+    """
+    Map from field names to Filter objects for those fields
+    """
+    def __init__(self):
+        self.__filters = {}
+
+    def add_filter(self, filter_name, table_filter):
+        """ table_filter is an instance of Filter """
+        self.__filters[filter_name] = table_filter
+
+    def get_filter(self, filter_name):
+        return self.__filters[filter_name]
+
+    def to_json(self, queryset):
+        data = {}
+
+        for filter_name, table_filter in self.__filters.iteritems():
+            data[filter_name] = table_filter.to_json()
+
+        return data
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 116cff3..a0991ec 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -28,6 +28,8 @@ from django.conf.urls import url
 from django.core.urlresolvers import reverse
 from django.views.generic import TemplateView
 
+from toastergui.tablefilter import TableFilter, TableFilterActionToggle
+
 class ProjectFilters(object):
     def __init__(self, project_layers):
         self.in_project = QuerysetFilter(Q(layer_version__in=project_layers))
@@ -53,16 +55,28 @@ class LayersTable(ToasterTable):
         project = Project.objects.get(pk=kwargs['pid'])
         self.project_layers = ProjectLayer.objects.filter(project=project)
 
+        in_current_project_filter = TableFilter(
+            "in_current_project",
+            "Filter by project layers"
+        )
+
         criteria = Q(projectlayer__in=self.project_layers)
-        in_project_filter = QuerysetFilter(criteria)
-        not_in_project_filter = QuerysetFilter(~criteria)
 
-        self.add_filter(title="Filter by project layers",
-                        name="in_current_project",
-                        filter_actions=[
-                            self.make_filter_action("in_project", "Layers added to this project", in_project_filter),
-                            self.make_filter_action("not_in_project", "Layers not added to this project", not_in_project_filter)
-                        ])
+        in_project_filter_action = TableFilterActionToggle(
+            "in_project",
+            "Layers added to this project",
+            QuerysetFilter(criteria)
+        )
+
+        not_in_project_filter_action = TableFilterActionToggle(
+            "not_in_project",
+            "Layers not added to this project",
+            QuerysetFilter(~criteria)
+        )
+
+        in_current_project_filter.add_action(in_project_filter_action)
+        in_current_project_filter.add_action(not_in_project_filter_action)
+        self.add_filter(in_current_project_filter)
 
     def setup_queryset(self, *args, **kwargs):
         prj = Project.objects.get(pk = kwargs['pid'])
@@ -199,12 +213,26 @@ class MachinesTable(ToasterTable):
 
         project_filters = ProjectFilters(self.project_layers)
 
-        self.add_filter(title="Filter by project machines",
-                        name="in_current_project",
-                        filter_actions=[
-                            self.make_filter_action("in_project", "Machines provided by layers added to this project", project_filters.in_project),
-                            self.make_filter_action("not_in_project", "Machines provided by layers not added to this project", project_filters.not_in_project)
-                        ])
+        in_current_project_filter = TableFilter(
+            "in_current_project",
+            "Filter by project machines"
+        )
+
+        in_project_filter_action = TableFilterActionToggle(
+            "in_project",
+            "Machines provided by layers added to this project",
+            project_filters.in_project
+        )
+
+        not_in_project_filter_action = TableFilterActionToggle(
+            "not_in_project",
+            "Machines provided by layers not added to this project",
+            project_filters.not_in_project
+        )
+
+        in_current_project_filter.add_action(in_project_filter_action)
+        in_current_project_filter.add_action(not_in_project_filter_action)
+        self.add_filter(in_current_project_filter)
 
     def setup_queryset(self, *args, **kwargs):
         prj = Project.objects.get(pk = kwargs['pid'])
@@ -318,12 +346,26 @@ class RecipesTable(ToasterTable):
     def setup_filters(self, *args, **kwargs):
         project_filters = ProjectFilters(self.project_layers)
 
-        self.add_filter(title="Filter by project recipes",
-                        name="in_current_project",
-                        filter_actions=[
-                            self.make_filter_action("in_project", "Recipes provided by layers added to this project", project_filters.in_project),
-                            self.make_filter_action("not_in_project", "Recipes provided by layers not added to this project", project_filters.not_in_project)
-                        ])
+        table_filter = TableFilter(
+            'in_current_project',
+            'Filter by project recipes'
+        )
+
+        in_project_filter_action = TableFilterActionToggle(
+            'in_project',
+            'Recipes provided by layers added to this project',
+            project_filters.in_project
+        )
+
+        not_in_project_filter_action = TableFilterActionToggle(
+            'not_in_project',
+            'Recipes provided by layers not added to this project',
+            project_filters.not_in_project
+        )
+
+        table_filter.add_action(in_project_filter_action)
+        table_filter.add_action(not_in_project_filter_action)
+        self.add_filter(table_filter)
 
     def setup_queryset(self, *args, **kwargs):
         prj = Project.objects.get(pk = kwargs['pid'])
@@ -1070,47 +1112,47 @@ class BuildsTable(ToasterTable):
 
     def setup_filters(self, *args, **kwargs):
         # outcomes
-        filter_only_successful_builds = QuerysetFilter(Q(outcome=Build.SUCCEEDED))
-        successful_builds_filter = self.make_filter_action(
+        outcome_filter = TableFilter(
+            'outcome_filter',
+            'Filter builds by outcome'
+        )
+
+        successful_builds_filter_action = TableFilterActionToggle(
             'successful_builds',
             'Successful builds',
-            filter_only_successful_builds
+            QuerysetFilter(Q(outcome=Build.SUCCEEDED))
         )
 
-        filter_only_failed_builds = QuerysetFilter(Q(outcome=Build.FAILED))
-        failed_builds_filter = self.make_filter_action(
+        failed_builds_filter_action = TableFilterActionToggle(
             'failed_builds',
             'Failed builds',
-            filter_only_failed_builds
+            QuerysetFilter(Q(outcome=Build.FAILED))
         )
 
-        self.add_filter(title='Filter builds by outcome',
-                        name='outcome_filter',
-                        filter_actions = [
-                            successful_builds_filter,
-                            failed_builds_filter
-                        ])
+        outcome_filter.add_action(successful_builds_filter_action)
+        outcome_filter.add_action(failed_builds_filter_action)
+        self.add_filter(outcome_filter)
 
         # failed tasks
+        failed_tasks_filter = TableFilter(
+            'failed_tasks_filter',
+            'Filter builds by failed tasks'
+        )
+
         criteria = Q(task_build__outcome=Task.OUTCOME_FAILED)
-        filter_only_builds_with_failed_tasks = QuerysetFilter(criteria)
-        with_failed_tasks_filter = self.make_filter_action(
+
+        with_failed_tasks_filter_action = TableFilterActionToggle(
             'with_failed_tasks',
             'Builds with failed tasks',
-            filter_only_builds_with_failed_tasks
+            QuerysetFilter(criteria)
         )
 
-        criteria = ~Q(task_build__outcome=Task.OUTCOME_FAILED)
-        filter_only_builds_without_failed_tasks = QuerysetFilter(criteria)
-        without_failed_tasks_filter = self.make_filter_action(
+        without_failed_tasks_filter_action = TableFilterActionToggle(
             'without_failed_tasks',
             'Builds without failed tasks',
-            filter_only_builds_without_failed_tasks
+            QuerysetFilter(~criteria)
         )
 
-        self.add_filter(title='Filter builds by failed tasks',
-                        name='failed_tasks_filter',
-                        filter_actions = [
-                            with_failed_tasks_filter,
-                            without_failed_tasks_filter
-                        ])
+        failed_tasks_filter.add_action(with_failed_tasks_filter_action)
+        failed_tasks_filter.add_action(without_failed_tasks_filter_action)
+        self.add_filter(failed_tasks_filter)
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 71b29ea..8790340 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -39,11 +39,13 @@ import json
 import collections
 import operator
 import re
+import urllib
 
 import logging
 logger = logging.getLogger("toaster")
 
 from toastergui.views import objtojson
+from toastergui.tablefilter import TableFilterMap
 
 class ToasterTable(TemplateView):
     def __init__(self, *args, **kwargs):
@@ -53,7 +55,10 @@ class ToasterTable(TemplateView):
         self.title = "Table"
         self.queryset = None
         self.columns = []
-        self.filters = {}
+
+        # map from field names to Filter instances
+        self.filter_map = TableFilterMap()
+
         self.total_count = 0
         self.static_context_extra = {}
         self.filter_actions = {}
@@ -66,7 +71,7 @@ class ToasterTable(TemplateView):
                         orderable=True,
                         field_name="id")
 
-        # prevent HTTP caching of table data
+    # prevent HTTP caching of table data
     @cache_control(must_revalidate=True, max_age=0, no_store=True, no_cache=True)
     def dispatch(self, *args, **kwargs):
         return super(ToasterTable, self).dispatch(*args, **kwargs)
@@ -108,27 +113,10 @@ class ToasterTable(TemplateView):
             self.apply_search(search)
 
         name = request.GET.get("name", None)
-        if name is None:
-            data = json.dumps(self.filters,
-                              indent=2,
-                              cls=DjangoJSONEncoder)
-        else:
-            for actions in self.filters[name]['filter_actions']:
-                queryset_filter = self.filter_actions[actions['name']]
-                actions['count'] = queryset_filter.count(self.queryset)
-
-            # Add the "All" items filter action
-            self.filters[name]['filter_actions'].insert(0, {
-                'name' : 'all',
-                'title' : 'All',
-                'count' : self.queryset.count(),
-            })
-
-            data = json.dumps(self.filters[name],
-                              indent=2,
-                              cls=DjangoJSONEncoder)
-
-            return data
+        table_filter = self.filter_map.get_filter(name)
+        return json.dumps(table_filter.to_json(self.queryset),
+                          indent=2,
+                          cls=DjangoJSONEncoder)
 
     def setup_columns(self, *args, **kwargs):
         """ function to implement in the subclass which sets up the columns """
@@ -140,33 +128,13 @@ class ToasterTable(TemplateView):
         """ function to implement in the subclass which sets up the queryset"""
         pass
 
-    def add_filter(self, name, title, filter_actions):
+    def add_filter(self, table_filter):
         """Add a filter to the table.
 
         Args:
-            name (str): Unique identifier of the filter.
-            title (str): Title of the filter.
-            filter_actions: Actions for all the filters.
+            table_filter: Filter instance
         """
-        self.filters[name] = {
-          'title' : title,
-          'filter_actions' : filter_actions,
-        }
-
-    def make_filter_action(self, name, title, queryset_filter):
-        """
-        Utility to make a filter_action; queryset_filter is an instance
-        of QuerysetFilter or a function
-        """
-
-        action = {
-          'title' : title,
-          'name' : name,
-        }
-
-        self.filter_actions[name] = queryset_filter
-
-        return action
+        self.filter_map.add_filter(table_filter.name, table_filter)
 
     def add_column(self, title="", help_text="",
                    orderable=False, hideable=True, hidden=False,
@@ -216,19 +184,41 @@ class ToasterTable(TemplateView):
         return template.render(context)
 
     def apply_filter(self, filters, **kwargs):
+        """
+        Apply a filter submitted in the querystring to the ToasterTable
+
+        filters: (str) in the format:
+          '<filter name>:<action name>!<action params>'
+        where <action params> is optional
+
+        <filter name> and <action name> are used to look up the correct filter
+        in the ToasterTable's filter map; the <action params> are set on
+        TableFilterAction* before its filter is applied and may modify the
+        queryset returned by the filter
+        """
         self.setup_filters(**kwargs)
 
         try:
-            filter_name, filter_action = filters.split(':')
+            filter_name, action_name_and_params = filters.split(':')
+
+            action_name = None
+            action_params = None
+            if re.search('!', action_name_and_params):
+                action_name, action_params = action_name_and_params.split('!')
+                action_params = urllib.unquote_plus(action_params)
+            else:
+                action_name = action_name_and_params
         except ValueError:
             return
 
-        if "all" in filter_action:
+        if "all" in action_name:
             return
 
         try:
-            queryset_filter = self.filter_actions[filter_action]
-            self.queryset = queryset_filter.filter(self.queryset)
+            table_filter = self.filter_map.get_filter(filter_name)
+            action = table_filter.get_action(action_name)
+            action.set_params(action_params)
+            self.queryset = action.filter(self.queryset)
         except KeyError:
             # pass it to the user - programming error here
             raise
-- 
2.1.4


