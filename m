Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RTakj-0002gJ-GL for bitbake-devel@lists.openembedded.org;
	Thu, 24 Nov 2011 15:58:17 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAOEpjVB025717
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2011 14:51:45 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 25320-05 for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2011 14:51:40 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAOEpbbW025699
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2011 14:51:38 GMT
Message-ID: <1322146303.24143.27.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 24 Nov 2011 14:51:43 +0000
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] runqueue.py: Fix debug message to reference the correct task
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
X-List-Received-Date: Thu, 24 Nov 2011 14:58:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index f5598ca..1800634 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1524,8 +1524,9 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
 
             for task in xrange(len(self.sq_revdeps)):
                 if task not in valid_new and task not in noexec:
+                    realtask = self.rqdata.runq_setscene[task]
                     logger.debug(2, 'No package found, so skipping setscene task %s',
-                                 self.rqdata.get_user_idstring(task))
+                                 self.rqdata.get_user_idstring(realtask))
                     self.task_failoutright(task)
 
         logger.info('Executing SetScene Tasks')



