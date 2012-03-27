Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SCbDG-0005h7-Ss
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 20:33:47 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 27 Mar 2012 11:23:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="146411063"
Received: from hp.sh.intel.com ([10.239.47.1])
	by fmsmga002.fm.intel.com with ESMTP; 27 Mar 2012 11:23:39 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 28 Mar 2012 02:25:46 +0800
Message-Id: <097875453688547873713aa87c264bfe81c2d491.1332871932.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cef75d16489fa6c057085c1db733f97b70340428.1332871932.git.limingx.l.an@intel.com>
References: <cef75d16489fa6c057085c1db733f97b70340428.1332871932.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1332871932.git.limingx.l.an@intel.com>
References: <cover.1332871932.git.limingx.l.an@intel.com>
Subject: [PATCH 2/6] Hob: fixed visually differentiate warnings and errors icon in building log
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
X-List-Received-Date: Tue, 27 Mar 2012 18:33:47 -0000

fixed the bug of 'error' and 'warning' icon is not constaintly with hob ui design

[YOCTO #2097]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py |   67 +++++++++++++++++++++++----------
 1 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index e224762..22898fb 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -58,6 +58,8 @@ class hic:
     ICON_INDI_ADD_FILE            = os.path.join(HOB_ICON_BASE_DIR, ('indicators/add.png'))
     ICON_INDI_ADD_HOVER_FILE      = os.path.join(HOB_ICON_BASE_DIR, ('indicators/add-hover.png'))
     ICON_INDI_REFRESH_FILE        = os.path.join(HOB_ICON_BASE_DIR, ('indicators/refresh.png'))
+    ICON_INDI_ALERT_FILE          = os.path.join(HOB_ICON_BASE_DIR, ('indicators/alert.png'))
+    ICON_INDI_TICK_FILE           = os.path.join(HOB_ICON_BASE_DIR, ('indicators/tick.png'))
 
 class hcc:
 
@@ -795,6 +797,44 @@ class HobWarpCellRendererText(gtk.CellRendererText):
 
 gobject.type_register(HobWarpCellRendererText)
 
+class HobIconChecker(hic):
+    def set_hob_icon_to_stock_icon(self, file_path, stock_id=""):
+        try:
+            pixbuf = gtk.gdk.pixbuf_new_from_file(file_path)
+        except Exception, e:
+            return None
+
+        if stock_id and (gtk.icon_factory_lookup_default(stock_id) == None):
+            icon_factory = gtk.IconFactory()
+            icon_factory.add_default()
+            icon_factory.add(stock_id, gtk.IconSet(pixbuf))
+            gtk.stock_add([(stock_id, '_label', 0, 0, '')])
+
+            return icon_factory.lookup(stock_id)
+
+        return None
+
+    """
+    For make hob icon consistently by request, and avoid icon view diff by system or gtk version, we use some 'hob icon' to replace the 'gtk icon'.
+    this function check the stock_id and make hob_id to replaced the gtk_id then return it or ""
+    """
+    def check_stock_icon(self, stock_name=""):
+        HOB_CHECK_STOCK_NAME = {
+            ('hic-dialog-info', 'gtk-dialog-info', 'dialog-info')           : self.ICON_INFO_DISPLAY_FILE,
+            ('hic-ok',          'gtk-ok',           'ok')                   : self.ICON_INDI_TICK_FILE,
+            ('hic-dialog-error', 'gtk-dialog-error', 'dialog-error')        : self.ICON_INDI_ERROR_FILE,
+            ('hic-dialog-warning', 'gtk-dialog-warning', 'dialog-warning')  : self.ICON_INDI_ALERT_FILE,
+        }
+        valid_stock_id = stock_name
+        if stock_name:
+            for names, path in HOB_CHECK_STOCK_NAME.iteritems():
+                if stock_name in names:
+                    valid_stock_id = names[0]
+                    if not gtk.icon_factory_lookup_default(valid_stock_id):
+                        self.set_hob_icon_to_stock_icon(path, valid_stock_id)
+
+        return valid_stock_id
+
 class RefreshRuningController(gobject.GObject):
     def __init__(self, widget=None, iter=None):
         gobject.GObject.__init__(self)
@@ -885,23 +925,8 @@ class HobCellRendererPixbuf(gtk.CellRendererPixbuf):
         gtk.CellRendererPixbuf.__init__(self)
         self.control = RefreshRuningController()
         # create default refrensh stock icon
-        self.set_hob_icon_to_stock_icon(hic.ICON_INDI_REFRESH_FILE, "task-refresh")
-
-    def set_hob_icon_to_stock_icon(self, file_path, stock_id=""):
-        try:
-            pixbuf = gtk.gdk.pixbuf_new_from_file(file_path)
-        except Exception, e:
-            return None
-
-        if pixbuf and stock_id and (gtk.icon_factory_lookup_default(stock_id) == None):
-            icon_factory = gtk.IconFactory()
-            icon_factory.add_default()
-            icon_factory.add(stock_id, gtk.IconSet(pixbuf))
-            gtk.stock_add([(stock_id, '_label', 0, 0, '')])
-
-            return icon_factory.lookup(stock_id)
-
-        return None
+        self.checker = HobIconChecker()
+        self.checker.set_hob_icon_to_stock_icon(hic.ICON_INDI_REFRESH_FILE, "task-refresh")
 
     def get_pixbuf_from_stock_icon(self, widget, stock_id="", size=gtk.ICON_SIZE_DIALOG):
         if widget and stock_id and gtk.icon_factory_lookup_default(stock_id):
@@ -909,9 +934,11 @@ class HobCellRendererPixbuf(gtk.CellRendererPixbuf):
 
         return None
 
-    def set_icon_name_to_id(self, name):
-        if name and type(name) == str:
-            if name.startswith("gtk") or name == "task-refresh":
+    def set_icon_name_to_id(self, new_name):
+        if new_name and type(new_name) == str:
+            # check the name is need to transfer to hob icon or not
+            name = self.checker.check_stock_icon(new_name)
+            if name.startswith("hic") or name.startswith("gtk") or name == "task-refresh":
                 stock_id = name
             else:
                 stock_id = 'gtk-' + name
-- 
1.7.5.4



