Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qs2pS-0000bu-7S
	for bitbake-devel@lists.openembedded.org;
	Sat, 13 Aug 2011 03:15:58 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 12 Aug 2011 18:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,365,1309762800"; d="scan'208";a="38018964"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.15.3])
	by azsmga001.ch.intel.com with ESMTP; 12 Aug 2011 18:11:03 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Aug 2011 18:10:52 -0700
Message-Id: <9235cb7403dd3a76d77f523e7265ce26c916b711.1313197700.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313197700.git.josh@linux.intel.com>
References: <cover.1313197700.git.josh@linux.intel.com>
In-Reply-To: <cover.1313197700.git.josh@linux.intel.com>
References: <cover.1313197700.git.josh@linux.intel.com>
Subject: [PATCH 2/5] bb/ui/crumbs/tasklistmodel: include package level information
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
X-List-Received-Date: Sat, 13 Aug 2011 01:15:58 -0000

Until now the hob UI has only contained recipe (pn) level targets in the
data store, this patch switches to including package level information.

This is slightly slower in all model related cases (more entries) but gives
much more flexibility for image customisation.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |   40 +++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index c0b0495..1f00f6c 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -226,32 +226,30 @@ class TaskListModel(gtk.ListStore):
             lic = event_model["pn"][item]["license"]
             group = event_model["pn"][item]["section"]
             filename = event_model["pn"][item]["filename"]
-            depends = event_model["depends"].get(item, "")
-            rdepends = event_model["rdepends-pn"].get(item, "")
-            if rdepends:
-                for rdep in rdepends:
-                    if event_model["packages"].get(rdep, ""):
-                        pn = event_model["packages"][rdep].get("pn", "")
-                        if pn:
-                            depends.append(pn)
-
-            # uniquify the list of depends
-            depends = self.squish(depends)
-            # remove circular dependencies
-            if name in depends:
-                depends.remove(name)
-            deps = " ".join(depends)
-
             if name.count('task-') > 0:
                 atype = 'task'
             elif name.count('-image-') > 0:
                 atype = 'image'
 
-            self.set(self.append(), self.COL_NAME, name, self.COL_DESC, summary,
-                     self.COL_LIC, lic, self.COL_GROUP, group,
-                     self.COL_DEPS, deps, self.COL_BINB, "",
-                     self.COL_TYPE, atype, self.COL_INC, False,
-                     self.COL_IMG, False, self.COL_PATH, filename)
+            depends = event_model["depends"].get(item, [])
+            rdepends = event_model["rdepends-pn"].get(item, [])
+            if ("%s-dev" % item) in rdepends:
+                rdepends.remove("%s-dev" % item)
+            packages = {}
+            for pkg in event_model["packages"]:
+                if event_model["packages"][pkg]["pn"] == name:
+                    deps = []
+                    deps.extend(depends)
+                    deps.extend(event_model["rdepends-pkg"].get(pkg, []))
+                    deps.extend(rdepends)
+                    packages[pkg] = deps
+
+            for p in packages:
+                self.set(self.append(), self.COL_NAME, p, self.COL_DESC, summary,
+                         self.COL_LIC, lic, self.COL_GROUP, group,
+                         self.COL_DEPS, " ".join(packages[p]), self.COL_BINB, "",
+                         self.COL_TYPE, atype, self.COL_INC, False,
+                         self.COL_IMG, False, self.COL_PATH, filename)
 
 	self.emit("tasklist-populated")
 
-- 
1.7.6



