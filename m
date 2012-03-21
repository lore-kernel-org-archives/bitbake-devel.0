Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SALFJ-0003Qs-G9
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 14:06:33 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 21 Mar 2012 05:57:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="121495244"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 21 Mar 2012 05:57:40 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 20:55:13 +0800
Message-Id: <bfbedb4119d7415cf43fba281e0d88f632443828.1332334068.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
Subject: [PATCH 09/17] Hob: Fix the workaround to get image types
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
X-List-Received-Date: Wed, 21 Mar 2012 13:06:33 -0000

Inherit image_types.bbclass before getting parameters to fix the
original workaround.

Besides, kick the handler things off after Builder is initialized.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hobeventhandler.py |    8 ++++++--
 lib/bb/ui/hob.py                    |    3 ++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index e9d10c5..fe7b5d5 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -379,6 +379,11 @@ class HobHandler(gobject.GObject):
         self.build.reset()
 
     def get_parameters(self):
+        # inherit image_types.bbclass
+        self.init_cooker()
+        self.set_extra_inherit("image_types")
+        self.parse_config()
+    
         # retrieve the parameters from bitbake
         params = {}
         params["core_base"] = self.server.runCommand(["getVariable", "COREBASE"]) or ""
@@ -444,8 +449,7 @@ class HobHandler(gobject.GObject):
 
         params["image_fstypes"] = self.server.runCommand(["getVariable", "IMAGE_FSTYPES"]) or ""
 
-        # walkaround
-        params["image_types"] = " ".join(hcc.SUPPORTED_IMAGE_TYPES.keys()).lstrip(" ")
+        params["image_types"] = self.server.runCommand(["getVariable", "IMAGE_TYPES"]) or ""
 
         params["conf_version"] = self.server.runCommand(["getVariable", "CONF_VERSION"]) or ""
         params["lconf_version"] = self.server.runCommand(["getVariable", "LCONF_VERSION"]) or ""
diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index daa708b..4c3e572 100755
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -56,9 +56,10 @@ def main (server = None, eventHandler = None):
     package_model = PackageListModel()
 
     hobHandler = HobHandler(server, recipe_model, package_model)
+    builder = Builder(hobHandler, recipe_model, package_model)
+
     if hobHandler.kick() == False:
         return 1
-    builder = Builder(hobHandler, recipe_model, package_model)
 
     # This timeout function regularly probes the event queue to find out if we
     # have any messages waiting for us.
-- 
1.7.4.1



