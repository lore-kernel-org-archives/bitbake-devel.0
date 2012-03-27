Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SCbDF-0005h7-PI
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 20:33:46 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 27 Mar 2012 11:23:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="146411055"
Received: from hp.sh.intel.com ([10.239.47.1])
	by fmsmga002.fm.intel.com with ESMTP; 27 Mar 2012 11:23:38 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 28 Mar 2012 02:25:45 +0800
Message-Id: <cef75d16489fa6c057085c1db733f97b70340428.1332871932.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1332871932.git.limingx.l.an@intel.com>
References: <cover.1332871932.git.limingx.l.an@intel.com>
Subject: [PATCH 1/6] Hob: add refresh icon as ui request in building log
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
X-List-Received-Date: Tue, 27 Mar 2012 18:33:46 -0000

add a refresh icon to indicator the running task, for avoid add more heavy to bitbake building process, increased the timer interval counter, and decreased the refresh icon render size.

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py    |  169 ++++++++++++++++++++++++++++++
 bitbake/lib/bb/ui/crumbs/runningbuild.py |   20 +++-
 2 files changed, 185 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 8936f0a..e224762 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -57,6 +57,7 @@ class hic:
     ICON_INDI_REMOVE_HOVER_FILE   = os.path.join(HOB_ICON_BASE_DIR, ('indicators/remove-hover.png'))
     ICON_INDI_ADD_FILE            = os.path.join(HOB_ICON_BASE_DIR, ('indicators/add.png'))
     ICON_INDI_ADD_HOVER_FILE      = os.path.join(HOB_ICON_BASE_DIR, ('indicators/add-hover.png'))
+    ICON_INDI_REFRESH_FILE        = os.path.join(HOB_ICON_BASE_DIR, ('indicators/refresh.png'))
 
 class hcc:
 
@@ -793,3 +794,171 @@ class HobWarpCellRendererText(gtk.CellRendererText):
         return adjwidth
 
 gobject.type_register(HobWarpCellRendererText)
