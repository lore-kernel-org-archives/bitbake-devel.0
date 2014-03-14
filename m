Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175])
	by mail.openembedded.org (Postfix) with ESMTP id A20FB6F860
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 17:59:08 +0000 (UTC)
Received: by mail-wi0-f175.google.com with SMTP id cc10so5742220wib.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 10:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=At941p1ZArGrIm8D+HIwY+eHxV3vNRnYdIwlz1lyadY=;
	b=AJnWEOQ420bceIVJZyyGpIrK8uzyJojQ6amuqU67k8fUDK0Kld/cR5p/3vTF3AaKvI
	j9uMkVSs8+8Zzk7ndfWOU4M0vAmbu2OkD076GEaiiHJpACwkk455FgHKWoSmA1pV2iQY
	G6OF0HgfsTO8d08J2Yw9IV/t49SeQDAqCDMjHS1bgFak4NBc3ocZGONiYoNa/39AmF3N
	4jyMU5YprfP6jhus8A6t+MJ/hIyQcnkpgsT57zpv5MRrvwTfmquj5rh6pErJKlOXBEOn
	Vvt0ROizO7Dc4NvGOJ24ZYGX3aVLLIqYGaAyPEDCMB0nKJCvtsMJMMjCH83eD82EWdmz
	UZiQ==
X-Gm-Message-State: ALoCoQnMnabe44fzKmanu76X3MGK9NfEu7ak2BOVwsvvp9eyjUGCrYavivHs/oBCFBPx/SUtBFje
X-Received: by 10.181.13.40 with SMTP id ev8mr3670832wid.0.1394819948941;
	Fri, 14 Mar 2014 10:59:08 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id t5sm15550335wjw.15.2014.03.14.10.59.04
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 14 Mar 2014 10:59:07 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 1DEEC561201; Fri, 14 Mar 2014 17:59:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Mar 2014 17:58:54 +0000
Message-Id: <bbc22958ab37dcd44c03420a7b8f842a1f4e51b1.1394819783.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
References: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394819783.git.alexandru.damian@intel.com>
References: <cover.1394819783.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 13/19] toaster: Presentation fixes for task.html
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
X-List-Received-Date: Fri, 14 Mar 2014 17:59:09 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Tidying up the presentation in the task.html template.
The changes include:

