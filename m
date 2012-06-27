Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SjpIa-0007Zn-Gb for bitbake-devel@lists.openembedded.org;
	Wed, 27 Jun 2012 12:16:36 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5RA5fm5010498
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jun 2012 11:05:41 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 06198-03 for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jun 2012 11:05:35 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5RA5Wc5010492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jun 2012 11:05:33 +0100
Message-ID: <1340791536.23146.14.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 27 Jun 2012 11:05:36 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] runqueue.py: Enhance add_xxx_dependencies to return the fnid it resolved to
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
X-List-Received-Date: Wed, 27 Jun 2012 10:16:36 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This extra data is required for the recrdepends fixes.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index c45287d..0621e9e 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -399,6 +399,7 @@ class RunQueueData:
         # rdeptast, recrdeptask, idepends).
 
         def add_build_dependencies(depids, tasknames, depends):
+            fnids = []
             for depid in depids:
                 # Won't be in build_targets if ASSUME_PROVIDED
                 if depid not in taskData.build_targets:
@@ -406,22 +407,27 @@ class RunQueueData:
                 depdata = taskData.build_targets[depid][0]
                 if depdata is None:
                     continue
+                fnids.append(depdata)
                 for taskname in tasknames:
                     taskid = taskData.gettask_id_fromfnid(depdata, taskname)
                     if taskid is not None:
                         depends.add(taskid)
+            return fnids
 
         def add_runtime_dependencies(depids, tasknames, depends):
+            fnids = []
             for depid in depids:
                 if depid not in taskData.run_targets:
                     continue
                 depdata = taskData.run_targets[depid][0]
                 if depdata is None:
                     continue
+                fnids.append(depdata)
                 for taskname in tasknames:
                     taskid = taskData.gettask_id_fromfnid(depdata, taskname)
                     if taskid is not None:
                         depends.add(taskid)
+            return fnids
 
         for task in xrange(len(taskData.tasks_name)):
             depends = set()




