Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SCbDS-0005ig-Gp
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 20:33:58 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 27 Mar 2012 11:23:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="146411126"
Received: from hp.sh.intel.com ([10.239.47.1])
	by fmsmga002.fm.intel.com with ESMTP; 27 Mar 2012 11:23:52 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 28 Mar 2012 02:25:48 +0800
Message-Id: <0f8af992885f0ab228e6aa9c70f9b0b489d05c8f.1332871932.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cef75d16489fa6c057085c1db733f97b70340428.1332871932.git.limingx.l.an@intel.com>
References: <cef75d16489fa6c057085c1db733f97b70340428.1332871932.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1332871932.git.limingx.l.an@intel.com>
References: <cover.1332871932.git.limingx.l.an@intel.com>
Subject: [PATCH 4/6] Hob: use hob icon checker to check the gtk icon for make the icon constaintly
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
X-List-Received-Date: Tue, 27 Mar 2012 18:33:58 -0000

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



