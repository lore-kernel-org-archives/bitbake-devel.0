Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id D11B66CB4E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:10 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 24 Sep 2013 09:53:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="382902480"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga001.jf.intel.com with ESMTP; 24 Sep 2013 09:53:11 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 25829560F55; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:32 +0100
Message-Id: <97735b2a1b5e37ff1962901c1776606b7db429c8.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 63/94] bitbake: webhob: add search functionality to the Simple interface
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

We add generic table search function for the builds table,
and make it generic to be able to expand to all other table views.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/templates/base.html    | 12 +++++++++++-
 bitbake/lib/webhob/bldviewer/templates/build.html   | 12 +++++++-----
 bitbake/lib/webhob/bldviewer/templates/package.html |  2 +-
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/webhob/bldviewer/templates/base.html b/bitbake/lib/webhob/bldviewer/templates/base.html
index 3f056a0..45f8652 100644
--- a/bitbake/lib/webhob/bldviewer/templates/base.html
+++ b/bitbake/lib/webhob/bldviewer/templates/base.html
@@ -17,7 +17,17 @@ function showhideTableColumn(i, sh) {
         $('td:nth-child('+i+'),th:nth-child('+i+')').show();
     else
         $('td:nth-child('+i+'),th:nth-child('+i+')').hide();
-g
+}
+
+
+function filterTableRows(test) {
+    if (test.length > 0) {
+        var r = new RegExp(test);
+        $('tr.data').map( function (i, el) { if (! r.test($(el).html())) {$(el).hide()} else $(el).show()});
+    } else
+    {
+        $('tr.data').show();
+    }
 }
 </script>
 
diff --git a/bitbake/lib/webhob/bldviewer/templates/build.html b/bitbake/lib/webhob/bldviewer/templates/build.html
index e30801b..aa92929 100644
--- a/bitbake/lib/webhob/bldviewer/templates/build.html
+++ b/bitbake/lib/webhob/bldviewer/templates/build.html
@@ -3,14 +3,16 @@
 {% block pagecontent %}
     <h1>WebHob Builds</h1>
 
-    <table border="1">
-
-<div align="right" style="display: float">Show/Hide columns:
+<div style="padding-top:1em ;padding-bottom: 1em">
+<div align="left" style="display:inline-block; width: 49%"> Search: <input type="search" id="filterstring" style="width: 30em" onkeyup="filterTableRows($('#filterstring').val())" autocomplete="off">
+</div>
+<div align="right" style="display: inline-block; width: 49%">Show/Hide columns:
 <span>Output: <input type="checkbox" id="ctoutput" onchange="showhideTableColumn(10, $('#ctoutput').is(':checked'))" checked autocomplete="off"></span> |
 <span>Log: <input type="checkbox" id="ctlog" onchange="showhideTableColumn(11, $('#ctlog').is(':checked'))"checked autocomplete="off"></span> |
 <span>Build Name: <input type="checkbox" id="ctbuildname" onchange="showhideTableColumn(13, $('#ctbuildname').is(':checked'))" checked autocomplete="off"></span> |
 </div>
-
+</div>
+    <table border="1">
     {% load projecttags %}
 
         <tr>
@@ -31,7 +33,7 @@
 
         {% for build in builds %}
 
-        <tr>
+        <tr class="data">
             <td><a href="/simple/build/{{build.id}}/task/">{{build.get_outcome_display}}</a></td>
             <td>{{build.started_on}}</td>
             <td>{{build.completed_on}}</td>
diff --git a/bitbake/lib/webhob/bldviewer/templates/package.html b/bitbake/lib/webhob/bldviewer/templates/package.html
index d31ecbb..d1259e9 100644
--- a/bitbake/lib/webhob/bldviewer/templates/package.html
+++ b/bitbake/lib/webhob/bldviewer/templates/package.html
@@ -19,7 +19,7 @@
 
             {% for package in packages %}
 
-                <tr>
+                <tr class="data">
                 <td><a name="#{{package.name}}">{{package.name}}</a></td>
                 <td>{{package.version}}</td>
                 <td>{{package.size}}</td>
-- 
1.8.1.2


