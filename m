Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id 78AFB6093F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Sep 2016 08:00:46 +0000 (UTC)
Received: by mail-wm0-f46.google.com with SMTP id w84so118045790wmg.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Sep 2016 01:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=/q+fsfBMsOtQT3nI+MrXpgqPWn1DHp6TD0McbPHIn2U=;
	b=YZSYDq+cRSILZsx5oGEMVuje0nE/bcoTYjiU2DkzEPa4sWvk8B0CAXbHnNWmiaOiE3
	TVfUMyM3RoSsclI7sMLKJwLE6PHaH5QLt1e9l2zRwRKl8W6LSXDQBp2ZwBpZApXVh/Qk
	AfcUaYz1dTFIVRCeA2Por1hIWe7/AubQOMIMXtlcZz23oppRggMkH/OCwymBbpBTF4sK
	rYCNuSwTkLKpdriVETN2MCg10rb1HtFywIFcvHb/nXYqmS3aA5sfmAJOCn9zDoWr+E1N
	C0mv8US0ns3Xx84xmCy61jIe4Y0hIVdKbBxjxIkhKvBEYWi0kqzgstOVtUipTGVJKSK7
	uX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=/q+fsfBMsOtQT3nI+MrXpgqPWn1DHp6TD0McbPHIn2U=;
	b=EgH/nxugBjiKfU8kFnu5ZdQe6t4tPGSGhh0p6tCkiyHifrZXoCMDou/vrvSrifm/+Q
	d/b5LrgZiI0EoAAvsaY8wMwNt+cblCHbHsnlIGL6A626oaTcydsyxXejiKN+B4sQLP0b
	MNEm0ZWZBY4Mf/Y8edQ/7xPMJpe2jillZe0pkk8PgiRPepRb33Lcu7iG1CnmUIYI0pp4
	lwdXqh4CVgC7/oDq2tRL0eUsuC5xEDrYWUN7LNGszXNShNAkUmu/m7stQpvuE/ZSxA3O
	4cKCelR3fsYiLx3mTvoQVJtMsooFFI5SBDat2opd5ovaesxu56Shy2V2OCSpCFBf9lC/
	euLw==
X-Gm-Message-State: AE9vXwMC8ZdczpZg8OjJ44GIHtTYFz+qkVtIDmxlW6tBOTB3hAxNe8kY2T0hRSBG2h1prIVw
X-Received: by 10.28.140.5 with SMTP id o5mr2127418wmd.13.1474358447079;
	Tue, 20 Sep 2016 01:00:47 -0700 (PDT)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id
	17sm26932021wju.44.2016.09.20.01.00.46
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 20 Sep 2016 01:00:46 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Sep 2016 09:00:41 +0100
Message-Id: <1474358441-1948-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 2.8.1
Subject: [PATCH] uihelper: use elif instead of repeated if
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
X-List-Received-Date: Tue, 20 Sep 2016 08:00:47 -0000

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/ui/uihelper.py | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/ui/uihelper.py b/bitbake/lib/bb/ui/uihelper.py
index f64fa18..fda7cc2 100644
--- a/bitbake/lib/bb/ui/uihelper.py
+++ b/bitbake/lib/bb/ui/uihelper.py
@@ -35,25 +35,25 @@ class BBUIHelper:
             self.running_tasks[event.pid] = { 'title' : "%s %s" % (event._package, event._task), 'starttime' : time.time() }
             self.running_pids.append(event.pid)
             self.needUpdate = True
-        if isinstance(event, bb.build.TaskSucceeded):
+        elif isinstance(event, bb.build.TaskSucceeded):
             del self.running_tasks[event.pid]
             self.running_pids.remove(event.pid)
             self.needUpdate = True
-        if isinstance(event, bb.build.TaskFailedSilent):
+        elif isinstance(event, bb.build.TaskFailedSilent):
             del self.running_tasks[event.pid]
             self.running_pids.remove(event.pid)
             # Don't add to the failed tasks list since this is e.g. a setscene task failure
             self.needUpdate = True
-        if isinstance(event, bb.build.TaskFailed):
+        elif isinstance(event, bb.build.TaskFailed):
             del self.running_tasks[event.pid]
             self.running_pids.remove(event.pid)
             self.failed_tasks.append( { 'title' : "%s %s" % (event._package, event._task)})
             self.needUpdate = True
-        if isinstance(event, bb.runqueue.runQueueTaskStarted) or isinstance(event, bb.runqueue.sceneQueueTaskStarted):
+        elif isinstance(event, bb.runqueue.runQueueTaskStarted) or isinstance(event, bb.runqueue.sceneQueueTaskStarted):
             self.tasknumber_current = event.stats.completed + event.stats.active + event.stats.failed + 1
             self.tasknumber_total = event.stats.total
             self.needUpdate = True
-        if isinstance(event, bb.build.TaskProgress):
+        elif isinstance(event, bb.build.TaskProgress):
             if event.pid > 0:
                 self.running_tasks[event.pid]['progress'] = event.progress
                 self.running_tasks[event.pid]['rate'] = event.rate
@@ -62,4 +62,3 @@ class BBUIHelper:
     def getTasks(self):
         self.needUpdate = False
         return (self.running_tasks, self.failed_tasks)
-
-- 
2.8.1


