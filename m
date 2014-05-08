Return-Path: <alexandru.damian@intel.com>
X-Greylist: delayed 358 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 08 May 2014 13:30:36 UTC
Received: from mail-wg0-f45.google.com (unknown [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id 3136165ED6
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 May 2014 13:30:36 +0000 (UTC)
Received: by mail-wg0-f45.google.com with SMTP id m15so2552834wgh.16
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 08 May 2014 06:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=kiooQgRdIrQoL/T0F9A4kDAfU+BaAgrlfKNznHTcHoE=;
	b=bcOxgEyVALYWJYnWVlofpXYSiH0a1K+fQZIBxDTtI7Z+CyKqcue8qwd1L9ItL5JgmI
	3GycRrdFmEUu+tDoqXxCgBR8K4mdtN1Vv6r1K5qv4mFMyU2aXXtAOGXAPeMthcji3qMu
	KOb92EeiEmbQoOQuT5HJPkWS/OZ6mgnXb6jovaWNwnRuGJGM/dpGVIPYWaTfp6fV4Mf4
	wmfZY9app+FRb6ST5lvEUXkSWlWXSNmYNiUkPh7kIamxHtTbcM1okz1o6Zj4KGDbQQEo
	UqPEUgaS1Ry1gxOu3eOVPkHoh+HhzqNr36YsYozo/uSZ5242OPzvr/XMBYaLlcDutdk8
	RJQg==
X-Gm-Message-State: ALoCoQloX2yoSBT9Z6DBrZYWNIsvuSOh87xkSE998UB0hb+hagijSzG0zYb68XYhBfcxPNl+shHG
X-Received: by 10.194.62.234 with SMTP id b10mr3267457wjs.48.1399555478458;
	Thu, 08 May 2014 06:24:38 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	ga10sm1322666wjb.23.2014.05.08.06.24.37 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 08 May 2014 06:24:37 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id EC8F45603A0; Thu,  8 May 2014 21:24:36 +0800 (HKT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  8 May 2014 14:24:31 +0100
Message-Id: <7fc64b40c28e09f8fe549d8d2972d5066bc1d125.1399555312.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1399555312.git.alexandru.damian@intel.com>
References: <cover.1399555312.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 1/5] toaster: sort outcome and sstate columns by string value
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
X-List-Received-Date: Thu, 08 May 2014 13:30:39 -0000

From: David Reyna <David.Reyna@windriver.com>

Sort the 'outcome' and 'sstate_result' columns by their
description string values and not their numerical values.

[YOCTO #5921]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/models.py       | 12 ++++++++++++
 lib/toaster/toastergui/views.py |  9 ++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index c344c66..22c66a9 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -166,9 +166,18 @@ class Task(models.Model):
     def get_related_setscene(self):
         return Task.objects.related_setscene(self)
 
+    def get_outcome_text(self):
+        return Task.TASK_OUTCOME[self.outcome + 1][1]
+
     def get_outcome_help(self):
         return Task.TASK_OUTCOME_HELP[self.outcome][1]
 
+    def get_sstate_text(self):
+        if self.sstate_result==Task.SSTATE_NA:
+            return ''
+        else:
+            return Task.SSTATE_RESULT[self.sstate_result][1]
+
     def get_executed_display(self):
         if self.task_executed:
             return "Executed"
@@ -200,6 +209,9 @@ class Task(models.Model):
     message = models.CharField(max_length=240)
     logfile = models.FilePathField(max_length=255, blank=True)
 
+    outcome_text = property(get_outcome_text)
+    sstate_text  = property(get_sstate_text)
+
     class Meta:
         ordering = ('order', 'recipe' ,)
         unique_together = ('build', 'recipe', 'task_name', )
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 53be967..3d2ed4c 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -853,7 +853,14 @@ def tasks_common(request, build_id, variant, task_anchor):
     (filter_string, search_term, ordering_string) = _search_tuple(request, Task)
     queryset_all = Task.objects.filter(build=build_id).exclude(order__isnull=True).exclude(outcome=Task.OUTCOME_NA)
     queryset_with_search = _get_queryset(Task, queryset_all, None , search_term, ordering_string, 'order')
-    queryset = _get_queryset(Task, queryset_all, filter_string, search_term, ordering_string, 'order')
+    if ordering_string.startswith('outcome'):
+        queryset = _get_queryset(Task, queryset_all, filter_string, search_term, 'order:+', 'order')
+        queryset = sorted(queryset, key=lambda ur: (ur.outcome_text), reverse=ordering_string.endswith('-'))
+    elif ordering_string.startswith('sstate_result'):
+        queryset = _get_queryset(Task, queryset_all, filter_string, search_term, 'order:+', 'order')
+        queryset = sorted(queryset, key=lambda ur: (ur.sstate_text), reverse=ordering_string.endswith('-'))
+    else:
+        queryset = _get_queryset(Task, queryset_all, filter_string, search_term, ordering_string, 'order')
 
 	# compute the anchor's page
     if anchor:
-- 
1.9.1


