Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SC7UQ-00006o-2d
	for bitbake-devel@lists.openembedded.org;
	Mon, 26 Mar 2012 12:49:30 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 26 Mar 2012 03:39:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="121679623"
Received: from hp.sh.intel.com ([10.239.47.1])
	by orsmga001.jf.intel.com with ESMTP; 26 Mar 2012 03:39:08 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Mar 2012 18:41:10 +0800
Message-Id: <a80eb8c10157b696b26757355f7215156e47f48c.1332752084.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <5812479c5fea3d18618e09521a804a6acd2cefdf.1332752084.git.limingx.l.an@intel.com>
References: <5812479c5fea3d18618e09521a804a6acd2cefdf.1332752084.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1332752084.git.limingx.l.an@intel.com>
References: <cover.1332752084.git.limingx.l.an@intel.com>
Subject: [PATCH 4/5] Hob: use hob icon checker to check the gtk icon for make the icon constaintly
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
X-List-Received-Date: Mon, 26 Mar 2012 10:49:30 -0000

Because we have hob icon, so need to make some gtk icon to transfer to hob icon. so use hob icon checker to fixed the gtk icon

[YOCTO #2108]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 6ae682b..d151fc4 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -28,7 +28,7 @@ import re
 import subprocess
 import shlex
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobwidget import hcc, hic, HobViewTable, HobInfoButton
+from bb.ui.crumbs.hobwidget import hcc, hic, HobViewTable, HobInfoButton, HobAltButton, HobIconChecker
 from bb.ui.crumbs.progressbar import HobProgressBar
 
 """
@@ -75,10 +75,8 @@ class CrumbsMessageDialog(CrumbsDialog):
 
         self.icon = gtk.Image()
         # We have our own Info icon which should be used in preference of the stock icon
-        if icon == gtk.STOCK_INFO or icon == "gtk-dialog-info":
-            self.icon.set_from_file(hic.ICON_INFO_DISPLAY_FILE)
-        else:
-            self.icon.set_from_stock(icon, gtk.ICON_SIZE_DIALOG)
+        self.icon_chk = HobIconChecker()
+        self.icon.set_from_stock(self.icon_chk.check_stock_icon(icon), gtk.ICON_SIZE_DIALOG)
         self.icon.set_property("yalign", 0.00)
         self.icon.show()
         first_row.add(self.icon)
-- 
1.7.5.4



