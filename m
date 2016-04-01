Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id ADBAD7326D
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 11:58:01 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga101.jf.intel.com with ESMTP; 01 Apr 2016 04:58:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,427,1455004800"; d="scan'208";a="77245788"
Received: from cmjones2-mobl3.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.22.222])
	by fmsmga004.fm.intel.com with ESMTP; 01 Apr 2016 04:58:01 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Apr 2016 12:57:58 +0100
Message-Id: <1459511878-2212-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Cc: Joshua Lock <joshua.g.lock@intel.com>
Subject: [PATCH] toaster: orm better detect requires during CustomImageRecipe generation
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
X-List-Received-Date: Fri, 01 Apr 2016 11:58:04 -0000

From: Joshua Lock <joshua.g.lock@intel.com>

We were doing a string search for the literal string "require" and
assuming that a match meant the recipe uses the require keyword to
include the contents of another recipe. This test isn't very smart (it
should at least have matched on "require ") and triggers on the word
require anywhere in the recipe, i.e. the word "required" in the
DESCRIPTION of core-image-lsb.bb, and then breaks as the much smarter
regex fails to match anything.

Instead always run the regex search and only try to update the
require entry when the regex matches.

Signed-off-by: Joshua Lock <joshua.g.lock@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/orm/models.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/toaster/orm/models.py b/bitbake/lib/toaster/orm/models.py
index 6ae6316..610d542 100644
--- a/bitbake/lib/toaster/orm/models.py
+++ b/bitbake/lib/toaster/orm/models.py
@@ -1547,11 +1547,10 @@ class CustomImageRecipe(Recipe):
         # "require core-image-minimal.bb" is changed to:
         # "require recipes-core/images/core-image-minimal.bb"
 
-        if "require" in base_recipe:
-            req_search = re.search(r'(require\s+)(.+\.bb\s*$)',
+        req_search = re.search(r'(require\s+)(.+\.bb\s*$)',
                                    base_recipe,
                                    re.MULTILINE)
-
+        if req_search:
             require_filename = req_search.group(2).strip()
 
             corrected_location = Recipe.objects.filter(
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


