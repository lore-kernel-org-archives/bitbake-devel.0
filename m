Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SGIZO-0003Lc-27
	for bitbake-devel@lists.openembedded.org;
	Sat, 07 Apr 2012 01:27:54 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 06 Apr 2012 16:18:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="129596283"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.176])
	by orsmga002.jf.intel.com with ESMTP; 06 Apr 2012 16:18:38 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Apr 2012 16:18:34 -0700
Message-Id: <ceffdf225dc7a6ff5746ef9b0ae07a1a62207856.1333754145.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1333754145.git.josh@linux.intel.com>
References: <cover.1333754145.git.josh@linux.intel.com>
In-Reply-To: <cover.1333754145.git.josh@linux.intel.com>
References: <cover.1333754145.git.josh@linux.intel.com>
Subject: [PATCH 2/4] lib/bb/ui/crumbs/recipeselectionpage: include 'Group' in 'Included' view
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
X-List-Received-Date: Fri, 06 Apr 2012 23:27:54 -0000

The 'Included' tab of the notebook should show the 'Group' a recipe
belongs to, per the design.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/recipeselectionpage.py |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py b/lib/bb/ui/crumbs/recipeselectionpage.py
index 956b02d..8314449 100755
--- a/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -49,6 +49,12 @@ class RecipeSelectionPage (HobPage):
                        'col_min'  : 100,
                        'col_max'  : 500
                       }, {
+                       'col_name' : 'Group',
+                       'col_id'   : RecipeListModel.COL_GROUP,
+                       'col_style': 'text',
+                       'col_min'  : 100,
+                       'col_max'  : 300
+                      }, {
                        'col_name' : 'Included',
                        'col_id'   : RecipeListModel.COL_INC,
                        'col_style': 'check toggle',
-- 
1.7.7.6



