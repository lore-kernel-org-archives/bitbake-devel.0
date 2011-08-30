Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QySoC-00068J-T3
	for bitbake-devel@lists.openembedded.org;
	Tue, 30 Aug 2011 20:13:13 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 30 Aug 2011 11:08:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,303,1312182000"; d="scan'208";a="43987482"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.52])
	by azsmga001.ch.intel.com with ESMTP; 30 Aug 2011 11:08:14 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Aug 2011 11:08:04 -0700
Message-Id: <12c6f98ba7a68baeeaee00594d910e1be8d55d87.1314727299.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1314727299.git.josh@linux.intel.com>
References: <cover.1314727299.git.josh@linux.intel.com>
In-Reply-To: <cover.1314727299.git.josh@linux.intel.com>
References: <cover.1314727299.git.josh@linux.intel.com>
Subject: [PATCH 4/6] ui/crumbs/tasklistmodel: remove unnecessary check
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
X-List-Received-Date: Tue, 30 Aug 2011 18:13:13 -0000

Cheaper to set COL_INC to True regardless of whether it's already set.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index 14a611f..790631f 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -436,9 +436,8 @@ class TaskListModel(gtk.ListStore):
     def include_item(self, item_path, binb="", image_contents=False):
         item_name = self[item_path][self.COL_NAME]
         item_deps = self[item_path][self.COL_DEPS]
-        item_inc = self[item_path][self.COL_INC]
-        if not item_inc:
-            self[item_path][self.COL_INC] = True
+
+        self[item_path][self.COL_INC] = True
 
         item_bin = self[item_path][self.COL_BINB].split(', ')
         if not binb in item_bin:
-- 
1.7.6



