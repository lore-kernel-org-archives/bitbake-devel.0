Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QgktA-0003ca-1e
	for bitbake-devel@lists.openembedded.org;
	Tue, 12 Jul 2011 23:53:08 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 12 Jul 2011 14:49:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,522,1304319600"; d="scan'208";a="27131395"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.215])
	by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2011 14:49:08 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Jul 2011 14:48:58 -0700
Message-Id: <08247b1bc6021b9c79e92f4a396dc5d82c178363.1310507186.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1310507186.git.josh@linux.intel.com>
References: <cover.1310507186.git.josh@linux.intel.com>
In-Reply-To: <cover.1310507186.git.josh@linux.intel.com>
References: <cover.1310507186.git.josh@linux.intel.com>
Subject: [PATCH 1/3] ui/crumbs/tasklistmodel: update brought in by column when possible
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
X-List-Received-Date: Tue, 12 Jul 2011 21:53:08 -0000

When a package is orphaned we were not correctly updating the brought-in-by
column if a later package additon would have brought that package in as a
dependency. This patch ensures that orphan packages are correctly re-parented
when appropriate.

Partially addresses [YOCTO #1218]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index 5e979b7..3e74e7f 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -390,8 +390,9 @@ class TaskListModel(gtk.ListStore):
         if not cur_inc:
             self[item_path][self.COL_INC] = True
             self[item_path][self.COL_BINB] = binb
-        # We want to do some magic with things which are brought in by the base
-        # image so tag them as so
+
+        # We want to do some magic with things which are brought in by the
+        # base image so tag them as so
         if image_contents:
             self[item_path][self.COL_IMG] = True
             if self[item_path][self.COL_TYPE] == 'image':
@@ -403,12 +404,17 @@ class TaskListModel(gtk.ListStore):
                 # If the contents model doesn't already contain dep, add it
                 # We only care to show things which will end up in the
                 # resultant image, so filter cross and native recipes
-                if not self.contents_includes_name(dep) and not dep.endswith("-native") and not dep.endswith("-cross"):
-                    path = self.find_path_for_item(dep)
+                dep_included = self.contents_includes_name(dep)
+                path = self.find_path_for_item(dep)
+                if not dep_included and not dep.endswith("-native") and not dep.endswith("-cross"):
                     if path:
                         self.include_item(path, name, image_contents)
                     else:
                         pass
+                # Set brought in by for any no longer orphan packages
+                elif dep_included and path:
+                    if not self[path][self.COL_BINB]:
+                        self[path][self.COL_BINB] = name
 
     """
     Find the model path for the item_name
-- 
1.7.6



