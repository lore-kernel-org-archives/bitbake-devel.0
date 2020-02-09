Return-Path: <peter.kjellerstedt@axis.com>
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
	by mail.openembedded.org (Postfix) with ESMTP id 91B46608AF
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Feb 2020 08:50:38 +0000 (UTC)
IronPort-SDR: APiG5/3Hxg55O5EmmU3SJra+P5FC+aiUKQguQh6soqzcdSTbxOyKg3eU2cDYM2hIFC9ukKnb9Q
	v0R0Ugn3Dobiy6yDSEb6wvpqGzJepMqMGtONpQVXuxP3SymOYF2+yxlFcvA+44n4oswSvX2cJ4
	W7ADyqxt1iCks4Gk9/FvNXQoU8eANhjZrfswZlOvouHcHAYA49cLBr5BIvTBmmsDDXRBx8GmPy
	TvBS6V+70kYmJfc3/LSO0xVyi57XrlLztXIcVxiEFMJrm2njsGDWh41NaP+bqhlhp31dXeEuO/
	DY8=
X-IronPort-AV: E=Sophos;i="5.70,420,1574118000"; 
   d="scan'208";a="5225059"
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 9 Feb 2020 09:50:34 +0100
Message-ID: <20200209085034.16349-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Subject: [master][zeus][PATCH] uihelper: Track scene tasks again
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
X-List-Received-Date: Sun, 09 Feb 2020 08:50:41 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Track both scene tasks and run tasks to provide a complete progress
information for all tasks. This avoids the progress bar from stating
"Currently XX running tasks (0 of 0)" while progressing through
thousands of setscene tasks, obviously confusing the user.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/ui/uihelper.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/uihelper.py b/bitbake/lib/bb/ui/uihelper.py
index 48d808ae28..ac4ac5a882 100644
--- a/bitbake/lib/bb/ui/uihelper.py
+++ b/bitbake/lib/bb/ui/uihelper.py
@@ -16,6 +16,10 @@ class BBUIHelper:
         self.running_pids = []
         self.failed_tasks = []
         self.pidmap = {}
+        self.scenetasks_current = 0
+        self.scenetasks_total = 0
+        self.runtasks_current = 0
+        self.runtasks_total = 0
         self.tasknumber_current = 0
         self.tasknumber_total = 0
 
@@ -49,9 +53,17 @@ class BBUIHelper:
             tid = event._fn + ":" + event._task
             removetid(event.pid, tid)
             self.failed_tasks.append( { 'title' : "%s %s" % (event._package, event._task)})
+        elif isinstance(event, bb.runqueue.sceneQueueTaskStarted):
+            self.scenetasks_current = event.stats.completed + event.stats.active + event.stats.failed + 1
+            self.scenetasks_total = event.stats.total
+            self.tasknumber_current = self.scenetasks_current + self.runtasks_current
+            self.tasknumber_total = self.scenetasks_total + self.runtasks_total
+            self.needUpdate = True
         elif isinstance(event, bb.runqueue.runQueueTaskStarted):
-            self.tasknumber_current = event.stats.completed + event.stats.active + event.stats.failed + 1
-            self.tasknumber_total = event.stats.total
+            self.runtasks_current = event.stats.completed + event.stats.active + event.stats.failed + 1
+            self.runtasks_total = event.stats.total
+            self.tasknumber_current = self.scenetasks_current + self.runtasks_current
+            self.tasknumber_total = self.scenetasks_total + self.runtasks_total
             self.needUpdate = True
         elif isinstance(event, bb.build.TaskProgress):
             if event.pid > 0 and event.pid in self.pidmap:
-- 
2.21.1


