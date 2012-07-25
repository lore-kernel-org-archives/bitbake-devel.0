Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Su7F9-0000Td-7w for bitbake-devel@lists.openembedded.org;
	Wed, 25 Jul 2012 21:27:35 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6PJG5s8014119
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2012 20:16:06 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12259-09 for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2012 20:16:02 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6PJFsuj014113
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2012 20:15:57 +0100
Message-ID: <1343243752.27838.14.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 25 Jul 2012 20:15:52 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] runqueue.py: Fix a stamp comparision bug
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
X-List-Received-Date: Wed, 25 Jul 2012 19:27:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We check the stamp cache before comparing t2 and t3 which means that we can miss
a level in the stamp file chains. The result of this is that a stamp can be accepted
as valid when in fact it isn't. Some weird behaviour alerted me to this in a local
build.

This patch also fixes to only uses the cache in recurse mode, there was a corner
case where stamps not in recurse mode could get added to the cache which could cause
an issue potentially.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 0a8c723..306ae79 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -835,9 +835,6 @@ class RunQueue:
         t1 = get_timestamp(stampfile)
         for dep in self.rqdata.runq_depends[task]:
             if iscurrent:
-                if dep in cache:
-                    iscurrent = cache[dep]
-                    continue
                 fn2 = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[dep]]
                 taskname2 = self.rqdata.runq_task[dep]
                 stampfile2 = bb.build.stampfile(taskname2, self.rqdata.dataCache, fn2)
@@ -854,9 +851,15 @@ class RunQueue:
                         logger.debug(2, 'Stampfile %s < %s', stampfile, stampfile2)
                         iscurrent = False
                     if recurse and iscurrent:
-                        iscurrent = self.check_stamp_task(dep, recurse=True, cache=cache)
-                        cache[dep] = iscurrent
-        cache[task] = iscurrent
+                        if dep in cache:
+                            iscurrent = cache[dep]
+                            if not iscurrent:
+                                logger.debug(2, 'Stampfile for dependency %s:%s invalid (cached)' % (fn2, taskname2))
+                        else:
+                            iscurrent = self.check_stamp_task(dep, recurse=True, cache=cache)
+                            cache[dep] = iscurrent
+        if recurse:
+            cache[task] = iscurrent
         return iscurrent
 
     def execute_runqueue(self):




