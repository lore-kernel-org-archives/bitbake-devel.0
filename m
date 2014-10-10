Return-Path: <alejandro.hernandez@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 7846C6FBB9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Oct 2014 18:14:14 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 10 Oct 2014 11:14:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,693,1406617200"; d="scan'208";a="612603607"
Received: from aehernan-devstation.zpn.intel.com ([10.219.4.60])
	by fmsmga002.fm.intel.com with ESMTP; 10 Oct 2014 11:14:01 -0700
From: Alejandro Hernandez <alejandro.hernandez@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Oct 2014 13:13:46 -0500
Message-Id: <1412964826-9586-1-git-send-email-alejandro.hernandez@linux.intel.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH] fetcher: fix getVar call due to incorrect argument datatype
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
X-List-Received-Date: Fri, 10 Oct 2014 18:14:18 -0000

Signed-off-by: Alejandro Hernandez <alejandro.hernandez@linux.intel.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 10c3346..5341ebf 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -543,7 +543,7 @@ def verify_checksum(ud, d):
 
     if ud.method.recommends_checksum(ud):
         # If strict checking enabled and neither sum defined, raise error
-        strict = d.getVar("BB_STRICT_CHECKSUM", "1") or "0"
+        strict = d.getVar("BB_STRICT_CHECKSUM", True) or "0"
         if (strict == "1") and not (ud.md5_expected or ud.sha256_expected):
             logger.error('No checksum specified for %s, please add at least one to the recipe:\n'
                              'SRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"' %
-- 
1.9.1


