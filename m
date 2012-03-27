Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SCNG6-0004Nd-1Y
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 05:39:46 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 26 Mar 2012 20:30:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="145976525"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.109])
	by fmsmga002.fm.intel.com with ESMTP; 26 Mar 2012 20:30:42 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Mar 2012 20:30:36 -0700
Message-Id: <2bdc071924ef9ffa1b5ce407acb93a9c35496de6.1332818913.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332818913.git.josh@linux.intel.com>
References: <cover.1332818913.git.josh@linux.intel.com>
In-Reply-To: <cover.1332818913.git.josh@linux.intel.com>
References: <cover.1332818913.git.josh@linux.intel.com>
Subject: [PATCH 2/4] lib/bb/ui/crumbs: tweak build status display
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
X-List-Received-Date: Tue, 27 Mar 2012 03:39:46 -0000

Use two lines to display the active task and recipe, per visual design.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/builddetailspage.py |    9 ++++++---
 lib/bb/ui/crumbs/builder.py          |    3 +--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/crumbs/builddetailspage.py b/lib/bb/ui/crumbs/builddetailspage.py
index c2f980f..df8304e 100755
--- a/lib/bb/ui/crumbs/builddetailspage.py
+++ b/lib/bb/ui/crumbs/builddetailspage.py
@@ -47,7 +47,7 @@ class BuildDetailsPage (HobPage):
         self.vbox = gtk.VBox(False, 12)
 
         self.progress_box = gtk.VBox(False, 12)
-        self.task_status = gtk.Label()
+        self.task_status = gtk.Label("\n") # to ensure layout is correct
         self.task_status.set_alignment(0.0, 0.5)
         self.progress_box.pack_start(self.task_status, expand=False, fill=False)
         self.progress_hbox = gtk.HBox(False, 6)
@@ -89,11 +89,14 @@ class BuildDetailsPage (HobPage):
         self.back_button.connect("clicked", self.back_button_clicked_cb)
         self.button_box.pack_start(self.back_button, expand=False, fill=False)
 
-    def update_build_status(self, tsk_msg):
+    def update_build_status(self, current, total, task):
+        recipe_path, recipe_task = task.split(", ")
+        recipe = os.path.basename(recipe_path).rstrip(".bb")
+        tsk_msg = "<b>Running task %s of %s:</b> %s\n<b>Recipe:</b> %s" % (current, total, recipe_task, recipe)
         self.task_status.set_markup(tsk_msg)
 
     def reset_build_status(self):
-        self.task_status.set_markup("")
+        self.task_status.set_markup("\n") # to ensure layout is correct
 
     def show_issues(self):
         self.num_of_issues += 1
diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index f57a855..1d32a13 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -612,8 +612,7 @@ class Builder(gtk.Window):
             elif message["eventname"] == "runQueueTaskStarted":
                 fraction = 0.2 + 0.8 * fraction
         self.build_details_page.update_progress_bar(title + ": ", fraction)
-        self.build_details_page.update_build_status(
-            "<span weight=\'bold\'>Running task %s of %s:</span> %s" % (message["current"], message["total"], message["task"]))
+        self.build_details_page.update_build_status(message["current"], message["total"], message["task"])
 
     def handler_build_failure_cb(self, running_build):
         self.build_details_page.show_issues()
-- 
1.7.7.6



