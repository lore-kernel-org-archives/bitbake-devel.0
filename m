Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id C2C5965CBA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 May 2016 13:50:48 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 16 May 2016 06:50:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,627,1455004800"; d="scan'208";a="977895223"
Received: from joerthel-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.28.80])
	by orsmga002.jf.intel.com with ESMTP; 16 May 2016 06:50:47 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 May 2016 14:50:40 +0100
Message-Id: <1463406641-20063-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 1/2] toaster: toastertables: Clean up and fix up a number of items
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
X-List-Received-Date: Mon, 16 May 2016 13:50:48 -0000

From: Michael Wood <michael.g.wood@intel.com>

 - Remove the unused 'computation' field
 - Remove the code to try to make the tables behave like an api
 - Remove custom JSON encoder in favour of DjangoJSONEncoder
 - Simplify get_data and add comments
 - Add exception type instead of using generic Exception
 - Clean up python style warnings

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/static/js/table.js |  21 +---
 bitbake/lib/toaster/toastergui/tables.py          |  11 --
 bitbake/lib/toaster/toastergui/widgets.py         | 127 ++++++++++++----------
 3 files changed, 72 insertions(+), 87 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/static/js/table.js b/bitbake/lib/toaster/toastergui/static/js/table.js
index f738144..7f76f55 100644
--- a/bitbake/lib/toaster/toastergui/static/js/table.js
+++ b/bitbake/lib/toaster/toastergui/static/js/table.js
@@ -101,27 +101,8 @@ function tableInit(ctx){
       var row = $("<tr></tr>");
       column_index = -1;
       for (var key_j in tableData.rows[i]){
-
-        /* if we have a static: version of a key, prefer the static: version for rendering */
-        var orig_key_j = key_j;
-
-        if (key_j.indexOf("static:") === 0) {
-          if (key_j.substr("static:".length) in tableData.rows[i]) {
-            continue;
-          }
-          orig_key_j = key_j.substr("static:".length)
-        } else if (("static:" + key_j) in tableData.rows[i]) {
-          key_j = "static:" + key_j;
-        }
-
-        /* we skip over un-displayable column entries */
-        column_index += 1;
-        if (! tableData.columns[column_index].displayable) {
-          continue;
-        }
-
         var td = $("<td></td>");
-        td.prop("class", orig_key_j);
+        td.prop("class", key_j);
         if (tableData.rows[i][key_j]){
           td.html(tableData.rows[i][key_j]);
         }
diff --git a/bitbake/lib/toaster/toastergui/tables.py b/bitbake/lib/toaster/toastergui/tables.py
index eb876ec..29b68de 100644
--- a/bitbake/lib/toaster/toastergui/tables.py
+++ b/bitbake/lib/toaster/toastergui/tables.py
@@ -190,17 +190,6 @@ class LayersTable(ToasterTable):
                         static_data_name="add-del-layers",
                         static_data_template='{% include "layer_btn.html" %}')
 
-        project = Project.objects.get(pk=kwargs['pid'])
-        self.add_column(title="LayerDetailsUrl",
-                        displayable = False,
-                        field_name="layerdetailurl",
-                        computation = lambda x: reverse('layerdetails', args=(project.id, x.id)))
-
-        self.add_column(title="name",
-                        displayable = False,
-                        field_name="name",
-                        computation = lambda x: x.layer.name)
-
 
 class MachinesTable(ToasterTable):
     """Table of Machines in Toaster"""
diff --git a/bitbake/lib/toaster/toastergui/widgets.py b/bitbake/lib/toaster/toastergui/widgets.py
index d2ef5d3..4117031 100644
--- a/bitbake/lib/toaster/toastergui/widgets.py
+++ b/bitbake/lib/toaster/toastergui/widgets.py
@@ -43,9 +43,12 @@ import urllib
 import logging
 logger = logging.getLogger("toaster")
 
-from toastergui.views import objtojson
 from toastergui.tablefilter import TableFilterMap
 
+
+class NoFieldOrDataNme(Exception):
+    pass
+
 class ToasterTable(TemplateView):
     def __init__(self, *args, **kwargs):
         super(ToasterTable, self).__init__()
@@ -63,25 +66,19 @@ class ToasterTable(TemplateView):
         self.empty_state = "Sorry - no data found"
         self.default_orderby = ""
 
-        # add the "id" column, undisplayable, by default
-        self.add_column(title="Id",
-                        displayable=False,
-                        orderable=True,
-                        field_name="id")
-
     # prevent HTTP caching of table data
-    @cache_control(must_revalidate=True, max_age=0, no_store=True, no_cache=True)
+    @cache_control(must_revalidate=True,
+                   max_age=0, no_store=True, no_cache=True)
     def dispatch(self, *args, **kwargs):
         return super(ToasterTable, self).dispatch(*args, **kwargs)
 
     def get_context_data(self, **kwargs):
         context = super(ToasterTable, self).get_context_data(**kwargs)
         context['title'] = self.title
-        context['table_name'] =  type(self).__name__.lower()
+        context['table_name'] = type(self).__name__.lower()
 
         return context
 
-
     def get(self, request, *args, **kwargs):
         if request.GET.get('format', None) == 'json':
 
@@ -102,8 +99,6 @@ class ToasterTable(TemplateView):
         return super(ToasterTable, self).get(request, *args, **kwargs)
 
     def get_filter_info(self, request, **kwargs):
-        data = None
-
         self.setup_filters(**kwargs)
 
         search = request.GET.get("search", None)
@@ -117,13 +112,18 @@ class ToasterTable(TemplateView):
                           cls=DjangoJSONEncoder)
 
     def setup_columns(self, *args, **kwargs):
