Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 6C9CF77629
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Feb 2018 07:23:57 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w1R7Nw4W011603
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Feb 2018 23:23:58 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.361.1; Mon, 26 Feb 2018 23:23:33 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 27 Feb 2018 15:28:09 +0800
Message-ID: <f909a91f9795300a24d76013bfeb019024df6b88.1519716375.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1519716375.git.liezhi.yang@windriver.com>
References: <cover.1519716375.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/3] bitbake: cooker: don't preserve BB_CONSOLELOG
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
X-List-Received-Date: Tue, 27 Feb 2018 07:23:57 -0000
Content-Type: text/plain

Fixed:
$ bitbake --server-only -T -1
Set MACHINE = "qemux86" in conf/local.conf
$ bitbake quilt
Set MACHINE = "qemuppc" in conf/local.conf
$ bitbake quilt

The log still goes into tmp/log/cooker/qemux86 in the second run, this is
incorrect (should be tmp/log/cooker/qemuppc). I checked the code, the ui
initializes it every time when it starts, so let it use the up-to-date
one rather than old one.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cooker.py | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index af482f9..3f113ae 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -326,11 +326,6 @@ class BBCooker:
         self.state = state.initial
         self.caches_array = []
 
-        # Need to preserve BB_CONSOLELOG over resets
-        consolelog = None
-        if hasattr(self, "data"):
-            consolelog = self.data.getVar("BB_CONSOLELOG")
-
         if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
             self.enableDataTracking()
 
@@ -358,9 +353,6 @@ class BBCooker:
         self.data_hash = self.databuilder.data_hash
         self.extraconfigdata = {}
 
-        if consolelog:
-            self.data.setVar("BB_CONSOLELOG", consolelog)
-
         self.data.setVar('BB_CMDLINE', self.ui_cmdline)
 
         #
-- 
2.7.4


