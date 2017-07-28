Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 00221784C5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jul 2017 14:55:32 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6SEtULG005836
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 28 Jul 2017 15:55:31 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1db6fq-0005bo-Qh; Fri, 28 Jul 2017 15:55:30 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Jul 2017 15:55:23 +0100
Message-Id: <1501253729-21511-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Fri, 28 Jul 2017 15:55:32 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 1/7] event: Don't write duplicate logs to stdout and stderr in no UI case
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
X-List-Received-Date: Fri, 28 Jul 2017 14:55:33 -0000

This code would duplicate messages to stdout and stderr when no UI connected
and there were error level messages.

Rework the code so it either uses stderr (for errors and above) or
stdout for warnings/debug but not both for the same messages.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/event.py | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 3827dcf..526c41f 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -149,23 +149,30 @@ def print_ui_queue():
 
         # First check to see if we have any proper messages
         msgprint = False
+        msgerrs = False
+
+        # Should we print to stderr?
+        for event in ui_queue[:]:
+            if isinstance(event, logging.LogRecord) and event.levelno >= logging.WARNING:
+                msgerrs = True
+                break
+
+        if msgerrs:
+            logger.addHandler(stderr)
+        else:
+            logger.addHandler(stdout)
+
         for event in ui_queue[:]:
             if isinstance(event, logging.LogRecord):
                 if event.levelno > logging.DEBUG:
-                    if event.levelno >= logging.WARNING:
-                        logger.addHandler(stderr)
-                    else:
-                        logger.addHandler(stdout)
                     logger.handle(event)
                     msgprint = True
-        if msgprint:
-            return
 
         # Nope, so just print all of the messages we have (including debug messages)
-        logger.addHandler(stdout)
-        for event in ui_queue[:]:
-            if isinstance(event, logging.LogRecord):
-                logger.handle(event)
+        if not msgprint:
+            for event in ui_queue[:]:
+                if isinstance(event, logging.LogRecord):
+                    logger.handle(event)
 
 def fire_ui_handlers(event, d):
     global _thread_lock
-- 
2.7.4


