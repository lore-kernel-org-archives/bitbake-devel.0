Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SCbDT-0005ig-7N
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 20:33:59 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 27 Mar 2012 11:23:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="146411135"
Received: from hp.sh.intel.com ([10.239.47.1])
	by fmsmga002.fm.intel.com with ESMTP; 27 Mar 2012 11:23:54 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 28 Mar 2012 02:25:49 +0800
Message-Id: <46d12470802e12814f5ecef4f7e676cd5c1784a1.1332871932.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cef75d16489fa6c057085c1db733f97b70340428.1332871932.git.limingx.l.an@intel.com>
References: <cef75d16489fa6c057085c1db733f97b70340428.1332871932.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1332871932.git.limingx.l.an@intel.com>
References: <cover.1332871932.git.limingx.l.an@intel.com>
Subject: [PATCH 5/6] Hob: change the implementing way about get config info for building log
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
X-List-Received-Date: Tue, 27 Mar 2012 18:33:59 -0000

Make the building log config information to get from the bitbake parameters directly, and then cancel the old way of filting the building log on running

[YOCTO #2144]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   86 ++++++++++++++++++++++++-
 bitbake/lib/bb/ui/crumbs/builder.py          |    7 ++
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py  |    6 ++
 bitbake/lib/bb/ui/crumbs/runningbuild.py     |   38 ++----------
 4 files changed, 100 insertions(+), 37 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index c2f980f..9d967cb 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -21,13 +21,90 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import gtk
+import pango
+import gobject
 from bb.ui.crumbs.progressbar import HobProgressBar
-from bb.ui.crumbs.hobwidget import hic, HobNotebook, HobAltButton
+from bb.ui.crumbs.hobwidget import hic, HobNotebook, HobAltButton, HobWarpCellRendererText
 from bb.ui.crumbs.runningbuild import RunningBuildTreeView
-from bb.ui.crumbs.runningbuild import BuildConfigurationTreeView
 from bb.ui.crumbs.runningbuild import BuildFailureTreeView
 from bb.ui.crumbs.hobpages import HobPage
 
+class BuildConfigurationTreeView(gtk.TreeView):
+    def __init__ (self):
+        gtk.TreeView.__init__(self)
+        self.set_rules_hint(False)
+        self.set_headers_visible(False)
+        self.set_property("hover-expand", True)
+        self.get_selection().set_mode(gtk.SELECTION_SINGLE)
+
+        # The icon that indicates whether we're building or failed.
+        renderer0 = gtk.CellRendererText()
+        renderer0.set_property('font-desc', pango.FontDescription('courier bold 12'))
+        col0 = gtk.TreeViewColumn ("Name", renderer0, text=0)
+        self.append_column (col0)
+
+        # The message of configuration.
+        renderer1 = HobWarpCellRendererText(col_number=1)
+        col1 = gtk.TreeViewColumn ("Values", renderer1, text=1)
+        self.append_column (col1)
+
+    def set_vars(self, key="", var=[""]):
+        d = {}
+        if type(var) == str:
+            d = {key: [var]}
+        elif type(var) == list and len(var) > 1:
+            #create the sub item line
+            l = []
+            text = ""
+            for item in var:
+                text = " - " + item
+                l.append(text)
+            d = {key: var}
+
+        return d
+
+    def set_config_model(self, show_vars):
+        listmodel = gtk.TreeStore(gobject.TYPE_STRING, gobject.TYPE_STRING)
+        parent = None
+        for var in show_vars:
+            for subitem in var.items():
+                name = subitem[0]
+                is_parent = True
+                for value in subitem[1]:
+                    if is_parent:
+                        parent = listmodel.append(parent, (name, value))
+                        is_parent = False
+                    else:
+                        listmodel.append(parent, (None, value))
+                    name = "     - "
+                parent = None
+        # renew the tree model after get the configuration messages
+        self.set_model(listmodel)
+
+    def show(self, src_config_info, src_params):
+        vars = []
+        vars.append(self.set_vars("BB VERSION:", src_params.bb_version))
+        vars.append(self.set_vars("TARGET_ARCH:", src_params.target_arch))
+        vars.append(self.set_vars("TARGET_OS:", src_params.target_os))
+        vars.append(self.set_vars("MACHINE:", src_config_info.curr_mach))
+        vars.append(self.set_vars("DISTRO:", src_config_info.curr_distro))
+        vars.append(self.set_vars("DISTRO_VERSION:", src_params.distro_version))
+        vars.append(self.set_vars("SDK_MACHINE:", src_config_info.curr_sdk_machine))
+        vars.append(self.set_vars("TUNE_FEATURE:", src_params.tune_pkgarch))
+        vars.append(self.set_vars("META:", src_config_info.layers))
+
+        for path in src_config_info.layers:
+            import os, os.path
+            if os.path.exists(path):
+                f = os.popen('cd %s; git branch 2>&1 | grep "^* " | tr -d "* "' % path)
+                if f:
+                    branch = f.readline()
+                    vars.append(self.set_vars("META-HOB:", branch))
+                    f.close()
+                break
+
+        self.set_config_model(vars)
+
 #
 # BuildDetailsPage
 #
@@ -60,8 +137,6 @@ class BuildDetailsPage (HobPage):
 
         self.notebook = HobNotebook()
         self.config_tv = BuildConfigurationTreeView()
-        self.config_model = self.builder.handler.build.model.config_model()
-        self.config_tv.set_model(self.config_model)
         self.scrolled_view_config = gtk.ScrolledWindow ()
         self.scrolled_view_config.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
         self.scrolled_view_config.add(self.config_tv)
@@ -158,3 +233,6 @@ class BuildDetailsPage (HobPage):
                 self.endpath = path
                 if v_adj.value == (v_adj.upper - v_adj.page_size): # check the gtk.adjustment position is at end boundary or not
                     treeview.scroll_to_cell(path)
+
+    def show_configurations(self, configurations, params):
+        self.config_tv.show(configurations, params)
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 7bf12e2..017f532 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -140,6 +140,12 @@ class Parameters:
         self.runnable_machine_patterns = params["runnable_machine_patterns"].split()
         self.deployable_image_types = params["deployable_image_types"].split()
         self.tmpdir = params["tmpdir"]
+        self.distro_version = params["distro_version"]
+        self.target_os = params["target_os"]
+        self.target_arch = params["target_arch"]
+        self.tune_pkgarch = params["tune_pkgarch"]
+        self.bb_version = params["bb_version"]
+        self.tune_arch = params["tune_arch"]
 
 class Builder(gtk.Window):
 
@@ -545,6 +551,7 @@ class Builder(gtk.Window):
         self.build_details_page.update_progress_bar("Build Started: ", fraction)
         self.build_details_page.reset_build_status()
         self.build_details_page.reset_issues()
+        self.build_details_page.show_configurations(self.configuration, self.parameters)
 
     def build_succeeded(self):
         if self.current_step == self.FAST_IMAGE_GENERATING:
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 8042fbd..8583fa4 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -440,4 +440,10 @@ class HobHandler(gobject.GObject):
         params["runnable_machine_patterns"] = self.server.runCommand(["getVariable", "RUNNABLE_MACHINE_PATTERNS"]) or ""
         params["deployable_image_types"] = self.server.runCommand(["getVariable", "DEPLOYABLE_IMAGE_TYPES"]) or ""
         params["tmpdir"] = self.server.runCommand(["getVariable", "TMPDIR"]) or ""
+        params["distro_version"] = self.server.runCommand(["getVariable", "DISTRO_VERSION"]) or ""
+        params["target_os"] = self.server.runCommand(["getVariable", "TARGET_OS"]) or ""
+        params["target_arch"] = self.server.runCommand(["getVariable", "TARGET_ARCH"]) or ""
+        params["tune_pkgarch"] = self.server.runCommand(["getVariable", "TUNE_PKGARCH"])  or ""
+        params["bb_version"] = self.server.runCommand(["getVariable", "BB_MIN_VERSION"]) or ""
+        params["tune_arch"] = self.server.runCommand(["getVariable", "TUNE_ARCH"]) or ""
         return params
diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
index aecfadf..b69f0ca 100644
--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
@@ -32,6 +32,11 @@ from bb.ui.crumbs.hobwidget import HobWarpCellRendererText, HobCellRendererPixbu
 class RunningBuildModel (gtk.TreeStore):
     (COL_LOG, COL_PACKAGE, COL_TASK, COL_MESSAGE, COL_ICON, COL_COLOR, COL_NUM_ACTIVE) = range(7)
 
+    __gsignals__ = {
+          'update-config-info' : (gobject.SIGNAL_RUN_LAST,
+                               gobject.TYPE_NONE,
+                               (gobject.TYPE_STRING,)),
+    }
     def __init__ (self):
         gtk.TreeStore.__init__ (self,
                                 gobject.TYPE_STRING,
@@ -42,14 +47,6 @@ class RunningBuildModel (gtk.TreeStore):
                                 gobject.TYPE_STRING,
                                 gobject.TYPE_INT)
 
-    def config_model_filter(self, model, it):
-        msg = model.get(it, self.COL_MESSAGE)[0]
-        if not msg or type(msg) != str:
-            return False
-        if msg.startswith("\nOE Build Configuration:\n"):
-            return True
-        return False
-
     def failure_model_filter(self, model, it):
         color = model.get(it, self.COL_COLOR)[0]
         if not color:
@@ -58,11 +55,6 @@ class RunningBuildModel (gtk.TreeStore):
             return True
         return False
 
-    def config_model(self):
-        model = self.filter_new()
-        model.set_visible_func(self.config_model_filter)
-        return model
-
     def failure_model(self):
         model = self.filter_new()
         model.set_visible_func(self.failure_model_filter)
@@ -75,7 +67,6 @@ class RunningBuildModel (gtk.TreeStore):
     def close_task_refresh(self):
         self.foreach(self.foreach_cell_func, None)
 
-
 class RunningBuild (gobject.GObject):
     __gsignals__ = {
           'build-started'   :  (gobject.SIGNAL_RUN_LAST,
@@ -422,25 +413,6 @@ class RunningBuildTreeView (gtk.TreeView):
 
         self._add_to_clipboard(message)
 
-
-class BuildConfigurationTreeView(gtk.TreeView):
-
-    def __init__ (self):
-        gtk.TreeView.__init__(self)
-        self.set_rules_hint(False)
-        self.set_headers_visible(False)
-        self.set_property("hover-expand", True)
-        self.get_selection().set_mode(gtk.SELECTION_SINGLE)
-
-        # The message of the build.
-        self.message_renderer = HobWarpCellRendererText (col_number=0)
-        self.message_column = gtk.TreeViewColumn ("Message", self.message_renderer, text=RunningBuildModel.COL_MESSAGE, background=RunningBuildModel.COL_COLOR)
-        font = self.get_style().font_desc
-        font.set_size(pango.SCALE * 13)
-        self.message_renderer.set_property('font-desc', font)
-        self.append_column (self.message_column)
-
-
 class BuildFailureTreeView(gtk.TreeView):
 
     def __init__ (self):
-- 
1.7.5.4



