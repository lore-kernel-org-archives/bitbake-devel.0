Return-Path: <cristiana.voicu@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id F0AA76A4AC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jul 2013 12:57:16 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 29 Jul 2013 05:57:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,769,1367996400"; d="scan'208";a="372876092"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga001.fm.intel.com with ESMTP; 29 Jul 2013 05:57:16 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Jul 2013 15:59:27 +0300
Message-Id: <1375102770-14079-14-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1375102770-14079-1-git-send-email-cristiana.voicu@intel.com>
References: <1375102770-14079-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH_V3 13/16] bitbake: save packages in IMAGE_INSTALL instead of PACKAGE_INSTALL
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
X-List-Received-Date: Mon, 29 Jul 2013 12:57:17 -0000

Hob retrieves the list of recipes and packages using the IMAGE_INSTALL
variable, so a custom image should be saved using this variable.
Changed how the image is saved in a bb file

[YOCTO #4193]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/cooker.py |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index f009210..97210ba 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1155,11 +1155,11 @@ class BBCooker:
                 if topdir in base_image:
                     base_image = require_line.split()[1]
                 imagefile.write("require " + base_image + "\n")
-            package_install = "PACKAGE_INSTALL_forcevariable = \""
+            image_install = "IMAGE_INSTALL = \""
             for package in package_queue:
-                package_install += str(package) + " "
-            package_install += "\"\n"
-            imagefile.write(package_install)
+                image_install += str(package) + " "
+            image_install += "\"\n"
+            imagefile.write(image_install)
 
             description_var = "DESCRIPTION = \"" + description + "\"\n"
             imagefile.write(description_var)
-- 
1.7.9.5


