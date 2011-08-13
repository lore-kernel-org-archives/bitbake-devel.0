Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qs2pQ-0000bu-F3
	for bitbake-devel@lists.openembedded.org;
	Sat, 13 Aug 2011 03:15:56 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 12 Aug 2011 18:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,365,1309762800"; d="scan'208";a="38018969"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.15.3])
	by azsmga001.ch.intel.com with ESMTP; 12 Aug 2011 18:11:04 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Aug 2011 18:10:54 -0700
Message-Id: <54d4d563bbf1e575c623454292d89dd0f1bf3f70.1313197700.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313197700.git.josh@linux.intel.com>
References: <cover.1313197700.git.josh@linux.intel.com>
In-Reply-To: <cover.1313197700.git.josh@linux.intel.com>
References: <cover.1313197700.git.josh@linux.intel.com>
Subject: [PATCH 4/5] bb/ui/crumbs/tasklistmodel: make package_model_filter a little safer
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
X-List-Received-Date: Sat, 13 Aug 2011 01:15:56 -0000

Ignore names that include '-cross', rather than just 'cross'

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index baf4ede..4da3e1e 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -196,7 +196,7 @@ class TaskListModel(gtk.ListStore):
             return False
         else:
             name = model.get_value(it, self.COL_NAME)
-            if name.count('-native') or name.count('cross'):
+            if name.count('-native') or name.count('-cross'):
                 return False
             return True
 
-- 
1.7.6



