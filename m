Return-Path: <petter@technux.se>
Received: from vsp-authed-02-02.binero.net (vsp-authed02.binero.net
	[195.74.38.226])
	by mail.openembedded.org (Postfix) with SMTP id 7582360958
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jul 2013 09:19:44 +0000 (UTC)
Received: from smtp01.binero.se (unknown [195.74.38.28])
	by vsp-authed-02-02.binero.net (Halon Mail Gateway) with ESMTP;
	Mon, 29 Jul 2013 11:19:35 +0200 (CEST)
Received: from eldbvzzwp1-7x.lan (90-224-44-236-no67.tbcn.telia.com
	[90.224.44.236]) (Authenticated sender: petter@technux.se)
	by smtp-06-01.atm.binero.net (Postfix) with ESMTPSA id 7EE553A10F;
	Mon, 29 Jul 2013 11:19:35 +0200 (CEST)
From: =?UTF-8?q?Petter=20Mab=C3=A4cker?= <petter@technux.se>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Jul 2013 11:19:31 +0200
Message-Id: <c8e2317302a86e93bdbe8746b02f0a42be91abcf.1375088734.git.petter@technux.se>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1375088734.git.petter@technux.se>
References: <cover.1375088734.git.petter@technux.se>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake: runqueue: add warning in invalidate task
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 29 Jul 2013 09:19:45 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a warning if 'bitbake -C' is executed with a task that does not
exist.

Fixes [YOCTO #4877]

Signed-off-by: Petter Mabäcker <petter@technux.se>
---
 bitbake/lib/bb/runqueue.py |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index fce08ee..539e9af 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -720,6 +720,9 @@ class RunQueueData:
 
         def invalidate_task(fn, taskname, error_nostamp):
             taskdep = self.dataCache.task_deps[fn]
+            fnid = self.taskData.getfn_id(fn)
+            if taskname not in taskData.tasks_lookup[fnid]:
+                logger.warn("Task %s does not exist, invalidate this task will have no effect" % taskname)
             if 'nostamp' in taskdep and taskname in taskdep['nostamp']:
                 if error_nostamp:
                     bb.fatal("Task %s is marked nostamp, cannot invalidate this task" % taskname)
-- 
1.7.9.5


