Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SSGVT-0000xQ-Cl
	for bitbake-devel@lists.openembedded.org;
	Thu, 10 May 2012 01:41:21 +0200
Received: by obhx4 with SMTP id x4so1075309obh.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 May 2012 16:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=vZRw7ekY2ZDlhCusM72lQhiMnQLwlj+GomlEGDDTOmo=;
	b=de27iizCcZtEirura/oHVhBDxStnru+Vgrx5F6PrRAMuy6ev310WRWOcqb2PpPg7/5
	qnXg1dw3V5m63lv2P6uIUTEUDMhp/Vsqx2c7/es/ALypSK+rdRTwj9sFyHljWx+wxJJX
	1DUAWM/atWHmx2cJVX+QtiQoFel8bZJwHWy92HaAc3hhK/Q6cqt2C7q1R4roiJt7z1Re
	7wL2HQhiu4B02wG7wYTO5HgdBsO6CwaIMoknwzZW2NU04ca1MCqEsJWbR4IBx2wvfwAp
	XVXO/VMFZhc2GzyMmTEQafkteoNhQpORPcV1inHThVNKC2tdpmrjw2fPAMaUooP+AYAU
	dq4Q==
Received: by 10.182.119.33 with SMTP id kr1mr2780181obb.60.1336606282962;
	Wed, 09 May 2012 16:31:22 -0700 (PDT)
Received: from localhost.localdomain (nat-lmt.mentorg.com. [139.181.28.34])
	by mx.google.com with ESMTPS id n9sm3512975oen.2.2012.05.09.16.31.21
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 09 May 2012 16:31:21 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 May 2012 18:32:20 -0500
Message-Id: <1336606340-31244-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 1.7.7
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH] runqueue: handle task exit due to signal/stop
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 09 May 2012 23:41:21 -0000

From: Christopher Larson <chris_larson@mentor.com>

- for a normal exit, use WEXITSTATUS, rather than manually shifting
- for exit via signal, set the exit code to 128+N, per shell convention
- if a process was stopped, return and don't handle it, as the process can yet
  be continued

This should fix the case where bitbake says a task failed with an exit code of
0 (we assumed failure based on the overall status, but didn't pass all the
information along to task_fail).

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/runqueue.py |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index b870caf..8828e4a 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1046,18 +1046,29 @@ class RunQueueExecute:
         Return none is there are no processes awaiting result collection, otherwise
         collect the process exit codes and close the information pipe.
         """
-        result = os.waitpid(-1, os.WNOHANG)
-        if result[0] == 0 and result[1] == 0:
+        pid, status = os.waitpid(-1, os.WNOHANG)
+        if pid == 0 or os.WIFSTOPPED(status):
             return None
-        task = self.build_pids[result[0]]
-        del self.build_pids[result[0]]
-        self.build_pipes[result[0]].close()
-        del self.build_pipes[result[0]]
-        # self.build_stamps[result[0]] may not exist when use shared work directory.
-        if result[0] in self.build_stamps.keys():
-            del self.build_stamps[result[0]]
-        if result[1] != 0:
-            self.task_fail(task, result[1]>>8)
+
+        if os.WIFEXITED(status):
+            status = os.WEXITSTATUS(status)
+        elif os.WIFSIGNALED(status):
+            # Per shell conventions for $?, when a process exits due to
+            # a signal, we return an exit code of 128 + SIGNUM
+            status = 128 + os.WTERMSIG(status)
+
+        task = self.build_pids[pid]
+        del self.build_pids[pid]
+
+        self.build_pipes[pid].close()
+        del self.build_pipes[pid]
+
+        # self.build_stamps[pid] may not exist when use shared work directory.
+        if pid in self.build_stamps.keys():
+            del self.build_stamps[pid]
+
+        if status != 0:
+            self.task_fail(task, status)
         else:
             self.task_complete(task)
         return True
-- 
1.7.7



