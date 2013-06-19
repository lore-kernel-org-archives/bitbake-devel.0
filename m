Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 63434601AF
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jun 2013 13:03:55 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r5JDA4Gt022851 for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jun 2013 14:10:04 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 4nPCaLcWRsLW for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jun 2013 14:10:04 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r5JD9wep022847
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jun 2013 14:10:00 +0100
Message-ID: <1371647019.20823.180.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 19 Jun 2013 14:03:39 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] runqueue/build: Add recideptask flag
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 19 Jun 2013 13:03:55 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently, tasks like fetchall are slightly broken since if a recipe
has specific [depends] which occur after do_fetch and add items not listed
in DEPENDS and RDEPENDS, they are not caught by recrdeptask. We've gone
around in circles on this issue (e.g
http://git.yoctoproject.org/cgit.cgi/poky/commit/bitbake/lib/bb/runqueue.py?id=5fa6036d49ed7befe6ad50ec95c61a50aec48195
) and in many cases the behaviour of recrdepends is correct but tasks like
fetchall need the other behaviour.

To address this we add a recideptask flag which can be used in conjuction
with the recrdeptask flag to specify which task to to the inspection upon.
This means entries like do_rootfs[depends] which have do_fetch tasks are
caught and run.

I'm not 100% happy with needing another flag but I don't see any rational
way to get the correct behaviour in all cases without it.

[YOCTO #4597]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index bfc176d..70d7165 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -602,6 +602,7 @@ def add_tasks(tasklist, d):
         getTask('deptask')
         getTask('rdeptask')
         getTask('recrdeptask')
+        getTask('recideptask')
         getTask('nostamp')
         getTask('fakeroot')
         getTask('noexec')
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index dcf9004..fce08ee 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -382,6 +382,7 @@ class RunQueueData:
 
         runq_build = []
         recursivetasks = {}
+        recursiveitasks = {}
         recursivetasksselfref = set()
 
         taskData = self.taskData
@@ -504,6 +505,12 @@ class RunQueueData:
                     if taskData.tasks_name[task] in tasknames:
                         recursivetasksselfref.add(task)
 
+                    if 'recideptask' in task_deps and taskData.tasks_name[task] in task_deps['recideptask']:
+                        recursiveitasks[task] = []
+                        for t in task_deps['recideptask'][taskData.tasks_name[task]].split():
+                            newdep = taskData.gettask_id_fromfnid(fnid, t)
+                            recursiveitasks[task].append(newdep)
+
             self.runq_fnid.append(taskData.tasks_fnid[task])
             self.runq_task.append(taskData.tasks_name[task])
             self.runq_depends.append(depends)
@@ -536,6 +543,10 @@ class RunQueueData:
                             generate_recdeps(n)
             generate_recdeps(task)
 
+            if task in recursiveitasks:
+                for dep in recursiveitasks[task]:
+                    generate_recdeps(dep)
+
         # Remove circular references so that do_a[recrdeptask] = "do_a do_b" can work
         for task in recursivetasks:
             extradeps[task].difference_update(recursivetasksselfref)



