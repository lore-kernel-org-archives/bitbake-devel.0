Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1T4qAb-000663-PW
	for bitbake-devel@lists.openembedded.org;
	Fri, 24 Aug 2012 11:27:14 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q7O9F5Dv028542
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 24 Aug 2012 02:15:05 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.2.309.2; Fri, 24 Aug 2012 02:15:04 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <richard.purdie@linuxfoundation.org>
Date: Fri, 24 Aug 2012 17:15:10 +0800
Message-ID: <05ea3feee5a55d029d7f439be59d04873c2433f6.1345799414.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1345799414.git.kai.kang@windriver.com>
References: <cover.1345799414.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: [PATCH 2/3] hob2: remove class hcc
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
X-List-Received-Date: Fri, 24 Aug 2012 09:27:14 -0000
Content-Type: text/plain

Because class hcc is useless, so remove it.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py         |    2 +-
 bitbake/lib/bb/ui/crumbs/hig.py             |    2 +-
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    1 -
 bitbake/lib/bb/ui/crumbs/hobwidget.py       |   29 ---------------------------
 4 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index dde4214..5677ccd 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -34,7 +34,7 @@ from bb.ui.crumbs.recipeselectionpage import RecipeSelectionPage
 from bb.ui.crumbs.packageselectionpage import PackageSelectionPage
 from bb.ui.crumbs.builddetailspage import BuildDetailsPage
 from bb.ui.crumbs.imagedetailspage import ImageDetailsPage
-from bb.ui.crumbs.hobwidget import hwc, HobButton, HobAltButton, hcc
+from bb.ui.crumbs.hobwidget import hwc, HobButton, HobAltButton
 from bb.ui.crumbs.hig import CrumbsMessageDialog, ImageSelectionDialog, \
                              AdvancedSettingDialog, LayerSelectionDialog, \
                              DeployImageDialog
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 014ea98..7b6742d 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -30,7 +30,7 @@ import shlex
 import subprocess
 import tempfile
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobwidget import hcc, hic, HobViewTable, HobInfoButton, HobButton, HobAltButton, HobIconChecker
+from bb.ui.crumbs.hobwidget import hic, HobViewTable, HobInfoButton, HobButton, HobAltButton, HobIconChecker
 from bb.ui.crumbs.progressbar import HobProgressBar
 import bb.ui.crumbs.utils
 import bb.process
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 16ab246..623e7d1 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -22,7 +22,6 @@
 import gobject
 import logging
 from bb.ui.crumbs.runningbuild import RunningBuild
-from bb.ui.crumbs.hobwidget import hcc
 
 class HobHandler(gobject.GObject):
 
diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index d10c56b..7c23440 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -63,35 +63,6 @@ class hic:
     ICON_INDI_TICK_FILE           = os.path.join(HOB_ICON_BASE_DIR, ('indicators/tick.png'))
     ICON_INDI_INFO_FILE           = os.path.join(HOB_ICON_BASE_DIR, ('indicators/info.png'))
 
-class hcc:
-
-    SUPPORTED_IMAGE_TYPES = {
-        "jffs2"         : ["jffs2"],
-        "sum.jffs2"     : ["sum.jffs2"],
-        "cramfs"        : ["cramfs"],
-        "ext2"          : ["ext2"],
-        "ext2.gz"       : ["ext2.gz"],
-        "ext2.bz2"      : ["ext2.bz2"],
-        "ext3"          : ["ext3"],
-        "ext3.gz"       : ["ext3.gz"],
-        "ext2.lzma"     : ["ext2.lzma"],
-        "btrfs"         : ["btrfs"],
-        "live"          : ["hddimg", "iso"],
-        "squashfs"      : ["squashfs"],
-        "squashfs-lzma" : ["squashfs-lzma"],
-        "ubi"           : ["ubi"],
-        "tar"           : ["tar"],
-        "tar.gz"        : ["tar.gz"],
-        "tar.bz2"       : ["tar.bz2"],
-        "tar.xz"        : ["tar.xz"],
-        "cpio"          : ["cpio"],
-        "cpio.gz"       : ["cpio.gz"],
-        "cpio.xz"       : ["cpio.xz"],
-        "vmdk"          : ["vmdk"],
-        "cpio.lzma"     : ["cpio.lzma"],
-        "elf"           : ["elf"],
-    }
-
 class HobViewTable (gtk.VBox):
     """
     A VBox to contain the table for different recipe views and package view
-- 
1.7.5.4



