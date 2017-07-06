Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 72C9971BEE
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Jul 2017 15:48:12 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v66FmB7w032634
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 6 Jul 2017 16:48:12 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dT90l-0003Pd-M4; Thu, 06 Jul 2017 16:48:11 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  6 Jul 2017 16:48:06 +0100
Message-Id: <1499356087-13072-2-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1499356087-13072-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1499356087-13072-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Thu, 06 Jul 2017 16:48:12 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 2/3] cooker: Experiment with multiple BuildStarted for multiconfig
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
X-List-Received-Date: Thu, 06 Jul 2017 15:48:12 -0000

Currently builds in multiple TMPDIRs with multiconfig can break
since the BuildStarted event is used to create directory strutures in several
cases (e.g. buildstats.bbclass) and there is only on BuildStarted event
generated in a multiconfig build.

We have two options, a) to add a new MultiConfigBuildStarted event which is
generated once per multiconfig, or b) allow multiple BuildStarted events.

Having reviewed the code and current users of BuildStarted, sending one event
per multiconfig seems like its the best way forward and the existing code looks
able to cope with the duplication of events. I did also check toaster and I think
that can handle this issue too (multiconfig builds may have other issues there).

I'm therefore proposing we send multiple BuildStarted events for multiconfig
and for consistency, send multiple BuildCompleted events too.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 479dc5a..c140220 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1191,6 +1191,10 @@ class BBCooker:
         if siggen_cache:
             bb.parse.siggen.checksum_cache.mtime_cache.clear()
 
+    def copyBuildVars(self, d):
+        for i in ["BUILDNAME", "BUILDSTART", "DATE", "TIME"]:
+            d.setVar(i, self.data.getVar(i, False))
+
     def matchFiles(self, bf):
         """
         Find the .bb files which match the expression in 'buildfile'.
@@ -1362,7 +1366,10 @@ class BBCooker:
 
             if not retval:
                 try:
-                    bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runtaskentries), buildname, targets, failures, interrupted), self.data)
+                    for mc in self.multiconfigs:
+                        localdata = data.createCopy(self.databuilder.mcdata[mc])
+                        self.copyBuildVars(localdata)
+                        bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runtaskentries), buildname, targets, failures, interrupted), localdata)
                 finally:
                     self.command.finishAsyncCommand(msg)
                 return False
@@ -1395,7 +1402,10 @@ class BBCooker:
                 ntargets.append("multiconfig:%s:%s:%s" % (target[0], target[1], target[2]))
             ntargets.append("%s:%s" % (target[1], target[2]))
 
-        bb.event.fire(bb.event.BuildStarted(buildname, ntargets), self.data)
+        for mc in self.multiconfigs:
+            localdata = data.createCopy(self.databuilder.mcdata[mc])
+            self.copyBuildVars(localdata)
+            bb.event.fire(bb.event.BuildStarted(buildname, ntargets), localdata)
 
         rq = bb.runqueue.RunQueue(self, self.data, self.recipecaches, taskdata, runlist)
         if 'universe' in targets:
-- 
2.7.4


