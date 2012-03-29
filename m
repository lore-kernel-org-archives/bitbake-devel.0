Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SDEeU-00083w-Cj
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 14:40:30 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 29 Mar 2012 05:31:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="124781632"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by azsmga001.ch.intel.com with ESMTP; 29 Mar 2012 05:31:27 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 20:54:56 +0800
Message-Id: <3826144cfbddeda314bda9bec446f656265795e8.1333025491.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <ae31cc41fb985bdc59e784dbf973c522b666553a.1333025490.git.shane.wang@intel.com>
References: <ae31cc41fb985bdc59e784dbf973c522b666553a.1333025490.git.shane.wang@intel.com>
In-Reply-To: <cover.1333025490.git.shane.wang@intel.com>
References: <cover.1333025490.git.shane.wang@intel.com>
Subject: [PATCH 7/8] Hob: fixed the 'error' icon source picture and adjusted corresponding showed icon size
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
X-List-Received-Date: Thu, 29 Mar 2012 12:40:31 -0000

From: Liming An <limingx.l.an@intel.com>

The error source picture is not right, so fixed it and adjusted its size.

[YOCTO #2097]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 8b176c6..bcc44cc 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -52,7 +52,7 @@ class hic:
     ICON_INFO_DISPLAY_FILE        = os.path.join(HOB_ICON_BASE_DIR, ('info/info_display.png'))
     ICON_INFO_HOVER_FILE          = os.path.join(HOB_ICON_BASE_DIR, ('info/info_hover.png'))
     ICON_INDI_CONFIRM_FILE        = os.path.join(HOB_ICON_BASE_DIR, ('indicators/confirmation.png'))
-    ICON_INDI_ERROR_FILE          = os.path.join(HOB_ICON_BASE_DIR, ('indicators/error.png'))
+    ICON_INDI_ERROR_FILE          = os.path.join(HOB_ICON_BASE_DIR, ('indicators/denied.png'))
     ICON_INDI_REMOVE_FILE         = os.path.join(HOB_ICON_BASE_DIR, ('indicators/remove.png'))
     ICON_INDI_REMOVE_HOVER_FILE   = os.path.join(HOB_ICON_BASE_DIR, ('indicators/remove-hover.png'))
     ICON_INDI_ADD_FILE            = os.path.join(HOB_ICON_BASE_DIR, ('indicators/add.png'))
@@ -933,6 +933,7 @@ class HobCellRendererPixbuf(gtk.CellRendererPixbuf):
         self.control = RefreshRuningController()
         # add icon checker for make the gtk-icon transfer to hob-icon
         self.checker = HobIconChecker()
+        self.set_property("stock-size", gtk.ICON_SIZE_DND)
 
     def get_pixbuf_from_stock_icon(self, widget, stock_id="", size=gtk.ICON_SIZE_DIALOG):
         if widget and stock_id and gtk.icon_factory_lookup_default(stock_id):
@@ -990,7 +991,15 @@ class HobCellRendererPixbuf(gtk.CellRendererPixbuf):
     def on_get_size(self, widget, cell_area):
         if self.props.icon_name or self.props.pixbuf or self.props.stock_id:
             w, h = gtk.icon_size_lookup(self.props.stock_size)
-            return 0, 0, w, h
+            calc_width = self.get_property("xpad") * 2 + w
+            calc_height = self.get_property("ypad") * 2 + h
+            x_offset = 0
+            y_offset = 0
+            if cell_area and w > 0 and h > 0:
+                x_offset = self.get_property("xalign") * (cell_area.width - calc_width - self.get_property("xpad"))
+                y_offset = self.get_property("yalign") * (cell_area.height - calc_height - self.get_property("ypad"))
+
+            return x_offset, y_offset, w, h
 
         return 0, 0, 0, 0
 
-- 
1.7.6



