Return-Path: <cristiana.voicu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 9267F6E716
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Mar 2014 13:37:00 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 19 Mar 2014 06:32:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,686,1389772800"; d="scan'208";a="503047184"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.62])
	by orsmga002.jf.intel.com with ESMTP; 19 Mar 2014 06:36:44 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Mar 2014 15:37:08 +0200
Message-Id: <1395236228-4362-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [dylan][PATCH] hob: disable layer drag and drop outside the containing widget
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 19 Mar 2014 13:37:01 -0000

[YOCTO #6008]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 .../lib/bb/ui/crumbs/hig/layerselectiondialog.py   |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/layerselectiondialog.py b/bitbake/lib/bb/ui/crumbs/hig/layerselectiondialog.py
index 783ee73..f6a4d72 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/layerselectiondialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/layerselectiondialog.py
@@ -132,12 +132,13 @@ class LayerSelectionDialog (CrumbsDialog):
         tree_selection.set_mode(gtk.SELECTION_SINGLE)
 
         # Allow enable drag and drop of rows including row move
+        dnd_internal_target = ''
+        dnd_targets = [(dnd_internal_target, gtk.TARGET_SAME_WIDGET, 0)]
         layer_tv.enable_model_drag_source( gtk.gdk.BUTTON1_MASK,
-            self.TARGETS,
-            gtk.gdk.ACTION_DEFAULT|
+            dnd_targets,
+            gtk.gdk.ACTION_MOVE)
+        layer_tv.enable_model_drag_dest(dnd_targets,
             gtk.gdk.ACTION_MOVE)
-        layer_tv.enable_model_drag_dest(self.TARGETS,
-            gtk.gdk.ACTION_DEFAULT)
         layer_tv.connect("drag_data_get", self.drag_data_get_cb)
         layer_tv.connect("drag_data_received", self.drag_data_received_cb)
 
-- 
1.7.9.5


