Return-Path: <cristiana.voicu@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 72E3F6B398
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jul 2013 11:40:23 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga101.ch.intel.com with ESMTP; 25 Jul 2013 04:40:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,742,1367996400"; d="scan'208";a="370781227"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga001.fm.intel.com with ESMTP; 25 Jul 2013 04:40:23 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jul 2013 14:42:26 +0300
Message-Id: <1374752549-29471-14-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1374752549-29471-1-git-send-email-cristiana.voicu@intel.com>
References: <1374752549-29471-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH_V2 13/16] bitbake: save packages in IMAGE_INSTALL instead of PACKAGE_INSTALL
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
X-List-Received-Date: Thu, 25 Jul 2013 11:40:23 -0000

Hob retrieves the list of recipes and packages using the IMAGE_INSTALL
variable, so a custom image should be saved using this variable.
Changed how the image is saved in a bb file

[YOCTO #4193]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/cooker.py |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index ad92dea..48be434 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1159,11 +1159,11 @@ class BBCooker:
                 if topdir in base_image:
                     base_image = require_line.split()[1]
                 imagefile.write("require " + base_image + "\n")
-            package_install = "PACKAGE_INSTALL_forcevariable = \""
+            image_install = "IMAGE_INSTALL_append = \""
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


