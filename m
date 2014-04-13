Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 06DA765EC2
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 Apr 2014 10:45:20 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s3DAjGHr008034 for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 Apr 2014 11:45:16 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SQ2H3PH01CIj for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 Apr 2014 11:45:16 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s3DAj9xT008019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 Apr 2014 11:45:13 +0100
Message-ID: <1397385903.15843.46.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 13 Apr 2014 11:45:03 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Fix task weighting algorithm
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
X-List-Received-Date: Sun, 13 Apr 2014 10:45:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When looking at a list of tasks, do_patch and do_unpack were being
given equal priority when one clearly depends on another. The
reason for this was the default task weights of 0 being to tasks.
This is therefore changed to 1 to allow correct weighting of dependencies
which means the scheduler has better information available to it about
tasks.

Weight endpoints differently (10) for clearer debugging of priorities.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 274ccf2..6ca693d 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -370,11 +370,11 @@ class RunQueueData:
 
         for listid in xrange(numTasks):
             task_done.append(False)
-            weight.append(0)
+            weight.append(1)
             deps_left.append(len(self.runq_revdeps[listid]))
 
         for listid in endpoints:
-            weight[listid] = 1
+            weight[listid] = 10
             task_done[listid] = True
 
         while True:



