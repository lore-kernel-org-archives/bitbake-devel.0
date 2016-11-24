Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id A02AF71B58
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 11:20:20 +0000 (UTC)
Received: by mail-wm0-f51.google.com with SMTP id f82so57224251wmf.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 03:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=DxqSWGmQR7EqrjZbWFI+YxOHcjhZ142F6sh7SNvw0Aw=;
	b=FVGNavTTCcAOOsDnBfydqPbrWyTNG10K3N/AzjwzMWdLstFE2LpbI2/zj6afyfRmiG
	jVVlSQbTwnpi83r27gjn6Vu9kHiG0NaNjGl+ER+u9kzePAVRW/T5A09MoikLB8A3KPvL
	j2k0nX+5reXvmaR/Bh88jAKP7un3KOVX5iFWCBNwkCdy9M2lwX+mmHJ4Sybzh6Fq8D7q
	0byc/ZjRnD7A4PVAkmQiAAdK9bUuWWYb8Ux6P+uF5r/RcG0/pP3c6z+VHrYTj6jNpcVf
	pxnVpDI76LxxNJ+OQ/h91BVVqNfHdGaggWx0T+QBsleO7HQBsvy9auSyRK9DQDMue1Ep
	zQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=DxqSWGmQR7EqrjZbWFI+YxOHcjhZ142F6sh7SNvw0Aw=;
	b=NVslEF9tnEoyZ0oRpilxdIiECLWxLcf2pfcKMCX9/eyE01QN55hHSgXHsv6HFTgqez
	JRIb9bkNxhjSgoJwLcnppWkHHoMlWbRlNsLk6thLk+Ty5SqtUBuzNJrDSpG7cQIuaHho
	QHSsAIwz+WHtSg9SkztzSl8bmcXORyJGTFf5ZlzjmO4fHTfJU5vU1zJC9X2Mwt/CoCOk
	yALL5AAs03huQPx9MRqvGtn18EWijpkTAcMOMR3CORll9crE41rwPaibOyNJQB90Ra+8
	eoKA7MYsLfSC3SyN4ssbu4hb1sZmECf2uTpHjcd9ir8mA29T/i4tjzG26G9UOrskUXSB
	cL3Q==
X-Gm-Message-State: AKaTC01NIet+rzn6UvFfGgiSusueI7YRMQqaMI3L71gos/L/FtR0/seJ8HjPypxb7K+akTcA
X-Received: by 10.194.172.42 with SMTP id az10mr1795653wjc.145.1479986421545; 
	Thu, 24 Nov 2016 03:20:21 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	g184sm7696900wme.23.2016.11.24.03.20.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 24 Nov 2016 03:20:21 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Nov 2016 11:19:52 +0000
Message-Id: <1479986406-4657-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
References: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 01/15] toaster: runbuilds Write the pidfile in python rather than shell script
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
X-List-Received-Date: Thu, 24 Nov 2016 11:20:22 -0000

Write the pid file out in the start up of this management command. This
ensures this has happened instead of relying on the shell command having
been run which may or may not be the case. This also makes it simpler for
testing.

Couple of clean ups of runbuilds as identified by pyflake

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bin/toaster                                         |  2 +-
 .../bldcontrol/management/commands/runbuilds.py     | 21 ++++++++++++++-------
 lib/toaster/orm/management/commands/lsupdates.py    |  1 -
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index f92d38e..e0aac1a 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -254,7 +254,7 @@ case $CMD in
             return 4
         fi
         export BITBAKE_UI='toasterui'
-        $MANAGE runbuilds & echo $! >${BUILDDIR}/.runbuilds.pid
+        $MANAGE runbuilds &
         # set fail safe stop system on terminal exit
         trap stop_system SIGHUP
         echo "Successful ${CMD}."
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 7f7a5a9..df11f9d 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -11,9 +11,11 @@ from orm.models import Build, LogMessage, Target
 import logging
 import traceback
 import signal
+import os
 
 logger = logging.getLogger("toaster")
 
+
 class Command(NoArgsCommand):
     args = ""
     help = "Schedules and executes build requests as possible. "\
@@ -50,7 +52,7 @@ class Command(NoArgsCommand):
                 logger.debug("runbuilds: No build env")
                 return
 
-            logger.info("runbuilds: starting build %s, environment %s" % \
+            logger.info("runbuilds: starting build %s, environment %s" %
                         (br, bec.be))
 
             # let the build request know where it is being executed
@@ -80,7 +82,7 @@ class Command(NoArgsCommand):
 
     def archive(self):
         for br in BuildRequest.objects.filter(state=BuildRequest.REQ_ARCHIVE):
-            if br.build == None:
+            if br.build is None:
                 br.state = BuildRequest.REQ_FAILED
             else:
                 br.state = BuildRequest.REQ_COMPLETED
@@ -99,10 +101,10 @@ class Command(NoArgsCommand):
             Q(updated__lt=timezone.now() - timedelta(seconds=30))
         ).update(lock=BuildEnvironment.LOCK_FREE)
 
-
         # update all Builds that were in progress and failed to start
-        for br in BuildRequest.objects.filter(state=BuildRequest.REQ_FAILED,
-                                              build__outcome=Build.IN_PROGRESS):
+        for br in BuildRequest.objects.filter(
+                state=BuildRequest.REQ_FAILED,
+                build__outcome=Build.IN_PROGRESS):
             # transpose the launch errors in ToasterExceptions
             br.build.outcome = Build.FAILED
             for brerror in br.brerror_set.all():
@@ -117,7 +119,6 @@ class Command(NoArgsCommand):
             br.environment.lock = BuildEnvironment.LOCK_FREE
             br.environment.save()
 
-
         # update all BuildRequests without a build created
         for br in BuildRequest.objects.filter(build=None):
             br.build = Build.objects.create(project=br.project,
@@ -144,7 +145,7 @@ class Command(NoArgsCommand):
 
         # Make sure the LOCK is removed for builds which have been fully
         # cancelled
-        for br in BuildRequest.objects.filter(\
+        for br in BuildRequest.objects.filter(
                       Q(build__outcome=Build.CANCELLED) &
                       Q(state=BuildRequest.REQ_CANCELLING) &
                       ~Q(environment=None)):
@@ -168,6 +169,12 @@ class Command(NoArgsCommand):
             logger.warn("runbuilds: schedule exception %s" % str(e))
 
     def handle_noargs(self, **options):
+        pidfile_path = os.path.join(os.environ.get("BUILDDIR", "."),
+                                    ".runbuilds.pid")
+
+        with open(pidfile_path, 'w') as pidfile:
+            pidfile.write("%s" % os.getpid())
+
         self.runbuild()
 
         signal.signal(signal.SIGUSR1, lambda sig, frame: None)
diff --git a/lib/toaster/orm/management/commands/lsupdates.py b/lib/toaster/orm/management/commands/lsupdates.py
index 688918e..68c6c42 100644
--- a/lib/toaster/orm/management/commands/lsupdates.py
+++ b/lib/toaster/orm/management/commands/lsupdates.py
@@ -90,7 +90,6 @@ class Command(NoArgsCommand):
             from urlparse import urlparse
 
         proxy_settings = os.environ.get("http_proxy", None)
-        oe_core_layer = 'openembedded-core'
 
         def _get_json_response(apiurl=DEFAULT_LAYERINDEX_SERVER):
             http_progress = Spinner()
-- 
2.7.4


