Return-Path: <daniel.ammann@bytesatwork.ch>
X-Greylist: delayed 580 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 25 Jul 2019 10:41:27 UTC
Received: from bytesatwork.ch (bytesatwork.ch [91.135.72.15])
	by mail.openembedded.org (Postfix) with ESMTP id C79727D1E9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jul 2019 10:41:27 +0000 (UTC)
Received: from mimas.bytesatwork.ch (162.40.150.83.ftth.as8758.net
	[83.150.40.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested) (Authenticated sender: daniel)
	by bytesatwork.ch (Postfix) with ESMTPSA id BDB2C101C2A6B;
	Thu, 25 Jul 2019 12:31:43 +0200 (CEST)
From: Daniel Ammann <daniel.ammann@bytesatwork.ch>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jul 2019 12:31:40 +0200
Message-Id: <20190725103140.5972-1-daniel.ammann@bytesatwork.ch>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH] toaster: Sync list of fs_types with oe-core
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
X-List-Received-Date: Thu, 25 Jul 2019 10:41:28 -0000

Signed-off-by: Daniel Ammann <daniel.ammann@bytesatwork.ch>
---
 lib/toaster/orm/models.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 41a9f819d..bb6b5decf 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -965,12 +965,12 @@ class TargetSDKFile(models.Model):
 class Target_Image_File(models.Model):
     # valid suffixes for image files produced by a build
     SUFFIXES = {
-        'btrfs', 'cpio', 'cpio.gz', 'cpio.lz4', 'cpio.lzma', 'cpio.xz',
-        'cramfs', 'elf', 'ext2', 'ext2.bz2', 'ext2.gz', 'ext2.lzma', 'ext4',
-        'ext4.gz', 'ext3', 'ext3.gz', 'hdddirect', 'hddimg', 'iso', 'jffs2',
-        'jffs2.sum', 'multiubi', 'qcow2', 'squashfs', 'squashfs-lzo',
+        'btrfs', 'container', 'cpio', 'cpio.gz', 'cpio.lz4', 'cpio.lzma',
+        'cpio.xz', 'cramfs', 'ext2', 'ext2.bz2', 'ext2.gz', 'ext2.lzma',
+        'ext3', 'ext3.gz', 'ext4', 'ext4.gz', 'f2fs', 'hddimg', 'iso', 'jffs2',
+        'jffs2.sum', 'multiubi', 'squashfs', 'squashfs-lz4', 'squashfs-lzo',
         'squashfs-xz', 'tar', 'tar.bz2', 'tar.gz', 'tar.lz4', 'tar.xz', 'ubi',
-        'ubifs', 'vdi', 'vmdk', 'wic', 'wic.bmap', 'wic.bz2', 'wic.gz', 'wic.lzma'
+        'ubifs', 'wic', 'wic.bz2', 'wic.gz', 'wic.lzma'
     }
 
     target = models.ForeignKey(Target)
-- 
2.11.0


