Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 628CB6CBB6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:20 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; 
	d="scan'208,217";a="364948525"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:09 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id DB28C56209A; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:09 +0100
Message-Id: <8f887c88f08b1a8c503987cf6545c92fd6828146.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 40/94] bitbake: webhob: enhance Simple browser navigation
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:23 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We make a couple of changes to allow easier navigation
in the simple data display.

- all templates now inherit the common base.html
- simple navigation menu added on top of page
- there is a link between a task name in tasks page,
and the recipe entry
- all tabs converted to 4-spaces

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/templates/base.html   |  16 +++
 bitbake/lib/webhob/bldviewer/templates/build.html  | 103 +++++++++----------
 bitbake/lib/webhob/bldviewer/templates/layer.html  |  44 ++++----
 bitbake/lib/webhob/bldviewer/templates/recipe.html |  90 ++++++++--------
 bitbake/lib/webhob/bldviewer/templates/task.html   | 114 ++++++++++-----------
 bitbake/lib/webhob/bldviewer/urls.py               |   2 +-
 6 files changed, 180 insertions(+), 189 deletions(-)
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/base.html

diff --git a/bitbake/lib/webhob/bldviewer/templates/base.html b/bitbake/lib/webhob/bldviewer/templates/base.html
new file mode 100644
index 0000000..ab3c3b7
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templates/base.html
@@ -0,0 +1,16 @@
+<!DOCTYPE html>
+
+<html>
+	<head>
+		<title>WebHob Simple Explorer</title>
+	</head>
+
+<body>
+<div>Menu: <a href="/simple/build/">All Builds</a>&nbsp;|&nbsp;<a href="/simple/layer/">All Layers</a>
+</div>
+{% block pagecontent %}
+
+{% endblock %}
+</body>
+</html>
+
diff --git a/bitbake/lib/webhob/bldviewer/templates/build.html b/bitbake/lib/webhob/bldviewer/templates/build.html
index cd257e0..8ee3800 100644
--- a/bitbake/lib/webhob/bldviewer/templates/build.html
+++ b/bitbake/lib/webhob/bldviewer/templates/build.html
@@ -1,54 +1,49 @@
-<html>
-
-	<head>
-		<title>WebHob Build page</title>
-	</head>
-
-<body>
-	<h1>WebHob Builds</h1>
-
-	<table border="1">
-
-	{% load projecttags %}
-
-		<tr>
-			<th>Outcome</th>
-			<th>Started On</th>
-			<th>Completed On</th>
-			<th>Target</th>
-	        <th>Image ?</th>
-			<th>Machine</th>
-			<th>Time</th>
-			<th>Errors</th>
-			<th>Warnings</th>
-			<th>Output</th>
-			<th>Log</th>
-			<th>Bitbake Version</th>
-			<th>Build Name</th>
-		</tr>
-
-		{% for build in builds %}
-
-		<tr>
-			<td><a href="/build/{{build.id}}">{{build.get_outcome_display}}</a></td>
-			<td>{{build.started_on}}</td>
-			<td>{{build.completed_on}}</td>
-			<td>{{build.target}}</td>
-	        <td>{{build.is_image}}</td>
-			<td>{{build.machine.name}}</td>
-			<td>{% time_difference build.started_on build.completed_on %}</td>
-			<td>{{build.errors_no}}</td>
-			<td>{{build.warnings_no}}</td>
-			<td>{{build.image_fstypes}}</td>
-			<td>{{build.cooker_log_path}}</td>
-			<td>{{build.bitbake_version}}</td>
-			<td>{{build.build_name}}</td>
-		</tr>
-
-		{% endfor %}
-
-	</table>
-
-</body>
-
-</html>
+{% extends "base.html" %}
+
+{% block pagecontent %}
+    <h1>WebHob Builds</h1>
+
+    <table border="1">
+
+    {% load projecttags %}
+
+        <tr>
+            <th>Outcome</th>
+            <th>Started On</th>
+            <th>Completed On</th>
+            <th>Target</th>
+            <th>Image ?</th>
+            <th>Machine</th>
+            <th>Time</th>
+            <th>Errors</th>
+            <th>Warnings</th>
+            <th>Output</th>
+            <th>Log</th>
+            <th>Bitbake Version</th>
+            <th>Build Name</th>
+        </tr>
+
+        {% for build in builds %}
+
+        <tr>
+            <td><a href="/simple/build/{{build.id}}/task/">{{build.get_outcome_display}}</a></td>
+            <td>{{build.started_on}}</td>
+            <td>{{build.completed_on}}</td>
+            <td>{{build.target}}</td>
+            <td>{{build.is_image}}</td>
+            <td>{{build.machine.name}}</td>
+            <td>{% time_difference build.started_on build.completed_on %}</td>
+            <td>{{build.errors_no}}</td>
+            <td>{{build.warnings_no}}</td>
+            <td>{{build.image_fstypes}}</td>
+            <td>{{build.cooker_log_path}}</td>
+            <td>{{build.bitbake_version}}</td>
+            <td>{{build.build_name}}</td>
+        </tr>
+
+        {% endfor %}
+
+    </table>
+{% endblock %}
+
+
diff --git a/bitbake/lib/webhob/bldviewer/templates/layer.html b/bitbake/lib/webhob/bldviewer/templates/layer.html
index 24bd86b..9d44f17 100644
--- a/bitbake/lib/webhob/bldviewer/templates/layer.html
+++ b/bitbake/lib/webhob/bldviewer/templates/layer.html
@@ -1,29 +1,25 @@
-<html>
+{% extends "base.html" %}
 
