Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Su7Fi-0000Uf-DV for bitbake-devel@lists.openembedded.org;
	Wed, 25 Jul 2012 21:28:10 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6PJGfVR014129
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2012 20:16:41 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12223-10 for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2012 20:16:37 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6PJGXRD014123
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2012 20:16:34 +0100
Message-ID: <1343243793.27838.15.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 25 Jul 2012 20:16:33 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] runqueue.py: Gracefully exit if an exception occurs in the runqueue execution code
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
X-List-Received-Date: Wed, 25 Jul 2012 19:28:10 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

There was a bug where an exception in the runqueue code would cause an infinite loop
of debug messages. The exception would get reported but would loop since runqueue was
still registered as an idle handler.

This patch adds an exception handler to ensure in the case of errors, the system
more gracefully shuts down and doesn't loop.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 306ae79..2925741 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -862,7 +862,7 @@ class RunQueue:
             cache[task] = iscurrent
         return iscurrent
 
-    def execute_runqueue(self):
+    def _execute_runqueue(self):
         """
         Run the tasks in a queue prepared by rqdata.prepare()
         Upon failure, optionally try to recover the build using any alternate providers
@@ -926,6 +926,14 @@ class RunQueue:
         # Loop
         return retval
 
+    def execute_runqueue(self):
+        try:
+            return self._execute_runqueue()
+        except:
+            logger.error("An uncaught exception occured in runqueue, please see the failure below:")
+            self.state = runQueueComplete
+            raise
+
     def finish_runqueue(self, now = False):
         if not self.rqexe:
             return




