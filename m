Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TTYZE-0002FP-U4
	for bitbake-devel@lists.openembedded.org;
	Wed, 31 Oct 2012 14:42:49 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 31 Oct 2012 06:29:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,687,1344236400"; d="scan'208";a="211732997"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by azsmga001.ch.intel.com with ESMTP; 31 Oct 2012 06:29:09 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 31 Oct 2012 15:31:07 +0200
Message-Id: <1351690267-6126-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: providing details about process state through porgress bar
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
X-List-Received-Date: Wed, 31 Oct 2012 13:42:49 -0000

-small changes to the text of the progress bar when parsing recipes

[YOCTO #3282]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py                |   15 +++++----------
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py        |    6 +++---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    2 +-
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index e5222da..ecf5371 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -947,10 +947,10 @@ class Builder(gtk.Window):
         self.package_details_page.refresh_selection()
 
     def handler_recipe_populated_cb(self, handler):
-        self.image_configuration_page.update_progress_bar("Populated recipes", 0.99)
+        self.image_configuration_page.update_progress_bar("Populating recipes", 0.99)
 
     def handler_package_populated_cb(self, handler):
-        self.image_configuration_page.update_progress_bar("Populated packages", 1.0)
+        self.image_configuration_page.update_progress_bar("Populating packages", 1.0)
 
     def handler_parsing_started_cb(self, handler, message):
         if self.current_step != self.RCPPKGINFO_POPULATING:
@@ -960,12 +960,9 @@ class Builder(gtk.Window):
         if message["eventname"] == "TreeDataPreparationStarted":
             fraction = 0.6 + fraction
             self.image_configuration_page.stop_button.set_sensitive(False)
-        else:
-            self.image_configuration_page.stop_button.set_sensitive(True)
-
-        if message["eventname"] == "TreeDataPreparationProgress":
             self.image_configuration_page.update_progress_bar("Generating dependency tree", fraction)
         else:
+            self.image_configuration_page.stop_button.set_sensitive(True)
             self.image_configuration_page.update_progress_bar(message["title"], fraction)
 
     def handler_parsing_cb(self, handler, message):
@@ -975,11 +972,9 @@ class Builder(gtk.Window):
         fraction = message["current"] * 1.0/message["total"]
         if message["eventname"] == "TreeDataPreparationProgress":
             fraction = 0.6 + 0.38 * fraction
+            self.image_configuration_page.update_progress_bar("Generating dependency tree", fraction)
         else:
             fraction = 0.6 * fraction
-        if message["eventname"] == "TreeDataPreparationProgress":
-            self.image_configuration_page.update_progress_bar("Generating dependency tree", fraction)
-        else: 
             self.image_configuration_page.update_progress_bar(message["title"], fraction)
 
     def handler_parsing_completed_cb(self, handler, message):
@@ -990,7 +985,7 @@ class Builder(gtk.Window):
             fraction = 0.98
         else:
             fraction = 0.6
-        self.image_configuration_page.update_progress_bar(message["title"], fraction)
+        self.image_configuration_page.update_progress_bar("Generating dependency tree", fraction)
 
     def handler_build_started_cb(self, running_build):
         if self.current_step == self.FAST_IMAGE_GENERATING:
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 7d3af6c..350b00b 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -243,7 +243,7 @@ class HobHandler(gobject.GObject):
             message["eventname"] = bb.event.getName(event)
             message["current"] = 0
             message["total"] = None
-            message["title"] = "Parsing recipes: "
+            message["title"] = "Parsing recipes"
             self.emit("parsing-started", message)
         elif isinstance(event, (bb.event.ParseProgress,
                 bb.event.CacheLoadProgress,
@@ -252,7 +252,7 @@ class HobHandler(gobject.GObject):
             message["eventname"] = bb.event.getName(event)
             message["current"] = event.current
             message["total"] = event.total
-            message["title"] = "Parsing recipes: "
+            message["title"] = "Parsing recipes"
             self.emit("parsing", message)
         elif isinstance(event, (bb.event.ParseCompleted,
                 bb.event.CacheLoadCompleted,
@@ -261,7 +261,7 @@ class HobHandler(gobject.GObject):
             message["eventname"] = bb.event.getName(event)
             message["current"] = event.total
             message["total"] = event.total
-            message["title"] = "Parsing recipes: "
+            message["title"] = "Parsing recipes"
             self.emit("parsing-completed", message)
         elif isinstance(event, bb.event.NetworkTestFailed):
             self.emit("network-failed")
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index 660319a..b94f35c 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -117,7 +117,7 @@ class ImageConfigurationPage (HobPage):
     def update_progress_bar(self, title, fraction, status=None):
         if self.stopping == False:
             self.progress_bar.update(fraction)
-            self.progress_bar.set_title(title)
+            self.progress_bar.set_text(title)
             self.progress_bar.set_rcstyle(status)
 
     def show_info_populating(self):
-- 
1.7.9.5



