Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 5AAF76CB80
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:19 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 24 Sep 2013 09:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; d="scan'208";a="364948524"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:09 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id D66FB561D59; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:07 +0100
Message-Id: <58cab4377ea911bcd7eeeb38132e962f481972db.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 38/94] bitbake: webhob: validate inputs for build api
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:20 -0000

From: Calin Dragomir <calinx.l.dragomir@intel.com>

This patch validates the inputs for the build api
by checking the following:
- have only one colon;
- have equal number of terms on both sides of the colon;
- left side terms must be part of the Django model fields.

Signed-off-by: Calin Dragomir <calinx.l.dragomir@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/views.py | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index 71e95b4..a71aebc 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -52,7 +52,7 @@ def layer_versions_recipes(request, layerversion_id):
 
 import json
 from django.core import serializers
-from django.http import HttpResponse
+from django.http import HttpResponse, HttpResponseBadRequest
 
 
 def builds(request):
@@ -69,8 +69,13 @@ def builds(request):
     except ValueError:
         offset = 0
 
-    ordering_string = request.GET.get('orderby', '')
-    filter_string = request.GET.get('filter', '')
+    ordering_string, invalid = _validate_input(request.GET.get('orderby', ''))
+    if invalid:
+        return HttpResponseBadRequest()
+
+    filter_string, invalid = _validate_input(request.GET.get('filter', ''))
+    if invalid:
+        return HttpResponseBadRequest()
 
     if filter_string:
         filter_terms = _get_filtering_terms(filter_string)
@@ -111,3 +116,25 @@ def _get_filtering_terms(filter_string):
     values = search_terms[1].split(',')
 
     return dict(zip(keys, values))
+
+def _validate_input(input):
+    invalid = 0
+
+    if input:
+        input_list = input.split(":")
+
+        # Check we have only one colon
+        if len(input.split(":")) != 2:
+            invalid = 1
+
+        # Check we have an equal number of terms both sides of the colon
+        if len(input_list[0].split(',')) != len(input_list[1].split(',')):
+            invalid = 1
+
+        # Check we are looking for a valid field
+        valid_fields = Build._meta.get_all_field_names()
+        for field in input_list[0].split(','):
+            if field not in valid_fields:
+                invalid = 1
+
+    return input, invalid
-- 
1.8.1.2


