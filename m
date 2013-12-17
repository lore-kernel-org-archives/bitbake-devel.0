Return-Path: <cristiana.voicu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id AC3046E4C1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Dec 2013 12:57:47 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 17 Dec 2013 04:53:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,501,1384329600"; d="scan'208";a="445629209"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.151])
	by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2013 04:57:46 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 17 Dec 2013 15:04:03 +0200
Message-Id: <1387285447-18057-2-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1387285447-18057-1-git-send-email-cristiana.voicu@intel.com>
References: <1387285447-18057-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH 1/5] hob: replace hob-toolchain with meta-toolchain
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
X-List-Received-Date: Tue, 17 Dec 2013 12:57:47 -0000

In order to remove meta-hob, hob-toolchain was removed.
In hob, it was replaced with meta-toolchain.

[YOCTO #5118]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py         |    2 +-
 meta-hob/recipes-core/meta/hob-toolchain.bb |    9 ---------
 2 files changed, 1 insertion(+), 10 deletions(-)
 delete mode 100644 meta-hob/recipes-core/meta/hob-toolchain.bb

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 1eae814..0ce9297 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -374,7 +374,7 @@ class Builder(gtk.Window):
         super(Builder, self).__init__()
 
         self.hob_image = "hob-image"
-        self.hob_toolchain = "hob-toolchain"
+        self.hob_toolchain = "meta-toolchain"
 
         # handler
         self.handler = hobHandler
diff --git a/meta-hob/recipes-core/meta/hob-toolchain.bb b/meta-hob/recipes-core/meta/hob-toolchain.bb
deleted file mode 100644
index 6f1a3d4..0000000
--- a/meta-hob/recipes-core/meta/hob-toolchain.bb
+++ /dev/null
@@ -1,9 +0,0 @@
-DESCRIPTION = "dummy toolchain"
-LICENSE = "MIT"
-
-PR = "r0"
-
-LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=3f40d7994397109285ec7b81fdeb3b58 \
-                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"
-
-inherit populate_sdk
-- 
1.7.9.5


