Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qqb2S-0003xC-Hj
	for bitbake-devel@lists.openembedded.org;
	Tue, 09 Aug 2011 03:23:24 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 08 Aug 2011 18:18:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,340,1309762800"; d="scan'208";a="36498550"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.247])
	by azsmga001.ch.intel.com with ESMTP; 08 Aug 2011 18:18:39 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  8 Aug 2011 18:18:28 -0700
Message-Id: <0ed58f28e869cceeefa930a3f1f46c5f3e9ffe21.1312852599.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312852599.git.josh@linux.intel.com>
References: <cover.1312852599.git.josh@linux.intel.com>
In-Reply-To: <cover.1312852599.git.josh@linux.intel.com>
References: <cover.1312852599.git.josh@linux.intel.com>
Subject: [PATCH 1/4] bb/ui/crumbs/tasklistmodel: prevent hang when removing item
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
X-List-Received-Date: Tue, 09 Aug 2011 01:23:24 -0000

It's possible to trigger an infinite recursion when removing a package
where many of the dependencies share their dependencies. Prevent this by
keeping a list of removed item names and only removing the item when it's
not in the list.

Addresses [YOCTO #1319]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index 8fb5683..3e09757 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -315,6 +315,7 @@ class TaskListModel(gtk.ListStore):
     """
     def mark(self, opath):
         usersel = {}
+        removed = []
         it = self.get_iter_first()
         name = self[opath][self.COL_NAME]
 
@@ -343,8 +344,9 @@ class TaskListModel(gtk.ListStore):
                 usersel[iname] = self[path][self.COL_IMG]
 
             # FIXME: need to ensure partial name matching doesn't happen
-            if inc and deps.count(name):
+            if inc and deps.count(name) and name not in removed:
                 # found a dependency, remove it
+                removed.append(name)
                 self.mark(path)
 
             if inc and binb.count(name):
-- 
1.7.6



