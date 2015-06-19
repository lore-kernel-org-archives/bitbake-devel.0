Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id AE2AA758DC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Jun 2015 11:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t5JBS2LB015417; Fri, 19 Jun 2015 12:28:02 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cBwVzSIiiPSu; Fri, 19 Jun 2015 12:28:02 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t5JBRkdZ015412
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 19 Jun 2015 12:27:57 +0100
Message-ID: <1434713266.14710.118.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 19 Jun 2015 12:27:46 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: Tomas Frydrych <tf@tthef.net>
Subject: [PATCH] runqueue: Sanity check BB_NUMBER_THREADS
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
X-List-Received-Date: Fri, 19 Jun 2015 11:28:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Bitbake does really weird things with negative or zero numbers of threads
which is confusing to the user. Add a sanity check for this.

When you have code doing arithmetic on the values and a VM reconfigures
to only a single thread, negative numbers are easier than you'd think.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index a5ae42b..3f62453 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1333,6 +1333,9 @@ class RunQueueExecute:
         if rq.fakeworkerpipe:
             rq.fakeworkerpipe.setrunqueueexec(self)
 
+        if self.number_tasks <= 0:
+             bb.fatal("Invalid BB_NUMBER_THREADS %s" % self.number_tasks)
+
     def runqueue_process_waitpid(self, task, status):
 
         # self.build_stamps[pid] may not exist when use shared work directory.



