Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 2D3747875F
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Feb 2018 15:15:08 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w11FF51j020321
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 1 Feb 2018 07:15:08 -0800
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.361.1; Thu, 1 Feb 2018 07:15:03 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 1 Feb 2018 23:15:25 +0800
Message-ID: <48f4881a33e65e2162ca1df077982561058f040c.1517497731.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1517497731.git.liezhi.yang@windriver.com>
References: <cover.1517497731.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 4/8] bitbake: cooker: don't preserve BB_CONSOLELOG
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
X-List-Received-Date: Thu, 01 Feb 2018 15:15:08 -0000
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


