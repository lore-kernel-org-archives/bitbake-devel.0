Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QexHn-00015h-Pw
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jul 2011 00:43:07 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 07 Jul 2011 15:39:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,496,1304319600"; d="scan'208";a="24664405"
Received: from vorpal.jf.intel.com ([10.7.199.170])
	by orsmga001.jf.intel.com with ESMTP; 07 Jul 2011 15:39:13 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  7 Jul 2011 15:43:26 -0700
Message-Id: <740cf222cc3a76d7c088620c46b18779fb1c9b2e.1310078501.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1310078501.git.josh@linux.intel.com>
References: <cover.1310078501.git.josh@linux.intel.com>
In-Reply-To: <cover.1310078501.git.josh@linux.intel.com>
References: <cover.1310078501.git.josh@linux.intel.com>
Subject: [PATCH 2/3] lib/bb/hob: fix changing base image
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
X-List-Received-Date: Thu, 07 Jul 2011 22:43:08 -0000

The path is not guaranteed to always point to the same value so do not rely
on it to change the image contents. Further, when changing the base image
we should maintain user selections.

Addresses [YOCTO #1225] and fixes [YOCTO #1226]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index fca41e4..7647d21 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -50,7 +50,6 @@ class MainWindow (gtk.Window):
         self.model = taskmodel
         self.model.connect("tasklist-populated", self.update_model)
         self.model.connect("image-changed", self.image_changed_string_cb)
-        self.curr_image_path = None
         self.handler = handler
         self.configurator = configurator
         self.prefs = prefs
@@ -133,12 +132,13 @@ class MainWindow (gtk.Window):
         if it:
             path = model.get_path(it)
             # Firstly, deselect the previous image
-            if self.curr_image_path:
-                self.toggle_package(self.curr_image_path, model)
+            userp, _ = self.model.get_selected_packages()
+            self.model.reset()
             # Now select the new image and save its path in case we
             # change the image later
-            self.curr_image_path = path
             self.toggle_package(path, model, image=True)
+            if len(userp):
+                self.model.set_selected_packages(userp)
 
     def reload_triggered_cb(self, handler, image, packages):
         if image:
@@ -463,8 +463,8 @@ class MainWindow (gtk.Window):
         return False
 
     def toggle_package(self, path, model, image=False):
-        # Warn user before removing packages
         inc = model[path][self.model.COL_INC]
+        # Warn user before removing included packages
         if inc:
             pn = model[path][self.model.COL_NAME]
             revdeps = self.model.find_reverse_depends(pn)
-- 
1.7.6



