Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SEJr7-00042U-Q0
	for bitbake-devel@lists.openembedded.org;
	Sun, 01 Apr 2012 14:26:01 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 01 Apr 2012 05:16:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="124192954"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 01 Apr 2012 05:16:55 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  1 Apr 2012 20:14:14 +0800
Message-Id: <6429ae88b0fca67fe5bacb121edb0ace5b2ec87a.1333269705.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333269705.git.dongxiao.xu@intel.com>
References: <cover.1333269705.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333269705.git.dongxiao.xu@intel.com>
References: <cover.1333269705.git.dongxiao.xu@intel.com>
Subject: [PATCH 06/10] Hob: Remove the recipe/task type for multilib
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
X-List-Received-Date: Sun, 01 Apr 2012 12:26:02 -0000

We will not display multilib recipes and tasks in separate tabs,
therefore remove the specific types.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hoblistmodel.py |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
index a09c7c7..6a829e2 100644
--- a/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/lib/bb/ui/crumbs/hoblistmodel.py
@@ -530,10 +530,7 @@ class RecipeListModel(gtk.ListStore):
             depends = event_model["depends"].get(item, []) + event_model["rdepends-pn"].get(item, [])
 
             if ('task-' in name):
-                if ('lib32-' in name or 'lib64-' in name):
-                    atype = 'mltask'
-                else:
-                    atype = 'task'
+                atype = 'task'
             elif ('image.bbclass' in " ".join(inherits)):
                 if name != "hob-image":
                     atype = 'image'
@@ -543,10 +540,7 @@ class RecipeListModel(gtk.ListStore):
             elif (name == 'dummy-image' or name == 'dummy-toolchain'):
                 atype = 'dummy'
             else:
-                if ('lib32-' in name or 'lib64-' in name):
-                    atype = 'mlrecipe'
-                else:
-                    atype = 'recipe'
+                atype = 'recipe'
 
             self.set(self.append(), self.COL_NAME, item, self.COL_DESC, desc,
                      self.COL_LIC, lic, self.COL_GROUP, group,
-- 
1.7.4.1



