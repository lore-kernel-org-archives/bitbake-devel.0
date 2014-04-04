Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f174.google.com (mail-we0-f174.google.com
	[74.125.82.174])
	by mail.openembedded.org (Postfix) with ESMTP id A4AFA6B72B
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Apr 2014 14:10:59 +0000 (UTC)
Received: by mail-we0-f174.google.com with SMTP id t60so3468273wes.19
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Apr 2014 07:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=40nTUTnIJN8y0gH1tmU6CKU4XudZ1qe4nIGYLxMRmFY=;
	b=bSV4Rv00sy59O95Ee5yT2rTLFW+ZzSWqb7jY/iWrQI8YY5GFXR2IvEknMM309aBK0P
	GquJ0SZsYUOxpwOorB5pHhV4ibuLdin/kZzD/Eb8Tdo1ascifwP9d7vlbg8lKb7YI4SE
	xyXvVTgqsfbANCqV+NN2b0xs4ISMc+ga47chcWEovq6PtuKG8zjrXp+C0s4CTTSBk6QF
	TvZx/OA9fAEYBff0OdBX+GHFaM15Illsu2iid/BXoypzV/KN7R61f/Ny6b/232uHaBlL
	TzF7svFki1Rmm5Q90UZ6QvXqcwqHeout9IIcbw4JzFRhC2RqOwBY+1EzXnl7zVCys78q
	vZbQ==
X-Gm-Message-State: ALoCoQmuST+C6s3ivaMaI/lhxs2fFlq9EpRjX+JR+V4/hWh96QmtUM/m3E2Ts1/surx1UpQ8L7fo
X-Received: by 10.194.192.132 with SMTP id hg4mr20459546wjc.28.1396620660053; 
	Fri, 04 Apr 2014 07:11:00 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	gp15sm12627659wjc.10.2014.04.04.07.10.56 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Apr 2014 07:10:57 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 8BAA65607E4; Fri,  4 Apr 2014 15:10:54 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Apr 2014 15:10:46 +0100
Message-Id: <afd71e439d2149bb3e294c3845793090732ca802.1396620556.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
References: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396620556.git.alexandru.damian@intel.com>
References: <cover.1396620556.git.alexandru.damian@intel.com>
Subject: [PATCH 07/14] toaster: Changes to help text
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
X-List-Received-Date: Fri, 04 Apr 2014 14:11:03 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

