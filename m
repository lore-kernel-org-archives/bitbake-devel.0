Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S86En-00067I-GH
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 09:40:45 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 15 Mar 2012 01:31:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="119200555"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 15 Mar 2012 01:31:57 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Mar 2012 16:29:49 +0800
Message-Id: <5d33c355001bec91f4e4c3860db8d7ac2b449782.1331796806.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1331796806.git.dongxiao.xu@intel.com>
References: <cover.1331796806.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1331796806.git.dongxiao.xu@intel.com>
References: <cover.1331796806.git.dongxiao.xu@intel.com>
Subject: [PATCH 01/12] Hob: add "Close" button to "BinbDialog"
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
X-List-Received-Date: Thu, 15 Mar 2012 08:40:45 -0000

For certain distributions, like FC16, it doesn't have close button in
sub-windows or dialogs. Therefore we need to add an "Close" button to
"BinbDialog" to close the dialog.

Besides, let BinbDialog inherits the CrumbsDialog instead of gtk.Dialog

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hig.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index e175a2a..28b7eef 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -94,13 +94,13 @@ class CrumbsMessageDialog(CrumbsDialog):
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
+        super(BinbDialog, self).__init__(title, parent, gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT, ("Close", gtk.RESPONSE_CLOSE))
 
         self.set_position(gtk.WIN_POS_MOUSE)
         self.set_resizable(False)
-- 
1.7.4.1



