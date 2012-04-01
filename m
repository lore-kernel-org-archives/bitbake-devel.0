Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SEJrD-00046R-5W
	for bitbake-devel@lists.openembedded.org;
	Sun, 01 Apr 2012 14:26:07 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 01 Apr 2012 05:17:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="127498339"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 01 Apr 2012 05:17:00 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  1 Apr 2012 20:14:18 +0800
Message-Id: <b921b683cd4b92ad0feb7aeeb02914dc891cb139.1333269705.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333269705.git.dongxiao.xu@intel.com>
References: <cover.1333269705.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333269705.git.dongxiao.xu@intel.com>
References: <cover.1333269705.git.dongxiao.xu@intel.com>
Subject: [PATCH 10/10] Hob: fix IMAGE_INSTALL setting while save template
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
X-List-Received-Date: Sun, 01 Apr 2012 12:26:07 -0000

If save every selected package into IMAGE_INSTALL field, and then build
the saved bb file by bitbake command line, it will report errors since
some packages could not be found since they are dynamically generated.
With this commit, Hob will only save those packages into the
IMAGE_INSTALL variable which are brought in by user.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py              |    4 +++-
 lib/bb/ui/crumbs/hoblistmodel.py         |   17 +++++++++++++++++
 lib/bb/ui/crumbs/packageselectionpage.py |    1 +
 3 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 20d4652..3ff6df7 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -68,6 +68,8 @@ class Configuration:
         self.selected_recipes = []
         self.selected_packages = []
 
+        self.user_selected_packages = []
+
         # proxy settings
         self.all_proxy = params["all_proxy"]
         self.http_proxy = params["http_proxy"]
@@ -157,7 +159,7 @@ class Configuration:
         self.selected_image = filename
         template.setVar("__SELECTED_IMAGE__", self.selected_image)
         template.setVar("DEPENDS", self.selected_recipes)
-        template.setVar("IMAGE_INSTALL", self.selected_packages)
+        template.setVar("IMAGE_INSTALL", self.user_selected_packages)
         # proxy
         template.setVar("all_proxy", self.all_proxy)
         template.setVar("http_proxy", self.http_proxy)
diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
index a351597..5dddffa 100644
--- a/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/lib/bb/ui/crumbs/hoblistmodel.py
@@ -342,6 +342,23 @@ class PackageListModel(gtk.TreeStore):
         self.selection_change_notification()
         return left
 
+    def get_user_selected_packages(self):
+        packagelist = []
+
+        it = self.get_iter_first()
+        while it:
+            child_it = self.iter_children(it)
+            while child_it:
+                if self.get_value(child_it, self.COL_INC):
+                    binb = self.get_value(child_it, self.COL_BINB)
+                    if not binb or binb == "User Selected":
+                        name = self.get_value(child_it, self.COL_NAME)
+                        packagelist.append(name)
+                child_it = self.iter_next(child_it)
+            it = self.iter_next(it)
+
+        return packagelist
+
     def get_selected_packages(self):
         packagelist = []
 
diff --git a/lib/bb/ui/crumbs/packageselectionpage.py b/lib/bb/ui/crumbs/packageselectionpage.py
index e071b07..0a7474e 100755
--- a/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/lib/bb/ui/crumbs/packageselectionpage.py
@@ -161,6 +161,7 @@ class PackageSelectionPage (HobPage):
         self._expand_all()
 
         self.builder.configuration.selected_packages = self.package_model.get_selected_packages()
+        self.builder.configuration.user_selected_packages = self.package_model.get_user_selected_packages()
         selected_packages_num = len(self.builder.configuration.selected_packages)
         selected_packages_size = float(self.package_model.get_packages_size())
         selected_packages_size_str = self._size_to_string(selected_packages_size)
-- 
1.7.4.1



