Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SbV0w-0002lP-T4
	for bitbake-devel@lists.openembedded.org;
	Mon, 04 Jun 2012 12:59:59 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 04 Jun 2012 03:49:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="152298223"
Received: from hp.sh.intel.com ([10.239.47.6])
	by orsmga002.jf.intel.com with ESMTP; 04 Jun 2012 03:49:33 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  4 Jun 2012 18:52:14 +0800
Message-Id: <926f93eacaaef0c0ae44d617945ff0064999d29f.1338806537.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <57f497956749ad3a4c41051cb12f7a3b97f0254e.1338806537.git.limingx.l.an@intel.com>
References: <57f497956749ad3a4c41051cb12f7a3b97f0254e.1338806537.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1338806537.git.limingx.l.an@intel.com>
References: <cover.1338806537.git.limingx.l.an@intel.com>
Subject: [PATCH 5/5] Hob: fixed the index issue when set actived item for base image combo
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
X-List-Received-Date: Mon, 04 Jun 2012 10:59:59 -0000

The combo item index dosn't be increased as the insert a dummy item, when
execute the upadate base image combo operation.

[YOCTO #2500]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index b5f0a5a..80332fe 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -364,7 +364,7 @@ class ImageConfigurationPage (HobPage):
         filter = {RecipeListModel.COL_TYPE : ['image']}
         image_model = recipe_model.tree_model(filter)
         active = 0
-        cnt = 0
+        cnt = 1
 
         white_pattern = []
         if self.builder.parameters.image_white_pattern:
@@ -415,7 +415,6 @@ class ImageConfigurationPage (HobPage):
         if selected_image == self.builder.recipe_model.__custom_image__:
             active = cnt
 
-        self.image_combo.set_active(0)
         self.image_combo.set_active(active)
 
         if active != 0:
-- 
1.7.5.4



