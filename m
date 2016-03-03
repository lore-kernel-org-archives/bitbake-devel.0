Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f68.google.com (mail-pa0-f68.google.com
	[209.85.220.68])
	by mail.openembedded.org (Postfix) with ESMTP id C032876803
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Mar 2016 06:41:30 +0000 (UTC)
Received: by mail-pa0-f68.google.com with SMTP id hj7so776270pac.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Mar 2016 22:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=0sZvLLtF5oiWN5g1D+dTWYZeh6An9znuNa34KZ1xRck=;
	b=bpHyBWzKpaDodwVFI7obPftq7a7DydNvHCAVZT9FTgIwx4dbuWU/A7+qPW+pRwWZpC
	FrEhRHxOntGp0l7oBwEDQ1RpYtTcSb6jHFIndWwDVBXCZbFIsxC8t0ujEeEcDIOLq1/n
	xOjwHfVNEIdBHdEfPSd2BleWUb4fP6E1V3Qv4M6lRF6SLV5YWppRyD+9qHju9UgrPa7W
	R8o3N6T4nxO36VB60pLkCCYLDNYcvOSOFoK1RQ2MD85ZuxUGHOx+aETlSkqmW/rp6pZs
	8X3JKPUFtBWJxBJTsWsETKsbjTPhGg9quW3prdmX9FqX1hYBRkAY/WPHq3m5LU7GTmAR
	P3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=0sZvLLtF5oiWN5g1D+dTWYZeh6An9znuNa34KZ1xRck=;
	b=lMDa2Bfdu6U1+uE0+rG6qiYTA0EubV7VuwAWR8rONr0t4/UZFQpeWg46c3CKVsb1az
	cjmOcZmWqEEOfm55JYHR5ruEAYNbPJxRWdKT0gReiwzj7Y5JFFPE7Z6D5DpXvGtvawjq
	HaK5XkbaTxdrVZZzo2W7Y44eGWRYegT3QQDX0Fm8HymwH5ZaYgcd+LiMKoczt1tWaPT/
	NjpAk3IR5j6oWRBcRf6HivyRVnaFoj5OVNT1z8YQ95rbshSslnwdvn57etPsweJJhs+v
	O+roZaleEpdp9+qALrJLj1EmeLudgmH/RDu+tBt6W4d6OgzPy98USTvUAKqLwOcg3QUG
	cY1g==
X-Gm-Message-State: AD7BkJLINIrymPHrRYyvOBSxKutSHY9xlETE3EzNDXiraHwN4MyC6N1TFbF+XUUUavvi9A==
X-Received: by 10.67.6.10 with SMTP id cq10mr1445076pad.120.1456987291260;
	Wed, 02 Mar 2016 22:41:31 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	r62sm57476673pfr.26.2016.03.02.22.41.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Mar 2016 22:41:30 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Mar 2016 22:47:38 -0800
Message-Id: <05400d100e891245541e10b1d5db9a783004b20e.1456987460.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1456987460.git.avery.brian@gmail.com>
References: <cover.1456987460.git.avery.brian@gmail.com>
Subject: [PATCH 1/7] toasterui: reformat list of events
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
X-List-Received-Date: Thu, 03 Mar 2016 06:41:30 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Reformatted and reordered list of events to make changes
easily and see them clearly in the diffs.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/toasterui.py | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 32b1889..377526e 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -92,15 +92,33 @@ def _close_build_log(build_log):
         build_log.close()
         logger.removeHandler(build_log)
 
-_evt_list = [ "bb.runqueue.runQueueExitWait", "bb.event.LogExecTTY", "logging.LogRecord",
-              "bb.build.TaskFailed", "bb.build.TaskBase", "bb.event.ParseStarted",
-              "bb.event.ParseProgress", "bb.event.ParseCompleted", "bb.event.CacheLoadStarted",
-              "bb.event.CacheLoadProgress", "bb.event.CacheLoadCompleted", "bb.command.CommandFailed",
-              "bb.command.CommandExit", "bb.command.CommandCompleted",  "bb.cooker.CookerExit",
-              "bb.event.MultipleProviders", "bb.event.NoProvider", "bb.runqueue.sceneQueueTaskStarted",
-              "bb.runqueue.runQueueTaskStarted", "bb.runqueue.runQueueTaskFailed", "bb.runqueue.sceneQueueTaskFailed",
-              "bb.event.BuildBase", "bb.build.TaskStarted", "bb.build.TaskSucceeded", "bb.build.TaskFailedSilent",
-              "bb.event.MetadataEvent"]
+_evt_list = [
+    "bb.build.TaskBase",
+    "bb.build.TaskFailed",
+    "bb.build.TaskFailedSilent",
+    "bb.build.TaskStarted",
+    "bb.build.TaskSucceeded",
+    "bb.command.CommandCompleted",
+    "bb.command.CommandExit",
+    "bb.command.CommandFailed",
+    "bb.cooker.CookerExit",
+    "bb.event.BuildBase",
+    "bb.event.CacheLoadCompleted",
+    "bb.event.CacheLoadProgress",
+    "bb.event.CacheLoadStarted",
+    "bb.event.LogExecTTY",
+    "bb.event.MetadataEvent",
+    "bb.event.MultipleProviders",
+    "bb.event.NoProvider",
+    "bb.event.ParseCompleted",
+    "bb.event.ParseProgress",
+    "bb.event.ParseStarted",
+    "bb.runqueue.runQueueExitWait",
+    "bb.runqueue.runQueueTaskFailed",
+    "bb.runqueue.runQueueTaskStarted",
+    "bb.runqueue.sceneQueueTaskFailed",
+    "bb.runqueue.sceneQueueTaskStarted",
+    "logging.LogRecord"]
 
 def main(server, eventHandler, params):
     # set to a logging.FileHandler instance when a build starts;
-- 
1.9.1


