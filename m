Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id B9A1C765BF
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Aug 2015 19:47:11 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 04 Aug 2015 12:46:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,611,1432623600"; d="scan'208";a="742158924"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 04 Aug 2015 12:46:51 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id ED29F6A4083;
	Tue,  4 Aug 2015 12:46:04 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Aug 2015 22:46:33 +0300
Message-Id: <da86b2f35c41f7476a6eaba544d671e2e63def61.1438717072.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <691696f2b87d41540b14b10ef08762f8529b4909.1438717072.git.ed.bartosh@linux.intel.com>
References: <691696f2b87d41540b14b10ef08762f8529b4909.1438717072.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438717072.git.ed.bartosh@linux.intel.com>
References: <cover.1438717072.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 05/12] bitbake: toastergui: Add typeaheads layers, machines, projects, recipes
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
X-List-Received-Date: Tue, 04 Aug 2015 19:47:11 -0000

From: Michael Wood <michael.g.wood@intel.com>

Implementation of typeahead widgets for layers machines and recipes
typeahead.

[YOCTO #7152]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/typeaheads.py | 145 +++++++++++++++++++++++++++++++++++
 lib/toaster/toastergui/urls.py       |  11 +++
 2 files changed, 156 insertions(+)
 create mode 100644 bitbake/lib/toaster/toastergui/typeaheads.py

diff --git a/lib/toaster/toastergui/typeaheads.py b/lib/toaster/toastergui/typeaheads.py
new file mode 100644
index 0000000..d5bec58
--- /dev/null
+++ b/lib/toaster/toastergui/typeaheads.py
@@ -0,0 +1,145 @@
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
+from toastergui.widgets import ToasterTypeAhead
+from orm.models import Project
+from django.core.urlresolvers import reverse
+
+class LayersTypeAhead(ToasterTypeAhead):
+    """ Typeahead for layers available and not added in the current project's
+    configuration """
+    def __init__(self):
+      super(LayersTypeAhead, self).__init__()
+
+    def apply_search(self, search_term, prj, request):
+        layers = prj.compatible_layerversions()
+        layers = layers.order_by('layer__name')
+
+        # Unlike the other typeaheads we also don't want to show suggestions
+        # for layers already in the project unless required such as when adding
+        # layerdeps to a new layer.
+        if ("include_added" in request.GET and
+                request.GET['include_added'] != "true"):
+            layers = layers.exclude(pk__in=prj.projectlayer_equivalent_set)
+
+        primary_results = layers.filter(layer__name__istartswith=search_term)
+        secondary_results = layers.filter(layer__name__icontains=search_term).exclude(pk__in=primary_results)
+
+        results = []
+
+        for layer_version in list(primary_results) + list(secondary_results):
+            vcs_reference = layer_version.get_vcs_reference()
+
+            detail = "[ %s | %s ]" % (layer_version.layer.vcs_url,
+                                      vcs_reference)
+            needed_fields = {
+                'id' : layer_version.pk,
+                'name' : layer_version.layer.name,
+                'layerdetailurl' : layer_version.get_detailspage_url(prj.pk),
+                'vcs_url' : layer_version.layer.vcs_url,
+                'vcs_reference' : vcs_reference,
+                'detail' : detail,
+            }
+
+            results.append(needed_fields)
+
+        return results
+
+class MachinesTypeAhead(ToasterTypeAhead):
+    """ Typeahead for all the machines available in the current project's
+    configuration """
+    def __init__(self):
+        super(MachinesTypeAhead, self).__init__()
+
+    def apply_search(self, search_term, prj, request):
+        machines = prj.get_available_machines()
+        machines = machines.order_by("name")
+
+        primary_results = machines.filter(name__istartswith=search_term)
+        secondary_results = machines.filter(name__icontains=search_term).exclude(pk__in=primary_results)
+        tertiary_results = machines.filter(layer_version__layer__name__icontains=search_term).exclude(pk__in=primary_results).exclude(pk__in=secondary_results)
+
+        results = []
+
+        for machine in list(primary_results) + list(secondary_results) + list(tertiary_results):
+
+            detail = "[ %s ]" % (machine.layer_version.layer.name)
+            needed_fields = {
+                'id' : machine.pk,
+                'name' : machine.name,
+                'detail' : detail,
+            }
+
+            results.append(needed_fields)
+
+        return results
+
+class RecipesTypeAhead(ToasterTypeAhead):
+    """ Typeahead for all the recipes available in the current project's
+    configuration """
+    def __init__(self):
+        super(RecipesTypeAhead, self).__init__()
+
+    def apply_search(self, search_term, prj, request):
+        recipes = prj.get_available_recipes()
+        recipes = recipes.order_by("name")
+
+
+        primary_results = recipes.filter(name__istartswith=search_term)
+        secondary_results = recipes.filter(name__icontains=search_term).exclude(pk__in=primary_results)
+        tertiary_results = recipes.filter(layer_version__layer__name__icontains=search_term).exclude(pk__in=primary_results).exclude(pk__in=secondary_results)
+
+        results = []
+
+        for recipe in list(primary_results) + list(secondary_results) + list(tertiary_results):
+
+            detail = "[ %s ]" % (recipe.layer_version.layer.name)
+            needed_fields = {
+                'id' : recipe.pk,
+                'name' : recipe.name,
+                'detail' : detail,
+            }
+
+            results.append(needed_fields)
+
+        return results
+
+class ProjectsTypeAhead(ToasterTypeAhead):
+    """ Typeahead for all the projects """
+    def __init__(self):
+        super(ProjectsTypeAhead, self).__init__()
+
+    def apply_search(self, search_term, prj, request):
+        projects = Project.objects.all().order_by("name")
+
+        primary_results = projects.filter(name__istartswith=search_term)
+        secondary_results = projects.filter(name__icontains=search_term).exclude(pk__in=primary_results)
+
+        results = []
+
+        for project in list(primary_results) + list(secondary_results):
+            needed_fields = {
+                'id' : project.pk,
+                'name' : project.name,
+                'detail' : "",
+                'projectPageUrl' : reverse('project', args=(project.pk,))
+            }
+
+            results.append(needed_fields)
+
+        return results
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index beb4303..b44c42f 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -21,6 +21,7 @@ from django.views.generic import RedirectView, TemplateView
 
 from django.http import HttpResponseBadRequest
 from toastergui import tables
+from toastergui import typeaheads
 
 urlpatterns = patterns('toastergui.views',
         # landing page
@@ -127,6 +128,16 @@ urlpatterns = patterns('toastergui.views',
 
         url(r'^xhr_datatypeahead/(?P<pid>\d+)$', 'xhr_datatypeahead', name='xhr_datatypeahead'),
         url(r'^xhr_configvaredit/(?P<pid>\d+)$', 'xhr_configvaredit', name='xhr_configvaredit'),
+        # typeahead api end points
+        url(r'^xhr_typeahead/(?P<pid>\d+)/layers$',
+            typeaheads.LayersTypeAhead.as_view(), name='xhr_layerstypeahead'),
+        url(r'^xhr_typeahead/(?P<pid>\d+)/machines$',
+            typeaheads.MachinesTypeAhead.as_view(), name='xhr_machinestypeahead'),
+        url(r'^xhr_typeahead/(?P<pid>\d+)/recipes$',
+            typeaheads.RecipesTypeAhead.as_view(), name='xhr_recipestypeahead'),
+        url(r'^xhr_typeahead/projects$',
+            typeaheads.ProjectsTypeAhead.as_view(), name='xhr_projectstypeahead'),
+
 
         url(r'^xhr_importlayer/$', 'xhr_importlayer', name='xhr_importlayer'),
         url(r'^xhr_updatelayer/$', 'xhr_updatelayer', name='xhr_updatelayer'),
-- 
2.1.4


