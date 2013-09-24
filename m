Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id BD33E6CB57
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:14 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="298814619"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by AZSMGA002.ch.intel.com with ESMTP; 24 Sep 2013 09:53:12 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 2F2015628CC; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:35 +0100
Message-Id: <5c211de7f1f73b0132e82b6b22ce1b756bf2e92b.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 66/94] bitbake: webhob: refactor Simple web interface
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

We're refactoring the inheritance model and code
placement in the Simple interface as to bring the
search functionality and column selection to all
table-based pages.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/templates/base.html    | 15 ++++++++++++++-
 bitbake/lib/webhob/bldviewer/templates/build.html   | 17 +++++------------
 bitbake/lib/webhob/bldviewer/templates/layer.html   |  6 ++++--
 bitbake/lib/webhob/bldviewer/templates/package.html | 12 +++++++-----
 bitbake/lib/webhob/bldviewer/templates/recipe.html  |  6 ++++--
 bitbake/lib/webhob/bldviewer/templates/task.html    |  6 ++++--
 6 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/bitbake/lib/webhob/bldviewer/templates/base.html b/bitbake/lib/webhob/bldviewer/templates/base.html
index 12b2f01..0d24d36 100644
--- a/bitbake/lib/webhob/bldviewer/templates/base.html
+++ b/bitbake/lib/webhob/bldviewer/templates/base.html
@@ -36,8 +36,21 @@ function filterTableRows(test) {
 
 <div>Menu: <a href="/simple/build/">All Builds</a>&nbsp;|&nbsp;<a href="/simple/layer/">All Layers</a>
 </div>
-{% block pagecontent %}
 
+{% block pagename %}
+{% endblock %}
+
+<div style="padding-top:1em ;padding-bottom: 1em">
+<div align="left" style="display:inline-block; width: 49%"> Search: <input type="search" id="filterstring" style="width: 30em" onkeyup="filterTableRows($('#filterstring').val())" autocomplete="off">
+</div>
+<div align="right" style="display: inline-block; width: 49%">Show/Hide columns:
+{% for i in hideshowcols %}
+    <span>{{i.name}} <input type="checkbox" id="ct{{i.name}}" onchange="showhideTableColumn({{i.order}}, $('#ct{{i.name}}').is(':checked'))" checked autocomplete="off"></span> |
+{% endfor %}
+</div>
+</div>
+
+{% block pagetable %}
 {% endblock %}
 </body>
 </html>
diff --git a/bitbake/lib/webhob/bldviewer/templates/build.html b/bitbake/lib/webhob/bldviewer/templates/build.html
index 5db72db..2828404 100644
--- a/bitbake/lib/webhob/bldviewer/templates/build.html
+++ b/bitbake/lib/webhob/bldviewer/templates/build.html
@@ -1,17 +1,10 @@
 {% extends "base.html" %}
 
-{% block pagecontent %}
-    <h1>WebHob Builds</h1>
-
-<div style="padding-top:1em ;padding-bottom: 1em">
-<div align="left" style="display:inline-block; width: 49%"> Search: <input type="search" id="filterstring" style="width: 30em" onkeyup="filterTableRows($('#filterstring').val())" autocomplete="off">
-</div>
-<div align="right" style="display: inline-block; width: 49%">Show/Hide columns:
-{% for i in hideshowcols %}
-    <span>{{i.name}} <input type="checkbox" id="ct{{i.name}}" onchange="showhideTableColumn({{i.order}}, $('#ct{{i.name}}').is(':checked'))" checked autocomplete="off"></span> |
-{% endfor %}
-</div>
-</div>
+{% block pagename %}
+    <h1>Toaster - Builds</h1>
+{% endblock %}
+
+{% block pagetable %}
     <table border="1">
     {% load projecttags %}
 
diff --git a/bitbake/lib/webhob/bldviewer/templates/layer.html b/bitbake/lib/webhob/bldviewer/templates/layer.html
index 9d44f17..0ffdaba 100644
--- a/bitbake/lib/webhob/bldviewer/templates/layer.html
+++ b/bitbake/lib/webhob/bldviewer/templates/layer.html
@@ -1,8 +1,10 @@
 {% extends "base.html" %}
 
-{% block pagecontent %}
-    <h1>WebHob Layers</h1>
+{% block pagename %}
+    <h1>Toaster - Layers</h1>
+{% endblock %}
 
+{% block pagetable %}
     <table border="1">
 
     {% load projecttags %}
diff --git a/bitbake/lib/webhob/bldviewer/templates/package.html b/bitbake/lib/webhob/bldviewer/templates/package.html
index d1259e9..e7856ba 100644
--- a/bitbake/lib/webhob/bldviewer/templates/package.html
+++ b/bitbake/lib/webhob/bldviewer/templates/package.html
@@ -1,8 +1,10 @@
 {% extends "base.html" %}
 
-{% block pagecontent %}
-    <h1>WebHob Packages</h1>
+{% block pagename %}
+    <h1>Toaster - Packages</h1>
+{% endblock %}
 
+{% block pagetable %}
     {% if not packages %}
         <p>No packages were build in this build!</p>
     {% else %}
@@ -29,11 +31,11 @@
             <div style="height: 3em; overflow:auto">
                     {% for d in package.depends_on %}
                     <a href="#{{d.name}}">{{d.name}}</a><br/>
-                    {% endfor %} 
+                    {% endfor %}
             </div>
                 </td>
-            
-            {% endfor %}        
+
+            {% endfor %}
 
         </table>
 
diff --git a/bitbake/lib/webhob/bldviewer/templates/recipe.html b/bitbake/lib/webhob/bldviewer/templates/recipe.html
index 5ebd880..0c9c077 100644
--- a/bitbake/lib/webhob/bldviewer/templates/recipe.html
+++ b/bitbake/lib/webhob/bldviewer/templates/recipe.html
@@ -1,8 +1,10 @@
 {% extends "base.html" %}
 
-{% block pagecontent %}
-    <h1>WebHob Recipes for a Layer</h1>
+{% block pagename %}
+    <h1>Toaster - Recipes for a Layer</h1>
+{% endblock %}
 
+{% block pagetable %}
     <table border="1">
 
     {% load projecttags %}
diff --git a/bitbake/lib/webhob/bldviewer/templates/task.html b/bitbake/lib/webhob/bldviewer/templates/task.html
index d87d261..0ed5f9d 100644
--- a/bitbake/lib/webhob/bldviewer/templates/task.html
+++ b/bitbake/lib/webhob/bldviewer/templates/task.html
@@ -1,8 +1,10 @@
 {% extends "base.html" %}
 
-{% block pagecontent %}
-    <h1>WebHob Tasks</h1>
+{% block pagename %}
+    <h1>Toaster - Tasks</h1>
+{% endblock %}
 
+{% block pagetable %}
     {% if not tasks %}
         <p>No tasks were executed in this build!</p>
     {% else %}
-- 
1.8.1.2


