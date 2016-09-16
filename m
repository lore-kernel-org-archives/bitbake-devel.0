Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f176.google.com (mail-pf0-f176.google.com
	[209.85.192.176])
	by mail.openembedded.org (Postfix) with ESMTP id 6C02275C60
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 16:22:55 +0000 (UTC)
Received: by mail-pf0-f176.google.com with SMTP id 21so18062036pfy.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 09:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=I8A94F/QPWPgZm8t+XkJC2bIn22QJ1B4j2udmY5qIR4=;
	b=Xdd4PfC/t/X5p05HlZVAUcxP8XtUtfenxVvZtUTT1fTaXuu5F1y/yXysdc2CR/jY9w
	mooL54OifQkcU838ovzLt785kxJQk0AcgSE5WwLgQFyt8mA+qSS3SQcZx+tXqHYwIXlv
	Aw9Wct54FeTBW9ZsKB+wRrdYjfqLY1dMVadPZUnepkzyVGBiHhIWcFGFLidoNck1izcW
	InjsOvrhjvsInshYY+Qw+mGe4XWYgwZ0u8lnGJ04pHwSLHKpp4Gu0WMwu/sm4cPEnRku
	joj9N5vusa+BkC8kcyxV1ODl6seUEMjl4pi3P+NQkUAlXCNoMDDqhzbnthgJjhbNsRPf
	yTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=I8A94F/QPWPgZm8t+XkJC2bIn22QJ1B4j2udmY5qIR4=;
	b=QSa6pkgPX5rRsp9hctoak5gmq8Pc1M3OgQ836WCeGRbgt9XgsYT0UQQgtmLSaPqYgY
	54RUQMl9Dz/bu+iiThpFTJ47mMAxG3Kdg+zj/pGHcus3nAzdTaGdzeRZcNLQlERdQaSs
	9DBPzNnstzTCrOS4yZVbNwZcAqhmKpUJPsEry0mX7D18pP3yFtbVnbKlaDXUtlZIHelI
	7MlXEJVO/FP6GUP0B9ijFQ4gPS91mrfr6oRWOuK8wWlEH746km7qNRs8TVLpjkkJyMFt
	T01ufhdV3fmWyUHTx3496MQiiDOOoQLzFq2zTlEVbW9JXUQXyNKcg5reaTsvSuujGdMD
	OWRA==
X-Gm-Message-State: AE9vXwMzVDqVQjJy/O92s+/kiT3YdqPt1jikSeGeooxknzDpik3JnMJYcHFGaP/qjfa/ohvi
X-Received: by 10.98.197.4 with SMTP id j4mr4167191pfg.134.1474042976368;
	Fri, 16 Sep 2016 09:22:56 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr04-ext.fm.intel.com.
	[192.55.55.39]) by smtp.gmail.com with ESMTPSA id
	bm8sm13336146pac.16.2016.09.16.09.22.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 16 Sep 2016 09:22:55 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Sep 2016 17:22:33 +0100
Message-Id: <1474042955-12618-7-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474042955-12618-1-git-send-email-michael.g.wood@intel.com>
References: <1474042955-12618-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 6/8] runbuilds: code cleanup - whitespaces, long lines
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
X-List-Received-Date: Fri, 16 Sep 2016 16:22:55 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Fixed following pylint warnings:
 C0330(bad-continuation): Wrong hanging indentation before block.
 C0326(bad-whitespace): No space allowed around keyword argument assignment
 C0326(bad-whitespace): Exactly one space required before assignment
 C0301(line-too-long): Line too long

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 .../bldcontrol/management/commands/runbuilds.py    | 34 ++++++++++------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 7df81dc..3421726 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -18,14 +18,13 @@ import signal
 logger = logging.getLogger("toaster")
 
 class Command(NoArgsCommand):
-    args    = ""
-    help    = "Schedules and executes build requests as possible."
-    "Does not return (interrupt with Ctrl-C)"
-
+    args = ""
+    help = "Schedules and executes build requests as possible. "\
+           "Does not return (interrupt with Ctrl-C)"
 
     @transaction.atomic
     def _selectBuildEnvironment(self):
-        bec = getBuildEnvironmentController(lock = BuildEnvironment.LOCK_FREE)
+        bec = getBuildEnvironmentController(lock=BuildEnvironment.LOCK_FREE)
         bec.be.lock = BuildEnvironment.LOCK_LOCK
         bec.be.save()
         return bec
@@ -75,17 +74,15 @@ class Command(NoArgsCommand):
             else:
                 errmsg = str(e)
 
-            BRError.objects.create(req = br,
-                    errtype = str(type(e)),
-                    errmsg = errmsg,
-                    traceback = traceback.format_exc())
+            BRError.objects.create(req=br, errtype=str(type(e)), errmsg=errmsg,
+                                   traceback=traceback.format_exc())
             br.state = BuildRequest.REQ_FAILED
             br.save()
             bec.be.lock = BuildEnvironment.LOCK_FREE
             bec.be.save()
 
     def archive(self):
-        for br in BuildRequest.objects.filter(state = BuildRequest.REQ_ARCHIVE):
+        for br in BuildRequest.objects.filter(state=BuildRequest.REQ_ARCHIVE):
             if br.build == None:
                 br.state = BuildRequest.REQ_FAILED
             else:
@@ -102,14 +99,13 @@ class Command(NoArgsCommand):
                                        BuildRequest.REQ_COMPLETED,
                                        BuildRequest.REQ_CANCELLING]) &
             Q(lock=BuildEnvironment.LOCK_LOCK) &
-            Q(updated__lt=timezone.now() - timedelta(seconds = 30))
+            Q(updated__lt=timezone.now() - timedelta(seconds=30))
         ).update(lock=BuildEnvironment.LOCK_FREE)
 
 
         # update all Builds that were in progress and failed to start
-        for br in BuildRequest.objects.filter(
-            state=BuildRequest.REQ_FAILED,
-            build__outcome=Build.IN_PROGRESS):
+        for br in BuildRequest.objects.filter(state=BuildRequest.REQ_FAILED,
+                                              build__outcome=Build.IN_PROGRESS):
             # transpose the launch errors in ToasterExceptions
             br.build.outcome = Build.FAILED
             for brerror in br.brerror_set.all():
@@ -126,7 +122,7 @@ class Command(NoArgsCommand):
 
 
         # update all BuildRequests without a build created
-        for br in BuildRequest.objects.filter(build = None):
+        for br in BuildRequest.objects.filter(build=None):
             br.build = Build.objects.create(project=br.project,
                                             completed_on=br.updated,
                                             started_on=br.created)
@@ -151,10 +147,10 @@ class Command(NoArgsCommand):
 
         # Make sure the LOCK is removed for builds which have been fully
         # cancelled
-        for br in BuildRequest.objects.filter(
-            Q(build__outcome=Build.CANCELLED) &
-            Q(state=BuildRequest.REQ_CANCELLING) &
-            ~Q(environment=None)):
+        for br in BuildRequest.objects.filter(\
+                      Q(build__outcome=Build.CANCELLED) &
+                      Q(state=BuildRequest.REQ_CANCELLING) &
+                      ~Q(environment=None)):
             br.environment.lock = BuildEnvironment.LOCK_FREE
             br.environment.save()
 
-- 
2.7.4


