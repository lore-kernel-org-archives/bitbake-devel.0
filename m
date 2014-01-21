Return-Path: <irina.patru@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id BE02F615AE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jan 2014 15:56:29 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 21 Jan 2014 07:55:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,696,1384329600"; d="scan'208";a="442320751"
Received: from irina-vostro-460.rb.intel.com ([10.237.105.140])
	by orsmga001.jf.intel.com with ESMTP; 21 Jan 2014 07:55:49 -0800
From: Irina Patru <irina.patru@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Jan 2014 17:59:36 +0200
Message-Id: <1390319978-31756-2-git-send-email-irina.patru@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1390319978-31756-1-git-send-email-irina.patru@intel.com>
References: <y>
 <1390319978-31756-1-git-send-email-irina.patru@intel.com>
Subject: [PATCH 2/4] bitbake: hob: check if parser has attribute 'shutdown'
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
X-List-Received-Date: Tue, 21 Jan 2014 15:56:29 -0000

It must be checked first if parser has the attribute 'shutdown' when
user hits Stop button and the forceshutdown state is given.

[HOB #5579]

Signed-off-by: Irina Patru <irina.patru@intel.com>
---
 bitbake/lib/bb/cooker.py |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index db4cb51..3cf019b 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1240,7 +1240,8 @@ class BBCooker:
             return
 
         if self.state in (state.shutdown, state.forceshutdown):
-            self.parser.shutdown(clean=False, force = True)
+            if hasattr(self.parser, 'shutdown'):
+                self.parser.shutdown(clean=False, force = True)
             raise bb.BBHandledException()
 
         if self.state != state.parsing:
-- 
1.7.9.5


