Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RqOx1-0004iK-15 for bitbake-devel@lists.openembedded.org;
	Thu, 26 Jan 2012 14:01:15 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0QCrREE022358
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jan 2012 12:53:27 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 22219-02 for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jan 2012 12:53:22 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0QCrK3Q022348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jan 2012 12:53:21 GMT
Message-ID: <1327582401.19643.372.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 26 Jan 2012 12:53:21 +0000
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] runqueue.py: Fix missing setscene dependencies
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
X-List-Received-Date: Thu, 26 Jan 2012 13:01:15 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When constructing the setscene inter-dependencies, we need to account for all task,
not just the last one found. This patch corrects this oversight and ensures all
dependencies are added, not just the first one found.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index c74e73c..a4030b3 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1435,18 +1435,20 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             sq_revdeps.append(copy.copy(self.rqdata.runq_revdeps[task]))
             sq_revdeps_new.append(set())
             if (len(self.rqdata.runq_revdeps[task]) == 0) and task not in self.rqdata.runq_setscene:
-                endpoints[task] = None
+                endpoints[task] = set()
 
         for task in self.rqdata.runq_setscene:
             for dep in self.rqdata.runq_depends[task]:
-                    endpoints[dep] = task
+                    if dep not in endpoints:
+                        endpoints[dep] = set()
+                    endpoints[dep].add(task)
 
         def process_endpoints(endpoints):
             newendpoints = {}
             for point, task in endpoints.items():
                 tasks = set()
                 if task:
-                    tasks.add(task)
+                    tasks |= task
                 if sq_revdeps_new[point]:
                     tasks |= sq_revdeps_new[point]
                 sq_revdeps_new[point] = set()




