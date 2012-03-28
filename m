Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SCvan-0005xg-Re
	for bitbake-devel@lists.openembedded.org;
	Wed, 28 Mar 2012 18:19:26 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 28 Mar 2012 09:10:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="147020203"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 28 Mar 2012 09:10:22 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 00:36:55 +0800
Message-Id: <8cfef83ce72c248c1d0f5d92d02de4f07376a32b.1332952559.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <ba0cac313670c2e9f5c77d04e1eb07ef3aec9352.1332952559.git.shane.wang@intel.com>
References: <ba0cac313670c2e9f5c77d04e1eb07ef3aec9352.1332952559.git.shane.wang@intel.com>
In-Reply-To: <cover.1332952559.git.shane.wang@intel.com>
References: <cover.1332952559.git.shane.wang@intel.com>
Subject: [PATCH 2/5] Hob: change some words for build configurations on build details screen
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
X-List-Received-Date: Wed, 28 Mar 2012 16:19:26 -0000

This patch is to change some words of variables to make them consistent with the GUI.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index e8dbad7..abbee4c 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -83,15 +83,15 @@ class BuildConfigurationTreeView(gtk.TreeView):
 
     def show(self, src_config_info, src_params):
         vars = []
-        vars.append(self.set_vars("BB VERSION:", src_params.bb_version))
-        vars.append(self.set_vars("TARGET_ARCH:", src_params.target_arch))
-        vars.append(self.set_vars("TARGET_OS:", src_params.target_os))
-        vars.append(self.set_vars("MACHINE:", src_config_info.curr_mach))
-        vars.append(self.set_vars("DISTRO:", src_config_info.curr_distro))
-        vars.append(self.set_vars("DISTRO_VERSION:", src_params.distro_version))
-        vars.append(self.set_vars("SDK_MACHINE:", src_config_info.curr_sdk_machine))
-        vars.append(self.set_vars("TUNE_FEATURE:", src_params.tune_pkgarch))
-        vars.append(self.set_vars("LAYERS:", src_config_info.layers))
+        vars.append(self.set_vars("BB version:", src_params.bb_version))
+        vars.append(self.set_vars("Target arch:", src_params.target_arch))
+        vars.append(self.set_vars("Target OS:", src_params.target_os))
+        vars.append(self.set_vars("Machine:", src_config_info.curr_mach))
+        vars.append(self.set_vars("Distro:", src_config_info.curr_distro))
+        vars.append(self.set_vars("Distro version:", src_params.distro_version))
+        vars.append(self.set_vars("SDK machine:", src_config_info.curr_sdk_machine))
+        vars.append(self.set_vars("Tune feature:", src_params.tune_pkgarch))
+        vars.append(self.set_vars("Layers:", src_config_info.layers))
 
         for path in src_config_info.layers:
             import os, os.path
@@ -99,7 +99,7 @@ class BuildConfigurationTreeView(gtk.TreeView):
                 f = os.popen('cd %s; git branch 2>&1 | grep "^* " | tr -d "* "' % path)
                 if f:
                     branch = f.readline().lstrip('\n').rstrip('\n')
-                    vars.append(self.set_vars("BRANCH:", branch))
+                    vars.append(self.set_vars("Branch:", branch))
                     f.close()
                 break
 
@@ -140,7 +140,7 @@ class BuildDetailsPage (HobPage):
         self.scrolled_view_config = gtk.ScrolledWindow ()
         self.scrolled_view_config.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
         self.scrolled_view_config.add(self.config_tv)
-        self.notebook.append_page(self.scrolled_view_config, gtk.Label("Build Configuration"))
+        self.notebook.append_page(self.scrolled_view_config, gtk.Label("Build configuration"))
 
         self.failure_tv = BuildFailureTreeView()
         self.failure_model = self.builder.handler.build.model.failure_model()
-- 
1.7.6