-	<head>
-		<title>WebHob Layer page</title>
-	</head>
+{% block pagecontent %}
+    <h1>WebHob Layers</h1>
 
-<body>
-	<h1>WebHob Layers</h1>
+    <table border="1">
 
-	<table border="1">
+    {% load projecttags %}
 
-	{% load projecttags %}
-
-		<tr>
-			<th>Name</th>
-			<th>Local Path</th>
-			<th>Layer Index URL</th>
+        <tr>
+            <th>Name</th>
+            <th>Local Path</th>
+            <th>Layer Index URL</th>
             <th>Known Versions</th>
-		</tr>
+        </tr>
 
-		{% for layer in layers %}
+        {% for layer in layers %}
 
-		<tr>
-			<td>{{layer.name}}</td>
-			<td>{{layer.local_path}}</td>
-			<td><a href='{{layer.layer_index_url}}'>{{layer.layer_index_url}}</a></td>
+        <tr>
+            <td>{{layer.name}}</td>
+            <td>{{layer.local_path}}</td>
+            <td><a href='{{layer.layer_index_url}}'>{{layer.layer_index_url}}</a></td>
             <td><table>
             {% for lv in layer.versions %}
                 <tr><td>
@@ -31,12 +27,10 @@
                 </td></tr>
             {% endfor %}
             </table></td>
-		</tr>
-
-		{% endfor %}
+        </tr>
 
-	</table>
+        {% endfor %}
 
-</body>
+    </table>
 
-</html>
+{% endblock %}
diff --git a/bitbake/lib/webhob/bldviewer/templates/recipe.html b/bitbake/lib/webhob/bldviewer/templates/recipe.html
index 8f5dcb3..5ebd880 100644
--- a/bitbake/lib/webhob/bldviewer/templates/recipe.html
+++ b/bitbake/lib/webhob/bldviewer/templates/recipe.html
@@ -1,48 +1,42 @@
-<html>
-
-	<head>
-		<title>WebHob Recipe page</title>
-	</head>
-
-<body>
-	<h1>WebHob Recipes for a Layer</h1>
-
-	<table border="1">
-
-	{% load projecttags %}
-
-		<tr>
-		</tr>
-			<th>Name</th>
-			<th>Version</th>
-			<th>Summary</th>
-			<th>Description</th>
-	        <th>Section</th>
-			<th>License</th>
-			<th>Homepage</th>
-			<th>Bugtracker</th>
-			<th>Author</th>
-			<th>File_path</th>
-
-		{% for recipe in recipes %}
-
-		<tr>
-			<td>{{recipe.name}}</td>
-			<td>{{recipe.version}}</td>
-			<td>{{recipe.summary}}</td>
-			<td>{{recipe.description}}</td>
-	        <td>{{recipe.section}}</td>
-			<td>{{recipe.license}}</td>
-			<td>{{recipe.homepage}}</td>
-			<td>{{recipe.bugtracker}}</td>
-			<td>{{recipe.author}}</td>
-			<td>{{recipe.file_path}}</td>
-		</tr>
-
-		{% endfor %}
-
-	</table>
-
-</body>
-
-</html>
+{% extends "base.html" %}
+
+{% block pagecontent %}
+    <h1>WebHob Recipes for a Layer</h1>
+
+    <table border="1">
+
+    {% load projecttags %}
+
+        <tr>
+        </tr>
+            <th>Name</th>
+            <th>Version</th>
+            <th>Summary</th>
+            <th>Description</th>
+            <th>Section</th>
+            <th>License</th>
+            <th>Homepage</th>
+            <th>Bugtracker</th>
+            <th>Author</th>
+            <th>File_path</th>
+
+        {% for recipe in recipes %}
+
+        <tr>
+            <td><a name="{{recipe.name}}">{{recipe.name}}</a></td>
+            <td>{{recipe.version}}</td>
+            <td>{{recipe.summary}}</td>
+            <td>{{recipe.description}}</td>
+            <td>{{recipe.section}}</td>
+            <td>{{recipe.license}}</td>
+            <td>{{recipe.homepage}}</td>
+            <td>{{recipe.bugtracker}}</td>
+            <td>{{recipe.author}}</td>
+            <td>{{recipe.file_path}}</td>
+        </tr>
+
+        {% endfor %}
+
+    </table>
+
+{% endblock %}
diff --git a/bitbake/lib/webhob/bldviewer/templates/task.html b/bitbake/lib/webhob/bldviewer/templates/task.html
index 1797028..88c82d8 100644
--- a/bitbake/lib/webhob/bldviewer/templates/task.html
+++ b/bitbake/lib/webhob/bldviewer/templates/task.html
@@ -1,72 +1,64 @@
-<html>
-
-	<head>
-		<title>WebHob Task page</title>
-	</head>
-
-<body>
-
-	<h1>WebHob Tasks</h1>
-
-	{% if not tasks %}
-		<p>No tasks were executed in this build!</p>
-	{% else %}
-
-		<table border="1">
-
-			<tr>
-			<th>Order</th>
-			<th>Task</th>
-			<th>Recipe Version</th>
-			<th>Task Type</th>
-			<th>Outcome</th>
-			<th>Errors</th>
-			<th>Warnings</th>
-			<th>Time</th>
-			<th>CPU usage</th>
-			<th>Disk I/O</th>
-			<th>Script type</th>
-			<th>File path</th>
+{% extends "base.html" %}
+
+{% block pagecontent %}
+    <h1>WebHob Tasks</h1>
+
+    {% if not tasks %}
+        <p>No tasks were executed in this build!</p>
+    {% else %}
+
+        <table border="1">
+
+            <tr>
+            <th>Order</th>
+            <th>Task</th>
+            <th>Recipe Version</th>
+            <th>Task Type</th>
+            <th>Outcome</th>
+            <th>Errors</th>
+            <th>Warnings</th>
+            <th>Time</th>
+            <th>CPU usage</th>
+            <th>Disk I/O</th>
+            <th>Script type</th>
+            <th>File path</th>
             <th>Depends</th>
