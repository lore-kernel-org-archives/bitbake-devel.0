Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
	[209.85.212.180])
	by mail.openembedded.org (Postfix) with ESMTP id DB3027596C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:34:47 +0000 (UTC)
Received: by wibdq8 with SMTP id dq8so71520538wib.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=PRzpF1WH+MLMwehw2L5C+rKF0znbh23szrFSsbjyrts=;
	b=WrVe1prtLO0Va6YjLBiYl17+e8+P6Rbfb8MHa95bCt5WPfiHuVUIKa8ktYWjKY7BbM
	kXXe8lN6egwsfFJQm9WaLJDDI9ydVtUBPfq6eRL0I/xhDyrDBwkVw0ZeBqzLFdLquV+D
	UxgpI9jg58WIYCHVQCtPHdC1ZPkHaWZFEQNxXm9wFMpVcSy0jokKmsZi3tNBexN/hwPJ
	ZI0lGeLRSGLLan5amGoRHopQxBcsHyW8NVY904bHoT0DmyJmz7Tyks3qndgs/cY1lFwE
	1qC6CEZ9vz1H1LFWUxxNRRwzSId1gQW1RjRQySJfTzgO+7RkaywyAKwwwXeHp9ZSxOky
	hhbg==
X-Gm-Message-State: ALoCoQndeK6lDqYvl+sRbk4pkSNS8jDDxnFhzVBazGBKCQiElADXGtYJO8e75jrqAklAfn9xFEDm
X-Received: by 10.181.29.201 with SMTP id jy9mr4532611wid.84.1435228488482;
	Thu, 25 Jun 2015 03:34:48 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id e2sm19719840wjw.12.2015.06.25.03.34.47
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:34:47 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id DA75A562796; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:51 +0100
Message-Id: <d5468d84c1ef83c780de5974c8e3a11eab762489.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
References: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
Subject: [PATCH 14/23] toaster: delete multiple builds
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
X-List-Received-Date: Thu, 25 Jun 2015 10:34:48 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes the build deletion on unmigrated databases,
and enhances it to delete multiple builds in a single run.

[YOCTO #7726]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py                    |  4 +-
 .../toastermain/management/commands/builddelete.py | 56 ++++++++++++++--------
 2 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 1a504b8..ec65903 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -64,9 +64,9 @@ def _get_latest_builds(prj=None):
     if prj is not None:
         queryset = queryset.filter(project = prj)
 
-    return itertools.chain(
+    return list(itertools.chain(
         queryset.filter(outcome=Build.IN_PROGRESS).order_by("-pk"),
-        queryset.filter(outcome__lt=Build.IN_PROGRESS).order_by("-pk")[:3] )
+        queryset.filter(outcome__lt=Build.IN_PROGRESS).order_by("-pk")[:3] ))
 
 
 # a JSON-able dict of recent builds; for use in the Project page, xhr_ updates,  and other places, as needed
diff --git a/lib/toaster/toastermain/management/commands/builddelete.py b/lib/toaster/toastermain/management/commands/builddelete.py
index 5cec436..343d311 100644
--- a/lib/toaster/toastermain/management/commands/builddelete.py
+++ b/lib/toaster/toastermain/management/commands/builddelete.py
@@ -1,33 +1,49 @@
 from django.core.management.base import BaseCommand, CommandError
 from orm.models import Build
+from django.db import OperationalError
 import os
 
 
 
 class Command(BaseCommand):
     args    = "buildId"
-    help    = "Deletes selected build"
+    help    = "Deletes selected build(s)"
 
     def handle(self, buildId, *args, **options):
-        b = Build.objects.get(pk = buildId)
-        # theoretically, just b.delete() would suffice
-        # however SQLite runs into problems when you try to
-        # delete too many rows at once, so we delete some direct
-        # relationships from Build manually.
+        for bid in buildId.split(","):
+            b = Build.objects.get(pk = bid)
+            # theoretically, just b.delete() would suffice
+            # however SQLite runs into problems when you try to
+            # delete too many rows at once, so we delete some direct
+            # relationships from Build manually.
+            for t in b.target_set.all():
+                t.delete()
+            for t in b.task_build.all():
+                t.delete()
+            for p in b.package_set.all():
+                p.delete()
+            for lv in b.layer_version_build.all():
+                lv.delete()
+            for v in b.variable_build.all():
+                v.delete()
+            for l in b.logmessage_set.all():
+                l.delete()
 
-        for t in b.target_set.all():
-            t.delete()
-        for t in b.task_build.all():
-            t.delete()
-        for p in b.package_set.all():
-            p.delete()
-        for lv in b.layer_version_build.all():
-            lv.delete()
-        for v in b.variable_build.all():
-            v.delete()
-        for l in b.logmessage_set.all():
-            l.delete()
+            # delete the build; some databases might have had problem with migration of the bldcontrol app
+            retry_count = 0
+            need_bldcontrol_migration = False
+            while True:
+                if retry_count >= 5:
+                    break
+                retry_count += 1
+                if need_bldcontrol_migration:
+                    from django.core import management
+                    management.call_command('migrate', 'bldcontrol', interactive=False)
 
-        # this should take care of the rest
-        b.delete()
+                try:
+                    b.delete()
+                    break
+                except OperationalError as e:
+                    # execute migrations
+                    need_bldcontrol_migration = True
 
-- 
1.9.1


