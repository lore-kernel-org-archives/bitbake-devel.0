Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
	by mail.openembedded.org (Postfix) with ESMTP id 622356FAF9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 18:02:37 +0000 (UTC)
Received: by mail-wg0-f48.google.com with SMTP id l18so559237wgh.31
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 11:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=8JcGUHWmsBSAyOSvn4rlvGGPDqhB9nYsBwesgce6XAg=;
	b=hNuOdvB7DeEiHDnRwsIihjuwdDIO1mAT47Xis2Jt6bHEDmmFVzgf1jR/p4C4BzMllq
	W5rVVbi94Lbw8snRS9xKlrWs0HlQMaQ3vovklS7TDGvIfUpj6+m8BpEqYJFncLlO74o4
	I9SapyzT//cZ0gaEDOqcjE1EA2rtQOrMttw+VefQEa3PpsGZfLPibJkl43on0mP3Ck5z
	LvfsG/ZX4V4ZwUuOoRvDW7cSTaR0wPf/KNJfYZ+fBAt8HYtJXKCdxw9desFvnarOlpgt
	8aZLkCKuMOrhc8OHtTetZlN9qzObZS9IE+4Pc9HsYDT6y/+RDhiF16++wQ1/ThblmQCL
	ixzw==
X-Gm-Message-State: ALoCoQkcxySq26sdSyLIHQIKJua9frWby9LdXmFG6mBvtHXNM+vVuD9nG97tNKHLyEApJayMOmbb
X-Received: by 10.180.101.166 with SMTP id fh6mr23607777wib.2.1395770558736;
	Tue, 25 Mar 2014 11:02:38 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id eq8sm178387wib.16.2014.03.25.11.02.35
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 25 Mar 2014 11:02:37 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 95D36560DFA; Tue, 25 Mar 2014 17:51:14 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Mar 2014 17:51:12 +0000
Message-Id: <1a82eddb23575fe9c50fd3f23b8ee4799117739e.1395769683.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <7cdff1413429eb64bae7522e587b42f850aa0fe0.1395769683.git.alexandru.damian@intel.com>
References: <7cdff1413429eb64bae7522e587b42f850aa0fe0.1395769683.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395769683.git.alexandru.damian@intel.com>
References: <cover.1395769683.git.alexandru.damian@intel.com>
Subject: [PATCH 4/5] toaster: Small fixes in tasks UI
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
X-List-Received-Date: Tue, 25 Mar 2014 18:02:40 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

This commit:

* Fixes an issue with white space when showing the log
in Cached tasks (task details page)

* Formats the no results alert of the "Prebuilt task
could be based on" search in the task details page

* Brings in the task outcome help text to "Prebuilt
task could be based on" table in the task details page,
to the tasks table in the recipe details page, and to
the all tasks page

* Adds the task_color tag to the "Prebuilt task could
be based on" table in the task details page, so that
each task gets the required visual treatment based on
execution

* Makes sure performance information for not executed
tasks shows in the task details page when it exists
(empty tasks often report a short time, for example)

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/recipe.html |  6 ++++--
 lib/toaster/toastergui/templates/task.html   | 18 ++++++++----------
 lib/toaster/toastergui/templates/tasks.html  |  3 ++-
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/lib/toaster/toastergui/templates/recipe.html b/lib/toaster/toastergui/templates/recipe.html
index 716ddfa..e367077 100644
--- a/lib/toaster/toastergui/templates/recipe.html
+++ b/lib/toaster/toastergui/templates/recipe.html
@@ -117,11 +117,13 @@
 
                     <td><a {{ task|task_color }} href="{% url "task" build.pk task.pk %}">{{task.get_executed_display}}</a></td>
 
-                    <td><a {{ task|task_color }} href="{% url "task" build.pk task.pk %}">{{task.get_outcome_display}}</a></td>
+                    <td>
+                        <a {{ task|task_color }} href="{% url "task" build.pk task.pk %}">{{task.get_outcome_display}} </a>
+                        <i class="icon-question-sign get-help hover-help" title="{{task.get_outcome_help}}"></i>
+                    </td>
                     <td>
                         {% ifnotequal task.sstate_result task.SSTATE_NA %}
                         <a {{ task|task_color }} href="{% url "task" build.pk task.pk %}">{{task.get_sstate_result_display}}</a>
