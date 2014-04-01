Return-Path: <marius.avram@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id E90126B5D9
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Apr 2014 10:58:56 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 01 Apr 2014 03:58:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,771,1389772800"; d="scan'208";a="511763245"
Received: from mavram-vostro.rb.intel.com ([10.237.105.50])
	by fmsmga002.fm.intel.com with ESMTP; 01 Apr 2014 03:58:57 -0700
From: Marius Avram <marius.avram@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  1 Apr 2014 13:59:05 +0300
Message-Id: <1396349945-30180-1-git-send-email-marius.avram@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] cooker: Overwrite IMAGE_BASENAME to default in custom image
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
X-List-Received-Date: Tue, 01 Apr 2014 10:59:00 -0000

This solves a problem of custom images which inherit a base
image with IMAGE_BASENAME overwritten in their recipe by a
different value than its default one: ${PN}.

The value of IMAGE_BASE causes a crash when hob will try to
create symbolic links to the resulting images from the deploy
directory, because it will look for names similar to
<original_recipe_name>-edited-timestamp-machine.rootfs.*
which might be different from the actual resulting image.

The solution is to simply overwrite IMAGE_BASENAME in the
custom recipe to the default value in the case IMAGE_BASENAME
is found in the base recipe.

Some recipes which were affected by this problem are those
from meta-fsl-demos (e.g.: fsl-image-test).

[YOCTO #6017]

Signed-off-by: Marius Avram <marius.avram@intel.com>
---
 bitbake/lib/bb/cooker.py |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 07202e3..ea861fa 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1219,6 +1219,7 @@ class BBCooker:
         '''
         Create a new image with a "require"/"inherit" base_image statement
         '''
+        import re
         if timestamp:
             image_name = os.path.splitext(image)[0]
             timestr = time.strftime("-%Y%m%d-%H%M%S")
@@ -1229,9 +1230,14 @@ class BBCooker:
             else:
                 dest = image
 
+        basename = False
         if base_image:
             with open(base_image, 'r') as f:
                 require_line = f.readline()
+                p = re.compile("IMAGE_BASENAME *=")
+                for line in f:
+                    if p.search(line):
+                        basename = True
 
         with open(dest, "w") as imagefile:
             if base_image is None:
@@ -1250,6 +1256,11 @@ class BBCooker:
             description_var = "DESCRIPTION = \"" + description + "\"\n"
             imagefile.write(description_var)
 
+            if basename:
+                # If this is overwritten in a inherited image, reset it to default
+                image_basename = "IMAGE_BASENAME = \"${PN}\"\n"
+                imagefile.write(image_basename)
+
         self.state = state.initial
         if timestamp:
             return timestr
-- 
1.7.9.5


