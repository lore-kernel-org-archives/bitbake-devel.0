Return-Path: <jussi.kukkonen@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 7F83773179
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jun 2016 12:20:29 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP; 20 Jun 2016 05:20:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,498,1459839600"; d="scan'208";a="1005849451"
Received: from theory.fi.intel.com ([10.237.72.196])
	by fmsmga002.fm.intel.com with ESMTP; 20 Jun 2016 05:20:06 -0700
From: Jussi Kukkonen <jussi.kukkonen@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 Jun 2016 15:20:03 +0300
Message-Id: <83681e51c2acb38fcb3ea363dfc0553fc5dd3f21.1466424068.git.jussi.kukkonen@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1466424068.git.jussi.kukkonen@intel.com>
References: <cover.1466424068.git.jussi.kukkonen@intel.com>
Subject: [PATCH 1/1] depexp.py: port to gtk+3
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 20 Jun 2016 12:20:29 -0000

The code is still a bit icky (and should be refactored to not use
Gdk.threads_enter/leave) but it should work about as reliably as
it did with Gtk+2.

Based on earlier patches by Maxin and Joshua.

Signed-off-by: Jussi Kukkonen <jussi.kukkonen@intel.com>
---
 bitbake/lib/bb/ui/depexp.py | 159 ++++++++++++++++++++++----------------------
 1 file changed, 80 insertions(+), 79 deletions(-)

diff --git a/bitbake/lib/bb/ui/depexp.py b/bitbake/lib/bb/ui/depexp.py
index 240aafc..995703d 100644
--- a/bitbake/lib/bb/ui/depexp.py
+++ b/bitbake/lib/bb/ui/depexp.py
@@ -18,14 +18,15 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import sys
-import gobject
-import gtk
-import Queue
+import gi
+gi.require_version('Gtk', '3.0')
+from gi.repository import Gtk, Gdk, GObject
+from multiprocessing import Queue
 import threading
-import xmlrpclib
+from xmlrpc import client
+import time
 import bb
 import bb.event
-from bb.ui.crumbs.progressbar import HobProgressBar
 
 # Package Model
 (COL_PKG_NAME) = (0)
@@ -35,19 +36,19 @@ from bb.ui.crumbs.progressbar import HobProgressBar
 (COL_DEP_TYPE, COL_DEP_PARENT, COL_DEP_PACKAGE) = (0, 1, 2)
 
 
-class PackageDepView(gtk.TreeView):
+class PackageDepView(Gtk.TreeView):
     def __init__(self, model, dep_type, label):
-        gtk.TreeView.__init__(self)
+        Gtk.TreeView.__init__(self)
         self.current = None
         self.dep_type = dep_type
         self.filter_model = model.filter_new()
-        self.filter_model.set_visible_func(self._filter)
+        self.filter_model.set_visible_func(self._filter, data=None)
         self.set_model(self.filter_model)
-        #self.connect("row-activated", self.on_package_activated, COL_DEP_PACKAGE)
-        self.append_column(gtk.TreeViewColumn(label, gtk.CellRendererText(), text=COL_DEP_PACKAGE))
+        self.append_column(Gtk.TreeViewColumn(label, Gtk.CellRendererText(), text=COL_DEP_PACKAGE))
 
-    def _filter(self, model, iter):
-        (this_type, package) = model.get(iter, COL_DEP_TYPE, COL_DEP_PARENT)
+    def _filter(self, model, iter, data):
+        this_type = model[iter][COL_DEP_TYPE]
+        package = model[iter][COL_DEP_PARENT]
         if this_type != self.dep_type: return False
         return package == self.current
 
@@ -56,17 +57,17 @@ class PackageDepView(gtk.TreeView):
         self.filter_model.refilter()
 
 
-class PackageReverseDepView(gtk.TreeView):
+class PackageReverseDepView(Gtk.TreeView):
     def __init__(self, model, label):
-        gtk.TreeView.__init__(self)
+        Gtk.TreeView.__init__(self)
         self.current = None
         self.filter_model = model.filter_new()
         self.filter_model.set_visible_func(self._filter)
         self.set_model(self.filter_model)
-        self.append_column(gtk.TreeViewColumn(label, gtk.CellRendererText(), text=COL_DEP_PARENT))
+        self.append_column(Gtk.TreeViewColumn(label, Gtk.CellRendererText(), text=COL_DEP_PARENT))
 
-    def _filter(self, model, iter):
-        package = model.get_value(iter, COL_DEP_PACKAGE)
+    def _filter(self, model, iter, data):
+        package = model[iter][COL_DEP_PACKAGE]
         return package == self.current
 
     def set_current_package(self, package):
