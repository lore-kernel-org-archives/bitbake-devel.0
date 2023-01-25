Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E358C27C76
	for <webhook@archiver.kernel.org>; Wed, 25 Jan 2023 08:47:45 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web10.41028.1674636460011957000
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Jan 2023 00:47:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=CR8nDP1v;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 22AB620008;
	Wed, 25 Jan 2023 08:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1674636457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SqPr6CFTf6bv7WfQaAX06Xv1zPKOcf7Vvz7r6KRcfZg=;
	b=CR8nDP1va7r6pMurBZlR7VPoznSg+sbGBcdeaTUokkFo1lMyZCLtfXB5SfTbb7/EtZURez
	hyyzYm6Dk9xCn85C0tHVbcY7SuruzBI4LMBcjo6B9eH4zInRfdAJGxPevBjwsOuLW/ZnbK
	OaV4bBkb509y/+YkI4OOZBVFWbnlrq3Ecg7xrb172S+FDMtsORMxeBXVEaYZjSWWyfsDEr
	uUnKTFZvam2Xfn2JuJw9HqVoXsjUWVH+JtbspQDdfhdFZ4xIjAGYEXowCbiP0OVI9iXl3A
	WxDefOdV37Jk84yhlPm0/32XU0IAORfM8rStrWIgyZra5FA3jOEklJfQhRoM3A==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] knotty/uihelper: use monotonic time to report task duration
Date: Wed, 25 Jan 2023 09:47:25 +0100
Message-Id: <20230125084725.2262388-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Jan 2023 08:47:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14339

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Without this, if the host machine is suspended to RAM,
BitBake reports a task duration which includes the time
the system remained suspended, not actually running the task.

This is addressed by getting the time from a monotonic
clock, which ignores time elapsed during suspend.

This fixes [YOCTO 15015]

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>

---

Note that while a successful build was obtained with this change,
it might have side effects in places I didn't foresee (in logs?).
---
 lib/bb/ui/knotty.py   | 2 +-
 lib/bb/ui/uihelper.py | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 431baa15..3174d977 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -239,7 +239,7 @@ class TerminalFilter(object):
         activetasks = self.helper.running_tasks
         failedtasks = self.helper.failed_tasks
         runningpids = self.helper.running_pids
-        currenttime = time.time()
+        currenttime = time.monotonic()
         if not self.lasttime or (currenttime - self.lasttime > 5):
             self.helper.needUpdate = True
             self.lasttime = currenttime
diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
index 82913e0d..5524f8d6 100644
--- a/lib/bb/ui/uihelper.py
+++ b/lib/bb/ui/uihelper.py
@@ -32,9 +32,9 @@ class BBUIHelper:
         if isinstance(event, bb.build.TaskStarted):
             tid = event._fn + ":" + event._task
             if event._mc != "default":
-                self.running_tasks[tid] = { 'title' : "mc:%s:%s %s" % (event._mc, event._package, event._task), 'starttime' : time.time(), 'pid' : event.pid }
+                self.running_tasks[tid] = { 'title' : "mc:%s:%s %s" % (event._mc, event._package, event._task), 'starttime' : time.monotonic(), 'pid' : event.pid }
             else:
-                self.running_tasks[tid] = { 'title' : "%s %s" % (event._package, event._task), 'starttime' : time.time(), 'pid' : event.pid }
+                self.running_tasks[tid] = { 'title' : "%s %s" % (event._package, event._task), 'starttime' : time.monotonic(), 'pid' : event.pid }
             self.running_pids.append(tid)
             self.pidmap[event.pid] = tid
             self.needUpdate = True
-- 
2.37.2


