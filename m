Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 318436CB88
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:19 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; d="scan'208";a="364948512"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:09 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id BABD4561479; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:56 +0100
Message-Id: <9b2e4c051bc03743c9e15bb2a69982688ef8074b.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 27/94] bitbake: webhob: record dependency info
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:20 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch adds the task dependency information
to the database, and displays it in a primitive form
for verification.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py             |  9 ++++---
 bitbake/lib/webhob/bldviewer/templates/task.html | 33 +++++++++---------------
 bitbake/lib/webhob/bldviewer/views.py            |  9 ++++++-
 3 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 07296d9..f5e3f25 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -8,7 +8,9 @@ import re
 os.environ.setdefault("DJANGO_SETTINGS_MODULE", "webhob.whbmain.settings")
 
 import webhob.whbmain.settings as whb_django_settings
-from webhob.orm.models import Machine, Build, Task, Recipe, Build_Layer, Layer, Package, Task_Dependency, Package_Dependency
+from webhob.orm.models import Machine, Build, Task, Recipe, Build_Layer, Layer, Package
+from webhob.orm.models import Task_Dependency
+
 
 class ORMWrapper(object):
     """ This class creates the dictionaries needed to store information in the database
@@ -429,8 +431,9 @@ class BuildInfoHelper(object):
             return task_obj
 
         for taskdesc in event._depgraph['tdepends']:
-            _save_a_task(taskdesc)
+            target = _save_a_task(taskdesc)
             for taskdesc1 in event._depgraph['tdepends'][taskdesc]:
-                _save_a_task(taskdesc1)
+                dep = _save_a_task(taskdesc1)
+                Task_Dependency.objects.get_or_create( task = target, depends_on = dep )
 
         del self.internal_state['recipes']
diff --git a/bitbake/lib/webhob/bldviewer/templates/task.html b/bitbake/lib/webhob/bldviewer/templates/task.html
index 7410489..1797028 100644
--- a/bitbake/lib/webhob/bldviewer/templates/task.html
+++ b/bitbake/lib/webhob/bldviewer/templates/task.html
@@ -17,57 +17,47 @@
 			<tr>
 			<th>Order</th>
 			<th>Task</th>
-			<th>Recipe</th>
 			<th>Recipe Version</th>
 			<th>Task Type</th>
 			<th>Outcome</th>
 			<th>Errors</th>
 			<th>Warnings</th>
 			<th>Time</th>
-			<th>Log</th>
-			<th>Work directory</th>
 			<th>CPU usage</th>
 			<th>Disk I/O</th>
-			<th>Sstate Checksum</th>
-			<th>Path to sstate object</th>
-			<th>Source URL</th>
 			<th>Script type</th>
 			<th>File path</th>
-			<th>Line number</th>
-			<th>Python Stack Trace</th>
-			<th>Sstate Result</th>
+            <th>Depends</th>
 			</tr>
 
 			{% for task in tasks %}
 
 				<tr>
 				<td>{{task.order}}</td>
-				<td>{{task.task_name}}</td>
-				<td>{{task.recipe.name}}</td>
+				<td><a name="{{task.recipe.name}}.{{task.task_name}}">
+				{{task.recipe.name}}.{{task.task_name}}</a></td>
 				<td>{{task.recipe.version}}</td>
 
 				{% if task.task_executed %}
-					<td>Executed</td>
+				<td>Executed</td>
 				{% else %}
-					<td>Prebuilt</td>
+				<td>Prebuilt</td>
 				{% endif %}
 
 				<td>{{task.get_outcome_display}}</td>
 				<td>{{task.errors_no}}</td>
 				<td>{{task.warnings_no}}</td>
 				<td>{{task.elapsed_time}}</td>
-				<td>{{task.log_file}}</td>
-				<td>{{task.work_directory}}</td>
 				<td>{{task.cpu_usage}}</td>
 				<td>{{task.disk_io}}</td>
-				<td>{{task.sstate_checksum}}</td>
-				<td>{{task.path_to_sstate_obj}}</td>
-				<td>{{task.source_url}}</td>
 				<td>{{task.get_script_type_display}}</td>
 				<td>{{task.recipe.file_path}}</td>
-				<td>{{task.line_number}}</td>
-				<td>{{task.py_stack_trace}}</td>
-				<td>{{task.get_sstate_result_display}}</td>
+                <td>
+                {% for tt in task.depends_on %}
+                    <a href="#{{tt.recipe.name}}.{{tt.task_name}}">
+                    {{tt.recipe.name}}.{{tt.task_name}}</a><br/>
+                {% endfor %}
+                </td>
 				</tr>
 
 			{% endfor %}
@@ -79,3 +69,4 @@
 </body>
 
 </html>
+
diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index f40d396..eb901a4 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -1,5 +1,5 @@
 from django.shortcuts import render
-from orm.models import Build, Task, Layer
+from orm.models import Build, Task, Layer, Task_Dependency
 
 
 def build(request):
@@ -14,6 +14,13 @@ def task(request, build_id):
     template = 'task.html'
 
     tasks = Task.objects.filter(build=build_id)
+    task_depends = Task_Dependency.objects.filter(task__in=tasks)
+
+    for t in tasks:
+        t.depends_on = []
+        for k in task_depends:
+            if t == k.task:
+                t.depends_on.append(k.depends_on)
 
     context = {'tasks': tasks}
 
-- 
1.8.1.2


