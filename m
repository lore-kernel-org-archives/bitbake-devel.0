Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4CE5778327
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 30 Jul 2017 15:18:13 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6UFICqu022575
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Sun, 30 Jul 2017 16:18:13 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dbpyt-0001Xc-W9; Sun, 30 Jul 2017 16:18:11 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 30 Jul 2017 16:18:09 +0100
Message-Id: <1501427889-5886-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Sun, 30 Jul 2017 16:18:13 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] runqueue: Tweak debug message to make it more readable/diffable
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
X-List-Received-Date: Sun, 30 Jul 2017 15:18:14 -0000

Having this as one huge long line isn't easy to manipulate, split it into
multiple lines for ease of debugging issues.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 7dd964d..e1a15af 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2372,7 +2372,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         self.rq.scenequeue_covered = self.scenequeue_covered
         self.rq.scenequeue_notcovered = self.scenequeue_notcovered
 
-        logger.debug(1, 'We can skip tasks %s', sorted(self.rq.scenequeue_covered))
+        logger.debug(1, 'We can skip tasks %s', "\n".join(sorted(self.rq.scenequeue_covered)))
 
         self.rq.state = runQueueRunInit
 
-- 
2.7.4


