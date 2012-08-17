Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1T2Cj1-0003cT-St
	for bitbake-devel@lists.openembedded.org;
	Fri, 17 Aug 2012 04:55:52 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 16 Aug 2012 19:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,782,1336374000"; d="scan'208";a="187546233"
Received: from hp.sh.intel.com ([10.239.47.150])
	by orsmga002.jf.intel.com with ESMTP; 16 Aug 2012 19:42:37 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Aug 2012 10:47:46 +0800
Message-Id: <b14e108cb4b0b2d5d420a32b090ae43bef10a7b8.1345171604.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1345171604.git.limingx.l.an@intel.com>
References: <cover.1345171604.git.limingx.l.an@intel.com>
Subject: [PATCH 1/1] Hob: fixed the build image failure scenario
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
X-List-Received-Date: Fri, 17 Aug 2012 02:55:52 -0000

As ui design,
1)change the primary button always to 'Edit image',
2)change the title to 'Hob cannot build the packages' when build
packages failure occur,
3)make the page transfer to 'Issue'

[YOCTO #2183]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   14 ++++++--------
 bitbake/lib/bb/ui/crumbs/builder.py          |    3 ++-
 bitbake/lib/bb/ui/crumbs/hobwidget.py        |    2 +-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 30eab29..9700de0 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -199,9 +199,7 @@ class BuildDetailsPage (HobPage):
         for child in children:
             self.remove(child)
 
-    def add_build_fail_top_bar(self, actions, log_file=None):
-        primary_action = "Edit %s" % actions
-
+    def add_build_fail_top_bar(self, primary_action, log_file=None):
         self.notebook.set_page("Issues")
 
         color = HobColors.ERROR
@@ -228,7 +226,7 @@ class BuildDetailsPage (HobPage):
         build_fail_tab.attach(label, 4, 40, 4, 9)
 
         # create button 'Edit packages'
-        action_button = HobButton(primary_action)
+        action_button = HobButton('Edit image')
         action_button.set_size_request(-1, 40)
         action_button.connect('clicked', self.failure_primary_action_button_clicked_cb, primary_action)
         build_fail_tab.attach(action_button, 4, 13, 9, 12)
@@ -249,7 +247,7 @@ class BuildDetailsPage (HobPage):
 
     def show_fail_page(self, title, action_names):
         self._remove_all_widget()
-        self.title = "Hob cannot build your %s" % title
+        self.title = "Hob cannot build %s" % title
 
         self.build_fail_bar = self.add_build_fail_top_bar(action_names, self.builder.current_logfile)
 
@@ -318,11 +316,11 @@ class BuildDetailsPage (HobPage):
         self.config_tv.show(configurations, params)
 
     def failure_primary_action_button_clicked_cb(self, button, action):
-        if "Edit recipes" in action:
+        if "recipes" in action:
             self.builder.show_recipes()
-        elif "Edit packages" in action:
+        elif "packages" in action:
             self.builder.show_packages()
-        elif "Edit image configuration" in action:
+        elif "image configuration" in action:
             self.builder.show_configuration()
 
     def failure_open_log_button_clicked_cb(self, button, log_file):
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index cb2338e..2be363f 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -918,7 +918,8 @@ class Builder(gtk.Window):
             elif self.current_step == self.PACKAGE_GENERATING:
                 fail_to_next_edit = "recipes"
                 fraction = 1.0
-            self.build_details_page.show_fail_page(fail_to_next_edit.split(' ')[0], fail_to_next_edit)
+            title = "the packages" if (self.current_step == self.PACKAGE_GENERATING) else "your image"
+            self.build_details_page.show_fail_page(title, fail_to_next_edit)
             status = "fail"
             message = "Build failed: "
         self.build_details_page.update_progress_bar(message, fraction, status)
diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index d10c56b..9ccb01f 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -537,7 +537,7 @@ class HobNotebook(gtk.Notebook):
         for child in self.pages:
             if child.lbl.get_label() == title:
                 child.grab_focus()
-                self.set_current_page(self.page_num(child))
+                self.set_current_page(self.pages.index(child))
 
 class HobWarpCellRendererText(gtk.CellRendererText):
     def __init__(self, col_number):
-- 
1.7.5.4



