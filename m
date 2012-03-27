Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SCbDT-0005ii-PI
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 20:34:00 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 27 Mar 2012 11:23:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="146411140"
Received: from hp.sh.intel.com ([10.239.47.1])
	by fmsmga002.fm.intel.com with ESMTP; 27 Mar 2012 11:23:56 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 28 Mar 2012 02:25:50 +0800
Message-Id: <ccfbfd4131b512f11263d6b2d5a4421e598b5d70.1332871932.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cef75d16489fa6c057085c1db733f97b70340428.1332871932.git.limingx.l.an@intel.com>
References: <cef75d16489fa6c057085c1db733f97b70340428.1332871932.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1332871932.git.limingx.l.an@intel.com>
References: <cover.1332871932.git.limingx.l.an@intel.com>
Subject: [PATCH 6/6] Hob: fixed some not compatible places for make runningbuild.py can be reused by another application
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
X-List-Received-Date: Tue, 27 Mar 2012 18:34:00 -0000

The runningbuild.py has been shared by different applications, not only hob, so fixed the some not compatibled codes

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |    2 +-
 bitbake/lib/bb/ui/crumbs/hobwidget.py        |   10 +++++-----
 bitbake/lib/bb/ui/crumbs/runningbuild.py     |   20 ++++++++++++++------
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 9d967cb..6b2cef4 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -150,7 +150,7 @@ class BuildDetailsPage (HobPage):
         self.scrolled_view_failure.add(self.failure_tv)
         self.notebook.append_page(self.scrolled_view_failure, gtk.Label("Issues"))
 
-        self.build_tv = RunningBuildTreeView(readonly=True)
+        self.build_tv = RunningBuildTreeView(readonly=True, hob=True)
         self.build_tv.set_model(self.builder.handler.build.model)
         self.scrolled_view_build = gtk.ScrolledWindow ()
         self.scrolled_view_build.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 22898fb..89ff23e 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -824,6 +824,7 @@ class HobIconChecker(hic):
             ('hic-ok',          'gtk-ok',           'ok')                   : self.ICON_INDI_TICK_FILE,
             ('hic-dialog-error', 'gtk-dialog-error', 'dialog-error')        : self.ICON_INDI_ERROR_FILE,
             ('hic-dialog-warning', 'gtk-dialog-warning', 'dialog-warning')  : self.ICON_INDI_ALERT_FILE,
+            ('hic-task-refresh', 'gtk-execute', 'execute')                  : self.ICON_INDI_REFRESH_FILE,
         }
         valid_stock_id = stock_name
         if stock_name:
@@ -924,9 +925,8 @@ class HobCellRendererPixbuf(gtk.CellRendererPixbuf):
     def __init__(self):
         gtk.CellRendererPixbuf.__init__(self)
         self.control = RefreshRuningController()
-        # create default refrensh stock icon
+        # add icon checker for make the gtk-icon transfer to hob-icon
         self.checker = HobIconChecker()
-        self.checker.set_hob_icon_to_stock_icon(hic.ICON_INDI_REFRESH_FILE, "task-refresh")
 
     def get_pixbuf_from_stock_icon(self, widget, stock_id="", size=gtk.ICON_SIZE_DIALOG):
         if widget and stock_id and gtk.icon_factory_lookup_default(stock_id):
@@ -938,7 +938,7 @@ class HobCellRendererPixbuf(gtk.CellRendererPixbuf):
         if new_name and type(new_name) == str:
             # check the name is need to transfer to hob icon or not
             name = self.checker.check_stock_icon(new_name)
-            if name.startswith("hic") or name.startswith("gtk") or name == "task-refresh":
+            if name.startswith("hic") or name.startswith("gtk"):
                 stock_id = name
             else:
                 stock_id = 'gtk-' + name
@@ -946,7 +946,7 @@ class HobCellRendererPixbuf(gtk.CellRendererPixbuf):
         return stock_id
 
     ''' render cell exactly, "icon-name" is priority
-        if use the 'task-refresh' will make the pix animation
+        if use the 'hic-task-refresh' will make the pix animation
         if 'pix' will change the pixbuf for it from the pixbuf or image.
     '''
     def do_render(self, window, tree, background_area,cell_area, expose_area, flags):
@@ -971,7 +971,7 @@ class HobCellRendererPixbuf(gtk.CellRendererPixbuf):
 
         if stock_id:
             pix = self.get_pixbuf_from_stock_icon(tree, stock_id, self.props.stock_size)
-        if stock_id == 'task-refresh':
+        if stock_id == 'hic-task-refresh':
             self.control.append_running_cell_area(cell_area)
             if self.control.is_active():
                 self.control.on_draw_cb(pix, window.cairo_create(), x, y, w, h, True)
diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
index b69f0ca..629da8c 100644
--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
@@ -61,7 +61,7 @@ class RunningBuildModel (gtk.TreeStore):
         return model
 
     def foreach_cell_func(self, model, path, iter, usr_data=None):
-        if model.get_value(iter, self.COL_ICON) == "task-refresh":
+        if model.get_value(iter, self.COL_ICON) == "gtk-execute":
             model.set(iter, self.COL_ICON, "")
 
     def close_task_refresh(self):
@@ -188,7 +188,7 @@ class RunningBuild (gobject.GObject):
             # Because this parent package now has an active child mark it as
             # such.
             # @todo if parent is already in error, don't mark it green
-            self.model.set(parent, self.model.COL_ICON, "task-refresh",
+            self.model.set(parent, self.model.COL_ICON, "gtk-execute",
                            self.model.COL_COLOR, HobColors.RUNNING)
 
             # Add an entry in the model for this task
@@ -196,7 +196,7 @@ class RunningBuild (gobject.GObject):
                                             package,
                                             task,
                                             "Task: %s" % (task),
-                                            "task-refresh",
+                                            "gtk-execute",
                                             HobColors.RUNNING,
                                             0))
 
@@ -344,18 +344,26 @@ class RunningBuildTreeView (gtk.TreeView):
     __gsignals__ = {
         "button_press_event" : "override"
         }
-    def __init__ (self, readonly=False):
+    def __init__ (self, readonly=False, hob=False):
         gtk.TreeView.__init__ (self)
         self.readonly = readonly
 
         # The icon that indicates whether we're building or failed.
-        renderer = HobCellRendererPixbuf ()
+        # add 'hob' flag because there has not only hob to share this code
+        if hob:
+            renderer = HobCellRendererPixbuf ()
+        else:
+            renderer = gtk.CellRendererPixbuf()
         col = gtk.TreeViewColumn ("Status", renderer)
         col.add_attribute (renderer, "icon-name", 4)
         self.append_column (col)
 
         # The message of the build.
-        self.message_renderer = HobWarpCellRendererText (col_number=1)
+        # add 'hob' flag because there has not only hob to share this code
+        if hob:
+            self.message_renderer = HobWarpCellRendererText (col_number=1)
+        else:
+            self.message_renderer = gtk.CellRendererText ()
         self.message_column = gtk.TreeViewColumn ("Message", self.message_renderer, text=3)
         self.message_column.add_attribute(self.message_renderer, 'background', 5)
         self.message_renderer.set_property('editable', (not self.readonly))
-- 
1.7.5.4



