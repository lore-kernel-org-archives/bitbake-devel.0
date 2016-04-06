Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id 1C9E07710D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:35 +0000 (UTC)
Received: by mail-wm0-f53.google.com with SMTP id f198so81809332wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=OYHLj6O3Xrcwb0pQ/0BermbuRx27N3r/VfWkWeOUM5E=;
	b=L15N4SM1b0TTg2VzaZWrdKPi58pJ7KlftPe1wA1hhjGjknoKys+82VNZ/T6HM7CB36
	LpYY9R++nTiPDSNYl41YkmQqoPPC00RjWroT+9FI9c1X0z4bcPFI7XDJMq6+pkVZtADN
	F+BRuR0qOa3NoH6SA1e5u3ySe4Mc60Z1jWAajvzjrJ55SpzFRvhfEPAFbqHjdPMApUgp
	XgJb0uh5hXy6tbRArxCMK6j/7XNLWmv4tlhK81rFuJrawA4HO5i6Mw9OQT8uvQT1YQZ2
	HiQ5rwAq/Td9oc98B0bYcCDI6aliTPCErHRQMkoJ+BKE9c5fNkkClTh52O39rQ0S1WIs
	hhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=OYHLj6O3Xrcwb0pQ/0BermbuRx27N3r/VfWkWeOUM5E=;
	b=S9m9PMhbfh1OYd/7Gk8QeZarIXT0Mpm6BE5h5i49Jv+S53P33un1926VFC3hBd6rSw
	f5AQ4xfItVrX55evGzv/HEUyDoJ2l2iYglfBPeKWBPVjXImbZiMqQ6OogAizqWrMYRK8
	8Ia8sOJCFkzF1Ml0RwBkhWuDzeMNbfhLXX9see+4Y6C2LAbK1tF1wKf5rZo16k0bFRat
	LQIiD/ZmxpyVurIAhLTncPqKtehqEsfM6MscY6Sf25AtFvlXI0y/gS6twoEH1Bhm9wpp
	bOZsV2dZkZPhpqaCd/LTwEVjo0rF2SMfHDvjvPTP633E667LsmbDDdR2DvpycnDXz6Uf
	ryQg==
X-Gm-Message-State: AD7BkJLt6+ayAuYBkATwYmgPT2ltq5IiW8f/8RTaR4SyIIsfVSazf6ihXLXio+InLxG+vbDb
X-Received: by 10.194.185.108 with SMTP id fb12mr15240671wjc.89.1459961256434; 
	Wed, 06 Apr 2016 09:47:36 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.35
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:35 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:41 +0100
Message-Id: <89db90f5a3da904721ac7a91214843e7628449c7.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 31/38] toaster: runbuilds Clean up runbuilds
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

- Organise the imports into logical groups
- Fix 80 col wrapping
- Remove catch all exceptions
- Log to the toaster log
- Use QuerySet functions such as .first() and Q()

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 .../bldcontrol/management/commands/runbuilds.py    | 81 ++++++++++++++--------
 1 file changed, 52 insertions(+), 29 deletions(-)

diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 4c1c6a7..27289be 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -2,18 +2,25 @@ from django.core.management.base import NoArgsCommand, CommandError
 from django.db import transaction
 from django.db.models import Q
 
+from bldcontrol.bbcontroller import getBuildEnvironmentController
+from bldcontrol.bbcontroller import ShellCmdException, BuildSetupException
+from bldcontrol.models import BuildRequest, BuildEnvironment
+from bldcontrol.models import BRError, BRVariable
+
 from orm.models import Build, ToasterSetting, LogMessage, Target
-from bldcontrol.bbcontroller import getBuildEnvironmentController, ShellCmdException, BuildSetupException
-from bldcontrol.models import BuildRequest, BuildEnvironment, BRError, BRVariable
+
 import os
 import logging
 import time
+import sys
+import traceback
 
-logger = logging.getLogger("ToasterScheduler")
+logger = logging.getLogger("toaster")
 
 class Command(NoArgsCommand):
     args    = ""
-    help    = "Schedules and executes build requests as possible. Does not return (interrupt with Ctrl-C)"
+    help    = "Schedules and executes build requests as possible."
+    "Does not return (interrupt with Ctrl-C)"
 
 
     @transaction.atomic
@@ -25,21 +32,19 @@ class Command(NoArgsCommand):
 
     @transaction.atomic
     def _selectBuildRequest(self):
-        br = BuildRequest.objects.filter(state = BuildRequest.REQ_QUEUED).order_by('pk')[0]
-        br.state = BuildRequest.REQ_INPROGRESS
-        br.save()
+        br = BuildRequest.objects.filter(state=BuildRequest.REQ_QUEUED).first()
         return br
 
     def schedule(self):
-        import traceback
         try:
