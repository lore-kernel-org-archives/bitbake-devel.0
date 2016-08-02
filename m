Return-Path: <randy.e.witt@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id A5F5B6E5CB
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Aug 2016 23:43:57 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 02 Aug 2016 16:43:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,463,1464678000"; d="scan'208";a="1007328699"
Received: from bitbang.jf.intel.com ([10.7.199.68])
	by orsmga001.jf.intel.com with ESMTP; 02 Aug 2016 16:43:59 -0700
From: Randy Witt <randy.e.witt@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  2 Aug 2016 16:43:54 -0700
Message-Id: <1470181434-16019-1-git-send-email-randy.e.witt@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] toaster: --help now returns 0 instead of 1
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
X-List-Received-Date: Tue, 02 Aug 2016 23:44:00 -0000

If the user explicitly passes in "--help" then it should return 0. This
is the convention follow by the typical application. This allows the
user to check for options without triggering an error.

Signed-off-by: Randy Witt <randy.e.witt@linux.intel.com>
---
 bin/toaster | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bin/toaster b/bin/toaster
index e3a0dae..79ab301 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -203,6 +203,10 @@ for param in $*; do
                 ADDR_PORT="localhost:$PORT"
             fi
     ;;
+    --help)
+            echo "$HELP"
+            return 0
+    ;;
     *)
             echo "$HELP"
             return 1
-- 
2.7.4


