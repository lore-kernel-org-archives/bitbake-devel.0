Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C9A1177EF7
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jul 2017 13:59:51 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v67Dxo4l002968
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 7 Jul 2017 14:59:51 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dTTnS-0007Ta-TG; Fri, 07 Jul 2017 14:59:50 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Jul 2017 14:59:49 +0100
Message-Id: <1499435989-28699-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Fri, 07 Jul 2017 14:59:52 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] server/process: Fix waitEvent() calls with 0 timeout
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
X-List-Received-Date: Fri, 07 Jul 2017 13:59:52 -0000

You might think Queue.Queue.get(True, 0) would return an event immediately
if present and otherwise return. It doesn't, it immediately "times out"
and returns with nothing from the queue.

The behaviour we want is not to wait but return anything present which is
what .get(False) does so map to this.

This fixes some odd behaviour observed in some of the tinfoil selftests.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index c3c1450..9ca2b69 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -253,6 +253,8 @@ class ProcessEventQueue(multiprocessing.queues.Queue):
         try:
             if not self.server.is_alive():
                 return self.getEvent()
+            if timeout == 0:
+                return self.get(False)
             return self.get(True, timeout)
         except Empty:
             return None
-- 
2.7.4


