Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id 196C772491
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 14:39:14 +0000 (UTC)
Received: by wigg3 with SMTP id g3so50844023wig.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 07:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=pGL5Yx3DebbZN03raa8zD01+xGVBDiUehmk69DwEAeY=;
	b=QFRIlJpvAHE/mMYH08+nc8Srwlu8SqnQ/ncPUchRiwB7KqV0E0jO4/L2rKyCLg3tVR
	hQFRDX2gztV2epTzSOF+wANm9KusVLyt1jKYuLGySFCq5nm+yFJ4FDrXsmS5atZKgGnr
	hOSbphtVcUuyK7owEEJ90Q/oC08mE4+FMJjaRG2vdVLmvmEh7O6UrThB6vCnVqipqT7d
	q5tOm6fzJ5VqVDll5ZmMuPwRJ0XC8k5qlfJJNXzAb9JsfSPBTwo18O1i752AZPbmvm3s
	HuHYRnyXVUIyrKGqG4vYpiA9WUGeaEOB/mqHID/9mi+H82eXezmzMz0rUN3nohZaKB3e
	5q7A==
X-Gm-Message-State: ALoCoQnXrvXp/chlxhDj3/j2oYnBfqYov80pmF4Ei+vhCnBisEc9K7E6CcT716cigiLVao/6syTP
X-Received: by 10.194.61.236 with SMTP id t12mr6905700wjr.59.1433947155509;
	Wed, 10 Jun 2015 07:39:15 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id fi6sm8252386wib.6.2015.06.10.07.39.13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Jun 2015 07:39:14 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 0B6CA561099; Wed, 10 Jun 2015 15:39:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jun 2015 15:38:51 +0100
Message-Id: <1778dac9fd39dae75c55bf2cf836cdd488dbc265.1433946742.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
References: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1433946742.git.alexandru.damian@intel.com>
References: <cover.1433946742.git.alexandru.damian@intel.com>
Subject: [PATCH 03/19] toaster: toastertables REST refactoring
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
X-List-Received-Date: Wed, 10 Jun 2015 14:39:15 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch refactors the ToasterTables to bring them in line
with REST principles -

- all table pages now support the "format=json" GET parameter
that returns the data in JSON format
- the tables themselves

This cleans up the URL namespace by aleviating the need to
have two URLS for each table (one for the template and one for
the data loading), and fixes minor things in the ToasterTable
implementation.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/js/table.js          |  5 +-
 lib/toaster/toastergui/tables.py                   | 84 ++++++++++++++--------
 lib/toaster/toastergui/templates/layerdetails.html |  2 +-
 .../toastergui/templates/toastertable-simple.html  |  2 +-
 lib/toaster/toastergui/templates/toastertable.html |  2 +-
 lib/toaster/toastergui/urls.py                     | 30 +++++---
 lib/toaster/toastergui/widgets.py                  | 47 +++++-------
 7 files changed, 102 insertions(+), 70 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index 2e35e38..7588a4a 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -383,12 +383,13 @@ function tableInit(ctx){
      */
     var params = {
       'name' : filterName,
-      'search': tableParams.search
+      'search': tableParams.search,
+      'cmd': 'filterinfo',
     };
 
     $.ajax({
         type: "GET",
-        url: ctx.url + 'filterinfo',
+        url: ctx.url,
         data: params,
         headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
         success: function (filterData) {
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 9a93ff9..b75e565 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -19,7 +19,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-from widgets import ToasterTable
+from toastergui.widgets import ToasterTable
 from orm.models import Recipe, ProjectLayer, Layer_Version, Machine, Project
 from django.db.models import Q, Max
 from django.conf.urls import url
@@ -29,9 +29,19 @@ class LayersTable(ToasterTable):
     """Table of layers in Toaster"""
 
     def __init__(self, *args, **kwargs):
-        ToasterTable.__init__(self)
+        super(LayersTable, self).__init__(*args, **kwargs)
         self.default_orderby = "layer__name"
 
+    def get_context_data(self, **kwargs):
+        context = super(LayersTable, self).get_context_data(**kwargs)
+
+        context['project'] = Project.objects.get(pk=kwargs['pid'])
+
+        context['projectlayers'] = map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=context['project']))
+
+        return context
+
+
     def setup_queryset(self, *args, **kwargs):
         prj = Project.objects.get(pk = kwargs['pid'])
         compatible_layers = prj.compatible_layerversions()
@@ -132,14 +142,31 @@ class LayersTable(ToasterTable):
                         static_data_name="add-del-layers",
                         static_data_template='{% include "layer_btn.html" %}')
 
+class LayerDetails(TemplateView):
+    def get_context_data(self, **kwargs):
+        context = super(LayerDetails, self).get_context_data(**kwargs)
+
+        context['project'] = Project.objects.get(pk=kwargs['pid'])
+        context['layerversion'] = Layer_Version.objects.get(pk=kwargs['layerid'])
+        context['projectlayers'] = map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=context['project']))
+
+        return context
+
 class MachinesTable(ToasterTable):
     """Table of Machines in Toaster"""
 
     def __init__(self, *args, **kwargs):
