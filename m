Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SBEtu-0001JV-8L
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 01:32:10 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 23 Mar 2012 17:23:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="121096268"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.82])
	by orsmga001.jf.intel.com with ESMTP; 23 Mar 2012 17:23:10 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Mar 2012 17:23:06 -0700
Message-Id: <4ff611f179da4d3c8953222c053d9cce62505277.1332545580.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332545580.git.josh@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
In-Reply-To: <cover.1332545580.git.josh@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
Subject: [PATCH 8/9] lib/bb/ui/crumbs: use a PersistentTooltip for the Brought in by information
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
X-List-Received-Date: Sat, 24 Mar 2012 00:32:10 -0000

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/builder.py |   12 +++++++-----
 lib/bb/ui/crumbs/hig.py     |   23 -----------------------
 2 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 2fe67d9..4eb374c 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -33,9 +33,10 @@ from bb.ui.crumbs.packageselectionpage import PackageSelectionPage
 from bb.ui.crumbs.builddetailspage import BuildDetailsPage
 from bb.ui.crumbs.imagedetailspage import ImageDetailsPage
 from bb.ui.crumbs.hobwidget import hwc
-from bb.ui.crumbs.hig import CrumbsMessageDialog, BinbDialog, \
+from bb.ui.crumbs.hig import CrumbsMessageDialog, ImageSelectionDialog, \
                              AdvancedSettingDialog, LayerSelectionDialog, \
-                             DeployImageDialog, ImageSelectionDialog
+                             DeployImageDialog
+from bb.ui.crumbs.persistenttooltip import PersistentTooltip
 
 class Configuration:
     '''Represents the data structure of configuration.'''
@@ -659,9 +660,10 @@ class Builder(gtk.Window):
         self.switch_page(self.FAST_IMAGE_GENERATING)
 
     def show_binb_dialog(self, binb):
-        binb_dialog = BinbDialog("Brought in by:", binb, self)
-        binb_dialog.run()
-        binb_dialog.destroy()
+        markup = "<b>Brought in by:</b>\n%s" % binb
+        ptip = PersistentTooltip(markup)
+
+        ptip.show()
 
     def show_layer_selection_dialog(self):
         dialog = LayerSelectionDialog(title = "Layers",
diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 3a66e7c..6ae682b 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -92,29 +92,6 @@ class CrumbsMessageDialog(CrumbsDialog):
         first_row.add(self.label)
 
 #
-# Brought-in-by Dialog
-#
-class BinbDialog(CrumbsDialog):
-    """
-    A dialog widget to show "brought in by" info when a recipe/package is clicked.
-    """
-
-    def __init__(self, title, content, parent=None):
-        super(BinbDialog, self).__init__(title, parent, gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT, ("Close", gtk.RESPONSE_CLOSE))
-
-        self.set_position(gtk.WIN_POS_MOUSE)
-        self.set_resizable(False)
-        self.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(HobColors.DARK))
-
-        label = gtk.Label(content)
-        label.set_alignment(0, 0)
-        label.set_line_wrap(True)
-        label.modify_fg(gtk.STATE_NORMAL, gtk.gdk.Color(HobColors.WHITE))
-
-        self.vbox.pack_start(label, expand=True, fill=True, padding=10)
-        self.vbox.show_all()
-
-#
 # AdvancedSettings Dialog
 #
 class AdvancedSettingDialog (CrumbsDialog):
-- 
1.7.7.6



