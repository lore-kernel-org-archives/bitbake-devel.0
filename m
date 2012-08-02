Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SwtKw-0005LD-3R
	for bitbake-devel@lists.openembedded.org;
	Thu, 02 Aug 2012 13:13:02 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 02 Aug 2012 04:01:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="176129818"
Received: from hp.sh.intel.com ([10.239.47.150])
	by azsmga001.ch.intel.com with ESMTP; 02 Aug 2012 04:01:22 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  2 Aug 2012 19:06:02 +0800
Message-Id: <a218bf8a38dfdd61421893ee2ae36c0bb91b55b8.1343905168.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <ec0c5d8bfb088d18270bec6157542545810e1d90.1343905168.git.limingx.l.an@intel.com>
References: <ec0c5d8bfb088d18270bec6157542545810e1d90.1343905168.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1343905168.git.limingx.l.an@intel.com>
References: <cover.1343905168.git.limingx.l.an@intel.com>
Subject: [PATCH 2/2] Hob: change the Build failure scenario as ui design
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
X-List-Received-Date: Thu, 02 Aug 2012 11:13:02 -0000

As ui design 'build-fail-spec.pdf' to change the GUI

[YOCTO #2183]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   83 ++++++++++---------------
 1 files changed, 33 insertions(+), 50 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index b1afe10..30eab29 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -25,7 +25,7 @@ import pango
 import gobject
 import bb.process
 from bb.ui.crumbs.progressbar import HobProgressBar
-from bb.ui.crumbs.hobwidget import hic, HobNotebook, HobAltButton, HobWarpCellRendererText, HobButton
+from bb.ui.crumbs.hobwidget import hic, HobNotebook, HobAltButton, HobWarpCellRendererText, HobButton, HobInfoButton
 from bb.ui.crumbs.runningbuild import RunningBuildTreeView
 from bb.ui.crumbs.runningbuild import BuildFailureTreeView
 from bb.ui.crumbs.hobpages import HobPage
@@ -199,68 +199,51 @@ class BuildDetailsPage (HobPage):
         for child in children:
             self.remove(child)
 
-    def update_failures_sum_display(self):
-        num = 0
-        it = self.failure_model.get_iter_first()
-        while it:
-            color = self.failure_model.get_value(it, self.builder.handler.build.model.COL_COLOR)
-            if color == HobColors.ERROR:
-                num += 1
-            it = self.failure_model.iter_next(it)
-
-        return num
-
-    def add_build_fail_top_bar(self, actions):
-        mainly_action = "Edit %s" % actions
-        if 'image' in actions:
-            next_action   = ""
-        else:
-            next_action   = "Create new image"
+    def add_build_fail_top_bar(self, actions, log_file=None):
+        primary_action = "Edit %s" % actions
 
-        #set to issue page
         self.notebook.set_page("Issues")
 
         color = HobColors.ERROR
         build_fail_top = gtk.EventBox()
-        build_fail_top.set_size_request(-1, 260)
+        build_fail_top.set_size_request(-1, 200)
         build_fail_top.modify_bg(gtk.STATE_NORMAL, gtk.gdk.color_parse(color))
 
-        build_fail_tab = gtk.Table(7, 40, True)
+        build_fail_tab = gtk.Table(14, 46, True)
         build_fail_top.add(build_fail_tab)
 
         icon = gtk.Image()
         icon_pix_buffer = gtk.gdk.pixbuf_new_from_file(hic.ICON_INDI_ERROR_FILE)
         icon.set_from_pixbuf(icon_pix_buffer)
-        build_fail_tab.attach(icon, 1, 4, 0, 3)
+        build_fail_tab.attach(icon, 1, 4, 0, 6)
 
         label = gtk.Label()
         label.set_alignment(0.0, 0.5)
-        label.set_markup("<span size='x-large'>%s</span>" % self.title)
-        build_fail_tab.attach(label, 4, 20, 0, 3)
+        label.set_markup("<span size='x-large'><b>%s</b></span>" % self.title)
+        build_fail_tab.attach(label, 4, 26, 0, 6)
 
         label = gtk.Label()
         label.set_alignment(0.0, 0.5)
-        num_of_fails = self.update_failures_sum_display()
-        current_fail, recipe_task_status = self.task_status.get_text().split('\n')
-        label.set_markup(" %d tasks failed,  %s, %s" % (num_of_fails, current_fail, recipe_task_status))
-        build_fail_tab.attach(label, 4, 40, 2, 4)
+        label.set_markup("<span size='medium'>Check the \"Issues\" information for more details</span>")
+        build_fail_tab.attach(label, 4, 40, 4, 9)
 
         # create button 'Edit packages'
-        action_button = HobButton(mainly_action)
-        action_button.set_size_request(-1, 49)
-        action_button.connect('clicked', self.failure_main_action_button_clicked_cb, mainly_action)
-        build_fail_tab.attach(action_button, 4, 16, 4, 6)
-
-        if next_action:
-            next_button = HobAltButton(next_action)
-            next_button.set_alignment(0.0, 0.5)
-            next_button.connect('clicked', self.failure_next_action_button_clicked_cb, next_action)
-            build_fail_tab.attach(next_button, 17, 24, 4, 5)
-
+        action_button = HobButton(primary_action)
+        action_button.set_size_request(-1, 40)
+        action_button.connect('clicked', self.failure_primary_action_button_clicked_cb, primary_action)
+        build_fail_tab.attach(action_button, 4, 13, 9, 12)
+
+        if log_file:
+            open_log_button = HobAltButton("Open log")
+            open_log_button.set_relief(gtk.RELIEF_HALF)
+            open_log_button.connect('clicked', self.failure_open_log_button_clicked_cb, log_file)
+            build_fail_tab.attach(open_log_button, 14, 23, 9, 12)
+
+        attach_pos = (24 if log_file else 14)
         file_bug_button = HobAltButton('File a bug')
-        file_bug_button.set_alignment(0.0, 0.5)
-        file_bug_button.connect('clicked', self.failure_file_bug_activate_link_cb)
-        build_fail_tab.attach(file_bug_button, 17, 24, 4 + abs(next_action != ""), 6)
+        file_bug_button.set_relief(gtk.RELIEF_HALF)
+        file_bug_button.connect('clicked', self.failure_activate_file_bug_link_cb)
+        build_fail_tab.attach(file_bug_button, attach_pos, attach_pos + 9, 9, 12)
 
         return build_fail_top
 
@@ -268,10 +251,10 @@ class BuildDetailsPage (HobPage):
         self._remove_all_widget()
         self.title = "Hob cannot build your %s" % title
 
-        self.build_fail_bar = self.add_build_fail_top_bar(action_names)
-        self.pack_start(self.build_fail_bar)
-        self.pack_start(self.group_align, expand=True, fill=True)
+        self.build_fail_bar = self.add_build_fail_top_bar(action_names, self.builder.current_logfile)
 
+        self.pack_start(self.group_align, expand=True, fill=True)
+        self.box_group_area.pack_start(self.build_fail_bar, expand=False, fill=False)
         self.box_group_area.pack_start(self.vbox, expand=True, fill=True)
 
         self.vbox.pack_start(self.notebook, expand=True, fill=True)
@@ -334,7 +317,7 @@ class BuildDetailsPage (HobPage):
     def show_configurations(self, configurations, params):
         self.config_tv.show(configurations, params)
 
-    def failure_main_action_button_clicked_cb(self, button, action):
+    def failure_primary_action_button_clicked_cb(self, button, action):
         if "Edit recipes" in action:
             self.builder.show_recipes()
         elif "Edit packages" in action:
@@ -342,9 +325,9 @@ class BuildDetailsPage (HobPage):
         elif "Edit image configuration" in action:
             self.builder.show_configuration()
 
-    def failure_next_action_button_clicked_cb(self, button, action):
-        if "Create new image" in action:
-            self.builder.initiate_new_build_async()
+    def failure_open_log_button_clicked_cb(self, button, log_file):
+        if log_file:
+            os.system("xdg-open /%s" % log_file)
 
-    def failure_file_bug_activate_link_cb(self, button):
+    def failure_activate_file_bug_link_cb(self, button):
         button.child.emit('activate-link', "http://bugzilla.yoctoproject.org")
-- 
1.7.5.4



