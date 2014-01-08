Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 0F3046D251
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jan 2014 17:35:43 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 08 Jan 2014 09:35:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,625,1384329600"; d="scan'208";a="435837858"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.128])
	by orsmga001.jf.intel.com with ESMTP; 08 Jan 2014 09:35:22 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jan 2014 17:35:19 +0000
Message-Id: <1389202519-21149-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [1.18][PATCH] hob/hoblistmodel: check if vals of packages/recipes names are not None
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
X-List-Received-Date: Wed, 08 Jan 2014 17:35:43 -0000

From: Cristiana Voicu <cristiana.voicu@intel.com>

[YOCTO #5053]

(Corresponds to BitBake master rev: ba9fe77e37be31e8246431578902e871dd94515e)

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 lib/bb/ui/crumbs/hoblistmodel.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
index 547c1ca..f6b3f09 100644
--- a/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/lib/bb/ui/crumbs/hoblistmodel.py
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
1.8.1.2


