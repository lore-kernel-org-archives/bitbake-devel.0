Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SJj15-00022e-9O
	for bitbake-devel@lists.openembedded.org;
	Mon, 16 Apr 2012 12:18:39 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 16 Apr 2012 03:08:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="132954759"
Received: from hp.sh.intel.com ([10.239.47.1])
	by orsmga002.jf.intel.com with ESMTP; 16 Apr 2012 03:08:08 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Apr 2012 18:09:48 +0800
Message-Id: <cb025c92d54ad2f20abc15f81d89fb26bf7dd65c.1334570665.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1334570665.git.limingx.l.an@intel.com>
References: <cover.1334570665.git.limingx.l.an@intel.com>
Subject: [PATCH 1/1] Hob: fixed a little view issue about package selection page
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
X-List-Received-Date: Mon, 16 Apr 2012 10:18:39 -0000

In package selection page, treeview cell data callback function not cover the 'else' case, so parent item will render the pervious value.

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index a42cdec..8cbd6aa 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -175,7 +175,8 @@ class HobViewTable (gtk.VBox):
         if binb:
             bin = binb.split(', ')
             cell.set_property('text', bin[0])
-
+        else:
+            cell.set_property('text', "")
         return True
 
     def set_model(self, tree_model):
-- 
1.7.5.4



