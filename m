Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RqOvm-0004L4-5y for bitbake-devel@lists.openembedded.org;
	Thu, 26 Jan 2012 13:59:58 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0QCqB41022310
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jan 2012 12:52:11 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 22219-01 for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jan 2012 12:52:05 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0QCq29E022302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jan 2012 12:52:03 GMT
Message-ID: <1327582324.19643.370.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 26 Jan 2012 12:52:04 +0000
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] data/runqueue.py: Fix commented out test code after variable name changes
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
X-List-Received-Date: Thu, 26 Jan 2012 12:59:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index e5c408c..c0636e1 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -333,7 +333,7 @@ def generate_dependencies(d):
                     deps[dep], values[dep] = build_dependencies(dep, keys, shelldeps, vardepvals, d)
                 newdeps |=  deps[dep]
             newdeps -= seen
-        #print "For %s: %s" % (task, str(taskdeps[task]))
+        #print "For %s: %s" % (task, str(deps[task]))
     return tasklist, deps, values
 
 def inherits_class(klass, d):
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index be6bbb1..c74e73c 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1472,7 +1472,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 bb.msg.fatal("RunQueue", "Something went badly wrong during scenequeue generation, aborting. Please report this problem.")
 
         #for task in xrange(len(sq_revdeps_squash)):
-        #    print "Task %s: %s.%s is %s " % (task, self.taskData.fn_index[self.runq_fnid[self.runq_setscene[task]]], self.runq_task[self.runq_setscene[task]] + "_setscene", sq_revdeps_squash[task])
+        #    print "Task %s: %s.%s is %s " % (task, self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[self.rqdata.runq_setscene[task]]], self.rqdata.runq_task[self.rqdata.runq_setscene[task]] + "_setscene", sq_revdeps_squash[task])
 
         self.sq_deps = []
         self.sq_revdeps = sq_revdeps_squash




