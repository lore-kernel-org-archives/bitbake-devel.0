Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T2NAx-00077y-QO for bitbake-devel@lists.openembedded.org;
	Fri, 17 Aug 2012 16:05:24 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7HDrQQa009147
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Aug 2012 14:53:26 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 07637-09 for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Aug 2012 14:53:22 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7HDrHLD009140
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Aug 2012 14:53:18 +0100
Message-ID: <1345211596.27428.6.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 17 Aug 2012 14:53:16 +0100
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] build.py: Correct package to recipe in TaskBase events to use consistent terminology
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
X-List-Received-Date: Fri, 17 Aug 2012 14:05:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index b484d19..82d22f7 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -72,7 +72,7 @@ class TaskBase(event.Event):
         self._task = t
         self._package = d.getVar("PF", True)
         event.Event.__init__(self)
-        self._message = "package %s: task %s: %s" % (d.getVar("PF", True), t, self.getDisplayName())
+        self._message = "recipe %s: task %s: %s" % (d.getVar("PF", True), t, self.getDisplayName())
 
     def getTask(self):
         return self._task
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 304ba29..b01daee 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -94,7 +94,7 @@ class InteractConsoleLogFilter(logging.Filter):
         self.format = format
 
     def filter(self, record):
-        if record.levelno == self.format.NOTE and (record.msg.startswith("Running") or record.msg.startswith("package ")):
+        if record.levelno == self.format.NOTE and (record.msg.startswith("Running") or record.msg.startswith("recipe ")):
             return False
         self.tf.clearFooter()
         return True




