Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R3Vob-0001jT-GS
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Sep 2011 18:26:29 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 13 Sep 2011 09:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,375,1312182000"; d="scan'208";a="50818018"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.59])
	by fmsmga001.fm.intel.com with ESMTP; 13 Sep 2011 09:21:16 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Sep 2011 09:21:07 -0700
Message-Id: <39ed18e70e9f3a13b522b4ea02bf6f4bdb7de89c.1315927921.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1315927921.git.josh@linux.intel.com>
References: <cover.1315927921.git.josh@linux.intel.com>
In-Reply-To: <cover.1315927921.git.josh@linux.intel.com>
References: <cover.1315927921.git.josh@linux.intel.com>
Subject: [PATCH 2/4] ui/crumbs/hobeventhandler: don't check BBPATH and BBFILES each build
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
X-List-Received-Date: Tue, 13 Sep 2011 16:26:29 -0000

There's no need to check the BBPATH and BBFILES are set correctly each
build when running multiple builds for one launch of the UI.

Partially addresses [YOCTO #1468]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobeventhandler.py |   39 ++++++++++++++++++-----------------
 1 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 4ed6590..8bf599f 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -77,6 +77,8 @@ class HobHandler(gobject.GObject):
         self.generating = False
         self.build_queue = []
         self.current_phase = None
+        self.bbpath_ok = False
+        self.bbfiles_ok = False
         self.image_dir = os.path.join(tempfile.gettempdir(), 'hob-images')
 
         self.model = taskmodel
@@ -247,6 +249,8 @@ class HobHandler(gobject.GObject):
 
     def build_image(self, image, configurator):
         targets = []
+        nbbp = None
+        nbbf = None
         targets.append(image)
         if self.build_toolchain and self.build_toolchain_headers:
             targets.append("meta-toolchain-sdk")
@@ -254,31 +258,28 @@ class HobHandler(gobject.GObject):
             targets.append("meta-toolchain")
         self.build_queue = targets
 
-        bbpath_ok = False
-        bbpath = self.server.runCommand(["getVariable", "BBPATH"])
-        if self.image_dir in bbpath.split(":"):
-            bbpath_ok = True
+        if not self.bbpath_ok:
+            bbpath = self.server.runCommand(["getVariable", "BBPATH"])
+            if self.image_dir in bbpath.split(":"):
+                self.bbpath_ok = True
+            else:
+                nbbp = self.image_dir
 
-        bbfiles_ok = False
-        bbfiles = self.server.runCommand(["getVariable", "BBFILES"]).split(" ")
-        for files in bbfiles:
+        if not self.bbfiles_ok:
             import re
             pattern = "%s/\*.bb" % self.image_dir
-            if re.match(pattern, files):
-                bbfiles_ok = True
-
-        if not bbpath_ok:
-            nbbp = self.image_dir
-        else:
-            nbbp = None
+            bbfiles = self.server.runCommand(["getVariable", "BBFILES"]).split(" ")
+            for files in bbfiles:
+                if re.match(pattern, files):
+                    self.bbfiles_ok = True
 
-        if not bbfiles_ok:
-            nbbf = "%s/*.bb" % self.image_dir
-        else:
-            nbbf = None
+            if not self.bbfiles_ok:
+                nbbf = "%s/*.bb" % self.image_dir
 
-        if not bbfiles_ok or not bbpath_ok:
+        if nbbp or nbbf:
             configurator.insertTempBBPath(nbbp, nbbf)
+            self.bbpath_ok = True
+            self.bbfiles_ok = True
 
         self.current_command = self.REPARSE_FILES
         self.run_next_command()
-- 
1.7.6



