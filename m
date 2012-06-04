Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SbV0i-0002hc-7L
	for bitbake-devel@lists.openembedded.org;
	Mon, 04 Jun 2012 12:59:44 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 04 Jun 2012 03:49:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="152298113"
Received: from hp.sh.intel.com ([10.239.47.6])
	by orsmga002.jf.intel.com with ESMTP; 04 Jun 2012 03:49:19 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  4 Jun 2012 18:52:11 +0800
Message-Id: <535a0a1719495d21ca0e89a04de41e19e686d973.1338806537.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <57f497956749ad3a4c41051cb12f7a3b97f0254e.1338806537.git.limingx.l.an@intel.com>
References: <57f497956749ad3a4c41051cb12f7a3b97f0254e.1338806537.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1338806537.git.limingx.l.an@intel.com>
References: <cover.1338806537.git.limingx.l.an@intel.com>
Subject: [PATCH 2/5] Hob: fix entry of recipe page can't be edited in case after clicked clear button
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
X-List-Received-Date: Mon, 04 Jun 2012 10:59:44 -0000

cancel some inviable code and fixed this issue

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index bd9e2e2..afcd5b8 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -529,14 +529,8 @@ class HobNotebook(gtk.Notebook):
         self.reset_entry(search)
 
     def set_search_entry_clear_cb(self, search, icon_pos, event):
-        self.reset_entry(search)
-
-    def set_page(self, title):
-        for child in self.tabbar.children:
-            if child["title"] == title:
-                self.tabbar.current_child = child
-                self.tabbar.grab_focus()
-                self.notebook.set_current_page(child["toggled_page"])
+        if search.get_editable() == True:
+            search.set_text("")
 
 class HobWarpCellRendererText(gtk.CellRendererText):
     def __init__(self, col_number):
-- 
1.7.5.4



