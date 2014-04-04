Return-Path: <cristiana.voicu@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id D07FA60DFA
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Apr 2014 10:53:03 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 04 Apr 2014 03:53:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,794,1389772800"; d="scan'208";a="514781320"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.143])
	by orsmga002.jf.intel.com with ESMTP; 04 Apr 2014 03:53:02 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Apr 2014 13:53:40 +0300
Message-Id: <1396608820-6039-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: adding INHERIT += " testimage " affects image recipes list
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
X-List-Received-Date: Fri, 04 Apr 2014 10:53:06 -0000

To find if a recipe is for an image, Hob checks if it inherits
image.bbclass. But when you add testimage in local.conf, this will
be added for each recipe, and it pass the test. Adding a "/" before
"image.bbclass", will check only for image.bbclass.

[YOCTO #6117]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 02d6332..50df156 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -703,7 +703,7 @@ class RecipeListModel(gtk.ListStore):
 
             if ('packagegroup.bbclass' in " ".join(inherits)):
                 atype = 'packagegroup'
-            elif ('image.bbclass' in " ".join(inherits)):
+            elif ('/image.bbclass' in " ".join(inherits)):
                 if "edited" not in name:
                     atype = 'image'
                     install = event_model["rdepends-pkg"].get(item, []) + event_model["rrecs-pkg"].get(item, [])
-- 
1.7.9.5


