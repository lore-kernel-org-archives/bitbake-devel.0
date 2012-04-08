Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SGp2e-0004cC-DA
	for bitbake-devel@lists.openembedded.org;
	Sun, 08 Apr 2012 12:08:16 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 08 Apr 2012 02:59:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="139106060"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2012 02:58:53 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  8 Apr 2012 18:21:10 +0800
Message-Id: <0c8edf4eec2e8fc6e8c81b56ccbfe521a9b3294f.1333880210.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333880210.git.shane.wang@intel.com>
References: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333880210.git.shane.wang@intel.com>
In-Reply-To: <cover.1333880210.git.shane.wang@intel.com>
References: <cover.1333880210.git.shane.wang@intel.com>
Subject: [PATCH 07/20] Hob: clean up and unify the steps for CONFIG_UPDATE to call update_config_async()
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
X-List-Received-Date: Sun, 08 Apr 2012 10:08:16 -0000

For the steps in CONFIG_UPDATE, the patch consolidates them into
update_config_async() to call.
consequently remove CONFIG_UPDATE since MACHINE_SELECTION covers it.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index ef6f182..6b8e9f3 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -212,7 +212,6 @@ class Parameters:
 class Builder(gtk.Window):
 
     (MACHINE_SELECTION,
-     CONFIG_UPDATED,
      RCPPKGINFO_POPULATING,
      RCPPKGINFO_POPULATED,
      BASEIMG_SELECTED,
@@ -225,7 +224,7 @@ class Builder(gtk.Window):
      IMAGE_GENERATED,
      MY_IMAGE_OPENED,
      BACK,
-     END_NOOP) = range(15)
+     END_NOOP) = range(14)
 
     (IMAGE_CONFIGURATION,
      RECIPE_DETAILS,
@@ -236,7 +235,6 @@ class Builder(gtk.Window):
 
     __step2page__ = {
         MACHINE_SELECTION     : IMAGE_CONFIGURATION,
-        CONFIG_UPDATED        : IMAGE_CONFIGURATION,
         RCPPKGINFO_POPULATING : IMAGE_CONFIGURATION,
         RCPPKGINFO_POPULATED  : IMAGE_CONFIGURATION,
         BASEIMG_SELECTED      : IMAGE_CONFIGURATION,
@@ -336,6 +334,11 @@ class Builder(gtk.Window):
         self.handler.set_extra_inherit("image_types")
         self.handler.parse_config()
 
+    def update_config_async(self):
+        self.switch_page(self.MACHINE_SELECTION)
+        self.set_user_config()
+        self.handler.parse_generate_configuration()
+
     def load_template(self, path):
         self.template = TemplateMgr()
         self.template.load(path)
@@ -345,7 +348,7 @@ class Builder(gtk.Window):
             if not os.path.exists(layer+'/conf/layer.conf'):
                 return False
 
-        self.switch_page(self.CONFIG_UPDATED)
+        self.update_config_async()
 
         self.template.destroy()
         self.template = None
@@ -373,12 +376,6 @@ class Builder(gtk.Window):
         if next_step == self.MACHINE_SELECTION: # init step
             self.image_configuration_page.show_machine()
 
-        elif next_step == self.CONFIG_UPDATED:
-            # after layers is changd by users
-            self.image_configuration_page.show_machine()
-            self.set_user_config()
-            self.handler.parse_generate_configuration()
-
         elif next_step == self.RCPPKGINFO_POPULATING:
             # MACHINE CHANGED action or SETTINGS CHANGED
             # show the progress bar
@@ -795,7 +792,7 @@ class Builder(gtk.Window):
             self.configuration.layers = dialog.layers
             # DO refresh layers
             if dialog.layers_changed:
-                self.switch_page(self.CONFIG_UPDATED)
+                self.update_config_async()
         dialog.destroy()
 
     def show_load_template_dialog(self):
@@ -886,7 +883,7 @@ class Builder(gtk.Window):
     def reparse_post_adv_settings(self):
         # DO reparse recipes
         if not self.configuration.curr_mach:
-            self.switch_page(self.CONFIG_UPDATED)
+            self.update_config_async()
         else:
             self.switch_page(self.RCPPKGINFO_POPULATING)
 
-- 
1.7.6



