Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70EDC433F5
	for <webhook@archiver.kernel.org>; Mon, 21 Mar 2022 05:02:24 +0000 (UTC)
Received: from mail1.wrs.com (mail1.wrs.com [147.11.3.146])
 by mx.groups.io with SMTP id smtpd.web10.26765.1647838943930271129
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 20 Mar 2022 22:02:24 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid
 domain name (domain: windriver.com, ip: 147.11.3.146,
 mailfrom: david.reyna@windriver.com)
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com
 [147.11.82.252])
	by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 22L52Me9006434
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Sun, 20 Mar 2022 22:02:22 -0700
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 20 Mar 2022 22:02:22 -0700
Received: from ala-lpggp2.wrs.com (147.11.105.123) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Sun, 20 Mar 2022 22:02:22 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/2] toaster: detect when bitbake crashed
Date: Sun, 20 Mar 2022 22:02:20 -0700
Message-ID: 
 <19b4157ed0212570f46d681ebce2af51ad436e13.1647836508.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1647836508.git.David.Reyna@windriver.com>
References: <cover.1647836508.git.David.Reyna@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 21 Mar 2022 05:02:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13486

From: David Reyna <David.Reyna@windriver.com>

Add a polling check on tracebacks in a build's log. This
can for example indicate that bitbake crashed, which would
stop the event stream that Toaster normally uses to detect
build errors.

[YOCTO #14085]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 .../management/commands/runbuilds.py          | 83 ++++++++++++++++++-
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 19f659ec41..834e32b36f 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -180,6 +180,77 @@ class Command(BaseCommand):
         except Exception as e:
             logger.warning("runbuilds: schedule exception %s" % str(e))
 
+    # Test to see if a build pre-maturely died due to a bitbake crash
+    def check_dead_builds(self):
+        do_cleanup = False
+        try:
+            for br in BuildRequest.objects.filter(state=BuildRequest.REQ_INPROGRESS):
+                # Get the build directory
+                if br.project.builddir:
+                    builddir =  br.project.builddir
+                else:
+                    builddir = '%s-toaster-%d' % (br.environment.builddir,br.project.id)
+                # Check log to see if there is a recent traceback
+                toaster_ui_log = os.path.join(builddir, 'toaster_ui.log')
+                test_file = os.path.join(builddir, '._toaster_check.txt')
+                os.system("tail -n 50 %s > %s" % (os.path.join(builddir, 'toaster_ui.log'),test_file))
+                traceback_text = ''
+                is_traceback = False
+                with open(test_file,'r') as test_file_fd:
+                    test_file_tail = test_file_fd.readlines()
+                    for line in test_file_tail:
+                        if line.startswith('Traceback (most recent call last):'):
+                            traceback_text = line
+                            is_traceback = True
+                        elif line.startswith('NOTE: ToasterUI waiting for events'):
+                            # Ignore any traceback before new build start
+                            traceback_text = ''
+                            is_traceback = False
+                        elif line.startswith('Note: Toaster traceback auto-stop'):
+                            # Ignore any traceback before this previous traceback catch
+                            traceback_text = ''
+                            is_traceback = False
+                        elif is_traceback:
+                            traceback_text += line
+                # Test the results
+                is_stop = False
+                if is_traceback:
+                    # Found a traceback
+                    errtype = 'Bitbake crash'
+                    errmsg = 'Bitbake crash\n' + traceback_text
+                    state = BuildRequest.REQ_FAILED
+                    # Clean up bitbake files
+                    bitbake_lock = os.path.join(builddir, 'bitbake.lock')
+                    if os.path.isfile(bitbake_lock):
+                        os.remove(bitbake_lock)
+                    bitbake_sock = os.path.join(builddir, 'bitbake.sock')
+                    if os.path.isfile(bitbake_sock):
+                        os.remove(bitbake_sock)
+                    if os.path.isfile(test_file):
+                        os.remove(test_file)
+                    # Add note to ignore this traceback on next check
+                    os.system('echo "Note: Toaster traceback auto-stop" >> %s' % toaster_ui_log)
+                    is_stop = True
+                # Add more tests here
+                #elif ...
+                # Stop the build request?
+                if is_stop:
+                    brerror = BRError(
+                        req = br,
+                        errtype = errtype,
+                        errmsg = errmsg,
+                        traceback = traceback_text,
+                        )
+                    brerror.save()
+                    br.state = state
+                    br.save()
+                    do_cleanup = True
+            # Do cleanup
+            if do_cleanup:
+                self.cleanup()
+        except Exception as e:
+            logger.error("runbuilds: Error in check_dead_builds %s" % e)
+
     def handle(self, **options):
         pidfile_path = os.path.join(os.environ.get("BUILDDIR", "."),
                                     ".runbuilds.pid")
@@ -187,10 +258,18 @@ class Command(BaseCommand):
         with open(pidfile_path, 'w') as pidfile:
             pidfile.write("%s" % os.getpid())
 
+        # Clean up any stale/failed builds from previous Toaster run
         self.runbuild()
 
         signal.signal(signal.SIGUSR1, lambda sig, frame: None)
 
         while True:
-            signal.pause()
-            self.runbuild()
+            sigset = signal.sigtimedwait([signal.SIGUSR1], 5)
+            if sigset:
+                for sig in sigset:
+                    # Consume each captured pending event
+                    self.runbuild()
+            else:
+                # Check for build exceptions
+                self.check_dead_builds()
+
-- 
2.17.1


