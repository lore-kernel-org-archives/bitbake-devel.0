Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id BDE7060D39
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Dec 2013 16:21:42 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBIGKZvu010169 for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Dec 2013 16:21:38 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id KgYz5-pjrw7Z for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Dec 2013 16:21:38 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBIGLW3u010212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Dec 2013 16:21:33 GMT
Message-ID: <1387383687.6402.49.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 18 Dec 2013 16:21:27 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Add output for -S option for listing the changepoints compared with an sstate cache
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
X-List-Received-Date: Wed, 18 Dec 2013 16:21:43 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Its useful to understand where the delta starts against an existing sstate cache
for a given target. Adding this to the output of the -S option seems like a 
natural fit.

We use the hashvalidate function to figure this out and assume it can find siginfo
files for more than just the setscene tasks.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 428cff1..b7a602b 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1039,6 +1039,7 @@ class RunQueue:
 
         if self.state is runQueueSceneInit:
             if self.cooker.configuration.dump_signatures:
+                self.print_diffscenetasks()
                 self.dump_signatures()
             else:
                 self.start_worker()
@@ -1123,6 +1124,82 @@ class RunQueue:
 
         return
 
+    def print_diffscenetasks(self):
+
+        valid = []
+        sq_hash = []
+        sq_hashfn = []
+        sq_fn = []
+        sq_taskname = []
+        sq_task = []
+        noexec = []
+        stamppresent = []
+        valid_new = set()
+
+        for task in xrange(len(self.rqdata.runq_fnid)):
+            fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]]
+            taskname = self.rqdata.runq_task[task]
+            taskdep = self.rqdata.dataCache.task_deps[fn]
+
+            if 'noexec' in taskdep and taskname in taskdep['noexec']:
+                noexec.append(task)
+                continue
+
+            sq_fn.append(fn)
+            sq_hashfn.append(self.rqdata.dataCache.hashfn[fn])
+            sq_hash.append(self.rqdata.runq_hash[task])
+            sq_taskname.append(taskname)
+            sq_task.append(task)
+        call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d)"
+        locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
+        valid = bb.utils.better_eval(call, locs)
+        for v in valid:
+            valid_new.add(sq_task[v])
+
+        # Tasks which are both setscene and noexec never care about dependencies
+        # We therefore find tasks which are setscene and noexec and mark their
+        # unique dependencies as valid.
+        for task in noexec:
+            if task not in self.rqdata.runq_setscene:
+                continue
+            for dep in self.rqdata.runq_depends[task]:
+                hasnoexecparents = True
+                for dep2 in self.rqdata.runq_revdeps[dep]:
+                    if dep2 in self.rqdata.runq_setscene and dep2 in noexec:
+                        continue
+                    hasnoexecparents = False
+                    break
+                if hasnoexecparents:
+                    valid_new.add(dep)
+
+        invalidtasks = set()
+        for task in xrange(len(self.rqdata.runq_fnid)):
+            if task not in valid_new and task not in noexec:
+                invalidtasks.add(task)
+
+        found = set()
+        processed = set()
+        for task in invalidtasks:
+            toprocess = set([task])
+            while toprocess:
+                next = set()
+                for t in toprocess:
+                    for dep in self.rqdata.runq_depends[t]:
+                        if dep in invalidtasks:
+                            found.add(task)
+                        if dep not in processed:
+                            processed.add(dep)
+                            next.add(dep)
+                toprocess = next
+                if task in found:
+                    toprocess = set()
+
+        tasklist = []
+        for task in invalidtasks.difference(found):
+            tasklist.append(self.rqdata.get_user_idstring(task))
+
+        if tasklist:
+            bb.plain("The differences between the current build and any cached tasks start at the following tasks:\n" + "\n".join(tasklist))
 
 class RunQueueExecute:
 



