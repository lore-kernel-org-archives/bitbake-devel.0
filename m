Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 72ADF719BD
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Mar 2017 02:24:05 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga105.fm.intel.com with ESMTP; 29 Mar 2017 19:24:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,244,1486454400"; d="scan'208";a="1128726353"
Received: from driley-mobl5.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.172.155])
	by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2017 19:24:05 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Mar 2017 15:23:59 +1300
Message-Id: <a8c46a5ae21994498726bcea39b5ce512a5ae7a6.1490840595.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1490840595.git.paul.eggleton@linux.intel.com>
References: <cover.1490840595.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] tinfoil: fix get_recipe_file() to return an error on invalid recipe
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
X-List-Received-Date: Thu, 30 Mar 2017 02:24:05 -0000

This function calls cooker.findBestProvider() but didn't handle the fact
that that function returns a tuple (None, None, None, None) when there
is no matching recipe. (This fixes devtool in OpenEmbedded showing a
traceback when an invalid recipe is specified instead of a proper error
message.)

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tinfoil.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index c2ee707..14a2271 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -363,7 +363,7 @@ class Tinfoil:
         skipped.
         """
         best = self.find_best_provider(pn)
-        if not best:
+        if not best or (len(best) > 3 and not best[3]):
             skiplist = self.get_skipped_recipes()
             taskdata = bb.taskdata.TaskData(None, skiplist=skiplist)
             skipreasons = taskdata.get_reasons(pn)
-- 
2.9.3


