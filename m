Return-Path: <cristiana.voicu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 3913E6D586
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Nov 2013 12:58:05 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 18 Nov 2013 04:54:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="410540911"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.65])
	by orsmga001.jf.intel.com with ESMTP; 18 Nov 2013 04:58:06 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 Nov 2013 15:03:38 +0200
Message-Id: <1384779819-1553-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH_DYLAN] hob/hoblistmodel: check if vals of packages/recipes names are not None
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
X-List-Received-Date: Mon, 18 Nov 2013 12:58:06 -0000

[YOCTO #5053]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 547c1ca..f6b3f09 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -181,7 +181,9 @@ class PackageListModel(gtk.ListStore):
     def sort_func(self, model, iter1, iter2, user_data):
         val1 = model.get_value(iter1, PackageListModel.COL_NAME)
         val2 = model.get_value(iter2, PackageListModel.COL_NAME)
-        if val1.startswith(user_data) and not val2.startswith(user_data):
+        if val1 is None or val2 is None:
+            return 0
+        elif val1.startswith(user_data) and not val2.startswith(user_data):
             return -1
         elif not val1.startswith(user_data) and val2.startswith(user_data):
             return 1
@@ -562,7 +564,9 @@ class RecipeListModel(gtk.ListStore):
     def sort_func(self, model, iter1, iter2, user_data):
         val1 = model.get_value(iter1, RecipeListModel.COL_NAME)
         val2 = model.get_value(iter2, RecipeListModel.COL_NAME)
-        if val1.startswith(user_data) and not val2.startswith(user_data):
+        if val1 is None or val2 is None:
+            return 0
+        elif val1.startswith(user_data) and not val2.startswith(user_data):
             return -1
         elif not val1.startswith(user_data) and val2.startswith(user_data):
             return 1
-- 
1.7.9.5


