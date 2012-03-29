Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SD3Oq-0007bo-Bu
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 02:39:36 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 28 Mar 2012 17:30:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="126325973"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.73])
	by orsmga002.jf.intel.com with ESMTP; 28 Mar 2012 17:30:30 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 28 Mar 2012 17:30:26 -0700
Message-Id: <ddd6cb69a1a15b74de348c44eabb1627d6fa72cd.1332980606.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332980606.git.josh@linux.intel.com>
References: <cover.1332980606.git.josh@linux.intel.com>
In-Reply-To: <cover.1332980606.git.josh@linux.intel.com>
References: <cover.1332980606.git.josh@linux.intel.com>
Subject: [PATCH 5/6] lib/bb/ui/crumbs: hob progress bar should not be red when user stops build
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
X-List-Received-Date: Thu, 29 Mar 2012 00:39:36 -0000

If the user explicitly stops the build telling them the build failed is a
misnomer.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/builddetailspage.py       |    2 +-
 lib/bb/ui/crumbs/builder.py                |   21 ++++++++++++++-------
 lib/bb/ui/crumbs/hig.py                    |    2 +-
 lib/bb/ui/crumbs/imageconfigurationpage.py |    2 +-
 lib/bb/ui/crumbs/progressbar.py            |    8 +++++---
 5 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/lib/bb/ui/crumbs/builddetailspage.py b/lib/bb/ui/crumbs/builddetailspage.py
index e8dbad7..d3d07d8 100755
--- a/lib/bb/ui/crumbs/builddetailspage.py
+++ b/lib/bb/ui/crumbs/builddetailspage.py
@@ -213,7 +213,7 @@ class BuildDetailsPage (HobPage):
         self.show_all()
         self.back_button.hide()
 
-    def update_progress_bar(self, title, fraction, status=True):
+    def update_progress_bar(self, title, fraction, status=None):
         self.progress_bar.update(fraction)
         self.progress_bar.set_title(title)
         self.progress_bar.set_rcstyle(status)
diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 1d203fe..3dccf06 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -608,13 +608,20 @@ class Builder(gtk.Window):
         self.stopping = False
 
     def build_failed(self):
-        if self.current_step == self.FAST_IMAGE_GENERATING:
-            fraction = 0.9
-        elif self.current_step == self.IMAGE_GENERATING:
-            fraction = 1.0
-        elif self.current_step == self.PACKAGE_GENERATING:
-            fraction = 1.0
-        self.build_details_page.update_progress_bar("Build Failed: ", fraction, False)
+        if self.stopping:
+            status = "stop"
+            message = "Build stopped: "
+            fraction = self.build_details_page.progress_bar.get_fraction()
+        else:
+            if self.current_step == self.FAST_IMAGE_GENERATING:
+                fraction = 0.9
+            elif self.current_step == self.IMAGE_GENERATING:
+                fraction = 1.0
+            elif self.current_step == self.PACKAGE_GENERATING:
+                fraction = 1.0
+            status = "fail"
+            message = "Build failed: "
+        self.build_details_page.update_progress_bar(message, fraction, status)
         self.build_details_page.show_back_button()
         self.build_details_page.hide_stop_button()
         self.handler.build_failed_async()
diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 4753c92..0ea5c0d 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -735,7 +735,7 @@ class DeployImageDialog (CrumbsDialog):
                 cmdline += "\"sudo dd if=" + self.image_path + " of=" + combo_item + "; bash\""
                 subprocess.Popen(args=shlex.split(cmdline))
 
-    def update_progress_bar(self, title, fraction, status=True):
+    def update_progress_bar(self, title, fraction, status=None):
         self.progress_bar.update(fraction)
         self.progress_bar.set_title(title)
         self.progress_bar.set_rcstyle(status)
diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index f66bcd6..d5aaf83 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -105,7 +105,7 @@ class ImageConfigurationPage (HobPage):
         self.set_config_machine_layout(show_progress_bar = False)
         self.show_all()
 
-    def update_progress_bar(self, title, fraction, status=True):
+    def update_progress_bar(self, title, fraction, status=None):
         self.progress_bar.update(fraction)
         self.progress_bar.set_title(title)
         self.progress_bar.set_rcstyle(status)
diff --git a/lib/bb/ui/crumbs/progressbar.py b/lib/bb/ui/crumbs/progressbar.py
index 882d461..f75818a 100644
--- a/lib/bb/ui/crumbs/progressbar.py
+++ b/lib/bb/ui/crumbs/progressbar.py
@@ -29,10 +29,12 @@ class HobProgressBar (gtk.ProgressBar):
     def set_rcstyle(self, status):
         rcstyle = gtk.RcStyle()
         rcstyle.fg[2] = gtk.gdk.Color(HobColors.BLACK)
-        if status:
-            rcstyle.bg[3] = gtk.gdk.Color(HobColors.RUNNING)
-        else:
+        if status == "stop":
+            rcstyle.bg[3] = gtk.gdk.Color(HobColors.WARNING)
+        elif status == "fail":
             rcstyle.bg[3] = gtk.gdk.Color(HobColors.ERROR)
+        else:
+            rcstyle.bg[3] = gtk.gdk.Color(HobColors.RUNNING)
         self.modify_style(rcstyle)
 
     def set_title(self, text=None):
-- 
1.7.7.6



