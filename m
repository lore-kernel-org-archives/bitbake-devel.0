Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id E825977FFE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jul 2017 10:27:50 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v6BARq2F021101
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jul 2017 03:27:52 -0700
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Tue, 11 Jul 2017 03:27:51 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 11 Jul 2017 03:27:48 -0700
Message-ID: <63def8487986a40105a2a8acdba4e411662ba28a.1499768495.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1499768495.git.liezhi.yang@windriver.com>
References: <cover.1499768495.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [RFC PATCH 3/3] bitbake: uihelper.py: check event.pid is present
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
X-List-Received-Date: Tue, 11 Jul 2017 10:27:51 -0000
Content-Type: text/plain

Fixed:
$ . ../poky/oe-init-build-env-memres .
$ bitbake world
In another terminal:
$ . ../poky/oe-init-build-env-memres .
Run the following command and Ctrl-C several times:
$ bitbake --observe-only
Traceback (most recent call last):
  File "/buildarea/lyang1/poky/bitbake/lib/bb/ui/knotty.py", line 441, in main
    helper.eventHandler(event)
  File "/buildarea/lyang1/poky/bitbake/lib/bb/ui/uihelper.py", line 42, in eventHandler
    del self.running_tasks[event.pid]
KeyError: 43646

This was becase the ui maybe connected at any time, so the event.pid may not be
present.

[YOCTO #11781]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/ui/uihelper.py | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/bitbake/lib/bb/ui/uihelper.py b/bitbake/lib/bb/ui/uihelper.py
index 113fcedeaf1..307c87e149c 100644
--- a/bitbake/lib/bb/ui/uihelper.py
+++ b/bitbake/lib/bb/ui/uihelper.py
@@ -38,29 +38,32 @@ class BBUIHelper:
                 self.running_tasks[event.pid] = { 'title' : "%s %s" % (event._package, event._task), 'starttime' : time.time() }
             self.running_pids.append(event.pid)
             self.needUpdate = True
-        elif isinstance(event, bb.build.TaskSucceeded):
-            del self.running_tasks[event.pid]
-            self.running_pids.remove(event.pid)
-            self.needUpdate = True
-        elif isinstance(event, bb.build.TaskFailedSilent):
-            del self.running_tasks[event.pid]
-            self.running_pids.remove(event.pid)
-            # Don't add to the failed tasks list since this is e.g. a setscene task failure
-            self.needUpdate = True
-        elif isinstance(event, bb.build.TaskFailed):
-            del self.running_tasks[event.pid]
-            self.running_pids.remove(event.pid)
-            self.failed_tasks.append( { 'title' : "%s %s" % (event._package, event._task)})
-            self.needUpdate = True
+        # The ui maybe connected at any time, so make sure that the
+        # event.pid is already in self.running_tasks.
+        elif getattr(event, 'pid', 'none_pid') in self.running_tasks:
+            if isinstance(event, bb.build.TaskSucceeded):
+                del self.running_tasks[event.pid]
+                self.running_pids.remove(event.pid)
+                self.needUpdate = True
+            elif isinstance(event, bb.build.TaskFailedSilent):
+                del self.running_tasks[event.pid]
+                self.running_pids.remove(event.pid)
+                # Don't add to the failed tasks list since this is e.g. a setscene task failure
+                self.needUpdate = True
+            elif isinstance(event, bb.build.TaskFailed):
+                del self.running_tasks[event.pid]
+                self.running_pids.remove(event.pid)
+                self.failed_tasks.append( { 'title' : "%s %s" % (event._package, event._task)})
+                self.needUpdate = True
+            elif isinstance(event, bb.build.TaskProgress):
+                if event.pid > 0:
+                    self.running_tasks[event.pid]['progress'] = event.progress
+                    self.running_tasks[event.pid]['rate'] = event.rate
+                    self.needUpdate = True
         elif isinstance(event, bb.runqueue.runQueueTaskStarted) or isinstance(event, bb.runqueue.sceneQueueTaskStarted):
             self.tasknumber_current = event.stats.completed + event.stats.active + event.stats.failed + 1
             self.tasknumber_total = event.stats.total
             self.needUpdate = True
-        elif isinstance(event, bb.build.TaskProgress):
-            if event.pid > 0:
-                self.running_tasks[event.pid]['progress'] = event.progress
-                self.running_tasks[event.pid]['rate'] = event.rate
-                self.needUpdate = True
 
     def getTasks(self):
         self.needUpdate = False
-- 
2.11.0


