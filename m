Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id DD5406CB78
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:15 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; 
	d="scan'208,217";a="298814622"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by AZSMGA002.ch.intel.com with ESMTP; 24 Sep 2013 09:53:12 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 369B45628D0; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:38 +0100
Message-Id: <914b829608b0d7e6b9a27e71a1b593024c1f69bd.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 69/94] bitbake: webhob: refactor CSS display in Simple
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:16 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Refactoring CSS display in Simple to separate
the generic layout to the table display code.

With the new layout we can add the generic display
to more than just table pages.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/templates/base.html   | 51 ++++------------------
 .../lib/webhob/bldviewer/templates/basetable.html  | 46 +++++++++++++++++++
 bitbake/lib/webhob/bldviewer/templates/build.html  |  2 +-
 bitbake/lib/webhob/bldviewer/templates/layer.html  |  2 +-
 .../lib/webhob/bldviewer/templates/package.html    |  2 +-
 bitbake/lib/webhob/bldviewer/templates/recipe.html |  2 +-
 bitbake/lib/webhob/bldviewer/templates/task.html   |  2 +-
 7 files changed, 59 insertions(+), 48 deletions(-)
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/basetable.html

diff --git a/bitbake/lib/webhob/bldviewer/templates/base.html b/bitbake/lib/webhob/bldviewer/templates/base.html
index e97c8f6..31abeb1 100644
--- a/bitbake/lib/webhob/bldviewer/templates/base.html
+++ b/bitbake/lib/webhob/bldviewer/templates/base.html
@@ -2,7 +2,7 @@
 
 <html>
 	<head>
-		<title>WebHob Simple Explorer</title>
+		<title>Toaster Simple Explorer</title>
 <script src="/static/js/jquery-2.0.3.js">
 </script>
 <script src="/static/js/bootstrap.js">
@@ -11,55 +11,20 @@
 	</head>
 
 <body style="height: 100%">
-<script>
-function showhideTableColumn(i, sh) {
-    if (sh)
-        $('td:nth-child('+i+'),th:nth-child('+i+')').show();
-    else
-        $('td:nth-child('+i+'),th:nth-child('+i+')').hide();
-}
-
-
-function filterTableRows(test) {
-    if (test.length > 0) {
-        var r = test.split(/[ ,]+/).map(function (e) { return new RegExp(e, 'i') });
-        $('tr.data').map( function (i, el) {
-            (! r.map(function (j) { return j.test($(el).html())}).reduce(function (c, p) { return c && p;} )) ? $(el).hide() : $(el).show();
-        });
-    } else
-    {
-        $('tr.data').show();
-    }
-}
-</script>
-<div style="position:fixed; top:0; z-index: 999; width: 100%; background:white"> 
+<div style="width:100%; height: 100%; position:absolute">
+<div style="width: 100%; height: 3em" class="nav">
     <ul class="nav nav-tabs">
         <li><a href="/simple/build/">All Builds</a></li>
         <li><a href="/simple/layer/">All Layers</a></li>
     </ul>
-    
-    {% block pagename %}
-    {% endblock %}
-    
-    <div style="padding-top:1em ;padding-bottom: 1em">
-    <div align="left" style="display:inline-block; width: 49%; margin-left: 2em"> Search: <input type="search" id="filterstring" style="width: 30em" onkeyup="filterTableRows($('#filterstring').val())" autocomplete="off">
-    </div>
-    {% if hideshowcols %}
-    <div align="right" style="display: inline-block; width: 49%">Show/Hide columns:
-    {% for i in hideshowcols %}
-        <span>{{i.name}} <input type="checkbox" id="ct{{i.name}}" onchange="showhideTableColumn({{i.order}}, $('#ct{{i.name}}').is(':checked'))" checked autocomplete="off"></span> |
-    {% endfor %}
-    </div>
-    {% endif %}
-    </div>
 </div>
-<div style="padding-top: 13em; width:98%; align:center; margin:auto;">
-    <table class="table table-striped table-condensed">
-{% block pagetable %}
+
+<div style="overflow-y:scroll; width: 100%; position: absolute; top: 3em; bottom:70px ">
+{% block pagecontent %}
 {% endblock %}
-    </table>
 </div>
-<div class="navbar"><br/>About Toaster | Yocto Project </div>
+<div class="navbar" style="position: absolute; bottom: 0; width:100%"><br/>About Toaster | Yocto Project </div>
+</div>
 </body>
 </html>
 
