Return-Path: <ddalex@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id CE4216CC63
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:29 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 24 Sep 2013 09:53:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="406511873"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2013 09:53:09 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id C322B56180C; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:59 +0100
Message-Id: <7e90fce7d6081702591ebca0be119371a3514937.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 30/94] bitbake: webhob: Setup API for build model
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:30 -0000

From: Calin Dragomir <calinx.l.dragomir@intel.com>

Adding REST API version 1.0 interface of WebHob.

Build call API is implemented in this patch
Documentation is here:
https://wiki.yoctoproject.org/wiki/Webhob_REST_API_Builds

Signed-off-by: Calin Dragomir <calinx.l.dragomir@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/api.py   |  6 ++++
 bitbake/lib/webhob/bldviewer/views.py | 56 +++++++++++++++++++++++++++++++++++
 bitbake/lib/webhob/whbmain/urls.py    |  1 +
 3 files changed, 63 insertions(+)
 create mode 100644 bitbake/lib/webhob/bldviewer/api.py

diff --git a/bitbake/lib/webhob/bldviewer/api.py b/bitbake/lib/webhob/bldviewer/api.py
new file mode 100644
index 0000000..d945861
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/api.py
@@ -0,0 +1,6 @@
+from django.conf.urls import patterns, include, url
+
+
+urlpatterns = patterns('bldviewer.views',
+        url(r'^builds/$', 'builds', name='builds'),
+)
diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index eb901a4..58d9444 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -33,3 +33,59 @@ def layer(request):
     context = {'layers': layer_info}
 
     return render(request, template, context)
+
+
+#### API
+
+import json
+from django.core import serializers
+from django.http import HttpResponse
+
+
+def builds(request):
+    response_data = {}
+
+    try:
+        limit = int(request.GET.get('limit', 0))
+    except ValueError:
+        limit = 0
+
+    try:
+        offset = int(request.GET.get('offset', 0))
+    except ValueError:
+        offset = 0
+
+    filter_string = request.GET.get('filter', '')
+
+    if filter_string:
+        filter_terms = _get_filtering_terms(filter_string)
+        try:
+            queryset = Build.objects.filter(**filter_terms)
+        except ValueError:
+            queryset = []
+    else:
+        queryset = Build.objects.all()
+
+    if offset and limit:
+        queryset = queryset[offset:(offset+limit)]
+    elif offset:
+        queryset = queryset[offset:]
+    elif limit:
+        queryset = queryset[:limit]
+
+    if queryset:
+        response_data['count'] = queryset.count()
+    else:
+        response_data['count'] = 0
+
+    response_data['list'] = serializers.serialize('json', queryset)
+
+    return HttpResponse(json.dumps(response_data), content_type='application/json')
+
+def _get_filtering_terms(filter_string):
+
+    search_terms = filter_string.split(":")
+    keys = search_terms[0].split(',')
+    values = search_terms[1].split(',')
+
+    return dict(zip(keys, values))
diff --git a/bitbake/lib/webhob/whbmain/urls.py b/bitbake/lib/webhob/whbmain/urls.py
index af536aa..14345f6 100644
--- a/bitbake/lib/webhob/whbmain/urls.py
+++ b/bitbake/lib/webhob/whbmain/urls.py
@@ -6,6 +6,7 @@ from django.conf.urls import patterns, include, url
 
 urlpatterns = patterns('',
     url(r'^build/', include('bldviewer.urls')),
+    url(r'^api/1.0/', include('bldviewer.api')),
     url(r'^gui/', include('whbgui.urls')),
     # Examples:
     # url(r'^webhob/', include('webhob.foo.urls')),
-- 
1.8.1.2


