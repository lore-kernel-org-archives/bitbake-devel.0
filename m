Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SI9Nt-0004DK-IX
	for bitbake-devel@lists.openembedded.org;
	Thu, 12 Apr 2012 04:03:41 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 11 Apr 2012 18:54:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="140686494"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.85])
	by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2012 18:54:20 -0700
From: josh@linux.intel.com
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Apr 2012 18:54:17 -0700
Message-Id: <1334195657-8240-1-git-send-email-josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH] packageselectionpage: add missing method
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
X-List-Received-Date: Thu, 12 Apr 2012 02:03:41 -0000

From: Joshua Lock <josh@linux.intel.com>

This is just a copy of the same method from the recipeselectionpage so
that we can actually run hob again.

Fixes [YOCTO #2281]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/packageselectionpage.py |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/packageselectionpage.py b/lib/bb/ui/crumbs/packageselectionpage.py
index b1b9722..dce4874 100755
--- a/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/lib/bb/ui/crumbs/packageselectionpage.py
@@ -239,3 +239,7 @@ class PackageSelectionPage (HobPage):
         if (not cell) or (not tree):
             return
         to_render_cells = []
+
+    def after_fadeout_checkin_include(self, table, ctrl, cell, tree):
+        tree.set_model(self.recipe_model.tree_model(self.pages[0]['filter']))
+
-- 
1.7.7.6



