Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id A5AAB6093D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 11:00:17 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga103.jf.intel.com with ESMTP; 26 Sep 2016 04:00:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,399,1470726000"; d="scan'208";a="883829253"
Received: from linux.intel.com ([10.54.29.200])
	by orsmga003.jf.intel.com with ESMTP; 26 Sep 2016 04:00:18 -0700
Received: from ed.fi.intel.com (ed.fi.intel.com [10.237.72.179])
	by linux.intel.com (Postfix) with ESMTP id D66556A4006
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 03:59:51 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Sep 2016 13:59:29 +0300
Message-Id: <bafa12a6e21e722c5b3e27c625c001693d3b7577.1474887106.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <cover.1474887106.git.ed.bartosh@linux.intel.com>
References: <cover.1474887106.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1474887106.git.ed.bartosh@linux.intel.com>
References: <cover.1474887106.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 02/10] toaster: move MostRecentBuildsView to its own widget
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
X-List-Received-Date: Mon, 26 Sep 2016 11:00:17 -0000

From: Michael Wood <michael.g.wood@intel.com>

This view is specific to the builds dashboard rather than gernic api so
like ToasterTable and ToasterTypeAhead we class it as a widget as it has
a single purpose. Also clean up some flake8 identified issues.

Original author of the code moved in this commit is Elliot Smith.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/api.py     | 108 -----------------------------
 lib/toaster/toastergui/urls.py    |   3 +-
 lib/toaster/toastergui/widgets.py | 141 +++++++++++++++++++++++++++++++++-----
 3 files changed, 127 insertions(+), 125 deletions(-)

diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index 8876409..5589118 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -33,10 +33,8 @@ from bldcontrol import bbcontroller
 from django.http import HttpResponse, JsonResponse
 from django.views.generic import View
 from django.core.urlresolvers import reverse
-from django.utils import timezone
 from django.db.models import Q, F
 from django.db import Error
-from toastergui.templatetags.projecttags import json, sectohms, get_tasks
 from toastergui.templatetags.projecttags import filtered_filesizeformat
 
 logger = logging.getLogger("toaster")
@@ -227,112 +225,6 @@ class XhrLayer(View):
         })
 
 
-class MostRecentBuildsView(View):
-    def _was_yesterday_or_earlier(self, completed_on):
-        now = timezone.now()
-        delta = now - completed_on
-
-        if delta.days >= 1:
-            return True
-
-        return False
-
-    def get(self, request, *args, **kwargs):
-        """
-        Returns a list of builds in JSON format.
-        """
-        project = None
-
-        project_id = request.GET.get('project_id', None)
-        if project_id:
-            try:
-                project = Project.objects.get(pk=project_id)
-            except:
-                # if project lookup fails, assume no project
-                pass
-
-        recent_build_objs = Build.get_recent(project)
-        recent_builds = []
-
-        for build_obj in recent_build_objs:
-            dashboard_url = reverse('builddashboard', args=(build_obj.pk,))
-            buildtime_url = reverse('buildtime', args=(build_obj.pk,))
-            rebuild_url = \
-                reverse('xhr_buildrequest', args=(build_obj.project.pk,))
-            cancel_url = \
-                reverse('xhr_buildrequest', args=(build_obj.project.pk,))
-
-            build = {}
-            build['id'] = build_obj.pk
-            build['dashboard_url'] = dashboard_url
-
-            buildrequest_id = None
-            if hasattr(build_obj, 'buildrequest'):
-                buildrequest_id = build_obj.buildrequest.pk
-            build['buildrequest_id'] = buildrequest_id
-
-            build['recipes_parsed_percentage'] = \
-                int((build_obj.recipes_parsed /
-                     build_obj.recipes_to_parse) * 100)
-
-            tasks_complete_percentage = 0
-            if build_obj.outcome in (Build.SUCCEEDED, Build.FAILED):
-                tasks_complete_percentage = 100
-            elif build_obj.outcome == Build.IN_PROGRESS:
-                tasks_complete_percentage = build_obj.completeper()
-            build['tasks_complete_percentage'] = tasks_complete_percentage
-
-            build['state'] = build_obj.get_state()
-
-            build['errors'] = build_obj.errors.count()
-            build['dashboard_errors_url'] = dashboard_url + '#errors'
-
-            build['warnings'] = build_obj.warnings.count()
-            build['dashboard_warnings_url'] = dashboard_url + '#warnings'
-
-            build['buildtime'] = sectohms(build_obj.timespent_seconds)
-            build['buildtime_url'] = buildtime_url
-
-            build['rebuild_url'] = rebuild_url
-            build['cancel_url'] = cancel_url
-
-            build['is_default_project_build'] = build_obj.project.is_default
-
-            build['build_targets_json'] = \
-                json(get_tasks(build_obj.target_set.all()))
-
-            # convert completed_on time to user's timezone
-            completed_on = timezone.localtime(build_obj.completed_on)
-
-            completed_on_template = '%H:%M'
-            if self._was_yesterday_or_earlier(completed_on):
-                completed_on_template = '%d/%m/%Y ' + completed_on_template
-            build['completed_on'] = completed_on.strftime(
-                completed_on_template)
-
-            targets = []
-            target_objs = build_obj.get_sorted_target_list()
-            for target_obj in target_objs:
-                if target_obj.task:
-                    targets.append(target_obj.target + ':' + target_obj.task)
-                else:
-                    targets.append(target_obj.target)
-            build['targets'] = ' '.join(targets)
-
-            # abbreviated form of the full target list
-            abbreviated_targets = ''
-            num_targets = len(targets)
-            if num_targets > 0:
-                abbreviated_targets = targets[0]
-            if num_targets > 1:
-                abbreviated_targets += (' +%s' % (num_targets - 1))
-            build['targets_abbreviated'] = abbreviated_targets
-
-            recent_builds.append(build)
-
-        return JsonResponse(recent_builds, safe=False)
-
-
 class XhrCustomRecipe(View):
     """ Create a custom image recipe """
 
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 1232611..0002a5a 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -24,6 +24,7 @@ from toastergui import tables
 from toastergui import buildtables
 from toastergui import typeaheads
 from toastergui import api
