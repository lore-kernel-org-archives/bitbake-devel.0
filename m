Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SHFFV-00007r-BU
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 16:07:17 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 09 Apr 2012 06:57:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="128716916"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by azsmga001.ch.intel.com with ESMTP; 09 Apr 2012 06:57:45 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Apr 2012 22:13:51 +0800
Message-Id: <db35457308bb67790938ed634e1307dd51f2028e.1333980506.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
References: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
In-Reply-To: <cover.1333980504.git.shane.wang@intel.com>
References: <cover.1333980504.git.shane.wang@intel.com>
Subject: [PATCH 21/21] Hob:Fixed some incorrect values of Build configuration tab
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
X-List-Received-Date: Mon, 09 Apr 2012 14:07:17 -0000

From: Liming An <limingx.l.an@intel.com>

Because some variables not be updated when building started, so add them
to the updating function of configuration class, and add reset function of
configurate treeview of building detail page

[YOCTO #2244]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   20 ++++++++++++--------
 bitbake/lib/bb/ui/crumbs/builder.py          |   14 +++++++-------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index cd4413b..23aaacd 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -81,16 +81,16 @@ class BuildConfigurationTreeView(gtk.TreeView):
         # renew the tree model after get the configuration messages
         self.set_model(listmodel)
 
-    def show(self, src_config_info, src_params):
+    def show(self, src_config_info):
         vars = []
-        vars.append(self.set_vars("BB version:", src_params.bb_version))
-        vars.append(self.set_vars("Target arch:", src_params.target_arch))
-        vars.append(self.set_vars("Target OS:", src_params.target_os))
+        vars.append(self.set_vars("BB version:", src_config_info.bb_version))
+        vars.append(self.set_vars("Target arch:", src_config_info.target_arch))
+        vars.append(self.set_vars("Target OS:", src_config_info.target_os))
         vars.append(self.set_vars("Machine:", src_config_info.curr_mach))
         vars.append(self.set_vars("Distro:", src_config_info.curr_distro))
-        vars.append(self.set_vars("Distro version:", src_params.distro_version))
+        vars.append(self.set_vars("Distro version:", src_config_info.distro_version))
         vars.append(self.set_vars("SDK machine:", src_config_info.curr_sdk_machine))
-        vars.append(self.set_vars("Tune feature:", src_params.tune_pkgarch))
+        vars.append(self.set_vars("Tune feature:", src_config_info.tune_pkgarch))
         vars.append(self.set_vars("Layers:", src_config_info.layers))
 
         for path in src_config_info.layers:
@@ -105,6 +105,9 @@ class BuildConfigurationTreeView(gtk.TreeView):
 
         self.set_config_model(vars)
 
+    def reset(self):
+        self.set_model(None)
+
 #
 # BuildDetailsPage
 #
@@ -208,6 +211,7 @@ class BuildDetailsPage (HobPage):
         self.box_group_area.pack_start(self.vbox, expand=True, fill=True)
 
         self.progress_bar.reset()
+        self.config_tv.reset()
         self.vbox.pack_start(self.progress_box, expand=False, fill=False)
 
         self.vbox.pack_start(self.notebook, expand=True, fill=True)
@@ -244,5 +248,5 @@ class BuildDetailsPage (HobPage):
                 if (v_adj.upper <= v_adj.page_size) or (v_adj.value == v_adj.upper - v_adj.page_size):
                     treeview.scroll_to_cell(path)
 
-    def show_configurations(self, configurations, params):
-        self.config_tv.show(configurations, params)
+    def show_configurations(self, configurations):
+        self.config_tv.show(configurations)
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 9e2495a..c0f4873 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -96,6 +96,12 @@ class Configuration:
         self.conf_version = params["conf_version"]
         self.lconf_version = params["lconf_version"]
         self.image_fstypes = params["image_fstypes"]
+        self.tune_arch = params["tune_arch"]
+        self.bb_version = params["bb_version"]
+        self.target_arch = params["target_arch"]
+        self.target_os = params["target_os"]
+        self.distro_version = params["distro_version"]
+        self.tune_pkgarch = params["tune_pkgarch"]
         # bblayers.conf
         self.layers = params["layer"].split()
 
@@ -201,12 +207,6 @@ class Parameters:
         self.runnable_machine_patterns = params["runnable_machine_patterns"].split()
         self.deployable_image_types = params["deployable_image_types"].split()
         self.tmpdir = params["tmpdir"]
-        self.distro_version = params["distro_version"]
-        self.target_os = params["target_os"]
-        self.target_arch = params["target_arch"]
-        self.tune_pkgarch = params["tune_pkgarch"]
-        self.bb_version = params["bb_version"]
-        self.tune_arch = params["tune_arch"]
         self.enable_proxy = False
 
 class Builder(gtk.Window):
@@ -653,7 +653,7 @@ class Builder(gtk.Window):
         elif self.current_step == self.PACKAGE_GENERATING:
             fraction = 0
         self.build_details_page.update_progress_bar("Build Started: ", fraction)
-        self.build_details_page.show_configurations(self.configuration, self.parameters)
+        self.build_details_page.show_configurations(self.configuration)
 
     def build_succeeded(self):
         if self.current_step == self.FAST_IMAGE_GENERATING:
-- 
1.7.6



