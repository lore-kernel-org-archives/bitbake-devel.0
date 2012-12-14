Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TjXTh-0006qo-TB
	for bitbake-devel@lists.openembedded.org;
	Fri, 14 Dec 2012 16:47:11 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 14 Dec 2012 07:32:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,281,1355126400"; d="scan'208";a="231605781"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by azsmga001.ch.intel.com with ESMTP; 14 Dec 2012 07:32:31 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Dec 2012 17:35:47 +0200
Message-Id: <1355499347-9320-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: use base image only if it was set
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
X-List-Received-Date: Fri, 14 Dec 2012 15:47:11 -0000

As it is, when you create a new image from scratch, hob gives an error.
This is because of the patch for #2601.

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index ae853ee..e690d4c 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -168,10 +168,11 @@ class HobHandler(gobject.GObject):
                 targets.append(self.toolchain)
             if targets[0] == "hob-image":
                 hobImage = self.runCommand(["matchFile", "hob-image.bb"])
-                baseImage = self.runCommand(["matchFile", self.base_image + ".bb"])
-                version = self.runCommand(["generateNewImage", hobImage, baseImage, self.package_queue])
-                targets[0] += version
-                self.recipe_model.set_custom_image_version(version)
+                if self.base_image != "Create your own image":
+                    baseImage = self.runCommand(["matchFile", self.base_image + ".bb"])
+                    version = self.runCommand(["generateNewImage", hobImage, baseImage, self.package_queue])
+                    targets[0] += version
+                    self.recipe_model.set_custom_image_version(version)
 
             self.runCommand(["buildTargets", targets, self.default_task])
 
-- 
1.7.9.5



