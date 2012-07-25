Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Su7GS-0000Vo-Rs for bitbake-devel@lists.openembedded.org;
	Wed, 25 Jul 2012 21:28:57 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6PJHRgq014141
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2012 20:17:27 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12259-10 for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2012 20:17:22 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6PJHKiL014134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2012 20:17:21 +0100
Message-ID: <1343243839.27838.16.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 25 Jul 2012 20:17:19 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] runqueue.py: Optimise the hashvalidate call to only process tasks we may actually want
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
X-List-Received-Date: Wed, 25 Jul 2012 19:28:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently we call the hashvalidate for anything without a valid setscene stamp.
This improves the code to account for existing stamp files so that we only process
setscene hashes for things we might actually end up using. This avoids hash processing
and makes things slightly more efficient and the logs less confusing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 2925741..fd33d07 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1510,6 +1510,12 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                     self.task_skip(task)
                     continue
 
+                if self.rq.check_stamp_task(realtask, taskname, recurse = True, cache=self.stampcache):
+                    logger.debug(2, 'Normal stamp current for task %s(%s)', task, self.rqdata.get_user_idstring(realtask))
+                    stamppresent.append(task)
+                    self.task_skip(task)
+                    continue
+
                 sq_fn.append(fn)
                 sq_hashfn.append(self.rqdata.dataCache.hashfn[fn])
                 sq_hash.append(self.rqdata.runq_hash[realtask])




