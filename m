Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S3d8j-00064Q-7B
	for bitbake-devel@lists.openembedded.org;
	Sat, 03 Mar 2012 01:48:01 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 02 Mar 2012 16:39:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="113997895"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.107])
	by orsmga001.jf.intel.com with ESMTP; 02 Mar 2012 16:39:26 -0800
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Mar 2012 16:39:19 -0800
Message-Id: <78a24cabc5d886fe39cddbc3dcab58e0fd8d9614.1330734444.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1330734444.git.josh@linux.intel.com>
References: <cover.1330734444.git.josh@linux.intel.com>
In-Reply-To: <cover.1330734444.git.josh@linux.intel.com>
References: <cover.1330734444.git.josh@linux.intel.com>
Subject: [PATCH 3/6] ui/crumbs/hobwidget: implement HobInfoButton per Hob interaction design
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
X-List-Received-Date: Sat, 03 Mar 2012 00:48:01 -0000

This button-like widget will display a persistent tooltip with the
supplied Pango Markup when it is clicked by the user. This widget features
prominently in the interaction design to offer help in a more prominent
manner.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobwidget.py |   49 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index 9afbfdb..f4ff1dc 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -23,6 +23,7 @@ import gobject
 import os
 import os.path
 from bb.ui.crumbs.hobcolor import HobColors
+from bb.ui.crumbs.persistenttooltip import PersistentTooltip
 
 class hwc:
 
@@ -311,3 +312,51 @@ class HobXpmLabelButtonBox(gtk.EventBox):
         """ Hide items - first time """
         pass
 
+class HobInfoButton(gtk.EventBox):
+    """
+    This class implements a button-like widget per the Hob visual and UX designs
+    which will display a persistent tooltip, with the contents of tip_markup, when
+    clicked.
+
+    tip_markup: the Pango Markup to be displayed in the persistent tooltip
+    """
+    def __init__(self, tip_markup, parent=None):
+        gtk.EventBox.__init__(self)
+        self.image = gtk.Image()
+        self.image.set_from_file(hic.ICON_INFO_DISPLAY_FILE)
+        self.image.show()
+        self.add(self.image)
+
+        self.set_events(gtk.gdk.BUTTON_RELEASE |
+                        gtk.gdk.ENTER_NOTIFY_MASK |
+                        gtk.gdk.LEAVE_NOTIFY_MASK)
+
+        self.ptip = PersistentTooltip(tip_markup)
+
+        if parent:
+            self.ptip.set_parent(parent)
+            self.ptip.set_transient_for(parent)
+            self.ptip.set_destroy_with_parent(True)
+
+        self.connect("button-release-event", self.button_release_cb)
+        self.connect("enter-notify-event", self.mouse_in_cb)
+        self.connect("leave-notify-event", self.mouse_out_cb)
+
+    """
+    When the mouse click is released emulate a button-click and show the associated
+    PersistentTooltip
+    """
+    def button_release_cb(self, widget, event):
+        self.ptip.show()
+
+    """
+    Change to the prelight image when the mouse enters the widget
+    """
+    def mouse_in_cb(self, widget, event):
+        self.image.set_from_file(hic.ICON_INFO_HOVER_FILE)
+
+    """
+    Change to the stock image when the mouse enters the widget
+    """
+    def mouse_out_cb(self, widget, event):
+        self.image.set_from_file(hic.ICON_INFO_DISPLAY_FILE)
-- 
1.7.7.6



