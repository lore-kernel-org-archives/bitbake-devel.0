Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QySoB-00068A-3i
	for bitbake-devel@lists.openembedded.org;
	Tue, 30 Aug 2011 20:13:11 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 30 Aug 2011 11:08:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,303,1312182000"; d="scan'208";a="43987477"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.52])
	by azsmga001.ch.intel.com with ESMTP; 30 Aug 2011 11:08:14 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Aug 2011 11:08:02 -0700
Message-Id: <01ef2ab0d201f3cb3666462558c9cf485592e04f.1314727299.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1314727299.git.josh@linux.intel.com>
References: <cover.1314727299.git.josh@linux.intel.com>
In-Reply-To: <cover.1314727299.git.josh@linux.intel.com>
References: <cover.1314727299.git.josh@linux.intel.com>
Subject: [PATCH 2/6] ui/crumbs/tasklistmodel: prevent packages depending on each other
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
X-List-Received-Date: Tue, 30 Aug 2011 18:13:11 -0000

Don't add y to x's COL_BINB if x is in y's COL_BINB - prevent circular
dependencies.

Further this patch improves the variable naming to make this code easier to
follow.

Fixes [YOCTO #1423]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |   42 +++++++++++++++++++-----------------
 1 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index edb4d96..8413873 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -434,39 +434,41 @@ class TaskListModel(gtk.ListStore):
     Add this item, and any of its dependencies, to the image contents
     """
     def include_item(self, item_path, binb="", image_contents=False):
-        name = self[item_path][self.COL_NAME]
-        deps = self[item_path][self.COL_DEPS]
-        cur_inc = self[item_path][self.COL_INC]
-        if not cur_inc:
+        item_name = self[item_path][self.COL_NAME]
+        item_deps = self[item_path][self.COL_DEPS]
+        item_inc = self[item_path][self.COL_INC]
+        if not item_inc:
             self[item_path][self.COL_INC] = True
 
-        bin = self[item_path][self.COL_BINB].split(', ')
-        if not binb in bin:
-            bin.append(binb)
-            self[item_path][self.COL_BINB] = ', '.join(bin).lstrip(', ')
+        item_bin = self[item_path][self.COL_BINB].split(', ')
+        if not binb in item_bin:
+            item_bin.append(binb)
+            self[item_path][self.COL_BINB] = ', '.join(item_bin).lstrip(', ')
 
         # We want to do some magic with things which are brought in by the
         # base image so tag them as so
         if image_contents:
             self[item_path][self.COL_IMG] = True
             if self[item_path][self.COL_TYPE] == 'image':
-                self.selected_image = name
+                self.selected_image = item_name
 
-        if deps:
+        if item_deps:
             # add all of the deps and set their binb to this item
-            for dep in deps.split(" "):
+            for dep in item_deps.split(" "):
                 # If the contents model doesn't already contain dep, add it
                 dep_included = self.contents_includes_name(dep)
-                path = self.find_path_for_item(dep)
-                if not path:
+                dep_path = self.find_path_for_item(dep)
+                if not dep_path:
                     continue
-                if dep_included:
-                    bin = self[path][self.COL_BINB].split(', ')
-                    if not name in bin:
-                        bin.append(name)
-                        self[path][self.COL_BINB] = ', '.join(bin).lstrip(', ')
-                else:
-                    self.include_item(path, binb=name, image_contents=image_contents)
+                if dep_included and not dep in item_bin:
+                    # don't set the COL_BINB to this item if the target is an
+                    # item in our own COL_BINB
+                    dep_bin = self[dep_path][self.COL_BINB].split(', ')
+                    if not item_name in dep_bin:
+                        dep_bin.append(item_name)
+                        self[dep_path][self.COL_BINB] = ', '.join(dep_bin).lstrip(', ')
+                elif not dep_included:
+                    self.include_item(dep_path, binb=item_name, image_contents=image_contents)
 
     """
     Find the model path for the item_name
-- 
1.7.6



