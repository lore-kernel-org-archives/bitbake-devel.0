Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qlmiq-0003i5-K1
	for bitbake-devel@lists.openembedded.org;
	Tue, 26 Jul 2011 20:51:16 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 26 Jul 2011 11:46:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,270,1309762800"; d="scan'208";a="30353991"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.155])
	by orsmga002.jf.intel.com with ESMTP; 26 Jul 2011 11:46:57 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2011 11:46:42 -0700
Message-Id: <812ead4900714545850698d8ce29194f4ee8db0e.1311705833.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311705833.git.josh@linux.intel.com>
References: <cover.1311705833.git.josh@linux.intel.com>
In-Reply-To: <cover.1311705833.git.josh@linux.intel.com>
References: <cover.1311705833.git.josh@linux.intel.com>
Subject: [PATCH 08/10] ui/crumbs/tasklistmodel: handle items added in by base image being removed
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
X-List-Received-Date: Tue, 26 Jul 2011 18:51:18 -0000

When building an image based on an existing image we need to correctly
handle removals from that images package set. Do so by testing if any of
the items brought in by the base image are removed and, if so, building
an image from scratch with all of the selected packages included.

Fixes [YOCTO #1232]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index 36a5673..e6af74f 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -495,9 +495,23 @@ class TaskListModel(gtk.ListStore):
             it = self.contents.iter_next(it)
         return userpkgs, allpkgs
 
+    def image_contents_removed(self):
+        it = self.get_iter_first()
+        while it:
+            sel = self.get_value(it, self.COL_INC)
+            img = self.get_value(it, self.COL_IMG)
+            if img and not sel:
+                return True
+            it = self.iter_next(it)
+        return False
+
     def get_build_rep(self):
         userpkgs, allpkgs = self.get_selected_packages()
-        image = self.selected_image
+        # If base image contents have been removed start from an empty rootfs
+        if not self.selected_image or self.image_contents_removed():
+            image = "empty"
+        else:
+            image = self.selected_image
 
         return BuildRep(" ".join(userpkgs), " ".join(allpkgs), image)
 
-- 
1.7.6



