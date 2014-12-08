Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D3EAF71F47
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Dec 2014 16:38:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sB8GbpJj005097
	for <bitbake-devel@lists.openembedded.org>; Mon, 8 Dec 2014 16:37:51 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qySNTMRPAn97 for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Dec 2014 16:37:51 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sB8Gbb1g005094
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 8 Dec 2014 16:37:48 GMT
Message-ID: <1418056694.22903.21.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 08 Dec 2014 16:38:14 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Fix 100% cpu use after keyboard interrupt
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
X-List-Received-Date: Mon, 08 Dec 2014 16:38:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

After Ctrl+C is pressed to interrupt bitbake, it loops continually, running
at 100% cpu. This patch selects on the correct file descriptors resolving
the excess cpu usage.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index a4d86ef..a6da72b 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1078,7 +1078,7 @@ class RunQueue:
             retval = self.rqexe.execute()
 
         if self.state is runQueueCleanUp:
-           self.rqexe.finish()
+            retval = self.rqexe.finish()
 
         if (self.state is runQueueComplete or self.state is runQueueFailed) and self.rqexe:
             self.teardown_workers()
@@ -1320,15 +1320,14 @@ class RunQueueExecute:
         if self.stats.active > 0:
             bb.event.fire(runQueueExitWait(self.stats.active), self.cfgData)
             self.rq.read_workers()
-
-            return
+            return self.rq.active_fds()
 
         if len(self.failed_fnids) != 0:
             self.rq.state = runQueueFailed
-            return
+            return True
 
         self.rq.state = runQueueComplete
-        return
+        return True
 
     def check_dependencies(self, task, taskdeps, setscene = False):
         if not self.rq.depvalidate:



