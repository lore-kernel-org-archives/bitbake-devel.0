Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SEJr7-00042U-3V
	for bitbake-devel@lists.openembedded.org;
	Sun, 01 Apr 2012 14:26:01 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 01 Apr 2012 05:16:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="124192925"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 01 Apr 2012 05:16:52 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  1 Apr 2012 20:14:12 +0800
Message-Id: <7a54422878526c88bfd2ae2a245ba87473aac035.1333269705.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333269705.git.dongxiao.xu@intel.com>
References: <cover.1333269705.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333269705.git.dongxiao.xu@intel.com>
References: <cover.1333269705.git.dongxiao.xu@intel.com>
Subject: [PATCH 04/10] Hob: Remove duplication for certain bitbake variables
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
X-List-Received-Date: Sun, 01 Apr 2012 12:26:01 -0000

Sometimes, certain variables have duplicated values inside, for example,
IMAGE_FSTYPES = "tar.bz2 ext3 tar.bz2 ext3"

We need to remove the redundancy for those values.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hobeventhandler.py |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 3d5df9e..74081dc 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -382,6 +382,13 @@ class HobHandler(gobject.GObject):
     def reset_build(self):
         self.build.reset()
 
+    def _remove_redundant(self, string):
+        ret = []
+        for i in string.split():
+            if i not in ret:
+                ret.append(i)
+        return " ".join(ret)
+
     def get_parameters(self):
         # retrieve the parameters from bitbake
         params = {}
@@ -445,19 +452,19 @@ class HobHandler(gobject.GObject):
             image_overhead_factor = float(image_overhead_factor)
         params['image_overhead_factor'] = image_overhead_factor
 
-        params["incompat_license"] = self.server.runCommand(["getVariable", "INCOMPATIBLE_LICENSE"]) or ""
+        params["incompat_license"] = self._remove_redundant(self.server.runCommand(["getVariable", "INCOMPATIBLE_LICENSE"]) or "")
         params["sdk_machine"] = self.server.runCommand(["getVariable", "SDKMACHINE"]) or self.server.runCommand(["getVariable", "SDK_ARCH"]) or ""
 
-        params["image_fstypes"] = self.server.runCommand(["getVariable", "IMAGE_FSTYPES"]) or ""
+        params["image_fstypes"] = self._remove_redundant(self.server.runCommand(["getVariable", "IMAGE_FSTYPES"]) or "")
 
-        params["image_types"] = self.server.runCommand(["getVariable", "IMAGE_TYPES"]) or ""
+        params["image_types"] = self._remove_redundant(self.server.runCommand(["getVariable", "IMAGE_TYPES"]) or "")
 
         params["conf_version"] = self.server.runCommand(["getVariable", "CONF_VERSION"]) or ""
         params["lconf_version"] = self.server.runCommand(["getVariable", "LCONF_VERSION"]) or ""
 
-        params["runnable_image_types"] = self.server.runCommand(["getVariable", "RUNNABLE_IMAGE_TYPES"]) or ""
-        params["runnable_machine_patterns"] = self.server.runCommand(["getVariable", "RUNNABLE_MACHINE_PATTERNS"]) or ""
-        params["deployable_image_types"] = self.server.runCommand(["getVariable", "DEPLOYABLE_IMAGE_TYPES"]) or ""
+        params["runnable_image_types"] = self._remove_redundant(self.server.runCommand(["getVariable", "RUNNABLE_IMAGE_TYPES"]) or "")
+        params["runnable_machine_patterns"] = self._remove_redundant(self.server.runCommand(["getVariable", "RUNNABLE_MACHINE_PATTERNS"]) or "")
+        params["deployable_image_types"] = self._remove_redundant(self.server.runCommand(["getVariable", "DEPLOYABLE_IMAGE_TYPES"]) or "")
         params["tmpdir"] = self.server.runCommand(["getVariable", "TMPDIR"]) or ""
         params["distro_version"] = self.server.runCommand(["getVariable", "DISTRO_VERSION"]) or ""
         params["target_os"] = self.server.runCommand(["getVariable", "TARGET_OS"]) or ""
-- 
1.7.4.1



