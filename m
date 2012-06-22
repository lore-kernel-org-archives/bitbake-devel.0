Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Si2av-0000Ud-4j for bitbake-devel@lists.openembedded.org;
	Fri, 22 Jun 2012 14:04:09 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5MBrMDI001128
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jun 2012 12:53:22 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 27315-10 for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jun 2012 12:53:18 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5MBrEYB001122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jun 2012 12:53:15 +0100
Message-ID: <1340365996.394.15.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 22 Jun 2012 12:53:16 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] utils.py: Add function to set nonblocking operation on a file descriptor
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 22 Jun 2012 12:04:09 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 1d9bdf0..03766ad 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1736,7 +1736,7 @@ class runQueuePipe():
     def __init__(self, pipein, pipeout, d):
         self.input = pipein
         pipeout.close()
-        fcntl.fcntl(self.input, fcntl.F_SETFL, fcntl.fcntl(self.input, fcntl.F_GETFL) | os.O_NONBLOCK)
+        bb.utils.nonblockingfd(self.input)
         self.queue = ""
         self.d = d
 
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index fc389a3..77ad39e 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -26,6 +26,7 @@ import logging
 import bb
 import bb.msg
 import multiprocessing
+import fcntl
 from commands import getstatusoutput
 from contextlib import contextmanager
 
@@ -754,3 +755,7 @@ def contains(variable, checkvalues, truevalue, falsevalue, d):
 
 def cpu_count():
     return multiprocessing.cpu_count()
+
+def nonblockingfd(fd):
+    fcntl.fcntl(fd, fcntl.F_SETFL, fcntl.fcntl(fd, fcntl.F_GETFL) | os.O_NONBLOCK)
+




