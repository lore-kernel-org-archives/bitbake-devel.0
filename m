Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
	by mail.openembedded.org (Postfix) with ESMTP id 8490477114
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:34 +0000 (UTC)
Received: by mail-wm0-f48.google.com with SMTP id f198so81808822wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=ymb/jEHlcwJ2Q/hMueHDCxw4viSKFYGLl7LyxpO1cc4=;
	b=gz9+KyOS1AGO44ss47olYtCAZs50YSLyWgnURKnh2joY50ZKX6HfzgCvKD1zpDoYbj
	qhDpKHFCTDhghnG9lA9D8oJWVFOPpMm5QWtVv+eQCs0ci5HkXy+NDMnGmuj932KSMZyn
	pqDDdQaSTTs5WWcth3s8PpCoe0U1Q2iQVpQ4KCdKSK2ZLHsHaKELbTxU0ONVFK6ZUoj0
	dt4s0i7kxSer4iC093Uw2WjQ4xUjeW27AKeWgDT2ZoOJjO4LMNp9SDY8V9Ic/3KyakDg
	Pl8tY/LpjPUfQSw9cpceMwOgbc/lNtrZa7ODCu8fnky1FBGvXz6TFVicD1h1vUVFxGzd
	6O9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ymb/jEHlcwJ2Q/hMueHDCxw4viSKFYGLl7LyxpO1cc4=;
	b=QqeG316f59a9W0e96iPJrieQttwqqMekHVjqdkKpXD4+R3qOdUn43gRjxfmlHoWHLT
	YF0I7p1KRWeRAmgD8tj48XetG7pVz/gKWydgtkxsmU4DPlFzS7cwfkNTlgEk7gQ2+vxH
	0u66BPfDYKsPpwuqkWNDD62JkGYLY7Q7nlfTYyHDhmD/kaYMQomlg9fREiu7fxExWyxk
	6jHK6UQifXD/ywsCtmx4WZrDKZY8Gu8Jo9k48YTQ7JO4VNDn6Cq6AithsJbFEDh6rcfz
	FNYBDY/5k02o6c25iHKOfo4j92SwEtS4VqK4vSGDMSRE9exTVv4pTjIV1JCf4AZ8r8WR
	g0BQ==
X-Gm-Message-State: AD7BkJK8V7LSNNzbpFmdR+qmeMJ3GoA1GXyYyJ5JKEGF1JstHLn8aNkHXNKWSY7yomd00Jys
X-Received: by 10.194.77.15 with SMTP id o15mr38530181wjw.41.1459961255541;
	Wed, 06 Apr 2016 09:47:35 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.34
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:35 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:40 +0100
Message-Id: <ed5b4b8345ecbe4f394a8e1d7cb1430020e1e500.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 30/38] toaster: runbuilds Make runbuilds aware of the build CANCELLED state
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:36 -0000

Add handlers to make sure we remove the BuildEnvironment LOCK when we
have cancelled a build.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 .../bldcontrol/management/commands/runbuilds.py    | 26 ++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 8ba836e..4c1c6a7 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -1,5 +1,7 @@
 from django.core.management.base import NoArgsCommand, CommandError
 from django.db import transaction
+from django.db.models import Q
+
 from orm.models import Build, ToasterSetting, LogMessage, Target
 from bldcontrol.bbcontroller import getBuildEnvironmentController, ShellCmdException, BuildSetupException
 from bldcontrol.models import BuildRequest, BuildEnvironment, BRError, BRVariable
@@ -86,13 +88,20 @@ class Command(NoArgsCommand):
     def cleanup(self):
         from django.utils import timezone
         from datetime import timedelta
-        # environments locked for more than 30 seconds - they should be unlocked
-        BuildEnvironment.objects.filter(buildrequest__state__in=[BuildRequest.REQ_FAILED, BuildRequest.REQ_COMPLETED]).filter(lock=BuildEnvironment.LOCK_LOCK).filter(updated__lt = timezone.now() - timedelta(seconds = 30)).update(lock = BuildEnvironment.LOCK_FREE)
-
-
         # update all Builds that failed to start
 
         for br in BuildRequest.objects.filter(state = BuildRequest.REQ_FAILED, build__outcome = Build.IN_PROGRESS):
+        # environments locked for more than 30 seconds
+        # they should be unlocked
+        BuildEnvironment.objects.filter(
+            Q(buildrequest__state__in=[BuildRequest.REQ_FAILED,
+                                       BuildRequest.REQ_COMPLETED,
+                                       BuildRequest.REQ_CANCELLING]) &
+            Q(lock=BuildEnvironment.LOCK_LOCK) &
+            Q(updated__lt=timezone.now() - timedelta(seconds = 30))
+        ).update(lock=BuildEnvironment.LOCK_FREE)
+
+
             # transpose the launch errors in ToasterExceptions
             br.build.outcome = Build.FAILED
             for brerror in br.brerror_set.all():
@@ -125,6 +134,15 @@ class Command(NoArgsCommand):
             br.build.save()
         pass
 
+        # Make sure the LOCK is removed for builds which have been fully
+        # cancelled
+        for br in BuildRequest.objects.filter(
+            Q(build__outcome=Build.CANCELLED) &
+            Q(state=BuildRequest.REQ_CANCELLING) &
+            ~Q(environment=None)):
+            br.environment.lock = BuildEnvironment.LOCK_FREE
+            br.environment.save()
+
 
     def handle_noargs(self, **options):
         while True:
-- 
2.1.4