+from toastergui import widgets
 
 urlpatterns = patterns('toastergui.views',
         # landing page
@@ -224,7 +225,7 @@ urlpatterns = patterns('toastergui.views',
             api.XhrProject.as_view(),
             name='xhr_project'),
 
-        url(r'^mostrecentbuilds$', api.MostRecentBuildsView.as_view(),
+        url(r'^mostrecentbuilds$', widgets.MostRecentBuildsView.as_view(),
             name='most_recent_builds'),
 
           # default redirection
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 005a562..026903d 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -22,23 +22,24 @@
 from django.views.generic import View, TemplateView
 from django.views.decorators.cache import cache_control
 from django.shortcuts import HttpResponse
-from django.http import HttpResponseBadRequest
-from django.core import serializers
 from django.core.cache import cache
 from django.core.paginator import Paginator, EmptyPage
 from django.db.models import Q
-from orm.models import Project, ProjectLayer, Layer_Version
+from orm.models import Project, Build
 from django.template import Context, Template
 from django.template import VariableDoesNotExist
 from django.template import TemplateSyntaxError
 from django.core.serializers.json import DjangoJSONEncoder
 from django.core.exceptions import FieldError
-from django.conf.urls import url, patterns
+from django.utils import timezone
+from toastergui.templatetags.projecttags import sectohms, get_tasks
+from toastergui.templatetags.projecttags import json as template_json
+from django.http import JsonResponse
+from django.core.urlresolvers import reverse
 
 import types
 import json
 import collections
-import operator
 import re
 
 try:
@@ -55,6 +56,7 @@ from toastergui.tablefilter import TableFilterMap
 class NoFieldOrDataName(Exception):
     pass
 
+
 class ToasterTable(TemplateView):
     def __init__(self, *args, **kwargs):
         super(ToasterTable, self).__init__()
@@ -81,7 +83,7 @@ class ToasterTable(TemplateView):
     def get_context_data(self, **kwargs):
         context = super(ToasterTable, self).get_context_data(**kwargs)
         context['title'] = self.title
-        context['table_name'] =  type(self).__name__.lower()
+        context['table_name'] = type(self).__name__.lower()
         context['empty_state'] = self.empty_state
 
         return context
@@ -406,7 +408,6 @@ class ToasterTable(TemplateView):
         return data
 
 
-
 class ToasterTypeAhead(View):
     """ A typeahead mechanism to support the front end typeahead widgets """
     MAX_RESULTS = 6
@@ -427,34 +428,142 @@ class ToasterTypeAhead(View):
         error = "ok"
 
         search_term = request.GET.get("search", None)
-        if search_term == None:
+        if search_term is None:
             # We got no search value so return empty reponse
-            return response({'error' : error , 'results': []})
+            return response({'error': error, 'results': []})
 
         try:
             prj = Project.objects.get(pk=kwargs['pid'])
         except KeyError:
             prj = None
 
-        results = self.apply_search(search_term, prj, request)[:ToasterTypeAhead.MAX_RESULTS]
+        results = self.apply_search(search_term,
+                                    prj,
+                                    request)[:ToasterTypeAhead.MAX_RESULTS]
 
         if len(results) > 0:
             try:
                 self.validate_fields(results[0])
-            except MissingFieldsException as e:
+            except self.MissingFieldsException as e:
                 error = e
 
-        data = { 'results' : results,
-                'error' : error,
-               }
+        data = {'results': results,
+                'error': error}
 
         return response(data)
 
     def validate_fields(self, result):
-        if 'name' in result == False or 'detail' in result == False:
-            raise MissingFieldsException("name and detail are required fields")
+        if 'name' in result is False or 'detail' in result is False:
+            raise self.MissingFieldsException(
+                "name and detail are required fields")
 
     def apply_search(self, search_term, prj):
         """ Override this function to implement search. Return an array of
         dictionaries with a minium of a name and detail field"""
         pass
+
+
+class MostRecentBuildsView(View):
+    def _was_yesterday_or_earlier(self, completed_on):
+        now = timezone.now()
+        delta = now - completed_on
+
+        if delta.days >= 1:
+            return True
+
+        return False
+
+    def get(self, request, *args, **kwargs):
+        """
+        Returns a list of builds in JSON format.
+        """
+        project = None
+
+        project_id = request.GET.get('project_id', None)
+        if project_id:
+            try:
+                project = Project.objects.get(pk=project_id)
+            except:
+                # if project lookup fails, assume no project
+                pass
+
+        recent_build_objs = Build.get_recent(project)
+        recent_builds = []
+
+        for build_obj in recent_build_objs:
+            dashboard_url = reverse('builddashboard', args=(build_obj.pk,))
+            buildtime_url = reverse('buildtime', args=(build_obj.pk,))
+            rebuild_url = \
+                reverse('xhr_buildrequest', args=(build_obj.project.pk,))
+            cancel_url = \
+                reverse('xhr_buildrequest', args=(build_obj.project.pk,))
+
+            build = {}
+            build['id'] = build_obj.pk
+            build['dashboard_url'] = dashboard_url
+
+            buildrequest_id = None
+            if hasattr(build_obj, 'buildrequest'):
+                buildrequest_id = build_obj.buildrequest.pk
+            build['buildrequest_id'] = buildrequest_id
+
+            build['recipes_parsed_percentage'] = \
+                int((build_obj.recipes_parsed /
+                     build_obj.recipes_to_parse) * 100)
+
+            tasks_complete_percentage = 0
+            if build_obj.outcome in (Build.SUCCEEDED, Build.FAILED):
+                tasks_complete_percentage = 100
+            elif build_obj.outcome == Build.IN_PROGRESS:
+                tasks_complete_percentage = build_obj.completeper()
+            build['tasks_complete_percentage'] = tasks_complete_percentage
+
+            build['state'] = build_obj.get_state()
+
+            build['errors'] = build_obj.errors.count()
+            build['dashboard_errors_url'] = dashboard_url + '#errors'
+
+            build['warnings'] = build_obj.warnings.count()
+            build['dashboard_warnings_url'] = dashboard_url + '#warnings'
+
+            build['buildtime'] = sectohms(build_obj.timespent_seconds)
+            build['buildtime_url'] = buildtime_url
+
+            build['rebuild_url'] = rebuild_url
+            build['cancel_url'] = cancel_url
+
+            build['is_default_project_build'] = build_obj.project.is_default
+
+            build['build_targets_json'] = \
+                template_json(get_tasks(build_obj.target_set.all()))
+
+            # convert completed_on time to user's timezone
+            completed_on = timezone.localtime(build_obj.completed_on)
+
+            completed_on_template = '%H:%M'
+            if self._was_yesterday_or_earlier(completed_on):
+                completed_on_template = '%d/%m/%Y ' + completed_on_template
+            build['completed_on'] = completed_on.strftime(
+                completed_on_template)
+
+            targets = []
+            target_objs = build_obj.get_sorted_target_list()
+            for target_obj in target_objs:
+                if target_obj.task:
+                    targets.append(target_obj.target + ':' + target_obj.task)
+                else:
+                    targets.append(target_obj.target)
+            build['targets'] = ' '.join(targets)
+
+            # abbreviated form of the full target list
+            abbreviated_targets = ''
+            num_targets = len(targets)
+            if num_targets > 0:
+                abbreviated_targets = targets[0]
+            if num_targets > 1:
+                abbreviated_targets += (' +%s' % (num_targets - 1))
+            build['targets_abbreviated'] = abbreviated_targets
+
+            recent_builds.append(build)
+
+        return JsonResponse(recent_builds, safe=False)
-- 
2.6.6


