Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1SczdJ-0004eN-Sg
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jun 2012 15:53:46 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q58DhFD3015538
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 8 Jun 2012 06:43:15 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Fri, 8 Jun 2012 06:43:15 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 8 Jun 2012 08:41:48 -0500
Message-ID: <1339162913-23759-14-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
References: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH v4 13/18] bitbake, runqueue: Add --no-setscene to skip all setscene tasks
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
X-List-Received-Date: Fri, 08 Jun 2012 13:53:46 -0000
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
index 420e69d..702d99c 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -170,6 +170,8 @@ Default BBFILES are the .bb files in the current directory.""")
 
     parser.add_option("-B", "--bind", help = "The name/address for the bitbake server to bind to",
                action = "store", dest = "bind", default = False)
+    parser.add_option("", "--no-setscene", help = "Do not run any setscene tasks, forces builds",
+               action = "store_true", dest = "nosetscene", default = False)
     options, args = parser.parse_args(sys.argv)
 
     configuration = BBConfiguration(options)
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index b870caf..da3fdf9 100644
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



