Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SIKbJ-00076w-N8
	for bitbake-devel@lists.openembedded.org;
	Thu, 12 Apr 2012 16:02:17 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 12 Apr 2012 06:52:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="152811477"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 12 Apr 2012 06:52:56 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Apr 2012 22:22:43 +0800
Message-Id: <66452ccd9200e82222920bfda51158a4c7e09fb2.1334240256.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1334240256.git.shane.wang@intel.com>
References: <cover.1334240256.git.shane.wang@intel.com>
Subject: [PATCH 1/2] Hob: fix the missing functions
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
X-List-Received-Date: Thu, 12 Apr 2012 14:02:17 -0000

The patch is to correct 7e5d41ab223b73c1c7b2cf7e4dd13289a2dc2e8b
(Bitbake rev: b6e68019494044305ab28492a517d1eafea851c3) to fix the
missing functions.

[Yocto #2281]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index dce4874..104d49d 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -239,7 +239,11 @@ class PackageSelectionPage (HobPage):
         if (not cell) or (not tree):
             return
         to_render_cells = []
+        view_model = tree.get_model()
+        self.get_excluded_rows(to_render_cells, view_model, view_model.get_iter_first())
 
-    def after_fadeout_checkin_include(self, table, ctrl, cell, tree):
-        tree.set_model(self.recipe_model.tree_model(self.pages[0]['filter']))
+        cell.fadeout(tree, 1000, to_render_cells)
 
+    def after_fadeout_checkin_include(self, table, ctrl, cell, tree):
+        tree.set_model(self.package_model.tree_model(self.pages[0]['filter']))
+        tree.expand_all()
-- 
1.7.6



