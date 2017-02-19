Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3A60A71CB8
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 19 Feb 2017 14:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v1JEGFhx026082; Sun, 19 Feb 2017 14:16:15 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 4f0koHbSk77K; Sun, 19 Feb 2017 14:16:15 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v1JEGBgq026072
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 19 Feb 2017 14:16:14 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cfSHb-00077s-6Z; Sun, 19 Feb 2017 06:16:11 -0800
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 19 Feb 2017 06:16:09 -0800
Message-Id: <1487513769-27354-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] runqueue: Fix collapsed setscene dependency tree
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
X-List-Received-Date: Sun, 19 Feb 2017 14:16:17 -0000

When we removed the postinst sstate dependency handling code from
setscene_depvalid, we noticed things being installed into the old
style sysroot for rootfs tasks which should not have been there,
causing a performance regression.

Analysis revealed that setscene dependencies were "bubbling" over
sstate tasks when they should have been stopping there. The
'continue' added by this patch avoids this issue and eusures
sstate tasks remain contained to their specific chains.

There was another bug in the code this exposed where the acconting
for tasks as they were removed from sq_revdeps was not correct. In
fixing this, what looks like a workaround in another test can then
be simplified.

After this change, populate_sysroot tasks are no longer depending
on package_write_rpm tasks for example, which would make no sense.

A before/after analysis of image dependencies only revealed improved
dependencies after this change.

Recipe specific sysroots did highlight the issue here since the
behaviour of the sysroot dependencies (and processing with depvalid)
was not matching what bitbake itself was doing, with bitbake being
incorrect. Failures were 'safe' in that too many dependencies would
get installed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 728b5fb..a3b451a 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2010,6 +2010,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         for tid in self.rqdata.runq_setscene_tids:
             #bb.warn("Added endpoint 2 %s" % (tid))
             for dep in self.rqdata.runtaskentries[tid].depends:
+                    if tid in sq_revdeps[dep]:
+                        sq_revdeps[dep].remove(tid)
                     if dep not in endpoints:
                         endpoints[dep] = set()
                     #bb.warn("  Added endpoint 3 %s" % (dep))
@@ -2029,12 +2031,13 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 if point in self.rqdata.runq_setscene_tids:
                     sq_revdeps_new[point] = tasks
                     tasks = set()
+                    continue
                 for dep in self.rqdata.runtaskentries[point].depends:
                     if point in sq_revdeps[dep]:
                         sq_revdeps[dep].remove(point)
                     if tasks:
                         sq_revdeps_new[dep] |= tasks
-                    if (len(sq_revdeps[dep]) == 0 or len(sq_revdeps_new[dep]) != 0) and dep not in self.rqdata.runq_setscene_tids:
+                    if len(sq_revdeps[dep]) == 0 and dep not in self.rqdata.runq_setscene_tids:
                         newendpoints[dep] = task
             if len(newendpoints) != 0:
                 process_endpoints(newendpoints)
-- 
2.7.4


