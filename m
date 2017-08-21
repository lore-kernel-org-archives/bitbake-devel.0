Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id E664C6E660
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Aug 2017 20:29:54 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v7LKTrT7000835
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Mon, 21 Aug 2017 21:29:54 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1djtKb-0005VP-7b; Mon, 21 Aug 2017 21:29:53 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 Aug 2017 21:29:52 +0100
Message-Id: <1503347392-21125-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Mon, 21 Aug 2017 21:29:54 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] process: Ensure we call select() to know which fds to read
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
X-List-Received-Date: Mon, 21 Aug 2017 20:29:55 -0000

There is an interesting bug in the current code where a sync command
is not seen until the current async command completes, by which time
the UI may have shut down.

The reason is that if there are idle commands, we may not end up sleeping
in the select call at all, partiularly under heavy load like parsing.

Fix this by calling select with a zero timeout so that we see active
fds and know to read from them. This fixes various problems toaster was
having with the recent server changes.

[YOCTO #11898]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 2ebfdfc..3ab793c 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -312,7 +312,7 @@ class ProcessServer(multiprocessing.Process):
                 # Ignore EINTR
                 return []
         else:
-            return []
+            return select.select(fds,[],[],0)[0]
 
 
 class ServerCommunicator():
-- 
2.7.4


