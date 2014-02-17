Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 00D246E8C4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Feb 2014 14:07:48 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 17 Feb 2014 06:07:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,860,1384329600"; d="scan'208";a="456876165"
Received: from nithyasr-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.123.246])
	by orsmga001.jf.intel.com with ESMTP; 17 Feb 2014 06:07:49 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Feb 2014 14:07:40 +0000
Message-Id: <9e29923158076b802b7659fe3018b14d1c0341a6.1392645935.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <cover.1392645935.git.paul.eggleton@linux.intel.com>
References: <cover.1392645935.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1392645935.git.paul.eggleton@linux.intel.com>
References: <cover.1392645935.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] parse: make vars_from_file return None for non-recipes
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
X-List-Received-Date: Mon, 17 Feb 2014 14:07:49 -0000

It doesn't really make sense to set PN from .conf files, for example.
More concretely, this avoids the config hash changing unnecessarily
within Hob due to PN effectively changing (since bblayers.conf is
parsed first and then .hob.conf).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/parse/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index 97983c9..e4a44dd 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
@@ -127,7 +127,7 @@ def resolve_file(fn, d):
 # Used by OpenEmbedded metadata
 __pkgsplit_cache__={}
 def vars_from_file(mypkg, d):
-    if not mypkg:
+    if not mypkg or not mypkg.endswith((".bb", ".bbappend")):
         return (None, None, None)
     if mypkg in __pkgsplit_cache__:
         return __pkgsplit_cache__[mypkg]
-- 
1.8.5.3


