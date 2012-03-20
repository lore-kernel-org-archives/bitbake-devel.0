Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S9mvn-000820-Fp
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 01:28:07 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 19 Mar 2012 17:18:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="141535448"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.181])
	by fmsmga002.fm.intel.com with ESMTP; 19 Mar 2012 17:18:08 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 19 Mar 2012 17:18:04 -0700
Message-Id: <82586a6a712fb5413e3f8698f6e0794c45676144.1332202341.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332202341.git.josh@linux.intel.com>
References: <cover.1332202341.git.josh@linux.intel.com>
In-Reply-To: <cover.1332202341.git.josh@linux.intel.com>
References: <cover.1332202341.git.josh@linux.intel.com>
Subject: [PATCH 4/6] ui/crumbs/persistenttooltip: try to reflect WM close button position
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
X-List-Received-Date: Tue, 20 Mar 2012 00:28:07 -0000

When the user is running a desktop where the close button is on the left we
try to detect that and position the tooltip close button appropriately.
Where we can't easily determine this we default to placing the close button
on the right.

Tested on Ubuntu/Unity and Fedora/Gnome Shell.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/persistenttooltip.py |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/persistenttooltip.py b/lib/bb/ui/crumbs/persistenttooltip.py
index 0167363..bae697e 100644
--- a/lib/bb/ui/crumbs/persistenttooltip.py
+++ b/lib/bb/ui/crumbs/persistenttooltip.py
@@ -20,6 +20,10 @@
 
 import gobject
 import gtk
+try:
+    import gconf
+except:
+    pass
 
 class PersistentTooltip(gtk.Window):
 	"""
@@ -34,6 +38,21 @@ class PersistentTooltip(gtk.Window):
 	def __init__(self, markup):
 		gtk.Window.__init__(self, gtk.WINDOW_POPUP)
 
+		# The placement of the close button on the tip should reflect how the
+		# window manager of the users system places close buttons. Try to read
+		# the metacity gconf key to determine whether the close button is on the
+		# left or the right.
+		# In the case that we can't determine the users configuration we default
+		# to close buttons being on the right.
+		__button_right = True
+		try:
+		    client = gconf.client_get_default()
+		    order = client.get_string("/apps/metacity/general/button_layout")
+		    if order and order.endswith(":"):
+		        __button_right = False
+		except NameError:
+			pass
+
 		# We need to ensure we're only shown once
 		self.shown = False
 
@@ -65,7 +84,10 @@ class PersistentTooltip(gtk.Window):
 		self.button.set_can_default(True)
 		self.button.grab_focus()
 		self.button.show()
-		hbox.pack_end(self.button, False, False, 0)
+		if __button_right:
+		    hbox.pack_end(self.button, False, False, 0)
+		else:
+		    hbox.pack_start(self.button, False, False, 0)
 
 		self.set_default(self.button)
 
-- 
1.7.7.6



