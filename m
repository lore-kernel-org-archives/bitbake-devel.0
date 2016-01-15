Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 488C275CF1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:22 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga104.fm.intel.com with ESMTP; 15 Jan 2016 04:58:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="893808862"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2016 04:58:23 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 702CD6A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:19 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:00:54 +0200
Message-Id: <170f63a5d847febd2461faaba7c2f3c54569cd18.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 11/23] toaster: toastergui: implement "today" and "yesterday" filters
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
X-List-Received-Date: Fri, 15 Jan 2016 12:58:22 -0000

From: Elliot Smith <elliot.smith@intel.com>

Add the "today" and "yesterday" filters to the started_on
and completed_on columns in the builds table.

During this work, some minor adjustments were made to the
behaviour of the builds table:

* Amend filter action variable names so they're more succinct.
* Retain order in which actions are added to a filter, as this
ordering is used in the UI when displaying the filter actions.
* Always show the table chrome, otherwise it's not possible
to edit the columns shown until there are 10 or more results.
* Because date range searches may return no results, make sure
that the search bar and "show all results" link are visible
when the query returns no results.

[YOCTO #8738]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/querysetfilter.py           |   4 -
 lib/toaster/toastergui/static/js/table.js          |  56 +++++----
 lib/toaster/toastergui/tablefilter.py              | 140 +++++++++++++++++----
 lib/toaster/toastergui/tables.py                   |  87 ++++++++-----
 .../toastergui/templates/builds-toastertable.html  |   2 +-
 lib/toaster/toastergui/templates/toastertable.html |   7 +-
 6 files changed, 212 insertions(+), 84 deletions(-)

diff --git a/lib/toaster/toastergui/querysetfilter.py b/lib/toaster/toastergui/querysetfilter.py
index efa8507..10cc988 100644
--- a/lib/toaster/toastergui/querysetfilter.py
+++ b/lib/toaster/toastergui/querysetfilter.py
@@ -22,7 +22,3 @@ class QuerysetFilter(object):
             return queryset.filter(self.criteria)
         else:
             return queryset
-
-    def count(self, queryset):
-        """ Returns a count of the elements in the filtered queryset """
-        return self.filter(queryset).count()
diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index b0a8ffb..afe16b5 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -71,22 +71,11 @@ function tableInit(ctx){
 
     if (tableData.total === 0){
       tableContainer.hide();
-      /* If we were searching show the new search bar and return */
-      if (tableParams.search){
-        $("#new-search-input-"+ctx.tableName).val(tableParams.search);
-        $("#no-results-"+ctx.tableName).show();
-      }
+      $("#new-search-input-"+ctx.tableName).val(tableParams.search);
+      $("#no-results-"+ctx.tableName).show();
       table.trigger("table-done", [tableData.total, tableParams]);
 
       return;
-
-    /* We don't want to clutter the place with the table chrome if there
-     * are only a few results */
-    } else if (tableData.total <= 10 &&
-               !tableParams.filter &&
-               !tableParams.search){
-      $("#table-chrome-"+ctx.tableName).hide();
-      pagination.hide();
     } else {
       tableContainer.show();
       $("#no-results-"+ctx.tableName).hide();
@@ -399,13 +388,14 @@ function tableInit(ctx){
 
   /**
    * Create the DOM/JS for the client side of a TableFilterActionToggle
+   * or TableFilterActionDay
    *
    * filterName: (string) internal name for the filter action
    * filterActionData: (object)
    * filterActionData.count: (number) The number of items this filter will
    * show when selected
    */
-  function createActionToggle(filterName, filterActionData) {
+  function createActionRadio(filterName, filterActionData) {
     var actionStr = '<div class="radio">' +
                     '<input type="radio" name="filter"' +
                     '       value="' + filterName + '"';
@@ -471,8 +461,7 @@ function tableInit(ctx){
       minDate: new Date(filterActionData.min)
     };
 
-    // create date pickers, setting currently-selected from and to
-    // dates
+    // create date pickers, setting currently-selected from and to dates
     var selectedFrom = null;
     var selectedTo = null;
 
@@ -496,6 +485,20 @@ function tableInit(ctx){
       action.find('[data-date-to-for]').datepicker(options);
     inputTo.val(selectedTo);
 
+    // if the radio button is checked and one or both of the datepickers are
+    // empty, populate them with today's date
+    radio.change(function () {
+      var now = new Date();
+
+      if (inputFrom.val() === '') {
+        inputFrom.datepicker('setDate', now);
+      }
+
+      if (inputTo.val() === '') {
+        inputTo.datepicker('setDate', now);
+      }
+    });
+
     // set filter_value based on date pickers when
     // one of their values changes
     var changeHandler = function () {
@@ -553,7 +556,8 @@ function tableInit(ctx){
                 {
                   title: '<label for radio button inside the popup>',
                   name: '<name of the filter action>',
-                  count: <number of items this filter will show>
+                  count: <number of items this filter will show>,
+                  ... additional data for the action ...
                 }
               ]
             }
@@ -567,11 +571,12 @@ function tableInit(ctx){
             filter
 
             the filterName is set on the column filter icon, and corresponds
-            to a value in the table's filters property
+            to a value in the table's filter map
 
             when the filter popup's "Apply" button is clicked, the
             value for the radio button which is checked is passed in the
-            querystring and applied to the queryset on the table
+            querystring, along with a filter_value, and applied to the
+            queryset on the table
           */
           var filterActionRadios = $('#filter-actions-' + ctx.tableName);
 
@@ -587,10 +592,12 @@ function tableInit(ctx){
             var filterName = filterData.name + ':' +
                              filterActionData.action_name;
 
-            if (filterActionData.type === 'toggle') {
-              action = createActionToggle(filterName, filterActionData);
+            if (filterActionData.type === 'toggle' ||
+                filterActionData.type === 'day') {
+              action = createActionRadio(filterName, filterActionData);
             }
             else if (filterActionData.type === 'daterange') {
+              // current values for the from/to dates
               var filterValue = tableParams.filter_value;
 
               action = createActionDateRange(
@@ -601,7 +608,7 @@ function tableInit(ctx){
             }
 
             if (action) {
-              // Setup the current selected filter, default to 'all' if
+              // Setup the current selected filter; default to 'all' if
               // no current filter selected
               var radioInput = action.children('input[name="filter"]');
               if ((tableParams.filter &&
@@ -707,13 +714,12 @@ function tableInit(ctx){
                                           tableParams.filter + "']");
     tableParams.filter_value = checkedFilterValue.val();
 
-    var filterBtn = $("#" + tableParams.filter.split(":")[0]);
-
     /* All === remove filter */
     if (tableParams.filter.match(":all$")) {
       tableParams.filter = null;
-      filterBtnActive(filterBtn, false);
+      tableParams.filter_value = null;
     } else {
+      var filterBtn = $("#" + tableParams.filter.split(":")[0]);
       filterBtnActive(filterBtn, true);
     }
 
diff --git a/lib/toaster/toastergui/tablefilter.py b/lib/toaster/toastergui/tablefilter.py
index 1ea30da..bd8decd 100644
--- a/lib/toaster/toastergui/tablefilter.py
+++ b/lib/toaster/toastergui/tablefilter.py
@@ -18,13 +18,18 @@
 # You should have received a copy of the GNU General Public License along
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
 from django.db.models import Q, Max, Min
 from django.utils import dateparse, timezone
+from datetime import timedelta
+from querysetfilter import QuerysetFilter
 
 class TableFilter(object):
     """
     Stores a filter for a named field, and can retrieve the action
-    requested from the set of actions for that filter
+    requested from the set of actions for that filter;
+    the order in which actions are added governs the order in which they
+    are returned in the JSON for the filter
     """
 
     def __init__(self, name, title):
@@ -32,7 +37,11 @@ class TableFilter(object):
         self.title = title
         self.__filter_action_map = {}
 
+        # retains the ordering of actions
+        self.__filter_action_keys = []
+
     def add_action(self, action):
+        self.__filter_action_keys.append(action.name)
         self.__filter_action_map[action.name] = action
 
     def get_action(self, action_name):
@@ -56,7 +65,8 @@ class TableFilter(object):
         })
 
         # add other filter actions
-        for action_name, filter_action in self.__filter_action_map.iteritems():
+        for action_name in self.__filter_action_keys:
+            filter_action = self.__filter_action_map[action_name]
             obj = filter_action.to_json(queryset)
             obj['action_name'] = action_name
             filter_actions.append(obj)
@@ -67,6 +77,40 @@ class TableFilter(object):
             'filter_actions': filter_actions
         }
 
+class TableFilterQueryHelper(object):
+    def dateStringsToQ(self, field_name, date_from_str, date_to_str):
+        """
+        Convert the date strings from_date_str and to_date_str into a
+        set of args in the form
+
+          {'<field_name>__gte': <date from>, '<field_name>__lte': <date to>}
+
+        where date_from and date_to are Django-timezone-aware dates; then
+        convert that into a Django Q object
+
+        Returns the Q object based on those criteria
+        """
+
+        # one of the values required for the filter is missing, so set
+        # it to the one which was supplied
+        if date_from_str == '':
+            date_from_str = date_to_str
+        elif date_to_str == '':
+            date_to_str = date_from_str
+
+        date_from_naive = dateparse.parse_datetime(date_from_str + ' 00:00:00')
+        date_to_naive = dateparse.parse_datetime(date_to_str + ' 23:59:59')
+
+        tz = timezone.get_default_timezone()
+        date_from = timezone.make_aware(date_from_naive, tz)
+        date_to = timezone.make_aware(date_to_naive, tz)
+
+        args = {}
+        args[field_name + '__gte'] = date_from
+        args[field_name + '__lte'] = date_to
+
+        return Q(**args)
+
 class TableFilterAction(object):
     """
     A filter action which displays in the filter popup for a ToasterTable
@@ -99,7 +143,7 @@ class TableFilterAction(object):
         return {
             'title': self.title,
             'type': self.type,
-            'count': self.queryset_filter.count(queryset)
+            'count': self.filter(queryset).count()
         }
 
 class TableFilterActionToggle(TableFilterAction):
@@ -113,15 +157,70 @@ class TableFilterActionToggle(TableFilterAction):
         super(TableFilterActionToggle, self).__init__(*args)
         self.type = 'toggle'
 
+class TableFilterActionDay(TableFilterAction):
+    """
+    A filter action which filters according to the named datetime field and a
+    string representing a day ("today" or "yesterday")
+    """
+
+    TODAY = 'today'
+    YESTERDAY = 'yesterday'
+
+    def __init__(self, name, title, field, day,
+    queryset_filter = QuerysetFilter(), query_helper = TableFilterQueryHelper()):
+        """
+        field: (string) the datetime field to filter by
+        day: (string) "today" or "yesterday"
+        """
+        super(TableFilterActionDay, self).__init__(
+            name,
+            title,
+            queryset_filter
+        )
+        self.type = 'day'
+        self.field = field
+        self.day = day
+        self.query_helper = query_helper
+
+    def filter(self, queryset):
+        """
+        Apply the day filtering before returning the queryset;
+        this is done here as the value of the filter criteria changes
+        depending on when the filtering is applied
+        """
+
+        criteria = None
+        date_str = None
+        now = timezone.now()
+
+        if self.day == self.YESTERDAY:
+            increment = timedelta(days=1)
+            wanted_date = now - increment
+        else:
+            wanted_date = now
+
+        wanted_date_str = wanted_date.strftime('%Y-%m-%d')
+
+        criteria = self.query_helper.dateStringsToQ(
+            self.field,
+            wanted_date_str,
+            wanted_date_str
+        )
+
+        self.queryset_filter.set_criteria(criteria)
+
+        return self.queryset_filter.filter(queryset)
+
 class TableFilterActionDateRange(TableFilterAction):
     """
     A filter action which will filter the queryset by a date range.
     The date range can be set via set_params()
     """
 
-    def __init__(self, name, title, field, queryset_filter):
+    def __init__(self, name, title, field,
+    queryset_filter = QuerysetFilter(), query_helper = TableFilterQueryHelper()):
         """
-        field: the field to find the max/min range from in the queryset
+        field: (string) the field to find the max/min range from in the queryset
         """
         super(TableFilterActionDateRange, self).__init__(
             name,
@@ -131,9 +230,13 @@ class TableFilterActionDateRange(TableFilterAction):
 
         self.type = 'daterange'
         self.field = field
+        self.query_helper = query_helper
 
     def set_filter_params(self, params):
         """
+        This filter depends on the user selecting some input, so it needs
+        to have its parameters set before its queryset is filtered
+
         params: (str) a string of extra parameters for the filtering
         in the format "2015-12-09,2015-12-11" (from,to); this is passed in the
         querystring and used to set the criteria on the QuerysetFilter
@@ -143,30 +246,18 @@ class TableFilterActionDateRange(TableFilterAction):
         # if params are invalid, return immediately, resetting criteria
         # on the QuerysetFilter
         try:
-            from_date_str, to_date_str = params.split(',')
+            date_from_str, date_to_str = params.split(',')
         except ValueError:
             self.queryset_filter.set_criteria(None)
             return
 
         # one of the values required for the filter is missing, so set
         # it to the one which was supplied
-        if from_date_str == '':
-            from_date_str = to_date_str
-        elif to_date_str == '':
-            to_date_str = from_date_str
-
-        date_from_naive = dateparse.parse_datetime(from_date_str + ' 00:00:00')
-        date_to_naive = dateparse.parse_datetime(to_date_str + ' 23:59:59')
-
-        tz = timezone.get_default_timezone()
-        date_from = timezone.make_aware(date_from_naive, tz)
-        date_to = timezone.make_aware(date_to_naive, tz)
-
-        args = {}
-        args[self.field + '__gte'] = date_from
-        args[self.field + '__lte'] = date_to
-
-        criteria = Q(**args)
+        criteria = self.query_helper.dateStringsToQ(
+            self.field,
+            date_from_str,
+            date_to_str
+        )
         self.queryset_filter.set_criteria(criteria)
 
     def to_json(self, queryset):
@@ -179,7 +270,8 @@ class TableFilterActionDateRange(TableFilterAction):
         data['max'] = queryset.aggregate(Max(self.field))[self.field + '__max']
 
         # a range filter has a count of None, as the number of records it
-        # will select depends on the date range entered
+        # will select depends on the date range entered and we don't know
+        # that ahead of time
         data['count'] = None
 
         return data
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 06ced52..58abe36 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -32,6 +32,7 @@ import itertools
 from toastergui.tablefilter import TableFilter
 from toastergui.tablefilter import TableFilterActionToggle
 from toastergui.tablefilter import TableFilterActionDateRange
+from toastergui.tablefilter import TableFilterActionDay
 
 class ProjectFilters(object):
     def __init__(self, project_layers):
@@ -65,20 +66,20 @@ class LayersTable(ToasterTable):
 
         criteria = Q(projectlayer__in=self.project_layers)
 
-        in_project_filter_action = TableFilterActionToggle(
+        in_project_action = TableFilterActionToggle(
             "in_project",
             "Layers added to this project",
             QuerysetFilter(criteria)
         )
 
-        not_in_project_filter_action = TableFilterActionToggle(
+        not_in_project_action = TableFilterActionToggle(
             "not_in_project",
             "Layers not added to this project",
             QuerysetFilter(~criteria)
         )
 
-        in_current_project_filter.add_action(in_project_filter_action)
-        in_current_project_filter.add_action(not_in_project_filter_action)
+        in_current_project_filter.add_action(in_project_action)
+        in_current_project_filter.add_action(not_in_project_action)
         self.add_filter(in_current_project_filter)
 
     def setup_queryset(self, *args, **kwargs):
@@ -221,20 +222,20 @@ class MachinesTable(ToasterTable):
             "Filter by project machines"
         )
 
-        in_project_filter_action = TableFilterActionToggle(
+        in_project_action = TableFilterActionToggle(
             "in_project",
             "Machines provided by layers added to this project",
             project_filters.in_project
         )
 
-        not_in_project_filter_action = TableFilterActionToggle(
+        not_in_project_action = TableFilterActionToggle(
             "not_in_project",
             "Machines provided by layers not added to this project",
             project_filters.not_in_project
         )
 
-        in_current_project_filter.add_action(in_project_filter_action)
-        in_current_project_filter.add_action(not_in_project_filter_action)
+        in_current_project_filter.add_action(in_project_action)
+        in_current_project_filter.add_action(not_in_project_action)
         self.add_filter(in_current_project_filter)
 
     def setup_queryset(self, *args, **kwargs):
@@ -354,20 +355,20 @@ class RecipesTable(ToasterTable):
             'Filter by project recipes'
         )
 
-        in_project_filter_action = TableFilterActionToggle(
+        in_project_action = TableFilterActionToggle(
             'in_project',
             'Recipes provided by layers added to this project',
             project_filters.in_project
         )
 
-        not_in_project_filter_action = TableFilterActionToggle(
+        not_in_project_action = TableFilterActionToggle(
             'not_in_project',
             'Recipes provided by layers not added to this project',
             project_filters.not_in_project
         )
 
-        table_filter.add_action(in_project_filter_action)
-        table_filter.add_action(not_in_project_filter_action)
+        table_filter.add_action(in_project_action)
+        table_filter.add_action(not_in_project_action)
         self.add_filter(table_filter)
 
     def setup_queryset(self, *args, **kwargs):
@@ -1137,20 +1138,20 @@ class BuildsTable(ToasterTable):
             'Filter builds by outcome'
         )
 
-        successful_builds_filter_action = TableFilterActionToggle(
+        successful_builds_action = TableFilterActionToggle(
             'successful_builds',
             'Successful builds',
             QuerysetFilter(Q(outcome=Build.SUCCEEDED))
         )
 
-        failed_builds_filter_action = TableFilterActionToggle(
+        failed_builds_action = TableFilterActionToggle(
             'failed_builds',
             'Failed builds',
             QuerysetFilter(Q(outcome=Build.FAILED))
         )
 
-        outcome_filter.add_action(successful_builds_filter_action)
-        outcome_filter.add_action(failed_builds_filter_action)
+        outcome_filter.add_action(successful_builds_action)
+        outcome_filter.add_action(failed_builds_action)
         self.add_filter(outcome_filter)
 
         # started on
@@ -1159,14 +1160,29 @@ class BuildsTable(ToasterTable):
             'Filter by date when build was started'
         )
 
-        by_started_date_range_filter_action = TableFilterActionDateRange(
+        started_today_action = TableFilterActionDay(
+            'today',
+            'Today\'s builds',
+            'started_on',
+            'today'
+        )
+
+        started_yesterday_action = TableFilterActionDay(
+            'yesterday',
+            'Yesterday\'s builds',
+            'started_on',
+            'yesterday'
+        )
+
+        by_started_date_range_action = TableFilterActionDateRange(
             'date_range',
             'Build date range',
-            'started_on',
-            QuerysetFilter()
+            'started_on'
         )
 
-        started_on_filter.add_action(by_started_date_range_filter_action)
+        started_on_filter.add_action(started_today_action)
+        started_on_filter.add_action(started_yesterday_action)
+        started_on_filter.add_action(by_started_date_range_action)
         self.add_filter(started_on_filter)
 
         # completed on
@@ -1175,14 +1191,29 @@ class BuildsTable(ToasterTable):
             'Filter by date when build was completed'
         )
 
-        by_completed_date_range_filter_action = TableFilterActionDateRange(
+        completed_today_action = TableFilterActionDay(
+            'today',
+            'Today\'s builds',
+            'completed_on',
+            'today'
+        )
+
+        completed_yesterday_action = TableFilterActionDay(
+            'yesterday',
+            'Yesterday\'s builds',
+            'completed_on',
+            'yesterday'
+        )
+
+        by_completed_date_range_action = TableFilterActionDateRange(
             'date_range',
             'Build date range',
-            'completed_on',
-            QuerysetFilter()
+            'completed_on'
         )
 
-        completed_on_filter.add_action(by_completed_date_range_filter_action)
+        completed_on_filter.add_action(completed_today_action)
+        completed_on_filter.add_action(completed_yesterday_action)
+        completed_on_filter.add_action(by_completed_date_range_action)
         self.add_filter(completed_on_filter)
 
         # failed tasks
@@ -1193,18 +1224,18 @@ class BuildsTable(ToasterTable):
 
         criteria = Q(task_build__outcome=Task.OUTCOME_FAILED)
 
-        with_failed_tasks_filter_action = TableFilterActionToggle(
+        with_failed_tasks_action = TableFilterActionToggle(
             'with_failed_tasks',
             'Builds with failed tasks',
             QuerysetFilter(criteria)
         )
 
-        without_failed_tasks_filter_action = TableFilterActionToggle(
+        without_failed_tasks_action = TableFilterActionToggle(
             'without_failed_tasks',
             'Builds without failed tasks',
             QuerysetFilter(~criteria)
         )
 
-        failed_tasks_filter.add_action(with_failed_tasks_filter_action)
-        failed_tasks_filter.add_action(without_failed_tasks_filter_action)
+        failed_tasks_filter.add_action(with_failed_tasks_action)
+        failed_tasks_filter.add_action(without_failed_tasks_action)
         self.add_filter(failed_tasks_filter)
diff --git a/lib/toaster/toastergui/templates/builds-toastertable.html b/lib/toaster/toastergui/templates/builds-toastertable.html
index 2e32edb..bf13a66 100644
--- a/lib/toaster/toastergui/templates/builds-toastertable.html
+++ b/lib/toaster/toastergui/templates/builds-toastertable.html
@@ -18,7 +18,7 @@
       {% include 'mrb_section.html' %}
     {% endwith %}
 
-    <h1  class="page-header top-air" data-role="page-title"></h1>
+    <h1 class="page-header top-air" data-role="page-title"></h1>
 
     {% url 'builds' as xhr_table_url %}
     {% include 'toastertable.html' %}
diff --git a/lib/toaster/toastergui/templates/toastertable.html b/lib/toaster/toastergui/templates/toastertable.html
index 98a715f..f0a3aed 100644
--- a/lib/toaster/toastergui/templates/toastertable.html
+++ b/lib/toaster/toastergui/templates/toastertable.html
@@ -32,8 +32,11 @@
       <a href="#" class="add-on btn remove-search-btn-{{table_name}}" tabindex="-1">
         <i class="icon-remove"></i>
       </a>
-      <button class="btn search-submit-{{table_name}}" >Search</button>
-      <button class="btn btn-link remove-search-btn-{{table_name}}">Show {{title|lower}}
+      <button class="btn search-submit-{{table_name}}">
+        Search
+      </button>
+      <button class="btn btn-link show-all-{{table_name}}">
+        Show {{title|lower}}
       </button>
     </form>
   </div>
-- 
2.1.4


