Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SB6Gk-0005xL-0E
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Mar 2012 16:19:10 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 23 Mar 2012 08:10:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="124320006"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 23 Mar 2012 08:10:15 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Mar 2012 23:07:55 +0800
Message-Id: <a6862f6048888552cda9cefe6a68acce1ddbe46f.1332514895.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1332514895.git.dongxiao.xu@intel.com>
References: <cover.1332514895.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1332514895.git.dongxiao.xu@intel.com>
References: <cover.1332514895.git.dongxiao.xu@intel.com>
Subject: [PATCH 7/7] Hob: runqemu and deployment functionality filter
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
X-List-Received-Date: Fri, 23 Mar 2012 15:19:10 -0000

Implement the filter for runqemu and deployment functionality.

runqemu
1) suffix should be in the list of RUNNABLE_IMAGE_TYPES.
2) machine should match the pattern of RUNNABLE_MACHINE_PATTERNS.

deployment:
1) suffix should be in the list of DEPLOYMENT_IMAGE_TYPES.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py          |    3 ++
 lib/bb/ui/crumbs/hobeventhandler.py  |    4 +++
 lib/bb/ui/crumbs/imagedetailspage.py |   44 +++++++++++++++++++++++++--------
 3 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index d348497..2984490 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -135,6 +135,9 @@ class Parameters:
         self.image_names = []
         self.image_addr = params["image_addr"]
         self.image_types = params["image_types"].split()
+        self.runnable_image_types = params["runnable_image_types"].split()
+        self.runnable_machine_patterns = params["runnable_machine_patterns"].split()
+        self.deployable_image_types = params["deployable_image_types"].split()
 
 class Builder(gtk.Window):
 
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index ec3e0ef..4b8aabc 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -434,4 +434,8 @@ class HobHandler(gobject.GObject):
 
         params["conf_version"] = self.server.runCommand(["getVariable", "CONF_VERSION"]) or ""
         params["lconf_version"] = self.server.runCommand(["getVariable", "LCONF_VERSION"]) or ""
+
+        params["runnable_image_types"] = self.server.runCommand(["getVariable", "RUNNABLE_IMAGE_TYPES"]) or ""
+        params["runnable_machine_patterns"] = self.server.runCommand(["getVariable", "RUNNABLE_MACHINE_PATTERNS"]) or ""
+        params["deployable_image_types"] = self.server.runCommand(["getVariable", "DEPLOYABLE_IMAGE_TYPES"]) or ""
         return params
diff --git a/lib/bb/ui/crumbs/imagedetailspage.py b/lib/bb/ui/crumbs/imagedetailspage.py
index 07a6eb0..5a5ec3f 100755
--- a/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/lib/bb/ui/crumbs/imagedetailspage.py
@@ -183,7 +183,6 @@ class ImageDetailsPage (HobPage):
             self.image_store.set(self.image_store.append(), 0, image_name, 1, image_size, 2, False)
         image_table = HobViewTable(self.__columns__)
         image_table.set_model(self.image_store)
-        image_table.toggle_default()
         image_size = self._size_to_string(os.stat(os.path.join(image_addr, image_names[0])).st_size)
         image_table.connect("toggled", self.toggled_cb)
         view_files_button = gtk.LinkButton("file://%s" % image_addr, "View files")
@@ -256,6 +255,29 @@ class ImageDetailsPage (HobPage):
         model[path][columnid] = True
         self.refresh_package_detail_box(model[path][1])
 
+        type_runnable = False
+        mach_runnable = False
+        image_name = model[path][0]
+        for t in self.builder.parameters.runnable_image_types:
+            if image_name.endswith(t):
+                type_runnable = True
+                break
+
+        for t in self.builder.parameters.runnable_machine_patterns:
+            if t in image_name:
+                mach_runnable = True
+                break
+
+        self.run_button.set_sensitive(type_runnable and mach_runnable)
+
+        deployable = False
+        for t in self.builder.parameters.deployable_image_types:
+            if image_name.endswith(t):
+                deployable = True
+                break
+
+        self.deploy_button.set_sensitive(deployable)
+
     def create_bottom_buttons(self, buttonlist):
         # Create the buttons at the bottom
         bottom_buttons = gtk.HBox(False, 6)
@@ -264,13 +286,13 @@ class ImageDetailsPage (HobPage):
         # create button "Deploy image"
         name = "Deploy image"
         if name in buttonlist:
-            deploy_button = HobButton('Deploy image')
-            deploy_button.set_size_request(205, 49)
-            deploy_button.set_tooltip_text("Deploy image to get your target board")
-            deploy_button.set_flags(gtk.CAN_DEFAULT)
-            deploy_button.grab_default()
-            deploy_button.connect("clicked", self.deploy_button_clicked_cb)
-            bottom_buttons.pack_end(deploy_button, expand=False, fill=False)
+            self.deploy_button = HobButton('Deploy image')
+            self.deploy_button.set_size_request(205, 49)
+            self.deploy_button.set_tooltip_text("Deploy image to get your target board")
+            self.deploy_button.set_flags(gtk.CAN_DEFAULT)
+            self.deploy_button.grab_default()
+            self.deploy_button.connect("clicked", self.deploy_button_clicked_cb)
+            bottom_buttons.pack_end(self.deploy_button, expand=False, fill=False)
             created = True
 
         name = "Run image"
@@ -281,9 +303,9 @@ class ImageDetailsPage (HobPage):
                 bottom_buttons.pack_end(label, expand=False, fill=False)
 
             # create button "Run image"
-            run_button = HobAltButton("Run image")
-            run_button.connect("clicked", self.run_button_clicked_cb)
-            bottom_buttons.pack_end(run_button, expand=False, fill=False)
+            self.run_button = HobAltButton("Run image")
+            self.run_button.connect("clicked", self.run_button_clicked_cb)
+            bottom_buttons.pack_end(self.run_button, expand=False, fill=False)
             created = True
 
         name = "Save as template"
-- 
1.7.4.1



