Return-Path: <marius.avram@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 2D23760D71
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Mar 2014 11:59:16 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 12 Mar 2014 04:58:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,637,1389772800"; d="scan'208";a="496903548"
Received: from mavram-vostro.rb.intel.com ([10.237.105.158])
	by fmsmga002.fm.intel.com with ESMTP; 12 Mar 2014 04:58:56 -0700
From: Marius Avram <marius.avram@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 12 Mar 2014 14:03:49 +0200
Message-Id: <1394625829-11427-1-git-send-email-marius.avram@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] bitbake: cooker: some IMAGE_FEATURES not recognized
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
X-List-Received-Date: Wed, 12 Mar 2014 11:59:17 -0000

Fixes an issue in hob which happened when the local.conf file was
modified externally by appending "eclipse-debug" to the IMAGE_FEATURES
variable. The reason of the problem is that some IMAGE_FEATURES are
not available in the image.bbclass file and they are declared in the
core-image.bbclass. Now a default hob image will inherit core-image.

[YOCTO #5711]

Signed-off-by: Marius Avram <marius.avram@intel.com>
---
 bitbake/lib/bb/cooker.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 96f05b5..4de6a51 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1220,7 +1220,7 @@ class BBCooker:
 
         with open(dest, "w") as imagefile:
             if base_image is None:
-                imagefile.write("inherit image\n")
+                imagefile.write("inherit core-image\n")
             else:
                 topdir = self.data.getVar("TOPDIR")
                 if topdir in base_image:
-- 
1.7.9.5


