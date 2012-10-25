Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TRKys-0002nt-Ia
	for bitbake-devel@lists.openembedded.org;
	Thu, 25 Oct 2012 12:48:07 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 25 Oct 2012 03:34:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,646,1344236400"; d="scan'208";a="160437997"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by AZSMGA002.ch.intel.com with ESMTP; 25 Oct 2012 03:34:35 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Oct 2012 13:36:23 +0300
Message-Id: <1351161383-17278-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: add a progress indicator when you select 'view log'
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
X-List-Received-Date: Thu, 25 Oct 2012 10:48:07 -0000

- created a new file named "hobthreads.py", defining a thread
for opening the log file in a subprocess using subprocess module;
in the future I think we will add some other threads here, to
implement some other performance issues
- on "builddetailspage", "packageselectionpage" and "imagedetailspage"
I have changed the manner for opening the log file; it uses the thread
to open the file, and on main thread it creates a dialog to show a
progress bar, which pulses till the file is open
- this was added because when the log file is big, it takes time to
be opened; on the dialog you can use "Cancel" button to terminate the
process initiated to open the file

[YOCTO #2997]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py     |   15 ++++++-
 bitbake/lib/bb/ui/crumbs/hig.py                  |   42 ++++++++++++++++++
 bitbake/lib/bb/ui/crumbs/hobthreads.py           |   51 ++++++++++++++++++++++
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py     |   16 ++++++-
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   15 ++++++-
 5 files changed, 136 insertions(+), 3 deletions(-)
 create mode 100644 bitbake/lib/bb/ui/crumbs/hobthreads.py

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 971cda0..1afacf8 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -30,6 +30,8 @@ from bb.ui.crumbs.runningbuild import RunningBuildTreeView
 from bb.ui.crumbs.runningbuild import BuildFailureTreeView
 from bb.ui.crumbs.hobpages import HobPage
 from bb.ui.crumbs.hobcolor import HobColors
+from bb.ui.crumbs.hobthreads import OpeningLogThread
+from bb.ui.crumbs.hig import OpeningLogDialog
 
 class BuildConfigurationTreeView(gtk.TreeView):
     def __init__ (self):
@@ -404,7 +406,18 @@ class BuildDetailsPage (HobPage):
 
     def open_log_button_clicked_cb(self, button, log_file):
         if log_file:
-            os.system("xdg-open /%s" % log_file)
+            self.stop = False
+            dialog = OpeningLogDialog(title = "Opening Log",
+                parent = None,
+                flags = gtk.DIALOG_MODAL
+                        | gtk.DIALOG_DESTROY_WITH_PARENT
+                        | gtk.DIALOG_NO_SEPARATOR)
+            #create a thread to open log file
+            background = OpeningLogThread(dialog, log_file, self)
+            background.start()
+            response = dialog.run()
+            self.stop = True
+            background.join()
 
     def failure_activate_file_bug_link_cb(self, button):
         button.child.emit('activate-link', "http://bugzilla.yoctoproject.org")
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 4f4fecb..d030bed 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -1855,6 +1855,9 @@ class ImageSelectionDialog (CrumbsDialog):
                     break
                 iter = self.image_store.iter_next(iter)
 
+#
+# ProxyDetailsDialog
+#
 class ProxyDetailsDialog (CrumbsDialog):
 
     def __init__(self, title, user, passwd, parent, flags, buttons=None):
@@ -1914,3 +1917,42 @@ class ProxyDetailsDialog (CrumbsDialog):
             else:
                 self.user = None
                 self.passwd = None
+
+
+#
+# OpeningLogDialog
+#
+class OpeningLogDialog (CrumbsDialog):
+
+    def __init__(self, title, parent, flags, buttons=None):
+        super(OpeningLogDialog, self).__init__(title, parent, flags, buttons)
+
+        self.running = False
+        # create visual elements on the dialog
+        self.create_visual_elements()
+
+    def start(self):
+        if not self.running:
+          self.running = True
+          gobject.timeout_add(100, self.pulse)
+
+    def pulse(self):
+        self.progress_bar.pulse()
+        return self.running
+
+    def create_visual_elements(self):
+        hbox = gtk.HBox(False, 12)
+        self.user_label = gtk.Label("The log will open in a text editor")
+        hbox.pack_start(self.user_label, expand=False, fill=False)
+        self.vbox.pack_start(hbox, expand=False, fill=False)
+
+        hbox = gtk.HBox(False, 12)
+        # Progress bar
+        self.progress_bar = HobProgressBar()
+        hbox.pack_start(self.progress_bar)
+        self.start()
+        self.vbox.pack_start(hbox, expand=False, fill=False)
+
+        button = self.add_button("Cancel", gtk.RESPONSE_CANCEL)
+        HobAltButton.style_button(button)
+        self.show_all()
diff --git a/bitbake/lib/bb/ui/crumbs/hobthreads.py b/bitbake/lib/bb/ui/crumbs/hobthreads.py
new file mode 100644
index 0000000..64ef912
--- /dev/null
+++ b/bitbake/lib/bb/ui/crumbs/hobthreads.py
@@ -0,0 +1,51 @@
+#!/usr/bin/env python
+#
+# BitBake Graphical GTK User Interface
+#
+# Copyright (C) 2012        Intel Corporation
+#
+# Authored by Cristiana Voicu <cristiana.voicu@intel.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import threading
+import gtk
+import subprocess
+
+#
+# OpeningLogThread
+#
+class OpeningLogThread(threading.Thread):
+    def __init__(self, dialog, log_file, parent):
+        threading.Thread.__init__(self)
+        self.dialog =dialog
+        self.log_file = log_file
+        self.parent = parent
+
+    def run(self):
+        p = subprocess.Popen(['xdg-open',self.log_file])
+        retcode = p.poll()
+        while (retcode == None):
+            if self.parent.stop:
+                try:
+                    p.terminate()
+                except OSError, e:
+                    if e.errno == 3:
+                        pass  # no such process
+                    else:
+                        raise
+            retcode = p.poll()
+
+        self.dialog.destroy()
+
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index c47d67a..a1c133e 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -27,6 +27,9 @@ from bb.ui.crumbs.hobwidget import hic, HobViewTable, HobAltButton, HobButton
 from bb.ui.crumbs.hobpages import HobPage
 import subprocess
 from bb.ui.crumbs.hig import CrumbsDialog
+from bb.ui.crumbs.hobthreads import OpeningLogThread
+from bb.ui.crumbs.hig import OpeningLogDialog
+
 #
 # ImageDetailsPage
 #
@@ -404,7 +407,18 @@ class ImageDetailsPage (HobPage):
 
     def open_log_clicked_cb(self, button, log_file):
         if log_file:
-            os.system("xdg-open /%s" % log_file)
+            self.stop = False
+            dialog = OpeningLogDialog(title = "Opening Log",
+                parent = None,
+                flags = gtk.DIALOG_MODAL
+                        | gtk.DIALOG_DESTROY_WITH_PARENT
+                        | gtk.DIALOG_NO_SEPARATOR)
+            #create a thread to open log file
+            background = OpeningLogThread(dialog, log_file, self)
+            background.start()
+            response = dialog.run()
+            self.stop = True
+            background.join()
 
     def refresh_package_detail_box(self, image_size):
         self.package_detail.update_line_widgets("Total image size: ", image_size)
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 17b1dfe..ac9cc7e 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -26,6 +26,8 @@ from bb.ui.crumbs.hobcolor import HobColors
 from bb.ui.crumbs.hobwidget import HobViewTable, HobNotebook, HobAltButton, HobButton
 from bb.ui.crumbs.hoblistmodel import PackageListModel
 from bb.ui.crumbs.hobpages import HobPage
+from bb.ui.crumbs.hobthreads import OpeningLogThread
+from bb.ui.crumbs.hig import OpeningLogDialog
 
 #
 # PackageSelectionPage
@@ -167,7 +169,18 @@ class PackageSelectionPage (HobPage):
 
     def open_log_clicked_cb(self, button, log_file):
         if log_file:
-            os.system("xdg-open /%s" % log_file)
+            self.stop = False
+            dialog = OpeningLogDialog(title = "Opening Log",
+                parent = None,
+                flags = gtk.DIALOG_MODAL
+                        | gtk.DIALOG_DESTROY_WITH_PARENT
+                        | gtk.DIALOG_NO_SEPARATOR)
+            #create a thread to open log file
+            background = OpeningLogThread(dialog, log_file, self)
+            background.start()
+            response = dialog.run()
+            self.stop = True
+            background.join()
 
     def show_page(self, log_file):
         children = self.button_box.get_children() or []
-- 
1.7.9.5



