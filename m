Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SBEtt-0001JV-Hi
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 01:32:09 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 23 Mar 2012 17:23:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="121096264"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.82])
	by orsmga001.jf.intel.com with ESMTP; 23 Mar 2012 17:23:10 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Mar 2012 17:23:04 -0700
Message-Id: <1610b4255cfc036137dfe731499105569399156c.1332545580.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332545580.git.josh@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
In-Reply-To: <cover.1332545580.git.josh@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
Subject: [PATCH 6/9] lib/bb/ui/crumbs/persistenttooltip: layout tweaks
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
X-List-Received-Date: Sat, 24 Mar 2012 00:32:09 -0000

The design documents have the close button vertically aligned with the
tooltip contents - reorganise the interal widget layout to achieve this.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/persistenttooltip.py |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/bb/ui/crumbs/persistenttooltip.py b/lib/bb/ui/crumbs/persistenttooltip.py
index 8ba0043..e184062 100644
--- a/lib/bb/ui/crumbs/persistenttooltip.py
+++ b/lib/bb/ui/crumbs/persistenttooltip.py
@@ -76,9 +76,7 @@ class PersistentTooltip(gtk.Window):
         # Draw our label and close buttons
         hbox = gtk.HBox(False, 0)
         hbox.show()
-        vbox = gtk.VBox(False, 0)
-        vbox.show()
-        vbox.pack_start(hbox, True, True, 0)
+        self.add(hbox)
 
         img = gtk.Image()
         img.set_from_stock(gtk.STOCK_CLOSE, gtk.ICON_SIZE_BUTTON)
@@ -89,18 +87,21 @@ class PersistentTooltip(gtk.Window):
         self.button.set_can_default(True)
         self.button.grab_focus()
         self.button.show()
+        vbox = gtk.VBox(False, 0)
+        vbox.show()
+        vbox.pack_start(self.button, False, False, 0)
         if __button_right:
-            hbox.pack_end(self.button, False, False, 0)
+            hbox.pack_end(vbox, True, True, 0)
         else:
-            hbox.pack_start(self.button, False, False, 0)
+            hbox.pack_start(vbox, True, True, 0)
 
         self.set_default(self.button)
 
-        hbox = gtk.HBox(True, 6)
-        hbox.set_border_width(6)
-        hbox.show()
-        vbox.pack_end(hbox, True, True, 6)
+        bin = gtk.HBox(True, 6)
+        bin.set_border_width(6)
+        bin.show()
         self.label = gtk.Label()
+        self.label.set_line_wrap(True)
         # We want to match the colours of the normal tooltips, as dictated by
         # the users gtk+-2.0 theme, wherever possible - on some systems this
         # requires explicitly setting a fg_color for the label which matches the
@@ -119,12 +120,11 @@ class PersistentTooltip(gtk.Window):
                 break # we only care for the tooltip_fg_color
         self.label.set_markup(markup)
         self.label.show()
-        hbox.pack_end(self.label, True, True, 6)
+        bin.add(self.label)
+        hbox.pack_end(bin, True, True, 6)
 
         self.connect("key-press-event", self._catch_esc_cb)
 
-        self.add(vbox)
-
     """
     Callback when the PersistentTooltip's close button is clicked.
     Hides the PersistentTooltip.
-- 
1.7.7.6



