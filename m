Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 395056FFFE
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jan 2016 18:05:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0II5Nj1000968; Mon, 18 Jan 2016 18:05:23 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vDEj3XcKXcuI; Mon, 18 Jan 2016 18:05:23 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0II5Ln9000958
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 18 Jan 2016 18:05:22 GMT
Message-ID: <1453140321.27999.85.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 18 Jan 2016 18:05:21 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: "Eggleton, Paul" <paul.eggleton@intel.com>
Subject: [PATCH] Revert "runqueue.py: Ensure one setscene function doesn't mask out another which needs to run"
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
X-List-Received-Date: Mon, 18 Jan 2016 18:05:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This reverts commit b22592af8145a8c7c4ada2fa7c1dee2e753eca46.

That commit isn't entirely clear about why this change is needed but
I do have a usecase where this breaks things. If for example you run
"bitbake X -c packagedata" and that packagedata is in sstate, you'd 
expect this to work. 

If sstate doesn't contain a do_populate_sysroot for a dependency, you
would still expect the command above to succeed and you would not
expect
it to rebuild that dependency. With the current code, this isn't what 
happens. The code finds the sstate for do_populate_sysroot missing, 
this makes the task "uncovered" and this in turn makes it unskippable.

The example I found with this was avahi-ui, where it would trigger 
a build of libdaemon to obtain its populate_sysroot.

Since this behaviour seems completely incorrect, revert the older patch
and we'll address any issues that crop up as a result.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index a647e7e..763952a 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1402,7 +1402,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 self.runq_buildable.append(1)
             else:
                 self.runq_buildable.append(0)
-            if len(self.rqdata.runq_revdeps[task]) > 0 and self.rqdata.runq_revdeps[task].issubset(self.rq.scenequeue_covered) and task not in self.rq.scenequeue_notcovered:
+            if len(self.rqdata.runq_revdeps[task]) > 0 and self.rqdata.runq_revdeps[task].issubset(self.rq.scenequeue_covered):
                 self.rq.scenequeue_covered.add(task)
 
         found = True
@@ -1413,7 +1413,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                     continue
                 logger.debug(1, 'Considering %s (%s): %s' % (task, self.rqdata.get_user_idstring(task), str(self.rqdata.runq_revdeps[task])))
 
-                if len(self.rqdata.runq_revdeps[task]) > 0 and self.rqdata.runq_revdeps[task].issubset(self.rq.scenequeue_covered) and task not in self.rq.scenequeue_notcovered:
+                if len(self.rqdata.runq_revdeps[task]) > 0 and self.rqdata.runq_revdeps[task].issubset(self.rq.scenequeue_covered):
                     found = True
                     self.rq.scenequeue_covered.add(task)
 
@@ -2055,9 +2055,6 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         self.rq.scenequeue_covered = set()
         for task in oldcovered:
             self.rq.scenequeue_covered.add(self.rqdata.runq_setscene[task])
-        self.rq.scenequeue_notcovered = set()
-        for task in self.scenequeue_notcovered:
-            self.rq.scenequeue_notcovered.add(self.rqdata.runq_setscene[task])
 
         logger.debug(1, 'We can skip tasks %s', sorted(self.rq.scenequeue_covered))
 



