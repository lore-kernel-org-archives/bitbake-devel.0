Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QrK0Z-0004cT-Rv
	for bitbake-devel@lists.openembedded.org;
	Thu, 11 Aug 2011 03:24:28 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 10 Aug 2011 18:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="37334315"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.222])
	by orsmga001.jf.intel.com with ESMTP; 10 Aug 2011 18:19:55 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Aug 2011 18:19:46 -0700
Message-Id: <93bae8f223cdeb7b7e31c309b5d785b97ae1c2ac.1313025215.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313025215.git.josh@linux.intel.com>
References: <cover.1313025215.git.josh@linux.intel.com>
In-Reply-To: <cover.1313025215.git.josh@linux.intel.com>
References: <cover.1313025215.git.josh@linux.intel.com>
Subject: [PATCH 2/4] bb/ui/crumbs/tasklistmodel: correctly uniquify dependency list
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
X-List-Received-Date: Thu, 11 Aug 2011 01:24:28 -0000

Fix thinko - the squish method returns a uniquified list, it doesn't modify
the list in place. Therefore the call to squish() was useless as its return
value was never assigned.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index 96814c2..aec80e2 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -235,7 +235,8 @@ class TaskListModel(gtk.ListStore):
                         if pn:
                             depends.append(pn)
 
-            self.squish(depends)
+            # uniquify the list of depends
+            depends = self.squish(depends)
             deps = " ".join(depends)
 
             if name.count('task-') > 0:
-- 
1.7.6



