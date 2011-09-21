Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R6BSg-0000IM-Tt
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Sep 2011 03:18:55 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 20 Sep 2011 18:13:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,414,1312182000"; d="scan'208";a="53811752"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.183])
	by fmsmga001.fm.intel.com with ESMTP; 20 Sep 2011 18:13:33 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Sep 2011 18:13:27 -0700
Message-Id: <043914a8b478fd4a7799acd1b44bdb3b0af2165a.1316567365.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6.2
In-Reply-To: <cover.1316567365.git.josh@linux.intel.com>
References: <cover.1316567365.git.josh@linux.intel.com>
In-Reply-To: <cover.1316567365.git.josh@linux.intel.com>
References: <cover.1316567365.git.josh@linux.intel.com>
Subject: [PATCH 2/2] hob: fix opening of image output dir on image build completion
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
X-List-Received-Date: Wed, 21 Sep 2011 01:18:55 -0000

Firstly, rather than polling the DEPLOY_DIR_IMAGE directory each time an
image is built store the variable as a member of the hobeventhandler.
Secondly emit the generic "build-complete" signal *after* the specialised
"build-failed" or "build-succeeded" signals such that the appropriate
state variables are set before we try and use them.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobeventhandler.py |    5 ++++-
 lib/bb/ui/crumbs/runningbuild.py    |    6 +++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 393b407..30504e1 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -79,11 +79,14 @@ class HobHandler(gobject.GObject):
         self.current_phase = None
         self.bbpath_ok = False
         self.bbfiles_ok = False
+        self.build_type = "image"
         self.image_dir = os.path.join(tempfile.gettempdir(), 'hob-images')
 
         self.model = taskmodel
         self.server = server
 
+        deploy_dir = self.server.runCommand(["getVariable", "DEPLOY_DIR"])
+        self.image_out_dir = os.path.join(deploy_dir, "images")
         self.image_output_types = self.server.runCommand(["getVariable", "IMAGE_FSTYPES"]).split(" ")
 
     def run_next_command(self):
@@ -324,7 +327,7 @@ class HobHandler(gobject.GObject):
         return self.image_output_types
 
     def get_image_deploy_dir(self):
-        return self.server.runCommand(["getVariable", "DEPLOY_DIR_IMAGE"])
+        return self.img_out_dir
 
     def make_temp_dir(self):
         bb.utils.mkdirhier(self.image_dir)
diff --git a/lib/bb/ui/crumbs/runningbuild.py b/lib/bb/ui/crumbs/runningbuild.py
index bd0cbf0..509590a 100644
--- a/lib/bb/ui/crumbs/runningbuild.py
+++ b/lib/bb/ui/crumbs/runningbuild.py
@@ -242,14 +242,14 @@ class RunningBuild (gobject.GObject):
                                       Colors.OK,
                                       0))
 
-            # Emit a generic "build-complete" signal for things wishing to
-            # handle when the build is finished
-            self.emit("build-complete")
             # Emit the appropriate signal depending on the number of failures
             if (failures >= 1):
                 self.emit ("build-failed")
             else:
                 self.emit ("build-succeeded")
+            # Emit a generic "build-complete" signal for things wishing to
+            # handle when the build is finished
+            self.emit("build-complete")
 
         elif isinstance(event, bb.command.CommandFailed):
             if event.error.startswith("Exited with"):
-- 
1.7.6.2



