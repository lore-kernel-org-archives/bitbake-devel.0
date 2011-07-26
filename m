Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qlmim-0003hd-GP
	for bitbake-devel@lists.openembedded.org;
	Tue, 26 Jul 2011 20:51:12 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 26 Jul 2011 11:46:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,270,1309762800"; d="scan'208";a="30353972"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.155])
	by orsmga002.jf.intel.com with ESMTP; 26 Jul 2011 11:46:52 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2011 11:46:36 -0700
Message-Id: <20f7218992cfe18f1d3dcea53f2e5a7bf96346db.1311705833.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311705833.git.josh@linux.intel.com>
References: <cover.1311705833.git.josh@linux.intel.com>
In-Reply-To: <cover.1311705833.git.josh@linux.intel.com>
References: <cover.1311705833.git.josh@linux.intel.com>
Subject: [PATCH 02/10] ui/crumbs/hobeventhandler: reparse files before running other commands
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
X-List-Received-Date: Tue, 26 Jul 2011 18:51:12 -0000

Integrate reparseFiles into the run_next_command() method rather than calling
reparseFiles on the server and immediately calling other methods.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobeventhandler.py |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 78a5090..d10c858 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -61,7 +61,7 @@ class HobHandler(gobject.GObject):
                                    gobject.TYPE_STRING)),
     }
 
-    (CFG_PATH_LOCAL, CFG_PATH_HOB, CFG_PATH_LAYERS, CFG_FILES_DISTRO, CFG_FILES_MACH, CFG_FILES_SDK, FILES_MATCH_CLASS, GENERATE_TGTS) = range(8)
+    (CFG_PATH_LOCAL, CFG_PATH_HOB, CFG_PATH_LAYERS, CFG_FILES_DISTRO, CFG_FILES_MACH, CFG_FILES_SDK, FILES_MATCH_CLASS, GENERATE_TGTS, REPARSE_FILES) = range(9)
 
     def __init__(self, taskmodel, server):
         gobject.GObject.__init__(self)
@@ -110,6 +110,9 @@ class HobHandler(gobject.GObject):
                 self.emit("data-generated")
                 self.generating = False
             self.current_command = None
+        elif self.current_command == self.REPARSE_FILES:
+            self.current_command = self.CFG_PATH_LAYERS
+            self.server.runCommand(["reparseFiles"])
 
     def handle_event(self, event, running_build, pbar):
         if not event:
@@ -195,8 +198,7 @@ class HobHandler(gobject.GObject):
         img = self.model.selected_image
         selected_packages, _ = self.model.get_selected_packages()
         self.emit("reload-triggered", img, " ".join(selected_packages))
-        self.server.runCommand(["reparseFiles"])
-        self.current_command = self.CFG_PATH_LAYERS
+        self.current_command = self.REPARSE_FILES
         self.run_next_command()
 
     def set_bbthreads(self, threads):
-- 
1.7.6



