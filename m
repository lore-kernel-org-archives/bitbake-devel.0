Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id DEE4960720
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Aug 2017 10:12:43 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v73ACfIq019321
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 3 Aug 2017 11:12:42 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1ddD7R-0006w4-Di; Thu, 03 Aug 2017 11:12:41 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  3 Aug 2017 11:12:40 +0100
Message-Id: <1501755160-26622-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Thu, 03 Aug 2017 11:12:42 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] daemonize: Always print any remaning UI events at exit
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
X-List-Received-Date: Thu, 03 Aug 2017 10:12:44 -0000

If there are events in the UI queue we want to print them regardless of
whether we're handling an exception or something like SystemExit.

This improves error messages for some other failure cases where currently
no logging would get printed and leave the user confused as to what went
wrong.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/daemonize.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/daemonize.py b/lib/bb/daemonize.py
index a5a9d86..8300d1d 100644
--- a/lib/bb/daemonize.py
+++ b/lib/bb/daemonize.py
@@ -77,6 +77,6 @@ def createDaemon(function, logfile):
         function()
     except Exception as e:
         traceback.print_exc()
-        bb.event.print_ui_queue()
     finally:
+        bb.event.print_ui_queue()
         os._exit(0)
-- 
2.7.4


