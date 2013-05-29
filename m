Return-Path: <andrei.adrianx.dinu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id AD75C6A459
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 May 2013 08:41:48 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 29 May 2013 01:39:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,763,1363158000"; d="scan'208";a="344851040"
Received: from adinu-vostro-460.rb.intel.com ([10.237.105.40])
	by orsmga002.jf.intel.com with ESMTP; 29 May 2013 01:41:34 -0700
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 May 2013 11:42:22 +0300
Message-Id: <1369816942-19830-1-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] Added distroy signal to information dialogs
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 29 May 2013 08:41:49 -0000

Added distroy signal to information dialogs
so that when pressing the close button,
the dialog would close.

[HOB #4568]

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig/propertydialog.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py b/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py
index 1e7f5c9..5bd9f95 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py
@@ -87,6 +87,7 @@ class PropertyDialog(CrumbsDialog):
                 self.table.attach(self.info_label, 0,1,1,2, xoptions=gtk.FILL|gtk.EXPAND, yoptions=gtk.FILL,xpadding=40,ypadding=10)
         
                 self.vbox.add(self.table)
+                self.connect('delete-event', lambda w, e: self.destroy() or True) 
 
         def treeViewTooltip( self, widget, e, tooltips, cell, emptyText="" ):
                  try:
-- 
1.7.9.5