-        """ function to implement in the subclass which sets up the columns """
+        """ function to implement in the subclass which sets up
+        the columns """
         pass
+
     def setup_filters(self, *args, **kwargs):
-        """ function to implement in the subclass which sets up the filters """
+        """ function to implement in the subclass which sets up the
+        filters """
         pass
+
     def setup_queryset(self, *args, **kwargs):
-        """ function to implement in the subclass which sets up the queryset"""
+        """ function to implement in the subclass which sets up the
+        queryset"""
         pass
 
     def add_filter(self, table_filter):
@@ -137,7 +137,6 @@ class ToasterTable(TemplateView):
     def add_column(self, title="", help_text="",
                    orderable=False, hideable=True, hidden=False,
                    field_name="", filter_name=None, static_data_name=None,
-                   displayable=True, computation=None,
                    static_data_template=None):
         """Add a column to the table.
 
@@ -155,18 +154,15 @@ class ToasterTable(TemplateView):
                 as data
         """
 
-        self.columns.append({'title' : title,
-                             'help_text' : help_text,
-                             'orderable' : orderable,
-                             'hideable' : hideable,
-                             'hidden' : hidden,
-                             'field_name' : field_name,
-                             'filter_name' : filter_name,
+        self.columns.append({'title': title,
+                             'help_text': help_text,
+                             'orderable': orderable,
+                             'hideable': hideable,
+                             'hidden': hidden,
+                             'field_name': field_name,
+                             'filter_name': filter_name,
                              'static_data_name': static_data_name,
-                             'static_data_template': static_data_template,
-                             'displayable': displayable,
-                             'computation': computation,
-                            })
+                             'static_data_template': static_data_template})
 
     def set_column_hidden(self, title, hidden):
         """
@@ -190,8 +186,8 @@ class ToasterTable(TemplateView):
         """Utility function to render the static data template"""
 
         context = {
-          'extra' : self.static_context_extra,
-          'data' : row,
+          'extra': self.static_context_extra,
+          'data': row,
         }
 
         context = Context(context)
@@ -241,7 +237,7 @@ class ToasterTable(TemplateView):
 
         if not hasattr(self.queryset.model, 'search_allowed_fields'):
             raise Exception("Search fields aren't defined in the model %s"
-                           % self.queryset.model)
+                            % self.queryset.model)
 
         search_queries = []
         for st in search_term.split(" "):
@@ -254,7 +250,6 @@ class ToasterTable(TemplateView):
 
         self.queryset = self.queryset.filter(search_queries)
 
-
     def get_data(self, request, **kwargs):
         """
         Returns the data for the page requested with the specified
