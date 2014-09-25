Return-Path: <alejandro.hernandez@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 97DBD609B2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Sep 2014 23:14:56 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 25 Sep 2014 16:08:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,600,1406617200"; d="scan'208";a="579177515"
Received: from aehernan-devstation.zpn.intel.com ([10.219.4.73])
	by orsmga001.jf.intel.com with ESMTP; 25 Sep 2014 16:14:36 -0700
From: Alejandro Hernandez <alejandro.hernandez@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Sep 2014 18:14:45 -0500
Message-Id: <1411686885-8169-1-git-send-email-alejandro.hernandez@linux.intel.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH] fetcher: fix BB_STRICT_CHECKSUM datatype check
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
X-List-Received-Date: Thu, 25 Sep 2014 23:14:56 -0000

[YOCTO #6762]

Signed-off-by: Alejandro Hernandez <alejandro.hernandez@linux.intel.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index df2f2b0..e182a9d 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -544,7 +544,7 @@ def verify_checksum(ud, d):
     if ud.method.recommends_checksum(ud):
         # If strict checking enabled and neither sum defined, raise error
         strict = d.getVar("BB_STRICT_CHECKSUM", True) or None
-        if strict and not (ud.md5_expected or ud.sha256_expected):
+        if (strict == 1) and not (ud.md5_expected or ud.sha256_expected):
             logger.error('No checksum specified for %s, please add at least one to the recipe:\n'
                              'SRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"' %
                              (ud.localpath, ud.md5_name, md5data,
-- 
1.9.1


