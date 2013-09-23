Return-Path: <cristiana.voicu@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 1F79F610FF
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Sep 2013 11:07:05 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 23 Sep 2013 04:07:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,961,1371106800"; d="scan'208";a="407628494"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.147])
	by orsmga002.jf.intel.com with ESMTP; 23 Sep 2013 04:07:02 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 23 Sep 2013 14:11:08 +0300
Message-Id: <1379934668-4626-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/hoblistmodel: check if vals of packages/recipes names are not None
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
X-List-Received-Date: Mon, 23 Sep 2013 11:07:06 -0000

[YOCTO #5053]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index b4d2a62..79e909c 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -199,7 +199,9 @@ class PackageListModel(gtk.ListStore):
         return self.cmp_vals(val1, val2, user_data)
 
     def cmp_vals(self, val1, val2, user_data):
-        if val1.startswith(user_data) and not val2.startswith(user_data):
+        if val1 is None or val2 is None:
+            return 0
+        elif val1.startswith(user_data) and not val2.startswith(user_data):
             return -1
         elif not val1.startswith(user_data) and val2.startswith(user_data):
             return 1
@@ -575,7 +577,9 @@ class RecipeListModel(gtk.ListStore):
         return self.cmp_vals(val1, val2, user_data)
 
     def cmp_vals(self, val1, val2, user_data):
-        if val1.startswith(user_data) and not val2.startswith(user_data):
+        if val1 is None or val2 is None:
+            return 0
+        elif val1.startswith(user_data) and not val2.startswith(user_data):
             return -1
         elif not val1.startswith(user_data) and val2.startswith(user_data):
             return 1
-- 
1.7.9.5


