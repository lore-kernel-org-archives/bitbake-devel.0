Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristian.iorga@intel.com>) id 1TO36i-0003iz-QH
	for bitbake-devel@lists.openembedded.org;
	Tue, 16 Oct 2012 11:06:37 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 16 Oct 2012 01:53:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,593,1344236400"; d="scan'208";a="156655339"
Received: from sentry (HELO localhost.localdomain) ([10.237.105.37])
	by AZSMGA002.ch.intel.com with ESMTP; 16 Oct 2012 01:53:17 -0700
From: Cristian Iorga <cristian.iorga@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 16 Oct 2012 11:52:38 +0300
Message-Id: <1350377558-26471-1-git-send-email-cristian.iorga@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] bitbake: hob/hobwidget: "Brought in by" column is now displayed correctly
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
X-List-Received-Date: Tue, 16 Oct 2012 09:06:37 -0000

In "Edit Recipes" and "Edit packages" pages, the "Brought in by"
column is displayed correctly, with the right number of additional
packages and a proper title.

Fixes [YOCTO #2195].

Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py            |   10 ++++++++--
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    2 +-
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |    2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 28dc375..65de9df 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -155,9 +155,15 @@ class HobViewTable (gtk.VBox):
             bin = binb.split(', ')
             total_no = len(bin)
             if total_no > 1 and bin[0] == "User Selected":
-                present_binb = bin[1] + ' (+' + str(total_no) + ')'
+                if total_no > 2:
+                    present_binb = bin[1] + ' (+' + str(total_no - 1) + ')'
+                else:
+                    present_binb = bin[1]
             else:
-                present_binb = bin[0] + ' (+' + str(total_no) + ')'
+                if total_no > 1:
+                    present_binb = bin[0] + ' (+' + str(total_no - 1) + ')'
+                else:
+                    present_binb = bin[0]
             cell.set_property('text', present_binb)
         else:
             cell.set_property('text', "")
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 6792fe0..d05b4a2 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -52,7 +52,7 @@ class PackageSelectionPage (HobPage):
                        'col_max'  : 300,
                        'expand'   : 'True'
                       }, {
-                       'col_name' : 'Brought in by',
+                       'col_name' : 'Brought in by (+others)',
                        'col_id'   : PackageListModel.COL_BINB,
                        'col_style': 'binb',
                        'col_min'  : 100,
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index 8655c29..27872ca 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -52,7 +52,7 @@ class RecipeSelectionPage (HobPage):
                        'col_max'  : 300,
                        'expand'   : 'True'
                       }, {
-                       'col_name' : 'Brought in by',
+                       'col_name' : 'Brought in by (+others)',
                        'col_id'   : RecipeListModel.COL_BINB,
                        'col_style': 'binb',
                        'col_min'  : 100,
-- 
1.7.9.5



