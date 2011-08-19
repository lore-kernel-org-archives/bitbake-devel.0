Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QuDeD-0005Bu-Va
	for bitbake-devel@lists.openembedded.org;
	Fri, 19 Aug 2011 03:13:22 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 18 Aug 2011 18:08:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,248,1312182000"; d="scan'208";a="40058927"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.250])
	by azsmga001.ch.intel.com with ESMTP; 18 Aug 2011 18:08:38 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Aug 2011 18:08:17 -0700
Message-Id: <3cd02ef4939339c762db6943e93010ab8970d19a.1313715804.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313715804.git.josh@linux.intel.com>
References: <cover.1313715804.git.josh@linux.intel.com>
In-Reply-To: <cover.1313715804.git.josh@linux.intel.com>
References: <cover.1313715804.git.josh@linux.intel.com>
Subject: [PATCH 03/11] bb/ui/crumbs/tasklistmodel: more robust checking for substrings
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
X-List-Received-Date: Fri, 19 Aug 2011 01:13:22 -0000

Relying on the count() method of Str to determine whether the string
contains a substring is error prone purely because the return value doesn't
strictly convert to a Boolean value.
To that end take the more pythonic approach of using the in operator (foo
in bar) to check for the substring.
Further, add a helper method for the common case of testing whether a pn
is -native, -cross or virtual/

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index 203b628..fa16609 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -124,6 +124,14 @@ class TaskListModel(gtk.ListStore):
                                 gobject.TYPE_BOOLEAN,
                                 gobject.TYPE_STRING)
 
+    """
+    Helper method to determine whether name is a target pn
+    """
+    def non_target_name(self, name):
+        if ('-native' in name) or ('-cross' in name) or name.startswith('virtual/'):
+            return True
+        return False
+
     def contents_changed_cb(self, tree_model, path, it=None):
         pkg_cnt = self.contents.iter_n_children(None)
         self.emit("contents-changed", pkg_cnt)
@@ -132,7 +140,7 @@ class TaskListModel(gtk.ListStore):
         if not model.get_value(it, self.COL_INC) or model.get_value(it, self.COL_TYPE) == 'image':
             return False
         name = model.get_value(it, self.COL_NAME)
-        if name.count('-native') or name.count('-cross'):
+        if self.non_target_name(name):
             return False
         else:
             return True
@@ -196,7 +204,7 @@ class TaskListModel(gtk.ListStore):
             return False
         else:
             name = model.get_value(it, self.COL_NAME)
-            if name.count('-native') or name.count('-cross'):
+            if self.non_target_name(name):
                 return False
             return True
 
@@ -226,9 +234,9 @@ class TaskListModel(gtk.ListStore):
             lic = event_model["pn"][item]["license"]
             group = event_model["pn"][item]["section"]
             filename = event_model["pn"][item]["filename"]
-            if name.count('task-') > 0:
+            if ('task-' in name):
                 atype = 'task'
-            elif name.count('-image-') > 0:
+            elif ('-image-' in name):
                 atype = 'image'
 
             depends = event_model["depends"].get(item, [])
@@ -352,14 +360,14 @@ class TaskListModel(gtk.ListStore):
             # If the iterated item is included and depends on the removed
             # item it should also be removed.
             # FIXME: need to ensure partial name matching doesn't happen
-            if inc and deps.count(marked_name) and itname not in removed:
+            if inc and marked_name in deps and itname not in removed:
                 # found a dependency, remove it
                 removed.append(itname)
                 self.mark(path)
 
             # If the iterated item was brought in by the removed (passed) item
             # try and find an alternative dependee and update the binb column
-            if inc and binb.count(marked_name):
+            if inc and marked_name in binb:
                 bib = self.find_alt_dependency(itname)
                 self[path][self.COL_BINB] = bib
 
@@ -411,7 +419,7 @@ class TaskListModel(gtk.ListStore):
             deps = self.contents[path][self.COL_DEPS]
             itname = self.contents[path][self.COL_NAME]
             inc = self.contents[path][self.COL_INC]
-            if itname != name and inc and deps.count(name) > 0:
+            if itname != name and inc and name in deps:
 		# if this item depends on the item, return this items name
 	        return itname
 	    it = self.contents.iter_next(it)
@@ -471,7 +479,7 @@ class TaskListModel(gtk.ListStore):
     def find_path_for_item(self, item_name):
         # We don't include virtual/* or *-native items in the model so save a
         # heavy iteration loop by exiting early for these items
-        if item_name.startswith("virtual/") or item_name.count('-native') or item_name.count('-cross'):
+        if self.non_target_name(item_name):
             return None
 
         it = self.get_iter_first()
@@ -561,7 +569,7 @@ class TaskListModel(gtk.ListStore):
             if not itype == 'package':
                 continue
 
-            if deps.count(pn) != 0:
+            if pn not in deps:
                 revdeps.append(name)
 
         if pn in revdeps:
-- 
1.7.6



