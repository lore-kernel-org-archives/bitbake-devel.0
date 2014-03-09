Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id DC96C6F60F
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Mar 2014 17:01:37 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s29H1XQ8020215
	for <bitbake-devel@lists.openembedded.org>; Sun, 9 Mar 2014 17:01:33 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id BAkXN2Ip2o4H for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Mar 2014 17:01:33 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s29H1OMv020200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sun, 9 Mar 2014 17:01:29 GMT
Message-ID: <1394384479.7883.8.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 09 Mar 2014 10:01:19 -0700
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: runqueue.py: Gracefully handle a missing worker process
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
X-List-Received-Date: Sun, 09 Mar 2014 17:01:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If the worker has already gone missing (e.g. SIGTERM), we should
gracefully handle the write failures at exit time rather than throwing
ugly tracebacks.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 967e944..7d3e91a 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -900,8 +900,11 @@ class RunQueue:
         if not worker:
             return
         logger.debug(1, "Teardown for bitbake-worker")
-        worker.stdin.write("<quit></quit>")
-        worker.stdin.flush()
+        try:
+           worker.stdin.write("<quit></quit>")
+           worker.stdin.flush()
+        except IOError:
+           pass
         while worker.returncode is None:
             workerpipe.read()
             worker.poll()
@@ -1275,11 +1278,15 @@ class RunQueueExecute:
 
     def finish_now(self):
 
-        self.rq.worker.stdin.write("<finishnow></finishnow>")
-        self.rq.worker.stdin.flush()
-        if self.rq.fakeworker:
-            self.rq.fakeworker.stdin.write("<finishnow></finishnow>")
-            self.rq.fakeworker.stdin.flush()
+        for worker in [self.rq.worker, self.rq.fakeworker]:
+            if not worker:
+                continue
+            try:
+                worker.stdin.write("<finishnow></finishnow>")
+                worker.stdin.flush()
+            except IOError:
+                # worker must have died?
+                pass
 
         if len(self.failed_fnids) != 0:
             self.rq.state = runQueueFailed



