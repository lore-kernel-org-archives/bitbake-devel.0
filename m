Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 5F5356CB6D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:13 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 24 Sep 2013 09:53:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="298814592"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by AZSMGA002.ch.intel.com with ESMTP; 24 Sep 2013 09:53:10 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id E97755622B8; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:14 +0100
Message-Id: <7603f3f6b9428b1bde94073522643b3fc8a03188.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Subject: [PATCH 45/94] bitbake: webhob: fix ordering issue
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:14 -0000

From: Calin Dragomir <calinx.l.dragomir@intel.com>

This patch fixes the AssertionError issue that caused the
build page to break.
This happened because ordering cannot be done after a slicing
operation has been executed.
By placing the ordering before the slicing occurs, the issue
stops appearing.

Signed-off-by: Calin Dragomir <calinx.l.dragomir@intel.com>

Conflicts:
	bitbake/lib/webhob/bldviewer/views.py
---
 bitbake/lib/webhob/bldviewer/views.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index 423fdf7..a5c4387 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -110,6 +110,13 @@ def model_explorer(request, model_name):
     if search_term:
         queryset = _get_search_results(search_term, queryset, model)
 
+    if ordering_string and queryset:
+        column, order = ordering_string.split(':')
+        if order.lower() == DESCENDING:
+            queryset = queryset.order_by('-' + column)
+        else:
+            queryset = queryset.order_by(column)
+
     if offset and limit:
         queryset = queryset[offset:(offset+limit)]
     elif offset:
@@ -122,13 +129,6 @@ def model_explorer(request, model_name):
     else:
         response_data['count'] = 0
 
-    if queryset and ordering_string:
-        column, order = ordering_string.split(':')
-        if order.lower() == DESCENDING:
-            queryset = queryset.order_by('-' + column)
-        else:
-            queryset = queryset.order_by(column)
-
     response_data['list'] = serializers.serialize('json', queryset)
 
     return HttpResponse(json.dumps(response_data),
-- 
1.8.1.2


