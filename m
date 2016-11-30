Return-Path: <ismo.puustinen@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 0479871AB6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Nov 2016 12:43:22 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga101.jf.intel.com with ESMTP; 30 Nov 2016 04:43:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,574,1473145200"; d="scan'208";a="197389186"
Received: from ipuustin-desk.fi.intel.com ([10.237.72.72])
	by fmsmga004.fm.intel.com with ESMTP; 30 Nov 2016 04:43:22 -0800
From: Ismo Puustinen <ismo.puustinen@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 30 Nov 2016 14:43:19 +0200
Message-Id: <20161130124319.12713-1-ismo.puustinen@intel.com>
X-Mailer: git-send-email 2.9.3
Subject: [PATCH] depexp: fix string formatting.
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
X-List-Received-Date: Wed, 30 Nov 2016 12:43:23 -0000

The parameters to Python string formatting need to be inside a tuple.

Signed-off-by: Ismo Puustinen <ismo.puustinen@intel.com>
---
 lib/bb/ui/depexp.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/depexp.py b/lib/bb/ui/depexp.py
index d879e04..9630646 100644
--- a/lib/bb/ui/depexp.py
+++ b/lib/bb/ui/depexp.py
@@ -313,7 +313,7 @@ def main(server, eventHandler, params):
                         extra = ". Close matches:\n  %s" % '\n  '.join(event._close_matches)
 
                 if event._dependees:
-                    print("Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)%s" % r, event._item, ", ".join(event._dependees), r, extra)
+                    print("Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)%s" % (r, event._item, ", ".join(event._dependees), r, extra))
                 else:
                     print("Nothing %sPROVIDES '%s'%s" % (r, event._item, extra))
                 if event._reasons:
-- 
2.9.3


