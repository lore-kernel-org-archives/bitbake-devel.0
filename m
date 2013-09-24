Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id DC71E6CB7A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:19 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 24 Sep 2013 09:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; 
	d="scan'208,217";a="364948550"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:11 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 2261A5628C9; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:31 +0100
Message-Id: <b9b020b217ab7e13193e670b2d834e56edc282fc.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 62/94] bitbake: webhob: add toggle column functionality to build page
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

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add demo toggle column functionality for the Simple interface,
webhob builds page.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/templates/base.html  | 15 +++++++++++++++
 bitbake/lib/webhob/bldviewer/templates/build.html |  6 ++++++
 bitbake/lib/webhob/bldviewer/views.py             |  3 ++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/webhob/bldviewer/templates/base.html b/bitbake/lib/webhob/bldviewer/templates/base.html
index ab3c3b7..3f056a0 100644
--- a/bitbake/lib/webhob/bldviewer/templates/base.html
+++ b/bitbake/lib/webhob/bldviewer/templates/base.html
@@ -3,9 +3,24 @@
 <html>
 	<head>
 		<title>WebHob Simple Explorer</title>
+<script src="/static/js/jquery-2.0.3.js">
+</script>
+<script src="/static/js/bootstrap.js">
+</script>
+<link href="/static/css/bootstrap.css" rel="stylesheet" type="text/css">
 	</head>
 
 <body>
+<script>
+function showhideTableColumn(i, sh) {
+    if (sh)
+        $('td:nth-child('+i+'),th:nth-child('+i+')').show();
+    else
+        $('td:nth-child('+i+'),th:nth-child('+i+')').hide();
+g
+}
+</script>
+
 <div>Menu: <a href="/simple/build/">All Builds</a>&nbsp;|&nbsp;<a href="/simple/layer/">All Layers</a>
 </div>
 {% block pagecontent %}
diff --git a/bitbake/lib/webhob/bldviewer/templates/build.html b/bitbake/lib/webhob/bldviewer/templates/build.html
index 20aa310..e30801b 100644
--- a/bitbake/lib/webhob/bldviewer/templates/build.html
+++ b/bitbake/lib/webhob/bldviewer/templates/build.html
@@ -5,6 +5,12 @@
 
     <table border="1">
 
+<div align="right" style="display: float">Show/Hide columns:
+<span>Output: <input type="checkbox" id="ctoutput" onchange="showhideTableColumn(10, $('#ctoutput').is(':checked'))" checked autocomplete="off"></span> |
+<span>Log: <input type="checkbox" id="ctlog" onchange="showhideTableColumn(11, $('#ctlog').is(':checked'))"checked autocomplete="off"></span> |
+<span>Build Name: <input type="checkbox" id="ctbuildname" onchange="showhideTableColumn(13, $('#ctbuildname').is(':checked'))" checked autocomplete="off"></span> |
+</div>
+
     {% load projecttags %}
 
         <tr>
diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index 7f97312..ab69c91 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -4,8 +4,9 @@ from django.db.models import Q
 from django.shortcuts import render
 from orm.models import Build, Task, Layer, Layer_Version, Recipe, Package, LogMessage
 from orm.models import Task_Dependency, Package_Dependency
+from django.views.decorators.cache import cache_control
 
-
+@cache_control(no_store=True)
 def build(request):
     template = 'build.html'
     build_info = Build.objects.all()
-- 
1.8.1.2


