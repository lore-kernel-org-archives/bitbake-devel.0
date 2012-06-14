Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1Sf9BO-0004DC-9u
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 14:29:50 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 14 Jun 2012 05:19:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="156320948"
Received: from hp.sh.intel.com ([10.239.47.6])
	by azsmga001.ch.intel.com with ESMTP; 14 Jun 2012 05:19:11 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 Jun 2012 20:22:25 +0800
Message-Id: <d226436d6adfb063aee2c549e7dd28620414aa9b.1339676383.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1339676383.git.limingx.l.an@intel.com>
References: <cover.1339676383.git.limingx.l.an@intel.com>
Subject: [PATCH 1/2] Hob: fixed an issue about no 'set_page' function in hob failed page show
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
X-List-Received-Date: Thu, 14 Jun 2012 12:29:50 -0000

Due in mistake deletion in previous patches, if building failed, will report
the error of no 'set_page', so add that function.

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index afcd5b8..dba278c 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -532,6 +532,12 @@ class HobNotebook(gtk.Notebook):
         if search.get_editable() == True:
             search.set_text("")
 
+    def set_page(self, title):
+        for child in self.pages:
+            if child.lbl.get_label() == title:
+                child.grab_focus()
+                self.set_current_page(self.page_num(child))
+
 class HobWarpCellRendererText(gtk.CellRendererText):
     def __init__(self, col_number):
         gtk.CellRendererText.__init__(self)
-- 
1.7.5.4



