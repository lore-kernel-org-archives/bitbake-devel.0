Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 3DE82760A3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:21 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga104.fm.intel.com with ESMTP; 15 Jan 2016 04:58:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="893808858"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2016 04:58:22 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 4881C6A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:18 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:00:53 +0200
Message-Id: <248297174046f96dd9e532e8e6badb3888dd26e6.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 10/23] toaster: toastergui: implement date range filters for builds
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
X-List-Received-Date: Fri, 15 Jan 2016 12:58:21 -0000

From: Elliot Smith <elliot.smith@intel.com>

Implement the completed_on and started_on filtering for
builds.

Also separate the name of a filter ("filter" in the querystring)
from its value ("filter_value" in the querystring). This enables
filtering to be defined in the querystring more intuitively,
and also makes it easier to add other types of filter (e.g.
by day).

[YOCTO #8738]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/querysetfilter.py           |   3 +-
 lib/toaster/toastergui/static/js/table.js          | 196 +++++++++++++++++----
 lib/toaster/toastergui/tablefilter.py              | 113 ++++++++++--
 lib/toaster/toastergui/tables.py                   |  38 +++-
 .../toastergui/templates/builds-toastertable.html  |  32 +---
 lib/toaster/toastergui/widgets.py                  |  32 ++--
 6 files changed, 330 insertions(+), 84 deletions(-)

diff --git a/lib/toaster/toastergui/querysetfilter.py b/lib/toaster/toastergui/querysetfilter.py
index dbae239..efa8507 100644
--- a/lib/toaster/toastergui/querysetfilter.py
+++ b/lib/toaster/toastergui/querysetfilter.py
@@ -2,10 +2,11 @@ class QuerysetFilter(object):
     """ Filter for a queryset """
 
     def __init__(self, criteria=None):
+        self.criteria = None
         if criteria:
             self.set_criteria(criteria)
 
-    def set_criteria(self, criteria = None):
+    def set_criteria(self, criteria):
         """
         criteria is an instance of django.db.models.Q;
         see https://docs.djangoproject.com/en/1.9/ref/models/querysets/#q-objects
diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index 63f8a1f..b0a8ffb 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -397,11 +397,140 @@ function tableInit(ctx){
     $.cookie("cols", JSON.stringify(disabled_cols));
   }
 
+  /**
+   * Create the DOM/JS for the client side of a TableFilterActionToggle
+   *
+   * filterName: (string) internal name for the filter action
+   * filterActionData: (object)
+   * filterActionData.count: (number) The number of items this filter will
+   * show when selected
+   */
+  function createActionToggle(filterName, filterActionData) {
+    var actionStr = '<div class="radio">' +
+                    '<input type="radio" name="filter"' +
+                    '       value="' + filterName + '"';
+
+    if (Number(filterActionData.count) == 0) {
+      actionStr += ' disabled="disabled"';
+    }
+
+    actionStr += ' id="' + filterName + '">' +
+                 '<input type="hidden" name="filter_value" value="on"' +
+                 '       data-value-for="' + filterName + '">' +
+                 '<label class="filter-title"' +
+                 '       for="' + filterName + '">' +
+                 filterActionData.title +
+                 ' (' + filterActionData.count + ')' +
+                 '</label>' +
+                 '</div>';
+
+    return $(actionStr);
+  }
+
+  /**
+   * Create the DOM/JS for the client side of a TableFilterActionDateRange
+   *
+   * filterName: (string) internal name for the filter action
+   * filterValue: (string) from,to date range in format yyyy-mm-dd,yyyy-mm-dd;
+   * used to select the current values for the from/to datepickers;
+   * if this is partial (e.g. "yyyy-mm-dd,") only the applicable datepicker
+   * will have a date pre-selected; if empty, neither will
+   * filterActionData: (object) data for generating the action's HTML
+   * filterActionData.title: label for the radio button
+   * filterActionData.max: (string) maximum date for the pickers, in ISO 8601
+   * datetime format
+   * filterActionData.min: (string) minimum date for the pickers, ISO 8601
+   * datetime
+   */
+  function createActionDateRange(filterName, filterValue, filterActionData) {
+    var action = $('<div class="radio">' +
+                   '<input type="radio" name="filter"' +
+                   '       value="' + filterName + '" ' +
+                   '       id="' + filterName + '">' +
+                   '<input type="hidden" name="filter_value" value=""' +
+                   '       data-value-for="' + filterName + '">' +
+                   '<label class="filter-title"' +
+                   '       for="' + filterName + '">' +
+                   filterActionData.title +
+                   '</label>' +
+                   '<input type="text" maxlength="10" class="input-small"' +
+                   '       data-date-from-for="' + filterName + '">' +
+                   '<span class="help-inline">to</span>' +
+                   '<input type="text" maxlength="10" class="input-small"' +
+                   '       data-date-to-for="' + filterName + '">' +
+                   '<span class="help-inline get-help">(yyyy-mm-dd)</span>' +
+                   '</div>');
+
+    var radio = action.find('[type="radio"]');
+    var value = action.find('[data-value-for]');
+
+    // make the datepickers for the range
+    var options = {
+      dateFormat: 'yy-mm-dd',
+      maxDate: new Date(filterActionData.max),
+      minDate: new Date(filterActionData.min)
+    };
+
+    // create date pickers, setting currently-selected from and to
+    // dates
+    var selectedFrom = null;
+    var selectedTo = null;
+
+    var selectedFromAndTo = [];
+    if (filterValue) {
+      selectedFromAndTo = filterValue.split(',');
+    }
+
+    if (selectedFromAndTo.length == 2) {
+      selectedFrom = selectedFromAndTo[0];
+      selectedTo = selectedFromAndTo[1];
+    }
+
+    options.defaultDate = selectedFrom;
+    var inputFrom =
+      action.find('[data-date-from-for]').datepicker(options);
+    inputFrom.val(selectedFrom);
+
+    options.defaultDate = selectedTo;
+    var inputTo =
+      action.find('[data-date-to-for]').datepicker(options);
+    inputTo.val(selectedTo);
+
+    // set filter_value based on date pickers when
+    // one of their values changes
+    var changeHandler = function () {
+      value.val(inputFrom.val() + ',' + inputTo.val());
+    };
+
+    inputFrom.change(changeHandler);
+    inputTo.change(changeHandler);
+
+    // check the associated radio button on clicking a date picker
+    var checkRadio = function () {
+      radio.prop('checked', 'checked');
+    };
+
+    inputFrom.focus(checkRadio);
+    inputTo.focus(checkRadio);
+
+    // selecting a date in a picker constrains the date you can
+    // set in the other picker
+    inputFrom.change(function () {
+      inputTo.datepicker('option', 'minDate', inputFrom.val());
+    });
+
+    inputTo.change(function () {
+      inputFrom.datepicker('option', 'maxDate', inputTo.val());
+    });
+
+    return action;
+  }
+
   function filterOpenClicked(){
     var filterName = $(this).data('filter-name');
 
-    /* We need to pass in the curren search so that the filter counts take
-     * into account the current search filter
+    /* We need to pass in the current search so that the filter counts take
+     * into account the current search term
      */
     var params = {
       'name' : filterName,
@@ -443,46 +572,44 @@ function tableInit(ctx){
             when the filter popup's "Apply" button is clicked, the
             value for the radio button which is checked is passed in the
             querystring and applied to the queryset on the table
-           */
+          */
+          var filterActionRadios = $('#filter-actions-' + ctx.tableName);
 
-          var filterActionRadios = $('#filter-actions-'+ctx.tableName);
+          $('#filter-modal-title-' + ctx.tableName).text(filterData.title);
 
-          $('#filter-modal-title-'+ctx.tableName).text(filterData.title);
-
-          filterActionRadios.text("");
+          filterActionRadios.empty();
 
+          // create a radio button + form elements for each action associated
+          // with the filter on this column of the table
           for (var i in filterData.filter_actions) {
-            var filterAction = filterData.filter_actions[i];
             var action = null;
+            var filterActionData = filterData.filter_actions[i];
+            var filterName = filterData.name + ':' +
+                             filterActionData.action_name;
 
-            if (filterAction.type === 'toggle') {
-              var actionTitle = filterAction.title + ' (' + filterAction.count + ')';
-
-              action = $('<label class="radio">' +
-                         '<input type="radio" name="filter" value="">' +
-                         '<span class="filter-title">' +
-                         actionTitle +
-                         '</span>' +
-                         '</label>');
-
-              var radioInput = action.children("input");
-              if (Number(filterAction.count) == 0) {
-                radioInput.attr("disabled", "disabled");
-              }
-
-              radioInput.val(filterData.name + ':' + filterAction.action_name);
+            if (filterActionData.type === 'toggle') {
+              action = createActionToggle(filterName, filterActionData);
+            }
+            else if (filterActionData.type === 'daterange') {
+              var filterValue = tableParams.filter_value;
+
+              action = createActionDateRange(
+                filterName,
+                filterValue,
+                filterActionData
+              );
+            }
 
-              /* Setup the current selected filter, default to 'all' if
-               * no current filter selected.
-               */
+            if (action) {
+              // Setup the current selected filter, default to 'all' if
+              // no current filter selected
+              var radioInput = action.children('input[name="filter"]');
               if ((tableParams.filter &&
                   tableParams.filter === radioInput.val()) ||
-                  filterAction.action_name == 'all') {
+                  filterActionData.action_name == 'all') {
                   radioInput.attr("checked", "checked");
               }
-            }
 
-            if (action) {
               filterActionRadios.append(action);
             }
           }
@@ -571,7 +698,14 @@ function tableInit(ctx){
       filterBtnActive($(filterBtn), false);
     });
 
-    tableParams.filter = $(this).find("input[type='radio']:checked").val();
+    // checked radio button
+    var checkedFilter = $(this).find("input[name='filter']:checked");
+    tableParams.filter = checkedFilter.val();
+
+    // hidden field holding the value for the checked filter
+    var checkedFilterValue = $(this).find("input[data-value-for='" +
+                                          tableParams.filter + "']");
+    tableParams.filter_value = checkedFilterValue.val();
 
     var filterBtn = $("#" + tableParams.filter.split(":")[0]);
 
diff --git a/lib/toaster/toastergui/tablefilter.py b/lib/toaster/toastergui/tablefilter.py
index b42fd52..1ea30da 100644
--- a/lib/toaster/toastergui/tablefilter.py
+++ b/lib/toaster/toastergui/tablefilter.py
@@ -18,12 +18,15 @@
 # You should have received a copy of the GNU General Public License along
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+from django.db.models import Q, Max, Min
+from django.utils import dateparse, timezone
 
 class TableFilter(object):
     """
     Stores a filter for a named field, and can retrieve the action
-    requested for that filter
+    requested from the set of actions for that filter
     """
+
     def __init__(self, name, title):
         self.name = name
         self.title = title
@@ -64,42 +67,128 @@ class TableFilter(object):
             'filter_actions': filter_actions
         }
 
-class TableFilterActionToggle(object):
+class TableFilterAction(object):
     """
-    Stores a single filter action which will populate one radio button of
-    a ToasterTable filter popup; this filter can either be on or off and
-    has no other parameters
+    A filter action which displays in the filter popup for a ToasterTable
+    and uses an associated QuerysetFilter to filter the queryset for that
+    ToasterTable
     """
 
     def __init__(self, name, title, queryset_filter):
         self.name = name
         self.title = title
-        self.__queryset_filter = queryset_filter
-        self.type = 'toggle'
+        self.queryset_filter = queryset_filter
+
+        # set in subclasses
+        self.type = None
 
-    def set_params(self, params):
+    def set_filter_params(self, params):
         """
         params: (str) a string of extra parameters for the action;
         the structure of this string depends on the type of action;
         it's ignored for a toggle filter action, which is just on or off
         """
-        pass
+        if not params:
+            return
 
     def filter(self, queryset):
-        return self.__queryset_filter.filter(queryset)
+        return self.queryset_filter.filter(queryset)
 
     def to_json(self, queryset):
         """ Dump as a JSON object """
         return {
             'title': self.title,
             'type': self.type,
-            'count': self.__queryset_filter.count(queryset)
+            'count': self.queryset_filter.count(queryset)
         }
 
+class TableFilterActionToggle(TableFilterAction):
+    """
+    A single filter action which will populate one radio button of
+    a ToasterTable filter popup; this filter can either be on or off and
+    has no other parameters
+    """
+
+    def __init__(self, *args):
+        super(TableFilterActionToggle, self).__init__(*args)
+        self.type = 'toggle'
+
+class TableFilterActionDateRange(TableFilterAction):
+    """
+    A filter action which will filter the queryset by a date range.
+    The date range can be set via set_params()
+    """
+
+    def __init__(self, name, title, field, queryset_filter):
+        """
+        field: the field to find the max/min range from in the queryset
+        """
+        super(TableFilterActionDateRange, self).__init__(
+            name,
+            title,
+            queryset_filter
+        )
+
+        self.type = 'daterange'
+        self.field = field
+
+    def set_filter_params(self, params):
+        """
+        params: (str) a string of extra parameters for the filtering
+        in the format "2015-12-09,2015-12-11" (from,to); this is passed in the
+        querystring and used to set the criteria on the QuerysetFilter
+        associated with this action
+        """
+
+        # if params are invalid, return immediately, resetting criteria
+        # on the QuerysetFilter
+        try:
+            from_date_str, to_date_str = params.split(',')
+        except ValueError:
+            self.queryset_filter.set_criteria(None)
+            return
+
+        # one of the values required for the filter is missing, so set
+        # it to the one which was supplied
+        if from_date_str == '':
+            from_date_str = to_date_str
+        elif to_date_str == '':
+            to_date_str = from_date_str
+
+        date_from_naive = dateparse.parse_datetime(from_date_str + ' 00:00:00')
+        date_to_naive = dateparse.parse_datetime(to_date_str + ' 23:59:59')
+
+        tz = timezone.get_default_timezone()
+        date_from = timezone.make_aware(date_from_naive, tz)
+        date_to = timezone.make_aware(date_to_naive, tz)
+
+        args = {}
+        args[self.field + '__gte'] = date_from
+        args[self.field + '__lte'] = date_to
+
+        criteria = Q(**args)
+        self.queryset_filter.set_criteria(criteria)
+
+    def to_json(self, queryset):
+        """ Dump as a JSON object """
+        data = super(TableFilterActionDateRange, self).to_json(queryset)
+
+        # additional data about the date range covered by the queryset's
+        # records, retrieved from its <field> column
+        data['min'] = queryset.aggregate(Min(self.field))[self.field + '__min']
+        data['max'] = queryset.aggregate(Max(self.field))[self.field + '__max']
+
+        # a range filter has a count of None, as the number of records it
+        # will select depends on the date range entered
+        data['count'] = None
+
+        return data
+
 class TableFilterMap(object):
     """
-    Map from field names to Filter objects for those fields
+    Map from field names to TableFilter objects for those fields
     """
+
     def __init__(self):
         self.__filters = {}
 
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 0941637..06ced52 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -29,7 +29,9 @@ from django.core.urlresolvers import reverse
 from django.views.generic import TemplateView
 import itertools
 
-from toastergui.tablefilter import TableFilter, TableFilterActionToggle
+from toastergui.tablefilter import TableFilter
+from toastergui.tablefilter import TableFilterActionToggle
+from toastergui.tablefilter import TableFilterActionDateRange
 
 class ProjectFilters(object):
     def __init__(self, project_layers):
@@ -1070,6 +1072,7 @@ class BuildsTable(ToasterTable):
                         help_text='The date and time when the build started',
                         hideable=True,
                         orderable=True,
+                        filter_name='started_on_filter',
                         static_data_name='started_on',
                         static_data_template=started_on_template)
 
@@ -1077,6 +1080,7 @@ class BuildsTable(ToasterTable):
                         help_text='The date and time when the build finished',
                         hideable=False,
                         orderable=True,
+                        filter_name='completed_on_filter',
                         static_data_name='completed_on',
                         static_data_template=completed_on_template)
 
@@ -1149,6 +1153,38 @@ class BuildsTable(ToasterTable):
         outcome_filter.add_action(failed_builds_filter_action)
         self.add_filter(outcome_filter)
 
+        # started on
+        started_on_filter = TableFilter(
+            'started_on_filter',
+            'Filter by date when build was started'
+        )
+
+        by_started_date_range_filter_action = TableFilterActionDateRange(
+            'date_range',
+            'Build date range',
+            'started_on',
+            QuerysetFilter()
+        )
+
+        started_on_filter.add_action(by_started_date_range_filter_action)
+        self.add_filter(started_on_filter)
+
+        # completed on
+        completed_on_filter = TableFilter(
+            'completed_on_filter',
+            'Filter by date when build was completed'
+        )
+
+        by_completed_date_range_filter_action = TableFilterActionDateRange(
+            'date_range',
+            'Build date range',
+            'completed_on',
+            QuerysetFilter()
+        )
+
+        completed_on_filter.add_action(by_completed_date_range_filter_action)
+        self.add_filter(completed_on_filter)
+
         # failed tasks
         failed_tasks_filter = TableFilter(
             'failed_tasks_filter',
diff --git a/lib/toaster/toastergui/templates/builds-toastertable.html b/lib/toaster/toastergui/templates/builds-toastertable.html
index f7604fd..2e32edb 100644
--- a/lib/toaster/toastergui/templates/builds-toastertable.html
+++ b/lib/toaster/toastergui/templates/builds-toastertable.html
@@ -1,4 +1,13 @@
 {% extends 'base.html' %}
+{% load static %}
+
+{% block extraheadcontent %}
+  <link rel="stylesheet" href="{% static 'css/jquery-ui.min.css' %}" type='text/css'>
+  <link rel="stylesheet" href="{% static 'css/jquery-ui.structure.min.css' %}" type='text/css'>
+  <link rel="stylesheet" href="{% static 'css/jquery-ui.theme.min.css' %}" type='text/css'>
+  <script src="{% static 'js/jquery-ui.min.js' %}">
+  </script>
+{% endblock %}
 
 {% block title %} All builds - Toaster {% endblock %}
 
@@ -34,29 +43,6 @@
 
         titleElt.text(title);
       });
-
-      /* {% if last_date_from and last_date_to %}
-      // TODO initialize the date range controls;
-      // this will need to be added via ToasterTable
-      date_init(
-        "started_on",
-        "{{last_date_from}}",
-        "{{last_date_to}}",
-        "{{dateMin_started_on}}",
-        "{{dateMax_started_on}}",
-        "{{daterange_selected}}"
-      );
-
-      date_init(
-        "completed_on",
-        "{{last_date_from}}",
-        "{{last_date_to}}",
-        "{{dateMin_completed_on}}",
-        "{{dateMax_completed_on}}",
-        "{{daterange_selected}}"
-      );
-      {% endif %}
-      */
     });
   </script>
 {% endblock %}
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 8790340..47de30d 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -183,13 +183,13 @@ class ToasterTable(TemplateView):
 
         return template.render(context)
 
-    def apply_filter(self, filters, **kwargs):
+    def apply_filter(self, filters, filter_value, **kwargs):
         """
         Apply a filter submitted in the querystring to the ToasterTable
 
         filters: (str) in the format:
-          '<filter name>:<action name>!<action params>'
-        where <action params> is optional
+          '<filter name>:<action name>'
+        filter_value: (str) parameters to pass to the named filter
 
         <filter name> and <action name> are used to look up the correct filter
         in the ToasterTable's filter map; the <action params> are set on
@@ -199,15 +199,8 @@ class ToasterTable(TemplateView):
         self.setup_filters(**kwargs)
 
         try:
-            filter_name, action_name_and_params = filters.split(':')
-
-            action_name = None
-            action_params = None
-            if re.search('!', action_name_and_params):
-                action_name, action_params = action_name_and_params.split('!')
-                action_params = urllib.unquote_plus(action_params)
-            else:
-                action_name = action_name_and_params
+            filter_name, action_name = filters.split(':')
+            action_params = urllib.unquote_plus(filter_value)
         except ValueError:
             return
 
@@ -217,7 +210,7 @@ class ToasterTable(TemplateView):
         try:
             table_filter = self.filter_map.get_filter(filter_name)
             action = table_filter.get_action(action_name)
-            action.set_params(action_params)
+            action.set_filter_params(action_params)
             self.queryset = action.filter(self.queryset)
         except KeyError:
             # pass it to the user - programming error here
@@ -247,13 +240,20 @@ class ToasterTable(TemplateView):
 
 
     def get_data(self, request, **kwargs):
-        """Returns the data for the page requested with the specified
-        parameters applied"""
+        """
+        Returns the data for the page requested with the specified
+        parameters applied
+
+        filters: filter and action name, e.g. "outcome:build_succeeded"
+        filter_value: value to pass to the named filter+action, e.g. "on"
+        (for a toggle filter) or "2015-12-11,2015-12-12" (for a date range filter)
+        """
 
         page_num = request.GET.get("page", 1)
         limit = request.GET.get("limit", 10)
         search = request.GET.get("search", None)
         filters = request.GET.get("filter", None)
+        filter_value = request.GET.get("filter_value", "on")
         orderby = request.GET.get("orderby", None)
         nocache = request.GET.get("nocache", None)
 
@@ -285,7 +285,7 @@ class ToasterTable(TemplateView):
         if search:
             self.apply_search(search)
         if filters:
-            self.apply_filter(filters, **kwargs)
+            self.apply_filter(filters, filter_value, **kwargs)
         if orderby:
             self.apply_orderby(orderby)
 
-- 
2.1.4


