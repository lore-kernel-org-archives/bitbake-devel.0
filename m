Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RUIek-0004lS-2N for bitbake-devel@lists.openembedded.org;
	Sat, 26 Nov 2011 14:51:02 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAQDiQDe013448
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Nov 2011 13:44:26 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12340-05 for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Nov 2011 13:44:21 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAQDiIju013442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Nov 2011 13:44:20 GMT
Message-ID: <1322315065.25382.7.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 26 Nov 2011 13:44:25 +0000
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] ui/uihelper: Keep track of task numbers
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
X-List-Received-Date: Sat, 26 Nov 2011 13:51:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Add code so the uihelper keeps track of how may tasks we've run and
how many tasks there are in total so UIs don't have to track
this information themselves.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/ui/uihelper.py b/bitbake/lib/bb/ui/uihelper.py
index 617d60d..a73bfbe 100644
--- a/bitbake/lib/bb/ui/uihelper.py
+++ b/bitbake/lib/bb/ui/uihelper.py
@@ -24,6 +24,8 @@ class BBUIHelper:
         self.needUpdate = False
         self.running_tasks = {}
         self.failed_tasks = []
+        self.tasknumber_current = 0
+        self.tasknumber_total = 0
 
     def eventHandler(self, event):
         if isinstance(event, bb.build.TaskStarted):
@@ -36,6 +38,9 @@ class BBUIHelper:
             del self.running_tasks[event.pid]
             self.failed_tasks.append( { 'title' : "%s %s" % (event._package, event._task)})
             self.needUpdate = True
+        if isinstance(event, bb.runqueue.runQueueTaskStarted):
+            self.tasknumber_current = event.stats.completed + event.stats.active + event.stats.failed + 1
+            self.tasknumber_total = event.stats.total
 
     def getTasks(self):
         self.needUpdate = False




