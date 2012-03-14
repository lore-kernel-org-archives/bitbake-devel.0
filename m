Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S7keG-0008H6-99
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Mar 2012 10:37:36 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 14 Mar 2012 02:28:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="117553618"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 14 Mar 2012 02:28:49 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Mar 2012 17:26:41 +0800
Message-Id: <b336abc11268177d4030f526384819717b43d2ce.1331716896.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1331716896.git.dongxiao.xu@intel.com>
References: <cover.1331716896.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1331716896.git.dongxiao.xu@intel.com>
References: <cover.1331716896.git.dongxiao.xu@intel.com>
Subject: [PATCH 10/11] Hob: Add stop button for parsing progress
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
X-List-Received-Date: Wed, 14 Mar 2012 09:37:36 -0000

Add a Stop button to allow user to quit the parsing process.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py                |   22 +++++++++++++++++++++-
 lib/bb/ui/crumbs/hobeventhandler.py        |    3 +++
 lib/bb/ui/crumbs/imageconfigurationpage.py |   14 +++++++++++++-
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 1363475..1d255ac 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -443,7 +443,20 @@ class Builder(gtk.Window):
         self.switch_page(self.MACHINE_SELECTION)
 
     def window_sensitive(self, sensitive):
-        self.set_sensitive(sensitive)
+        self.image_configuration_page.machine_combo.set_sensitive(sensitive)
+        self.image_configuration_page.image_combo.set_sensitive(sensitive)
+        self.image_configuration_page.layer_button.set_sensitive(sensitive)
+        self.image_configuration_page.layer_info_icon.set_sensitive(sensitive)
+        self.image_configuration_page.toolbar.set_sensitive(sensitive)
+        self.image_configuration_page.view_recipes_button.set_sensitive(sensitive)
+        self.image_configuration_page.view_packages_button.set_sensitive(sensitive)
+        self.image_configuration_page.config_build_button.set_sensitive(sensitive)
+
+        self.recipe_details_page.set_sensitive(sensitive)
+        self.package_details_page.set_sensitive(sensitive)
+        self.build_details_page.set_sensitive(sensitive)
+        self.image_details_page.set_sensitive(sensitive)
+
         if sensitive:
             self.get_root_window().set_cursor(gtk.gdk.Cursor(gtk.gdk.LEFT_PTR))
         else:
@@ -482,6 +495,10 @@ class Builder(gtk.Window):
         fraction = 0
         if message["eventname"] == "TreeDataPreparationStarted":
             fraction = 0.6 + fraction
+            self.image_configuration_page.stop_button.set_sensitive(False)
+        else:
+            self.image_configuration_page.stop_button.set_sensitive(True)
+
         self.image_configuration_page.update_progress_bar(message["title"], fraction)
 
     def handler_parsing_cb(self, handler, message):
@@ -836,6 +853,9 @@ class Builder(gtk.Window):
     def show_configuration(self):
         self.switch_page(self.BASEIMG_SELECTED)
 
+    def stop_parse(self):
+        self.handler.cancel_parse()
+
     def stop_build(self):
         if self.stopping:
             lbl = "<b>Force Stop build?</b>\nYou've already selected Stop once,"
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index cd25754..790e2ef 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -371,6 +371,9 @@ class HobHandler(gobject.GObject):
         self.commands_async = []
         self.building = False
 
+    def cancel_parse(self):
+        self.server.runCommand(["stateStop"])
+
     def cancel_build(self, force=False):
         if force:
             # Force the cooker to stop as quickly as possible
diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index f386281..2af9054 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -150,7 +150,13 @@ class ImageConfigurationPage (HobPage):
         markup += "poky-ref-manual.html#usingpoky-changes-layers\">reference manual</a>."
         self.layer_info_icon = HobInfoButton(markup, self.get_parent())
 
+        self.progress_box = gtk.HBox(False, 5)
         self.progress_bar = HobProgressBar()
+        self.progress_box.pack_start(self.progress_bar, expand=True, fill=True)
+        self.stop_button = gtk.LinkButton("Stop the parsing process", "Stop")
+        self.stop_button.connect("clicked", self.stop_button_clicked_cb)
+        self.progress_box.pack_end(self.stop_button, expand=False, fill=False)
+
         self.machine_separator = gtk.HSeparator()
 
     def set_config_machine_layout(self, show_progress_bar = False):
@@ -160,7 +166,7 @@ class ImageConfigurationPage (HobPage):
         self.gtable.attach(self.layer_button, 12, 36, 6, 10)
         self.gtable.attach(self.layer_info_icon, 36, 40, 6, 9)
         if show_progress_bar == True:
-            self.gtable.attach(self.progress_bar, 0, 40, 13, 17)
+            self.gtable.attach(self.progress_box, 0, 40, 13, 17)
         self.gtable.attach(self.machine_separator, 0, 40, 12, 13)
 
     def create_config_baseimg(self):
@@ -242,8 +248,14 @@ class ImageConfigurationPage (HobPage):
 
         return button_box
 
+    def stop_button_clicked_cb(self, button):
+        self.builder.stop_parse()
+
     def machine_combo_changed_cb(self, machine_combo):
         combo_item = machine_combo.get_active_text()
+        if not combo_item:
+            return
+
         self.builder.configuration.curr_mach = combo_item
         # Do reparse recipes
         self.builder.switch_page(self.builder.RCPPKGINFO_POPULATING)
-- 
1.7.4.1