@@ -262,7 +257,8 @@ class ToasterTable(TemplateView):
 
         filters: filter and action name, e.g. "outcome:build_succeeded"
         filter_value: value to pass to the named filter+action, e.g. "on"
-        (for a toggle filter) or "2015-12-11,2015-12-12" (for a date range filter)
+        (for a toggle filter) or "2015-12-11,2015-12-12"
+        (for a date range filter)
         """
 
         page_num = request.GET.get("page", 1)
@@ -313,16 +309,16 @@ class ToasterTable(TemplateView):
             page = paginator.page(1)
 
         data = {
-            'total' : self.queryset.count(),
-            'default_orderby' : self.default_orderby,
-            'columns' : self.columns,
-            'rows' : [],
-            'error' : "ok",
+            'total': self.queryset.count(),
+            'default_orderby': self.default_orderby,
+            'columns': self.columns,
+            'rows': [],
+            'error': "ok",
         }
 
         try:
-            for row in page.object_list:
-                #Use collection to maintain the order
+            for model_obj in page.object_list:
+                # Use collection to maintain the order
                 required_data = collections.OrderedDict()
 
                 for col in self.columns:
@@ -330,38 +326,57 @@ class ToasterTable(TemplateView):
                     if not field:
                         field = col['static_data_name']
                     if not field:
-                        raise Exception("Must supply a field_name or static_data_name for column %s.%s" % (self.__class__.__name__,col))
+                        raise NoFieldOrDataNme("Must supply a field_name or"
+                                               "static_data_name for column"
+                                               "%s.%s" %
+                                               (self.__class__.__name__, col))
+
                     # Check if we need to process some static data
                     if "static_data_name" in col and col['static_data_name']:
-                        required_data["static:%s" % col['static_data_name']] = self.render_static_data(col['static_data_template'], row)
-
                         # Overwrite the field_name with static_data_name
                         # so that this can be used as the html class name
-
                         col['field_name'] = col['static_data_name']
 
-                    # compute the computation on the raw data if needed
-                    model_data = row
-                    if col['computation']:
-                        model_data = col['computation'](row)
+                        # Render the template given
+                        required_data[col['static_data_name']] = \
+                            self.render_static_data(
+                                col['static_data_template'], model_obj)
                     else:
-                        # Traverse to any foriegn key in the object hierachy
-                        for subfield in field.split("__"):
-                            if hasattr(model_data, subfield):
-                                model_data = getattr(model_data, subfield)
-                        # The field could be a function on the model so check
-                        # If it is then call it
+                        # Traverse to any foriegn key in the field
+                        # e.g. recipe__layer_version__name
+                        model_data = None
+
+                        if "__" in field:
+                            for subfield in field.split("__"):
+                                if not model_data:
+                                    # The first iteration is always going to
+                                    # be on the actual model object instance.
+                                    # Subsequent ones are on the result of
+                                    # that. e.g. forieng key objects
+                                    model_data = getattr(model_obj,
+                                                         subfield)
+                                else:
+                                    model_data = getattr(model_data,
+                                                         subfield)
+
+                        else:
+                            model_data = getattr(model_obj,
+                                                 col['field_name'])
+
+                        # We might have a model function as the field so
+                        # call it to return the data needed
                         if isinstance(model_data, types.MethodType):
-                          model_data = model_data()
+                            model_data = model_data()
 
-                    required_data[col['field_name']] = model_data
+                        required_data[col['field_name']] = model_data
 
                 data['rows'].append(required_data)
 
         except FieldError:
             # pass  it to the user - programming-error here
             raise
-        data = json.dumps(data, indent=2, default=objtojson)
+
+        data = json.dumps(data, indent=2, cls=DjangoJSONEncoder)
         cache.set(cache_name, data, 60*30)
 
         return data
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


