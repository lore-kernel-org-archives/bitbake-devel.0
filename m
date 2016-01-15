Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id BB10375CC2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:19 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga101.jf.intel.com with ESMTP; 15 Jan 2016 04:58:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="633907020"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 15 Jan 2016 04:58:13 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 2F9736A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:08 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:00:45 +0200
Message-Id: <c68a352d5eb8ec52d323c3bf7c4a79361823c645.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 02/23] toaster: move image file suffix list to model
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
X-List-Received-Date: Fri, 15 Jan 2016 12:58:19 -0000

From: Elliot Smith <elliot.smith@intel.com>

Image file suffixes are used in the project configuration page to
show a list of available image file types. This list is stored
as a function in the views code.

However, this list is also needed when parsing image file paths,
so that the suffixes can be shown in the "all builds" and "project
builds" tables.

Move the list of valid image file suffixes to the Target_Image_File
class to make is accessible in other places where it may be needed.

[YOCTO #8738]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/orm/models.py       | 9 +++++++++
 lib/toaster/toastergui/views.py | 7 +------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index e4ab0bb..7e0cf96 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -461,6 +461,15 @@ class Target(models.Model):
         return self.target
 
 class Target_Image_File(models.Model):
+    # valid suffixes for image files produced by a build
+    SUFFIXES = {
+        'btrfs', 'cpio', 'cpio.gz', 'cpio.lz4', 'cpio.lzma', 'cpio.xz',
+        'cramfs', 'elf', 'ext2', 'ext2.bz2', 'ext2.gz', 'ext2.lzma', 'ext4',
+        'ext4.gz', 'ext3', 'ext3.gz', 'hddimg', 'iso', 'jffs2', 'jffs2.sum',
+        'squashfs', 'squashfs-lzo', 'squashfs-xz', 'tar.bz2', 'tar.lz4',
+        'tar.xz', 'tartar.gz', 'ubi', 'ubifs', 'vmdk'
+    }
+
     target = models.ForeignKey(Target)
     file_name = models.FilePathField(max_length=254)
     file_size = models.IntegerField()
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index bd334b9..4cd7afd 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2808,12 +2808,7 @@ if True:
             'all_proxy','ftp_proxy','http_proxy ','https_proxy'
             }
 
-        vars_fstypes  = {
-            'btrfs','cpio','cpio.gz','cpio.lz4','cpio.lzma','cpio.xz','cramfs',
-            'elf','ext2','ext2.bz2','ext2.gz','ext2.lzma', 'ext4', 'ext4.gz', 'ext3','ext3.gz','hddimg',
-            'iso','jffs2','jffs2.sum','squashfs','squashfs-lzo','squashfs-xz','tar.bz2',
-            'tar.lz4','tar.xz','tartar.gz','ubi','ubifs','vmdk'
-        }
+        vars_fstypes = Target_Image_File.SUFFIXES
 
         return(vars_managed,sorted(vars_fstypes),vars_blacklist)
 
-- 
2.1.4


