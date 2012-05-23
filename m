Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SXCu8-0005La-8a
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 16:51:12 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 23 May 2012 07:41:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="170400228"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 23 May 2012 07:40:59 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 May 2012 23:19:44 +0800
Message-Id: <13678628889560c06a747df22ae496772b27f604.1337786155.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1337786155.git.shane.wang@intel.com>
References: <cover.1337786155.git.shane.wang@intel.com>
Subject: [PATCH 1/1] Hob: Adjust the progress bar and set 100% only when all is done.
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
X-List-Received-Date: Wed, 23 May 2012 14:51:12 -0000

After parsing recipes, Hob will populate recipes and packages, which is probably
time exhaused. So, this patch is to adjust the progress bar and ensure 100% is
set if and only if all populations are done.

The patch also fixes "weird 18 second delay when parsing recipes" on build appliance.
Because Hob is doing something, but the progress bar shows 100% and wait there.

[Yocto #2341]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py         |   12 ++++++++++--
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    8 ++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 44d626c..c77272e 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -424,6 +424,8 @@ class Builder(gtk.Window):
         self.handler.connect("data-generated",           self.handler_data_generated_cb)
         self.handler.connect("command-succeeded",        self.handler_command_succeeded_cb)
         self.handler.connect("command-failed",           self.handler_command_failed_cb)
+        self.handler.connect("recipe-populated",         self.handler_recipe_populated_cb)
+        self.handler.connect("package-populated",        self.handler_package_populated_cb)
 
         self.handler.set_config_filter(hob_conf_filter)
 
@@ -773,6 +775,12 @@ class Builder(gtk.Window):
     def packagelist_changed_cb(self, package_model):
         self.package_details_page.refresh_selection()
 
+    def handler_recipe_populated_cb(self, handler):
+        self.image_configuration_page.update_progress_bar("Populated recipes", 0.99)
+
+    def handler_package_populated_cb(self, handler):
+        self.image_configuration_page.update_progress_bar("Populated packages", 1.0)
+
     def handler_parsing_started_cb(self, handler, message):
         if self.current_step != self.RCPPKGINFO_POPULATING:
             return
@@ -792,7 +800,7 @@ class Builder(gtk.Window):
 
         fraction = message["current"] * 1.0/message["total"]
         if message["eventname"] == "TreeDataPreparationProgress":
-            fraction = 0.6 + 0.4 * fraction
+            fraction = 0.6 + 0.38 * fraction
         else:
             fraction = 0.6 * fraction
         self.image_configuration_page.update_progress_bar(message["title"], fraction)
@@ -802,7 +810,7 @@ class Builder(gtk.Window):
             return
 
         if message["eventname"] == "TreeDataPreparationCompleted":
-            fraction = 1.0
+            fraction = 0.98
         else:
             fraction = 0.6
         self.image_configuration_page.update_progress_bar(message["title"], fraction)
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 7303ff8..b34bdbe 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -57,6 +57,12 @@ class HobHandler(gobject.GObject):
          "parsing-completed"       : (gobject.SIGNAL_RUN_LAST,
                                       gobject.TYPE_NONE,
                                      (gobject.TYPE_PYOBJECT,)),
+         "recipe-populated"        : (gobject.SIGNAL_RUN_LAST,
+                                      gobject.TYPE_NONE,
+                                     ()),
+         "package-populated"       : (gobject.SIGNAL_RUN_LAST,
+                                      gobject.TYPE_NONE,
+                                     ()),
     }
 
     (GENERATE_CONFIGURATION, GENERATE_RECIPES, GENERATE_PACKAGES, GENERATE_IMAGE, POPULATE_PACKAGEINFO, SANITY_CHECK) = range(6)
@@ -158,6 +164,7 @@ class HobHandler(gobject.GObject):
 
         if isinstance(event, bb.event.PackageInfo):
             self.package_model.populate(event._pkginfolist)
+            self.emit("package-populated")
             self.run_next_command()
 
         elif isinstance(event, bb.event.SanityCheckPassed):
@@ -171,6 +178,7 @@ class HobHandler(gobject.GObject):
             self.current_phase = "data generation"
             if event._model:
                 self.recipe_model.populate(event._model)
+                self.emit("recipe-populated")
         elif isinstance(event, bb.event.ConfigFilesFound):
             self.current_phase = "configuration lookup"
             var = event._variable
-- 
1.7.6



