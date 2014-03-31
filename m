Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id D66CA6A8F0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 22:07:36 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2VM6meR030305 for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 23:07:31 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3PAdCaHtOaew for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 23:07:31 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2VM7P1C030321
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 23:07:27 +0100
Message-ID: <1396303640.14790.85.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 31 Mar 2014 23:07:20 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Fix sstate task dependency problems
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
X-List-Received-Date: Mon, 31 Mar 2014 22:07:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If a setscene task has [depends], its possible they may still get executed out
of order. The issue is that the dependencies are set to set() for all tasks
involved. This patch adds back in explict dependencies within these chains
to avoid the setscene task failures.

[YOCTO #6069]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 42b6c48..1a19677 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1757,6 +1757,10 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                     # Have to zero this to avoid circular dependencies
                     sq_revdeps_squash[self.rqdata.runq_setscene.index(taskid)] = set()
 
+        for task in self.sq_harddeps:
+             for dep in self.sq_harddeps[task]:
+                 sq_revdeps_squash[dep].add(task)
+
         #for task in xrange(len(sq_revdeps_squash)):
         #    realtask = self.rqdata.runq_setscene[task]
         #    bb.warn("Task %s: %s_setscene is %s " % (task, self.rqdata.get_user_idstring(realtask) , sq_revdeps_squash[task]))



