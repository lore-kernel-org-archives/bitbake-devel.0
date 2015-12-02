Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
	[209.85.220.43])
	by mail.openembedded.org (Postfix) with ESMTP id 6D71F612E5
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 18:00:03 +0000 (UTC)
Received: by padhx2 with SMTP id hx2so47147265pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 10:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=iMv3dCDI3B1vhGycAS+Tb0nclGHBMSTIyBj1lg+kfXo=;
	b=EFTgqD+n0YDu8w3LADNLu2+mA6bcSPDzqMKgs9j/mDm5yzRdtPlpu41go7KcsCRABs
	p3Q9aefzvEXAOmzlZipbc6GfJzgTYmkPGHzYXJGZmah4oLoIIKxXt6fxCsLGNWyY8r0T
	b6X8o4hHx21VbZDis/VHvWzl85I56kNO8dkN13j6hYUcERr3aW1BPIpbPE2MPpGI5Zmq
	4dqwckr6Jxh0sqnOWNGDuan8MjZv8zA2rQL9SBqhFVtoKwMQ3a3bfkitv9VCblxAMiW2
	bU8bp1Q9lfIUCdt07yJ0PlWCT8LvjHXv9SAS4WFQFh/VgmTa/OLLADVObXSNG1IUcfmW
	xC8w==
X-Received: by 10.66.55.72 with SMTP id q8mr6515259pap.136.1449079204161;
	Wed, 02 Dec 2015 10:00:04 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.10.00.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 10:00:03 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:03:01 -0800
Message-Id: <2c6b2b2a1047fc2daf756d8ab2da04de8481909d.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 29/30] bb/ui: ignore CommandStarted event
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
X-List-Received-Date: Wed, 02 Dec 2015 18:00:03 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Fixed 'Unknown event' warnings in knotty and runningbuild
for new event. The reason for them to appear despite of
setting filter mask in ui modules is that this event
is fired earlier than mask is set.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/crumbs/runningbuild.py | 3 ++-
 lib/bb/ui/knotty.py              | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/runningbuild.py b/lib/bb/ui/crumbs/runningbuild.py
index 16a955d..ba8a05c 100644
--- a/lib/bb/ui/crumbs/runningbuild.py
+++ b/lib/bb/ui/crumbs/runningbuild.py
@@ -433,7 +433,8 @@ class RunningBuild (gobject.GObject):
                                       bb.runqueue.runQueueExitWait,
                                       bb.event.OperationStarted,
                                       bb.event.OperationCompleted,
-                                      bb.event.OperationProgress)):
+                                      bb.event.OperationProgress,
+                                      bb.command.CommandStarted)):
                 self.emit("log", "error", "Unknown event: %s" % (event.error if hasattr(event, 'error') else 'error'))
 
         return
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 90c3183..9dfba35 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -499,7 +499,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                                   bb.event.OperationStarted,
                                   bb.event.OperationCompleted,
                                   bb.event.OperationProgress,
-                                  bb.event.DiskFull)):
+                                  bb.event.DiskFull,
+                                  bb.command.CommandStarted)):
                 continue
 
             logger.error("Unknown event: %s", event)
-- 
1.9.1


