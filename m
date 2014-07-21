Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 94A8870534
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jul 2014 08:36:07 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s6L8Z4lD028222 for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jul 2014 09:36:03 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id h6_f7jkV5yPQ for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jul 2014 09:36:02 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s6L8ZwHE028240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jul 2014 09:36:00 +0100
Message-ID: <1405931753.22985.93.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 21 Jul 2014 09:35:53 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] command/runqueue: Fix shutdown logic
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
X-List-Received-Date: Mon, 21 Jul 2014 08:36:10 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If you hit Ctrl+C at the right point, the system processes the request
but merrily continues building. It turns out finish_runqueue() is called
but this doesn't stop the later generation and execution of the
runqueue.

This patch adjusts some of the conditionals to ensure the build really
does stop.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 84fcdf9..d797fcf 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -86,7 +86,7 @@ class Command:
 
     def runAsyncCommand(self):
         try:
-            if self.cooker.state == bb.cooker.state.error:
+            if self.cooker.state in (bb.cooker.state.error, bb.cooker.state.shutdown, bb.cooker.state.forceshutdown):
                 return False
             if self.currentAsyncCommand is not None:
                 (command, options) = self.currentAsyncCommand
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 4ea4970..f68a11d 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1065,7 +1065,7 @@ class RunQueue:
         if self.state is runQueueCleanUp:
            self.rqexe.finish()
 
-        if self.state is runQueueComplete or self.state is runQueueFailed:
+        if (self.state is runQueueComplete or self.state is runQueueFailed) and self.rqexe:
             self.teardown_workers()
             if self.rqexe.stats.failed:
                 logger.info("Tasks Summary: Attempted %d tasks of which %d didn't need to be rerun and %d failed.", self.rqexe.stats.completed + self.rqexe.stats.failed, self.rqexe.stats.skipped, self.rqexe.stats.failed)
@@ -1106,6 +1106,7 @@ class RunQueue:
 
     def finish_runqueue(self, now = False):
         if not self.rqexe:
+            self.state = runQueueComplete
             return
 
         if now:
-- 
cgit v0.10.1