-        ToasterTable.__init__(self)
+        super(MachinesTable, self).__init__(*args, **kwargs)
         self.empty_state = "No machines maybe you need to do a build?"
         self.default_orderby = "name"
 
+    def get_context_data(self, **kwargs):
+        context = super(MachinesTable, self).get_context_data(**kwargs)
+        context['project'] = Project.objects.get(pk=kwargs['pid'])
+        context['projectlayers'] = map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=context['project']))
+        return context
+
+
     def setup_queryset(self, *args, **kwargs):
         prj = Project.objects.get(pk = kwargs['pid'])
         compatible_layers = prj.compatible_layerversions()
@@ -191,7 +218,13 @@ class LayerMachinesTable(MachinesTable):
     """ Smaller version of the Machines table for use in layer details """
 
     def __init__(self, *args, **kwargs):
-        MachinesTable.__init__(self)
+        super(LayerMachinesTable, self).__init__(*args, **kwargs)
+
+    def get_context_data(self, **kwargs):
+        context = super(LayerMachinesTable, self).get_context_data(**kwargs)
+        context['layerversion'] = Layer_Version.objects.get(pk=kwargs['layerid'])
+        return context
+
 
     def setup_queryset(self, *args, **kwargs):
         MachinesTable.setup_queryset(self, *args, **kwargs)
@@ -219,10 +252,20 @@ class RecipesTable(ToasterTable):
     """Table of Recipes in Toaster"""
 
     def __init__(self, *args, **kwargs):
-        ToasterTable.__init__(self)
+        super(RecipesTable, self).__init__(*args, **kwargs)
         self.empty_state = "Toaster has no recipe information. To generate recipe information you can configure a layer source then run a build."
         self.default_orderby = "name"
 
+    def get_context_data(self, **kwargs):
+        context = super(RecipesTable, self).get_context_data(**kwargs)
+
+        context['project'] = Project.objects.get(pk=kwargs['pid'])
+
+        context['projectlayers'] = map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=context['project']))
+
+        return context
+
+
     def setup_queryset(self, *args, **kwargs):
         prj = Project.objects.get(pk = kwargs['pid'])
 
@@ -293,10 +336,16 @@ class RecipesTable(ToasterTable):
                         static_data_template='{% include "recipe_btn.html" %}')
 
 class LayerRecipesTable(RecipesTable):
-    """ Smaller version of the Machines table for use in layer details """
+    """ Smaller version of the Recipes table for use in layer details """
 
     def __init__(self, *args, **kwargs):
-        RecipesTable.__init__(self)
+        super(LayerRecipesTable, self).__init__(*args, **kwargs)
+
+    def get_context_data(self, **kwargs):
+        context = super(LayerRecipesTable, self).get_context_data(**kwargs)
+        context['layerversion'] = Layer_Version.objects.get(pk=kwargs['layerid'])
+        return context
+
 
     def setup_queryset(self, *args, **kwargs):
         RecipesTable.setup_queryset(self, *args, **kwargs)
@@ -320,24 +369,3 @@ class LayerRecipesTable(RecipesTable):
         self.add_column(title="Build recipe",
                         static_data_name="add-del-layers",
                         static_data_template=build_recipe_template)
