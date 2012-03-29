Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SDEDs-0007Ux-6M
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 14:13:00 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 29 Mar 2012 05:03:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="126516883"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 29 Mar 2012 05:03:55 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 20:01:16 +0800
Message-Id: <f8822788449d71fe690517650923a8e12223bd43.1333022081.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333022081.git.dongxiao.xu@intel.com>
References: <cover.1333022081.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333022081.git.dongxiao.xu@intel.com>
References: <cover.1333022081.git.dongxiao.xu@intel.com>
Subject: [PATCH 10/14] Hob: Remember user settings when reparse config
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
X-List-Received-Date: Thu, 29 Mar 2012 12:13:01 -0000

When config reparse is issued (e.x, adding a layer), we will firstly
remember the past user settings by setting them to bitbake server,
and then do the reparse.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py         |   13 +++++++------
 lib/bb/ui/crumbs/hobeventhandler.py |    8 +++-----
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 924529f..3ea9448 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -198,7 +198,7 @@ class Parameters:
 class Builder(gtk.Window):
 
     (MACHINE_SELECTION,
-     LAYER_CHANGED,
+     CONFIG_UPDATED,
      RCPPKGINFO_POPULATING,
      RCPPKGINFO_POPULATED,
      BASEIMG_SELECTED,
@@ -222,7 +222,7 @@ class Builder(gtk.Window):
 
     __step2page__ = {
         MACHINE_SELECTION     : IMAGE_CONFIGURATION,
-        LAYER_CHANGED         : IMAGE_CONFIGURATION,
+        CONFIG_UPDATED        : IMAGE_CONFIGURATION,
         RCPPKGINFO_POPULATING : IMAGE_CONFIGURATION,
         RCPPKGINFO_POPULATED  : IMAGE_CONFIGURATION,
         BASEIMG_SELECTED      : IMAGE_CONFIGURATION,
@@ -329,7 +329,7 @@ class Builder(gtk.Window):
             if not os.path.exists(layer+'/conf/layer.conf'):
                 return False
 
-        self.switch_page(self.LAYER_CHANGED)
+        self.switch_page(self.CONFIG_UPDATED)
 
         self.template.destroy()
         self.template = None
@@ -357,10 +357,11 @@ class Builder(gtk.Window):
         if next_step == self.MACHINE_SELECTION: # init step
             self.image_configuration_page.show_machine()
 
-        elif next_step == self.LAYER_CHANGED:
+        elif next_step == self.CONFIG_UPDATED:
             # after layers is changd by users
             self.image_configuration_page.show_machine()
-            self.handler.refresh_layers(self.configuration.layers)
+            self.set_user_config()
+            self.handler.parse_generate_configuration()
 
         elif next_step == self.RCPPKGINFO_POPULATING:
             # MACHINE CHANGED action or SETTINGS CHANGED
@@ -766,7 +767,7 @@ class Builder(gtk.Window):
             self.configuration.layers = dialog.layers
             # DO refresh layers
             if dialog.layers_changed:
-                self.switch_page(self.LAYER_CHANGED)
+                self.switch_page(self.CONFIG_UPDATED)
         dialog.destroy()
 
     def show_load_template_dialog(self):
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 6efb9b0..d1f36e62 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -243,11 +243,9 @@ class HobHandler(gobject.GObject):
         self.commands_async.append(self.SUB_PARSE_CONFIG)
         self.run_next_command(self.PARSE_CONFIG)
 
-    def refresh_layers(self, bblayers):
-        self.init_cooker()
-        self.set_bblayers(bblayers)
-        self.commands_async.append(self.SUB_PARSE_CONFIG)
-        self.generate_configuration()
+    def parse_generate_configuration(self):
+         self.commands_async.append(self.SUB_PARSE_CONFIG)
+         self.generate_configuration()
 
     def set_extra_inherit(self, bbclass):
         inherits = self.server.runCommand(["getVariable", "INHERIT"]) or ""
-- 
1.7.4.1



