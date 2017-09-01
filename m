Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id A8AA765C5B
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Sep 2017 15:59:48 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v81FxiF6029595
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 1 Sep 2017 16:59:45 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dnoMC-0002K4-0N; Fri, 01 Sep 2017 16:59:44 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Sep 2017 16:59:42 +0100
Message-Id: <1504281582-8889-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Fri, 01 Sep 2017 16:59:45 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] cooker: Ensure parseConfiguration clears parsecache_valid
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
X-List-Received-Date: Fri, 01 Sep 2017 15:59:49 -0000

BB_SERVER_TIMEOUT=100 oe-selftest -r bblayers

was failing and highlighted that since parseConfiguation clears data
structures, it needs to also clear parsecache_valid as it no longer
contains correct data.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index ab3de91..f5ae831 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -418,6 +418,8 @@ class BBCooker:
 
         self.handleCollections(self.data.getVar("BBFILE_COLLECTIONS"))
 
+        self.parsecache_valid = False
+
     def updateConfigOpts(self, options, environment, cmdline):
         self.ui_cmdline = cmdline
         clean = True
-- 
2.7.4


