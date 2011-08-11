Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QrK0a-0004cS-K0
	for bitbake-devel@lists.openembedded.org;
	Thu, 11 Aug 2011 03:24:28 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 10 Aug 2011 18:19:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="37334317"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.222])
	by orsmga001.jf.intel.com with ESMTP; 10 Aug 2011 18:19:56 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Aug 2011 18:19:47 -0700
Message-Id: <396bbc220604c19ced4add30dd17f7f22d5e0022.1313025215.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313025215.git.josh@linux.intel.com>
References: <cover.1313025215.git.josh@linux.intel.com>
In-Reply-To: <cover.1313025215.git.josh@linux.intel.com>
References: <cover.1313025215.git.josh@linux.intel.com>
Subject: [PATCH 3/4] bb/ui/crumbs/tasklistmodel: don't include an item in its own depends
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

This causes the simple removal algorithm to perform needless circular logic

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index aec80e2..7a463a6 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -237,6 +237,9 @@ class TaskListModel(gtk.ListStore):
 
             # uniquify the list of depends
             depends = self.squish(depends)
+            # remove circular dependencies
+            if name in depends:
+                depends.remove(name)
             deps = " ".join(depends)
 
             if name.count('task-') > 0:
-- 
1.7.6



