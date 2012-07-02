Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Slfw0-0008Q8-U5 for bitbake-devel@lists.openembedded.org;
	Mon, 02 Jul 2012 14:40:57 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q62CTucN030963
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 2 Jul 2012 13:29:56 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 29631-04 for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Jul 2012 13:29:52 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q62CTlS4030957
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 2 Jul 2012 13:29:49 +0100
Message-ID: <1341232193.23146.225.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 02 Jul 2012 13:29:53 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] runqueue.py: Allow recrdeptasks that have self references
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
X-List-Received-Date: Mon, 02 Jul 2012 12:40:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

In some cases we want to pull in DEPENDS and RDEPENDS of recrdeptask
dependencies but we need a way to trigger or avoid this behaviour
depending on context. The logical syntax to trigger such behaviour
would be a self referencing recrdeptask:

do_a[recrdeptask] = "do_a do_b"

The dependency chains already recurse this kind of expression correctly, the
missing piece is to avoid any circular reference errors. Since the dependencies
have already been recursively resolved, simply removing any recrdeptask
references is enough to break the circular references.

This patch therefore removes any circular references using the set
difference_update() operator. There will be metadata tweaks required to
add any references needed to the extra taskname.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index f457ec2..212d297 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -510,7 +510,7 @@ class RunQueueData:
         # We need to do this separately since we need all of self.runq_depends to be complete before this is processed
         extradeps = {}
         for task in recursivetasks:
-            extradeps[task] = set()
+            extradeps[task] = set(self.runq_depends[task])
             tasknames = recursivetasks[task]
             seendeps = set()
             seenfnid = []
@@ -527,10 +527,15 @@ class RunQueueData:
                             generate_recdeps(n)
             generate_recdeps(task)
 
+        # Remove circular references so that do_a[recrdeptask] = "do_a do_b" can work
+        recursivetaskset = set(recursivetasks.keys())
+        for task in recursivetasks:
+            extradeps[task].difference_update(recursivetaskset)
+
         for task in xrange(len(taskData.tasks_name)):
             # Add in extra dependencies
             if task in extradeps:
-                 self.runq_depends[task].update(extradeps[task])
+                 self.runq_depends[task] = extradeps[task]
             # Remove all self references
             if task in self.runq_depends[task]:
                 logger.debug(2, "Task %s (%s %s) contains self reference! %s", task, taskData.fn_index[taskData.tasks_fnid[task]], taskData.tasks_name[task], self.runq_depends[task])




