Return-Path: <rpjday@crashcourse.ca>
Received: from smtp684.redcondor.net (smtp684.redcondor.net [208.80.206.84])
	by mail.openembedded.org (Postfix) with ESMTP id D18F365CF7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Aug 2014 08:53:26 +0000 (UTC)
Received: from astoria.ccjclearline.com ([64.235.106.9])
	by smtp684.redcondor.net ({700db0a8-6fb7-4c8b-9b2a-6812225182d8})
	via TCP (outbound) with ESMTPS id 20140812085326220
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Aug 2014 08:53:26 +0000
X-RC-FROM: <rpjday@crashcourse.ca>
X-RC-RCPT: <bitbake-devel@lists.openembedded.org>
Received: from [99.240.204.5] (port=33463 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1XH7pZ-0008WN-B4 for bitbake-devel@lists.openembedded.org;
	Tue, 12 Aug 2014 04:53:21 -0400
Date: Tue, 12 Aug 2014 04:53:16 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1408120451580.17954@localhost>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-MAG-OUTBOUND: ccj.redcondor.net@64.235.106.9/32
Subject: [PATCH] runqueue.py: Fix typoes/grammar in comments.
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
X-List-Received-Date: Tue, 12 Aug 2014 08:53:29 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index baaac44..19bce3e 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -97,7 +97,7 @@ class RunQueueScheduler(object):
     def __init__(self, runqueue, rqdata):
         """
         The default scheduler just returns the first buildable task (the
-        priority map is sorted by task numer)
+        priority map is sorted by task number)
         """
         self.rq = runqueue
         self.rqdata = rqdata
@@ -186,7 +186,7 @@ class RunQueueSchedulerCompletion(RunQueueSchedulerSpeed):
     """
     A scheduler optimised to complete .bb files are quickly as possible. The
     priority map is sorted by task weight, but then reordered so once a given
-    .bb file starts to build, its completed as quickly as possible. This works
+    .bb file starts to build, it's completed as quickly as possible. This works
     well where disk space is at a premium and classes like OE's rm_work are in
     force.
     """
@@ -795,7 +795,7 @@ class RunQueueData:
                 for st in self.cooker.configuration.invalidate_stamp.split(','):
                     invalidate_task(fn, "do_%s" % st, True)

-        # Interate over the task list and call into the siggen code
+        # Iterate over the task list and call into the siggen code
         dealtwith = set()
         todeal = set(range(len(self.runq_fnid)))
         while len(todeal) > 0:
@@ -967,11 +967,11 @@ class RunQueue:

         stampfile = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)

-        # If the stamp is missing its not current
+        # If the stamp is missing, it's not current
         if not os.access(stampfile, os.F_OK):
             logger.debug(2, "Stampfile %s not available", stampfile)
             return False
-        # If its a 'nostamp' task, it's not current
+        # If it's a 'nostamp' task, it's not current
         taskdep = self.rqdata.dataCache.task_deps[fn]
         if 'nostamp' in taskdep and taskname in taskdep['nostamp']:
             logger.debug(2, "%s.%s is nostamp\n", fn, taskname)
@@ -1688,7 +1688,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):

         process_endpoints(endpoints)

-        # Build a list of setscene tasks which as "unskippable"
+        # Build a list of setscene tasks which are "unskippable"
         # These are direct endpoints referenced by the build
         endpoints2 = {}
         sq_revdeps2 = []

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


