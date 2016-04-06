Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
	by mail.openembedded.org (Postfix) with ESMTP id C4D3C771B4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:29 +0000 (UTC)
Received: by mail-wm0-f50.google.com with SMTP id f198so81805857wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=9nvubs4GrlTjBS+zTb2ZtxNMUw6tyX6WNyPhrB5kfyU=;
	b=o4IjgpskLfq4PXcvTVw2JRlk2wmKZpSqvqUupll1Ewb0eillxVhAhhN+mx9onIVr93
	l2B+plA5lYvcOM8/JgBgDfx4Y6OEGqlwnpxcQaFamw2KXB3aTUy9WHe/v4XA1h6DdJir
	Jispat8aK6/RHTC6/zsjeGcG6fpYuzqa6sVIRkhh5ELvqSOaSKMPJBhiVUNxQS4d3l9g
	T0UY1UfUSYqVFN1HrsTqjpw5fg56JvfghlNVc2ex5AicAp6IkgMHookdG+SURYIEEec4
	vFrKWjaLSzApog0AUV9MJkyKwQiljAihKmrRPGS+jWfxKFW5EbW0khwdHyn7jdn075+Q
	9fxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=9nvubs4GrlTjBS+zTb2ZtxNMUw6tyX6WNyPhrB5kfyU=;
	b=bnPIDHSw0/9UCpJzxHVp5WiVldrwpI4cq9hVF+Ccandteo7HsRGmXpKoapGQ+YRXJY
	u/xrQqtFLfTegNAgbJzXlYy28Q6GZl3uP3O3izr3sAH6fidfojH2zrRTucWUQt3glEmW
	YPVoSb6oNMXN46pbEk86Eri5OV1V2LzFVxlwH3t9mF+gvntoOvHAXzsZDVFG8wHRVs4l
	AUmywFSewgdedSuFA59EoQEOqRnhQHwt0+lXX/7iB/fVOvG7aeDUfWtfiG2bFb9H4gu7
	aehhiFpdF9sRuiuxQnQnIV9uRPcQglt6+QyG6mwPrdgFNxWvJ7/IoTyskeXRs4qjPim9
	KHZQ==
X-Gm-Message-State: AD7BkJKn0lDwZxgXa3KYVZTD33Q+26YMpRy0ILcskplPsuaruBKmalsR5aJavE32sVgzJi8k
X-Received: by 10.28.73.66 with SMTP id w63mr25845569wma.53.1459961250068;
	Wed, 06 Apr 2016 09:47:30 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.29
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:29 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:34 +0100
Message-Id: <add8cd475ffe4a33c50b8b2d1e85e52eb815beb4.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 24/38] toaster: models Add cancelled state to build outcome
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:31 -0000

From: Sujith H <sujith.h@gmail.com>

A new state CANCELLED is introduced to, distinguish
the state of build.

[YOCTO #6787]

Signed-off-by: Sujith H <sujith.h@gmail.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 .../orm/migrations/0006_add_cancelled_state.py        | 19 +++++++++++++++++++
 lib/toaster/orm/models.py                             |  7 ++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 bitbake/lib/toaster/orm/migrations/0006_add_cancelled_state.py

diff --git a/lib/toaster/orm/migrations/0006_add_cancelled_state.py b/lib/toaster/orm/migrations/0006_add_cancelled_state.py
new file mode 100644
index 0000000..91a32a9
--- /dev/null
+++ b/lib/toaster/orm/migrations/0006_add_cancelled_state.py
@@ -0,0 +1,19 @@
+# -*- coding: utf-8 -*-
+from __future__ import unicode_literals
+
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('orm', '0005_task_field_separation'),
+    ]
+
+    operations = [
+        migrations.AlterField(
+            model_name='build',
+            name='outcome',
+            field=models.IntegerField(default=2, choices=[(0, b'Succeeded'), (1, b'Failed'), (2, b'In Progress'), (3, b'Cancelled')]),
+        ),
+    ]
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index e67b0d6..dfa69a3 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -358,11 +358,13 @@ class Build(models.Model):
     SUCCEEDED = 0
     FAILED = 1
     IN_PROGRESS = 2
+    CANCELLED = 3
 
     BUILD_OUTCOME = (
         (SUCCEEDED, 'Succeeded'),
         (FAILED, 'Failed'),
         (IN_PROGRESS, 'In Progress'),
+        (CANCELLED, 'Cancelled'),
     )
 
     search_allowed_fields = ['machine', 'cooker_log_path', "target__target", "target__target_image_file__file_name"]
@@ -390,7 +392,10 @@ class Build(models.Model):
         if project:
             builds = builds.filter(project=project)
 
-        finished_criteria = Q(outcome=Build.SUCCEEDED) | Q(outcome=Build.FAILED)
+        finished_criteria = \
+                Q(outcome=Build.SUCCEEDED) | \
+                Q(outcome=Build.FAILED) | \
+                Q(outcome=Build.CANCELLED)
 
         recent_builds = list(itertools.chain(
             builds.filter(outcome=Build.IN_PROGRESS).order_by("-started_on"),
-- 
2.1.4


