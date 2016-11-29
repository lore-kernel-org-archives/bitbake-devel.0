Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f176.google.com (mail-io0-f176.google.com
	[209.85.223.176])
	by mail.openembedded.org (Postfix) with ESMTP id 869C9719F2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Nov 2016 16:48:09 +0000 (UTC)
Received: by mail-io0-f176.google.com with SMTP id m5so161505210ioe.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Nov 2016 08:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=r7RyO1ik7P1kP5qtnJKd91U0kViyV7s9Swv9kK28E9Y=;
	b=iqDs2THpDpWUrhnNad0cRS4pTDKXPMH5v/7zG8yYQRQR/BC/RWbj9dHCQ0uXXrRWr9
	WuakmTbGEl0+34OmaQdId/+vUGIGBTtiQDBmIGPO+dWj3oSETHc8dwv0rhGUIjD6fqND
	Nvby+rQig6UMl4J5jb1Y52qtS3PvHzdpLhF+zZLnDBWcSoyAOL0s0OQhMMsdUS3lZ0z9
	AhW4xjRp2GsAQhQhRK1p60JB2C9hroqvsQ1GjWGfe8TI7DtC35UM/7KF3YmP9jZKzOC3
	IGMPNdnDCnHOk7l5wZ1q6KpRWrYGFrQB3hlfBzfzW6IAKkSu2c18JjNHBw/yEJIEAMul
	G1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=r7RyO1ik7P1kP5qtnJKd91U0kViyV7s9Swv9kK28E9Y=;
	b=kcEfUG/xWFzltw0lj5Ow4JfaT3aqW925bgt3bAbT75+3nd2Pv7xz9Td5rABMm+IBcS
	64AiCC/Ssli459ULrD0OxS+Gqx0KyrgfG+Nu3AoBZgiGT4i9pbXkcmesqoiCkvDJMYQk
	W6IgFmOAM78RMkNufNDYRMjCKn617tfG9E9F+DT+FID0T6xW4p8jSQHIVG0Bc71U24dg
	DK7mfflD6mcCqVddqtbk6vRoDBVXOSRIeuCZiiw0x3qbE6O2o3qGpdyxU2DqatoQEwsj
	kDG+nqPtERKk1FJK26Cm/TYWdixVUg4H/e52VoTbn/QWzVGiiaEFO+K2irIRPExQvl1a
	SgtA==
X-Gm-Message-State: AKaTC02rVndBvctuToK/pA1Rvzqy2ty3fVb1jkU3m+63xr3LmWf+u/749Wj0rdk3PbxMT0mL
X-Received: by 10.107.147.9 with SMTP id v9mr25008208iod.110.1480438091003;
	Tue, 29 Nov 2016 08:48:11 -0800 (PST)
Received: from pohly-desktop.fritz.box (p5DE8EEDB.dip0.t-ipconnect.de.
	[93.232.238.219])
	by smtp.gmail.com with ESMTPSA id l79sm1119425itb.1.2016.11.29.08.48.09
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 29 Nov 2016 08:48:10 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 29 Nov 2016 17:47:43 +0100
Message-Id: <57cd005d71d0b164e21714bf4903c22130e03988.1480437099.git.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1480437099.git.patrick.ohly@intel.com>
References: <cover.1480437099.git.patrick.ohly@intel.com>
Subject: [PATCH V2 2/4] runqueue.py: monitor disk space at regular time intervals
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
X-List-Received-Date: Tue, 29 Nov 2016 16:48:10 -0000

Hooking the disk monitor into the regular heatbeat event instead
of the runqueue solves two problems:

- When there is just one long running task which fills up the disk,
  the previous approach did not notice that until after the completion
  of the task because _execute_runqueue() only gets called on task
  state changes. As a result, aborting a build did not work in this
  case.

- When there are many short-lived tasks, disk space was getting
  checked very frequently. When the storage that is getting checked
  is on an NFS server, that can lead to noticable traffic to the
  server.

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/runqueue.py | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 84b2685..b1a09ad 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -984,8 +984,14 @@ class RunQueue:
         self.state = runQueuePrepare
 
         # For disk space monitor
+        # Invoked at regular time intervals via the bitbake heartbeat event
+        # while the build is running. We generate a unique name for the handler
+        # here, just in case that there ever is more than one RunQueue instance,
+        # start the handler when reaching runQueueSceneRun, and stop it when
+        # done with the build.
         self.dm = monitordisk.diskMonitor(cfgData)
-
+        self.dm_event_handler_name = '_bb_diskmonitor_' + str(id(self))
+        self.dm_event_handler_registered = False
         self.rqexe = None
         self.worker = {}
         self.fakeworker = {}
@@ -1208,10 +1214,12 @@ class RunQueue:
                 self.rqdata.init_progress_reporter.next_stage()
                 self.rqexe = RunQueueExecuteScenequeue(self)
 
-        if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp]:
-            self.dm.check(self)
-
         if self.state is runQueueSceneRun:
+            if not self.dm_event_handler_registered:
+                 res = bb.event.register(self.dm_event_handler_name,
+                                         lambda x: self.dm.check(self) if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp] else False,
+                                         ('bb.event.HeartbeatEvent',))
+                 self.dm_event_handler_registered = True
             retval = self.rqexe.execute()
 
         if self.state is runQueueRunInit:
@@ -1230,7 +1238,13 @@ class RunQueue:
         if self.state is runQueueCleanUp:
             retval = self.rqexe.finish()
 
-        if (self.state is runQueueComplete or self.state is runQueueFailed) and self.rqexe:
+        build_done = self.state is runQueueComplete or self.state is runQueueFailed
+
+        if build_done and self.dm_event_handler_registered:
+            bb.event.remove(self.dm_event_handler_name, None)
+            self.dm_event_handler_registered = False
+
+        if build_done and self.rqexe:
             self.teardown_workers()
             if self.rqexe.stats.failed:
                 logger.info("Tasks Summary: Attempted %d tasks of which %d didn't need to be rerun and %d failed.", self.rqexe.stats.completed + self.rqexe.stats.failed, self.rqexe.stats.skipped, self.rqexe.stats.failed)
-- 
2.1.4