+
+class RefreshRuningController(gobject.GObject):
+    def __init__(self, widget=None, iter=None):
+        gobject.GObject.__init__(self)
+        self.timeout_id = None
+        self.current_angle_pos = 0.0
+        self.step_angle = 0.0
+        self.tree_headers_height = 0
+        self.running_cell_areas = []
+
+    def is_active(self):
+        if self.timeout_id:
+            return True
+        else:
+            return False
+
+    def reset(self):
+        self.force_stop(True)
+        self.current_angle_pos = 0.0
+        self.timeout_id = None
+        self.step_angle = 0.0
+
+    ''' time_iterval: (1~1000)ms, which will be as the basic interval count for timer
+        init_usrdata: the current data which related the progress-bar will be at
+        min_usrdata: the range of min of user data
+        max_usrdata: the range of max of user data
+        step: each step which you want to progress
+        Note: the init_usrdata should in the range of from min to max, and max should > min
+             step should < (max - min)
+    '''
+    def start_run(self, time_iterval, init_usrdata, min_usrdata, max_usrdata, step, tree):
+        if (not time_iterval) or (not max_usrdata):
+            return
+        usr_range = (max_usrdata - min_usrdata) * 1.0
+        self.current_angle_pos = (init_usrdata * 1.0) / usr_range
+        self.step_angle = (step * 1) / usr_range
+        self.timeout_id = gobject.timeout_add(int(time_iterval),
+        self.make_image_on_progressing_cb, tree)
+        self.tree_headers_height = self.get_treeview_headers_height(tree)
+
+    def force_stop(self, after_hide_or_not=False):
+        if self.timeout_id:
+            gobject.source_remove(self.timeout_id)
+            self.timeout_id = None
+        if self.running_cell_areas:
+            self.running_cell_areas = []
+
+    def on_draw_cb(self, pixbuf, cr, x, y, img_width, img_height, do_refresh=True):
+        if pixbuf:
+            r = max(img_width/2, img_height/2)
+            cr.translate(x + r, y + r)
+            if do_refresh:
+                cr.rotate(2 * math.pi * self.current_angle_pos)
+
+            cr.set_source_pixbuf(pixbuf, -img_width/2, -img_height/2)
+            cr.paint()
+
+    def get_treeview_headers_height(self, tree):
+        if tree and (tree.get_property("headers-visible") == True):
+            height = tree.get_allocation().height - tree.get_bin_window().get_size()[1]
+            return height
+
+        return 0
+
+    def make_image_on_progressing_cb(self, tree):
+        self.current_angle_pos += self.step_angle
+        if (self.current_angle_pos >= 1):
+            self.current_angle_pos = self.step_angle
+
+        for rect in self.running_cell_areas:
+            tree.queue_draw_area(rect.x, rect.y + self.tree_headers_height, rect.width, rect.height)
+
+        return True
+
+    def append_running_cell_area(self, cell_area):
+        if cell_area and (cell_area not in self.running_cell_areas):
+            self.running_cell_areas.append(cell_area)
+
+    def remove_running_cell_area(self, cell_area):
+        if cell_area in self.running_cell_areas:
+            self.running_cell_areas.remove(cell_area)
+        if not self.running_cell_areas:
+            self.reset()
+
+gobject.type_register(RefreshRuningController)
+
+class HobCellRendererPixbuf(gtk.CellRendererPixbuf):
+    def __init__(self):
+        gtk.CellRendererPixbuf.__init__(self)
+        self.control = RefreshRuningController()
+        # create default refrensh stock icon
+        self.set_hob_icon_to_stock_icon(hic.ICON_INDI_REFRESH_FILE, "task-refresh")
+
+    def set_hob_icon_to_stock_icon(self, file_path, stock_id=""):
+        try:
+            pixbuf = gtk.gdk.pixbuf_new_from_file(file_path)
+        except Exception, e:
+            return None
+
+        if pixbuf and stock_id and (gtk.icon_factory_lookup_default(stock_id) == None):
+            icon_factory = gtk.IconFactory()
+            icon_factory.add_default()
+            icon_factory.add(stock_id, gtk.IconSet(pixbuf))
+            gtk.stock_add([(stock_id, '_label', 0, 0, '')])
+
+            return icon_factory.lookup(stock_id)
+
+        return None
+
+    def get_pixbuf_from_stock_icon(self, widget, stock_id="", size=gtk.ICON_SIZE_DIALOG):
+        if widget and stock_id and gtk.icon_factory_lookup_default(stock_id):
+            return widget.render_icon(stock_id, size)
+
+        return None
+
+    def set_icon_name_to_id(self, name):
+        if name and type(name) == str:
+            if name.startswith("gtk") or name == "task-refresh":
+                stock_id = name
+            else:
+                stock_id = 'gtk-' + name
+
+        return stock_id
+
+    ''' render cell exactly, "icon-name" is priority
+        if use the 'task-refresh' will make the pix animation
+        if 'pix' will change the pixbuf for it from the pixbuf or image.
+    '''
+    def do_render(self, window, tree, background_area,cell_area, expose_area, flags):
+        if (not self.control) or (not tree):
+            return
+
+        x, y, w, h = self.on_get_size(tree, cell_area)
+        x += cell_area.x
+        y += cell_area.y
+        w -= 2 * self.get_property("xpad")
+        h -= 2 * self.get_property("ypad")
+
+        stock_id = ""
+        if self.props.icon_name:
+            stock_id = self.set_icon_name_to_id(self.props.icon_name)
+        elif self.props.stock_id:
+            stock_id = self.props.stock_id
+        elif self.props.pixbuf:
+            pix = self.props.pixbuf
+        else:
+            return
+
+        if stock_id:
+            pix = self.get_pixbuf_from_stock_icon(tree, stock_id, self.props.stock_size)
+        if stock_id == 'task-refresh':
+            self.control.append_running_cell_area(cell_area)
+            if self.control.is_active():
+                self.control.on_draw_cb(pix, window.cairo_create(), x, y, w, h, True)
+            else:
+                self.control.start_run(200, 0, 0, 1000, 200, tree)
+        else:
+            self.control.remove_running_cell_area(cell_area)
+            self.control.on_draw_cb(pix, window.cairo_create(), x, y, w, h, False)
+
+    def on_get_size(self, widget, cell_area):
+        if self.props.icon_name or self.props.pixbuf or self.props.stock_id:
+            w, h = gtk.icon_size_lookup(self.props.stock_size)
+            return 0, 0, w, h
+
+        return 0, 0, 0, 0
+
+gobject.type_register(HobCellRendererPixbuf)
diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
index 0f58e4e..aecfadf 100644
--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
@@ -27,7 +27,7 @@ import urllib
 import urllib2
 import pango
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobwidget import HobWarpCellRendererText
+from bb.ui.crumbs.hobwidget import HobWarpCellRendererText, HobCellRendererPixbuf
 
 class RunningBuildModel (gtk.TreeStore):
     (COL_LOG, COL_PACKAGE, COL_TASK, COL_MESSAGE, COL_ICON, COL_COLOR, COL_NUM_ACTIVE) = range(7)
