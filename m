Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 47D2A7830A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Jul 2017 11:03:16 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6VB3GlJ005688
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Mon, 31 Jul 2017 12:03:17 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dc8Tk-0005Co-3a; Mon, 31 Jul 2017 12:03:16 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Jul 2017 12:03:15 +0100
Message-Id: <1501498995-19972-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Mon, 31 Jul 2017 12:03:17 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] daemonize: Ensure child process exits safely
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
X-List-Received-Date: Mon, 31 Jul 2017 11:03:17 -0000

When we create the child, if an exception occurred it was transfering
back into the parent context. We don't want to do that us use a try/finally
to ensure we exit.

We need to ensure a traceback is printed and any queued UI messages which
may not have made it to the client UI at this point.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/daemonize.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/bb/daemonize.py b/lib/bb/daemonize.py
index 8380828..a4664ad 100644
--- a/lib/bb/daemonize.py
+++ b/lib/bb/daemonize.py
@@ -30,6 +30,7 @@ __version__ = "0.2"
 import os                    # Miscellaneous OS interfaces.
 import sys                   # System-specific parameters and functions.
 import io
+import traceback
 
 # Default daemon parameters.
 # File mode creation mask of the daemon.
@@ -192,6 +193,10 @@ def createDaemon(function, logfile):
         sys.stdout = open(logfile, 'a+')
         sys.stderr = sys.stdout
 
-    function()
-
-    os._exit(0)
+    try:
+        function()
+    except Exception as e:
+        traceback.print_exc()
+        bb.event.print_ui_queue()
+    finally:
+        os._exit(0)
-- 
2.7.4


