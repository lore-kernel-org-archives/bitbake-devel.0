Return-Path: <bunk@stusta.de>
X-Greylist: delayed 484 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 21 Feb 2020 21:00:18 UTC
Received: from mail.stusta.mhn.de (mail.stusta.mhn.de [141.84.69.5])
	by mail.openembedded.org (Postfix) with ESMTP id 82CA261774
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Feb 2020 21:00:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.stusta.mhn.de (Postfix) with ESMTPSA id 48PNtk4x83z40
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Feb 2020 21:52:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stusta.de;
	s=default; t=1582318334;
	bh=jKF/5RAuWXtiyT2jAakwEaSyf0DZkQZ55n68KM0ossw=;
	h=From:To:Subject:Date:From;
	b=hLkr6dsnSIuSAdWbwCLELP4EenRPOG1rKH+3DiR4RYrzBvwwIFJDoUk/u5inhqzjr
	yMWIPlvMRXt8oLGi5TmawVDg4hVxvCHLREyjw/6Is3tnH5kuoGShRI5R8cRS+4WJOV
	sxtHN/4LxEvoUcPg25vXUca5RyBa29eS9xIR1eJrep3Z+06PGOaMzTV8rqcL+HM7nq
	eCdldvcMsxZxnMh8+GVcLpKO8MFanFA1CNcBX+QPx7ROc2JYHoPLnBTdlMtoV5JBrH
	8RSkC33oRPL0/Aw9ZlT5dGUSEW8iJhprVi0wVlI+leE2j/Gz5KfhoAm5ZopiA1U/Vn
	1vNT21zs72GgG8iev7PZ9pU0BgZPhv3ZSyOhgPBzk3Goq1noMtWEEZjgvdN5bDHRDA
	+2blnqaPROY69r/POIZLIQ/anpybFj07E3rgpdY3Pmb91IThmTLuroodk/GSfxJkKS
	e+lfi0xUel8kn+PyEEXHzvnVPVM7I6LZZk6D8/Pc3lbdax9zuGYnjdwD/MMvkZ2TxG
	MKh/8NsTMnHVkjqW9wojpXKkpbDgywzfc9iFQDu75YC2+PcYqkakVRJLmA9gYeTdvi
	eWJnFLS6bMgTywKY+t2vK8PF3NLC8+tKiSIDyMMlAs2munIai5MrTC6Vzn6fEfvQ4q
	coDWgf2Kb0yvHz5Bk991wKBw=
From: Adrian Bunk <bunk@stusta.de>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 21 Feb 2020 22:52:13 +0200
Message-Id: <20200221205213.16130-1-bunk@stusta.de>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH] Lower priority of debug messages that should not be shown on the console
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
X-List-Received-Date: Fri, 21 Feb 2020 21:00:18 -0000

Signed-off-by: Adrian Bunk <bunk@stusta.de>
---
 bitbake/lib/bb/runqueue.py | 8 ++++----
 bitbake/lib/bb/siggen.py   | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 71108eeed7..f6bd8db8ce 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -2054,7 +2054,7 @@ class RunQueueExecute:
         self.update_holdofftasks()
 
         if not self.sq_live and not self.sqdone and not self.sq_deferred and not self.updated_taskhash_queue and not self.holdoff_tasks:
-            logger.info("Setscene tasks completed")
+            logger.debug(1, "Setscene tasks completed")
 
             err = self.summarise_scenequeue_errors()
             if err:
@@ -2259,7 +2259,7 @@ class RunQueueExecute:
             self.updated_taskhash_queue.remove((tid, unihash))
 
             if unihash != self.rqdata.runtaskentries[tid].unihash:
-                logger.info("Task %s unihash changed to %s" % (tid, unihash))
+                logger.debug(1, "Task %s unihash changed to %s" % (tid, unihash))
                 self.rqdata.runtaskentries[tid].unihash = unihash
                 bb.parse.siggen.set_unihash(tid, unihash)
                 toprocess.add(tid)
@@ -2304,7 +2304,7 @@ class RunQueueExecute:
                 elif tid in self.scenequeue_covered or tid in self.sq_live:
                     # Already ran this setscene task or it running. Report the new taskhash
                     bb.parse.siggen.report_unihash_equiv(tid, newhash, origuni, newuni, self.rqdata.dataCaches)
-                    logger.info("Already covered setscene for %s so ignoring rehash (remap)" % (tid))
+                    logger.debug(1, "Already covered setscene for %s so ignoring rehash (remap)" % (tid))
                     remapped = True
 
                 if not remapped:
@@ -2405,7 +2405,7 @@ class RunQueueExecute:
 
         for (tid, harddepfail, origvalid) in update_tasks:
             if tid in self.sqdata.valid and not origvalid:
-                logger.info("Setscene task %s became valid" % tid)
+                logger.debug(1, "Setscene task %s became valid" % tid)
             if harddepfail:
                 self.sq_task_failoutright(tid)
 
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index c2d0c736cf..d5c5c5c0af 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -606,7 +606,7 @@ class SignatureGeneratorUniHashMixIn(object):
                 method = method + self.extramethod[tid]
 
             data = self.client().report_unihash_equiv(taskhash, method, wanted_unihash, extra_data)
-            bb.note('Reported task %s as unihash %s to %s (%s)' % (tid, wanted_unihash, self.server, str(data)))
+            bb.debug(1, 'Reported task %s as unihash %s to %s (%s)' % (tid, wanted_unihash, self.server, str(data)))
 
             if data is None:
                 bb.warn("Server unable to handle unihash report")
@@ -615,9 +615,9 @@ class SignatureGeneratorUniHashMixIn(object):
             finalunihash = data['unihash']
 
             if finalunihash == current_unihash:
-                bb.note('Task %s unihash %s unchanged by server' % (tid, finalunihash))
+                bb.debug(1, 'Task %s unihash %s unchanged by server' % (tid, finalunihash))
             elif finalunihash == wanted_unihash:
-                bb.note('Task %s unihash changed %s -> %s as wanted' % (tid, current_unihash, finalunihash))
+                bb.debug(1, 'Task %s unihash changed %s -> %s as wanted' % (tid, current_unihash, finalunihash))
                 self.set_unihash(tid, finalunihash)
                 return True
             else:
-- 
2.17.1


