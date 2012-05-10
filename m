Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SSOnR-0004fm-Co for bitbake-devel@lists.openembedded.org;
	Thu, 10 May 2012 10:32:25 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4A8MVlu008148
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 May 2012 09:22:31 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 25763-08 for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 May 2012 09:22:27 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4A8MNUs008141
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 May 2012 09:22:24 +0100
Message-ID: <1336638142.2494.121.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 10 May 2012 09:22:22 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake/runqueue: Drop check_stamps function, it is obsolete and unused
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
X-List-Received-Date: Thu, 10 May 2012 08:32:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This was originally used to check the consistency of the stamps in one function
call. This turns out to be inefficient, unnecessary and if it were necessary,
check_stamp_task() could be called in a loop. The function has been unmodified
for a while and likely contains bugs. Its best simply removed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 0eed9ee..8d56331 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -781,100 +781,6 @@ class RunQueue:
 
         self.rqexe = None
 
-    def check_stamps(self):
-        unchecked = {}
-        current = []
-        notcurrent = []
-        buildable = []
-
-        if self.stamppolicy == "perfile":
-            fulldeptree = False
-        else:
-            fulldeptree = True
-            stampwhitelist = []
-            if self.stamppolicy == "whitelist":
-                stampwhitelist = self.rqdata.stampfnwhitelist
-
-        for task in xrange(len(self.rqdata.runq_fnid)):
-            unchecked[task] = ""
-            if len(self.rqdata.runq_depends[task]) == 0:
-                buildable.append(task)
-
-        def check_buildable(self, task, buildable):
-            for revdep in self.rqdata.runq_revdeps[task]:
-                alldeps = 1
-                for dep in self.rqdata.runq_depends[revdep]:
-                    if dep in unchecked:
-                        alldeps = 0
-                if alldeps == 1:
-                    if revdep in unchecked:
-                        buildable.append(revdep)
-
-        for task in xrange(len(self.rqdata.runq_fnid)):
-            if task not in unchecked:
-                continue
-            fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]]
-            taskname = self.rqdata.runq_task[task]
-            stampfile = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
-            # If the stamp is missing its not current
-            if not os.access(stampfile, os.F_OK):
-                del unchecked[task]
-                notcurrent.append(task)
-                check_buildable(self, task, buildable)
-                continue
-            # If its a 'nostamp' task, it's not current
-            taskdep = self.rqdata.dataCache.task_deps[fn]
-            if 'nostamp' in taskdep and task in taskdep['nostamp']:
-                del unchecked[task]
-                notcurrent.append(task)
-                check_buildable(self, task, buildable)
-                continue
-
-        while (len(buildable) > 0):
-            nextbuildable = []
-            for task in buildable:
-                if task in unchecked:
-                    fn = self.taskData.fn_index[self.rqdata.runq_fnid[task]]
-                    taskname = self.rqdata.runq_task[task]
-                    stampfile = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
-                    iscurrent = True
-
-                    t1 = os.stat(stampfile)[stat.ST_MTIME]
-                    for dep in self.rqdata.runq_depends[task]:
-                        if iscurrent:
-                            fn2 = self.taskData.fn_index[self.rqdata.runq_fnid[dep]]
-                            taskname2 = self.rqdata.runq_task[dep]
-                            stampfile2 = bb.build.stampfile(taskname2, self.rqdata.dataCache, fn2)
-                            if fn == fn2 or (fulldeptree and fn2 not in stampwhitelist):
-                                if dep in notcurrent:
-                                    iscurrent = False
-                                else:
-                                    t2 = os.stat(stampfile2)[stat.ST_MTIME]
-                                    if t1 < t2:
-                                        iscurrent = False
-                    del unchecked[task]
-                    if iscurrent:
-                        current.append(task)
-                    else:
-                        notcurrent.append(task)
-
-                check_buildable(self, task, nextbuildable)
-
-            buildable = nextbuildable
-
-        #for task in range(len(self.runq_fnid)):
-        #    fn = self.taskData.fn_index[self.runq_fnid[task]]
-        #    taskname = self.runq_task[task]
-        #    print "%s %s.%s" % (task, taskname, fn)
-
-        #print "Unchecked: %s" % unchecked
-        #print "Current: %s" % current
-        #print "Not current: %s" % notcurrent
-
-        if len(unchecked) > 0:
-            bb.msg.fatal("RunQueue", "check_stamps fatal internal error")
-        return current
-
     def check_stamp_task(self, task, taskname = None, recurse = False, cache = None):
         def get_timestamp(f):
             try:




