Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S86Fk-0006FM-H8
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 09:41:44 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 15 Mar 2012 01:32:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="121224388"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 15 Mar 2012 01:32:01 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Mar 2012 16:29:52 +0800
Message-Id: <a16b2245d7f5ef8509df0c543f9432c98367c79c.1331796806.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1331796806.git.dongxiao.xu@intel.com>
References: <cover.1331796806.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1331796806.git.dongxiao.xu@intel.com>
References: <cover.1331796806.git.dongxiao.xu@intel.com>
Subject: [PATCH 04/12] Hob: Fix the image installation dependency
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
X-List-Received-Date: Thu, 15 Mar 2012 08:41:44 -0000

Get the image installation content from rdepends and rrecommends
variables.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hoblistmodel.py |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
index 0b7c0cb..0378828 100644
--- a/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/lib/bb/ui/crumbs/hoblistmodel.py
@@ -546,9 +546,7 @@ class RecipeListModel(gtk.ListStore):
             group = event_model["pn"][item]["section"]
             install = []
 
-            depends = event_model["depends"].get(item, [])
-            rdepends = event_model["rdepends-pn"].get(item, [])
-            depends = depends + rdepends
+            depends = event_model["depends"].get(item, []) + event_model["rdepends-pn"].get(item, [])
 
             if ('task-' in name):
                 if ('lib32-' in name or 'lib64-' in name):
@@ -557,7 +555,7 @@ class RecipeListModel(gtk.ListStore):
                     atype = 'task'
             elif ('-image-' in name):
                 atype = 'image'
-                install = rdepends
+                install = event_model["rdepends-pkg"].get(item, []) + event_model["rrecs-pkg"].get(item, [])
             elif ('meta-' in name):
                 atype = 'toolchain'
             elif (name == 'dummy-image' or name == 'dummy-toolchain'):
-- 
1.7.4.1



