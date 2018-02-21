Return-Path: <ola.x.nilsson@axis.com>
X-Greylist: delayed 497 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 21 Feb 2018 10:34:11 UTC
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 448156FEFE
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Feb 2018 10:34:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 182F118434
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Feb 2018 11:25:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id xl_c0YdtbXe2 for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Feb 2018 11:25:50 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id BCB301842A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Feb 2018 11:25:49 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 371531A06B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Feb 2018 11:25:49 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C29D1A065
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Feb 2018 11:25:49 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder02.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Feb 2018 11:25:49 +0100 (CET)
Received: from lnxolani1.se.axis.com (lnxolani1.se.axis.com [10.88.130.9])
	by seth.se.axis.com (Postfix) with ESMTP id 20AD81BCC
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Feb 2018 11:25:49 +0100 (CET)
Received: by lnxolani1.se.axis.com (Postfix, from userid 20853)
	id 1D374409B5; Wed, 21 Feb 2018 11:25:49 +0100 (CET)
From: Ola x Nilsson <ola.x.nilsson@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Feb 2018 11:25:49 +0100
Message-Id: <20180221102549.15542-1-olani@axis.com>
X-Mailer: git-send-email 2.11.0
X-TM-AS-GCONF: 00
Subject: [PATCH] bitbake: knotty: Simplify footer tasklist generation
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
X-List-Received-Date: Wed, 21 Feb 2018 10:34:12 -0000

Instead of using a string for tasks without progressbar and a tuple
for tasks with progressbar, collect the necessary state in a
namedtuple.
Only have two string variants instead of three, and get elapsed time
for tasks with progressbar.

Signed-off-by: Ola x Nilsson <olani@axis.com>
---
 bitbake/lib/bb/ui/knotty.py | 52 ++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index fa88e6ccdd..896baf2e86 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -32,6 +32,7 @@ import fcntl
 import struct
 import copy
 import atexit
+from collections import namedtuple
 
 from bb.ui import uihelper
 
@@ -239,29 +240,24 @@ class TerminalFilter(object):
             self.clearFooter()
         if (not self.helper.tasknumber_total or self.helper.tasknumber_current == self.helper.tasknumber_total) and not len(activetasks):
             return
+        Task = namedtuple('task', 'title pid starttime progress pbar rate')
         tasks = []
-        for t in runningpids:
-            progress = activetasks[t].get("progress", None)
+        for pid in runningpids:
+            title = activetasks[pid]["title"]
+            start_time = activetasks[pid].get("starttime", None)
+            progress = activetasks[pid].get("progress", None)
+            pbar = progress and activetasks[pid].get("progressbar", None)
+            rate = progress and activetasks[pid].get("rate", None)
             if progress is not None:
-                pbar = activetasks[t].get("progressbar", None)
-                rate = activetasks[t].get("rate", None)
-                start_time = activetasks[t].get("starttime", None)
                 if not pbar or pbar.bouncing != (progress < 0):
                     if progress < 0:
-                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], t), 100, widgets=[progressbar.BouncingSlider(), ''], extrapos=2, resize_handler=self.sigwinch_handle)
+                        pbar = BBProgress(title, 100, widgets=[progressbar.BouncingSlider(), ''], extrapos=2, resize_handler=self.sigwinch_handle)
                         pbar.bouncing = True
                     else:
-                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], t), 100, widgets=[progressbar.Percentage(), ' ', progressbar.Bar(), ''], extrapos=4, resize_handler=self.sigwinch_handle)
+                        pbar = BBProgress(title, 100, widgets=[progressbar.Percentage(), ' ', progressbar.Bar(), ''], extrapos=4, resize_handler=self.sigwinch_handle)
                         pbar.bouncing = False
-                    activetasks[t]["progressbar"] = pbar
-                tasks.append((pbar, progress, rate, start_time))
-            else:
-                start_time = activetasks[t].get("starttime", None)
-                if start_time:
-                    tasks.append("%s - %ds (pid %s)" % (activetasks[t]["title"], currenttime - start_time, t))
-                else:
-                    tasks.append("%s (pid %s)" % (activetasks[t]["title"], t))
-
+                    activetasks[pid]["progressbar"] = pbar
+            tasks.append(Task(title, pid, start_time, progress, pbar, rate))
         if self.main.shutdown:
             content = "Waiting for %s running tasks to finish:" % len(activetasks)
             print(content)
@@ -286,21 +282,23 @@ class TerminalFilter(object):
         lines = 1 + int(len(content) / (self.columns + 1))
         if self.quiet == 0:
             for tasknum, task in enumerate(tasks[:(self.rows - 2)]):
-                if isinstance(task, tuple):
-                    pbar, progress, rate, start_time = task
-                    if not pbar.start_time:
-                        pbar.start(False)
+                if task.starttime:
+                    content = "%s: %s - %ds (pid %d)" % (tasknum, task.title, currenttime - task.starttime, task.pid)
+                else:
+                    content = "%s: %s (pid %d)" % (tasknum, task.title, task.pid)
+                if task.pbar:
+                    if not task.pbar.start_time:
+                        task.pbar.start(False)
                         if start_time:
-                            pbar.start_time = start_time
-                    pbar.setmessage('%s:%s' % (tasknum, pbar.msg.split(':', 1)[1]))
-                    if progress > -1:
-                        pbar.setextra(rate)
-                        content = pbar.update(progress)
+                            task.pbar.start_time = start_time
+                    task.pbar.setmessage(content)
+                    if task.progress > -1:
+                        task.pbar.setextra(task.rate)
+                        content = task.pbar.update(task.progress)
                     else:
-                        content = pbar.update(1)
+                        content = task.pbar.update(1)
                     print('')
                 else:
-                    content = "%s: %s" % (tasknum, task)
                     print(content)
                 lines = lines + 1 + int(len(content) / (self.columns + 1))
         self.footer_present = lines
-- 
2.11.0


