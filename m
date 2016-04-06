Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id D27CD771C3
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:30 +0000 (UTC)
Received: by mail-wm0-f51.google.com with SMTP id l6so73377082wml.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=17os9mvTUTDzMvYTS1hMvXAMIe8nKmLz5OgVYu5koLg=;
	b=JX47ZEB9YcEPgmljT75rAVTaLa1gJ98Umu4eWgxtcY8cUnNfkLmKISYctDCtOdwcOq
	uJFQOV9yni5X/HfUc0WuGQGvrXzefZI3FH6m3KfDfieg9Za9PMO3oHhvQtR7rUT1M5ev
	sqaG86ORWmJm1u32aiCj+wEGHDBCmzlny39/kCzqS9hDF+reC0W0TTAxHObg/uHTk2ev
	0n4g0Qw510WV+wDTH4YRjWVAWVCxUq+BhxKvT2vpxF7ih3ES1Z9XH3s/nKuNDn4gF4xd
	5h42kJTRFFwNyLhbvHd9Eq8zDhNtlZ4m83IwrrKaKaEGOxr80aj2pZXxKdPt/qRKBq5t
	IrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=17os9mvTUTDzMvYTS1hMvXAMIe8nKmLz5OgVYu5koLg=;
	b=j7Auo0vF8GH1yxvxLQxKgrDMpzxz1uZ1EeTrjxqghf/iyixXijEsUwgY8na/nlK0cH
	3yjRN9EQ8uWVcbCmhUZYtzDn5V1LswDORJGrfk2iuH+a38npjX58WhDLJ/1qtuNmuf9G
	Mjt8/TIWqoqI1/+qN8ttmoahRT21AiLcn+PkcTwe6k8FsYqYQK9r0f1pz7WQ/BFECH6R
	id9RoS0efOoN0DVWBDUlq1i0ZlUshUEztFFUGNjZ6YvI1xBveIQYY2lF6NoMlsNw7gRo
	I1J1Dyx2IgqC0JjK1gfH5+IAvw60XWmE6458F1T/Cbe3QZ95EN5JsDGPGjt1I8vGUX/l
	3p4w==
X-Gm-Message-State: AD7BkJL1Xb2UBI2sCs7U5AEqq8hTUoDkpbojR3/gQi6syKBDEkiLncnnv+UamcnbbeEpKGiz
X-Received: by 10.28.132.212 with SMTP id g203mr25151719wmd.30.1459961250994; 
	Wed, 06 Apr 2016 09:47:30 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.30
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:30 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:35 +0100
Message-Id: <e2533ccd84bdb791f65b97c4bb9b84019909acd5.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 25/38] toaster: bldcontrol models Add a cancelling state the BuildRequest
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

To accurately reflect the state of a build request we also need a
cancelling state. This is set when we've started a build and then for
whatever reason cancel it, cancelling is not instantaneous so we have
this state to indicate that a cancel is in progress.

Also add a state transition guard. As the state of a BuildRequest can
currently be modified by three processes; Toastergui,
Runbuilds/bldcontrol and the buildinofhelper we cannot say for sure
which process will be running at the time of cancellation so in order to
avoid one of these processes making an incorrect transition only allow
transitions of state to increase.

e.g. CREATED -> QUEUED -> INPROGRESS
And to ignore such requested changes such as
INPROGRESS -> CREATED

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 .../migrations/0003_add_cancelling_state.py        | 19 +++++++++++++++
 lib/toaster/bldcontrol/models.py                   | 27 +++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 bitbake/lib/toaster/bldcontrol/migrations/0003_add_cancelling_state.py

diff --git a/lib/toaster/bldcontrol/migrations/0003_add_cancelling_state.py b/lib/toaster/bldcontrol/migrations/0003_add_cancelling_state.py
new file mode 100644
index 0000000..eec9216
--- /dev/null
+++ b/lib/toaster/bldcontrol/migrations/0003_add_cancelling_state.py
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
+        ('bldcontrol', '0002_auto_20160120_1250'),
+    ]
+
+    operations = [
+        migrations.AlterField(
+            model_name='buildrequest',
+            name='state',
+            field=models.IntegerField(default=0, choices=[(0, b'created'), (1, b'queued'), (2, b'in progress'), (3, b'completed'), (4, b'failed'), (5, b'deleted'), (6, b'cancelling'), (7, b'archive')]),
+        ),
+    ]
diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index 9b2d0d0..cb49a58 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -4,6 +4,8 @@ from django.core.validators import MaxValueValidator, MinValueValidator
 from django.utils.encoding import force_bytes
 from orm.models import Project, ProjectLayer, ProjectVariable, ProjectTarget, Build, Layer_Version
 
+import logging
+logger = logging.getLogger("toaster")
 # a BuildEnvironment is the equivalent of the "build/" directory on the localhost
 class BuildEnvironment(models.Model):
     SERVER_STOPPED = 0
@@ -64,7 +66,8 @@ class BuildRequest(models.Model):
     REQ_COMPLETED = 3
     REQ_FAILED = 4
     REQ_DELETED = 5
-    REQ_ARCHIVE = 6
+    REQ_CANCELLING = 6
+    REQ_ARCHIVE = 7
 
     REQUEST_STATE = (
         (REQ_CREATED, "created"),
@@ -73,6 +76,7 @@ class BuildRequest(models.Model):
         (REQ_COMPLETED, "completed"),
         (REQ_FAILED, "failed"),
         (REQ_DELETED, "deleted"),
+        (REQ_CANCELLING, "cancelling"),
         (REQ_ARCHIVE, "archive"),
     )
 
@@ -85,6 +89,27 @@ class BuildRequest(models.Model):
     created     = models.DateTimeField(auto_now_add = True)
     updated     = models.DateTimeField(auto_now = True)
 
+    def __init__(self, *args, **kwargs):
+        super(BuildRequest, self).__init__(*args, **kwargs)
+        # Save the old state incase it's about to be modified
+        self.old_state = self.state
+
+    def save(self, *args, **kwargs):
+        # Check that the state we're trying to set is not going backwards
+        # e.g. from REQ_FAILED to REQ_INPROGRESS
+        if self.old_state != self.state and self.old_state > self.state:
+            logger.warn("Invalid state change requested: "
+                        "Cannot go from %s to %s - ignoring request" %
+                        (BuildRequest.REQUEST_STATE[self.old_state][1],
+                         BuildRequest.REQUEST_STATE[self.state][1])
+                       )
+            # Set property back to the old value
+            self.state = self.old_state
+            return
+
+        super(BuildRequest, self).save(*args, **kwargs)
+
+
     def get_duration(self):
         return (self.updated - self.created).total_seconds()
 
-- 
2.1.4


