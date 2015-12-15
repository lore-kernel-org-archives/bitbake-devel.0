Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 666D873195
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Dec 2015 16:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tBFGgL3v005009 for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Dec 2015 16:42:21 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xPPwv_aPbKnj for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Dec 2015 16:42:21 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tBFGgIms005004
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Dec 2015 16:42:19 GMT
Message-ID: <1450197738.13505.76.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 15 Dec 2015 16:42:18 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: runqueue: Add support for <task>- syntax
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
X-List-Received-Date: Tue, 15 Dec 2015 16:42:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

It can be useful to run all tasks up to but not including a specific task. The
main reason this was never added was the lack of a good syntax. This patch
uses the syntax <taskname>- to denote this behaviour which is simple, not 
invasive and fits what we need from good syntax IMO, hence we can add this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 878028a..ee06f0e 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -634,23 +634,33 @@ class RunQueueData:
 
             fnid = taskData.build_targets[targetid][0]
             fn = taskData.fn_index[fnid]
-            self.target_pairs.append((fn, target[1]))
+            task = target[1]
+            parents = False
+            if task.endswith('-'):
+                parents = True
+                task = task[:-1]
+
+            self.target_pairs.append((fn, task))
 
             if fnid in taskData.failed_fnids:
                 continue
 
-            if target[1] not in taskData.tasks_lookup[fnid]:
+            if task not in taskData.tasks_lookup[fnid]:
                 import difflib
-                close_matches = difflib.get_close_matches(target[1], taskData.tasks_lookup[fnid], cutoff=0.7)
+                close_matches = difflib.get_close_matches(task, taskData.tasks_lookup[fnid], cutoff=0.7)
                 if close_matches:
                     extra = ". Close matches:\n  %s" % "\n  ".join(close_matches)
                 else:
                     extra = ""
-                bb.msg.fatal("RunQueue", "Task %s does not exist for target %s%s" % (target[1], target[0], extra))
-
-            listid = taskData.tasks_lookup[fnid][target[1]]
-
-            mark_active(listid, 1)
+                bb.msg.fatal("RunQueue", "Task %s does not exist for target %s%s" % (task, target[0], extra))
+  
+            # For tasks called "XXXX-", ony run their dependencies
+            listid = taskData.tasks_lookup[fnid][task]
+            if parents:
+                for i in self.runq_depends[listid]:
+                    mark_active(i, 1)
+            else:
+                mark_active(listid, 1)
 
         # Step C - Prune all inactive tasks
         #



