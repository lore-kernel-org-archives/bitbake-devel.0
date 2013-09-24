Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id A4B876CB39
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:10 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 24 Sep 2013 09:53:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="382902478"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga001.jf.intel.com with ESMTP; 24 Sep 2013 09:53:11 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 28F1F56282F; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:33 +0100
Message-Id: <c03ca7597847bb1f902e4cdbff744f44a0fe811f.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 64/94] bitbake: webhob: refactor column hiding code
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:11 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We're refactoring the column show/hide code to get it
more generic, and easier to apply it to all table pages.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/templates/build.html | 6 +++---
 bitbake/lib/webhob/bldviewer/views.py             | 6 +++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/webhob/bldviewer/templates/build.html b/bitbake/lib/webhob/bldviewer/templates/build.html
index aa92929..5db72db 100644
--- a/bitbake/lib/webhob/bldviewer/templates/build.html
+++ b/bitbake/lib/webhob/bldviewer/templates/build.html
@@ -7,9 +7,9 @@
 <div align="left" style="display:inline-block; width: 49%"> Search: <input type="search" id="filterstring" style="width: 30em" onkeyup="filterTableRows($('#filterstring').val())" autocomplete="off">
 </div>
 <div align="right" style="display: inline-block; width: 49%">Show/Hide columns:
-<span>Output: <input type="checkbox" id="ctoutput" onchange="showhideTableColumn(10, $('#ctoutput').is(':checked'))" checked autocomplete="off"></span> |
-<span>Log: <input type="checkbox" id="ctlog" onchange="showhideTableColumn(11, $('#ctlog').is(':checked'))"checked autocomplete="off"></span> |
-<span>Build Name: <input type="checkbox" id="ctbuildname" onchange="showhideTableColumn(13, $('#ctbuildname').is(':checked'))" checked autocomplete="off"></span> |
+{% for i in hideshowcols %}
+    <span>{{i.name}} <input type="checkbox" id="ct{{i.name}}" onchange="showhideTableColumn({{i.order}}, $('#ct{{i.name}}').is(':checked'))" checked autocomplete="off"></span> |
+{% endfor %}
 </div>
 </div>
     <table border="1">
diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index ab69c91..2ef905a 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -12,7 +12,11 @@ def build(request):
     build_info = Build.objects.all()
     logs = LogMessage.objects.all()
 
-    context = {'builds': build_info, 'logs': logs }
+    context = {'builds': build_info, 'logs': logs , 
+        'hideshowcols' : [
+                {'name': 'Output', 'order':10},
+                {'name': 'Log', 'order':11},
+            ]}
 
     return render(request, template, context)
 
-- 
1.8.1.2


