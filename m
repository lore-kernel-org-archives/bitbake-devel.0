Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id C6F5A6CB17
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:19 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; d="scan'208";a="364948528"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:09 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id D8A7D562059; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:08 +0100
Message-Id: <cb443e01054e762308f2deb2a0ca68d1d246151a.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 39/94] bitbake: webhob: generic view for multiple models
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:22 -0000

From: Calin Dragomir <calinx.l.dragomir@intel.com>

This patch creates a generic view that supports multiple
models. It allows exploration of the fields of the models and
it has validation of inputs given.

Also avoids code replication.

Signed-off-by: Calin Dragomir <calinx.l.dragomir@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>

Conflicts:
	bitbake/lib/webhob/bldviewer/views.py
---
 bitbake/lib/webhob/bldviewer/api.py   |  4 +++-
 bitbake/lib/webhob/bldviewer/views.py | 33 ++++++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/webhob/bldviewer/api.py b/bitbake/lib/webhob/bldviewer/api.py
index d945861..3b2d7d2 100644
--- a/bitbake/lib/webhob/bldviewer/api.py
+++ b/bitbake/lib/webhob/bldviewer/api.py
@@ -2,5 +2,7 @@ from django.conf.urls import patterns, include, url
 
 
 urlpatterns = patterns('bldviewer.views',
-        url(r'^builds/$', 'builds', name='builds'),
+        url(r'^builds/$', 'model_explorer',  {'model_name':'build'}, name='builds'),
+        url(r'^tasks/$', 'model_explorer', {'model_name':'task'}, name='task'),
+        url(r'^packages/$', 'model_explorer', {'model_name':'package'}, name='package'),
 )
diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index a71aebc..73f7ba7 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -1,5 +1,5 @@
 from django.shortcuts import render
-from orm.models import Build, Task, Layer, Layer_Version, Task_Dependency, Recipe
+from orm.models import Build, Task, Layer, Layer_Version, Task_Dependency, Recipe, Package
 
 
 def build(request):
@@ -55,9 +55,20 @@ from django.core import serializers
 from django.http import HttpResponse, HttpResponseBadRequest
 
 
-def builds(request):
+def model_explorer(request, model_name):
+
     DESCENDING = 'desc'
     response_data = {}
+    model_mapping = {
+        'build': Build,
+        'task': Task,
+        'package': Package,
+        }
+
+    if model_name not in model_mapping.keys():
+        return HttpResponseBadRequest()
+
+    model = model_mapping[model_name]
 
     try:
         limit = int(request.GET.get('limit', 0))
@@ -69,22 +80,24 @@ def builds(request):
     except ValueError:
         offset = 0
 
-    ordering_string, invalid = _validate_input(request.GET.get('orderby', ''))
+    ordering_string, invalid = _validate_input(request.GET.get('orderby', ''),
+                                               model)
     if invalid:
         return HttpResponseBadRequest()
 
-    filter_string, invalid = _validate_input(request.GET.get('filter', ''))
+    filter_string, invalid = _validate_input(request.GET.get('filter', ''),
+                                             model)
     if invalid:
         return HttpResponseBadRequest()
 
     if filter_string:
         filter_terms = _get_filtering_terms(filter_string)
         try:
-            queryset = Build.objects.filter(**filter_terms)
+            queryset = model.objects.filter(**filter_terms)
         except ValueError:
             queryset = []
     else:
-        queryset = Build.objects.all()
+        queryset = model.objects.all()
 
     if offset and limit:
         queryset = queryset[offset:(offset+limit)]
@@ -107,7 +120,8 @@ def builds(request):
 
     response_data['list'] = serializers.serialize('json', queryset)
 
-    return HttpResponse(json.dumps(response_data), content_type='application/json')
+    return HttpResponse(json.dumps(response_data),
+                        content_type='application/json')
 
 def _get_filtering_terms(filter_string):
 
@@ -117,7 +131,8 @@ def _get_filtering_terms(filter_string):
 
     return dict(zip(keys, values))
 
-def _validate_input(input):
+def _validate_input(input, model):
+
     invalid = 0
 
     if input:
@@ -132,7 +147,7 @@ def _validate_input(input):
             invalid = 1
 
         # Check we are looking for a valid field
-        valid_fields = Build._meta.get_all_field_names()
+        valid_fields = model._meta.get_all_field_names()
         for field in input_list[0].split(','):
             if field not in valid_fields:
                 invalid = 1
-- 
1.8.1.2


