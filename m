Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7A15878840
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Jan 2018 12:10:12 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w0UCABvB029015
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 30 Jan 2018 12:10:12 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1egUjr-0006h7-Gj; Tue, 30 Jan 2018 12:10:11 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Jan 2018 12:10:09 +0000
Message-Id: <1517314210-25684-3-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517314210-25684-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1517314210-25684-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 3/4] runqueue: Optimize recrdepends handling
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
X-List-Received-Date: Tue, 30 Jan 2018 12:10:14 -0000

We can optimise the loops slightly so we only process given substrings
once rather than many times. This means expanding out add_resolved_dependencies.

Also add a function which allows replacement of the task element of a
task id, reducing the amount of string handling we're doing in a performance
critical loop.

Its also clear that later code adds to the tasks depends so we don't need
to add .depends() to extradeps at the start.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 5f53fe7..bbfe9ee 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -74,6 +74,9 @@ def build_tid(mc, fn, taskname):
         return "multiconfig:" + mc + ":" + fn + ":" + taskname
     return fn + ":" + taskname
 
+def tid_replacetask(tid, taskname):
+    return tid.rsplit(":", 1)[0] + ":" + taskname
+
 class RunQueueStats:
     """
     Holds statistics on the tasks handled by the associated runQueue
@@ -581,12 +584,6 @@ class RunQueueData:
                     if t in taskData[mc].taskentries:
                         depends.add(t)
 
-        def add_resolved_dependencies(mc, fn, tasknames, depends):
-            for taskname in tasknames:
-                tid = build_tid(mc, fn, taskname)
-                if tid in self.runtaskentries:
-                    depends.add(tid)
-
         for mc in taskData:
             for tid in taskData[mc].taskentries:
 
@@ -689,16 +686,22 @@ class RunQueueData:
             extradeps = {}
 
             for taskcounter, tid in enumerate(recursivetasks):
-                extradeps[tid] = set(self.runtaskentries[tid].depends)
+                extradeps[tid] = set()
 
                 tasknames = recursivetasks[tid]
                 seendeps = set()
+                seenbasedeps = set()
 
                 def generate_recdeps(t):
                     newdeps = set()
-                    (mc, fn, taskname, _) = split_tid_mcfn(t)
-                    add_resolved_dependencies(mc, fn, tasknames, newdeps)
-                    extradeps[tid].update(newdeps)
+                    basetid = fn_from_tid(t)
+                    if basetid not in seenbasedeps:
+                        for taskname in tasknames:
+                            newtid = tid_replacetask(t, taskname)
+                            if newtid in self.runtaskentries and newtid not in seendeps:
+                                newdeps.add(newtid)
+                                extradeps[tid].add(newtid)
+                        seenbasedeps.add(basetid)
                     seendeps.add(t)
                     newdeps.add(t)
                     for i in newdeps:
-- 
2.7.4


