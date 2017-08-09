Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id AA4F577D0C
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Aug 2017 09:56:21 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v799uJq9003524
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Wed, 9 Aug 2017 10:56:20 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dfNit-00049S-Rh; Wed, 09 Aug 2017 10:56:19 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Aug 2017 10:56:16 +0100
Message-Id: <1502272577-15918-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Wed, 09 Aug 2017 10:56:21 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 1/2] cooker/siggen: Reset siggen when reparsing
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
X-List-Received-Date: Wed, 09 Aug 2017 09:56:22 -0000

If we don't do this, we get basehash mismatch errors occurring from the reparse
which would then set bitbake's error exit code.

This for example would cause oe-selftest -r bbtests.BitbakeTests.test_bbappend_order
to fail with a non-zero BB_SERVER_TIMEOUT.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 1 +
 lib/bb/siggen.py | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 81027db..3740c61 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1468,6 +1468,7 @@ class BBCooker:
             self.updateCacheSync()
 
         if self.state != state.parsing and not self.parsecache_valid:
+            bb.parse.siggen.reset(self.data)
             self.parseConfiguration ()
             if CookerFeatures.SEND_SANITYEVENTS in self.featureset:
                 for mc in self.multiconfigs:
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index f71190a..4380760 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -94,6 +94,9 @@ class SignatureGeneratorBasic(SignatureGenerator):
         else:
             self.checksum_cache = None
 
+    def reset(self, data):
+        self.__init__(data)
+
     def init_rundepcheck(self, data):
         self.taskwhitelist = data.getVar("BB_HASHTASK_WHITELIST") or None
         if self.taskwhitelist:
-- 
2.7.4


