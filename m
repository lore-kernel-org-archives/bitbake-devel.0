Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QnxG7-0001pg-Sp
	for bitbake-devel@lists.openembedded.org;
	Mon, 01 Aug 2011 20:30:36 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 01 Aug 2011 11:26:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,301,1309762800"; d="scan'208";a="34344102"
Received: from vorpal.jf.intel.com ([10.7.199.75])
	by orsmga001.jf.intel.com with ESMTP; 01 Aug 2011 11:26:12 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  1 Aug 2011 11:30:43 -0700
Message-Id: <b1b02d523c6281615b72255774ed455b4cae4847.1312216779.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312216779.git.josh@linux.intel.com>
References: <cover.1312216779.git.josh@linux.intel.com>
In-Reply-To: <cover.1312216779.git.josh@linux.intel.com>
References: <cover.1312216779.git.josh@linux.intel.com>
Subject: [PATCH 1/8] ui/crumbs/hobeventhandler: remove unused code
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
X-List-Received-Date: Mon, 01 Aug 2011 18:30:36 -0000

Remove some unused variables and methods.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobeventhandler.py |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index c6ac7d5..cccb8ad 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -117,8 +117,6 @@ class HobHandler(gobject.GObject):
             if self.generating:
                 self.emit("data-generated")
                 self.generating = False
-            bbpath = self.server.runCommand(["getVariable", "BBPATH"])
-            bbfiles = self.server.runCommand(["getVariable", "BBFILES"])
             self.server.runCommand(["buildTargets", self.build_queue, "build"])
             self.build_queue = []
             self.current_command = None
@@ -279,22 +277,6 @@ class HobHandler(gobject.GObject):
         if self.build_toolchain_headers != enabled:
             self.build_toolchain_headers = enabled
 
-    def queue_image_recipe_path(self, path):
-        self.build_queue.append(path)
-
-    def build_complete_cb(self, running_build):
-        if len(self.build_queue) > 0:
-            next = self.build_queue.pop(0)
-            if next.endswith('.bb'):
-                self.build_file(next)
-                self.building = 'image'
-                self.build_file(next)
-            else:
-                self.build_packages(next.split(" "))
-        else:
-            self.building = None
-            self.emit("build-complete")
-
     def set_fstypes(self, fstypes):
         self.server.runCommand(["setVariable", "IMAGE_FSTYPES", fstypes])
 
-- 
1.7.6



