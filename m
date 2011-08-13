Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qs2pR-0000bu-9W
	for bitbake-devel@lists.openembedded.org;
	Sat, 13 Aug 2011 03:15:57 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 12 Aug 2011 18:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,365,1309762800"; d="scan'208";a="38018963"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.15.3])
	by azsmga001.ch.intel.com with ESMTP; 12 Aug 2011 18:11:02 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Aug 2011 18:10:51 -0700
Message-Id: <c11dd89a8a37017d238dffccac17e92e7503a5e5.1313197700.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313197700.git.josh@linux.intel.com>
References: <cover.1313197700.git.josh@linux.intel.com>
In-Reply-To: <cover.1313197700.git.josh@linux.intel.com>
References: <cover.1313197700.git.josh@linux.intel.com>
Subject: [PATCH 1/5] bb/crumbs/tasklistmodel: filter nativesdk packages out of views
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
X-List-Received-Date: Sat, 13 Aug 2011 01:15:57 -0000

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index 7a463a6..c0b0495 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -132,7 +132,7 @@ class TaskListModel(gtk.ListStore):
         if not model.get_value(it, self.COL_INC) or model.get_value(it, self.COL_TYPE) == 'image':
             return False
         name = model.get_value(it, self.COL_NAME)
-        if name.endswith('-native') or name.endswith('-cross'):
+        if name.count('-native') or name.count('-cross'):
             return False
         else:
             return True
-- 
1.7.6



