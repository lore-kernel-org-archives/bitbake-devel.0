Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UCuBl-0003eQ-Pj
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Mar 2013 16:54:04 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 05 Mar 2013 07:34:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,787,1355126400"; d="scan'208";a="271343704"
Received: from adinu-vostro-460 (HELO localhost.localdomain) ([10.237.105.45])
	by orsmga001.jf.intel.com with ESMTP; 05 Mar 2013 07:36:23 -0800
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Mar 2013 17:36:28 +0200
Message-Id: <1362497791-30020-9-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
Subject: [PATCH 08/11] added functionality for the information dialogs.
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
X-List-Received-Date: Tue, 05 Mar 2013 15:54:07 -0000

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 0bdae3b..9a00e94 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -345,18 +345,13 @@ class HobInfoButton(gtk.EventBox):
         hic.ICON_INFO_DISPLAY_FILE)
         self.image.show()
         self.add(self.image)
+        self.tip_markup = tip_markup
+        self.my_parent = parent
 
         self.set_events(gtk.gdk.BUTTON_RELEASE |
                         gtk.gdk.ENTER_NOTIFY_MASK |
                         gtk.gdk.LEAVE_NOTIFY_MASK)
 
-        self.ptip = PersistentTooltip(tip_markup)
-
-        if parent:
-            self.ptip.set_parent(parent)
-            self.ptip.set_transient_for(parent)
-            self.ptip.set_destroy_with_parent(True)
-
         self.connect("button-release-event", self.button_release_cb)
         self.connect("enter-notify-event", self.mouse_in_cb)
         self.connect("leave-notify-event", self.mouse_out_cb)
@@ -366,7 +361,18 @@ class HobInfoButton(gtk.EventBox):
     PersistentTooltip
     """
     def button_release_cb(self, widget, event):
-        self.ptip.show()
+        from bb.ui.crumbs.hig.propertydialog import PropertyDialog
+        self.dialog = PropertyDialog(title = '',
+                    parent = self.my_parent,
+                    information = self.tip_markup,
+                    flags = gtk.DIALOG_DESTROY_WITH_PARENT
+                        | gtk.DIALOG_NO_SEPARATOR)
+
+        button = self.dialog.add_button("Close", gtk.RESPONSE_CANCEL)
+        HobAltButton.style_button(button)
+        button.connect("clicked", lambda w: self.dialog.destroy())
+        self.dialog.show_all()
+        self.dialog.run()
 
     """
     Change to the prelight image when the mouse enters the widget
-- 
1.7.9.5