-            br = None
-            try:
-                # select the build environment and the request to build
-                br = self._selectBuildRequest()
-            except IndexError as e:
-                #logger.debug("runbuilds: No build request")
+            # select the build environment and the request to build
+            br = self._selectBuildRequest()
+            if br:
+                br.state = BuildRequest.REQ_INPROGRESS
+                br.save()
+            else:
                 return
+
             try:
                 bec = self._selectBuildEnvironment()
             except IndexError as e:
@@ -49,15 +54,17 @@ class Command(NoArgsCommand):
                 logger.debug("runbuilds: No build env")
                 return
 
-            logger.debug("runbuilds: starting build %s, environment %s" % (str(br).decode('utf-8'), bec.be))
+            logger.debug("runbuilds: starting build %s, environment %s" % \
+                         (str(br).decode('utf-8'), bec.be))
 
             # let the build request know where it is being executed
             br.environment = bec.be
             br.save()
 
             # this triggers an async build
-            bec.triggerBuild(br.brbitbake, br.brlayer_set.all(), br.brvariable_set.all(),
-                             br.brtarget_set.all(), "%d:%d" % (br.pk, bec.be.pk))
+            bec.triggerBuild(br.brbitbake, br.brlayer_set.all(),
+                             br.brvariable_set.all(), br.brtarget_set.all(),
+                             "%d:%d" % (br.pk, bec.be.pk))
 
         except Exception as e:
             logger.error("runbuilds: Error launching build %s" % e)
@@ -88,9 +95,6 @@ class Command(NoArgsCommand):
     def cleanup(self):
         from django.utils import timezone
         from datetime import timedelta
-        # update all Builds that failed to start
-
-        for br in BuildRequest.objects.filter(state = BuildRequest.REQ_FAILED, build__outcome = Build.IN_PROGRESS):
         # environments locked for more than 30 seconds
         # they should be unlocked
         BuildEnvironment.objects.filter(
@@ -102,22 +106,30 @@ class Command(NoArgsCommand):
         ).update(lock=BuildEnvironment.LOCK_FREE)
 
 
+        # update all Builds that were in progress and failed to start
+        for br in BuildRequest.objects.filter(
+            state=BuildRequest.REQ_FAILED,
+            build__outcome=Build.IN_PROGRESS):
             # transpose the launch errors in ToasterExceptions
             br.build.outcome = Build.FAILED
             for brerror in br.brerror_set.all():
                 logger.debug("Saving error %s" % brerror)
-                LogMessage.objects.create(build = br.build, level = LogMessage.EXCEPTION, message = brerror.errmsg)
+                LogMessage.objects.create(build=br.build,
+                                          level=LogMessage.EXCEPTION,
+                                          message=brerror.errmsg)
             br.build.save()
 
-            # we don't have a true build object here; hence, toasterui didn't have a change to release the BE lock
+            # we don't have a true build object here; hence, toasterui
+            # didn't have a change to release the BE lock
             br.environment.lock = BuildEnvironment.LOCK_FREE
             br.environment.save()
 
 
-
         # update all BuildRequests without a build created
         for br in BuildRequest.objects.filter(build = None):
-            br.build = Build.objects.create(project = br.project, completed_on = br.updated, started_on = br.created)
+            br.build = Build.objects.create(project=br.project,
+                                            completed_on=br.updated,
+                                            started_on=br.created)
             br.build.outcome = Build.FAILED
             try:
                 br.build.machine = br.brvariable_set.get(name='MACHINE').value
@@ -126,13 +138,16 @@ class Command(NoArgsCommand):
             br.save()
             # transpose target information
             for brtarget in br.brtarget_set.all():
-                Target.objects.create(build=br.build, target=brtarget.target, task=brtarget.task)
+                Target.objects.create(build=br.build,
+                                      target=brtarget.target,
+                                      task=brtarget.task)
             # transpose the launch errors in ToasterExceptions
             for brerror in br.brerror_set.all():
-                LogMessage.objects.create(build = br.build, level = LogMessage.EXCEPTION, message = brerror.errmsg)
+                LogMessage.objects.create(build=br.build,
+                                          level=LogMessage.EXCEPTION,
+                                          message=brerror.errmsg)
 
             br.build.save()
-        pass
 
         # Make sure the LOCK is removed for builds which have been fully
         # cancelled
@@ -148,9 +163,17 @@ class Command(NoArgsCommand):
         while True:
             try:
                 self.cleanup()
+            except Exception as e:
+                logger.warn("runbuilds: cleanup exception %s" % str(e))
+
+            try:
                 self.archive()
+            except Exception as e:
+                logger.warn("runbuilds: archive exception %s" % str(e))
+
+            try:
                 self.schedule()
-            except:
-                pass
+            except Exception as e:
+                logger.warn("runbuilds: schedule exception %s" % str(e))
 
             time.sleep(1)
-- 
2.1.4


