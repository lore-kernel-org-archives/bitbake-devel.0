Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 987AA6011F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Sep 2016 15:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u8KFQvlX001022; Tue, 20 Sep 2016 16:26:57 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id a8f4awMAeDQi; Tue, 20 Sep 2016 16:26:57 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u8KFPncT000995
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 20 Sep 2016 16:25:50 +0100
Message-ID: <1474385149.7207.309.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 20 Sep 2016 16:25:49 +0100
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Cc: "Avery, Brian" <brian.avery@intel.com>
Subject: [PATCH] runqueue: Handle missing sstate dependencies better
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
X-List-Received-Date: Tue, 20 Sep 2016 15:27:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

If you "bitbake glibc-locale" then delete the libpcre-native sstate
and "bitbake glibc-locale -C package_write_rpm", it will fail with
rpmbuild missing the libprce library.

The reason is that libpcre-native fails to install from sstate (since
it isn't present) but doesn't get built and hence rpm-native tries to
run without its dependencies.

The simplest fix is not to add "covered" tasks which have failed to
install sstate. I can't help feeling there is more to this issue but
this does fix the current problem and shouldn't have adverse affects.
It is an unusual situation to have missing dependencies in sstate since
they're usually all present or not at all.

I've taken the opportunity to remove some old cruft from when we had
numeric task ids, the code can be simpler now.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 761c660..018025e 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1555,6 +1555,8 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 logger.debug(1, 'Considering %s: %s' % (tid, str(self.rqdata.runtaskentries[tid].revdeps)))
 
                 if len(self.rqdata.runtaskentries[tid].revdeps) > 0 and self.rqdata.runtaskentries[tid].revdeps.issubset(self.rq.scenequeue_covered):
+                    if tid in self.rq.scenequeue_notcovered:
+                        continue
                     found = True
                     self.rq.scenequeue_covered.add(tid)
 
@@ -2242,11 +2244,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         #        revdeps = self.sq_revdeps[tid]
         #        bb.warn("Found we didn't run %s %s %s" % (tid, buildable, str(revdeps)))
 
-        # Convert scenequeue_covered task numbers into full taskgraph ids
-        oldcovered = self.scenequeue_covered
-        self.rq.scenequeue_covered = set()
-        for task in oldcovered:
-            self.rq.scenequeue_covered.add(task)
+        self.rq.scenequeue_covered = self.scenequeue_covered
+        self.rq.scenequeue_notcovered = self.scenequeue_notcovered
 
         logger.debug(1, 'We can skip tasks %s', sorted(self.rq.scenequeue_covered))
 



