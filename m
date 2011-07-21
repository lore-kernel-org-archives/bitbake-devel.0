Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qjy4W-00053G-Jq
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jul 2011 20:34:08 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 21 Jul 2011 11:29:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,242,1309762800"; d="scan'208";a="28648892"
Received: from vorpal.jf.intel.com ([10.7.199.57])
	by orsmga002.jf.intel.com with ESMTP; 21 Jul 2011 11:29:55 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2011 11:34:23 -0700
Message-Id: <205b52bfc7f28af0c50fef1f741fae6af16fb0dc.1311273097.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311273097.git.josh@linux.intel.com>
References: <cover.1311273097.git.josh@linux.intel.com>
In-Reply-To: <cover.1311273097.git.josh@linux.intel.com>
References: <cover.1311273097.git.josh@linux.intel.com>
Subject: [PATCH 6/6] ui/crumbs/tasklistmodel: ignore tasks and images when marking dependencies
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
X-List-Received-Date: Thu, 21 Jul 2011 18:34:08 -0000

When calculating what dependencies are affected by the removal of an item
we should ignore images and tasks as they are not constructs which make
sense in the GUI.
E.g: if we don't ignore tasks and remove opkg from an image based on
core-image-minimal the fact that opkg was brought in by task-core results
in task-core and all of the packages it brought in being removed and,
eventually, an empty image.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index e28dbe7..112fdde 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -306,9 +306,16 @@ class TaskListModel(gtk.ListStore):
         # Remove all dependent packages, update binb
         while it:
             path = self.get_path(it)
+            it = self.iter_next(it)
+
             inc = self[path][self.COL_INC]
             deps = self[path][self.COL_DEPS]
             binb = self[path][self.COL_BINB]
+            itype = self[path][self.COL_TYPE]
+
+            # We ignore anything that isn't a package
+            if not itype == "package":
+                continue
 
             # FIXME: need to ensure partial name matching doesn't happen
             if inc and deps.count(name):
@@ -318,8 +325,6 @@ class TaskListModel(gtk.ListStore):
                 bib = self.find_alt_dependency(name)
                 self[path][self.COL_BINB] = bib
 
-            it = self.iter_next(it)
-
     """
     Remove items from contents if the have an empty COL_BINB (brought in by)
     caused by all packages they are a dependency of being removed.
@@ -488,10 +493,18 @@ class TaskListModel(gtk.ListStore):
         it = self.contents.get_iter_first()
 
         while it:
-            if self.contents.get_value(it, self.COL_DEPS).count(pn) != 0:
-                revdeps.append(self.contents.get_value(it, self.COL_NAME))
+            name = self.contents.get_value(it, self.COL_NAME)
+            itype = self.contents.get_value(it, self.COL_TYPE)
+            deps = self.contents.get_value(it, self.COL_DEPS)
+
             it = self.contents.iter_next(it)
 
+            if not itype == 'package':
+                continue
+
+            if deps.count(pn) != 0:
+                revdeps.append(name)
+
         if pn in revdeps:
             revdeps.remove(pn)
         return revdeps
-- 
1.7.6



