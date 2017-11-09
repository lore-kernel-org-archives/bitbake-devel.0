Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 2C97B782DC
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Nov 2017 11:56:10 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	vA9Bu9Ue007646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 9 Nov 2017 11:56:10 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1eClRJ-00031p-Dl; Thu, 09 Nov 2017 11:56:09 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  9 Nov 2017 11:56:07 +0000
Message-Id: <1510228568-11602-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 1/2] event: Ensure we clean up loggers
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
X-List-Received-Date: Thu, 09 Nov 2017 11:56:10 -0000

Whilst we're likely exiting in this case, clean up the loggers we add
so that in the case of certain server retries there is no possibility
multiple loggers stack up.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/event.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 526c41f..52072b5 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -173,6 +173,10 @@ def print_ui_queue():
             for event in ui_queue[:]:
                 if isinstance(event, logging.LogRecord):
                     logger.handle(event)
+        if msgerrs:
+            logger.removeHandler(stderr)
+        else:
+            logger.removeHandler(stdout)
 
 def fire_ui_handlers(event, d):
     global _thread_lock
-- 
2.7.4


