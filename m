Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SA03X-0000sa-9N
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 15:28:59 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 20 Mar 2012 07:19:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="141897568"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 20 Mar 2012 07:19:33 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Mar 2012 22:41:03 +0800
Message-Id: <792c5eb29cf44d9ef559ae59802327fb1bb2cb3c.1332254194.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <e4ebac226cc5e4589bcecd8bada9fde462e925cc.1332254194.git.shane.wang@intel.com>
References: <e4ebac226cc5e4589bcecd8bada9fde462e925cc.1332254194.git.shane.wang@intel.com>
In-Reply-To: <cover.1332254194.git.shane.wang@intel.com>
References: <cover.1332254194.git.shane.wang@intel.com>
Subject: [PATCH 02/11] Hob: use HobNotebook to implement a notebook in build details page
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
X-List-Received-Date: Tue, 20 Mar 2012 14:28:59 -0000

This patch is to use HobNotebook we defined to implement the notebook in the build details page.

Signed-off-by: Liming An <limingx.l.an@intel.com>
Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   30 ++++++++++--
 bitbake/lib/bb/ui/crumbs/runningbuild.py     |   65 ++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 8b75ca0..63d2c7b 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -22,8 +22,10 @@
 
 import gtk
 from bb.ui.crumbs.progressbar import HobProgressBar
-from bb.ui.crumbs.hobwidget import hic
+from bb.ui.crumbs.hobwidget import hic, HobNotebook
 from bb.ui.crumbs.runningbuild import RunningBuildTreeView
+from bb.ui.crumbs.runningbuild import BuildConfigurationTreeView
+from bb.ui.crumbs.runningbuild import BuildFailureTreeView
 from bb.ui.crumbs.hobpages import HobPage
 
 #
@@ -49,11 +51,29 @@ class BuildDetailsPage (HobPage):
         self.stop_button.connect("clicked", self.stop_button_clicked_cb)
         self.progress_box.pack_end(self.stop_button, expand=False, fill=False)
 
+        self.notebook = HobNotebook()
+        self.config_tv = BuildConfigurationTreeView()
+        self.config_model = self.builder.handler.build.model.config_model()
+        self.config_tv.set_model(self.config_model)
+        self.scrolled_view_config = gtk.ScrolledWindow ()
+        self.scrolled_view_config.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
+        self.scrolled_view_config.add(self.config_tv)
+        self.notebook.append_page(self.scrolled_view_config, gtk.Label("Build Configuration"))
+
+        self.failure_tv = BuildFailureTreeView()
+        self.failure_model = self.builder.handler.build.model.failure_model()
+        self.failure_tv.set_model(self.failure_model)
+        self.scrolled_view_failure = gtk.ScrolledWindow ()
+        self.scrolled_view_failure.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
+        self.scrolled_view_failure.add(self.failure_tv)
+        self.notebook.append_page(self.scrolled_view_failure, gtk.Label("Issues"))
+
         self.build_tv = RunningBuildTreeView(readonly=True)
         self.build_tv.set_model(self.builder.handler.build.model)
-        self.scrolled_view = gtk.ScrolledWindow ()
-        self.scrolled_view.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
-        self.scrolled_view.add(self.build_tv)
+        self.scrolled_view_build = gtk.ScrolledWindow ()
+        self.scrolled_view_build.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
+        self.scrolled_view_build.add(self.build_tv)
+        self.notebook.append_page(self.scrolled_view_build, gtk.Label("Log"))
 
         self.button_box = gtk.HBox(False, 6)
         self.back_button = gtk.LinkButton("Go back to Image Configuration screen", "<< Back to image configuration")
@@ -86,7 +106,7 @@ class BuildDetailsPage (HobPage):
         self.progress_bar.reset()
         self.vbox.pack_start(self.progress_box, expand=False, fill=False)
 
-        self.vbox.pack_start(self.scrolled_view, expand=True, fill=True)
+        self.vbox.pack_start(self.notebook, expand=True, fill=True)
 
         self.box_group_area.pack_end(self.button_box, expand=False, fill=False)
         self.show_all()
diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
index 718f692..eedd8d9 100644
--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
@@ -25,6 +25,7 @@ import logging
 import time
 import urllib
 import urllib2
+import pango
 from bb.ui.crumbs.hobcolor import HobColors
 
 class RunningBuildModel (gtk.TreeStore):
@@ -40,6 +41,32 @@ class RunningBuildModel (gtk.TreeStore):
                                 gobject.TYPE_STRING,
                                 gobject.TYPE_INT)
 
+    def config_model_filter(self, model, it):
+        msg = model.get(it, self.COL_MESSAGE)[0]
+        if msg == None or type(msg) != str:
+            return False
+        if msg.startswith("\nOE Build Configuration:\n"):
+            return True
+        return False
+
+    def failure_model_filter(self, model, it):
+        color = model.get(it, self.COL_COLOR)[0]
+        if color == None:
+            return False
+        if color == HobColors.ERROR:
+            return True
+        return False
+
+    def config_model(self):
+        model = self.filter_new()
+        model.set_visible_func(self.config_model_filter)
+        return model
+
+    def failure_model(self):
+        model = self.filter_new()
+        model.set_visible_func(self.failure_model_filter)
+        return model
+
 class RunningBuild (gobject.GObject):
     __gsignals__ = {
           'build-started' : (gobject.SIGNAL_RUN_LAST,
@@ -376,3 +403,41 @@ class RunningBuildTreeView (gtk.TreeView):
         message = model.get(it, model.COL_MESSAGE)[0]
 
         self._add_to_clipboard(message)
+
+
+class BuildConfigurationTreeView(gtk.TreeView):
+
+    def __init__ (self):
+        gtk.TreeView.__init__(self)
+        self.set_rules_hint(False)
+        self.set_headers_visible(False)
+        self.set_property("hover-expand", True)
+        self.get_selection().set_mode(gtk.SELECTION_SINGLE)
+
+        # The message of the build.
+        self.message_renderer = gtk.CellRendererText ()
+        self.message_column = gtk.TreeViewColumn ("Message", self.message_renderer, text=RunningBuildModel.COL_MESSAGE, background=RunningBuildModel.COL_COLOR)
+        font = self.get_style().font_desc
+        font.set_size(pango.SCALE * 13)
+        self.message_renderer.set_property('font-desc', font)
+        self.append_column (self.message_column)
+
+
+class BuildFailureTreeView(gtk.TreeView):
+
+    def __init__ (self):
+        gtk.TreeView.__init__(self)
+        self.set_rules_hint(False)
+        self.set_headers_visible(False)
+        self.get_selection().set_mode(gtk.SELECTION_SINGLE)
+
+        # The icon that indicates whether we're building or failed.
+        renderer = gtk.CellRendererPixbuf ()
+        col = gtk.TreeViewColumn ("Status", renderer)
+        col.add_attribute (renderer, "icon-name", RunningBuildModel.COL_ICON)
+        self.append_column (col)
+
+        # The message of the build.
+        self.message_renderer = gtk.CellRendererText ()
+        self.message_column = gtk.TreeViewColumn ("Message", self.message_renderer, text=RunningBuildModel.COL_MESSAGE, background=RunningBuildModel.COL_COLOR)
+        self.append_column (self.message_column)
-- 
1.7.6



