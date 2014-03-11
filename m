Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182])
	by mail.openembedded.org (Postfix) with ESMTP id C520B6F887
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Mar 2014 15:49:55 +0000 (UTC)
Received: by mail-wi0-f182.google.com with SMTP id d1so1096692wiv.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Mar 2014 08:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=httv1L540rYYjPcw1jAMONoh0sEuW5IhL/6DQLMeyHs=;
	b=fhxSGmbmoj+/vQ7lITw4s9z4gAoIia2oEm/ObGo9ULeh4zc+OBJESBJGBj1Yx+3G6H
	OHjZvx4kkL501b4xRzVA7J9klmAHKZN9MBJ/3AoXiueOwevuskBplZGIGu1dlzeeuJeQ
	gB4XXO5cs35Zg0e3cuTBV8XcYOKfn1TOVXCvJ7w6kcxgjTCIz7s4ZhG3qpitJxLPq9/Z
	Z7j9wmTXhHChC5hDolb1h2j7HceEahuXydqm6a1hPnSfo25Qu1wS60sQJkmN0mR1SLzg
	hs40GylxYrrRizdQ+gJEi7jOqDQMgW5NqcnEtkOi3EpkdzBh0xKTSTDtj/1rXkGphQ+h
	jKXQ==
X-Gm-Message-State: ALoCoQl/9mVePFPVHpYJlEkzhMLaGLJxU4WNFeWBNwr9m+Vf4soKy/4BzyQTts8Ol1j8/FeGPUlv
X-Received: by 10.180.164.229 with SMTP id yt5mr3749354wib.49.1394552996016;
	Tue, 11 Mar 2014 08:49:56 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id ga20sm4257243wic.0.2014.03.11.08.49.53
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 11 Mar 2014 08:49:53 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 336F05605C8; Tue, 11 Mar 2014 15:49:54 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Mar 2014 15:49:47 +0000
Message-Id: <e9a8c32512bb270cda3dee4a3ed5fd22204c24bc.1394552757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <f8488845ee9670e16a63c331dd2e97fdb314929c.1394552757.git.alexandru.damian@intel.com>
References: <f8488845ee9670e16a63c331dd2e97fdb314929c.1394552757.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394552757.git.alexandru.damian@intel.com>
References: <cover.1394552757.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 3/8] toaster: add commands to list and delete builds
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

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add Django commands for the manage.py to manage the database
content.

The two commands added are:
* buildslist - produces a list of current builds
* builddelete - deletes a build and all associated data from the database

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastermain/management/__init__.py     |  0
 .../toastermain/management/commands/__init__.py    |  0
 .../toastermain/management/commands/builddelete.py | 33 ++++++++++++++++++++++
 .../toastermain/management/commands/buildslist.py  | 13 +++++++++
 4 files changed, 46 insertions(+)
 create mode 100644 lib/toaster/toastermain/management/__init__.py
 create mode 100644 lib/toaster/toastermain/management/commands/__init__.py
 create mode 100644 lib/toaster/toastermain/management/commands/builddelete.py
 create mode 100644 lib/toaster/toastermain/management/commands/buildslist.py

diff --git a/lib/toaster/toastermain/management/__init__.py b/lib/toaster/toastermain/management/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/lib/toaster/toastermain/management/commands/__init__.py b/lib/toaster/toastermain/management/commands/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/lib/toaster/toastermain/management/commands/builddelete.py b/lib/toaster/toastermain/management/commands/builddelete.py
new file mode 100644
index 0000000..5cec436
--- /dev/null
+++ b/lib/toaster/toastermain/management/commands/builddelete.py
@@ -0,0 +1,33 @@
+from django.core.management.base import BaseCommand, CommandError
+from orm.models import Build
+import os
+
+
+
+class Command(BaseCommand):
+    args    = "buildId"
+    help    = "Deletes selected build"
+
+    def handle(self, buildId, *args, **options):
+        b = Build.objects.get(pk = buildId)
+        # theoretically, just b.delete() would suffice
+        # however SQLite runs into problems when you try to
+        # delete too many rows at once, so we delete some direct
+        # relationships from Build manually.
+
+        for t in b.target_set.all():
+            t.delete()
+        for t in b.task_build.all():
+            t.delete()
+        for p in b.package_set.all():
+            p.delete()
+        for lv in b.layer_version_build.all():
+            lv.delete()
+        for v in b.variable_build.all():
+            v.delete()
+        for l in b.logmessage_set.all():
+            l.delete()
+
+        # this should take care of the rest
+        b.delete()
+
diff --git a/lib/toaster/toastermain/management/commands/buildslist.py b/lib/toaster/toastermain/management/commands/buildslist.py
new file mode 100644
index 0000000..cad987f
--- /dev/null
+++ b/lib/toaster/toastermain/management/commands/buildslist.py
@@ -0,0 +1,13 @@
+from django.core.management.base import NoArgsCommand, CommandError
+from orm.models import Build
+import os
+
+
+
+class Command(NoArgsCommand):
+    args    = ""
+    help    = "Lists current builds"
+
+    def handle_noargs(self,**options):
+        for b in Build.objects.all():
+            print "%d: %s %s %s" % (b.pk, b.machine, b.distro, ",".join([x.target for x in b.target_set.all()]))
-- 
1.8.3.2


