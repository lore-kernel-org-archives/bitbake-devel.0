Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 2894B785A3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 29 Jul 2017 00:22:44 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v6T0MkbZ020710
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jul 2017 17:22:46 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Fri, 28 Jul 2017 17:22:45 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Jul 2017 17:14:13 -0700
Message-ID: <0ad5121915689c0bcf8b7fd2b38ab306c752c08e.1501286515.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1501286515.git.David.Reyna@windriver.com>
References: <cover.1501286515.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 1/2] toaster: enable remote HTTP API for status aggregation
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
X-List-Received-Date: Sat, 29 Jul 2017 00:22:45 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Add support for Toaster aggregators with a set of api links that
return JSON data for (a) builds in progress, (b) builds completed,
(c) specific build data, and (d) an is-alive health ping link.

[YOCTO #11794]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/templates/health.html |  6 ++
 lib/toaster/toastergui/urls.py               |  7 ++-
 lib/toaster/toastergui/views.py              | 86 +++++++++++++++++++++++++++-
 lib/toaster/toastermain/urls.py              |  5 +-
 4 files changed, 100 insertions(+), 4 deletions(-)
 create mode 100644 bitbake/lib/toaster/toastergui/templates/health.html

diff --git a/lib/toaster/toastergui/templates/health.html b/lib/toaster/toastergui/templates/health.html
new file mode 100644
index 0000000..f17fdbc
--- /dev/null
+++ b/lib/toaster/toastergui/templates/health.html
@@ -0,0 +1,6 @@
+<!DOCTYPE html>
+<html lang="en">
+  <head><title>Toaster Health</title></head>
+  <body>Ok</body>
+</html>
+
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 6aebc3f..3ad5566 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -244,6 +244,11 @@ urlpatterns = [
         url(r'^mostrecentbuilds$', widgets.MostRecentBuildsView.as_view(),
             name='most_recent_builds'),
 
-          # default redirection
+        # JSON data for aggregators
+        url(r'^api/builds$', views.json_builds, name='json_builds'),
+        url(r'^api/building$', views.json_building, name='json_building'),
+        url(r'^api/build/(?P<build_id>\d+)$', views.json_build, name='json_build'),
+
+        # default redirection
         url(r'^$', RedirectView.as_view(url='landing', permanent=True)),
 ]
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 5720b9d..334bb4a 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -35,7 +35,7 @@ from orm.models import BitbakeVersion, CustomImageRecipe
 from django.core.urlresolvers import reverse, resolve
 from django.core.exceptions import MultipleObjectsReturned, ObjectDoesNotExist
 from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
-from django.http import HttpResponseNotFound
+from django.http import HttpResponseNotFound, JsonResponse
 from django.utils import timezone
 from datetime import timedelta, datetime
 from toastergui.templatetags.projecttags import json as jsonfilter
@@ -1256,6 +1256,89 @@ def managedcontextprocessor(request):
     }
     return ret
 
+# REST-based API calls to return build/building status to external Toaster
+# managers and aggregators via JSON
+
+def _json_build_status(build_id,extend):
+    build_stat = None
+    try:
+        build = Build.objects.get( pk = build_id )
+        build_stat = {}
+        build_stat['id'] = build.id
+        build_stat['name'] = build.build_name
+        build_stat['machine'] = build.machine
+        build_stat['distro'] = build.distro
+        build_stat['start'] = build.started_on
+        # look up target name
+        target= Target.objects.get( build = build )
+        if target:
+            if target.task:
+                build_stat['target'] = '%s:%s' % (target.target,target.task)
+            else:
+                build_stat['target'] = '%s' % (target.target)
+        else:
+            build_stat['target'] = ''
+        # look up project name
+        project = Project.objects.get( build = build )
+        if project:
+            build_stat['project'] = project.name
+        else:
+            build_stat['project'] = ''
+        if Build.IN_PROGRESS == build.outcome:
+            now = timezone.now()
+            timediff = now - build.started_on
+            build_stat['seconds']='%.3f' % timediff.total_seconds()
+            build_stat['clone']='%d:%d' % (build.repos_cloned,build.repos_to_clone)
+            build_stat['parse']='%d:%d' % (build.recipes_parsed,build.recipes_to_parse)
+            tf = Task.objects.filter(build = build)
+            tfc = tf.count()
+            if tfc > 0:
+                tfd = tf.exclude(order__isnull=True).count()
+            else:
+                tfd = 0
+            build_stat['task']='%d:%d' % (tfd,tfc)
+        else:
+            build_stat['outcome'] = build.get_outcome_text()
+            timediff = build.completed_on - build.started_on
+            build_stat['seconds']='%.3f' % timediff.total_seconds()
+            build_stat['stop'] = build.completed_on
+            messages = LogMessage.objects.all().filter(build = build)
+            errors = len(messages.filter(level=LogMessage.ERROR) |
+                 messages.filter(level=LogMessage.EXCEPTION) |
+                 messages.filter(level=LogMessage.CRITICAL))
+            build_stat['errors'] = errors
+            warnings = len(messages.filter(level=LogMessage.WARNING))
+            build_stat['warnings'] = warnings
+        if extend:
+            build_stat['cooker_log'] = build.cooker_log_path
+    except Exception as e:
+        build_state = str(e)
+    return build_stat
+
+def json_builds(request):
+    build_table = []
+    builds = []
+    try:
+        builds = Build.objects.exclude(outcome=Build.IN_PROGRESS).order_by("-started_on")
+        for build in builds:
+            build_table.append(_json_build_status(build.id,False))
+    except Exception as e:
+        build_table = str(e)
+    return JsonResponse({'builds' : build_table, 'count' : len(builds)})
+
+def json_building(request):
+    build_table = []
+    builds = []
+    try:
+        builds = Build.objects.filter(outcome=Build.IN_PROGRESS).order_by("-started_on")
+        for build in builds:
+            build_table.append(_json_build_status(build.id,False))
+    except Exception as e:
+        build_table = str(e)
+    return JsonResponse({'building' : build_table, 'count' : len(builds)})
+
+def json_build(request,build_id):
+    return JsonResponse({'build' : _json_build_status(build_id,True)})
 
 
 import toastermain.settings
@@ -1694,3 +1777,4 @@ if True:
                 return render(request, "unavailable_artifact.html")
         except (ObjectDoesNotExist, IOError):
             return render(request, "unavailable_artifact.html")
+
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls.py
index bb32559..6750bdf 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -20,9 +20,8 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.conf.urls import patterns, include, url
-from django.views.generic import RedirectView
+from django.views.generic import RedirectView, TemplateView
 from django.views.decorators.cache import never_cache
-
 import bldcollector.views
 
 import logging
@@ -46,6 +45,8 @@ urlpatterns = [
     # in the future.
     url(r'^orm/eventfile$', bldcollector.views.eventfile),
 
+    url(r'^health$', TemplateView.as_view(template_name="health.html"), name='Toaster Health'),
+
     # if no application is selected, we have the magic toastergui app here
     url(r'^$', never_cache(RedirectView.as_view(url='/toastergui/', permanent=True))),
 ]
-- 
1.9.1


