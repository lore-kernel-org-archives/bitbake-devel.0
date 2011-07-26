Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qlmip-0003hd-Nh
	for bitbake-devel@lists.openembedded.org;
	Tue, 26 Jul 2011 20:51:15 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 26 Jul 2011 11:46:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,270,1309762800"; d="scan'208";a="30353976"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.155])
	by orsmga002.jf.intel.com with ESMTP; 26 Jul 2011 11:46:52 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2011 11:46:38 -0700
Message-Id: <d947f9880c2205be66fbd61cf7d3728275979a56.1311705833.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311705833.git.josh@linux.intel.com>
References: <cover.1311705833.git.josh@linux.intel.com>
In-Reply-To: <cover.1311705833.git.josh@linux.intel.com>
References: <cover.1311705833.git.josh@linux.intel.com>
Subject: [PATCH 04/10] ui/hob: don't offer to show built output if build fails
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
X-List-Received-Date: Tue, 26 Jul 2011 18:51:16 -0000

The link to open the deploy directory should only be shown if the build
completed succesfully.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 654d2df..e0380dd 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -57,6 +57,7 @@ class MainWindow (gtk.Window):
         self.layers = layers
         self.save_path = None
         self.dirty = False
+        self.build_succeeded = False
 
         self.connect("delete-event", self.destroy_window)
         self.set_title("Image Creator")
@@ -65,6 +66,7 @@ class MainWindow (gtk.Window):
 
         self.build = RunningBuild()
         self.build.connect("build-failed", self.running_build_failed_cb)
+        self.build.connect("build-succeeded", self.running_build_succeeded_cb)
         self.build.connect("build-started", self.build_started_cb)
         self.build.connect("build-complete", self.build_complete_cb)
 
@@ -113,9 +115,11 @@ class MainWindow (gtk.Window):
     def scroll_tv_cb(self, model, path, it, view):
         view.scroll_to_cell(path)
 
+    def running_build_succeeded_cb(self, running_build):
+        self.build_succeeded = True
+
     def running_build_failed_cb(self, running_build):
-        # FIXME: handle this
-        print("Build failed")
+        self.build_succeeded = False
 
     def image_changed_string_cb(self, model, new_image):
         cnt = 0
@@ -408,7 +412,7 @@ class MainWindow (gtk.Window):
             os.remove(f)
 
         lbl = "<b>Build completed</b>\n\nClick 'Edit Image' to start another build or 'View Log' to view the build log."
-        if self.handler.building == "image":
+        if self.handler.building == "image" and self.build_succeeded:
             deploy = self.handler.get_image_deploy_dir()
             lbl = lbl + "\n<a href=\"file://%s\" title=\"%s\">Browse folder of built images</a>." % (deploy, deploy)
 
-- 
1.7.6



