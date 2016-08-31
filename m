Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 410F9731E5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Aug 2016 10:37:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7VAbxKs016744 for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Aug 2016 11:37:59 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gZ6Xvkueo951 for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Aug 2016 11:37:59 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7VAbr96016738
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Aug 2016 11:37:55 +0100
Message-ID: <1472639873.29583.76.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 31 Aug 2016 11:37:53 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] build/runqueue: Add noextra stamp file parameter to fix multiconfig builds
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
X-List-Received-Date: Wed, 31 Aug 2016 10:37:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We can't execute the same task for the same package_arch multiple
times as the current setup has conflicting directories. Since
these would usually have the same stamp/hash, we want to execute in 
sequence rather than in parallel, so for the purposes of task execution,
don't consider the "extra-info" on the stamp files. We need to add
a parameter to the stamp function to achieve this.

This avoids multiple update-rc.d populate_sysroot tasks executing in
parallel and breaking multiconfig builds.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 50f0276..9dfcfec 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -633,7 +633,7 @@ def exec_task(fn, task, d, profile = False):
             event.fire(failedevent, d)
         return 1
 
-def stamp_internal(taskname, d, file_name, baseonly=False):
+def stamp_internal(taskname, d, file_name, baseonly=False, noextra=False):
     """
     Internal stamp helper function
     Makes sure the stamp directory exists
@@ -656,6 +656,8 @@ def stamp_internal(taskname, d, file_name, baseonly=False):
 
     if baseonly:
         return stamp
+    if noextra:
+        extrainfo = ""
 
     if not stamp:
         return
@@ -751,12 +753,12 @@ def write_taint(task, d, file_name = None):
     with open(taintfn, 'w') as taintf:
         taintf.write(str(uuid.uuid4()))
 
-def stampfile(taskname, d, file_name = None):
+def stampfile(taskname, d, file_name = None, noextra=False):
     """
     Return the stamp for a given task
     (d can be a data dict or dataCache)
     """
-    return stamp_internal(taskname, d, file_name)
+    return stamp_internal(taskname, d, file_name, noextra=noextra)
 
 def add_tasks(tasklist, d):
     task_deps = d.getVar('_task_deps', False)
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 3e49e21..761c660 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -137,7 +137,7 @@ class RunQueueScheduler(object):
         for tid in self.rqdata.runtaskentries:
             (mc, fn, taskname) = split_tid(tid)
             taskfn = taskfn_fromtid(tid)
-            self.stamps[tid] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn)
+            self.stamps[tid] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
             if tid in self.rq.runq_buildable:
                 self.buildable.append(tid)
 
@@ -1805,7 +1805,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, False, self.cooker.collection.get_file_appends(taskfn), taskdepdata)) + b"</runtask>")
                 self.rq.worker[mc].process.stdin.flush()
 
-            self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn)
+            self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
             self.build_stamps2.append(self.build_stamps[task])
             self.runq_running.add(task)
             self.stats.taskActive()



