Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QuDeF-0005Br-6O
	for bitbake-devel@lists.openembedded.org;
	Fri, 19 Aug 2011 03:13:23 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 18 Aug 2011 18:08:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,248,1312182000"; d="scan'208";a="40058934"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.250])
	by azsmga001.ch.intel.com with ESMTP; 18 Aug 2011 18:08:39 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Aug 2011 18:08:19 -0700
Message-Id: <36e3265181c4747a0de85824b2dbb7cc199e5f11.1313715804.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313715804.git.josh@linux.intel.com>
References: <cover.1313715804.git.josh@linux.intel.com>
In-Reply-To: <cover.1313715804.git.josh@linux.intel.com>
References: <cover.1313715804.git.josh@linux.intel.com>
Subject: [PATCH 05/11] bb/ui/crumbs/tasklistmodel: store all binb, not just the first
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
X-List-Received-Date: Fri, 19 Aug 2011 01:13:23 -0000

This makes it easier for the user to determine what the effects of a
removal may be, further it means we no longer need the find_alt_dependency
method which could be a fairly time-consuming method depending on the size
of the contents table.

Partially addresses [YOCTO #1365]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |   50 ++++++++++++------------------------
 1 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index b0f5d7a..d2f49d1 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -350,7 +350,7 @@ class TaskListModel(gtk.ListStore):
 
             inc = self[path][self.COL_INC]
             deps = self[path][self.COL_DEPS]
-            binb = self[path][self.COL_BINB]
+            binb = self[path][self.COL_BINB].split(', ')
             itype = self[path][self.COL_TYPE]
             itname = self[path][self.COL_NAME]
 
@@ -362,7 +362,7 @@ class TaskListModel(gtk.ListStore):
             # we should keep it and its dependencies, the easiest way to do so
             # is to save its name and re-mark it for inclusion once dependency
             # processing is complete
-            if binb == "User Selected":
+            if "User Selected" in binb:
                 usersel[itname] = self[path][self.COL_IMG]
 
             # If the iterated item is included and depends on the removed
@@ -376,8 +376,8 @@ class TaskListModel(gtk.ListStore):
             # If the iterated item was brought in by the removed (passed) item
             # try and find an alternative dependee and update the binb column
             if inc and marked_name in binb:
-                bib = self.find_alt_dependency(itname)
-                self[path][self.COL_BINB] = bib
+                binb.remove(marked_name)
+                self[path][self.COL_BINB] = ', '.join(binb).lstrip(', ')
 
         # Re-add any removed user selected items
         for u in usersel:
@@ -415,25 +415,6 @@ class TaskListModel(gtk.ListStore):
                 it = self.contents.iter_next(it)
 
     """
-    Find the name of an item in the image contents which depends on the item
-    name.
-    Returns either an item name (str) or None
-    """
-    def find_alt_dependency(self, name):
-        it = self.contents.get_iter_first()
-        while it:
-            # iterate all items in the contents model
-            path = self.contents.get_path(it)
-            deps = self.contents[path][self.COL_DEPS]
-            itname = self.contents[path][self.COL_NAME]
-            inc = self.contents[path][self.COL_INC]
-            if itname != name and inc and name in deps:
-		# if this item depends on the item, return this items name
-	        return itname
-	    it = self.contents.iter_next(it)
-	return ""
-
-    """
     Check the self.contents gtk.TreeModel for an item
     where COL_NAME matches item_name
     Returns True if a match is found, False otherwise
@@ -456,7 +437,10 @@ class TaskListModel(gtk.ListStore):
         cur_inc = self[item_path][self.COL_INC]
         if not cur_inc:
             self[item_path][self.COL_INC] = True
-            self[item_path][self.COL_BINB] = binb
+
+        bin = self[item_path][self.COL_BINB].split(', ')
+        bin.append(binb)
+        self[item_path][self.COL_BINB] = ', '.join(bin).lstrip(', ')
 
         # We want to do some magic with things which are brought in by the
         # base image so tag them as so
@@ -469,16 +453,16 @@ class TaskListModel(gtk.ListStore):
             # add all of the deps and set their binb to this item
             for dep in deps.split(" "):
                 # If the contents model doesn't already contain dep, add it
-                # We only care to show things which will end up in the
-                # resultant image, so filter cross and native recipes
                 dep_included = self.contents_includes_name(dep)
                 path = self.find_path_for_item(dep)
-                if not dep_included and path:
-                    self.include_item(path, name, image_contents)
-                # Set brought in by for any no longer orphan packages
-                elif dep_included and path:
-                    if not self[path][self.COL_BINB]:
-                        self[path][self.COL_BINB] = name
+                if not path:
+                    continue
+                if dep_included:
+                    bin = self[path][self.COL_BINB].split(', ')
+                    bin.append(name)
+                    self[path][self.COL_BINB] = ', '.join(bin).lstrip(', ')
+                else:
+                    self.include_item(path, binb=name, image_contents=image_contents)
 
     """
     Find the model path for the item_name
@@ -535,7 +519,7 @@ class TaskListModel(gtk.ListStore):
 
         it = self.contents.get_iter_first()
         while it:
-            sel = self.contents.get_value(it, self.COL_BINB) == "User Selected"
+            sel = "User Selected" in self.contents.get_value(it, self.COL_BINB)
             name = self.contents.get_value(it, self.COL_NAME)
             allpkgs.append(name)
             if sel:
-- 
1.7.6



