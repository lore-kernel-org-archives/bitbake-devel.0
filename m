Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1THF2S-00089u-VR
	for bitbake-devel@lists.openembedded.org;
	Thu, 27 Sep 2012 16:26:05 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 27 Sep 2012 07:12:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,496,1344236400"; d="scan'208";a="227646224"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by fmsmga002.fm.intel.com with ESMTP; 27 Sep 2012 07:12:02 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Sep 2012 17:12:59 +0300
Message-Id: <1348755179-5257-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/recipeselectionpage: recipes should not be shown brought in by themselves
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 27 Sep 2012 14:26:05 -0000

[YOCTO #3107]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 15894d3..fe58adf 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -672,6 +672,10 @@ class RecipeListModel(gtk.ListStore):
                         self[dep_path][self.COL_BINB] = ', '.join(dep_bin).lstrip(', ')
                 elif not dep_included:
                     self.include_item(dep_path, binb=item_name, image_contents=image_contents)
+        dep_bin = self[item_path][self.COL_BINB].split(', ')
+        if self[item_path][self.COL_NAME] in dep_bin:
+            dep_bin.remove(self[item_path][self.COL_NAME])
+        self[item_path][self.COL_BINB] = ', '.join(dep_bin).lstrip(', ')
 
     def exclude_item(self, item_path):
         if not self.path_included(item_path):
-- 
1.7.9.5



