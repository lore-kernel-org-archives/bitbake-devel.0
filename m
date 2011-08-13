Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qs2pP-0000bu-KR
	for bitbake-devel@lists.openembedded.org;
	Sat, 13 Aug 2011 03:15:55 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 12 Aug 2011 18:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,365,1309762800"; d="scan'208";a="38018967"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.15.3])
	by azsmga001.ch.intel.com with ESMTP; 12 Aug 2011 18:11:03 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Aug 2011 18:10:53 -0700
Message-Id: <a7d7de3ab3499065502cffbb30ecff110fb57a9c.1313197700.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313197700.git.josh@linux.intel.com>
References: <cover.1313197700.git.josh@linux.intel.com>
In-Reply-To: <cover.1313197700.git.josh@linux.intel.com>
References: <cover.1313197700.git.josh@linux.intel.com>
Subject: [PATCH 3/5] bb/ui/crumbs/tasklistmodel: optimise find_path_for_item
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
X-List-Received-Date: Sat, 13 Aug 2011 01:15:55 -0000

If the item_name contains virtual/, -native or -cross it won't be present
in the model. Return None early in this circumstance rather than iterating
the entire model and still returning None.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index 1f00f6c..baf4ede 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -472,6 +472,11 @@ class TaskListModel(gtk.ListStore):
     Returns the path in the model or None
     """
     def find_path_for_item(self, item_name):
+        # We don't include virtual/* or *-native items in the model so save a
+        # heavy iteration loop by exiting early for these items
+        if item_name.startswith("virtual/") or item_name.count('-native') or item_name.count('-cross'):
+            return None
+
         it = self.get_iter_first()
         path = None
         while it:
-- 
1.7.6



