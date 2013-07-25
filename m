Return-Path: <cristiana.voicu@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id B60F46B347
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jul 2013 11:40:16 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga101.ch.intel.com with ESMTP; 25 Jul 2013 04:40:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,742,1367996400"; d="scan'208";a="370781152"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga001.fm.intel.com with ESMTP; 25 Jul 2013 04:40:16 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jul 2013 14:42:22 +0300
Message-Id: <1374752549-29471-10-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1374752549-29471-1-git-send-email-cristiana.voicu@intel.com>
References: <1374752549-29471-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH_V2 09/16] hob/bitbake: when an image is saved, it should require an image from layers
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 25 Jul 2013 11:40:16 -0000

Saving an image that requires another image will cause issues when
the second on is removed. So, we have agreed to "require" only the images
from layers.
The functionality is implemented in bitbake, in order to be more abstract,
and it is used by Hob when an image recipe is saved.

[YOCTO #4193]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/cooker.py |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 9965417..ad92dea 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1147,10 +1147,17 @@ class BBCooker:
             else:
                 dest = image
 
+        if base_image:
+            with open(base_image, 'r') as f:
+                require_line = f.readline()
+
         with open(dest, "w") as imagefile:
             if base_image is None:
                 imagefile.write("inherit image\n")
             else:
+                topdir = self.data.getVar("TOPDIR")
+                if topdir in base_image:
+                    base_image = require_line.split()[1]
                 imagefile.write("require " + base_image + "\n")
             package_install = "PACKAGE_INSTALL_forcevariable = \""
             for package in package_queue:
-- 
1.7.9.5


