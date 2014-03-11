Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
	[209.85.212.171])
	by mail.openembedded.org (Postfix) with ESMTP id ACB786F7B2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Mar 2014 15:49:55 +0000 (UTC)
Received: by mail-wi0-f171.google.com with SMTP id hn9so1100658wib.4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Mar 2014 08:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=biX751CtHui3hLlepvmQq7BcGeMQMlMECxmsF6uQ//k=;
	b=gLBOxY9gxrk7oiEngjNpht7UAf7asTvIiMP7o+wyVUf45ayc1Ex+bN15ksPa1sRTWM
	2sSgBF062S8A4VlyRQ9qViUwSUA6HJ8M398QsJMbeGjtGNa/xbqwKtXyD3AhGuQKxQ/k
	pdzQxxmE6p24PjuuadfpwxCx71XYujbNr/DuHX1jk93cIX+prmPloqfJg+dFpSqIe9GL
	YrpATqf1Sy0CY5t5VmIpoZCAip6Ih3fms0XdExizzrb2yjV+vWbft7CrrhSV0wsRvotW
	dWqmWZmKwuGfTjUxAp+gXWws+XpCys6y9HF5rs2FeiXCzHU0CXuXukhtLQSlkk6vPQIs
	UWgA==
X-Gm-Message-State: ALoCoQmY0nnNDNoRHnGpqeqgi2HDZdcc24EqJKF+MBRoSixpuJQHACzpU7xhdBG7f3XKNqcJwul1
X-Received: by 10.194.60.16 with SMTP id d16mr8187310wjr.46.1394552995566;
	Tue, 11 Mar 2014 08:49:55 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id ux5sm62436691wjc.6.2014.03.11.08.49.53
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 11 Mar 2014 08:49:53 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 37BD05605D1; Tue, 11 Mar 2014 15:49:54 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Mar 2014 15:49:49 +0000
Message-Id: <f3001af0b73f103a5d37af180e8c4c54a6249e97.1394552757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <f8488845ee9670e16a63c331dd2e97fdb314929c.1394552757.git.alexandru.damian@intel.com>
References: <f8488845ee9670e16a63c331dd2e97fdb314929c.1394552757.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394552757.git.alexandru.damian@intel.com>
References: <cover.1394552757.git.alexandru.damian@intel.com>
Subject: [PATCH 5/8] toaster: Fix help text for task details outcome
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
X-List-Received-Date: Tue, 11 Mar 2014 15:49:58 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Changes made to models.py and task.html to make sure the
help text for the task outcome is displayed.

[YOCTO #5917]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/orm/models.py                  | 20 ++++++++++----------
 lib/toaster/toastergui/templates/task.html |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 6706da8..0646813 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -140,14 +140,14 @@ class Task(models.Model):
         (OUTCOME_EMPTY, 'Empty'),
     )
 
-    TASK_OUTCOME_HELP = {
-        OUTCOME_SUCCESS:'This task completed successfully',
-        OUTCOME_COVERED:'This task did not run because its output is provided by another task',
-        OUTCOME_CACHED:'This task restored output from the sstate-cache directory or mirrors',
-        OUTCOME_PREBUILT:'This task did not run because its outcome was reused from a previous build',
-        OUTCOME_FAILED:'This task did not complete',
-        OUTCOME_NA:''
-    }
+    TASK_OUTCOME_HELP = (
+        (OUTCOME_SUCCESS, 'This task completed successfully'),
+        (OUTCOME_COVERED, 'This task did not run because its output is provided by another task'),
+        (OUTCOME_CACHED, 'This task restored output from the sstate-cache directory or mirrors'),
+        (OUTCOME_PREBUILT, 'This task did not run because its outcome was reused from a previous build'),
+        (OUTCOME_FAILED, 'This task did not complete'),
+        (OUTCOME_NA, ''),
+    )
 
     search_allowed_fields = [ "recipe__name", "recipe__version", "task_name", "logfile" ]
 
@@ -156,8 +156,8 @@ class Task(models.Model):
     def get_related_setscene(self):
         return Task.objects.related_setscene(self)
 
-    def outcome_help(self):
-        return Task.TASK_OUTCOME_HELP[self.outcome]
+    def get_outcome_help(self):
+        return Task.TASK_OUTCOME_HELP[self.outcome][1]
 
     def get_executed_display(self):
         if self.task_executed:
diff --git a/lib/toaster/toastergui/templates/task.html b/lib/toaster/toastergui/templates/task.html
index c5d6176..a8bcb52 100644
--- a/lib/toaster/toastergui/templates/task.html
+++ b/lib/toaster/toastergui/templates/task.html
@@ -18,7 +18,7 @@
 {# Outcome section #}
 <h2 {{ task|task_color:True }}>
     {{task.get_outcome_display}}
-    <i class="icon-question-sign get-help heading-help" title="" data-original-title="{{task.outcome_help}}"></i>
+    <i class="icon-question-sign get-help heading-help" title="{{task.get_outcome_help}}"></i>
 </h2>
 {%if task.task_executed %}
     {# executed tasks outcome #}
-- 
1.8.3.2


