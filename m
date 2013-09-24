Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 3DE046CAF6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:09 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 24 Sep 2013 09:53:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="382902458"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga001.jf.intel.com with ESMTP; 24 Sep 2013 09:53:10 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id E6A51562275; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:13 +0100
Message-Id: <22462956f2759c325a41c9b46e4e867e967e1740.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 44/94] bitbake: webhob: add search for build model
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:09 -0000

From: Calin Dragomir <calinx.l.dragomir@intel.com>

This patch enables search on the build model. However, the
search can be executed only on a predefined list of fields
allowed to be searched.

Signed-off-by: Calin Dragomir <calinx.l.dragomir@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/views.py | 17 +++++++++++++++++
 bitbake/lib/webhob/orm/models.py      |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index 3ef6940..423fdf7 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -1,3 +1,6 @@
+import operator
+
+from django.db.models import Q
 from django.shortcuts import render
 from orm.models import Build, Task, Layer, Layer_Version, Task_Dependency, Recipe, Package
 
@@ -93,6 +96,8 @@ def model_explorer(request, model_name):
     if invalid:
         return HttpResponseBadRequest()
 
+    search_term = request.GET.get('search', '')
+
     if filter_string:
         filter_terms = _get_filtering_terms(filter_string)
         try:
@@ -102,6 +107,9 @@ def model_explorer(request, model_name):
     else:
         queryset = model.objects.all()
 
+    if search_term:
+        queryset = _get_search_results(search_term, queryset, model)
+
     if offset and limit:
         queryset = queryset[offset:(offset+limit)]
     elif offset:
@@ -159,3 +167,12 @@ def _validate_input(input, model):
                 return None, invalid
 
     return input, invalid
+
+def _get_search_results(search_term, queryset, model):
+    q_map = map(lambda x: Q(**{x+'__icontains': search_term}),
+                model.search_allowed_fields)
+
+    search_object = reduce(operator.or_, q_map)
+    queryset = queryset.filter(search_object)
+
+    return queryset
diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
index 0d6cf15..a4721db 100644
--- a/bitbake/lib/webhob/orm/models.py
+++ b/bitbake/lib/webhob/orm/models.py
@@ -12,6 +12,9 @@ class Build(models.Model):
         (IN_PROGRESS, 'In Progress'),
     )
 
+    search_allowed_fields = ['target', 'machine__name',
+                             'cooker_log_path', 'image_fstypes']
+
     uuid = models.CharField(max_length=100, unique=True)
     target = models.CharField(max_length=100)
     is_image = models.BooleanField(default = False)
-- 
1.8.1.2


