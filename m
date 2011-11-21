Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RSXAy-00008L-0k for bitbake-devel@lists.openembedded.org;
	Mon, 21 Nov 2011 17:57:00 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pALGoVsu009097
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Nov 2011 16:50:31 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 08308-08 for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Nov 2011 16:50:28 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pALGoNWn009091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Nov 2011 16:50:24 GMT
Message-ID: <1321894228.18926.35.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 21 Nov 2011 16:50:28 +0000
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: bitbake/runqueue.py: Ensure we fully process the covered list
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
X-List-Received-Date: Mon, 21 Nov 2011 16:57:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The existing looping code can mask an existing "found = True"
by forcing it to False each time. This can lead to dependency
lists not being fully searched and results in dependency errors.

An exmaple of this was the autobuilder building linux-yocto from
sstate but then rebuilding some of the recipe's tasks for no
apparent reason. Separating the logic into two variables solves this
problem since any "found = True" value is now always preserved.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 98124af..54b1c86 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1211,12 +1211,13 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 if task in self.rq.scenequeue_covered:
                     continue
                 if len(self.rqdata.runq_revdeps[task]) > 0 and self.rqdata.runq_revdeps[task].issubset(self.rq.scenequeue_covered):
-                    found = True
+                    ok = True
                     for revdep in self.rqdata.runq_revdeps[task]:
                         if self.rqdata.runq_fnid[task] != self.rqdata.runq_fnid[revdep]:
-                            found = False
+                            ok = False
                             break
-                    if found:
+                    if ok:
+                        found = True
                         self.rq.scenequeue_covered.add(task)
 
         # Detect when the real task needs to be run anyway by looking to see




