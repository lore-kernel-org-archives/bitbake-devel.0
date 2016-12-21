Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 222FC77492
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Dec 2016 17:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uBLH6Yut001644; Wed, 21 Dec 2016 17:06:35 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id V764aMxRbhTT; Wed, 21 Dec 2016 17:06:35 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uBLH6TO1001588
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Dec 2016 17:06:30 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cJkLV-0006uB-Dp; Wed, 21 Dec 2016 17:06:29 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Dec 2016 17:06:20 +0000
Message-Id: <1482339985-26495-2-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1482339985-26495-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1482339985-26495-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 2/7] build/uihelper: Show better information about multiconfig tasks on UI
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
X-List-Received-Date: Wed, 21 Dec 2016 17:06:38 -0000

Currently the UI shows X is building, possibly multiple times but doesn't
say which of the multilibs that might be. This adds a prefix to the task
name so the mulitconfig being built can be identified.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/build.py       | 1 +
 lib/bb/ui/uihelper.py | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 0c2c1ba..271cda6 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -92,6 +92,7 @@ class TaskBase(event.Event):
     def __init__(self, t, logfile, d):
         self._task = t
         self._package = d.getVar("PF")
+        self._mc = d.getVar("BB_CURRENT_MC")
         self.taskfile = d.getVar("FILE")
         self.taskname = self._task
         self.logfile = logfile
diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
index fda7cc2..113fced 100644
--- a/lib/bb/ui/uihelper.py
+++ b/lib/bb/ui/uihelper.py
@@ -32,7 +32,10 @@ class BBUIHelper:
 
     def eventHandler(self, event):
         if isinstance(event, bb.build.TaskStarted):
-            self.running_tasks[event.pid] = { 'title' : "%s %s" % (event._package, event._task), 'starttime' : time.time() }
+            if event._mc != "default":
+                self.running_tasks[event.pid] = { 'title' : "mc:%s:%s %s" % (event._mc, event._package, event._task), 'starttime' : time.time() }
+            else:
+                self.running_tasks[event.pid] = { 'title' : "%s %s" % (event._package, event._task), 'starttime' : time.time() }
             self.running_pids.append(event.pid)
             self.needUpdate = True
         elif isinstance(event, bb.build.TaskSucceeded):
-- 
2.7.4


