Return-Path: <valentin.popa@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 86FBB6FA41
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Jun 2014 13:19:24 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 05 Jun 2014 06:19:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.98,981,1392192000"; d="scan'208";a="550216649"
Received: from vpopa-desktop.rb.intel.com ([10.237.105.76])
	by fmsmga002.fm.intel.com with ESMTP; 05 Jun 2014 06:19:24 -0700
From: Valentin Popa <valentin.popa@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  5 Jun 2014 16:18:47 +0300
Message-Id: <1401974327-6414-1-git-send-email-valentin.popa@intel.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH] bitbake: fix contains_any()
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
X-List-Received-Date: Thu, 05 Jun 2014 13:19:25 -0000

"in" doesn't work for this case where
checkvalues is a set.

Signed-off-by: Valentin Popa <valentin.popa@intel.com>
---
 bitbake/lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 96d8218..1ff201f 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -851,7 +851,7 @@ def contains_any(variable, checkvalues, truevalue, falsevalue, d):
         checkvalues = set(checkvalues.split())
     else:
         checkvalues = set(checkvalues)
-    if checkvalues in val:
+    if checkvalues & val != set([]):
         return truevalue
     return falsevalue
 
-- 
1.9.1


