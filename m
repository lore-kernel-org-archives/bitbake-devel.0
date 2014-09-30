Return-Path: <alejandro.hernandez@linux.intel.com>
X-Greylist: delayed 608 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 30 Sep 2014 16:32:46 UTC
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id A6EB66017E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Sep 2014 16:32:46 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 30 Sep 2014 09:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,627,1406617200"; d="scan'208";a="581355130"
Received: from aehernan-devstation.zpn.intel.com ([10.219.4.60])
	by orsmga001.jf.intel.com with ESMTP; 30 Sep 2014 09:22:10 -0700
From: Alejandro Hernandez <alejandro.hernandez@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Sep 2014 11:21:58 -0500
Message-Id: <1412094118-27406-1-git-send-email-alejandro.hernandez@linux.intel.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH v2] fetcher: fix BB_STRICT_CHECKSUM datatype check
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
X-List-Received-Date: Tue, 30 Sep 2014 16:32:54 -0000

Forcing strict to be a string, to avoid problems when performing comparisons

[YOCTO #6762]

Signed-off-by: Alejandro Hernandez <alejandro.hernandez@linux.intel.com>
---
 lib/bb/fetch2/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index df2f2b0..10c3346 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -543,8 +543,8 @@ def verify_checksum(ud, d):
 
     if ud.method.recommends_checksum(ud):
         # If strict checking enabled and neither sum defined, raise error
-        strict = d.getVar("BB_STRICT_CHECKSUM", True) or None
-        if strict and not (ud.md5_expected or ud.sha256_expected):
+        strict = d.getVar("BB_STRICT_CHECKSUM", "1") or "0"
+        if (strict == "1") and not (ud.md5_expected or ud.sha256_expected):
             logger.error('No checksum specified for %s, please add at least one to the recipe:\n'
                              'SRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"' %
                              (ud.localpath, ud.md5_name, md5data,
-- 
1.9.1


