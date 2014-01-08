Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 4F3316D304
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jan 2014 17:40:36 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 08 Jan 2014 09:40:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,625,1384329600"; d="scan'208";a="462123164"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.128])
	by fmsmga002.fm.intel.com with ESMTP; 08 Jan 2014 09:40:06 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jan 2014 17:40:04 +0000
Message-Id: <1389202804-21358-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [1.20][PATCH] hob/hoblistmodel: check if vals of packages/recipes names are not None
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
X-List-Received-Date: Wed, 08 Jan 2014 17:40:36 -0000

From: Cristiana Voicu <cristiana.voicu@intel.com>

[YOCTO #5053]

(Corresponds to BitBake master rev: ba9fe77e37be31e8246431578902e871dd94515e)

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/crumbs/hoblistmodel.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
index b4d2a62..79e909c 100644
--- a/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/lib/bb/ui/crumbs/hoblistmodel.py
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
1.8.1.2


