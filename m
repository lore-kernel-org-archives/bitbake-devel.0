Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UKnqQ-0005Lp-5U
	for bitbake-devel@lists.openembedded.org;
	Wed, 27 Mar 2013 11:44:40 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 27 Mar 2013 03:27:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,917,1355126400"; d="scan'208";a="219373142"
Received: from adinu-vostro-460.rb.intel.com ([10.237.105.146])
	by AZSMGA002.ch.intel.com with ESMTP; 27 Mar 2013 03:27:16 -0700
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 27 Mar 2013 12:27:54 +0200
Message-Id: <1364380074-16382-7-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1364380074-16382-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1364380074-16382-1-git-send-email-andrei.adrianx.dinu@intel.com>
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
X-List-Received-Date: Wed, 27 Mar 2013 10:44:50 -0000

In order to have information for each package in hob,
a new item is added to the dictionary, represeting the
files that are brought in by each package.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
 mode change 100755 => 100644 bitbake/lib/bb/ui/crumbs/packageselectionpage.py

diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
old mode 100755
new mode 100644
index 6f9a4e2..fbb6017
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -178,11 +178,12 @@ class PackageSelectionPage (HobPage):
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