-                        <i class="icon-question-sign get-help hover-help" title="This task did not run because its outcome was reused from a previous build"></i>
                         {% endifnotequal %}
                     </td>
 
diff --git a/lib/toaster/toastergui/templates/task.html b/lib/toaster/toastergui/templates/task.html
index 7c5b743..1a7e9d4 100644
--- a/lib/toaster/toastergui/templates/task.html
+++ b/lib/toaster/toastergui/templates/task.html
@@ -76,7 +76,7 @@
                 </thead>
                 <tbody>
                     {% for match in matching_tasks %}
-                        <tr>
+                        <tr {{ match|task_color }}>
                             <td>
                                 <a href="{%url "task" match.build.pk match.pk%}">{{match.recipe.name}}</a>
                             </td>
@@ -87,7 +87,7 @@
                                 <a href="{%url "task" match.build.pk match.pk%}">{{match.get_executed_display}}</a>
                             </td>
                             <td>
-                                <a href="{%url "task" match.build.pk match.pk%}">{{match.get_outcome_display}}</a><i class="icon-question-sign get-help hover-help" title="{{match.outcome_help}}"></i>
+                                <a href="{%url "task" match.build.pk match.pk%}">{{match.get_outcome_display}} </a><i class="icon-question-sign get-help hover-help" title="{{match.get_outcome_help}}"></i>
                             </td>
                             <td>
                                 <a href="{%url "task" match.build.pk match.pk%}">{{match.build.completed_on|date:"d/m/y H:i"}}</a>
@@ -98,8 +98,8 @@
             </table>
         {% else %}
             <p class="alert">
-                We have found no tasks matching this prebuilt task.<br/>
-                The task you are looking for could belong to a build for which Toaster has not data.
+                <strong> We have found no tasks matching this prebuilt task</strong><br/>
+                The task you are looking for could belong to a build for which Toaster has no data.
             </p>
         {% endif %}
     {% elif task.outcome == task.OUTCOME_COVERED %}
@@ -119,8 +119,7 @@
                 <i class="icon-question-sign get-help" title="The location in disk of the task log file"></i> Log file
             </dt>
             <dd>
-                <code>{% for t in task.get_related_setscene %} {{t.logfile}}<br/>{% endfor %}
-		</code>
+                <code>{% for t in task.get_related_setscene %} {{t.logfile}} {% endfor %}</code>
             </dd>
         </dl>
     {%elif task.outcome == task.OUTCOME_EMPTY%}
@@ -243,10 +242,11 @@
 </dl>
 
 {# Performance section - shown only for executed tasks #}
-{%if task.task_executed %}
+{%if task.elapsed_time or task.cpu_usage or task.disk_io %}
     <h2 class="details">Performance</h2>
+{% endif %}
     <dl class="dl-horizontal">
-		{% if task.elapsed_time > 0.01 %}
+		{% if task.elapsed_time %}
         <dt>
             <i class="icon-question-sign get-help" title="How long it took the task to finish, expressed in seconds"></i>
             Time (secs)
@@ -268,8 +268,6 @@
         <dd>{{task.disk_io|format_none_and_zero}}</dd>
 		{% endif %}
     </dl>
-{%endif%}
-
 
 </div>
 {% endblock %}
diff --git a/lib/toaster/toastergui/templates/tasks.html b/lib/toaster/toastergui/templates/tasks.html
index a2629dc..ace30de 100644
--- a/lib/toaster/toastergui/templates/tasks.html
+++ b/lib/toaster/toastergui/templates/tasks.html
@@ -51,7 +51,8 @@
                 <a href="{%url "task" build.pk task.pk%} ">{{task.get_executed_display}}</a>
             </td>
             <td class="outcome">
-                <a href="{%url "task" build.pk task.pk%} ">{{task.get_outcome_display}}</a>
+                <a href="{%url "task" build.pk task.pk%} ">{{task.get_outcome_display}} </a>
+                <i class="icon-question-sign get-help hover-help" title="{{task.get_outcome_help}}"></i>
             </td>
             <td class="cache_attempt">
                 <a href="{%url "task" build.pk task.pk%} ">{{task.get_sstate_result_display|format_none_and_zero}}</a>
-- 
1.8.3.2


