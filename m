Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 46F726CB5B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:11 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 24 Sep 2013 09:50:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; 
	d="scan'208,217";a="408442590"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga002.jf.intel.com with ESMTP; 24 Sep 2013 09:53:12 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 31B725628CE; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:36 +0100
Message-Id: <2f6937dbd26fb8b7f66e7e3ae7530baf33cd5cd4.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 67/94] bitbake: webhob: simple interface CSS
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:12 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adds Bootstrap CSS features to the Simple interface,
as to make it more visually appealing.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/templates/base.html   | 44 +++++++++++++---------
 bitbake/lib/webhob/bldviewer/templates/build.html  |  7 +---
 bitbake/lib/webhob/bldviewer/templates/layer.html  |  6 +--
 .../lib/webhob/bldviewer/templates/package.html    |  6 +--
 bitbake/lib/webhob/bldviewer/templates/recipe.html |  6 +--
 bitbake/lib/webhob/bldviewer/templates/task.html   |  6 +--
 6 files changed, 31 insertions(+), 44 deletions(-)

diff --git a/bitbake/lib/webhob/bldviewer/templates/base.html b/bitbake/lib/webhob/bldviewer/templates/base.html
index 0d24d36..e97c8f6 100644
--- a/bitbake/lib/webhob/bldviewer/templates/base.html
+++ b/bitbake/lib/webhob/bldviewer/templates/base.html
@@ -10,7 +10,7 @@
 <link href="/static/css/bootstrap.css" rel="stylesheet" type="text/css">
 	</head>
 
