Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SGpI1-0004ss-On
	for bitbake-devel@lists.openembedded.org;
	Sun, 08 Apr 2012 12:24:09 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 08 Apr 2012 03:14:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="129974815"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 08 Apr 2012 03:14:53 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  8 Apr 2012 18:21:20 +0800
Message-Id: <c26c9c75b6ad71e96529b550e49eedd8ffabc516.1333880210.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333880210.git.shane.wang@intel.com>
References: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333880210.git.shane.wang@intel.com>
In-Reply-To: <cover.1333880210.git.shane.wang@intel.com>
References: <cover.1333880210.git.shane.wang@intel.com>
Subject: [PATCH 17/20] Hob: handle some steps for build-succeeded and build-failed by hob event handler itself
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
X-List-Received-Date: Sun, 08 Apr 2012 10:24:10 -0000

Changing the state of building, clearing the commands_async queue, and resetting
initcmd should be the behaviours of hob event handler rather that builder,
because those are the members of hob event handler. So, the patch is to put those
steps from the builder into the hob event handler by adding two callback functions
in it.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py         |    2 --
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    7 +++++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index afd1d1b..4997cd4 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -668,7 +668,6 @@ class Builder(gtk.Window):
         elif self.current_step == self.PACKAGE_GENERATING:
             fraction = 1.0
         self.build_details_page.update_progress_bar("Build Completed: ", fraction)
-        self.handler.build_succeeded_async()
         self.stopping = False
 
     def build_failed(self):
@@ -688,7 +687,6 @@ class Builder(gtk.Window):
         self.build_details_page.update_progress_bar(message, fraction, status)
         self.build_details_page.show_back_button()
         self.build_details_page.hide_stop_button()
-        self.handler.build_failed_async()
         self.stopping = False
 
     def handler_build_succeeded_cb(self, running_build):
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 1a7427a..41ab593 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -81,6 +81,9 @@ class HobHandler(gobject.GObject):
         self.error_msg = ""
         self.initcmd = None
 
+        self.build.connect("build-succeeded", self.build_succeeded_cb)
+        self.build.connect("build-failed",    self.build_failed_cb)
+
     def set_busy(self):
         if not self.generating:
             self.emit("generating-data")
@@ -359,10 +362,10 @@ class HobHandler(gobject.GObject):
         self.commands_async.append(self.SUB_BUILD_IMAGE)
         self.run_next_command(self.GENERATE_IMAGE)
 
-    def build_succeeded_async(self):
+    def build_succeeded_cb(self, running_build):
         self.building = False
 
-    def build_failed_async(self):
+    def build_failed_cb(self, running_build):
         self.initcmd = None
         self.commands_async = []
         self.building = False
-- 
1.7.6



