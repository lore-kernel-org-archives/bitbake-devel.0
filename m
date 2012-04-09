Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SHF5j-0007rg-RW
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 15:57:12 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 09 Apr 2012 06:47:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="126873924"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 09 Apr 2012 06:47:56 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Apr 2012 22:13:36 +0800
Message-Id: <0dc83006e19fe1ada319ea3eec95fa31ff6c1ef6.1333980505.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
References: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
In-Reply-To: <cover.1333980504.git.shane.wang@intel.com>
References: <cover.1333980504.git.shane.wang@intel.com>
Subject: [PATCH 06/21] Hob: clean up and unify the steps for new build to call initiate_new_build_async()
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
X-List-Received-Date: Mon, 09 Apr 2012 13:57:12 -0000

initiate_new_build() (changed the function name into initiate_new_build_async()
to indicate it is an async function) or the similar sub-functions are called at
different places.

This patch is unify to call initiate_new_build_async().

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py          |   19 +++++++------------
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |    2 +-
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index a3410d4..ef6f182 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -294,11 +294,7 @@ class Builder(gtk.Window):
         self.handler.connect("command-succeeded",        self.handler_command_succeeded_cb)
         self.handler.connect("command-failed",           self.handler_command_failed_cb)
 
-        self.handler.init_cooker()
-        self.handler.set_extra_inherit("image_types")
-        self.handler.parse_config()
-
-        self.switch_page(self.MACHINE_SELECTION)
+        self.initiate_new_build_async()
 
     def create_visual_elements(self):
         self.set_title("Hob")
@@ -334,6 +330,12 @@ class Builder(gtk.Window):
         self.show_all()
         self.nb.set_current_page(0)
 
+    def initiate_new_build_async(self):
+        self.switch_page(self.MACHINE_SELECTION)
+        self.handler.init_cooker()
+        self.handler.set_extra_inherit("image_types")
+        self.handler.parse_config()
+
     def load_template(self, path):
         self.template = TemplateMgr()
         self.template.load(path)
@@ -987,13 +989,6 @@ class Builder(gtk.Window):
     def show_recipes(self):
         self.switch_page(self.RECIPE_SELECTION)
 
-    def initiate_new_build(self):
-        self.handler.init_cooker()
-        self.handler.set_extra_inherit("image_types")
-        self.handler.parse_config()
-        self.image_configuration_page.switch_machine_combo()
-        self.switch_page(self.MACHINE_SELECTION)
-
     def show_configuration(self):
         self.switch_page(self.BASEIMG_SELECTED)
 
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index b685d11..e550653 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -381,7 +381,7 @@ class ImageDetailsPage (HobPage):
         self.builder.runqemu_image(image_name)
 
     def build_new_button_clicked_cb(self, button):
-        self.builder.initiate_new_build()
+        self.builder.initiate_new_build_async()
 
     def edit_config_button_clicked_cb(self, button):
         self.builder.show_configuration()
-- 
1.7.6



