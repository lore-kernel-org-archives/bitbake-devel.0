Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SAjpp-0003Ld-8A
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 16:21:53 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 22 Mar 2012 08:12:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="123894955"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 22 Mar 2012 08:12:56 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 22 Mar 2012 23:38:06 +0800
Message-Id: <72d28089005830f17dda4acdf7d956941ce152ee.1332430442.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <994a3ff7aec35f01ad019ff455b699c86342945e.1332430442.git.shane.wang@intel.com>
References: <994a3ff7aec35f01ad019ff455b699c86342945e.1332430442.git.shane.wang@intel.com>
In-Reply-To: <cover.1332430442.git.shane.wang@intel.com>
References: <cover.1332430442.git.shane.wang@intel.com>
Subject: [PATCH 4/8] Hob: Fix the workaround to get image types
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
X-List-Received-Date: Thu, 22 Mar 2012 15:21:53 -0000

From: Dongxiao Xu <dongxiao.xu@intel.com>

Inherit image_types.bbclass before getting parameters to fix the
original workaround.

Besides, kick the handler things off after Builder is initialized.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    8 ++++++--
 bitbake/lib/bb/ui/hob.py                    |    3 ++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index e9d10c5..fe7b5d5 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
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
diff --git a/bitbake/lib/bb/ui/hob.py b/bitbake/lib/bb/ui/hob.py
index daa708b..4c3e572 100755
--- a/bitbake/lib/bb/ui/hob.py
+++ b/bitbake/lib/bb/ui/hob.py
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
1.7.6



