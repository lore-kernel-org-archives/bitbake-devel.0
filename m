Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TanGP-0007hn-VX
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Nov 2012 13:49:19 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 20 Nov 2012 04:35:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.83,285,1352102400"; d="scan'208";a="251828814"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by fmsmga002.fm.intel.com with ESMTP; 20 Nov 2012 04:35:12 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Nov 2012 14:37:46 +0200
Message-Id: <1353415066-10784-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: showing when build fails because out of disk space
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
X-List-Received-Date: Tue, 20 Nov 2012 12:49:19 -0000

-to enable this in hob, first you have to enable this in bitbake using
BB_DISKMON_DIRS and/or BB_DISKMON_WARNINTERVAL vars
-created "restart the build" action on the build_fail_top_bar

[YOCTO #3357]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   38 ++++++++++++++++++++++----
 bitbake/lib/bb/ui/crumbs/builder.py          |    4 +++
 bitbake/lib/bb/ui/crumbs/hobwidget.py        |    3 +-
 bitbake/lib/bb/ui/crumbs/runningbuild.py     |    5 ++++
 4 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 1afacf8..6d8c38b 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -206,8 +206,6 @@ class BuildDetailsPage (HobPage):
     def add_build_fail_top_bar(self, actions, log_file=None):
         primary_action = "Edit %s" % actions
 
-        self.notebook.set_page("Issues")
-
         color = HobColors.ERROR
         build_fail_top = gtk.EventBox()
         #build_fail_top.set_size_request(-1, 200)
@@ -228,7 +226,17 @@ class BuildDetailsPage (HobPage):
 
         label = gtk.Label()
         label.set_alignment(0.0, 0.5)
-        label.set_markup("<span size='medium'>Check the \"Issues\" information for more details</span>")
+        # Ensure variable disk_full is defined
+        try:
+            self.builder.disk_full
+        except NameError:
+            self.builder.disk_full = False
+        if self.builder.disk_full:
+            markup = "<span size='medium'>There is no disk space left, so Hob cannot finish building your image. Free up some disk space\n"
+            markup += "and restart the build. Check the \"Issues\" tab for more details</span>"
+            label.set_markup(markup)
+        else:
+            label.set_markup("<span size='medium'>Check the \"Issues\" information for more details</span>")
         build_fail_tab.attach(label, 4, 40, 4, 9)
 
         # create button 'Edit packages'
@@ -236,22 +244,36 @@ class BuildDetailsPage (HobPage):
         #action_button.set_size_request(-1, 40)
         action_button.set_tooltip_text("Edit the %s parameters" % actions)
         action_button.connect('clicked', self.failure_primary_action_button_clicked_cb, primary_action)
-        build_fail_tab.attach(action_button, 4, 13, 9, 12)
 
         if log_file:
             open_log_button = HobAltButton("Open log")
             open_log_button.set_relief(gtk.RELIEF_HALF)
             open_log_button.set_tooltip_text("Open the build's log file")
             open_log_button.connect('clicked', self.open_log_button_clicked_cb, log_file)
-            build_fail_tab.attach(open_log_button, 14, 23, 9, 12)
 
         attach_pos = (24 if log_file else 14)
         file_bug_button = HobAltButton('File a bug')
         file_bug_button.set_relief(gtk.RELIEF_HALF)
         file_bug_button.set_tooltip_text("Open the Yocto Project bug tracking website")
         file_bug_button.connect('clicked', self.failure_activate_file_bug_link_cb)
-        build_fail_tab.attach(file_bug_button, attach_pos, attach_pos + 9, 9, 12)
 
+        if not self.builder.disk_full:
+            build_fail_tab.attach(action_button, 4, 13, 9, 12)
+            if log_file:
+                build_fail_tab.attach(open_log_button, 14, 23, 9, 12)
+            build_fail_tab.attach(file_bug_button, attach_pos, attach_pos + 9, 9, 12)
+
+        else:
+            restart_build = HobButton("Restart the build")
+            restart_build.set_tooltip_text("Restart the build")
+            restart_build.connect('clicked', self.restart_build_button_clicked_cb)
+
+            build_fail_tab.attach(restart_build, 4, 13, 9, 12)
+            build_fail_tab.attach(action_button, 14, 23, 9, 12)
+            if log_file:
+                build_fail_tab.attach(open_log_button, attach_pos, attach_pos + 9, 9, 12)
+
+        self.builder.disk_full = False
         return build_fail_top
 
     def show_fail_page(self, title):
@@ -266,6 +288,7 @@ class BuildDetailsPage (HobPage):
 
         self.vbox.pack_start(self.notebook, expand=True, fill=True)
         self.show_all()
+        self.notebook.set_page("Issues")
         self.back_button.hide()
 
     def add_build_stop_top_bar(self, action, log_file=None):
@@ -396,6 +419,9 @@ class BuildDetailsPage (HobPage):
         elif "Edit image" in action:
             self.builder.show_configuration()
 
+    def restart_build_button_clicked_cb(self, button):
+        self.builder.just_bake()
+
     def stop_primary_action_button_clicked_cb(self, button, action):
         if "recipes" in action:
             self.builder.show_recipes()
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index ecf5371..0fcfca7 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -457,6 +457,7 @@ class Builder(gtk.Window):
         self.handler.build.connect("build-aborted",      self.handler_build_aborted_cb)
         self.handler.build.connect("task-started",       self.handler_task_started_cb)
         self.handler.build.connect("log-error",          self.handler_build_failure_cb)
+        self.handler.build.connect("disk-full",          self.handler_disk_full_cb)
         self.handler.build.connect("log",                self.handler_build_log_cb)
         self.handler.build.connect("no-provider",        self.handler_no_provider_cb)
         self.handler.connect("generating-data",          self.handler_generating_data_cb)
@@ -1121,6 +1122,9 @@ class Builder(gtk.Window):
         self.build_details_page.update_progress_bar(title + ": ", fraction)
         self.build_details_page.update_build_status(message["current"], message["total"], message["task"])
 
+    def handler_disk_full_cb(self, running_build):
+        self.disk_full = True
+
     def handler_build_failure_cb(self, running_build):
         self.build_details_page.show_issues()
 
diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 65de9df..3ca9066 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -521,7 +521,8 @@ class HobNotebook(gtk.Notebook):
         for child in self.pages:
             if child.lbl.get_label() == title:
                 child.grab_focus()
-                self.set_current_page(self.page_num(child))
+                self.set_current_page(self.pages.index(child))
+                return
 
 class HobWarpCellRendererText(gtk.CellRendererText):
     def __init__(self, col_number):
diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
index b4d19b6..87995b9 100644
--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
@@ -85,6 +85,9 @@ class RunningBuild (gobject.GObject):
           'log-error'       :  (gobject.SIGNAL_RUN_LAST,
                                 gobject.TYPE_NONE,
                                ()),
+          'disk-full'       :  (gobject.SIGNAL_RUN_LAST,
+                                gobject.TYPE_NONE,
+                               ()),
           'no-provider'     :  (gobject.SIGNAL_RUN_LAST,
                                 gobject.TYPE_NONE,
                                (gobject.TYPE_PYOBJECT,)),
@@ -286,6 +289,7 @@ class RunningBuild (gobject.GObject):
             # Emit the appropriate signal depending on the number of failures
             if self.buildaborted:
                 self.emit ("build-aborted")
+                self.buildaborted = False
             elif (failures >= 1):
                 self.emit ("build-failed")
             else:
@@ -300,6 +304,7 @@ class RunningBuild (gobject.GObject):
 
         elif isinstance(event, bb.event.DiskFull):
             self.buildaborted = True
+            self.emit("disk-full")
 
         elif isinstance(event, bb.command.CommandFailed):
             self.emit("log", "error", "Command execution failed: %s" % (event.error))
-- 
1.7.9.5



