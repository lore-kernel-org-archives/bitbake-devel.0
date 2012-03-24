Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SBEtr-0001JU-Uy
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 01:32:08 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 23 Mar 2012 17:23:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="121096256"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.82])
	by orsmga001.jf.intel.com with ESMTP; 23 Mar 2012 17:23:09 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Mar 2012 17:23:00 -0700
Message-Id: <45f156daf8e6423f035a1d8bb3450b149d3096f0.1332545580.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332545580.git.josh@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
In-Reply-To: <cover.1332545580.git.josh@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
Subject: [PATCH 2/9] lib/bb/ui/crumbs/hobwidget: HobAltButton different visual when insensitive
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
X-List-Received-Date: Sat, 24 Mar 2012 00:32:08 -0000

Use an alternative, grey, colour when the button is insensitive so that
the insensitivity is easily noticed.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobwidget.py |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index 020c5e2..6b8fc1b 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -221,9 +221,32 @@ class HobAltButton(gtk.Button):
     A gtk.Button subclass which has no relief, and so is more discrete
     """
     def __init__(self, label):
-        gtk.Button.__init__(self, "<span color='%s'><b>%s</b></span>" % (HobColors.PALE_BLUE, gobject.markup_escape_text(label)))
-        self.child.set_use_markup(True)
+        gtk.Button.__init__(self)
+        self.text = label
+        self.set_text()
         self.set_relief(gtk.RELIEF_NONE)
+        self.connect("state-changed", self.desensitise_on_state_change_cb)
+
+    """
+    A callback for the state-changed event to ensure the text is displayed
+    differently when the widget is not sensitive
+    """
+    def desensitise_on_state_change_cb(self, widget, state):
+        if widget.get_state() == gtk.STATE_INSENSITIVE:
+            self.set_text(False)
+        else:
+            self.set_text(True)
+
+    """
+    Set the button label with an appropriate colour for the current widget state
+    """
+    def set_text(self, sensitive=True):
+        if sensitive:
+            colour = HobColors.PALE_BLUE
+        else:
+            colour = HobColors.LIGHT_GRAY
+        self.set_label("<span color='%s'><b>%s</b></span>" % (colour, gobject.markup_escape_text(self.text)))
+        self.child.set_use_markup(True)
 
 class HobImageButton(gtk.Button):
     """
-- 
1.7.7.6



