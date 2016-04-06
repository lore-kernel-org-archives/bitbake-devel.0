Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id 20E747718D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:26 +0000 (UTC)
Received: by mail-wm0-f43.google.com with SMTP id f198so81803923wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=Vxksuo8oxAjXnf1uVLbM/dY0SZK8zeKwCp69CvH5g0g=;
	b=k5K7kxj4bFppbYiSSGSfRehvpjQgyG3I3ahRV0ITgwCE+6oUOa6Pvlj0Lq2eQjwlRk
	aKufljXcb9gVeQrmZuthn4c3bVTxL8v/r07N0LPBgJ1l77+OLDdJWzVYrxU6iBzEcLvW
	fL4lBTtk7BWuTjm+8iTGnpDeVfyyIejrgjlh4jyMCQdSeY/0q8S9JKF7loZC7CyDzoVA
	ScYrIwhuy2rwW0PbJhl8mDDLVjZP7bgjpWKFB+m3gDoI0JK1sDIhciHF8YPuGzWdXhKl
	mf6beaFNPVb7XZtP7Udiit3WfJoEJkzqGLgKyTvGpzTeJrRyoQTUQdRI4SVKH+Y5w6Hx
	z3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Vxksuo8oxAjXnf1uVLbM/dY0SZK8zeKwCp69CvH5g0g=;
	b=F7gEGWmZTp2z7j7tTQi7tAe9pHlzyFWB7Z9PHF1SAuhn3PWY7LlM/fc+4+gteZq1ft
	2+pEgi6aI44eYgEGb8+N4u98hMz4Wvv1CaLp16bEBHyNs01np7x0JmgC4QHacZ/5Jcfk
	0td0QOhM0OXFLl8cFwT/7aBcjLvJ1mbOGeRg3b+aKIsnfhzAFCauDJ07A+aq1KmhCbdh
	boMzlboihsw+PqxP0U6ldjbtZVQQUMjyiZ+ci3q6eUj8eG/vK/EEVNDnA6gZ2TWfVzNp
	StI0Qo+WnVdOuJc0h/vV7IfpSZAD1CI+OOqy9rvtrHpdW0lDrZDL6ux0T3y0tl64zIpy
	fOpw==
X-Gm-Message-State: AD7BkJIl0nsw35vpi3J2cSveKWgNAJ9VEGF2UC1p3Iit0qCtd/0rqrNfBZf4i/F9JCdfpg4j
X-Received: by 10.194.186.242 with SMTP id fn18mr3866429wjc.65.1459961246691; 
	Wed, 06 Apr 2016 09:47:26 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.25
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:26 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:30 +0100
Message-Id: <1adc36f8a9c9847a51c4b3cfd3005ca3cc5ebd5a.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 20/38] toaster: Move xhr calls for starting and stopping builds
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:26 -0000

Move the backend xhr implementation of the build request changes
into it's own file and out of the ToasterTable definition.
It used to live in the views.py but in a hope of starting to collate logical
groups of views move this to a new file called api.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/api.py    | 74 ++++++++++++++++++++++++++++++++++++++++
 lib/toaster/toastergui/tables.py | 43 +----------------------
 lib/toaster/toastergui/urls.py   |  5 +++
 3 files changed, 80 insertions(+), 42 deletions(-)
 create mode 100644 bitbake/lib/toaster/toastergui/api.py

diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
new file mode 100644
index 0000000..1b1f598
--- /dev/null
+++ b/lib/toaster/toastergui/api.py
@@ -0,0 +1,74 @@
+#
+# BitBake Toaster Implementation
+#
+# Copyright (C) 2016        Intel Corporation
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
+
+# Temporary home for the UI's misc API
+
+from orm.models import Project, ProjectTarget
+from bldcontrol.models import BuildRequest
+from bldcontrol import bbcontroller
+from django.http import HttpResponse, JsonResponse
+from django.views.generic import View
+
+
+class XhrBuildRequest(View):
+
+    def get(self, request, *args, **kwargs):
+        return HttpResponse()
+
+    def post(self, request, *args, **kwargs):
+        """ Process HTTP POSTs which make build requests """
+
+        project = Project.objects.get(pk=kwargs['pid'])
+
+        if 'buildCancel' in request.POST:
+            for i in request.POST['buildCancel'].strip().split(" "):
+                try:
+                    br = BuildRequest.objects.select_for_update().get(project = project, pk = i, state__lte = BuildRequest.REQ_QUEUED)
+                    br.state = BuildRequest.REQ_DELETED
+                    br.save()
+                except BuildRequest.DoesNotExist:
+                    pass
+
+        if 'buildDelete' in request.POST:
+            for i in request.POST['buildDelete'].strip().split(" "):
+                try:
+                    BuildRequest.objects.select_for_update().get(project = project, pk = i, state__lte = BuildRequest.REQ_DELETED).delete()
+                except BuildRequest.DoesNotExist:
+                    pass
+
+        if 'targets' in request.POST:
+            ProjectTarget.objects.filter(project = project).delete()
+            s = str(request.POST['targets'])
+            for t in s.translate(None, ";%|\"").split(" "):
+                if ":" in t:
+                    target, task = t.split(":")
+                else:
+                    target = t
+                    task = ""
+                ProjectTarget.objects.create(project = project,
+                                             target = target,
+                                             task = task)
+            project.schedule_build()
+
+        # redirect back to builds page so any new builds in progress etc.
+        # are visible
+        response = HttpResponse()
+        response.status_code = 302
+        response['Location'] = request.build_absolute_uri()
+        return response
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index c677ec5..3340e05 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -22,7 +22,7 @@
 from toastergui.widgets import ToasterTable
 from orm.models import Recipe, ProjectLayer, Layer_Version, Machine, Project
 from orm.models import CustomImageRecipe, Package, Target, Build, LogMessage, Task
-from orm.models import CustomImagePackage, ProjectTarget
+from orm.models import CustomImagePackage
 from django.db.models import Q, Max, Sum, Count, When, Case, Value, IntegerField
 from django.conf.urls import url
 from django.core.urlresolvers import reverse, resolve
@@ -1406,47 +1406,6 @@ class BuildsTable(ToasterTable):
         failed_tasks_filter.add_action(without_failed_tasks_action)
         self.add_filter(failed_tasks_filter)
 
-    def post(self, request, *args, **kwargs):
-        """ Process HTTP POSTs which make build requests """
-
-        project = Project.objects.get(pk=kwargs['pid'])
-
-        if 'buildCancel' in request.POST:
-            for i in request.POST['buildCancel'].strip().split(" "):
-                try:
-                    br = BuildRequest.objects.select_for_update().get(project = project, pk = i, state__lte = BuildRequest.REQ_QUEUED)
-                    br.state = BuildRequest.REQ_DELETED
-                    br.save()
-                except BuildRequest.DoesNotExist:
-                    pass
-
-        if 'buildDelete' in request.POST:
-            for i in request.POST['buildDelete'].strip().split(" "):
-                try:
-                    BuildRequest.objects.select_for_update().get(project = project, pk = i, state__lte = BuildRequest.REQ_DELETED).delete()
-                except BuildRequest.DoesNotExist:
-                    pass
-
-        if 'targets' in request.POST:
-            ProjectTarget.objects.filter(project = project).delete()
-            s = str(request.POST['targets'])
-            for t in s.translate(None, ";%|\"").split(" "):
-                if ":" in t:
-                    target, task = t.split(":")
-                else:
-                    target = t
-                    task = ""
-                ProjectTarget.objects.create(project = project,
-                                             target = target,
-                                             task = task)
-            project.schedule_build()
-
-        # redirect back to builds page so any new builds in progress etc.
-        # are visible
-        response = HttpResponse()
-        response.status_code = 302
-        response['Location'] = request.build_absolute_uri()
-        return response
 
 class AllBuildsTable(BuildsTable):
     """ Builds page for all builds """
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 400580a..27b0baa 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -22,6 +22,7 @@ from django.views.generic import RedirectView, TemplateView
 from django.http import HttpResponseBadRequest
 from toastergui import tables
 from toastergui import typeaheads
+from toastergui import api
 
 urlpatterns = patterns('toastergui.views',
         # landing page
@@ -180,6 +181,10 @@ urlpatterns = patterns('toastergui.views',
         url(r'^xhr_customrecipe/', 'xhr_customrecipe',
             name='xhr_customrecipe'),
 
+        url(r'^xhr_buildrequest/project/(?P<pid>\d+)$',
+           api.XhrBuildRequest.as_view(),
+            name='xhr_buildrequest'),
+
           # default redirection
         url(r'^$', RedirectView.as_view(url='landing', permanent=True)),
 )
-- 
2.1.4


