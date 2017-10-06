Return-Path: <leonardo.sandoval.gonzalez@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 3CD0078227
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Oct 2017 15:11:05 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 Oct 2017 08:10:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,484,1500966000"; d="scan'208";a="1203024176"
Received: from yctb05.ostc.intel.com ([10.54.69.59])
	by fmsmga001.fm.intel.com with ESMTP; 06 Oct 2017 08:10:47 -0700
From: leonardo.sandoval.gonzalez@linux.intel.com
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Oct 2017 08:10:41 -0700
Message-Id: <20171006151043.55075-1-leonardo.sandoval.gonzalez@linux.intel.com>
X-Mailer: git-send-email 2.12.3
Subject: [PATCH v2 1/3] bitbake-user-manual/bitbake-user-manual: remove YP as build system
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
X-List-Received-Date: Fri, 06 Oct 2017 15:11:07 -0000

From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>

YP is not a build system, so it can not be used as build system example.

Signed-off-by: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-intro.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
index ca7f7246..08d9afdf 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
@@ -440,7 +440,7 @@
                     Build Checkout:</emphasis>
                     A final possibility for getting a copy of BitBake is that it
                     already comes with your checkout of a larger Bitbake-based build
-                    system, such as Poky or Yocto Project.
+                    system, such as Poky.
                     Rather than manually checking out individual layers and
                     gluing them together yourself, you can check
                     out an entire build system.
-- 
2.12.3


