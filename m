Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 3D9C36010B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 May 2016 23:17:22 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga101.jf.intel.com with ESMTP; 30 May 2016 16:17:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,392,1459839600"; d="scan'208";a="113081697"
Received: from klsmgloan09.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.145.237])
	by fmsmga004.fm.intel.com with ESMTP; 30 May 2016 16:17:22 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 31 May 2016 11:16:58 +1200
Message-Id: <30f746878200a4d1f9f7a598be7a84c604171c6b.1464650184.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1464650184.git.paul.eggleton@linux.intel.com>
References: <cover.1464650184.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1464650184.git.paul.eggleton@linux.intel.com>
References: <cover.1464650184.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] bitbake-layers: show-layers: disable parsing
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
X-List-Received-Date: Mon, 30 May 2016 23:17:22 -0000

We don't need to parse all recipes just to show the list of layers,
since that comes straight from the configuration, so save a bit of time
by not doing so. (A minor regression that came in with the the
bitbake-layers refactoring).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bblayers/query.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
index b5b98f7..91c98c6 100644
--- a/lib/bblayers/query.py
+++ b/lib/bblayers/query.py
@@ -481,7 +481,7 @@ NOTE: .bbappend files can impact the dependencies.
             logger.plain("%s %s %s" % (f, keyword, best_realfn))
 
     def register_commands(self, sp):
-        self.add_command(sp, 'show-layers', self.do_show_layers)
+        self.add_command(sp, 'show-layers', self.do_show_layers, parserecipes=False)
 
         parser_show_overlayed = self.add_command(sp, 'show-overlayed', self.do_show_overlayed)
         parser_show_overlayed.add_argument('-f', '--filenames', help='instead of the default formatting, list filenames of higher priority recipes with the ones they overlay indented underneath', action='store_true')
-- 
2.5.5


