Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
	[209.85.212.178])
	by mail.openembedded.org (Postfix) with ESMTP id C09236EEFA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 17:59:09 +0000 (UTC)
Received: by mail-wi0-f178.google.com with SMTP id n15so2954761wiw.17
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 10:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=MkUlin+5ewKe7J4e+XLbcDTKyvq+qsC+MlCZWxsrcOo=;
	b=nKlmfnQJALDvGPnFYpmU0cRFNlt2V2ASxbChH42UGVepxVJvWoA9ERNV+HCo7FwEba
	3RKM5lYvtuaxTfZSB0iHD78aKidm1TZXlyT8Yaxo5q7zJ7oPtCa0+6DGU2BC+fmygFrQ
	QOFXcbWZYEUFJytbaFM/zMIcwPMqcloYSXWKu27AInfxksH/BRiYS03cXxn2yaAmLmUN
	pgr3IjHQsx/JuOEo7m7JWWp85FJEig7jO6NxXsL22zGC98s4Oz41nk56/fhAJ4gKOAQx
	r9oy/SvncHVojYhTz4CSrkFvuu6sjWsVJ0OGYpapM/u2QmqusGo2AKAwMjHFWIs0iPUL
	HiYg==
X-Gm-Message-State: ALoCoQmDH53aL9U9BqqcWGgTpXRJT35JdKDXJrGYpBHlpBmLOVEjUVVUf78bJXMHRNXDXE3CBZau
X-Received: by 10.194.2.70 with SMTP id 6mr7706298wjs.25.1394819949854;
	Fri, 14 Mar 2014 10:59:09 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id ee5sm18715861wib.8.2014.03.14.10.59.05
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 14 Mar 2014 10:59:08 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 1FD6756120A; Fri, 14 Mar 2014 17:59:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Mar 2014 17:58:55 +0000
Message-Id: <9516827571b3cf9ceaa38e716360d1fc052d22f4.1394819783.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
References: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394819783.git.alexandru.damian@intel.com>
References: <cover.1394819783.git.alexandru.damian@intel.com>
Subject: [PATCH 14/19] bitbake:toaster: Not using task_color tag for execution heading
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
X-List-Received-Date: Fri, 14 Mar 2014 17:59:10 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The modifications to the task_color tag in commit
23a7c338d387ac2ba13a7a1114a4abc75228c960 broke the styling
of failed tasks in the tasks.html template. Undo the
changes to the task_color tag and use an if statement
instead to set the .muted class when the execution
heading says "Not executed".

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/task.html         | 9 +++++----
 lib/toaster/toastergui/templatetags/projecttags.py | 6 +++---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/toastergui/templates/task.html b/lib/toaster/toastergui/templates/task.html
index af994fd..7c5b743 100644
--- a/lib/toaster/toastergui/templates/task.html
+++ b/lib/toaster/toastergui/templates/task.html
@@ -131,15 +131,16 @@
 {% endif %}
 
 {# Execution section #}
-<h2 {{task|task_color}}>
     {% if task.task_executed %}
+	<h2>
         Executed
         <i class="icon-question-sign get-help heading-help" title="Executed tasks are those that need to run in order to generate the task output"></i>
-     {% else %}
+    {% else %}
+	<h2 class="muted">
         Not Executed
         <i class="icon-question-sign get-help heading-help" title="Not executed tasks don't need to run because their outcome is provided by another task"></i>
-     {% endif %}
-</h2>
+    {% endif %}
+	</h2>
 <dl class="dl-horizontal">
     <dt>
         <i class="icon-question-sign get-help" title="To make builds more efficient, the build system detects changes in the 'inputs' to a given task by creating a 'task signature'. If the signature changes, the build system assumes the inputs have changed and the task needs to be rerun"></i>
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index 2d339d6..857680b 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -70,16 +70,16 @@ def sortcols(tablecols):
     return sorted(tablecols, key = lambda t: t['name'])
 
 @register.filter
-def task_color(task_object, show_colour=False):
+def task_color(task_object, show_green=False):
     """ Return css class depending on Task execution status and execution outcome.
         By default, green is not returned for executed and successful tasks;
         show_green argument should be True to get green color.
     """
     if not task_object.task_executed:
         return 'class=muted'
-    elif task_object.outcome == task_object.OUTCOME_FAILED and show_colour:
+    elif task_object.outcome == task_object.OUTCOME_FAILED:
         return 'class=error'
-    elif task_object.outcome == task_object.OUTCOME_SUCCESS and show_colour:
+    elif task_object.outcome == task_object.OUTCOME_SUCCESS and show_green:
         return 'class=green'
     else:
         return ''
-- 
1.8.3.2


