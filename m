Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QgktA-0003ca-OG
	for bitbake-devel@lists.openembedded.org;
	Tue, 12 Jul 2011 23:53:08 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 12 Jul 2011 14:49:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,522,1304319600"; d="scan'208";a="27131398"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.215])
	by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2011 14:49:08 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Jul 2011 14:48:59 -0700
Message-Id: <788a2104732e8f00ee41f1cc283a31517fccfae6.1310507186.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1310507186.git.josh@linux.intel.com>
References: <cover.1310507186.git.josh@linux.intel.com>
In-Reply-To: <cover.1310507186.git.josh@linux.intel.com>
References: <cover.1310507186.git.josh@linux.intel.com>
Subject: [PATCH 2/3] ui/crumbs/tasklistmodel: fix automatic removal of orphaned items
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
X-List-Received-Date: Tue, 12 Jul 2011 21:53:09 -0000

The sweep_up() method intends to remove all packages with an empty brought in
by column, this patch changes the implementation to be more reliable.

Each time a removal is triggered we begin interating the contents model again
at the beginning, only once the contents model has been iterated from start
to finish without any removals can we be certain that there will be no more
orphaned items.

Fixes [YOCTO #1218]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index 3e74e7f..633931d 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -327,24 +327,28 @@ class TaskListModel(gtk.ListStore):
     If the item isn't a package we leave it included.
     """
     def sweep_up(self):
-        model = self.contents
-        removals = []
         it = self.contents.get_iter_first()
-
-	while it:
-            binb = model.get_value(it, self.COL_BINB)
-            itype = model.get_value(it, self.COL_TYPE)
+        while it:
+            binb = self.contents.get_value(it, self.COL_BINB)
+            itype = self.contents.get_value(it, self.COL_TYPE)
+            remove = False
 
             if itype == 'package' and not binb:
-                opath = model.convert_path_to_child_path(model.get_path(it))
-                if not opath in removals:
-                    removals.extend(opath)
-
-            it = model.iter_next(it)
-
-	while removals:
-	    path = removals.pop()
-	    self.mark(path)
+                oit = self.contents.convert_iter_to_child_iter(it)
+                opath = self.get_path(oit)
+                self.mark(opath)
+                remove = True
+
+            # When we remove a package from the contents model we alter the
+            # model, so continuing to iterate is bad. *Furthermore* it's
+            # likely that the removal has affected an already iterated item
+            # so we should start from the beginning anyway.
+            # Only when we've managed to iterate the entire contents model
+            # without removing any items do we allow the loop to exit.
+            if remove:
+                it = self.contents.get_iter_first()
+            else:
+                it = self.contents.iter_next(it)
 
     """
     Find the name of an item in the image contents which depends on the item
-- 
1.7.6



