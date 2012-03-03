Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S3d8k-00064W-BF
	for bitbake-devel@lists.openembedded.org;
	Sat, 03 Mar 2012 01:48:02 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 02 Mar 2012 16:39:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="113997899"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.107])
	by orsmga001.jf.intel.com with ESMTP; 02 Mar 2012 16:39:27 -0800
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Mar 2012 16:39:22 -0800
Message-Id: <0aa653ca441811e220bbf70de4eb32781e41c9c5.1330734444.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1330734444.git.josh@linux.intel.com>
References: <cover.1330734444.git.josh@linux.intel.com>
In-Reply-To: <cover.1330734444.git.josh@linux.intel.com>
References: <cover.1330734444.git.josh@linux.intel.com>
Subject: [PATCH 6/6] ui/crumbs/hig: special case stock info icons in CrumbsMesssageDialog
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
X-List-Received-Date: Sat, 03 Mar 2012 00:48:02 -0000

The Hob visual design includes an info icon which should be used
consistently throught the GUI. This change detects use of the stock info
icon in CrumbsMessageDialog and uses the Hob info icon instead.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hig.py |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index b109c0a..e175a2a 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -74,7 +74,11 @@ class CrumbsMessageDialog(CrumbsDialog):
         self.vbox.add(first_row)
 
         self.icon = gtk.Image()
-        self.icon.set_from_stock(icon, gtk.ICON_SIZE_DIALOG)
+        # We have our own Info icon which should be used in preference of the stock icon
+        if icon == gtk.STOCK_INFO or icon == "gtk-dialog-info":
+            self.icon.set_from_file(hic.ICON_INFO_DISPLAY_FILE)
+        else:
+            self.icon.set_from_stock(icon, gtk.ICON_SIZE_DIALOG)
         self.icon.set_property("yalign", 0.00)
         self.icon.show()
         first_row.add(self.icon)
-- 
1.7.7.6