-
-
-
-# This needs to be staticaly defined here as django reads the url patterns
-# on start up
-urlpatterns = (
-    url(r'^machines/(?P<cmd>\w+)*', MachinesTable.as_view(),
-        name=MachinesTable.__name__.lower()),
-    url(r'^layers/(?P<cmd>\w+)*', LayersTable.as_view(),
-        name=LayersTable.__name__.lower()),
-    url(r'^recipes/(?P<cmd>\w+)*', RecipesTable.as_view(),
-        name=RecipesTable.__name__.lower()),
-
-    # layer details tables
-    url(r'^layer/(?P<layerid>\d+)/recipes/(?P<cmd>\w+)*',
-        LayerRecipesTable.as_view(),
-        name=LayerRecipesTable.__name__.lower()),
-    url(r'^layer/(?P<layerid>\d+)/machines/(?P<cmd>\w+)*',
-        LayerMachinesTable.as_view(),
-        name=LayerMachinesTable.__name__.lower()),
-)
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 259a59e..c27d259 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -33,7 +33,7 @@
 
   $(document).ready(function (){
     var ctx = {
-      projectBuildUrl : "{% url 'xhr_build' %}",
+      projectBuildUrl : "{% url 'xhr_projectbuild' project.id %}",
       layerDetailsUrl : "{% url 'base_layerdetails' project.id %}",
       xhrUpdateLayerUrl : "{% url 'xhr_updatelayer' %}",
       layerVersion : {
diff --git a/lib/toaster/toastergui/templates/toastertable-simple.html b/lib/toaster/toastergui/templates/toastertable-simple.html
index 23a7526..ea7b38e 100644
--- a/lib/toaster/toastergui/templates/toastertable-simple.html
+++ b/lib/toaster/toastergui/templates/toastertable-simple.html
@@ -10,7 +10,7 @@
 
     var ctx = {
       tableName : "{{table_name}}",
-      url : "{{ xhr_table_url }}",
+      url : "{{ xhr_table_url }}?format=json",
       title : "{{title}}",
       projectLayers : {{projectlayers|json}},
     };
diff --git a/lib/toaster/toastergui/templates/toastertable.html b/lib/toaster/toastergui/templates/toastertable.html
index 5c79ab4..c7c7a84 100644
--- a/lib/toaster/toastergui/templates/toastertable.html
+++ b/lib/toaster/toastergui/templates/toastertable.html
@@ -10,7 +10,7 @@
 
     var ctx = {
       tableName : "{{table_name}}",
-      url : "{{ xhr_table_url }}",
+      url : "{{ xhr_table_url }}?format=json",
       title : "{{title}}",
       projectLayers : {{projectlayers|json}},
     };
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 4e328da..e10e0bb 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -20,8 +20,7 @@ from django.conf.urls import patterns, include, url
 from django.views.generic import RedirectView, TemplateView
 
 from django.http import HttpResponseBadRequest
-import tables
-from widgets import ToasterTemplateView
+from toastergui import tables
 
 urlpatterns = patterns('toastergui.views',
         # landing page
@@ -81,32 +80,46 @@ urlpatterns = patterns('toastergui.views',
         url(r'^project/(?P<pid>\d+)/configuration$', 'projectconf', name='projectconf'),
         url(r'^project/(?P<pid>\d+)/builds/$', 'projectbuilds', name='projectbuilds'),
 
-        url(r'^project/(?P<pid>\d+)/layer/(?P<layerid>\d+)$',
-            ToasterTemplateView.as_view(template_name='layerdetails.html'),
-            name='layerdetails'),
         url(r'^project/(?P<pid>\d+)/layer/$', lambda x,pid: HttpResponseBadRequest(), name='base_layerdetails'),
 
         # the import layer is a project-specific functionality;
         url(r'^project/(?P<pid>\d+)/importlayer$', 'importlayer', name='importlayer'),
 
+
+        # the table pages that have been converted to ToasterTable widget
         url(r'^project/(?P<pid>\d+)/machines/$',
-            ToasterTemplateView.as_view(template_name="generic-toastertable-page.html"),
+            tables.MachinesTable.as_view(template_name="generic-toastertable-page.html"),
             { 'table_name': tables.MachinesTable.__name__.lower(),
               'title' : 'All compatible machines' },
             name="all-machines"),
 
         url(r'^project/(?P<pid>\d+)/recipes/$',
-            ToasterTemplateView.as_view(template_name="generic-toastertable-page.html"),
+            tables.RecipesTable.as_view(template_name="generic-toastertable-page.html"),
             { 'table_name': tables.RecipesTable.__name__.lower(),
               'title' : 'All compatible recipes' },
             name="all-targets"),
 
         url(r'^project/(?P<pid>\d+)/layers/$',
-            ToasterTemplateView.as_view(template_name="generic-toastertable-page.html"),
+            tables.LayersTable.as_view(template_name="generic-toastertable-page.html"),
             { 'table_name': tables.LayersTable.__name__.lower(),
               'title' : 'All compatible layers' },
             name="all-layers"),
 
+        url(r'^project/(?P<pid>\d+)/layer/(?P<layerid>\d+)$',
+            tables.LayerDetails.as_view(template_name='layerdetails.html'),
+            name='layerdetails'),
+
+        url(r'^project/(?P<pid>\d+)/layer/(?P<layerid>\d+)/recipes/$',
+            tables.LayerRecipesTable.as_view(template_name="generic-toastertable-page.html"),
+            { 'table_name': tables.LayerRecipesTable.__name__.lower(),
+              'title' : 'All recipes in layer' },
+             name=tables.LayerRecipesTable.__name__.lower()),
+
+        url(r'^project/(?P<pid>\d+)/layer/(?P<layerid>\d+)/machines/$',
+            tables.LayerMachinesTable.as_view(template_name="generic-toastertable-page.html"),
+            { 'table_name': tables.LayerMachinesTable.__name__.lower(),
+              'title' : 'All machines in layer' },
+            name=tables.LayerMachinesTable.__name__.lower()),
 
         url(r'^xhr_projectbuild/(?P<pid>\d+)$', 'xhr_projectbuild', name='xhr_projectbuild'),
         url(r'^xhr_projectinfo/$', 'xhr_projectinfo', name='xhr_projectinfo'),
@@ -116,7 +129,6 @@ urlpatterns = patterns('toastergui.views',
         url(r'^xhr_datatypeahead/(?P<pid>\d+)$', 'xhr_datatypeahead', name='xhr_datatypeahead'),
         url(r'^xhr_importlayer/$', 'xhr_importlayer', name='xhr_importlayer'),
         url(r'^xhr_updatelayer/$', 'xhr_updatelayer', name='xhr_updatelayer'),
-        url(r'^xhr_tables/project/(?P<pid>\d+)/', include('toastergui.tables')),
 
         # dashboard for failed build requests
         url(r'^project/(?P<pid>\d+)/buildrequest/(?P<brid>\d+)$', 'buildrequestdetails', name='buildrequestdetails'),
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 8cf6e1b..4347a3f 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -32,29 +32,17 @@ from django.core.serializers.json import DjangoJSONEncoder
 from django.core.exceptions import FieldError
 from django.conf.urls import url, patterns
 
-import urls
 import types
 import json
 import collections
 import operator
 
 
-class ToasterTemplateView(TemplateView):
-    def get_context_data(self, **kwargs):
-      context = super(ToasterTemplateView, self).get_context_data(**kwargs)
-      if 'pid' in kwargs:
-          context['project'] = Project.objects.get(pk=kwargs['pid'])
-
-          context['projectlayers'] = map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=context['project']))
-
-      if 'layerid' in kwargs:
-          context['layerversion'] = Layer_Version.objects.get(pk=kwargs['layerid'])
-
-      return context
-
-
-class ToasterTable(View):
-    def __init__(self):
+class ToasterTable(TemplateView):
+    def __init__(self, *args, **kwargs):
+        super(ToasterTable, self).__init__()
+        if 'template_name' in kwargs:
+            self.template_name = kwargs['template_name']
         self.title = None
         self.queryset = None
         self.columns = []
@@ -66,20 +54,23 @@ class ToasterTable(View):
         self.default_orderby = ""
 
     def get(self, request, *args, **kwargs):
-        self.setup_queryset(*args, **kwargs)
+        if request.GET.get('format', None) == 'json':
 
-        # Put the project id into the context for the static_data_template
-        if 'pid' in kwargs:
-            self.static_context_extra['pid'] = kwargs['pid']
+            self.setup_queryset(*args, **kwargs)
+            # Put the project id into the context for the static_data_template
+            if 'pid' in kwargs:
+                self.static_context_extra['pid'] = kwargs['pid']
 
-        cmd = kwargs['cmd']
-        if cmd and 'filterinfo' in cmd:
-            data = self.get_filter_info(request)
-        else:
-            # If no cmd is specified we give you the table data
-            data = self.get_data(request, **kwargs)
+            cmd = request.GET.get('cmd', None)
+            if cmd and 'filterinfo' in cmd:
+                data = self.get_filter_info(request)
+            else:
+                # If no cmd is specified we give you the table data
+                data = self.get_data(request, **kwargs)
+
+            return HttpResponse(data, content_type="application/json")
 
-        return HttpResponse(data, content_type="application/json")
+        return super(ToasterTable, self).get(request, *args, **kwargs)
 
     def get_filter_info(self, request):
         data = None
-- 
1.9.1


