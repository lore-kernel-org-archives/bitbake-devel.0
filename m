Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SJhM7-0006C0-Ml
	for bitbake-devel@lists.openembedded.org;
	Mon, 16 Apr 2012 10:32:15 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 16 Apr 2012 01:22:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="130041059"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 16 Apr 2012 01:22:49 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Apr 2012 16:53:28 +0800
Message-Id: <9c0d9fb3aa4a2d2b7c1d69d87a3fd6d8538574a8.1334565351.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <395e04713e9714aeedb15553de9334a48403a495.1334565351.git.shane.wang@intel.com>
References: <395e04713e9714aeedb15553de9334a48403a495.1334565351.git.shane.wang@intel.com>
In-Reply-To: <cover.1334565351.git.shane.wang@intel.com>
References: <cover.1334565351.git.shane.wang@intel.com>
Subject: [PATCH 2/2] Hob: add the parent window to 'binb' popup window for managing it
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
X-List-Received-Date: Mon, 16 Apr 2012 08:32:16 -0000

From: Liming An <limingx.l.an@intel.com>

The 'binb' popup window should be "set transient for" the main application
window which they were spawned from.

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py           |    2 +-
 bitbake/lib/bb/ui/crumbs/persistenttooltip.py |    6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index bd45016..0f85cf5 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -898,7 +898,7 @@ class Builder(gtk.Window):
 
     def show_binb_dialog(self, binb):
         markup = "<b>Brought in by:</b>\n%s" % binb
-        ptip = PersistentTooltip(markup)
+        ptip = PersistentTooltip(markup, self)
 
         ptip.show()
 
diff --git a/bitbake/lib/bb/ui/crumbs/persistenttooltip.py b/bitbake/lib/bb/ui/crumbs/persistenttooltip.py
index 4db3018..b43d297 100644
--- a/bitbake/lib/bb/ui/crumbs/persistenttooltip.py
+++ b/bitbake/lib/bb/ui/crumbs/persistenttooltip.py
@@ -35,7 +35,7 @@ class PersistentTooltip(gtk.Window):
 
     markup: some Pango text markup to display in the tooltip
     """
-    def __init__(self, markup):
+    def __init__(self, markup, parent_win=None):
         gtk.Window.__init__(self, gtk.WINDOW_POPUP)
 
         # Inherit the system theme for a tooltip
@@ -76,6 +76,10 @@ class PersistentTooltip(gtk.Window):
         # Ensure a reasonable minimum size
         self.set_geometry_hints(self, 100, 50)
 
+        # Set this window as a transient window for parent(main window)
+        if parent_win:
+            self.set_transient_for(parent_win)
+            self.set_destroy_with_parent(True)
         # Draw our label and close buttons
         hbox = gtk.HBox(False, 0)
         hbox.show()
-- 
1.7.6