-<body>
+<body style="height: 100%">
 <script>
 function showhideTableColumn(i, sh) {
     if (sh)
@@ -22,7 +22,6 @@ function showhideTableColumn(i, sh) {
 
 function filterTableRows(test) {
     if (test.length > 0) {
-
         var r = test.split(/[ ,]+/).map(function (e) { return new RegExp(e, 'i') });
         $('tr.data').map( function (i, el) {
             (! r.map(function (j) { return j.test($(el).html())}).reduce(function (c, p) { return c && p;} )) ? $(el).hide() : $(el).show();
@@ -33,25 +32,34 @@ function filterTableRows(test) {
     }
 }
 </script>
-
-<div>Menu: <a href="/simple/build/">All Builds</a>&nbsp;|&nbsp;<a href="/simple/layer/">All Layers</a>
-</div>
-
-{% block pagename %}
-{% endblock %}
-
-<div style="padding-top:1em ;padding-bottom: 1em">
-<div align="left" style="display:inline-block; width: 49%"> Search: <input type="search" id="filterstring" style="width: 30em" onkeyup="filterTableRows($('#filterstring').val())" autocomplete="off">
-</div>
-<div align="right" style="display: inline-block; width: 49%">Show/Hide columns:
-{% for i in hideshowcols %}
-    <span>{{i.name}} <input type="checkbox" id="ct{{i.name}}" onchange="showhideTableColumn({{i.order}}, $('#ct{{i.name}}').is(':checked'))" checked autocomplete="off"></span> |
-{% endfor %}
-</div>
+<div style="position:fixed; top:0; z-index: 999; width: 100%; background:white"> 
+    <ul class="nav nav-tabs">
+        <li><a href="/simple/build/">All Builds</a></li>
+        <li><a href="/simple/layer/">All Layers</a></li>
+    </ul>
+    
+    {% block pagename %}
+    {% endblock %}
+    
+    <div style="padding-top:1em ;padding-bottom: 1em">
+    <div align="left" style="display:inline-block; width: 49%; margin-left: 2em"> Search: <input type="search" id="filterstring" style="width: 30em" onkeyup="filterTableRows($('#filterstring').val())" autocomplete="off">
+    </div>
+    {% if hideshowcols %}
+    <div align="right" style="display: inline-block; width: 49%">Show/Hide columns:
+    {% for i in hideshowcols %}
+        <span>{{i.name}} <input type="checkbox" id="ct{{i.name}}" onchange="showhideTableColumn({{i.order}}, $('#ct{{i.name}}').is(':checked'))" checked autocomplete="off"></span> |
+    {% endfor %}
+    </div>
+    {% endif %}
+    </div>
 </div>
-
+<div style="padding-top: 13em; width:98%; align:center; margin:auto;">
+    <table class="table table-striped table-condensed">
 {% block pagetable %}
 {% endblock %}
+    </table>
+</div>
+<div class="navbar"><br/>About Toaster | Yocto Project </div>
 </body>
 </html>
 
diff --git a/bitbake/lib/webhob/bldviewer/templates/build.html b/bitbake/lib/webhob/bldviewer/templates/build.html
index 2828404..20c415b 100644
--- a/bitbake/lib/webhob/bldviewer/templates/build.html
+++ b/bitbake/lib/webhob/bldviewer/templates/build.html
@@ -5,9 +5,8 @@
 {% endblock %}
 
 {% block pagetable %}
-    <table border="1">
-    {% load projecttags %}
 
+    {% load projecttags %}
         <tr>
             <th>Outcome</th>
             <th>Started On</th>
@@ -23,9 +22,7 @@
             <th>Bitbake Version</th>
             <th>Build Name</th>
         </tr>
-
         {% for build in builds %}
-
         <tr class="data">
             <td><a href="/simple/build/{{build.id}}/task/">{{build.get_outcome_display}}</a></td>
             <td>{{build.started_on}}</td>
@@ -43,8 +40,6 @@
         </tr>
 
         {% endfor %}
-
-    </table>
 {% endblock %}
 
 
diff --git a/bitbake/lib/webhob/bldviewer/templates/layer.html b/bitbake/lib/webhob/bldviewer/templates/layer.html
index 0ffdaba..5b317ba 100644
--- a/bitbake/lib/webhob/bldviewer/templates/layer.html
+++ b/bitbake/lib/webhob/bldviewer/templates/layer.html
@@ -5,8 +5,6 @@
 {% endblock %}
 
 {% block pagetable %}
-    <table border="1">
-
     {% load projecttags %}
 
         <tr>
@@ -18,7 +16,7 @@
 
         {% for layer in layers %}
 
-        <tr>
+        <tr class="data">
             <td>{{layer.name}}</td>
             <td>{{layer.local_path}}</td>
             <td><a href='{{layer.layer_index_url}}'>{{layer.layer_index_url}}</a></td>
@@ -33,6 +31,4 @@
 
         {% endfor %}
 
-    </table>
-
 {% endblock %}
diff --git a/bitbake/lib/webhob/bldviewer/templates/package.html b/bitbake/lib/webhob/bldviewer/templates/package.html
index e7856ba..f70b022 100644
--- a/bitbake/lib/webhob/bldviewer/templates/package.html
+++ b/bitbake/lib/webhob/bldviewer/templates/package.html
@@ -9,8 +9,6 @@
         <p>No packages were build in this build!</p>
     {% else %}
 
-        <table border="1">
-
             <tr>
             <th>Name</th>
             <th>Version</th>
@@ -21,7 +19,7 @@
 
             {% for package in packages %}
 
-                <tr class="data">
+            <tr class="data">
                 <td><a name="#{{package.name}}">{{package.name}}</a></td>
                 <td>{{package.version}}</td>
                 <td>{{package.size}}</td>
@@ -37,8 +35,6 @@
 
             {% endfor %}
 
-        </table>
-
     {% endif %}
 
 {% endblock %}
diff --git a/bitbake/lib/webhob/bldviewer/templates/recipe.html b/bitbake/lib/webhob/bldviewer/templates/recipe.html
index 0c9c077..515053a 100644
--- a/bitbake/lib/webhob/bldviewer/templates/recipe.html
+++ b/bitbake/lib/webhob/bldviewer/templates/recipe.html
@@ -5,8 +5,6 @@
 {% endblock %}
 
 {% block pagetable %}
-    <table border="1">
-
     {% load projecttags %}
 
         <tr>
@@ -24,7 +22,7 @@
 
         {% for recipe in recipes %}
 
-        <tr>
+        <tr class="data">
             <td><a name="{{recipe.name}}">{{recipe.name}}</a></td>
             <td>{{recipe.version}}</td>
             <td>{{recipe.summary}}</td>
@@ -39,6 +37,4 @@
 
         {% endfor %}
 
-    </table>
-
 {% endblock %}
diff --git a/bitbake/lib/webhob/bldviewer/templates/task.html b/bitbake/lib/webhob/bldviewer/templates/task.html
index 0ed5f9d..6d06d0f 100644
--- a/bitbake/lib/webhob/bldviewer/templates/task.html
+++ b/bitbake/lib/webhob/bldviewer/templates/task.html
@@ -9,8 +9,6 @@
         <p>No tasks were executed in this build!</p>
     {% else %}
 
-        <table border="1">
-
             <tr>
             <th>Order</th>
             <th>Task</th>
@@ -29,7 +27,7 @@
 
             {% for task in tasks %}
 
-                <tr>
+            <tr class="data">
                 <td>{{task.order}}</td>
                 <td><a name="{{task.recipe.name}}.{{task.task_name}}">
                 <a href="/simple/layerversions/{{task.recipe.layer_version_id}}/recipes/#{{task.recipe.name}}">{{task.recipe.name}}</a>.{{task.task_name}}</a></td>
@@ -61,8 +59,6 @@
 
             {% endfor %}
 
-        </table>
-
     {% endif %}
 
 {% endblock %}
-- 
1.8.1.2


