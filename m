Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TBTtG-0002ux-Rk
	for bitbake-devel@lists.openembedded.org;
	Tue, 11 Sep 2012 19:04:47 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 11 Sep 2012 09:52:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,406,1344236400"; d="scan'208";a="191458851"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.206])
	by azsmga001.ch.intel.com with ESMTP; 11 Sep 2012 09:52:11 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Sep 2012 17:52:01 +0100
Message-Id: <98eca12e39f253a65f0831bb30cef6cd48f1744f.1347382193.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1347382193.git.paul.eggleton@linux.intel.com>
References: <cover.1347382193.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1347382193.git.paul.eggleton@linux.intel.com>
References: <cover.1347382193.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/3] hob: sort base image drop-down list
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
X-List-Received-Date: Tue, 11 Sep 2012 17:04:47 -0000

Sort the list of base images to make it easier to find a specific image
in the list. Note that "Create your own image" still remains the last
item in the list.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index 65c88cd..0cf9ebe 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -345,6 +345,7 @@ class ImageConfigurationPage (HobPage):
         # populate image combo
         filter = {RecipeListModel.COL_TYPE : ['image']}
         image_model = recipe_model.tree_model(filter)
+        image_model.set_sort_column_id(recipe_model.COL_NAME, gtk.SORT_ASCENDING)
         active = 0
         cnt = 1
 
-- 
1.7.9.5



