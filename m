Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 22525774B3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Dec 2016 17:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uBLH6YRO001647; Wed, 21 Dec 2016 17:06:35 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WBkAvuiMmK7e; Wed, 21 Dec 2016 17:06:35 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uBLH6Thj001593
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Dec 2016 17:06:30 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cJkLV-0006uV-GP; Wed, 21 Dec 2016 17:06:29 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Dec 2016 17:06:24 +0000
Message-Id: <1482339985-26495-6-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1482339985-26495-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1482339985-26495-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 6/7] runqueue: Only start fakeroot workers when needed
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
X-List-Received-Date: Wed, 21 Dec 2016 17:06:37 -0000

Fakeroot workers usually have dependencies that need to be ready before they
can be started. Starting them as a block therefore doesn't work as the
dependencies may or may not have been built. Therefore start the multiconfig
fakeworkers individually upon demand.

[YOCTO #10344]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index ef14347..48c6a79 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1068,10 +1068,9 @@ class RunQueue:
         for mc in self.rqdata.dataCaches:
             self.worker[mc] = self._start_worker(mc)
 
-    def start_fakeworker(self, rqexec):
-        if not self.fakeworker:
-            for mc in self.rqdata.dataCaches:
-                self.fakeworker[mc] = self._start_worker(mc, True, rqexec)
+    def start_fakeworker(self, rqexec, mc):
+        if not mc in self.fakeworker:
+            self.fakeworker[mc] = self._start_worker(mc, True, rqexec)
 
     def teardown_workers(self):
         self.teardown = True
@@ -1804,9 +1803,9 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not (self.cooker.configuration.dry_run or self.rqdata.setscene_enforce):
-                if not self.rq.fakeworker:
+                if not mc in self.rq.fakeworker:
                     try:
-                        self.rq.start_fakeworker(self)
+                        self.rq.start_fakeworker(self, mc)
                     except OSError as exc:
                         logger.critical("Failed to spawn fakeroot worker to run %s: %s" % (task, str(exc)))
                         self.rq.state = runQueueFailed
@@ -2221,8 +2220,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
 
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
-                if not self.rq.fakeworker:
-                    self.rq.start_fakeworker(self)
+                if not mc in self.rq.fakeworker:
+                    self.rq.start_fakeworker(self, mc)
                 self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
                 self.rq.fakeworker[mc].process.stdin.flush()
             else:
-- 
2.7.4


