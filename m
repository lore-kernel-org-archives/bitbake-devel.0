Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S2kQo-0005q7-Ot
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 15:23:02 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 29 Feb 2012 06:14:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="130973485"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 29 Feb 2012 06:14:33 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Feb 2012 22:15:24 +0800
Message-Id: <79c20962f88a34c41344c8480aea6368f62c3241.1330523904.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
In-Reply-To: <cover.1330523904.git.shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
Subject: [PATCH 27/32] Hob: add "OK" button to "BinbDialog"
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
X-List-Received-Date: Wed, 29 Feb 2012 14:23:03 -0000

From: Dongxiao Xu <dongxiao.xu@intel.com>

For certain distributions, like FC16, it doesn't have close button in
sub-windows or dialogs. Therefore we need to add an "OK" button to
"BinbDialog" to close the dialog.

Besides, let BinbDialog inherits the CrumbsDialog instead of gtk.Dialog

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index c5bd27a..20585b7 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -90,13 +90,13 @@ class CrumbsMessageDialog(CrumbsDialog):
 #
 # Brought-in-by Dialog
 #
-class BinbDialog(gtk.Dialog):
+class BinbDialog(CrumbsDialog):
     """
     A dialog widget to show "brought in by" info when a recipe/package is clicked.
     """
 
     def __init__(self, title, content, parent=None):
-        super(BinbDialog, self).__init__(title, parent, gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT, None)
+        super(BinbDialog, self).__init__(title, parent, gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT, ("OK", gtk.RESPONSE_OK))
 
         self.set_position(gtk.WIN_POS_MOUSE)
         self.set_resizable(False)
-- 
1.7.6



