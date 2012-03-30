Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SDahL-00034s-S3
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 Mar 2012 14:12:56 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 30 Mar 2012 05:03:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="83492321"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by AZSMGA002.ch.intel.com with ESMTP; 30 Mar 2012 05:03:49 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 30 Mar 2012 20:01:18 +0800
Message-Id: <7b834219e675cbe02194aa1bbb76a3165ae82356.1333108781.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333108781.git.dongxiao.xu@intel.com>
References: <cover.1333108781.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333108781.git.dongxiao.xu@intel.com>
References: <cover.1333108781.git.dongxiao.xu@intel.com>
Subject: [PATCH 6/7] Hob: Remove duplication for certain bitbake variables
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
X-List-Received-Date: Fri, 30 Mar 2012 12:12:56 -0000

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



