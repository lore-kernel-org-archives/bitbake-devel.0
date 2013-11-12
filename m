Return-Path: <cristiana.voicu@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 7F58B6D4FC
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Nov 2013 14:45:01 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 12 Nov 2013 06:45:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="407483255"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.65])
	by orsmga001.jf.intel.com with ESMTP; 12 Nov 2013 06:45:01 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Nov 2013 16:50:24 +0200
Message-Id: <1384267824-19862-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] toaster: convert build_package size to bytes to keep consistence
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
X-List-Received-Date: Tue, 12 Nov 2013 14:45:03 -0000

[YOCTO #5503]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py               |    2 +-
 .../lib/toaster/bldviewer/templates/bpackage.html  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index c3809ef..6dcf459 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -186,7 +186,7 @@ class ORMWrapper(object):
                                        revision = package_info['PKGR'],
                                        summary = package_info['SUMMARY'],
                                        description = package_info['DESCRIPTION'],
-                                       size = package_info['PKGSIZE'],
+                                       size = int(package_info['PKGSIZE']) * 1024,
                                        section = package_info['SECTION'],
                                        license = package_info['LICENSE'],
                                        )
diff --git a/bitbake/lib/toaster/bldviewer/templates/bpackage.html b/bitbake/lib/toaster/bldviewer/templates/bpackage.html
index 2e254db..4e6d9c6 100644
--- a/bitbake/lib/toaster/bldviewer/templates/bpackage.html
+++ b/bitbake/lib/toaster/bldviewer/templates/bpackage.html
@@ -13,7 +13,7 @@
             <th>Summary</th>
             <th>Section</th>
             <th>Description</th>
-            <th>Size on host disk (KBytes)</th>
+            <th>Size on host disk (Bytes)</th>
             <th>License</th>
             <th>Dependencies List (all)</th>
             </tr>
-- 
1.7.9.5


