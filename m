Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TxIsd-0004mY-90
	for bitbake-devel@lists.openembedded.org;
	Mon, 21 Jan 2013 16:01:54 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 21 Jan 2013 06:45:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,506,1355126400"; d="scan'208";a="274679493"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by orsmga002.jf.intel.com with ESMTP; 21 Jan 2013 06:46:16 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 Jan 2013 16:50:40 +0200
Message-Id: <1358779840-24761-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH_V2] hob: progress bar changed to busy cursor when you open log file
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
X-List-Received-Date: Mon, 21 Jan 2013 15:02:02 -0000

-the first implementation for this bug used a progress bar, that is shown
during open file process; it revelead that the progress bar stops earlier
-now I have implemented using gtk.show_uri() method, that shows itself a
busy cursor when it opens a file;
-deleted the code for the first implementation

[YOCTO #2997]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py     |   16 +----
 bitbake/lib/bb/ui/crumbs/hig/openinglogdialog.py |   68 ----------------------
 bitbake/lib/bb/ui/crumbs/hobthreads.py           |   51 ----------------
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py     |   16 +----
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   16 +----
 5 files changed, 6 insertions(+), 161 deletions(-)
 delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/openinglogdialog.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/hobthreads.py

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 64e758d..171a7a6 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -30,8 +30,6 @@ from bb.ui.crumbs.runningbuild import RunningBuildTreeView
 from bb.ui.crumbs.runningbuild import BuildFailureTreeView
 from bb.ui.crumbs.hobpages import HobPage
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobthreads import OpeningLogThread
-from bb.ui.crumbs.hig.openinglogdialog import OpeningLogDialog
 
 class BuildConfigurationTreeView(gtk.TreeView):
     def __init__ (self):
@@ -431,18 +429,8 @@ class BuildDetailsPage (HobPage):
 
     def open_log_button_clicked_cb(self, button, log_file):
         if log_file:
-            self.stop = False
-            dialog = OpeningLogDialog(title = "Opening Log",
-                parent = None,
-                flags = gtk.DIALOG_MODAL
-                        | gtk.DIALOG_DESTROY_WITH_PARENT
-                        | gtk.DIALOG_NO_SEPARATOR)
-            #create a thread to open log file
-            background = OpeningLogThread(dialog, log_file, self)
-            background.start()
-            response = dialog.run()
-            self.stop = True
-            background.join()
+            log_file = "file:///" + log_file
+            gtk.show_uri(screen=button.get_screen(), uri=log_file, timestamp=0)
 
     def failure_activate_file_bug_link_cb(self, button):
         button.child.emit('activate-link', "http://bugzilla.yoctoproject.org")
diff --git a/bitbake/lib/bb/ui/crumbs/hig/openinglogdialog.py b/bitbake/lib/bb/ui/crumbs/hig/openinglogdialog.py
deleted file mode 100644
index f173315..0000000
--- a/bitbake/lib/bb/ui/crumbs/hig/openinglogdialog.py
+++ /dev/null
@@ -1,68 +0,0 @@
-#
-# BitBake Graphical GTK User Interface
-#
-# Copyright (C) 2011-2012   Intel Corporation
-#
-# Authored by Joshua Lock <josh@linux.intel.com>
-# Authored by Dongxiao Xu <dongxiao.xu@intel.com>
-# Authored by Shane Wang <shane.wang@intel.com>
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
-import gtk
-import gobject
-from bb.ui.crumbs.hobwidget import HobAltButton
-from bb.ui.crumbs.progressbar import HobProgressBar
-from bb.ui.crumbs.hig.crumbsdialog import CrumbsDialog
-
-"""
-The following are convenience classes for implementing GNOME HIG compliant
-BitBake GUI's
-In summary: spacing = 12px, border-width = 6px
-"""
-
-class OpeningLogDialog (CrumbsDialog):
-
-    def __init__(self, title, parent, flags, buttons=None):
-        super(OpeningLogDialog, self).__init__(title, parent, flags, buttons)
-
-        self.running = False
-        # create visual elements on the dialog
-        self.create_visual_elements()
-
-    def start(self):
-        if not self.running:
-          self.running = True
-          gobject.timeout_add(100, self.pulse)
-
-    def pulse(self):
-        self.progress_bar.pulse()
-        return self.running
-
-    def create_visual_elements(self):
-        hbox = gtk.HBox(False, 12)
-        self.user_label = gtk.Label("The log will open in a text editor")
-        hbox.pack_start(self.user_label, expand=False, fill=False)
-        self.vbox.pack_start(hbox, expand=False, fill=False)
-
-        hbox = gtk.HBox(False, 12)
-        # Progress bar
-        self.progress_bar = HobProgressBar()
-        hbox.pack_start(self.progress_bar)
-        self.start()
-        self.vbox.pack_start(hbox, expand=False, fill=False)
-
-        button = self.add_button("Cancel", gtk.RESPONSE_CANCEL)
-        HobAltButton.style_button(button)
-        self.show_all()
diff --git a/bitbake/lib/bb/ui/crumbs/hobthreads.py b/bitbake/lib/bb/ui/crumbs/hobthreads.py
deleted file mode 100644
index 64ef912..0000000
--- a/bitbake/lib/bb/ui/crumbs/hobthreads.py
+++ /dev/null
@@ -1,51 +0,0 @@
-#!/usr/bin/env python
-#
-# BitBake Graphical GTK User Interface
-#
-# Copyright (C) 2012        Intel Corporation
-#
-# Authored by Cristiana Voicu <cristiana.voicu@intel.com>
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
-import threading
-import gtk
-import subprocess
-
-#
-# OpeningLogThread
-#
-class OpeningLogThread(threading.Thread):
-    def __init__(self, dialog, log_file, parent):
-        threading.Thread.__init__(self)
-        self.dialog =dialog
-        self.log_file = log_file
-        self.parent = parent
-
-    def run(self):
-        p = subprocess.Popen(['xdg-open',self.log_file])
-        retcode = p.poll()
-        while (retcode == None):
-            if self.parent.stop:
-                try:
-                    p.terminate()
-                except OSError, e:
-                    if e.errno == 3:
-                        pass  # no such process
-                    else:
-                        raise
-            retcode = p.poll()
-
-        self.dialog.destroy()
-
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 38fbaaa..1b60aa8 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -27,8 +27,6 @@ from bb.ui.crumbs.hobwidget import hic, HobViewTable, HobAltButton, HobButton
 from bb.ui.crumbs.hobpages import HobPage
 import subprocess
 from bb.ui.crumbs.hig.crumbsdialog import CrumbsDialog
-from bb.ui.crumbs.hobthreads import OpeningLogThread
-from bb.ui.crumbs.hig.openinglogdialog import OpeningLogDialog
 
 #
 # ImageDetailsPage
@@ -407,18 +405,8 @@ class ImageDetailsPage (HobPage):
 
     def open_log_clicked_cb(self, button, log_file):
         if log_file:
-            self.stop = False
-            dialog = OpeningLogDialog(title = "Opening Log",
-                parent = None,
-                flags = gtk.DIALOG_MODAL
-                        | gtk.DIALOG_DESTROY_WITH_PARENT
-                        | gtk.DIALOG_NO_SEPARATOR)
-            #create a thread to open log file
-            background = OpeningLogThread(dialog, log_file, self)
-            background.start()
-            response = dialog.run()
-            self.stop = True
-            background.join()
+            log_file = "file:///" + log_file
+            gtk.show_uri(screen=button.get_screen(), uri=log_file, timestamp=0)
 
     def refresh_package_detail_box(self, image_size):
         self.package_detail.update_line_widgets("Total image size: ", image_size)
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 2da9277..1868ebe 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -26,8 +26,6 @@ from bb.ui.crumbs.hobcolor import HobColors
 from bb.ui.crumbs.hobwidget import HobViewTable, HobNotebook, HobAltButton, HobButton
 from bb.ui.crumbs.hoblistmodel import PackageListModel
 from bb.ui.crumbs.hobpages import HobPage
-from bb.ui.crumbs.hobthreads import OpeningLogThread
-from bb.ui.crumbs.hig.openinglogdialog import OpeningLogDialog
 
 #
 # PackageSelectionPage
@@ -169,18 +167,8 @@ class PackageSelectionPage (HobPage):
 
     def open_log_clicked_cb(self, button, log_file):
         if log_file:
-            self.stop = False
-            dialog = OpeningLogDialog(title = "Opening Log",
-                parent = None,
-                flags = gtk.DIALOG_MODAL
-                        | gtk.DIALOG_DESTROY_WITH_PARENT
-                        | gtk.DIALOG_NO_SEPARATOR)
-            #create a thread to open log file
-            background = OpeningLogThread(dialog, log_file, self)
-            background.start()
-            response = dialog.run()
-            self.stop = True
-            background.join()
+            log_file = "file:///" + log_file
+            gtk.show_uri(screen=button.get_screen(), uri=log_file, timestamp=0)
 
     def show_page(self, log_file):
         children = self.button_box.get_children() or []
-- 
1.7.9.5



