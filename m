Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail.openembedded.org (Postfix) with ESMTP id A42B26C123
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Nov 2018 12:17:17 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id z18so2026956wmc.4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Nov 2018 04:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=GqBfUJsCDqGrTcsJRO6zW7PiafoXgODRcpjHzK/61Mk=;
	b=aTUWwShA5e0WCupt9QBenJrFW7zZ5HU4FPSZvgGTpHbAUijh5vJvIbgS8fJojhvbXu
	OGC629BOHKTLsORgMeSkLim6A7NsdE+d4Ibs7rRxxKiCmdgUDwfKi5AiOixHOJemDLCS
	EYAjTrKQhsCEBeqZ1PfACIJWHeK2cVPZM3cDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=GqBfUJsCDqGrTcsJRO6zW7PiafoXgODRcpjHzK/61Mk=;
	b=tvmm9MZ/FE6VNmufb7sclE0CKYri7lx/6mYmPOnlsF57ofvjDcmL4Vz622dUuKx8Wt
	lRJmxvRe/lNz4N1mauJnzngulS+QuH7oZxKm2ja+QiuuMorNwIyOpz8wOZiUB7HU6iOh
	jcAm/mQWhCJMjiGTwbfZ4nMQVcLLy0T/9xazrxffGUG4DYp3FjfrznvWLeOsgyH1DMKj
	7OLXxprw6hee9DZqf+mjGS6fnSEAo/J57oBViz/f2+j4Eyai24ws38znYMe90QTZrfff
	YbhvBYqJeXfzphUZfjxCStdF+27U1SACFB5APV7LSZAur4Eq3VVSdrBRjXta1Ero/fQQ
	nc1Q==
X-Gm-Message-State: AA+aEWZnTBsgsrQS6h7neWgyqTF1VWLX1zqhyl86Y2Nv0aJM6VFsVLYm
	BXgO3NZD11KdPsPTPu18+aMuV0TphWY=
X-Google-Smtp-Source: AFSGD/WWJzr9VkG4EDCw8awp6kspG/wIRJ8rDX2PCOh9/A/IFedxupjNSLGjp4WjW1OLRxt8gc9Q6A==
X-Received: by 2002:a1c:5892:: with SMTP id m140mr1557451wmb.60.1543493838038; 
	Thu, 29 Nov 2018 04:17:18 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p74sm3387588wmd.29.2018.11.29.04.17.17
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 29 Nov 2018 04:17:17 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Nov 2018 12:17:16 +0000
Message-Id: <20181129121716.8236-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Subject: [PATCH] runqueue: Ensure disk monitor is started when no setscene tasks are run
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
X-List-Received-Date: Thu, 29 Nov 2018 12:17:17 -0000
Content-Transfer-Encoding: 8bit

Currently if there are no setscene tasks, the disk monitor isn't started.

Move the startup code to somewhere to ensure it always is started. This
issue would partially explain occasional selftest failures.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 9ce06c4085..4d5d876797 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1409,6 +1409,12 @@ class RunQueue:
                 bb.event.fire(bb.event.DepTreeGenerated(depgraph), self.cooker.data)
 
         if self.state is runQueueSceneInit:
+            if not self.dm_event_handler_registered:
+                 res = bb.event.register(self.dm_event_handler_name,
+                                         lambda x: self.dm.check(self) if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp] else False,
+                                         ('bb.event.HeartbeatEvent',))
+                 self.dm_event_handler_registered = True
+
             dump = self.cooker.configuration.dump_signatures
             if dump:
                 self.rqdata.init_progress_reporter.finish()
@@ -1425,11 +1431,6 @@ class RunQueue:
                 self.rqexe = RunQueueExecuteScenequeue(self)
 
         if self.state is runQueueSceneRun:
-            if not self.dm_event_handler_registered:
-                 res = bb.event.register(self.dm_event_handler_name,
-                                         lambda x: self.dm.check(self) if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp] else False,
-                                         ('bb.event.HeartbeatEvent',))
-                 self.dm_event_handler_registered = True
             retval = self.rqexe.execute()
 
         if self.state is runQueueRunInit:
-- 
2.19.1


