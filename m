Return-Path: <juro.bystricky@intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 5ED8C77AD4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Mar 2017 19:44:13 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga105.jf.intel.com with ESMTP; 17 Mar 2017 12:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,178,1486454400"; d="scan'208";a="61805746"
Received: from juro-precision-t5610.jf.intel.com ([10.7.198.53])
	by orsmga002.jf.intel.com with ESMTP; 17 Mar 2017 12:44:14 -0700
From: Juro Bystricky <juro.bystricky@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Mar 2017 12:44:07 -0700
Message-Id: <1489779847-31506-1-git-send-email-juro.bystricky@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: richard.purdie@intel.com
Subject: [PATCH] data.py: sort exported variables
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
X-List-Received-Date: Fri, 17 Mar 2017 19:44:14 -0000

Various run.do_xxx files export dozens of variables.
Presently they are in random order. Among other things,
this makes it difficult to compare two files for relevant changes.
This patch ensures they are enumerated/printed in a sorted
(alphabetical) order.

Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
---
 bitbake/lib/bb/data.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 0f05b60..d145f1b 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -220,7 +220,7 @@ def emit_func(func, o=sys.__stdout__, d = init()):
     """Emits all items in the data store in a format such that it can be sourced by a shell."""
 
     keys = (key for key in d.keys() if not key.startswith("__") and not d.getVarFlag(key, "func", False))
-    for key in keys:
+    for key in sorted(keys):
         emit_var(key, o, d, False)
 
     o.write('\n')
-- 
2.7.4


