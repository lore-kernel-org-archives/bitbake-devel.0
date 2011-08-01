Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QnxG7-0001pg-2k
	for bitbake-devel@lists.openembedded.org;
	Mon, 01 Aug 2011 20:30:35 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 01 Aug 2011 11:26:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,301,1309762800"; d="scan'208";a="34344104"
Received: from vorpal.jf.intel.com ([10.7.199.75])
	by orsmga001.jf.intel.com with ESMTP; 01 Aug 2011 11:26:12 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  1 Aug 2011 11:30:45 -0700
Message-Id: <b6f6edd5090e933ac97a65f93ea9d1b255fca811.1312216779.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312216779.git.josh@linux.intel.com>
References: <cover.1312216779.git.josh@linux.intel.com>
In-Reply-To: <cover.1312216779.git.josh@linux.intel.com>
References: <cover.1312216779.git.josh@linux.intel.com>
Subject: [PATCH 3/8] ui/crumbs/hobeventhandler: emit a signal when there's a fatal-error
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
X-List-Received-Date: Mon, 01 Aug 2011 18:30:35 -0000

If the cooker encounters an error we're unable to proceed so emit a signal
so that UI's can notify the user and exit.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobeventhandler.py |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index cccb8ad..1163cba 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -19,6 +19,7 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import gobject
+import logging
 
 progress_total = 0
 
@@ -49,8 +50,10 @@ class HobHandler(gobject.GObject):
          "data-generated"      : (gobject.SIGNAL_RUN_LAST,
                                   gobject.TYPE_NONE,
                                   ()),
-         "error"               : (gobject.SIGNAL_RUN_LAST,
+         "fatal-error"         : (gobject.SIGNAL_RUN_LAST,
                                   gobject.TYPE_NONE,
+                                  (gobject.TYPE_STRING,
+                                   gobject.TYPE_STRING,)),
                                   (gobject.TYPE_STRING,)),
          "reload-triggered"    : (gobject.SIGNAL_RUN_LAST,
                                   gobject.TYPE_NONE,
@@ -69,6 +72,7 @@ class HobHandler(gobject.GObject):
         self.build_toolchain_headers = False
         self.generating = False
         self.build_queue = []
+        self.current_phase = None
 
         self.model = taskmodel
         self.server = server
@@ -127,11 +131,14 @@ class HobHandler(gobject.GObject):
 
         # If we're running a build, use the RunningBuild event handler
         if self.building:
+            self.current_phase = "building"
             running_build.handle_event(event)
         elif isinstance(event, bb.event.TargetsTreeGenerated):
+            self.current_phase = "data generation"
             if event._model:
                 self.model.populate(event._model)
         elif isinstance(event, bb.event.ConfigFilesFound):
+            self.current_phase = "configuration lookup"
             var = event._variable
 	    if var == "distro":
 		distros = event._values
@@ -146,9 +153,11 @@ class HobHandler(gobject.GObject):
                 sdk_machines.sort()
                 self.emit("sdk-machines-updated", sdk_machines)
         elif isinstance(event, bb.event.ConfigFilePathFound):
+            self.current_phase = "configuration lookup"
             path = event._path
             self.emit("config-found", path)
         elif isinstance(event, bb.event.FilesMatchingFound):
+            self.current_phase = "configuration lookup"
             # FIXME: hard coding, should at least be a variable shared between
             # here and the caller
             if event._pattern == "rootfs_":
@@ -160,25 +169,35 @@ class HobHandler(gobject.GObject):
                 formats.sort()
                 self.emit("package-formats-found", formats)
         elif isinstance(event, bb.command.CommandCompleted):
+            self.current_phase = None
             self.run_next_command()
         elif isinstance(event, bb.command.CommandFailed):
-            self.emit("error", event.error)
         elif isinstance(event, bb.event.CacheLoadStarted):
+            self.current_phase = "cache loading"
             bb.ui.crumbs.hobeventhandler.progress_total = event.total
             pbar.set_text("Loading cache: %s/%s" % (0, bb.ui.crumbs.hobeventhandler.progress_total))
         elif isinstance(event, bb.event.CacheLoadProgress):
+            self.current_phase = "cache loading"
             pbar.set_text("Loading cache: %s/%s" % (event.current, bb.ui.crumbs.hobeventhandler.progress_total))
         elif isinstance(event, bb.event.CacheLoadCompleted):
+            self.current_phase = None
             pbar.set_text("Loading cache: %s/%s" % (bb.ui.crumbs.hobeventhandler.progress_total, bb.ui.crumbs.hobeventhandler.progress_total))
         elif isinstance(event, bb.event.ParseStarted):
+            self.current_phase = "recipe parsing"
             if event.total == 0:
                 return
             bb.ui.crumbs.hobeventhandler.progress_total = event.total
             pbar.set_text("Processing recipes: %s/%s" % (0, bb.ui.crumbs.hobeventhandler.progress_total))
         elif isinstance(event, bb.event.ParseProgress):
+            self.current_phase = "recipe parsing"
             pbar.set_text("Processing recipes: %s/%s" % (event.current, bb.ui.crumbs.hobeventhandler.progress_total))
         elif isinstance(event, bb.event.ParseCompleted):
+            self.current_phase = None
             pbar.set_fraction(1.0)
+        elif isinstance(event, logging.LogRecord):
+            format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
+            if event.levelno >= format.CRITICAL:
+                self.emit("fatal-error", event.getMessage(), self.current_phase)
         return
 
     def event_handle_idle_func (self, eventHandler, running_build, pbar):
-- 
1.7.6



