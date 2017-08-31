Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id E0F8E78310
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Aug 2017 17:06:04 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v7VH63C8032315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 31 Aug 2017 18:06:04 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dnSZG-0003fy-KX; Thu, 31 Aug 2017 17:43:46 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Aug 2017 17:43:45 +0100
Message-Id: <1504197825-14091-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Thu, 31 Aug 2017 18:06:04 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] cooker: Ensure buildFile doesn't have lasting side effects
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
X-List-Received-Date: Thu, 31 Aug 2017 17:06:05 -0000

BB_SERVER_TIMEOUT=100 oe-selftest -r devtool.DevtoolTests.test_devtool_build_image

fails, the reason is that internally, the limited_deps flag is set in
the bitbake server and then never cleared. This causes the sysroots to
be setup incorrectly (as per the limited dependency case) and builds
break. There is also potential for corruption of recipecaches.

Add shutdown/cleanup code to ensure these effects don't 'stick'.

This bug is particularly nasty as you can destroy TMPDIR with large
sysroots in build work directories which are prone to break.

Also ensure mtime cache is cleared (to match buildTargets) and
that no lasting changes are made to siggen either which ensures:

BB_SERVER_TIMEOUT=100 oe-selftest -r devtool.DevtoolTests.test_devtool_upgrade_git devtool.DevtoolTests.test_devtool_virtual_kernel_modify

works.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1ed3fd4..ab3de91 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1276,6 +1276,7 @@ class BBCooker:
         fn = self.matchFile(fn)
 
         self.buildSetVars()
+        self.reset_mtime_caches()
 
         bb_cache = bb.cache.Cache(self.databuilder, self.data_hash, self.caches_array)
 
@@ -1356,6 +1357,10 @@ class BBCooker:
                 if fireevents:
                     bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runtaskentries), buildname, item, failures, interrupted), self.databuilder.mcdata[mc])
                 self.command.finishAsyncCommand(msg)
+                # We trashed self.recipecaches above
+                self.parsecache_valid = False
+                self.configuration.limited_deps = False
+                bb.parse.siggen.reset(self.data)
                 if quietlog:
                     bb.runqueue.logger.setLevel(rqloglevel)
                 return False
-- 
2.7.4