-			</tr>
-
-			{% for task in tasks %}
-
-				<tr>
-				<td>{{task.order}}</td>
-				<td><a name="{{task.recipe.name}}.{{task.task_name}}">
-				{{task.recipe.name}}.{{task.task_name}}</a></td>
-				<td>{{task.recipe.version}}</td>
-
-				{% if task.task_executed %}
-				<td>Executed</td>
-				{% else %}
-				<td>Prebuilt</td>
-				{% endif %}
-
-				<td>{{task.get_outcome_display}}</td>
-				<td>{{task.errors_no}}</td>
-				<td>{{task.warnings_no}}</td>
-				<td>{{task.elapsed_time}}</td>
-				<td>{{task.cpu_usage}}</td>
-				<td>{{task.disk_io}}</td>
-				<td>{{task.get_script_type_display}}</td>
-				<td>{{task.recipe.file_path}}</td>
+            </tr>
+
+            {% for task in tasks %}
+
+                <tr>
+                <td>{{task.order}}</td>
+                <td><a name="{{task.recipe.name}}.{{task.task_name}}">
+                <a href="/simple/layerversions/{{task.recipe.layer_version_id}}/recipes/#{{task.recipe.name}}">{{task.recipe.name}}</a>.{{task.task_name}}</a></td>
+                <td>{{task.recipe.version}}</td>
+
+                {% if task.task_executed %}
+                <td>Executed</td>
+                {% else %}
+                <td>Prebuilt</td>
+                {% endif %}
+
+                <td>{{task.get_outcome_display}}</td>
+                <td>{{task.errors_no}}</td>
+                <td>{{task.warnings_no}}</td>
+                <td>{{task.elapsed_time}}</td>
+                <td>{{task.cpu_usage}}</td>
+                <td>{{task.disk_io}}</td>
+                <td>{{task.get_script_type_display}}</td>
+                <td>{{task.recipe.file_path}}</td>
                 <td>
                 {% for tt in task.depends_on %}
                     <a href="#{{tt.recipe.name}}.{{tt.task_name}}">
                     {{tt.recipe.name}}.{{tt.task_name}}</a><br/>
                 {% endfor %}
                 </td>
-				</tr>
-
-			{% endfor %}
-
-		</table>
+                </tr>
 
-	{% endif %}
+            {% endfor %}
 
-</body>
+        </table>
 
-</html>
+    {% endif %}
 
+{% endblock %}
diff --git a/bitbake/lib/webhob/bldviewer/urls.py b/bitbake/lib/webhob/bldviewer/urls.py
index b6c6796..5f07161 100644
--- a/bitbake/lib/webhob/bldviewer/urls.py
+++ b/bitbake/lib/webhob/bldviewer/urls.py
@@ -5,6 +5,6 @@ urlpatterns = patterns('bldviewer.views',
         url(r'^build/$', 'build', name='build'),
         url(r'^build/(?P<build_id>\d+)/task/$', 'task', name='task'),
         url(r'^layer/$', 'layer', name='layer'),
-        url(r'^layerversions/(?P<layerversion_id>\d+)/recipes$', 'layer_versions_recipes', name='layer_versions_recipes'),
+        url(r'^layerversions/(?P<layerversion_id>\d+)/recipes/.*$', 'layer_versions_recipes', name='layer_versions_recipes'),
         url(r'^$', redirect_to, {'url': 'build/'}),
 )
-- 
1.8.1.2


