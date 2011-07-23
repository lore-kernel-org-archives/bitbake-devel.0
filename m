Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QkUIZ-0005rY-9m
	for bitbake-devel@lists.openembedded.org;
	Sat, 23 Jul 2011 06:58:47 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 22 Jul 2011 21:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,251,1309762800"; d="scan'208";a="31029047"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.127])
	by orsmga001.jf.intel.com with ESMTP; 22 Jul 2011 21:54:35 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Jul 2011 21:54:23 -0700
Message-Id: <726eb1010691023c98601eb9f81e2646df75195d.1311396521.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311396520.git.josh@linux.intel.com>
References: <cover.1311396520.git.josh@linux.intel.com>
In-Reply-To: <cover.1311396520.git.josh@linux.intel.com>
References: <cover.1311396520.git.josh@linux.intel.com>
Subject: [PATCH 4/8] ui/hob: if the user clicks Stop a second time only offer 'Force Stop'
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
X-List-Received-Date: Sat, 23 Jul 2011 04:58:47 -0000

Fixes [YOCTO #1264]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |   38 ++++++++++++++++++++++++++------------
 1 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index a8bbd73..8e3e7bc 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -46,6 +46,7 @@ class MainWindow (gtk.Window):
         self.files_to_clean = []
         self.selected_image = None
         self.selected_packages = None
+        self.stopping = False
 
         self.model = taskmodel
         self.model.connect("tasklist-populated", self.update_model)
@@ -403,6 +404,7 @@ class MainWindow (gtk.Window):
         self.nb.set_current_page(0)
 
     def build_complete_cb(self, running_build):
+        self.stopping = False
         self.back.connect("clicked", self.back_button_clicked_cb)
         self.back.set_sensitive(True)
         self.cancel.set_sensitive(False)
@@ -651,20 +653,32 @@ class MainWindow (gtk.Window):
         return vbox
 
     def cancel_build(self, button):
-        lbl = "<b>Stop build?</b>\n\nAre you sure you want to stop this build?\n"
-        lbl = lbl + "'Force Stop' will stop the build as quickly as"
-        lbl = lbl + " possible but may well leave your build directory in an"
-        lbl = lbl + " unusable state that requires manual steps to fix.\n"
-        lbl = lbl + "'Stop' will stop the build as soon as all in"
-        lbl = lbl + " progress build tasks are finished. However if a"
-        lbl = lbl + " lengthy compilation phase is in progress this may take"
-        lbl = lbl + " some time."
-        dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
-        dialog.add_button(gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL)
-        dialog.add_button("Stop", gtk.RESPONSE_OK)
-        dialog.add_button("Force Stop", gtk.RESPONSE_YES)
+        if self.stopping:
+            lbl = "<b>Force Stop build?</b>\nYou've already selected Stop once,"
+            lbl = lbl + " would you like to 'Force Stop' the build?\n\n"
+            lbl = lbl + "This will stop the build as quickly as possible but may"
+            lbl = lbl + " well leave your build directory in an  unusable state"
+            lbl = lbl + " that requires manual steps to fix.\n"
+            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
+            dialog.add_button(gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL)
+            dialog.add_button("Force Stop", gtk.RESPONSE_YES)
+        else:
+            lbl = "<b>Stop build?</b>\n\nAre you sure you want to stop this"
+            lbl = lbl + " build?\n\n'Force Stop' will stop the build as quickly as"
+            lbl = lbl + " possible but may well leave your build directory in an"
+            lbl = lbl + " unusable state that requires manual steps to fix.\n\n"
+            lbl = lbl + "'Stop' will stop the build as soon as all in"
+            lbl = lbl + " progress build tasks are finished. However if a"
+            lbl = lbl + " lengthy compilation phase is in progress this may take"
+            lbl = lbl + " some time."
+            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
+            dialog.add_button(gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL)
+            dialog.add_button("Stop", gtk.RESPONSE_OK)
+            dialog.add_button("Force Stop", gtk.RESPONSE_YES)
         response = dialog.run()
         dialog.destroy()
+        if response != gtk.RESPONSE_CANCEL:
+            self.stopping = True
         if response == gtk.RESPONSE_OK:
             self.handler.cancel_build()
         elif response == gtk.RESPONSE_YES:
-- 
1.7.6



