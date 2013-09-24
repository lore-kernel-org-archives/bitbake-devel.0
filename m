Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id C1F1F6CBA3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:19 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 24 Sep 2013 09:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; d="scan'208";a="364948542"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:11 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 15DE35625FE; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:27 +0100
Message-Id: <b799a5834fc351759da8c1a0c6aba03de56e3209.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 58/94] bitbake: webhob: display proper information in Simple
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

We modify the Simple interface to match the changes in the
Task file.

Also a couple of display-related changes in the Simple interface.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/templates/build.html |  4 ++--
 bitbake/lib/webhob/bldviewer/templates/task.html  | 10 +++++-----
 bitbake/lib/webhob/bldviewer/views.py             |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/webhob/bldviewer/templates/build.html b/bitbake/lib/webhob/bldviewer/templates/build.html
index bef84a9..20aa310 100644
--- a/bitbake/lib/webhob/bldviewer/templates/build.html
+++ b/bitbake/lib/webhob/bldviewer/templates/build.html
@@ -33,8 +33,8 @@
             <td>{% if build.is_image %} <a href="/simple/build/{{build.id}}/package/">{{build.is_image}}</a>{% else %} {{build.is_image}} {% endif %}</td>
             <td>{{build.machine.name}}</td>
             <td>{% time_difference build.started_on build.completed_on %}</td>
-            <td>{% if  build.errors_no %}{% for error in logs %}{% if error.build == build %}{% if error.level == 2 %}<p>{{error.message}}</p>{% endif %}{% endif %}{% endfor %}{% else %}None{% endif %}</td>
-            <td>{% if  build.warnings_no %}{% for warning in logs %}{% if warning.build == build %}{% if warning.level == 1 %}<p>{{warning.message}}</p>{% endif %}{% endif %}{% endfor %}{% else %}None{% endif %}</td>
+            <td>{{build.errors_no}}:{% if  build.errors_no %}{% for error in logs %}{% if error.build == build %}{% if error.level == 2 %}<p>{{error.message}}</p>{% endif %}{% endif %}{% endfor %}{% else %}None{% endif %}</td>
+            <td>{{build.warnings_no}}:{% if  build.warnings_no %}{% for warning in logs %}{% if warning.build == build %}{% if warning.level == 1 %}<p>{{warning.message}}</p>{% endif %}{% endif %}{% endfor %}{% else %}None{% endif %}</td>
             <td>{{build.image_fstypes}}</td>
             <td>{{build.cooker_log_path}}</td>
             <td>{{build.bitbake_version}}</td>
diff --git a/bitbake/lib/webhob/bldviewer/templates/task.html b/bitbake/lib/webhob/bldviewer/templates/task.html
index 2d78668..d87d261 100644
--- a/bitbake/lib/webhob/bldviewer/templates/task.html
+++ b/bitbake/lib/webhob/bldviewer/templates/task.html
@@ -15,8 +15,8 @@
             <th>Recipe Version</th>
             <th>Task Type</th>
             <th>Outcome</th>
-            <th>Errors</th>
-            <th>Warnings</th>
+            <th>Message</th>
+            <th>Logfile</th>
             <th>Time</th>
             <th>CPU usage</th>
             <th>Disk I/O</th>
@@ -40,13 +40,13 @@
                 {% endif %}
 
                 <td>{{task.get_outcome_display}}</td>
-                <td>{{task.errors_no}}</td>
-                <td>{{task.warnings_no}}</td>
+                <td><p>{{task.message}}</td>
+                <td><a target="_fileview" href="file:///{{task.logfile}}">{{task.logfile}}</a></td>
                 <td>{{task.elapsed_time}}</td>
                 <td>{{task.cpu_usage}}</td>
                 <td>{{task.disk_io}}</td>
                 <td>{{task.get_script_type_display}}</td>
-                <td>{{task.recipe.file_path}}</td>
+                <td><a target="_fileview" href="file:///{{task.recipe.file_path}}">{{task.recipe.file_path}}</a></td>
                 <td>
             <div style="height: 3em; overflow:auto">
                 {% for tt in task.depends_on %}
diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index 8535963..7f97312 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -19,7 +19,7 @@ def task(request, build_id):
     template = 'task.html'
 
     tasks = Task.objects.filter(build=build_id)
-    task_depends = Task_Dependency.objects.filter(task__in=tasks)
+    task_depends = Task_Dependency.objects.filter(task__in=tasks).select_related()
 
     for t in tasks:
         t.depends_on = []
-- 
1.8.1.2


