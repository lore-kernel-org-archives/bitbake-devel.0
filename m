Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SALGT-0003wh-Uz
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 14:07:46 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 21 Mar 2012 05:58:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="121495267"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 21 Mar 2012 05:57:50 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 20:55:21 +0800
Message-Id: <99d30da5610bbe83fa7e1bc7bcbdb02740c0f91f.1332334068.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
Subject: [PATCH 17/17] Hob: Use inherit information to judge if a recipe is image type
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
X-List-Received-Date: Wed, 21 Mar 2012 13:07:46 -0000

Previously we use pattern "-image-" to match recipe name to judge if
it is image type. This will ignore some images whose name doesn't
match the pattern. The new method is to use the inherit information,
that is, if a recipe inherits image.bbclass, we treat it as an image.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hoblistmodel.py |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
index 61f2911..bfd49bd 100644
--- a/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/lib/bb/ui/crumbs/hoblistmodel.py
@@ -528,6 +528,7 @@ class RecipeListModel(gtk.ListStore):
             desc = event_model["pn"][item]["description"]
             lic = event_model["pn"][item]["license"]
             group = event_model["pn"][item]["section"]
+            inherits = event_model["pn"][item]["inherits"]
             install = []
 
             depends = event_model["depends"].get(item, []) + event_model["rdepends-pn"].get(item, [])
@@ -537,9 +538,10 @@ class RecipeListModel(gtk.ListStore):
                     atype = 'mltask'
                 else:
                     atype = 'task'
-            elif ('-image-' in name):
-                atype = 'image'
-                install = event_model["rdepends-pkg"].get(item, []) + event_model["rrecs-pkg"].get(item, [])
+            elif ('image.bbclass' in " ".join(inherits)):
+                if name != "hob-image":
+                    atype = 'image'
+                    install = event_model["rdepends-pkg"].get(item, []) + event_model["rrecs-pkg"].get(item, [])
             elif ('meta-' in name):
                 atype = 'toolchain'
             elif (name == 'dummy-image' or name == 'dummy-toolchain'):
-- 
1.7.4.1