@@ -74,50 +75,50 @@ class PackageReverseDepView(gtk.TreeView):
         self.filter_model.refilter()
 
 
-class DepExplorer(gtk.Window):
+class DepExplorer(Gtk.Window):
     def __init__(self):
-        gtk.Window.__init__(self)
+        Gtk.Window.__init__(self)
         self.set_title("Dependency Explorer")
         self.set_default_size(500, 500)
-        self.connect("delete-event", gtk.main_quit)
+        self.connect("delete-event", Gtk.main_quit)
 
         # Create the data models
-        self.pkg_model = gtk.ListStore(gobject.TYPE_STRING)
-        self.pkg_model.set_sort_column_id(COL_PKG_NAME, gtk.SORT_ASCENDING)
-        self.depends_model = gtk.ListStore(gobject.TYPE_INT, gobject.TYPE_STRING, gobject.TYPE_STRING)
-        self.depends_model.set_sort_column_id(COL_DEP_PACKAGE, gtk.SORT_ASCENDING)
+        self.pkg_model = Gtk.ListStore(GObject.TYPE_STRING)
+        self.pkg_model.set_sort_column_id(COL_PKG_NAME, Gtk.SortType.ASCENDING)
+        self.depends_model = Gtk.ListStore(GObject.TYPE_INT, GObject.TYPE_STRING, GObject.TYPE_STRING)
+        self.depends_model.set_sort_column_id(COL_DEP_PACKAGE, Gtk.SortType.ASCENDING)
 
-        pane = gtk.HPaned()
+        pane = Gtk.HPaned()
         pane.set_position(250)
         self.add(pane)
 
         # The master list of packages
-        scrolled = gtk.ScrolledWindow()
-        scrolled.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
-        scrolled.set_shadow_type(gtk.SHADOW_IN)
+        scrolled = Gtk.ScrolledWindow()
+        scrolled.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
+        scrolled.set_shadow_type(Gtk.ShadowType.IN)
 
-        self.pkg_treeview = gtk.TreeView(self.pkg_model)
+        self.pkg_treeview = Gtk.TreeView(self.pkg_model)
         self.pkg_treeview.get_selection().connect("changed", self.on_cursor_changed)
-        column = gtk.TreeViewColumn("Package", gtk.CellRendererText(), text=COL_PKG_NAME)
+        column = Gtk.TreeViewColumn("Package", Gtk.CellRendererText(), text=COL_PKG_NAME)
         self.pkg_treeview.append_column(column)
         pane.add1(scrolled)
         scrolled.add(self.pkg_treeview)
 
-        box = gtk.VBox(homogeneous=True, spacing=4)
+        box = Gtk.VBox(homogeneous=True, spacing=4)
 
         # Runtime Depends
-        scrolled = gtk.ScrolledWindow()
-        scrolled.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
-        scrolled.set_shadow_type(gtk.SHADOW_IN)
+        scrolled = Gtk.ScrolledWindow()
+        scrolled.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
+        scrolled.set_shadow_type(Gtk.ShadowType.IN)
         self.rdep_treeview = PackageDepView(self.depends_model, TYPE_RDEP, "Runtime Depends")
         self.rdep_treeview.connect("row-activated", self.on_package_activated, COL_DEP_PACKAGE)
         scrolled.add(self.rdep_treeview)
         box.add(scrolled)
 
         # Build Depends
-        scrolled = gtk.ScrolledWindow()
-        scrolled.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
-        scrolled.set_shadow_type(gtk.SHADOW_IN)
+        scrolled = Gtk.ScrolledWindow()
+        scrolled.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
+        scrolled.set_shadow_type(Gtk.ShadowType.IN)
         self.dep_treeview = PackageDepView(self.depends_model, TYPE_DEP, "Build Depends")
         self.dep_treeview.connect("row-activated", self.on_package_activated, COL_DEP_PACKAGE)
         scrolled.add(self.dep_treeview)
@@ -125,9 +126,9 @@ class DepExplorer(gtk.Window):
         pane.add2(box)
 
         # Reverse Depends
-        scrolled = gtk.ScrolledWindow()
-        scrolled.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
-        scrolled.set_shadow_type(gtk.SHADOW_IN)
+        scrolled = Gtk.ScrolledWindow()
+        scrolled.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
+        scrolled.set_shadow_type(Gtk.ShadowType.IN)
         self.revdep_treeview = PackageReverseDepView(self.depends_model, "Reverse Depends")
         self.revdep_treeview.connect("row-activated", self.on_package_activated, COL_DEP_PARENT)
         scrolled.add(self.revdep_treeview)
@@ -183,15 +184,23 @@ class gtkthread(threading.Thread):
         threading.Thread.__init__(self)
         self.setDaemon(True)
         self.shutdown = shutdown
