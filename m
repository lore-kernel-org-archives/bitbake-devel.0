Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qx85s-0005Lx-Um
	for bitbake-devel@lists.openembedded.org;
	Sat, 27 Aug 2011 03:53:57 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 26 Aug 2011 18:49:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,288,1312182000"; d="scan'208";a="45524223"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.247])
	by fmsmga001.fm.intel.com with ESMTP; 26 Aug 2011 18:49:05 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 26 Aug 2011 18:48:58 -0700
Message-Id: <5e95098be1c1f92c2d72fb371c94bab31c46cf83.1314409608.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1314409608.git.josh@linux.intel.com>
References: <cover.1314409608.git.josh@linux.intel.com>
In-Reply-To: <cover.1314409608.git.josh@linux.intel.com>
References: <cover.1314409608.git.josh@linux.intel.com>
Subject: [PATCH 1/2] ui/crumbs/tasklistmodel: don't add same item to binb column more than once
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
X-List-Received-Date: Sat, 27 Aug 2011 01:53:57 -0000

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index 5ff1f5a..cf9fc59 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -441,8 +441,9 @@ class TaskListModel(gtk.ListStore):
             self[item_path][self.COL_INC] = True
 
         bin = self[item_path][self.COL_BINB].split(', ')
-        bin.append(binb)
-        self[item_path][self.COL_BINB] = ', '.join(bin).lstrip(', ')
+        if not binb in bin:
+            bin.append(binb)
+            self[item_path][self.COL_BINB] = ', '.join(bin).lstrip(', ')
 
         # We want to do some magic with things which are brought in by the
         # base image so tag them as so
-- 
1.7.6



