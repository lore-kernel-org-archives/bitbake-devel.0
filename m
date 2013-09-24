Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 1B72E6CB83
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:14 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="298814583"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by AZSMGA002.ch.intel.com with ESMTP; 24 Sep 2013 09:53:10 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id D4972561CD5; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:06 +0100
Message-Id: <e4e474555f58ddc71a78da96ff6269a964329899.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 37/94] bitbake: webhob: add ordering capabilities to build api
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:15 -0000

From: Calin Dragomir <calinx.l.dragomir@intel.com>

This patch adds the capability to order builds by a specific
field of the build model.
The format used is 'field_name:order' and the default ordering
is ascending.

Signed-off-by: Calin Dragomir <calinx.l.dragomir@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/views.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index de89b84..71e95b4 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -56,6 +56,7 @@ from django.http import HttpResponse
 
 
 def builds(request):
+    DESCENDING = 'desc'
     response_data = {}
 
     try:
@@ -68,6 +69,7 @@ def builds(request):
     except ValueError:
         offset = 0
 
+    ordering_string = request.GET.get('orderby', '')
     filter_string = request.GET.get('filter', '')
 
     if filter_string:
@@ -91,6 +93,13 @@ def builds(request):
     else:
         response_data['count'] = 0
 
+    if queryset and ordering_string:
+        column, order = ordering_string.split(':')
+        if order.lower() == DESCENDING:
+            queryset = queryset.order_by('-' + column)
+        else:
+            queryset = queryset.order_by(column)
+
     response_data['list'] = serializers.serialize('json', queryset)
 
     return HttpResponse(json.dumps(response_data), content_type='application/json')
-- 
1.8.1.2


