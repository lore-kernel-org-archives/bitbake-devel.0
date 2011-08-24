Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QwK1H-00010b-0E
	for bitbake-devel@lists.openembedded.org;
	Wed, 24 Aug 2011 22:25:51 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 24 Aug 2011 13:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="41542777"
Received: from vorpal.jf.intel.com ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 24 Aug 2011 13:21:01 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 24 Aug 2011 13:25:59 -0700
Message-Id: <dd31d68839ab5805f8179c87bf39b711b4a7b16a.1314217450.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1314217450.git.josh@linux.intel.com>
References: <cover.1314217450.git.josh@linux.intel.com>
In-Reply-To: <cover.1314217450.git.josh@linux.intel.com>
References: <cover.1314217450.git.josh@linux.intel.com>
Subject: [PATCH 2/3] bb/ui/crumbs/tasklistmodel: fix find_reverse_depends method
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
X-List-Received-Date: Wed, 24 Aug 2011 20:25:51 -0000

This fixes an embarassing typo which meant the method actually returned a
list of packages which didn't depend on the passed pn.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index 3921581..5ff1f5a 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -577,7 +577,7 @@ class TaskListModel(gtk.ListStore):
             if not itype == 'package':
                 continue
 
-            if pn not in deps:
+            if pn in deps:
                 revdeps.append(name)
 
         if pn in revdeps:
-- 
1.7.6



