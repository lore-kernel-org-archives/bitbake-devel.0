Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 1825576497
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Aug 2015 16:01:44 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 06 Aug 2015 09:01:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,623,1432623600"; d="scan'208";a="743525662"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 06 Aug 2015 09:01:44 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 403AC6A4083;
	Thu,  6 Aug 2015 09:00:57 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  6 Aug 2015 19:01:35 +0300
Message-Id: <9e6dc3ab607a3838fa86696cf2bae16cfe58bab8.1438876763.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <d5bbed667ae3585aa515d0b90329c99a62d2a3b7.1438876763.git.ed.bartosh@linux.intel.com>
References: <d5bbed667ae3585aa515d0b90329c99a62d2a3b7.1438876763.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438876763.git.ed.bartosh@linux.intel.com>
References: <cover.1438876763.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 2/3] bitbake: toastergui: Move layerdetails view definition to the views.py
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
X-List-Received-Date: Thu, 06 Aug 2015 16:01:44 -0000

From: Michael Wood <michael.g.wood@intel.com>

The layerdetails view definition was moved to tables though it isn't
a table. We have a mechanism for the JSON response for this page so use
this instead of a custom class.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/toaster/toastergui/tables.py  | 24 +-----------------------
 bitbake/lib/toaster/toastergui/urls.py    |  3 +--
 bitbake/lib/toaster/toastergui/views.py   | 15 +++++++++++++++
 bitbake/lib/toaster/toastergui/widgets.py | 26 --------------------------
 4 files changed, 17 insertions(+), 51 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/tables.py b/bitbake/lib/toaster/toastergui/tables.py
index 8d5166be..8770df5 100644
--- a/bitbake/lib/toaster/toastergui/tables.py
+++ b/bitbake/lib/toaster/toastergui/tables.py
@@ -19,7 +19,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-from toastergui.widgets import ToasterTable, ToasterTemplateView
+from toastergui.widgets import ToasterTable
 from orm.models import Recipe, ProjectLayer, Layer_Version, Machine, Project
 from django.db.models import Q, Max
 from django.conf.urls import url
@@ -202,28 +202,6 @@ class LayersTable(ToasterTable):
                         computation = lambda x: x.layer.name)
 
 
-
-
-class LayerDetails(ToasterTemplateView):
-    def get_context_data(self, **kwargs):
-        context = super(LayerDetails, self).get_context_data(**kwargs)
-        from toastergui.views import _lv_to_dict
-
-        context['project'] = Project.objects.get(pk=kwargs['pid'])
-        context['layerversion'] = Layer_Version.objects.get(pk=kwargs['layerid'])
-        context['layerdict'] = _lv_to_dict(context['project'], context['layerversion'])
-        context['layerdeps'] = {"list": [
-            [ {"id": y.id,
-               "name": y.layer.name,
-               "layerdetailurl": reverse('layerdetails', args=(kwargs['pid'], y.id)),
-              } for y in x.depends_on.get_equivalents_wpriority(context['project'])][0] for x in context['layerversion'].dependencies.all()]}
-        context['projectlayers'] = map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=context['project']))
-
-        self.context_entries = ['project', 'layerversion', 'projectlayers', 'layerdict', 'layerdeps']
-
-        return context
-
-
 class MachinesTable(ToasterTable, ProjectFiltersMixin):
     """Table of Machines in Toaster"""
 
diff --git a/bitbake/lib/toaster/toastergui/urls.py b/bitbake/lib/toaster/toastergui/urls.py
index beb4303..6a2c586 100644
--- a/bitbake/lib/toaster/toastergui/urls.py
+++ b/bitbake/lib/toaster/toastergui/urls.py
@@ -109,8 +109,7 @@ urlpatterns = patterns('toastergui.views',
             name="projectlayers"),
 
         url(r'^project/(?P<pid>\d+)/layer/(?P<layerid>\d+)$',
-            tables.LayerDetails.as_view(template_name='layerdetails.html'),
-            name='layerdetails'),
+            'layerdetails', name='layerdetails'),
 
         url(r'^project/(?P<pid>\d+)/layer/(?P<layerid>\d+)/recipes/$',
             tables.LayerRecipesTable.as_view(template_name="generic-toastertable-page.html"),
diff --git a/bitbake/lib/toaster/toastergui/views.py b/bitbake/lib/toaster/toastergui/views.py
index b43a01e..21997d6 100755
--- a/bitbake/lib/toaster/toastergui/views.py
+++ b/bitbake/lib/toaster/toastergui/views.py
@@ -2528,6 +2528,21 @@ if True:
         }
         return render(request, template, context)
 
+    @_template_renderer('layerdetails.html')
+    def layerdetails(request, pid, layerid):
+        project = Project.objects.get(pk=pid)
+        layer_version = Layer_Version.objects.get(pk=layerid)
+
+        context = { 'project' : project,
+                   'layerversion' : layer_version,
+                   'layerdeps' : { "list": [
+                     [{"id": y.id, "name": y.layer.name} for y in x.depends_on.get_equivalents_wpriority(project)][0] for x in layer_version.dependencies.all()]},
+                   'projectlayers': map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=project))
+                  }
+
+        return context
+
+
     def get_project_configvars_context():
         # Vars managed outside of this view
         vars_managed = {
diff --git a/bitbake/lib/toaster/toastergui/widgets.py b/bitbake/lib/toaster/toastergui/widgets.py
index 0885402..1f81297 100644
--- a/bitbake/lib/toaster/toastergui/widgets.py
+++ b/bitbake/lib/toaster/toastergui/widgets.py
@@ -328,29 +328,3 @@ class ToasterTable(TemplateView):
         cache.set(cache_name, data, 60*30)
 
         return data
-
-
-class ToasterTemplateView(TemplateView):
-    # renders a instance in a template, or returns the context as json
-    # the class-equivalent of the _template_renderer decorator for views
-
-
-    def get(self, *args, **kwargs):
-        if self.request.GET.get('format', None) == 'json':
-            from django.core.urlresolvers import reverse
-            from django.shortcuts import HttpResponse
-            from views import objtojson
-            from toastergui.templatetags.projecttags import json as jsonfilter
-
-            context = self.get_context_data(**kwargs)
-
-            for x in context.keys():
-                if x not in self.context_entries:
-                    del context[x]
-
-            context["error"] = "ok"
-
-            return HttpResponse(jsonfilter(context,  default=objtojson ),
-                            content_type = "application/json; charset=utf-8")
-
-        return super(ToasterTemplateView, self).get(*args, **kwargs)
-- 
2.1.4


