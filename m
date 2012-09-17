Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1TDk8K-0003Pv-9J
	for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 00:49:40 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q8HMaxcM001941
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Sep 2012 15:36:59 -0700 (PDT)
Received: from ord-lpggp2.wrs.com (128.224.65.244) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Mon, 17 Sep 2012 15:36:59 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 17 Sep 2012 17:43:17 -0500
Message-ID: <1347921797-60524-1-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Subject: [PATCH] bitbake, runqueue: Add --no-setscene to skip all setscene tasks
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
X-List-Received-Date: Mon, 17 Sep 2012 22:49:40 -0000
Content-Type: text/plain

Mainly intended for the purpose of debugging or forcing builds
from source, the --no-setscene will prevent any setscene
tasks from running.

(LOCAL REV: NOT UPSTREAM)

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 bin/bitbake        |    2 ++
 lib/bb/runqueue.py |   13 +++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index c000d98..37c1045 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -182,6 +182,8 @@ Default BBFILES are the .bb files in the current directory.""")
 
     parser.add_option("-B", "--bind", help = "The name/address for the bitbake server to bind to",
                action = "store", dest = "bind", default = False)
+    parser.add_option("", "--no-setscene", help = "Do not run any setscene tasks, forces builds",
+               action = "store_true", dest = "nosetscene", default = False)
     options, args = parser.parse_args(sys.argv)
 
     configuration = BBConfiguration(options)
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index bc2eb87..cd67607 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -692,13 +692,14 @@ class RunQueueData:
             stampfnwhitelist.append(fn)
         self.stampfnwhitelist = stampfnwhitelist
 
-        # Interate over the task list looking for tasks with a 'setscene' function
+        # Iterate over the task list looking for tasks with a 'setscene' function
         self.runq_setscene = []
-        for task in range(len(self.runq_fnid)):
-            setscene = taskData.gettask_id(self.taskData.fn_index[self.runq_fnid[task]], self.runq_task[task] + "_setscene", False)
-            if not setscene:
-                continue
-            self.runq_setscene.append(task)
+        if not self.cooker.configuration.nosetscene:
+            for task in range(len(self.runq_fnid)):
+                setscene = taskData.gettask_id(self.taskData.fn_index[self.runq_fnid[task]], self.runq_task[task] + "_setscene", False)
+                if not setscene:
+                    continue
+                self.runq_setscene.append(task)
 
         def invalidate_task(fn, taskname, error_nostamp):
             taskdep = self.dataCache.task_deps[fn]
-- 
1.7.1



