Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SWTuw-0000IU-DR
	for bitbake-devel@lists.openembedded.org;
	Mon, 21 May 2012 16:49:02 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 21 May 2012 07:38:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="146430768"
Received: from hp.sh.intel.com ([10.239.47.6])
	by orsmga002.jf.intel.com with ESMTP; 21 May 2012 07:38:56 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 May 2012 22:41:21 +0800
Message-Id: <498d0438ede9d17c4bf9d8e865c2e0068d5b0640.1337610738.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <be9df903825ec31825cd12c0d5d20d0ca0e8d88a.1337610738.git.limingx.l.an@intel.com>
References: <be9df903825ec31825cd12c0d5d20d0ca0e8d88a.1337610738.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1337610738.git.limingx.l.an@intel.com>
References: <cover.1337610738.git.limingx.l.an@intel.com>
Subject: [PATCH 2/5] Hob: change the build failure scenario as ui design
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
X-List-Received-Date: Mon, 21 May 2012 14:49:02 -0000

change the top bar display in build 'issue' page

[YOCTO #2183]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   99 +++++++++++++++++++++++++-
 bitbake/lib/bb/ui/crumbs/builder.py          |    8 ++
 bitbake/lib/bb/ui/crumbs/hobwidget.py        |    7 ++
 3 files changed, 113 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index c2d5abc..0052b01 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -24,10 +24,11 @@ import gtk
 import pango
 import gobject
 from bb.ui.crumbs.progressbar import HobProgressBar
-from bb.ui.crumbs.hobwidget import hic, HobNotebook, HobAltButton, HobWarpCellRendererText
+from bb.ui.crumbs.hobwidget import hic, HobNotebook, HobAltButton, HobWarpCellRendererText, HobButton
 from bb.ui.crumbs.runningbuild import RunningBuildTreeView
 from bb.ui.crumbs.runningbuild import BuildFailureTreeView
 from bb.ui.crumbs.hobpages import HobPage
+from bb.ui.crumbs.hobcolor import HobColors
 
 class BuildConfigurationTreeView(gtk.TreeView):
     def __init__ (self):
@@ -198,6 +199,87 @@ class BuildDetailsPage (HobPage):
         for child in children:
             self.remove(child)
 
+    def update_failures_sum_display(self):
+        num = 0
+        it = self.failure_model.get_iter_first()
+        while it:
+            color = self.failure_model.get_value(it, self.builder.handler.build.model.COL_COLOR)
+            if color == HobColors.ERROR:
+                num += 1
+            it = self.failure_model.iter_next(it)
+
+        return num
+
+    def add_build_fail_top_bar(self, actions):
+        mainly_action = "Edit %s" % actions
+        if 'image' in actions:
+            next_action   = ""
+        else:
+            next_action   = "Create new image"
+
+        #set to issue page
+        self.notebook.set_page("Issues")
+
+        color = HobColors.ERROR
+        build_fail_top = gtk.EventBox()
+        build_fail_top.set_size_request(-1, 260)
+        build_fail_top.modify_bg(gtk.STATE_NORMAL, gtk.gdk.color_parse(color))
+
+        build_fail_tab = gtk.Table(7, 40, True)
+        build_fail_top.add(build_fail_tab)
+
+        icon = gtk.Image()
+        icon_pix_buffer = gtk.gdk.pixbuf_new_from_file(hic.ICON_INDI_ERROR_FILE)
+        icon.set_from_pixbuf(icon_pix_buffer)
+        build_fail_tab.attach(icon, 1, 4, 0, 3)
+
+        label = gtk.Label()
+        label.set_alignment(0.0, 0.5)
+        label.set_markup("<span size='x-large'>%s</span>" % self.title)
+        build_fail_tab.attach(label, 4, 20, 0, 3)
+
+        label = gtk.Label()
+        label.set_alignment(0.0, 0.5)
+        num_of_fails = self.update_failures_sum_display()
+        current_fail, recipe_task_status = self.task_status.get_text().split('\n')
+        label.set_markup(" %d tasks failed,  %s, %s" % (num_of_fails, current_fail, recipe_task_status))
+        build_fail_tab.attach(label, 4, 40, 2, 4)
+
+        # create button 'Edit packages'
+        action_button = HobButton(mainly_action)
+        action_button.set_size_request(-1, 49)
+        action_button.connect('clicked', self.failure_main_action_button_clicked_cb, mainly_action)
+        build_fail_tab.attach(action_button, 4, 16, 4, 6)
+
+        if next_action:
+            next_button = HobAltButton(next_action)
+            next_button.set_alignment(0.0, 0.5)
+            next_button.connect('clicked', self.failure_next_action_button_clicked_cb, next_action)
+            build_fail_tab.attach(next_button, 17, 24, 4, 5)
+
+        file_bug_button = HobAltButton('File a bug')
+        file_bug_button.set_alignment(0.0, 0.5)
+        file_bug_button.connect('clicked', self.failure_file_bug_activate_link_cb)
+        build_fail_tab.attach(file_bug_button, 17, 24, 4 + abs(next_action != ""), 6)
+
+        return build_fail_top
+
+    def show_fail_page(self, title, action_names):
+        self._remove_all_widget()
+        self.title = "Hob cannot build your %s" % title
+
+        self.build_fail_bar = self.add_build_fail_top_bar(action_names)
+        self.pack_start(self.build_fail_bar)
+        self.pack_start(self.group_align, expand=True, fill=True)
+
+        self.box_group_area.pack_start(self.vbox, expand=True, fill=True)
+
+        self.vbox.pack_start(self.notebook, expand=True, fill=True)
+
+        self.box_group_area.pack_end(self.button_box, expand=False, fill=False)
+        self.show_all()
+        self.back_button.hide()
+
     def show_page(self, step):
         self._remove_all_widget()
         if step == self.builder.PACKAGE_GENERATING or step == self.builder.FAST_IMAGE_GENERATING:
@@ -251,3 +333,18 @@ class BuildDetailsPage (HobPage):
 
     def show_configurations(self, configurations, params):
         self.config_tv.show(configurations, params)
+
+    def failure_main_action_button_clicked_cb(self, button, action):
+        if "Edit recipes" in action:
+            self.builder.show_recipes()
+        elif "Edit packages" in action:
+            self.builder.show_packages()
+        elif "Edit image configuration" in action:
+            self.builder.show_configuration()
+
+    def failure_next_action_button_clicked_cb(self, button, action):
+        if "Create new image" in action:
+            self.builder.initiate_new_build_async()
+
+    def failure_file_bug_activate_link_cb(self, button):
+        button.child.emit('activate-link', "http://bugzilla.yoctoproject.org")
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index eb60b89..d10ced6 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -778,12 +778,20 @@ class Builder(gtk.Window):
             message = "Build stopped: "
             fraction = self.build_details_page.progress_bar.get_fraction()
         else:
+            fail_to_next_edit = ""
             if self.current_step == self.FAST_IMAGE_GENERATING:
+                fail_to_next_edit = "image configuration"
                 fraction = 0.9
             elif self.current_step == self.IMAGE_GENERATING:
+                if self.previous_step == self.FAST_IMAGE_GENERATING:
+                    fail_to_next_edit = "image configuration"
+                else:
+                    fail_to_next_edit = "packages"
                 fraction = 1.0
             elif self.current_step == self.PACKAGE_GENERATING:
+                fail_to_next_edit = "recipes"
                 fraction = 1.0
+            self.build_details_page.show_fail_page(fail_to_next_edit.split(' ')[0], fail_to_next_edit)
             status = "fail"
             message = "Build failed: "
         self.build_details_page.update_progress_bar(message, fraction, status)
diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index f5997e5..f8e97ad 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -566,6 +566,13 @@ class HobNotebook(gtk.Notebook):
     def set_search_entry_clear_cb(self, search, icon_pos, event):
         self.reset_entry(search)
 
+    def set_page(self, title):
+        for child in self.tabbar.children:
+            if child["title"] == title:
+                self.tabbar.current_child = child
+                self.tabbar.grab_focus()
+                self.notebook.set_current_page(child["toggled_page"])
+
 class HobWarpCellRendererText(gtk.CellRendererText):
     def __init__(self, col_number):
         gtk.CellRendererText.__init__(self)
-- 
1.7.5.4