@@ -68,6 +68,14 @@ class RunningBuildModel (gtk.TreeStore):
         model.set_visible_func(self.failure_model_filter)
         return model
 
+    def foreach_cell_func(self, model, path, iter, usr_data=None):
+        if model.get_value(iter, self.COL_ICON) == "task-refresh":
+            model.set(iter, self.COL_ICON, "")
+
+    def close_task_refresh(self):
+        self.foreach(self.foreach_cell_func, None)
+
+
 class RunningBuild (gobject.GObject):
     __gsignals__ = {
           'build-started'   :  (gobject.SIGNAL_RUN_LAST,
@@ -189,7 +197,7 @@ class RunningBuild (gobject.GObject):
             # Because this parent package now has an active child mark it as
             # such.
             # @todo if parent is already in error, don't mark it green
-            self.model.set(parent, self.model.COL_ICON, "gtk-execute",
+            self.model.set(parent, self.model.COL_ICON, "task-refresh",
                            self.model.COL_COLOR, HobColors.RUNNING)
 
             # Add an entry in the model for this task
@@ -197,7 +205,7 @@ class RunningBuild (gobject.GObject):
                                             package,
                                             task,
                                             "Task: %s" % (task),
-                                            "gtk-execute",
+                                            "task-refresh",
                                             HobColors.RUNNING,
                                             0))
 
@@ -284,6 +292,8 @@ class RunningBuild (gobject.GObject):
             # Emit a generic "build-complete" signal for things wishing to
             # handle when the build is finished
             self.emit("build-complete")
+            # reset the all cell's icon indicator
+            self.model.close_task_refresh()
             if pbar:
                 pbar.set_text(event.msg)
 
@@ -292,6 +302,8 @@ class RunningBuild (gobject.GObject):
                 # If the command fails with an exit code we're done, emit the
                 # generic signal for the UI to notify the user
                 self.emit("build-complete")
+                # reset the all cell's icon indicator
+                self.model.close_task_refresh()
 
         elif isinstance(event, bb.event.CacheLoadStarted) and pbar:
             pbar.set_title("Loading cache")
@@ -346,7 +358,7 @@ class RunningBuildTreeView (gtk.TreeView):
         self.readonly = readonly
 
         # The icon that indicates whether we're building or failed.
-        renderer = gtk.CellRendererPixbuf ()
+        renderer = HobCellRendererPixbuf ()
         col = gtk.TreeViewColumn ("Status", renderer)
         col.add_attribute (renderer, "icon-name", 4)
         self.append_column (col)
-- 
1.7.5.4



