Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SJgur-0005hJ-IG
	for bitbake-devel@lists.openembedded.org;
	Mon, 16 Apr 2012 10:04:05 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 16 Apr 2012 00:54:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="154052297"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga002.fm.intel.com with ESMTP; 16 Apr 2012 00:54:39 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Apr 2012 15:51:43 +0800
Message-Id: <ffbec35100248d5995f162b117383b82d1d8562a.1334562055.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1334562055.git.dongxiao.xu@intel.com>
References: <cover.1334562055.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1334562055.git.dongxiao.xu@intel.com>
References: <cover.1334562055.git.dongxiao.xu@intel.com>
Subject: [PATCH 1/1] Hob: Fix contents in imagedetailsscreen
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
X-List-Received-Date: Mon, 16 Apr 2012 08:04:05 -0000

This commit fixes the contents in imagedetailsscreen, which lacks some
kind of image types, e.x., iso and hddimg.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py |    9 +++++----
 lib/bb/ui/crumbs/hig.py     |    2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index bd45016..6b172d0 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -32,7 +32,7 @@ from bb.ui.crumbs.recipeselectionpage import RecipeSelectionPage
 from bb.ui.crumbs.packageselectionpage import PackageSelectionPage
 from bb.ui.crumbs.builddetailspage import BuildDetailsPage
 from bb.ui.crumbs.imagedetailspage import ImageDetailsPage
-from bb.ui.crumbs.hobwidget import hwc, HobButton, HobAltButton
+from bb.ui.crumbs.hobwidget import hwc, HobButton, HobAltButton, hcc
 from bb.ui.crumbs.hig import CrumbsMessageDialog, ImageSelectionDialog, \
                              AdvancedSettingDialog, LayerSelectionDialog, \
                              DeployImageDialog
@@ -752,9 +752,10 @@ class Builder(gtk.Window):
             else:
                 linkname = selected_image + '-' + self.configuration.curr_mach
             for image_type in self.parameters.image_types:
-                linkpath = self.parameters.image_addr + '/' + linkname + '.' + image_type
-                if os.path.exists(linkpath):
-                    self.parameters.image_names.append(os.readlink(linkpath))
+                for real_image_type in hcc.SUPPORTED_IMAGE_TYPES[image_type]:
+                    linkpath = self.parameters.image_addr + '/' + linkname + '.' + real_image_type
+                    if os.path.exists(linkpath):
+                        self.parameters.image_names.append(os.readlink(linkpath))
         elif self.current_step == self.PACKAGE_GENERATING:
             fraction = 1.0
         self.build_details_page.update_progress_bar("Build Completed: ", fraction)
diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 322efc6..a85b478 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -1107,7 +1107,7 @@ class ImageSelectionDialog (CrumbsDialog):
                 for image_type in self.image_types:
                     for real_image_type in hcc.SUPPORTED_IMAGE_TYPES[image_type]:
                         if f.endswith('.' + real_image_type):
-                            imageset.add(f.rsplit('.' + real_image_type)[0])
+                            imageset.add(f.rsplit('.' + real_image_type)[0].rsplit('.rootfs')[0])
                             self.image_list.append(f)
         
         for image in imageset:
-- 
1.7.4.1



