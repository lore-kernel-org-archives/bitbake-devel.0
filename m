Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QlvJd-0007hu-Px
	for bitbake-devel@lists.openembedded.org;
	Wed, 27 Jul 2011 06:01:49 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 26 Jul 2011 20:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,273,1309762800"; d="scan'208";a="34904868"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.163])
	by fmsmga001.fm.intel.com with ESMTP; 26 Jul 2011 20:57:34 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2011 20:57:24 -0700
Message-Id: <1e1055262450de994202fc3e5943b8b19f628681.1311738866.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311738866.git.josh@linux.intel.com>
References: <cover.1311738866.git.josh@linux.intel.com>
In-Reply-To: <cover.1311738866.git.josh@linux.intel.com>
References: <cover.1311738866.git.josh@linux.intel.com>
Subject: [PATCH 1/4] ui/crumbs/tasklistmodel: work around overly aggressive package removal
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
X-List-Received-Date: Wed, 27 Jul 2011 04:01:50 -0000

The mark() method, which removes dependent and rdependent items, is overly
aggressive removing items which are actually required by user selected
items and then causing a removal of those items. Because the data
structures used are not fine grained enough to do more intelligent
dependency tracking the simplest "fix" is to track removals which are
marked as "User Selected" and re-add those (and therefore their
dependencies) once the aggressive removal is completed.

Because the aggressive removal already ignores images and tasks this should
make the removal behave as expected though certainly leaves area for
improvement in future.

Fixes [YOCTO #1280].

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index ee6ebf8..d7dff3c 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -306,11 +306,15 @@ class TaskListModel(gtk.ListStore):
         self[path][self.COL_INC] = False
 
     """
-    recursively called to mark the item at opath and any package which
-    depends on it for removal
+    Recursively called to mark the item at opath and any package which
+    depends on it for removal.
+    NOTE: This method dumbly removes user selected packages and since we don't
+    do significant reverse dependency tracking it's easier and simpler to save
+    the items marked as user selected and re-add them once the removal sweep is
+    complete.
     """
     def mark(self, opath):
-        removals = []
+        usersel = {}
         it = self.get_iter_first()
         name = self[opath][self.COL_NAME]
 
@@ -325,19 +329,34 @@ class TaskListModel(gtk.ListStore):
             deps = self[path][self.COL_DEPS]
             binb = self[path][self.COL_BINB]
             itype = self[path][self.COL_TYPE]
+            iname = self[path][self.COL_NAME]
 
             # We ignore anything that isn't a package
             if not itype == "package":
                 continue
 
+            # If the user added this item and it's not the item we're removing
+            # we should keep it and its dependencies, the easiest way to do so
+            # is to save its name and re-mark it for inclusion once dependency
+            # processing is complete
+            if binb == "User Selected":
+                usersel[iname] = self[path][self.COL_IMG]
+
             # FIXME: need to ensure partial name matching doesn't happen
             if inc and deps.count(name):
                 # found a dependency, remove it
                 self.mark(path)
+
             if inc and binb.count(name):
                 bib = self.find_alt_dependency(name)
                 self[path][self.COL_BINB] = bib
 
+        # Re-add any removed user selected items
+        for u in usersel:
+            npath = self.find_path_for_item(u)
+            self.include_item(item_path=npath,
+                              binb="User Selected",
+                              image_contents=usersel[u])
     """
     Remove items from contents if the have an empty COL_BINB (brought in by)
     caused by all packages they are a dependency of being removed.
-- 
1.7.6



