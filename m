Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SB6Gh-0005xL-QA
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Mar 2012 16:19:08 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 23 Mar 2012 08:10:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="124319972"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 23 Mar 2012 08:10:10 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Mar 2012 23:07:51 +0800
Message-Id: <db00bf8d46f76c4886e1b67dca199337c3d4daae.1332514895.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1332514895.git.dongxiao.xu@intel.com>
References: <cover.1332514895.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1332514895.git.dongxiao.xu@intel.com>
References: <cover.1332514895.git.dongxiao.xu@intel.com>
Subject: [PATCH 3/7] Hob: Initial an empty label in recipeselectionpage.py
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
X-List-Received-Date: Fri, 23 Mar 2012 15:19:08 -0000

When creating label in recipeselectionpage.py, the builder's
configuration may not be ready yet, so create an empty label in
initialization.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/recipeselectionpage.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py b/lib/bb/ui/crumbs/recipeselectionpage.py
index 881b2ec..ebdb7c1 100755
--- a/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -118,7 +118,7 @@ class RecipeSelectionPage (HobPage):
         self.create_visual_elements()
 
     def create_visual_elements(self):
-        self.label = gtk.Label("Recipes included: %s" % len(self.builder.configuration.selected_recipes))
+        self.label = gtk.Label()
         self.eventbox = self.add_onto_top_bar(self.label, 73)
         self.pack_start(self.eventbox, expand=False, fill=False)
         self.pack_start(self.group_align, expand=True, fill=True)
-- 
1.7.4.1



