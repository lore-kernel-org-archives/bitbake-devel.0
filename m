Return-Path: <cristiana.voicu@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 54F6C6BEF5
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Sep 2013 07:24:30 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 03 Sep 2013 00:24:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,1012,1367996400"; d="scan'208";a="355114620"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by azsmga001.ch.intel.com with ESMTP; 03 Sep 2013 00:24:29 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Sep 2013 10:28:01 +0300
Message-Id: <1378193281-16921-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: remove PACKAGE_INSTALL variable setting from hob
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 03 Sep 2013 07:24:31 -0000

Before saving the packages for a custom images in a .bb file,
the packages were saved in bitbake memory. Now all the variables
are saved in conf file, so saving PACKAGE_INSTALL is not needed anymore.
Moved were LINGUAS_INSTALL is set, because both conditions are for testing
if a custom image is saved.

[YOCTO #5101]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 7854742..d0ac6bd 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -166,13 +166,11 @@ class HobHandler(gobject.GObject):
             self.clear_busy()
             self.building = True
             targets = [self.image]
-            if self.package_queue:
-                self.set_var_in_file("LINGUAS_INSTALL", "", "local.conf")
-                self.set_var_in_file("PACKAGE_INSTALL", " ".join(self.package_queue), "local.conf")
             if self.toolchain_packages:
                 self.set_var_in_file("TOOLCHAIN_TARGET_TASK", " ".join(self.toolchain_packages), "local.conf")
                 targets.append(self.toolchain)
             if targets[0] == "hob-image":
+                self.set_var_in_file("LINGUAS_INSTALL", "", "local.conf")
                 hobImage = self.runCommand(["matchFile", "hob-image.bb"])
                 if self.base_image != "Start with an empty image recipe":
                     baseImage = self.runCommand(["matchFile", self.base_image + ".bb"])
-- 
1.7.9.5


