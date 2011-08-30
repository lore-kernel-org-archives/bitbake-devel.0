Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QySoC-00068A-6z
	for bitbake-devel@lists.openembedded.org;
	Tue, 30 Aug 2011 20:13:12 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 30 Aug 2011 11:08:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,303,1312182000"; d="scan'208";a="43987479"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.52])
	by azsmga001.ch.intel.com with ESMTP; 30 Aug 2011 11:08:14 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Aug 2011 11:08:03 -0700
Message-Id: <d2450536269996147a22d6eafbdf72aa62afa4f6.1314727299.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1314727299.git.josh@linux.intel.com>
References: <cover.1314727299.git.josh@linux.intel.com>
In-Reply-To: <cover.1314727299.git.josh@linux.intel.com>
References: <cover.1314727299.git.josh@linux.intel.com>
Subject: [PATCH 3/6] ui/crumbs/tasklistmodel: optimise find_path_for_item()
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
X-List-Received-Date: Tue, 30 Aug 2011 18:13:12 -0000

Rather than calling get_path() for each iterated value use the get_value()
method to lookup the COL_NAME value and only call get_path() for a match.

This should save some time by potentially removing N-1 calls to get_path()
from the loop.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index 8413873..14a611f 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -481,11 +481,9 @@ class TaskListModel(gtk.ListStore):
             return None
 
         it = self.get_iter_first()
-        path = None
         while it:
-            path = self.get_path(it)
-            if (self[path][self.COL_NAME] == item_name):
-                return path
+            if (self.get_value(it, self.COL_NAME) == item_name):
+                return self.get_path(it)
             else:
                 it = self.iter_next(it)
         return None
-- 
1.7.6



