Return-Path: <maxin.john@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 5942B6FFCC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jun 2016 14:42:12 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 17 Jun 2016 07:42:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,484,1459839600"; d="scan'208";a="1004346099"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga002.fm.intel.com with ESMTP; 17 Jun 2016 07:42:13 -0700
Received: from mbabyjoh-desk.fi.intel.com (mbabyjoh-desk.fi.intel.com
	[10.237.72.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTP id 9BF066A4006
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jun 2016 07:42:11 -0700 (PDT)
From: "Maxin B. John" <maxin.john@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Jun 2016 17:41:58 +0300
Message-Id: <1466174518-19538-1-git-send-email-maxin.john@intel.com>
X-Mailer: git-send-email 2.4.0
Subject: [PATCH] depexp.py: port to gtk+3
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
X-List-Received-Date: Fri, 17 Jun 2016 14:42:13 -0000

Update depexp.py to support gtk+3

Signed-off-by: Maxin B. John <maxin.john@intel.com>
---
 bitbake/lib/bb/ui/depexp.py | 127 ++++++++++++++++++++------------------------
 1 file changed, 58 insertions(+), 69 deletions(-)

diff --git a/bitbake/lib/bb/ui/depexp.py b/bitbake/lib/bb/ui/depexp.py
index 240aafc..8f603dd 100644
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
@@ -185,9 +186,10 @@ class gtkthread(threading.Thread):
         self.shutdown = shutdown
 
     def run(self):
-        gobject.threads_init()
-        gtk.gdk.threads_init()
-        gtk.main()
+        time.sleep(1)
+        GObject.threads_init()
+        Gdk.threads_init()
+        Gtk.main()
         gtkthread.quit.set()
 
 
@@ -212,12 +214,12 @@ def main(server, eventHandler, params):
         elif ret != True:
             print("Error running command '%s': returned %s" % (cmdline, ret))
             return 1
-    except xmlrpclib.Fault as x:
+    except client.Fault as x:
         print("XMLRPC Fault getting commandline:\n %s" % x)
         return
 
     try:
-        gtk.init_check()
+        Gtk.init_check()
     except RuntimeError:
         sys.stderr.write("Please set DISPLAY variable before running this command \n")
         return
@@ -227,16 +229,14 @@ def main(server, eventHandler, params):
     gtkgui = gtkthread(shutdown)
     gtkgui.start()
 
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
     bardialog.show_all()
-    bardialog.connect("delete-event", gtk.main_quit)
-    gtk.gdk.threads_leave()
+    bardialog.connect("delete-event", Gtk.main_quit)
+    Gdk.threads_leave()
 
     progress_total = 0
     while True:
@@ -253,17 +253,12 @@ def main(server, eventHandler, params):
 
             if isinstance(event, bb.event.CacheLoadStarted):
                 progress_total = event.total
-                gtk.gdk.threads_enter()
+                Gdk.threads_enter()
                 bardialog.set_title("Loading Cache")
-                pbar.update(0)
-                gtk.gdk.threads_leave()
+                Gdk.threads_leave()
 
             if isinstance(event, bb.event.CacheLoadProgress):
                 x = event.current
-                gtk.gdk.threads_enter()
-                pbar.update(x * 1.0 / progress_total)
-                pbar.set_title('')
-                gtk.gdk.threads_leave()
                 continue
 
             if isinstance(event, bb.event.CacheLoadCompleted):
@@ -274,18 +269,12 @@ def main(server, eventHandler, params):
                 progress_total = event.total
                 if progress_total == 0:
                     continue
-                gtk.gdk.threads_enter()
-                pbar.update(0)
+                Gdk.threads_enter()
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
                 continue
 
             if isinstance(event, bb.event.ParseCompleted):
@@ -293,9 +282,9 @@ def main(server, eventHandler, params):
                 continue
 
             if isinstance(event, bb.event.DepTreeGenerated):
-                gtk.gdk.threads_enter()
+                Gdk.threads_enter()
                 dep.parse(event._depgraph)
-                gtk.gdk.threads_leave()
+                Gdk.threads_leave()
 
             if isinstance(event, bb.command.CommandCompleted):
                 continue
-- 
2.4.0


