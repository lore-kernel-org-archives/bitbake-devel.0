Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QySoA-00068A-9A
	for bitbake-devel@lists.openembedded.org;
	Tue, 30 Aug 2011 20:13:10 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 30 Aug 2011 11:08:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,303,1312182000"; d="scan'208";a="43987474"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.52])
	by azsmga001.ch.intel.com with ESMTP; 30 Aug 2011 11:08:13 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Aug 2011 11:08:01 -0700
Message-Id: <6ad1103b5fd592afa9ea03ef5a0d706604cc0e0f.1314727299.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1314727299.git.josh@linux.intel.com>
References: <cover.1314727299.git.josh@linux.intel.com>
In-Reply-To: <cover.1314727299.git.josh@linux.intel.com>
References: <cover.1314727299.git.josh@linux.intel.com>
Subject: [PATCH 1/6] ui/crumbs/tasklistmodel: don't add same item to binb column more than once
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
X-List-Received-Date: Tue, 30 Aug 2011 18:13:10 -0000

In the same vein as a similar, earlier, patch where I missed the second
loop which modifies the binb column.

Fixes [YOCTO #1420]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index cf9fc59..edb4d96 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -462,8 +462,9 @@ class TaskListModel(gtk.ListStore):
                     continue
                 if dep_included:
                     bin = self[path][self.COL_BINB].split(', ')
-                    bin.append(name)
-                    self[path][self.COL_BINB] = ', '.join(bin).lstrip(', ')
+                    if not name in bin:
+                        bin.append(name)
+                        self[path][self.COL_BINB] = ', '.join(bin).lstrip(', ')
                 else:
                     self.include_item(path, binb=name, image_contents=image_contents)
 
-- 
1.7.6



