Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SALFN-0003UK-Vg
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 14:06:38 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 21 Mar 2012 05:57:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="131476485"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2012 05:57:43 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 20:55:15 +0800
Message-Id: <d189918f454da5ce96e01fed67745deba9a7da2f.1332334068.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
Subject: [PATCH 11/17] Hob: Change package selection tab order
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
X-List-Received-Date: Wed, 21 Mar 2012 13:06:38 -0000

In the package screen, change the tab order to be:
"Included" and "All packages".

Also change some descriptions in tab.

This fixes [YOCTO #2111]

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 lib/bb/ui/crumbs/packageselectionpage.py |   40 +++++++++++++++---------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/lib/bb/ui/crumbs/packageselectionpage.py b/lib/bb/ui/crumbs/packageselectionpage.py
index 23e460c..32e438c 100755
--- a/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/lib/bb/ui/crumbs/packageselectionpage.py
@@ -34,55 +34,55 @@ class PackageSelectionPage (HobPage):
 
     pages = [
         {
-         'name'    : 'All packages',
-         'filter'  : {},
+         'name'    : 'Included',
+         'filter'  : { PackageListModel.COL_INC : [True] },
          'columns' : [{
-                       'col_name' : 'Name',
+                       'col_name' : 'Package Name',
                        'col_id'   : PackageListModel.COL_NAME,
                        'col_style': 'text',
                        'col_min'  : 100,
-                       'col_max'  : 400
+                       'col_max'  : 300
                       }, {
-                       'col_name' : 'size',
+                       'col_name' : 'Brought in by',
+                       'col_id'   : PackageListModel.COL_BINB,
+                       'col_style': 'text',
+                       'col_min'  : 100,
+                       'col_max'  : 350
+                      }, {
+                       'col_name' : 'Size',
                        'col_id'   : PackageListModel.COL_SIZE,
                        'col_style': 'text',
                        'col_min'  : 100,
-                       'col_max'  : 500
+                       'col_max'  : 300
                       }, {
                        'col_name' : 'Included',
                        'col_id'   : PackageListModel.COL_INC,
                        'col_style': 'check toggle',
                        'col_min'  : 50,
                        'col_max'  : 50
-                      }]
+                     }]
         }, {
-         'name'    : 'Included',
-         'filter'  : { PackageListModel.COL_INC : [True] },
+         'name'    : 'All packages',
+         'filter'  : {},
          'columns' : [{
-                       'col_name' : 'Name',
+                       'col_name' : 'Package Name',
                        'col_id'   : PackageListModel.COL_NAME,
                        'col_style': 'text',
                        'col_min'  : 100,
-                       'col_max'  : 300
-                      }, {
-                       'col_name' : 'Brought by',
-                       'col_id'   : PackageListModel.COL_BINB,
-                       'col_style': 'text',
-                       'col_min'  : 100,
-                       'col_max'  : 350
+                       'col_max'  : 400
                       }, {
-                       'col_name' : 'size',
+                       'col_name' : 'Size',
                        'col_id'   : PackageListModel.COL_SIZE,
                        'col_style': 'text',
                        'col_min'  : 100,
-                       'col_max'  : 300
+                       'col_max'  : 500
                       }, {
                        'col_name' : 'Included',
                        'col_id'   : PackageListModel.COL_INC,
                        'col_style': 'check toggle',
                        'col_min'  : 50,
                        'col_max'  : 50
-                     }]
+                      }]
         }
     ]
 
-- 
1.7.4.1



