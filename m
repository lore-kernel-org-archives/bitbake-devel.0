Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qs2pS-0000c3-7n
	for bitbake-devel@lists.openembedded.org;
	Sat, 13 Aug 2011 03:15:58 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 12 Aug 2011 18:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,365,1309762800"; d="scan'208";a="38018971"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.15.3])
	by azsmga001.ch.intel.com with ESMTP; 12 Aug 2011 18:11:04 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Aug 2011 18:10:55 -0700
Message-Id: <f69b184998c7ee6a462fc0c35e3aed9328ca885d.1313197700.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313197700.git.josh@linux.intel.com>
References: <cover.1313197700.git.josh@linux.intel.com>
In-Reply-To: <cover.1313197700.git.josh@linux.intel.com>
References: <cover.1313197700.git.josh@linux.intel.com>
Subject: [PATCH 5/5] bb/ui/crumbs/tasklistmodel: simplify conditional in include_item
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

No need to check if the name ends with -native or -cross as path will be
None in this instance.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index 4da3e1e..203b628 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -457,11 +457,8 @@ class TaskListModel(gtk.ListStore):
                 # resultant image, so filter cross and native recipes
                 dep_included = self.contents_includes_name(dep)
                 path = self.find_path_for_item(dep)
-                if not dep_included and not dep.endswith("-native") and not dep.endswith("-cross"):
-                    if path:
-                        self.include_item(path, name, image_contents)
-                    else:
-                        pass
+                if not dep_included and path:
+                    self.include_item(path, name, image_contents)
                 # Set brought in by for any no longer orphan packages
                 elif dep_included and path:
                     if not self[path][self.COL_BINB]:
-- 
1.7.6



