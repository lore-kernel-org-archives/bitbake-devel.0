Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 42FE477CF3
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Apr 2017 21:52:49 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga104.jf.intel.com with ESMTP; 06 Apr 2017 14:52:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,161,1488873600"; d="scan'208";a="1116565842"
Received: from anatara2-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.141.179])
	by orsmga001.jf.intel.com with ESMTP; 06 Apr 2017 14:52:47 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Apr 2017 09:52:02 +1200
Message-Id: <4eb24a3b4d1b61e44a5b751de1c4eeb66332c3de.1491514854.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1491514854.git.paul.eggleton@linux.intel.com>
References: <cover.1491514854.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 02/11] lib/bb/siggen: add missing path separator to cleaned paths
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
X-List-Received-Date: Thu, 06 Apr 2017 21:52:49 -0000

Printing "pbzip2pbzip2_1.1.13.bb" is ugly, we need to add a separating
slash so that we get "pbzip2/pbzip2_1.1.13.bb" instead.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/siggen.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 3ceeef1..f47af6d 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -355,7 +355,7 @@ def clean_basepath(a):
     mc = None
     if a.startswith("multiconfig:"):
         _, mc, a = a.split(":", 2)
-    b = a.rsplit("/", 2)[1] + a.rsplit("/", 2)[2]
+    b = a.rsplit("/", 2)[1] + '/' + a.rsplit("/", 2)[2]
     if a.startswith("virtual:"):
         b = b + ":" + a.rsplit(":", 1)[0]
     if mc:
-- 
2.9.3