+        if not Gtk.init_check()[0]:
+            sys.stderr.write("Gtk+ init failed. Make sure DISPLAY variable is set.\n")
+            gtkthread.quit.set()
 
     def run(self):
-        gobject.threads_init()
-        gtk.gdk.threads_init()
-        gtk.main()
+        GObject.threads_init()
+        Gdk.threads_init()
+        Gtk.main()
         gtkthread.quit.set()
 
 
 def main(server, eventHandler, params):
+    shutdown = 0
+
+    gtkgui = gtkthread(shutdown)
+    gtkgui.start()
+
     try:
         params.updateFromServer(server)
         cmdline = params.parseActions()
@@ -212,31 +221,24 @@ def main(server, eventHandler, params):
         elif ret != True:
             print("Error running command '%s': returned %s" % (cmdline, ret))
             return 1
-    except xmlrpclib.Fault as x:
+    except client.Fault as x:
         print("XMLRPC Fault getting commandline:\n %s" % x)
         return
 
-    try:
-        gtk.init_check()
-    except RuntimeError:
-        sys.stderr.write("Please set DISPLAY variable before running this command \n")
+    if gtkthread.quit.isSet():
         return
 
-    shutdown = 0
-
-    gtkgui = gtkthread(shutdown)
-    gtkgui.start()
-
-    gtk.gdk.threads_enter()
+    Gdk.threads_enter()
     dep = DepExplorer()
-    bardialog = gtk.Dialog(parent=dep,
-                           flags=gtk.DIALOG_MODAL|gtk.DIALOG_DESTROY_WITH_PARENT)
+    bardialog = Gtk.Dialog(parent=dep,
+            flags=Gtk.DialogFlags.MODAL|Gtk.DialogFlags.DESTROY_WITH_PARENT)
     bardialog.set_default_size(400, 50)
-    pbar = HobProgressBar()
-    bardialog.vbox.pack_start(pbar)
+    box = bardialog.get_content_area()
+    pbar = Gtk.ProgressBar()
+    box.pack_start(pbar, True, True, 0)
     bardialog.show_all()
-    bardialog.connect("delete-event", gtk.main_quit)
-    gtk.gdk.threads_leave()
+    bardialog.connect("delete-event", Gtk.main_quit)
+    Gdk.threads_leave()
 
     progress_total = 0
     while True:
@@ -253,49 +255,48 @@ def main(server, eventHandler, params):
 
             if isinstance(event, bb.event.CacheLoadStarted):
                 progress_total = event.total
-                gtk.gdk.threads_enter()
+                Gdk.threads_enter()
                 bardialog.set_title("Loading Cache")
-                pbar.update(0)
-                gtk.gdk.threads_leave()
+                pbar.set_fraction(0.0)
+                Gdk.threads_leave()
 
             if isinstance(event, bb.event.CacheLoadProgress):
                 x = event.current
-                gtk.gdk.threads_enter()
-                pbar.update(x * 1.0 / progress_total)
-                pbar.set_title('')
-                gtk.gdk.threads_leave()
+                Gdk.threads_enter()
+                pbar.set_fraction(x * 1.0 / progress_total)
+                Gdk.threads_leave()
                 continue
 
             if isinstance(event, bb.event.CacheLoadCompleted):
-                bardialog.hide()
                 continue
 
             if isinstance(event, bb.event.ParseStarted):
                 progress_total = event.total
                 if progress_total == 0:
                     continue
-                gtk.gdk.threads_enter()
-                pbar.update(0)
+                Gdk.threads_enter()
+                pbar.set_fraction(0.0)
                 bardialog.set_title("Processing recipes")
-
-                gtk.gdk.threads_leave()
+                Gdk.threads_leave()
 
             if isinstance(event, bb.event.ParseProgress):
                 x = event.current
-                gtk.gdk.threads_enter()
-                pbar.update(x * 1.0 / progress_total)
-                pbar.set_title('')
-                gtk.gdk.threads_leave()
+                Gdk.threads_enter()
+                pbar.set_fraction(x * 1.0 / progress_total)
+                Gdk.threads_leave()
                 continue
 
             if isinstance(event, bb.event.ParseCompleted):
-                bardialog.hide()
+                Gdk.threads_enter()
+                bardialog.set_title("Generating dependency tree")
+                Gdk.threads_leave()
                 continue
 
             if isinstance(event, bb.event.DepTreeGenerated):
-                gtk.gdk.threads_enter()
+                Gdk.threads_enter()
+                bardialog.hide()
                 dep.parse(event._depgraph)
-                gtk.gdk.threads_leave()
+                Gdk.threads_leave()
 
             if isinstance(event, bb.command.CommandCompleted):
                 continue
-- 
2.1.4


