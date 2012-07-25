Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Su7HC-0000X0-RU for bitbake-devel@lists.openembedded.org;
	Wed, 25 Jul 2012 21:29:43 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6PJIDpb014153
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2012 20:18:13 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14132-01 for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2012 20:18:08 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6PJHx6w014147
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2012 20:18:07 +0100
Message-ID: <1343243878.27838.17.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 25 Jul 2012 20:17:58 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] runqueue.py: Ensure one setscene function doesn't mask out another which needs to run
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
X-List-Received-Date: Wed, 25 Jul 2012 19:29:43 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The scenequeue code could result in one setscene function masking out another
which had been marked as notcovered. This change ensures the notcovered list
is taken into account when deciding which tasks need to be run, ensuring
that tasks that should be run do get run.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index fd33d07..a4009d4 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1178,7 +1178,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 self.runq_buildable.append(1)
             else:
                 self.runq_buildable.append(0)
-            if len(self.rqdata.runq_revdeps[task]) > 0 and self.rqdata.runq_revdeps[task].issubset(self.rq.scenequeue_covered):
+            if len(self.rqdata.runq_revdeps[task]) > 0 and self.rqdata.runq_revdeps[task].issubset(self.rq.scenequeue_covered) and task not in self.rq.scenequeue_notcovered:
                 self.rq.scenequeue_covered.add(task)
 
         found = True
@@ -1189,7 +1189,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                     continue
                 logger.debug(1, 'Considering %s (%s): %s' % (task, self.rqdata.get_user_idstring(task), str(self.rqdata.runq_revdeps[task])))
 
-                if len(self.rqdata.runq_revdeps[task]) > 0 and self.rqdata.runq_revdeps[task].issubset(self.rq.scenequeue_covered):
+                if len(self.rqdata.runq_revdeps[task]) > 0 and self.rqdata.runq_revdeps[task].issubset(self.rq.scenequeue_covered) and task not in self.rq.scenequeue_notcovered:
                     ok = True
                     for revdep in self.rqdata.runq_revdeps[task]:
                         if self.rqdata.runq_fnid[task] != self.rqdata.runq_fnid[revdep]:
@@ -1646,6 +1646,9 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         self.rq.scenequeue_covered = set()
         for task in oldcovered:
             self.rq.scenequeue_covered.add(self.rqdata.runq_setscene[task])
+        self.rq.scenequeue_notcovered = set()
+        for task in self.scenequeue_notcovered:
+            self.rq.scenequeue_notcovered.add(self.rqdata.runq_setscene[task])
 
         logger.debug(1, 'We can skip tasks %s', sorted(self.rq.scenequeue_covered))
 




