Return-Path: <rpjday@crashcourse.ca>
Received: from smtp685.redcondor.net (smtp685.redcondor.net [208.80.206.85])
	by mail.openembedded.org (Postfix) with ESMTP id E9B3860424
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Aug 2014 09:19:04 +0000 (UTC)
Received: from astoria.ccjclearline.com ([64.235.106.9])
	by smtp685.redcondor.net ({20c8e40f-6b6c-4c9e-abff-1640ea7bf404})
	via TCP (outbound) with ESMTPS id 20140813091903785
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Aug 2014 09:19:03 +0000
X-RC-FROM: <rpjday@crashcourse.ca>
X-RC-RCPT: <bitbake-devel@lists.openembedded.org>
Received: from [99.240.204.5] (port=48044 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1XHUhv-0002sX-KG for bitbake-devel@lists.openembedded.org;
	Wed, 13 Aug 2014 05:18:59 -0400
Date: Wed, 13 Aug 2014 05:18:50 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1408130517380.5574@localhost>
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
Subject: [PATCH] runqueue.py: Correct several misspellings of "notifing".
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
X-List-Received-Date: Wed, 13 Aug 2014 09:19:05 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index baaac44..46dca58 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2041,7 +2041,7 @@ class sceneQueueEvent(runQueueEvent):

 class runQueueTaskStarted(runQueueEvent):
     """
-    Event notifing a task was started
+    Event notifying a task was started
     """
     def __init__(self, task, stats, rq, noexec=False):
         runQueueEvent.__init__(self, task, stats, rq)
@@ -2049,7 +2049,7 @@ class runQueueTaskStarted(runQueueEvent):

 class sceneQueueTaskStarted(sceneQueueEvent):
     """
-    Event notifing a setscene task was started
+    Event notifying a setscene task was started
     """
     def __init__(self, task, stats, rq, noexec=False):
         sceneQueueEvent.__init__(self, task, stats, rq)
@@ -2057,7 +2057,7 @@ class sceneQueueTaskStarted(sceneQueueEvent):

 class runQueueTaskFailed(runQueueEvent):
     """
-    Event notifing a task failed
+    Event notifying a task failed
     """
     def __init__(self, task, stats, exitcode, rq):
         runQueueEvent.__init__(self, task, stats, rq)
@@ -2065,7 +2065,7 @@ class runQueueTaskFailed(runQueueEvent):

 class sceneQueueTaskFailed(sceneQueueEvent):
     """
-    Event notifing a setscene task failed
+    Event notifying a setscene task failed
     """
     def __init__(self, task, stats, exitcode, rq):
         sceneQueueEvent.__init__(self, task, stats, rq)
@@ -2081,17 +2081,17 @@ class sceneQueueComplete(sceneQueueEvent):

 class runQueueTaskCompleted(runQueueEvent):
     """
-    Event notifing a task completed
+    Event notifying a task completed
     """

 class sceneQueueTaskCompleted(sceneQueueEvent):
     """
-    Event notifing a setscene task completed
+    Event notifying a setscene task completed
     """

 class runQueueTaskSkipped(runQueueEvent):
     """
-    Event notifing a task was skipped
+    Event notifying a task was skipped
     """
     def __init__(self, task, stats, rq, reason):
         runQueueEvent.__init__(self, task, stats, rq)

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


