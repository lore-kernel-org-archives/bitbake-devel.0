Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8E10D60797
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Feb 2018 21:48:33 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w1RLmX6u013078
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 27 Feb 2018 21:48:34 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1eqn6u-0006X4-WC; Tue, 27 Feb 2018 21:48:32 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Feb 2018 21:48:32 +0000
Message-Id: <1519768112-25072-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: clamav-milter 0.99.3 at dan
X-Virus-Status: Clean
Subject: [PATCH] runqueue: Ensure only recursive task dependencies are pruned
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
X-List-Received-Date: Tue, 27 Feb 2018 21:48:35 -0000

If a standalone tasks adds a dependency on X:do_build, the code in runqueue would
currently remove it if that do_build was part of an image recipe which uses
recrdeptask on do_build.

Such individual tasks shouldn't do this, therefore tweak the recursive reference code
to only process recurseive tasks, not all tasks.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 48df013..f2e52cf 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -765,7 +765,7 @@ class RunQueueData:
             bb.debug(1, "Added %s recursive dependencies in this loop" % extradeps)
 
         # Remove recrdeptask circular references so that do_a[recrdeptask] = "do_a do_b" can work
-        for tid in self.runtaskentries:
+        for tid in recursivetasksselfref:
             self.runtaskentries[tid].depends.difference_update(recursivetasksselfref)
 
         self.init_progress_reporter.next_stage()
-- 
2.7.4