* Correct the markup for the help tooltips
* Fix the help content for the outcome heading
* Make sure <dt> tags do not show for empty log
file, time, cpu and disk I/O values
* Eliminate an extra <dl> for tasks with sstate attempts
* Add <strong> tag to the sstate restored alert
* Replace the .alert-info class with the .muted class
for the no dependencies messages
* Make sure the Executed heading does not inherit
the .red class for failed tasks
* Format time and cpu values to make sure they only
show 2 decimal digits

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/css/default.css      |  2 +-
 lib/toaster/toastergui/templates/task.html         | 36 +++++++++++++---------
 lib/toaster/toastergui/templatetags/projecttags.py |  6 ++--
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 2b47aff..7db156a 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -30,7 +30,7 @@ dd code, .alert code { white-space: pre-wrap; word-break: break-all; word-wrap:
 .tooltip code { background-color: transparent; color: #FFFFFF; font-weight: normal; border: none; font-size: 1em; }
 
 /* Style for definition lists */
-dd ul { list-style-type: none; margin-left: 0px; }
+dd ul { list-style-type: none; margin: 0px; }
 dt, dd  {line-height: 25px; }
 dd li { line-height: 25px; }
 dd p { line-height: 20px; }
diff --git a/lib/toaster/toastergui/templates/task.html b/lib/toaster/toastergui/templates/task.html
index 403bb03..af994fd 100644
--- a/lib/toaster/toastergui/templates/task.html
+++ b/lib/toaster/toastergui/templates/task.html
@@ -23,12 +23,14 @@
 {%if task.task_executed %}
     {# executed tasks outcome #}
     <dl class="dl-horizontal">
+	{% if task.logfile %}
         <dt>
-            <i class="icon-question-sign get-help" title="" data-original-title="The location in disk of the task log file"></i> Log file
+            <i class="icon-question-sign get-help" title="The location in disk of the task log file"></i> Log file
         </dt>
         <dd>
             <code>{{task.logfile}}</code>
         </dd>
+	{% endif %}
         {# show stack trace for failed task #}
         {% if task.outcome == task.OUTCOME_FAILED and log_head %}
             <h3>Python stack trace</h3>
@@ -47,7 +49,7 @@
             <a class="btn" href="javascript:reload_params({'show_matches' : 'true' })">Match to tasks in previous builds <i class="icon-question-sign get-help" style="margin-top:20px;" data-toggle="tooltip" title="This will show you a list of tasks from previous builds with the same inputs signature as this prebuilt task. Any of them could be the task that generated the output this prebuilt task is reusing"></i></a>
         {% elif matching_tasks %}
             <h3 class="details">Prebuilt task could be based on
-                <i class="icon-question-sign get-help heading-help" title="" data-toggle="tooltip" data-original-title="This table shows a list of tasks from previous builds with the same inputs signature as the prebuilt task. Any of them could be the task that generated the output the prebuilt task is reusing"></i>
+                <i class="icon-question-sign get-help heading-help" title="This table shows a list of tasks from previous builds with the same inputs signature as the prebuilt task. Any of them could be the task that generated the output the prebuilt task is reusing"></i>
             </h3>
             <table class="table table-bordered table-hover">
                 <thead>
@@ -85,7 +87,7 @@
                                 <a href="{%url "task" match.build.pk match.pk%}">{{match.get_executed_display}}</a>
                             </td>
                             <td>
-                                <a href="{%url "task" match.build.pk match.pk%}">{{match.get_outcome_display}}</a><i class="icon-question-sign get-help hover-help" title="" style="visibility: hidden;" data-original-title="{{match.outcome_help}}"></i>
+                                <a href="{%url "task" match.build.pk match.pk%}">{{match.get_outcome_display}}</a><i class="icon-question-sign get-help hover-help" title="{{match.outcome_help}}"></i>
                             </td>
                             <td>
                                 <a href="{%url "task" match.build.pk match.pk%}">{{match.build.completed_on|date:"d/m/y H:i"}}</a>
@@ -103,7 +105,7 @@
     {% elif task.outcome == task.OUTCOME_COVERED %}
         <dl class="dl-horizontal">
             <dt>
-                <i class="icon-question-sign get-help" title="" data-toggle="tooltip" data-original-title="The task providing the outcome of this task"></i>Task covered by
+                <i class="icon-question-sign get-help" title="The task providing the outcome of this task"></i> Task covered by
             </dt>
             <dd>
                 <ul>
@@ -114,7 +116,7 @@
     {%elif task.outcome == task.OUTCOME_CACHED%}
         <dl class="dl-horizontal">
             <dt>
-                <i class="icon-question-sign get-help" title="" data-original-title="The location in disk of the task log file"></i> Log file
+                <i class="icon-question-sign get-help" title="The location in disk of the task log file"></i> Log file
             </dt>
             <dd>
                 <code>{% for t in task.get_related_setscene %} {{t.logfile}}<br/>{% endfor %}
@@ -132,10 +134,10 @@
 <h2 {{task|task_color}}>
     {% if task.task_executed %}
         Executed
-        <i class="icon-question-sign get-help heading-help" title="" data-original-title="Executed tasks are those that need to run in order to generate the task output"></i>
+        <i class="icon-question-sign get-help heading-help" title="Executed tasks are those that need to run in order to generate the task output"></i>
      {% else %}
         Not Executed
-        <i class="icon-question-sign get-help heading-help" title="" data-original-title="Not executed tasks don't need to run because their outcome is provided by another task"></i>
+        <i class="icon-question-sign get-help heading-help" title="Not executed tasks don't need to run because their outcome is provided by another task"></i>
      {% endif %}
 </h2>
 <dl class="dl-horizontal">
@@ -146,12 +148,12 @@
     <dd>
         {{task.sstate_checksum}}
     </dd>
-</dl>
     {% if task.sstate_result != task.SSTATE_NA %}
+		</dl>
         <div class="alert alert-info">Attempting to restore output from sstate cache
             <i class="icon-question-sign get-help get-help-blue" title="The build system is searching for the task output in your <code>sstate-cache</code> directory and mirrors. If it finds it, it will use it instead of building it from scratch by running the real task. This makes the build faster"></i>
         </div>
-        <dl class="dl-horizontal">
+		<dl class="dl-horizontal">
             <dt>
                 <i class="icon-question-sign get-help" title="The name of the file searched for in your <code>sstate-cache</code> directory and mirrors"></i>
                 File searched for
@@ -189,7 +191,7 @@
         </div>
     {% elif task.sstate_result == task.SSTATE_RESTORED %}
         <div class="alert alert-info">
-            Output successfully restored from sstate cache.
+            Output <strong>successfully restored</strong> from sstate cache.
         </div>
     {% endif %}
     <dl class="dl-horizontal">
@@ -221,7 +223,7 @@
             {% for dep in deps %}
                 <li><a href="{%url 'task' dep.build.pk dep.pk%}" class="task-info" title="{{dep.get_executed_display}} | {{dep.get_outcome_display}}">{{dep.recipe.name}}_{{dep.recipe.version}} <span class="task-name">{{dep.task_name}}</span></a></li>
             {% empty %}
-                <li><p class="alert-info">This task has no dependencies</p></li>
+                <li class="muted">This task has no dependencies</li>
             {% endfor %}
         </ul>
     </dd>
@@ -234,7 +236,7 @@
             {% for dep in rdeps %}
                 <li><a href="{%url 'task' dep.build.pk dep.pk%}" class="task-info" title="{{dep.get_executed_display}} | {{dep.get_outcome_display}}">{{dep.recipe.name}}_{{dep.recipe.version}} <span class="task-name">{{dep.task_name}}</span></a></li>
             {% empty %}
-                <li><p class="alert-info">This task has no reverse dependencies</p></li>
+                <li class="muted">This task has no reverse dependencies</li>
             {% endfor %}
         </ul>
 </dl>
@@ -243,21 +245,27 @@
 {%if task.task_executed %}
     <h2 class="details">Performance</h2>
     <dl class="dl-horizontal">
+		{% if task.elapsed_time > 0.01 %}
         <dt>
             <i class="icon-question-sign get-help" title="How long it took the task to finish, expressed in seconds"></i>
             Time (secs)
         </dt>
-        <dd>{{task.elapsed_time|format_none_and_zero}}</dd>
+        <dd>{{task.elapsed_time|format_none_and_zero|floatformat:2}}</dd>
+		{% endif %}	
+		{% if task.cpu_usage > 0 %}	
         <dt>
             <i class="icon-question-sign get-help" title="Task CPU utilisation, expressed as a percentage"></i>
             CPU usage
         </dt>
-        <dd>{{task.cpu_usage|format_none_and_zero}}</dd>
+        <dd>{{task.cpu_usage|format_none_and_zero|floatformat:2}}%</dd>
+		{% endif %}
+		{% if task.disk_io > 0 %}
         <dt>
             <i class="icon-question-sign get-help" title="Number of miliseconds the task spent doing disk input and output"></i>
             Disk I/O (ms)
         </dt>
         <dd>{{task.disk_io|format_none_and_zero}}</dd>
+		{% endif %}
     </dl>
 {%endif%}
 
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index 857680b..2d339d6 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -70,16 +70,16 @@ def sortcols(tablecols):
     return sorted(tablecols, key = lambda t: t['name'])
 
 @register.filter
-def task_color(task_object, show_green=False):
+def task_color(task_object, show_colour=False):
     """ Return css class depending on Task execution status and execution outcome.
         By default, green is not returned for executed and successful tasks;
         show_green argument should be True to get green color.
     """
     if not task_object.task_executed:
         return 'class=muted'
-    elif task_object.outcome == task_object.OUTCOME_FAILED:
+    elif task_object.outcome == task_object.OUTCOME_FAILED and show_colour:
         return 'class=error'
-    elif task_object.outcome == task_object.OUTCOME_SUCCESS and show_green:
+    elif task_object.outcome == task_object.OUTCOME_SUCCESS and show_colour:
         return 'class=green'
     else:
         return ''
-- 
1.8.3.2


