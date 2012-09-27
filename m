Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1THNMc-0003ky-Iu for bitbake-devel@lists.openembedded.org;
	Fri, 28 Sep 2012 01:19:26 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8RN6Y0r005290
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Sep 2012 00:06:34 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 04374-05 for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Sep 2012 00:06:30 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8RN6OYI005284
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Sep 2012 00:06:26 +0100
Message-ID: <1348787186.15753.36.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Sep 2012 00:06:26 +0100
In-Reply-To: <1348783608.15753.31.camel@ted>
References: <1348783608.15753.31.camel@ted>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH v2] knotty: Allow displaying of status when no tasks are active
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
X-List-Received-Date: Thu, 27 Sep 2012 23:19:26 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

From f44c74bd864ca183590dbb2931fe3033c908ea16 Mon Sep 17 00:00:00 2001
From: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Thu, 27 Sep 2012 21:56:02 +0000
Subject: knotty: Allow displaying of status when no tasks are active

The console can appear to hang when no tasks are executing even if bitbake
is iterating through a large number of tasks behind the scenes.

This patch tweaks the footer code to display a status even when no tasks
are active to give the user better feedback about what is happening.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index d81ad5d..3799018 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -183,11 +183,11 @@ class TerminalFilter(object):
         activetasks = self.helper.running_tasks
         failedtasks = self.helper.failed_tasks
         runningpids = self.helper.running_pids
-        if self.footer_present and (self.lastpids == runningpids):
+        if self.footer_present and (self.lastcount == self.helper.tasknumber_current) and (self.lastpids == runningpids):
             return
         if self.footer_present:
             self.clearFooter()
-        if not activetasks:
+        if not self.helper.tasknumber_total or self.helper.tasknumber_current == self.helper.tasknumber_total:
             return
         tasks = []
         for t in runningpids:
@@ -195,6 +195,8 @@ class TerminalFilter(object):
 
         if self.main.shutdown:
             content = "Waiting for %s running tasks to finish:" % len(activetasks)
+        elif not len(activetasks):
+            content = "No currently running tasks (%s of %s)" % (self.helper.tasknumber_current, self.helper.tasknumber_total)
         else:
             content = "Currently %s running tasks (%s of %s):" % (len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total)
         print content
@@ -205,6 +207,7 @@ class TerminalFilter(object):
             lines = lines + 1 + int(len(content) / (self.columns + 1))
         self.footer_present = lines
         self.lastpids = runningpids[:]
+        self.lastcount = self.helper.tasknumber_current
 
     def finish(self):
         if self.stdinbackup:




