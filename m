Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SJ7rK-0008VI-6j
	for bitbake-devel@lists.openembedded.org;
	Sat, 14 Apr 2012 20:38:06 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 14 Apr 2012 11:28:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="132525454"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 14 Apr 2012 11:28:41 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 15 Apr 2012 02:58:59 +0800
Message-Id: <2ca4f63bf948765410a50e8ec1cffc79cec89664.1334429180.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <5aa3bc3f4cd72922ed3456eb995eb52cdff09beb.1334429179.git.shane.wang@intel.com>
References: <5aa3bc3f4cd72922ed3456eb995eb52cdff09beb.1334429179.git.shane.wang@intel.com>
In-Reply-To: <cover.1334429179.git.shane.wang@intel.com>
References: <cover.1334429179.git.shane.wang@intel.com>
Subject: [PATCH 2/2] Hob: reset user recipe selection and package selection after settings are changed
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
X-List-Received-Date: Sat, 14 Apr 2012 18:38:06 -0000

Reset user recipe list and package list after the user changes the settings and
triggers recipe reparsing.

This is to continue to fix the bug [Yocto #2255]

[Yocto #2255]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py                |   12 ++++++++----
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    4 +---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 5dd2b13..48053b3 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -60,9 +60,7 @@ class Configuration:
         # bblayers.conf
         self.layers = []
         # image/recipes/packages
-        self.selected_image = None
-        self.selected_recipes = []
-        self.selected_packages = []
+        self.clear_selection()
 
         self.user_selected_packages = []
 
@@ -73,6 +71,11 @@ class Configuration:
         self.git_proxy_host = self.git_proxy_port = ""
         self.cvs_proxy_host = self.cvs_proxy_port = ""
 
+    def clear_selection(self):
+        self.selected_image = None
+        self.selected_recipes = []
+        self.selected_packages = []
+
     def update(self, params):
         # settings
         self.curr_distro = params["distro"]
@@ -988,10 +991,11 @@ class Builder(gtk.Window):
         return response == gtk.RESPONSE_YES, settings_changed
 
     def reparse_post_adv_settings(self):
-        # DO reparse recipes
         if not self.configuration.curr_mach:
             self.update_config_async()
         else:
+            self.configuration.clear_selection()
+            # DO reparse recipes
             self.populate_recipe_package_info_async()
 
     def deploy_image(self, image_name):
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index 64c512d5..0463ee8 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -264,9 +264,7 @@ class ImageConfigurationPage (HobPage):
 
         self.builder.configuration.curr_mach = combo_item
         if self.machine_combo_changed_by_manual:
-            self.builder.configuration.selected_image = None
-            self.builder.configuration.selected_recipes = []
-            self.builder.configuration.selected_packages = []
+            self.builder.configuration.clear_selection()
         # reset machine_combo_changed_by_manual
         self.machine_combo_changed_by_manual = True
 
-- 
1.7.6



