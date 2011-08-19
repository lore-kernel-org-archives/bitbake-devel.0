Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QuDeE-0005Br-8K
	for bitbake-devel@lists.openembedded.org;
	Fri, 19 Aug 2011 03:13:22 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 18 Aug 2011 18:08:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,248,1312182000"; d="scan'208";a="40058932"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.250])
	by azsmga001.ch.intel.com with ESMTP; 18 Aug 2011 18:08:39 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Aug 2011 18:08:18 -0700
Message-Id: <229c8367330fe3f713d39d79e068f6ab6f8bc211.1313715804.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313715804.git.josh@linux.intel.com>
References: <cover.1313715804.git.josh@linux.intel.com>
In-Reply-To: <cover.1313715804.git.josh@linux.intel.com>
References: <cover.1313715804.git.josh@linux.intel.com>
Subject: [PATCH 04/11] bb/ui/crumbs/tasklistmodel: remove useless items from dependency list
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

Ensure the dependency list is uniquified, doesn't include self references
and further doesn't include -dev references.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index fa16609..b0f5d7a 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -239,10 +239,11 @@ class TaskListModel(gtk.ListStore):
             elif ('-image-' in name):
                 atype = 'image'
 
+            # Create a combined list of build and runtime dependencies and
+            # then remove any duplicate entries and any entries for -dev
+            # packages
             depends = event_model["depends"].get(item, [])
             rdepends = event_model["rdepends-pn"].get(item, [])
-            if ("%s-dev" % item) in rdepends:
-                rdepends.remove("%s-dev" % item)
             packages = {}
             for pkg in event_model["packages"]:
                 if event_model["packages"][pkg]["pn"] == name:
@@ -250,6 +251,13 @@ class TaskListModel(gtk.ListStore):
                     deps.extend(depends)
                     deps.extend(event_model["rdepends-pkg"].get(pkg, []))
                     deps.extend(rdepends)
+                    deps = self.squish(deps)
+                    # rdepends-pn includes pn-dev
+                    if ("%s-dev" % item) in deps:
+                        deps.remove("%s-dev" % item)
+                    # rdepends-on includes pn
+                    if pkg in deps:
+                        deps.remove(pkg)
                     packages[pkg] = deps
 
             for p in packages:
-- 
1.7.6