diff --git a/bitbake/lib/webhob/bldviewer/templates/basetable.html b/bitbake/lib/webhob/bldviewer/templates/basetable.html
new file mode 100644
index 0000000..083bcb8
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templates/basetable.html
@@ -0,0 +1,46 @@
+{% extends "base.html" %}
+
+{% block pagecontent %}
+<script>
+function showhideTableColumn(i, sh) {
+    if (sh)
+        $('td:nth-child('+i+'),th:nth-child('+i+')').show();
+    else
+        $('td:nth-child('+i+'),th:nth-child('+i+')').hide();
+}
+
+
+function filterTableRows(test) {
+    if (test.length > 0) {
+        var r = test.split(/[ ,]+/).map(function (e) { return new RegExp(e, 'i') });
+        $('tr.data').map( function (i, el) {
+            (! r.map(function (j) { return j.test($(el).html())}).reduce(function (c, p) { return c && p;} )) ? $(el).hide() : $(el).show();
+        });
+    } else
+    {
+        $('tr.data').show();
+    }
+}
+</script>
+<div style="margin-bottom: 0.5em">
+
+    {% block pagename %}
+    {% endblock %}
+    <div align="left" style="display:inline-block; width: 40%; margin-left: 2em"> Search: <input type="search" id="filterstring" style="width: 80%" onkeyup="filterTableRows($('#filterstring').val())" autocomplete="off">
+    </div>
+    {% if hideshowcols %}
+    <div align="right" style="display: inline-block; width: 40%">Show/Hide columns:
+    {% for i in hideshowcols %}
+        <span>{{i.name}} <input type="checkbox" id="ct{{i.name}}" onchange="showhideTableColumn({{i.order}}, $('#ct{{i.name}}').is(':checked'))" checked autocomplete="off"></span> |
+    {% endfor %}
+    </div>
+    {% endif %}
+</div>
+<div>
+    <table class="table table-striped table-condensed" style="width:95%">
+{% block pagetable %}
+{% endblock %}
+    </table>
+</div>
+
+{% endblock %}
diff --git a/bitbake/lib/webhob/bldviewer/templates/build.html b/bitbake/lib/webhob/bldviewer/templates/build.html
index 20c415b..53271a7 100644
--- a/bitbake/lib/webhob/bldviewer/templates/build.html
+++ b/bitbake/lib/webhob/bldviewer/templates/build.html
@@ -1,4 +1,4 @@
-{% extends "base.html" %}
+{% extends "basetable.html" %}
 
 {% block pagename %}
     <h1>Toaster - Builds</h1>
diff --git a/bitbake/lib/webhob/bldviewer/templates/layer.html b/bitbake/lib/webhob/bldviewer/templates/layer.html
index 5b317ba..508f254 100644
--- a/bitbake/lib/webhob/bldviewer/templates/layer.html
+++ b/bitbake/lib/webhob/bldviewer/templates/layer.html
@@ -1,4 +1,4 @@
-{% extends "base.html" %}
+{% extends "basetable.html" %}
 
 {% block pagename %}
     <h1>Toaster - Layers</h1>
diff --git a/bitbake/lib/webhob/bldviewer/templates/package.html b/bitbake/lib/webhob/bldviewer/templates/package.html
index f70b022..622c23d 100644
--- a/bitbake/lib/webhob/bldviewer/templates/package.html
+++ b/bitbake/lib/webhob/bldviewer/templates/package.html
@@ -1,4 +1,4 @@
-{% extends "base.html" %}
+{% extends "basetable.html" %}
 
 {% block pagename %}
     <h1>Toaster - Packages</h1>
diff --git a/bitbake/lib/webhob/bldviewer/templates/recipe.html b/bitbake/lib/webhob/bldviewer/templates/recipe.html
index 515053a..e855625 100644
--- a/bitbake/lib/webhob/bldviewer/templates/recipe.html
+++ b/bitbake/lib/webhob/bldviewer/templates/recipe.html
@@ -1,4 +1,4 @@
-{% extends "base.html" %}
+{% extends "basetable.html" %}
 
 {% block pagename %}
     <h1>Toaster - Recipes for a Layer</h1>
diff --git a/bitbake/lib/webhob/bldviewer/templates/task.html b/bitbake/lib/webhob/bldviewer/templates/task.html
index 6d06d0f..05d8e12 100644
--- a/bitbake/lib/webhob/bldviewer/templates/task.html
+++ b/bitbake/lib/webhob/bldviewer/templates/task.html
@@ -1,4 +1,4 @@
-{% extends "base.html" %}
+{% extends "basetable.html" %}
 
 {% block pagename %}
     <h1>Toaster - Tasks</h1>
-- 
1.8.1.2


