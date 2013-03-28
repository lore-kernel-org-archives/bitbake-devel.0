Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UL8NF-0004iI-SL
	for bitbake-devel@lists.openembedded.org;
	Thu, 28 Mar 2013 09:39:54 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 28 Mar 2013 01:22:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,924,1355126400"; d="scan'208";a="313050669"
Received: from adinu-vostro-460.rb.intel.com ([10.237.105.146])
	by fmsmga002.fm.intel.com with ESMTP; 28 Mar 2013 01:22:42 -0700
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 Mar 2013 10:23:22 +0200
Message-Id: <1364459002-4165-7-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1364459002-4165-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1364459002-4165-1-git-send-email-andrei.adrianx.dinu@intel.com>
Subject: [PATCH 6/6] packageselectionpage.py : added information to hob
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
X-List-Received-Date: Thu, 28 Mar 2013 08:39:54 -0000

In order to have information for each package in hob,
a new item is added to the dictionary, represeting the
files that are brought in by each package.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 0bb4cb1..781d579 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -204,11 +204,12 @@ class PackageSelectionPage (HobPage):
         path, col = widget.table_tree.get_cursor()
         tree_model = widget.table_tree.get_model()
         if path: # else activation is likely a removal
-            properties = {'binb': '' , 'name': '', 'size':'', 'recipe':''}
+            properties = {'binb': '' , 'name': '', 'size':'', 'recipe':'', 'files_list':''}
             properties['binb'] = tree_model.get_value(tree_model.get_iter(path), PackageListModel.COL_BINB)
             properties['name'] = tree_model.get_value(tree_model.get_iter(path), PackageListModel.COL_NAME)
             properties['size'] = tree_model.get_value(tree_model.get_iter(path), PackageListModel.COL_SIZE)
             properties['recipe'] = tree_model.get_value(tree_model.get_iter(path), PackageListModel.COL_RCP)
+            properties['files_list'] = tree_model.get_value(tree_model.get_iter(path), PackageListModel.COL_FLIST)
 
             self.builder.show_recipe_property_dialog(properties)
 
-- 
1.7.9.5



