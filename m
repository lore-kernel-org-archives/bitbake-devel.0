Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SKAKg-0001sp-QN
	for bitbake-devel@lists.openembedded.org;
	Tue, 17 Apr 2012 17:28:42 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 17 Apr 2012 08:19:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="154695636"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.138])
	by fmsmga002.fm.intel.com with ESMTP; 17 Apr 2012 08:19:15 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 17 Apr 2012 08:19:05 -0700
Message-Id: <1334675945-11802-1-git-send-email-josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH 4/4] lib/bb/ui/crumbs/recipeselectionpage: fix type availabel->available
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
X-List-Received-Date: Tue, 17 Apr 2012 15:28:43 -0000

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/recipeselectionpage.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py b/lib/bb/ui/crumbs/recipeselectionpage.py
index fff8a88..7336da9 100755
--- a/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -99,7 +99,7 @@ class RecipeSelectionPage (HobPage):
                       }]
         }, {
          'name'    : 'Tasks',
-         'tooltip' : 'All tasks availabel in the Yocto Project',
+         'tooltip' : 'All tasks available in the Yocto Project',
          'filter'  : { RecipeListModel.COL_TYPE : ['task'] },
          'columns' : [{
                        'col_name' : 'Task name',
-- 
1.7.7.6