All help text strings have been reviewed by the
technical writer, and some of them by Paul Eggleton.
This patch implements their suggested changes.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/orm/models.py                          |  2 +-
 .../toastergui/templates/builddashboard.html       | 20 +++++++--
 .../templates/package_built_dependencies.html      |  4 +-
 .../toastergui/templates/package_built_detail.html |  6 +--
 .../toastergui/templates/package_detail_base.html  |  4 +-
 .../templates/package_included_dependencies.html   |  2 +-
 .../templates/package_included_tabs.html           |  2 +-
 lib/toaster/toastergui/templates/recipe.html       | 16 +++----
 lib/toaster/toastergui/templates/task.html         | 34 +++++++-------
 lib/toaster/toastergui/views.py                    | 52 +++++++++++-----------
 10 files changed, 77 insertions(+), 65 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 658e1d2..c344c66 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -150,7 +150,7 @@ class Task(models.Model):
     )
 
     TASK_OUTCOME_HELP = (
-        (OUTCOME_SUCCESS, 'This task completed successfully'),
+        (OUTCOME_SUCCESS, 'This task successfully completed'),
         (OUTCOME_COVERED, 'This task did not run because its output is provided by another task'),
         (OUTCOME_CACHED, 'This task restored output from the sstate-cache directory or mirrors'),
         (OUTCOME_PREBUILT, 'This task did not run because its outcome was reused from a previous build'),
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index 6563128..6cce788 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -84,7 +84,7 @@
 			<dt>Total package size</dt>
 			<dd>{{target.pkgsz|filtered_filesizeformat}}</dd>
 			<dt>
-				<i class="icon-question-sign get-help" title="The location in disk of the license manifest, a document listing all packages installed in your image and their licenses"></i>
+				<i class="icon-question-sign get-help" title="Path to the license manifest, which is a document listing all packages installed in your image and their licenses"></i>
 				License manifest
 			</dt>
 			<dd><a href="{% url 'targetpackages' build.pk target.target.pk %}"><code>{{target.target.license_manifest_path}}</code></a></dd>
@@ -126,9 +126,21 @@
         <h4><a href="{%url 'tasks' build.pk%}">Tasks</a></h4>
             <dl>
         <dt>Total number of tasks</dt><dd><a href="{% url 'tasks' build.pk %}">{{build.task_build.all.count}}</a></dd>
-        <dt>Tasks executed</dt><dd><a href="{% url 'tasks' build.pk %}?filter=task_executed%3A1&amp;count=25&amp;search=&amp;page=1&amp;orderby=order%3A%2B">{% query build.task_build task_executed=1 order__gt=0 as exectask%}{{exectask.count}}</a></dd>
-        <dt>Tasks not executed</dt><dd><a href="{% url 'tasks' build.pk %}?filter=task_executed%3A0&amp;count=25&amp;search=&amp;page=1&amp;orderby=order%3A%2B">{% query build.task_build task_executed=0 order__gt=0 as noexectask%}{{noexectask.count}}</a></dd>
-        <dt>Reuse</dt><dd>
+        <dt>
+            Tasks executed
+            <i class="icon-question-sign get-help" title="'Executed' tasks are those that need to be run in order to generate the task output"></i>
+        </dt>
+        <dd><a href="{% url 'tasks' build.pk %}?filter=task_executed%3A1&amp;count=25&amp;search=&amp;page=1&amp;orderby=order%3A%2B">{% query build.task_build task_executed=1 order__gt=0 as exectask%}{{exectask.count}}</a></dd>
+        <dt>
+            Tasks not executed
+            <i class="icon-question-sign get-help" title="'Not executed' tasks don't need to run because their outcome is provided by another task"></i>
+        </dt>           
+        <dd><a href="{% url 'tasks' build.pk %}?filter=task_executed%3A0&amp;count=25&amp;search=&amp;page=1&amp;orderby=order%3A%2B">{% query build.task_build task_executed=0 order__gt=0 as noexectask%}{{noexectask.count}}</a></dd>
+        <dt>
+            Reuse
+            <i class="icon-question-sign get-help" title="The percentage of 'not executed' tasks over the total number of tasks, which is a measure of the efficiency of your build"></i>
+        </dt>     
+        <dd>
 {% query build.task_build order__gt=0 as texec %}
 {% if noexectask.count|multiply:100|divide:texec.count < 0 %}
 0
diff --git a/lib/toaster/toastergui/templates/package_built_dependencies.html b/lib/toaster/toastergui/templates/package_built_dependencies.html
index 8613f1e..4e86da5 100644
--- a/lib/toaster/toastergui/templates/package_built_dependencies.html
+++ b/lib/toaster/toastergui/templates/package_built_dependencies.html
@@ -24,7 +24,7 @@
                 </div>
             {% else %}
                 <div class="alert alert-info">
-                    <strong>{{package.fullpackagespec}}</strong> is <strong>not included</strong> in any image.  These are its projected runtime dependencies if you were to include it in future builds.
+                    <strong>{{package.fullpackagespec}}</strong> is <strong>not included</strong> in any image. This page shows you the projected runtime dependencies if you include <strong>{{package.fullpackagespec}}</strong> in future builds.
                 </div>
                 <table class="table table-bordered table-hover">
                     <thead>
@@ -64,7 +64,7 @@
                             <th>Version</th>
                             <th>Size</th>
                             <th>
-                                <i class="icon-question-sign get-help" title="There are 5 relationship types: recommends, suggests, provides, replaces and conflicts"></i>
+                                <i class="icon-question-sign get-help" title="Five relationship types exist: recommends, suggests, provides, replaces and conflicts"></i>
                                 Relationship type
                             </th>
                         </tr>
diff --git a/lib/toaster/toastergui/templates/package_built_detail.html b/lib/toaster/toastergui/templates/package_built_detail.html
index 6ccd405..3aa1b2a 100644
--- a/lib/toaster/toastergui/templates/package_built_detail.html
+++ b/lib/toaster/toastergui/templates/package_built_detail.html
@@ -8,11 +8,11 @@
             {# Not included case #}
             <ul class="nav nav-pills">
                 <li class="active"> <a href="#">
-                    <i class="icon-question-sign get-help" data-toggle="tooltip" title="Files that would be added to a root file system if you were to include {{package.name}} in an image"></i>
+                    <i class="icon-question-sign get-help" data-toggle="tooltip" title="Files added to a root file system when you include {{package.name}} in an image"></i>
                     Generated files ({{packageFileCount}})
                 </a></li>
                 <li class=""><a href="{% url 'package_built_dependencies' build.id package.id %}">
-                    <i class="icon-question-sign get-help" data-toggle="tooltip" title="Projected runtime dependencies if you were to include {{package.name}} in an image"></i>
+                    <i class="icon-question-sign get-help" data-toggle="tooltip" title="Projected runtime dependencies when you include {{package.name}} in an image"></i>
                     Runtime dependencies ({{dependency_count}})
                 </a></li>
             </ul>
@@ -21,7 +21,7 @@
             <!-- Package file list or if empty, alert pane -->
             {% if packageFileCount > 0 %}
                 <div class="alert alert-info">
-                    {{package.fullpackagespec}} is <strong>not included</strong> in any image.  These are the files that would be added to an image root file system if you were to include it in future builds.
+                    <strong>{{package.fullpackagespec}}</strong> is <strong>not included</strong> in any image. This page shows you the files added to an image root file system if you include <strong>{{package.fullpackagespec}}</strong> in future builds.
                 </div>
                 <table class="table table-bordered table-hover">
                     <thead>
diff --git a/lib/toaster/toastergui/templates/package_detail_base.html b/lib/toaster/toastergui/templates/package_detail_base.html
index 5ec9dd7..5888513 100644
--- a/lib/toaster/toastergui/templates/package_detail_base.html
+++ b/lib/toaster/toastergui/templates/package_detail_base.html
@@ -83,7 +83,7 @@
             # problemse are resolved.
             <dt>
                 License files
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="Location in disk of the license files that apply to the package"></i>
+                <i class="icon-question-sign get-help" data-toggle="tooltip" title="Path to the license files that apply to the package"></i>
             </dt>
             <dd></dd>
             {% endcomment %}
@@ -136,7 +136,7 @@
             <dd class="iscommit">{{package.recipe.layer_version.commit}}</dd>
             <dt>
                 Layer directory
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="Location in disk of the layer providing the recipe that builds this package"></i>
+                <i class="icon-question-sign get-help" data-toggle="tooltip" title="Path to the layer providing the recipe that builds this package"></i>
             </dt>
             <dd><code>{{package.recipe.layer_version.layer.local_path}}</code></dd>
         </dl>
diff --git a/lib/toaster/toastergui/templates/package_included_dependencies.html b/lib/toaster/toastergui/templates/package_included_dependencies.html
index e06e073..9169ee9 100644
--- a/lib/toaster/toastergui/templates/package_included_dependencies.html
+++ b/lib/toaster/toastergui/templates/package_included_dependencies.html
@@ -59,7 +59,7 @@
                         <th>Version</th>
                         <th>Size</th>
                         <th>
-                            <i class="icon-question-sign get-help" title="There are 5 relationship types: recommends, suggests, provides, replaces and conflicts"></i>
+                            <i class="icon-question-sign get-help" title="Five relationship types exist: recommends, suggests, provides, replaces and conflicts"></i>
                             Relationship type
                         </th>
                     </tr>
diff --git a/lib/toaster/toastergui/templates/package_included_tabs.html b/lib/toaster/toastergui/templates/package_included_tabs.html
index 3ea4915..0140b03 100644
--- a/lib/toaster/toastergui/templates/package_included_tabs.html
+++ b/lib/toaster/toastergui/templates/package_included_tabs.html
@@ -26,7 +26,7 @@
         <li class="">
     {% endif %}
             <a href="{% url 'package_included_reverse_dependencies' build.id target.id package.id %}">
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="The package runtime reverse dependencies (i.e. which other packages in this image depend on this package). Reverse dependencies reflect only the 'depends' dependency type"></i>
+                <i class="icon-question-sign get-help" data-toggle="tooltip" title="The package runtime reverse dependencies (i.e. the packages in this image that depend on this package). Reverse dependencies reflect only the 'depends' dependency type"></i>
                 Reverse runtime dependencies ({{reverse_count}})
             </a>
         </li>
diff --git a/lib/toaster/toastergui/templates/recipe.html b/lib/toaster/toastergui/templates/recipe.html
index b8898d2..c846aa9 100644
--- a/lib/toaster/toastergui/templates/recipe.html
+++ b/lib/toaster/toastergui/templates/recipe.html
@@ -33,13 +33,13 @@
         </li>
         <li>
             <a href="#dependencies" data-toggle="tab">
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="The recipe build-time dependencies (other recipes)"></i>
+                <i class="icon-question-sign get-help" data-toggle="tooltip" title="The recipe build-time dependencies (i.e. other recipes)"></i>
                 Build dependencies ({{object.r_dependencies_recipe.all.count}})
             </a>
         </li>
         <li>
             <a href="#brought-in-by" data-toggle="tab">
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="The recipe build-time reverse dependencies (i.e. which other recipes depend on this recipe)"></i>
+                <i class="icon-question-sign get-help" data-toggle="tooltip" title="The recipe build-time reverse dependencies (i.e. the recipes that depend on this recipe)"></i>
                 Reverse build dependencies ({{object.r_dependencies_depends.all.count}})
             </a>
         </li>
@@ -53,12 +53,12 @@
                 </dt>
                 <dd>{{layer.name}}</dd>
                 <dt>
-                    <i class="icon-question-sign get-help" data-toggle="tooltip" title="Location in disk of the layer providing the recipe"></i>
+                    <i class="icon-question-sign get-help" data-toggle="tooltip" title="Path to the layer providing the recipe"></i>
                     Layer directory
                 </dt>
                 <dd><code>{{layer.local_path}}</code></dd>
                 <dt>
-                    <i class="icon-question-sign get-help" data-toggle="tooltip" title="Location in disk of the recipe .bb file"></i>
+                    <i class="icon-question-sign get-help" data-toggle="tooltip" title="Path to the recipe .bb file"></i>
                     Recipe file
                 </dt>
                 <dd><code>{{object.file_path}}</code></dd>
@@ -91,15 +91,15 @@
                         Task
                     </th>
                     <th>
-                        <i class="icon-question-sign get-help" title="This value tells you if a task had to run in order to generate the task output (executed), or if the output was provided by another task and therefore the task didn't need to run (not executed)"></i>
+                        <i class="icon-question-sign get-help" title="This value tells you if a task had to run (executed) in order to generate the task output, or if the output was provided by another task and therefore the task didn't need to run (not executed)"></i>
                         Executed
                     </th>
                     <th>
-                        <i class="icon-question-sign get-help" title="This column tells you if executed tasks succeeded, failed or reused output from the sstate-cache directory or mirrors. It also tells you why not executed tasks did not need to run"></i>
+                        <i class="icon-question-sign get-help" title="This column tells you if 'executed' tasks succeeded or failed. The column also tells you why 'not executed' tasks did not need to run"></i>
                         Outcome
                     </th>
                     <th>
-                        <i class="icon-question-sign get-help" title="This column tells you if a task tried to restore output from the <code>sstate-cache</code> directory or mirros, and what was the result: Succeeded, Failed or File not in cache"></i>
+                        <i class="icon-question-sign get-help" title="This column tells you if a task tried to restore output from the <code>sstate-cache</code> directory or mirrors, and reports the result: Succeeded, Failed or File not in cache"></i>
                         Cache attempt
                     </th>
                 </thead>
@@ -259,7 +259,7 @@
         {% if object.section %}
             <dt>
             Section
-            <i class="icon-question-sign get-help" data-toggle="tooltip" title="The section in which recipes should be categorised"></i>
+            <i class="icon-question-sign get-help" data-toggle="tooltip" title="The section in which recipes should be categorized"></i>
             </dt>
             <dd>{{object.section}}</dd>
         {% endif %}
diff --git a/lib/toaster/toastergui/templates/task.html b/lib/toaster/toastergui/templates/task.html
index 5c32250..c1504b6 100644
--- a/lib/toaster/toastergui/templates/task.html
+++ b/lib/toaster/toastergui/templates/task.html
@@ -25,7 +25,7 @@
     <dl class="dl-horizontal">
 	{% if task.logfile %}
         <dt>
-            <i class="icon-question-sign get-help" title="The location in disk of the task log file"></i> Log file
+            <i class="icon-question-sign get-help" title="Path the task log file"></i> Log file
         </dt>
         <dd>
             <code>{{task.logfile}}</code>
@@ -46,10 +46,10 @@
 {# not executed tasks outcome #}
     {% if task.outcome == task.OUTCOME_PREBUILT %}
         {% if not showing_matches %}
-            <a class="btn" href="javascript:reload_params({'show_matches' : 'true' })">Match to tasks in previous builds <i class="icon-question-sign get-help" style="margin-top:20px;" data-toggle="tooltip" title="This will show you a list of tasks from previous builds with the same inputs signature as this prebuilt task. Any of them could be the task that generated the output this prebuilt task is reusing"></i></a>
+            <a class="btn" href="javascript:reload_params({'show_matches' : 'true' })">Match to tasks in previous builds <i class="icon-question-sign get-help" style="margin-top:20px;" data-toggle="tooltip" title="This shows you a list of tasks from previous builds with the same signature generated from the same inputs as used in the prebuilt task. Any of them could be the task that generated the output this prebuilt task is reusing"></i></a>
         {% elif matching_tasks %}
             <h3 class="details">Prebuilt task could be based on
-                <i class="icon-question-sign get-help heading-help" title="This table shows a list of tasks from previous builds with the same inputs signature as the prebuilt task. Any of them could be the task that generated the output the prebuilt task is reusing"></i>
+                <i class="icon-question-sign get-help heading-help" title="This table shows a list of tasks from previous builds with the same signature generated from the same inputs as used in the prebuilt task. Any of them could be the task that generated the output this prebuilt task is reusing"></i>
             </h3>
             <table class="table table-bordered table-hover">
                 <thead>
@@ -62,11 +62,11 @@
                         Task
                     </th>
                     <th>
-                        <i class="icon-question-sign get-help" title="This value tells you if a task had to run in order to generate the task output (executed), or if the output was provided by another task and therefore the task didn't need to run (not executed)"></i>
+                        <i class="icon-question-sign get-help" title="This value tells you if a task had to run (executed) in order to generate the task output, or if the output was provided by another task and therefore the task didn't need to run (not executed)"></i>
                         Executed
                     </th>
                     <th>
-                        <i class="icon-question-sign get-help" title="This column tells you if executed tasks succeeded, failed or reused output from the sstate-cache directory or mirrors. It also tells you why not executed tasks did not need to run"></i>
+                        <i class="icon-question-sign get-help" title="This column tells you if 'executed' tasks succeeded or failed. The column also tells you why 'not executed' tasks did not need to run"></i>
                         Outcome
                     </th>
                     <th>
@@ -116,7 +116,7 @@
     {%elif task.outcome == task.OUTCOME_CACHED%}
         <dl class="dl-horizontal">
             <dt>
-                <i class="icon-question-sign get-help" title="The location in disk of the task log file"></i> Log file
+                <i class="icon-question-sign get-help" title="Path the task log file"></i> Log file
             </dt>
             <dd>
                 <code>{% for t in task.get_related_setscene %} {{t.logfile}} {% endfor %}</code>
@@ -133,11 +133,11 @@
     {% if task.task_executed %}
 	<h2>
         Executed
-        <i class="icon-question-sign get-help heading-help" title="Executed tasks are those that need to run in order to generate the task output"></i>
+        <i class="icon-question-sign get-help heading-help" title="'Executed' tasks are those that need to run in order to generate the task output"></i>
     {% else %}
 	<h2 class="muted">
         Not Executed
-        <i class="icon-question-sign get-help heading-help" title="Not executed tasks don't need to run because their outcome is provided by another task"></i>
+        <i class="icon-question-sign get-help heading-help" title="'Not executed' tasks don't need to run because their outcome is provided by another task"></i>
     {% endif %}
 	</h2>
 <dl class="dl-horizontal">
@@ -151,7 +151,7 @@
     {% if task.sstate_result != task.SSTATE_NA %}
 		</dl>
         <div class="alert alert-info">Attempting to restore output from sstate cache
-            <i class="icon-question-sign get-help get-help-blue" title="The build system is searching for the task output in your <code>sstate-cache</code> directory and mirrors. If it finds it, it will use it instead of building it from scratch by running the real task. This makes the build faster"></i>
+            <i class="icon-question-sign get-help get-help-blue" title="The build system is searching for the task output in your <code>sstate-cache</code> directory and mirrors. If the build system finds the task output, it will reuse it instead of building it from scratch by running the real task. Reusing the task output makes the build faster"></i>
         </div>
 		<dl class="dl-horizontal">
             <dt>
@@ -160,7 +160,7 @@
             </dt>
             <dd><code>{{task.path_to_sstate_obj}}</code></dd>
             <dt>
-                <i class="icon-question-sign get-help" title="The locations where the above file was searched: your <code>sstate-cache</code> directory and the mirrors you have set up (if any)"></i>
+                <i class="icon-question-sign get-help" title="The locations searched for the above file (i.e. your <code>sstate-cache</code> directory and any mirrors you have set up)"></i>
                 URI(s) searched
             </dt>
             <dd><code>{{task.work_directory}}</code></dd>
@@ -176,12 +176,12 @@
         </div>
         <dl class="dl-horizontal">
             <dt>
-                <i class="icon-question-sign get-help" title="The location in disk of the cache attempt log file"></i>
+                <i class="icon-question-sign get-help" title="Path to the cache attempt log file"></i>
                 Log file
             </dt>
             <dd><code>{{task.logfile}}</code></dd>
             <dt>
-                <i class="icon-question-sign get-help" title="How long it took the cache attempt to finish, expressed in seconds"></i>
+                <i class="icon-question-sign get-help" title="How long it took the cache attempt to finish in seconds"></i>
                 Time (secs)
             </dt>
             <dd>{{task.elapsed_time|format_none_and_zero}}</dd>
@@ -202,7 +202,7 @@
     <dd><a href="{%url "tasks_task" build.pk task.order %}#{{task.order}}">{{task.order}}</a></dd>
     {% if task.task_executed %}
         <dt>
-            <i class="icon-question-sign get-help" title="If this task executes a Python or Shell function(s)"></i>
+            <i class="icon-question-sign get-help" title="Indicates if this task executes a Python or Shell function(s)"></i>
             Task script type
         </dt>
         <dd>{{task.get_script_type_display}}</dd>
@@ -215,7 +215,7 @@
     <dd><code>{{task.source_url}}</code></dd>
 -->
     <dt>
-        <i class="icon-question-sign get-help" title="Task dependency chain (other tasks)"></i>
+        <i class="icon-question-sign get-help" title="Task dependency chain (i.e. other tasks)"></i>
         Dependencies
     </dt>
     <dd>
@@ -228,7 +228,7 @@
         </ul>
     </dd>
     <dt>
-        <i class="icon-question-sign get-help" title="Which other tasks depend on this task"></i>
+        <i class="icon-question-sign get-help" title="Tasks that depend on this task"></i>
         Reverse dependencies
     </dt>
     <dd>
@@ -248,14 +248,14 @@
     <dl class="dl-horizontal">
 		{% if task.elapsed_time %}
         <dt>
-            <i class="icon-question-sign get-help" title="How long it took the task to finish, expressed in seconds"></i>
+            <i class="icon-question-sign get-help" title="How long it took the task to finish in seconds"></i>
             Time (secs)
         </dt>
         <dd>{{task.elapsed_time|format_none_and_zero|floatformat:2}}</dd>
 		{% endif %}	
 		{% if task.cpu_usage > 0 %}	
         <dt>
-            <i class="icon-question-sign get-help" title="Task CPU utilisation, expressed as a percentage"></i>
+            <i class="icon-question-sign get-help" title="The percentage of task CPU utilization"></i>
             CPU usage
         </dt>
         <dd>{{task.cpu_usage|format_none_and_zero|floatformat:2}}%</dd>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index a92a03f..ba69dd8 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -268,7 +268,7 @@ def builds(request):
             # Specifies the display of columns for the table, appearance in "Edit columns" box, toggling default show/hide, and specifying filters for columns
                 'tablecols' : [
                 {'name': 'Outcome',                                                # column with a single filter
-                 'qhelp' : "The outcome tells you if a build completed successfully or failed",     # the help button content
+                 'qhelp' : "The outcome tells you if a build successfully completed or failed",     # the help button content
                  'dclass' : "span2",                                                # indication about column width; comes from the design
                  'orderfield': _get_toggle_order(request, "outcome"),               # adds ordering by the field value; default ascending unless clicked from ascending into descending
                  'ordericon':_get_toggle_order_icon(request, "outcome"),
@@ -284,12 +284,12 @@ def builds(request):
                             }
                 },
                 {'name': 'Target',                                                 # default column, disabled box, with just the name in the list
-                 'qhelp': "This is the build target(s): one or more recipes or image recipes",
+                 'qhelp': "This is the build target or build targets (i.e. one or more recipes or image recipes)",
                  'orderfield': _get_toggle_order(request, "target__target"),
                  'ordericon':_get_toggle_order_icon(request, "target__target"),
                 },
                 {'name': 'Machine',
-                 'qhelp': "The machine is the hardware for which you are building",
+                 'qhelp': "The machine is the hardware for which you are building a recipe or image recipe",
                  'orderfield': _get_toggle_order(request, "machine"),
                  'ordericon':_get_toggle_order_icon(request, "machine"),
                  'dclass': 'span3'
@@ -361,7 +361,7 @@ def builds(request):
                 },
                 {'name': 'Log',
                  'dclass': "span4",
-                 'qhelp': "The location in disk of the build main log file",
+                 'qhelp': "Path to the build main log file",
                  'clclass': 'log', 'hidden': 1,
                  'orderfield': _get_toggle_order(request, "cooker_log_path"),
                  'ordericon':_get_toggle_order_icon(request, "cooker_log_path"),
@@ -536,7 +536,7 @@ def target(request, build_id, target_id):
                 },
                 {
                     'name':'License',
-                    'qhelp':'The license under which the package is distributed. Separate license names using | (pipe) means there is a choice between licenses. Separate license names using & (ampersand) means multiple licenses exist that cover different parts of the source',
+                    'qhelp':'The license under which the package is distributed. Multiple license names separated by the pipe character indicates a choice between licenses. Multiple license names separated by the ampersand character indicates multiple licenses exist that cover different parts of the source',
                     'orderfield': _get_toggle_order(request, "license"),
                     'ordericon':_get_toggle_order_icon(request, "license"),
                     'clclass': 'license',
@@ -544,13 +544,13 @@ def target(request, build_id, target_id):
                 },
                 {
                     'name':'Dependencies',
-                    'qhelp':"Package runtime dependencies (other packages)",
+                    'qhelp':"Package runtime dependencies (i.e. other packages)",
                     'clclass': 'depends',
                     'hidden' : 0,
                 },
                 {
                     'name':'Reverse dependencies',
-                    'qhelp':'Package run-time reverse dependencies (i.e. which other packages depend on this package',
+                    'qhelp':'Package run-time reverse dependencies (i.e. other packages that depend on this package)',
                     'clclass': 'brought_in_by',
                     'hidden' : 0,
                 },
@@ -592,7 +592,7 @@ def target(request, build_id, target_id):
                 },
                 {
                     'name':'Layer directory',
-                    'qhelp':'Location in disk of the layer providing the recipe that builds the package',
+                    'qhelp':'Path to the layer providing the recipe that builds the package',
                     'orderfield': _get_toggle_order(request, "recipe__layer_version__layer__local_path"),
                     'ordericon':_get_toggle_order_icon(request, "recipe__layer_version__layer__local_path"),
                     'clclass': 'layer_directory',
@@ -847,7 +847,7 @@ def tasks_common(request, build_id, variant, task_anchor):
     }
     tc_executed={
         'name':'Executed',
-        'qhelp':"This value tells you if a task had to run in order to generate the task output (executed), or if the output was provided by another task and therefore the task didn't need to run (not executed)",
+        'qhelp':"This value tells you if a task had to run (executed) in order to generate the task output, or if the output was provided by another task and therefore the task didn't need to run (not executed)",
         'clclass': 'executed', 'hidden' : 0,
         'orderfield': _get_toggle_order(request, "task_executed"),
         'ordericon':_get_toggle_order_icon(request, "task_executed"),
@@ -863,7 +863,7 @@ def tasks_common(request, build_id, variant, task_anchor):
     }
     tc_outcome={
         'name':'Outcome',
-        'qhelp':'This column tells you if executed tasks succeeded, failed or restored output from the <code>sstate-cache</code> directory or mirrors. It also tells you why not executed tasks did not need to run',
+        'qhelp':"This column tells you if 'executed' tasks succeeded or failed. The column also tells you why 'not executed' tasks did not need to run",
         'clclass': 'outcome', 'hidden' : 0,
         'orderfield': _get_toggle_order(request, "outcome"),
         'ordericon':_get_toggle_order_icon(request, "outcome"),
@@ -871,9 +871,9 @@ def tasks_common(request, build_id, variant, task_anchor):
                    'class' : 'outcome',
                    'label': 'Show:',
                    'options' : [
-                               ('Succeeded Tasks', 'outcome:%d'%Task.OUTCOME_SUCCESS, queryset_with_search.filter(outcome=Task.OUTCOME_SUCCESS).count(), 'Succeeded tasks are those that ran and completed during the build' ),
-                               ('Failed Tasks', 'outcome:%d'%Task.OUTCOME_FAILED, queryset_with_search.filter(outcome=Task.OUTCOME_FAILED).count(), 'Failed tasks are those that ran but did not complete during the build'),
-                               ('Cached Tasks', 'outcome:%d'%Task.OUTCOME_CACHED, queryset_with_search.filter(outcome=Task.OUTCOME_CACHED).count(), 'Cached tasks restored output from the <code>sstate-cache</code> directory or mirrors'),
+                               ('Succeeded Tasks', 'outcome:%d'%Task.OUTCOME_SUCCESS, queryset_with_search.filter(outcome=Task.OUTCOME_SUCCESS).count(), "'Succeeded' tasks are those that ran and completed during the build" ),
+                               ('Failed Tasks', 'outcome:%d'%Task.OUTCOME_FAILED, queryset_with_search.filter(outcome=Task.OUTCOME_FAILED).count(), "'Failed' tasks are those that ran but did not complete during the build"),
+                               ('Cached Tasks', 'outcome:%d'%Task.OUTCOME_CACHED, queryset_with_search.filter(outcome=Task.OUTCOME_CACHED).count(), 'Cached tasks restore output from the <code>sstate-cache</code> directory or mirrors'),
                                ('Prebuilt Tasks', 'outcome:%d'%Task.OUTCOME_PREBUILT, queryset_with_search.filter(outcome=Task.OUTCOME_PREBUILT).count(),'Prebuilt tasks didn\'t need to run because their output was reused from a previous build'),
                                ('Covered Tasks', 'outcome:%d'%Task.OUTCOME_COVERED, queryset_with_search.filter(outcome=Task.OUTCOME_COVERED).count(), 'Covered tasks didn\'t need to run because their output is provided by another task in this build'),
                                ('Empty Tasks', 'outcome:%d'%Task.OUTCOME_EMPTY, queryset_with_search.filter(outcome=Task.OUTCOME_NA).count(), 'Empty tasks have no executable content'),
@@ -883,14 +883,14 @@ def tasks_common(request, build_id, variant, task_anchor):
     }
     tc_log={
         'name':'Log',
-        'qhelp':'The location in disk of the task log file',
+        'qhelp':'Path to the task log file',
         'orderfield': _get_toggle_order(request, "logfile"),
         'ordericon':_get_toggle_order_icon(request, "logfile"),
         'clclass': 'task_log', 'hidden' : 1,
     }
     tc_cache={
         'name':'Cache attempt',
-        'qhelp':'This column tells you if a task tried to restore output from the <code>sstate-cache</code> directory or mirrors, and what was the result: Succeeded, Failed or File not in cache',
+        'qhelp':'This column tells you if a task tried to restore output from the <code>sstate-cache</code> directory or mirrors, and reports the result: Succeeded, Failed or File not in cache',
         'clclass': 'cache_attempt', 'hidden' : 0,
         'orderfield': _get_toggle_order(request, "sstate_result"),
         'ordericon':_get_toggle_order_icon(request, "sstate_result"),
@@ -909,7 +909,7 @@ def tasks_common(request, build_id, variant, task_anchor):
     #if   'tasks' == variant: tc_cache['hidden']='0';
     tc_time={
         'name':'Time (secs)',
-        'qhelp':'How long it took the task to finish, expressed in seconds',
+        'qhelp':'How long it took the task to finish in seconds',
         'orderfield': _get_toggle_order(request, "elapsed_time", True),
         'ordericon':_get_toggle_order_icon(request, "elapsed_time"),
         'clclass': 'time_taken', 'hidden' : 1,
@@ -917,7 +917,7 @@ def tasks_common(request, build_id, variant, task_anchor):
     if   'buildtime' == variant: tc_time['hidden']='0'; del tc_time['clclass']; tc_cache['hidden']='1';
     tc_cpu={
         'name':'CPU usage',
-        'qhelp':'Task CPU utilisation, expressed as a percentage',
+        'qhelp':'The percentage of task CPU utilization',
         'orderfield': _get_toggle_order(request, "cpu_usage", True),
         'ordericon':_get_toggle_order_icon(request, "cpu_usage"),
         'clclass': 'cpu_used', 'hidden' : 1,
@@ -1002,31 +1002,31 @@ def recipes(request, build_id):
             },
             {
                 'name':'Dependencies',
-                'qhelp':'Recipe build-time dependencies (other recipes)',
+                'qhelp':'Recipe build-time dependencies (i.e. other recipes)',
                 'clclass': 'depends_on', 'hidden': 1,
             },
             {
                 'name':'Reverse dependencies',
-                'qhelp':'Recipe build-time reverse dependencies (i.e. which other recipes depend on this recipe)',
+                'qhelp':'Recipe build-time reverse dependencies (i.e. the recipes that depend on this recipe)',
                 'clclass': 'depends_by', 'hidden': 1,
             },
             {
                 'name':'Recipe file',
-                'qhelp':'Location in disk of the recipe .bb file',
+                'qhelp':'Path to the recipe .bb file',
                 'orderfield': _get_toggle_order(request, "file_path"),
                 'ordericon':_get_toggle_order_icon(request, "file_path"),
                 'clclass': 'recipe_file', 'hidden': 0,
             },
             {
                 'name':'Section',
-                'qhelp':'The section in which recipes should be categorised',
+                'qhelp':'The section in which recipes should be categorized',
                 'orderfield': _get_toggle_order(request, "section"),
                 'ordericon':_get_toggle_order_icon(request, "section"),
                 'clclass': 'recipe_section', 'hidden': 0,
             },
             {
                 'name':'License',
-                'qhelp':'The list of source licenses for the recipe. Separate license names using | (pipe) means there is a choice between licenses. Separate license names using & (ampersand) means multiple licenses exist that cover different parts of the source',
+                'qhelp':'The list of source licenses for the recipe. Multiple license names separated by the pipe character indicates a choice between licenses. Multiple license names separated by the ampersand character indicates multiple licenses exist that cover different parts of the source',
                 'orderfield': _get_toggle_order(request, "license"),
                 'ordericon':_get_toggle_order_icon(request, "license"),
                 'clclass': 'recipe_license', 'hidden': 0,
@@ -1052,7 +1052,7 @@ def recipes(request, build_id):
             },
             {
                 'name':'Layer directory',
-                'qhelp':'Location in disk of the layer providing the recipe',
+                'qhelp':'Path to the layer prodiving the recipe',
                 'orderfield': _get_toggle_order(request, "layer_version__layer__local_path"),
                 'ordericon':_get_toggle_order_icon(request, "layer_version__layer__local_path"),
                 'clclass': 'layer_version__layer__local_path', 'hidden': 1,
@@ -1174,7 +1174,7 @@ def configvars(request, build_id):
                     'class' : 'description',
                     'label': 'Show:',
                     'options' : [
-                               ('Variables with description', 'description__regex:.+', queryset_with_search.filter(description__regex='.+').count(), 'We provide descriptions for the most common BiBake variables, so this filter effectively shows you a curated list of variables put together by the Yocto Project maintainers. The curated list lives in <code>/meta/conf/documentation.conf</code> inside your <code>poky</code> directory'),
+                               ('Variables with description', 'description__regex:.+', queryset_with_search.filter(description__regex='.+').count(), 'We provide descriptions for the most common BitBake variables. The list of descriptions lives in <code>meta/conf/documentation.conf</code>'),
                                ]
                             },
                 },
@@ -1220,7 +1220,7 @@ def bpackage(request, build_id):
             },
             {
                 'name':'License',
-                'qhelp':'The license under which the package is distributed. Separate license names using | (pipe) means there is a choice between licenses. Separate license names using & (ampersand) means multiple licenses exist that cover different parts of the source',
+                'qhelp':'The license under which the package is distributed. Multiple license names separated by the pipe character indicates a choice between licenses. Multiple license names separated by the ampersand character indicates multiple licenses exist that cover different parts of the source',
                 'orderfield': _get_toggle_order(request, "license"),
                 'ordericon':_get_toggle_order_icon(request, "license"),
                 'clclass': 'license', 'hidden': 1,
@@ -1258,7 +1258,7 @@ def bpackage(request, build_id):
             },
             {
                 'name':'Layer directory',
-                'qhelp':'Location in disk of the layer providing the recipe that builds the package',
+                'qhelp':'Path to the layer providing the recipe that builds the package',
                 'orderfield': _get_toggle_order(request, "recipe__layer_version__layer__local_path"),
                 'ordericon':_get_toggle_order_icon(request, "recipe__layer_version__layer__local_path"),
                 'clclass': 'recipe__layer_version__layer__local_path', 'hidden': 1,
-- 
1.9.1


