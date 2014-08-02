Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id CE97165F37
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  2 Aug 2014 08:51:04 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s728p5S3013357 for <bitbake-devel@lists.openembedded.org>;
	Sat, 2 Aug 2014 09:51:05 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5SfIADsc0o8l for <bitbake-devel@lists.openembedded.org>;
	Sat,  2 Aug 2014 09:51:05 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s728p0B5013125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 2 Aug 2014 09:51:02 +0100
Message-ID: <1406969460.6981.18.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 02 Aug 2014 09:51:00 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: runqueue: Add sceneQueueComplete event
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
X-List-Received-Date: Sat, 02 Aug 2014 08:51:05 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Its useful to have an event emitted when all of the sceneQueue tasks
have completed since the metadata can hook this for processing.
Therefore add such an event.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index f68a11d..baaac44 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1985,6 +1985,10 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         logger.debug(1, 'We can skip tasks %s', sorted(self.rq.scenequeue_covered))
 
         self.rq.state = runQueueRunInit
+
+        completeevent = sceneQueueComplete(self.stats, self.rq)
+        bb.event.fire(completeevent, self.cfgData)
+
         return True
 
     def runqueue_process_waitpid(self, task, status):
@@ -2067,6 +2071,14 @@ class sceneQueueTaskFailed(sceneQueueEvent):
         sceneQueueEvent.__init__(self, task, stats, rq)
         self.exitcode = exitcode
 
+class sceneQueueComplete(sceneQueueEvent):
+    """
+    Event when all the sceneQueue tasks are complete
+    """
+    def __init__(self, stats, rq):
+        self.stats = stats.copy()
+        bb.event.Event.__init__(self)
+
 class runQueueTaskCompleted(runQueueEvent):
     """
     Event notifing a task completed



