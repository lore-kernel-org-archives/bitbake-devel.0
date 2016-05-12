Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id CFDEA601D3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 23:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4CNMsIl007786 for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 May 2016 00:22:54 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id m_J-UuDf4ebK for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 May 2016 00:22:54 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4CNMpFB007781
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 May 2016 00:22:52 +0100
Message-ID: <1463095371.9746.62.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 13 May 2016 00:22:51 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] server/process: Fix missing log messages on server exception
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
X-List-Received-Date: Thu, 12 May 2016 23:22:55 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently if the server dies, its possible that log messages are never
displayed which is particularly problematic if one of those messages
is the exception and backtrace the server died with.

Rather than having the event queue exit as soon as the server disappears,
we should pop events from the queue until its empty before exiting.

This patch tweaks that code so that even if the server is dead and we're
going to exit, we return any events left in the pipe. This makes
debugging certain failures much easier.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index 76011e9..982fcf7 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -222,11 +222,10 @@ class ProcessEventQueue(multiprocessing.queues.Queue):
 
     def waitEvent(self, timeout):
         if self.exit:
-            sys.exit(1)
+            return self.getEvent()
         try:
             if not self.server.is_alive():
-                self.setexit()
-                return None
+                return self.getEvent()
             return self.get(True, timeout)
         except Empty:
             return None
@@ -235,9 +234,10 @@ class ProcessEventQueue(multiprocessing.queues.Queue):
         try:
             if not self.server.is_alive():
                 self.setexit()
-                return None
             return self.get(False)
         except Empty:
+            if self.exit:
+                sys.exit(1)
             return None
 
 



