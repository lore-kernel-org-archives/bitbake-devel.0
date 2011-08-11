Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QreBg-0004uv-H8
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 00:57:16 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 11 Aug 2011 15:52:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="36965235"
Received: from vorpal.jf.intel.com ([10.7.199.53])
	by orsmga002.jf.intel.com with ESMTP; 11 Aug 2011 15:52:43 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Aug 2011 15:57:24 -0700
Message-Id: <ba9f2fe496eec0a221b563ffc9bb76eca592192f.1313103368.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313103368.git.josh@linux.intel.com>
References: <cover.1313103368.git.josh@linux.intel.com>
In-Reply-To: <cover.1313103368.git.josh@linux.intel.com>
References: <cover.1313103368.git.josh@linux.intel.com>
Subject: [PATCH 1/8] bb/ui/crumbs/tasklistmodel: fix some typos and add comments to mark()
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
X-List-Received-Date: Thu, 11 Aug 2011 22:57:16 -0000

Two similarly named variables in the mark() method resulted in the wrong
variable being used in a couple of places. This patch adresses this in
several ways:
1) Renames the variables to be less similar
2) Uses the correct variables
3) Adds some coments to document the methods intent

Partially addresses [YOCTO #1355]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index 3e09757..96814c2 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -316,9 +316,13 @@ class TaskListModel(gtk.ListStore):
     def mark(self, opath):
         usersel = {}
         removed = []
+
         it = self.get_iter_first()
-        name = self[opath][self.COL_NAME]
+        # The name of the item we're removing, so that we can use it to find
+        # other items which either depend on it, or were brought in by it
+        marked_name = self[opath][self.COL_NAME]
 
+        # Remove the passed item
         self.remove_item_path(opath)
 
         # Remove all dependent packages, update binb
@@ -330,7 +334,7 @@ class TaskListModel(gtk.ListStore):
             deps = self[path][self.COL_DEPS]
             binb = self[path][self.COL_BINB]
             itype = self[path][self.COL_TYPE]
-            iname = self[path][self.COL_NAME]
+            itname = self[path][self.COL_NAME]
 
             # We ignore anything that isn't a package
             if not itype == "package":
@@ -341,16 +345,20 @@ class TaskListModel(gtk.ListStore):
             # is to save its name and re-mark it for inclusion once dependency
             # processing is complete
             if binb == "User Selected":
-                usersel[iname] = self[path][self.COL_IMG]
+                usersel[itname] = self[path][self.COL_IMG]
 
+            # If the iterated item is included and depends on the removed
+            # item it should also be removed.
             # FIXME: need to ensure partial name matching doesn't happen
-            if inc and deps.count(name) and name not in removed:
+            if inc and deps.count(marked_name) and itname not in removed:
                 # found a dependency, remove it
-                removed.append(name)
+                removed.append(itname)
                 self.mark(path)
 
-            if inc and binb.count(name):
-                bib = self.find_alt_dependency(name)
+            # If the iterated item was brought in by the removed (passed) item
+            # try and find an alternative dependee and update the binb column
+            if inc and binb.count(marked_name):
+                bib = self.find_alt_dependency(itname)
                 self[path][self.COL_BINB] = bib
 
         # Re-add any removed user selected items
-- 
1.7.6



