Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1Sf0hn-0006T4-V4
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 05:26:44 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q5E3G4N7019049
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Jun 2012 20:16:06 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Wed, 13 Jun 2012 20:16:04 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 13 Jun 2012 22:15:59 -0500
Message-ID: <1339643761-23149-2-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339643761-23149-1-git-send-email-jason.wessel@windriver.com>
References: <1339643761-23149-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/3] bitbake, runqueue: Add --no-setscene to skip all setscene tasks
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
X-List-Received-Date: Thu, 14 Jun 2012 03:26:44 -0000
Content-Type: text/plain

Mainly intended for the purpose of debugging or forcing builds
from source, the --no-setscene will prevent any setscene
tasks from running.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 bin/bitbake        |    2 ++
 lib/bb/runqueue.py |   13 +++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 478ac06..d178a38 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -171,6 +171,8 @@ Default BBFILES are the .bb files in the current directory.""")
 
     parser.add_option("-B", "--bind", help = "The name/address for the bitbake server to bind to",
                action = "store", dest = "bind", default = False)
+    parser.add_option("", "--no-setscene", help = "Do not run any setscene tasks, forces builds",
+               action = "store_true", dest = "nosetscene", default = False)
     options, args = parser.parse_args(sys.argv)
 
     configuration = BBConfiguration(options)
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index d925b4c..6596e83 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -699,13 +699,14 @@ class RunQueueData:
 
         # Interate over the task list looking for tasks with a 'setscene' function
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
 
-        # Interate over the task list and call into the siggen code
+        # Iterate over the task list and call into the siggen code
         dealtwith = set()
         todeal = set(range(len(self.runq_fnid)))
         while len(todeal) > 0:
-- 
1.7.10



