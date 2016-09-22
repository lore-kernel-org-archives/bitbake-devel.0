Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 9C7E4600E3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Sep 2016 12:54:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u8MCs1Zq015406 for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Sep 2016 13:54:49 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id uFBsJ-i1YOeS for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Sep 2016 13:54:49 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u8MCsh7Z015603
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Sep 2016 13:54:44 +0100
Message-ID: <1474548883.7207.362.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 22 Sep 2016 13:54:43 +0100
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] knotty: Show task elapsed time
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
X-List-Received-Date: Thu, 22 Sep 2016 12:54:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Its often useful to know how long a task has been running for. This patch
adds that information to the task display, updating every 5s if there
were no other updates so the user can see how long tasks have been running
for.

[YOCTO #9737]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index a1856ec..c34b6f6 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -170,6 +170,7 @@ class TerminalFilter(object):
         self.interactive = sys.stdout.isatty()
         self.footer_present = False
         self.lastpids = []
+        self.lasttime = None
         self.quiet = quiet
 
         if not self.interactive:
@@ -226,6 +227,10 @@ class TerminalFilter(object):
         activetasks = self.helper.running_tasks
         failedtasks = self.helper.failed_tasks
         runningpids = self.helper.running_pids
+        currenttime = time.time()
+        if not self.lasttime or (currenttime - self.lasttime > 5):
+            self.helper.needUpdate = True
+            self.lasttime = currenttime
         if self.footer_present and not self.helper.needUpdate:
             return
         self.helper.needUpdate = False
@@ -250,7 +256,11 @@ class TerminalFilter(object):
                     activetasks[t]["progressbar"] = pbar
                 tasks.append((pbar, progress, rate, start_time))
             else:
-                tasks.append("%s (pid %s)" % (activetasks[t]["title"], t))
+                start_time = activetasks[t].get("starttime", None)
+                if start_time:
+                    tasks.append("%s - %ds (pid %s)" % (activetasks[t]["title"], currenttime - start_time, t))
+                else:
+                    tasks.append("%s (pid %s)" % (activetasks[t]["title"], t))
 
         if self.main.shutdown:
             content = "Waiting for %s running tasks to finish:" % len(activetasks)



