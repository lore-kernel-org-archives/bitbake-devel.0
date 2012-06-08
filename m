Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1SczdH-0004bc-1D
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jun 2012 15:53:43 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q58DhDv3015532
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 8 Jun 2012 06:43:13 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Fri, 8 Jun 2012 06:43:12 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 8 Jun 2012 08:41:44 -0500
Message-ID: <1339162913-23759-10-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
References: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH v4 09/18] knotty2.py: Fix knotty2 to report something other than 0 of 0 for setscene tasks
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
X-List-Received-Date: Fri, 08 Jun 2012 13:53:43 -0000
Content-Type: text/plain

Any time knotty2 was running through the setscene tasks it was always
reporting the top line as follows for a core-image-minimal build.

    Currently 7 running tasks (0 of 0):

With this patch the number of SetScene tasks are tracked and reported
with knotty such that it nows looks something like:

    Currently 7 running SetScene tasks (342 of 479):

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/ui/knotty2.py  |    5 ++++-
 lib/bb/ui/uihelper.py |    5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty2.py b/lib/bb/ui/knotty2.py
index 01693e9..9e3619b 100644
--- a/lib/bb/ui/knotty2.py
+++ b/lib/bb/ui/knotty2.py
@@ -97,7 +97,10 @@ class TerminalFilter2(object):
         if self.main.shutdown:
             print("Waiting for %s running tasks to finish:" % len(activetasks))
         else:
-            print("Currently %s running tasks (%s of %s):" % (len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total))
+            if self.helper.tasknumber_current == 0:
+                print("Currently %s running SetScene tasks (%s of %s):" % (len(activetasks), self.helper.sc_tasknumber_current, self.helper.sc_tasknumber_total))
+            else:
+                print("Currently %s running tasks (%s of %s):" % (len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total))
         for tasknum, task in enumerate(tasks):
             print("%s: %s" % (tasknum, task))
             lines = lines + 1
diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
index 2c78695..84af5a3 100644
--- a/lib/bb/ui/uihelper.py
+++ b/lib/bb/ui/uihelper.py
@@ -28,6 +28,8 @@ class BBUIHelper:
         self.failed_tasks = []
         self.tasknumber_current = 0
         self.tasknumber_total = 0
+        self.sc_tasknumber_current = 0
+        self.sc_tasknumber_current = 0
 
     def eventHandler(self, event):
         if isinstance(event, bb.build.TaskStarted):
@@ -48,6 +50,9 @@ class BBUIHelper:
             self.running_pids.remove(event.pid)
             self.failed_tasks.append( { 'title' : "%s %s" % (event._package, event._task)})
             self.needUpdate = True
+        if isinstance(event, bb.runqueue.sceneQueueTaskStarted):
+            self.sc_tasknumber_current = event.stats.completed + event.stats.active + event.stats.failed + 1
+            self.sc_tasknumber_total = event.stats.total
         if isinstance(event, bb.runqueue.runQueueTaskStarted):
             self.tasknumber_current = event.stats.completed + event.stats.active + event.stats.failed + 1
             self.tasknumber_total = event.stats.total
-- 
1.7.10



