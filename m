Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376A1D2ECF9
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 05:55:22 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.789.1768888519711093848
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Jan 2026 21:55:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=To/JVBop;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1329275-20260120055514298c7435e50002073b-epou3s@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260120055514298c7435e50002073b
        for <bitbake-devel@lists.openembedded.org>;
        Tue, 20 Jan 2026 06:55:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=psWt4axeKfXRVS0KUxN7TRNFB3KJFNCKMoNVuYpAX7g=;
 b=To/JVBopnSK3/Qk27cdE6Idt2eCbjAvVmx9GXmpJ65A5VI/cW/fesTxdDaF4WkQPMVflCQ
 gJziiehC/S87ZMDWNXQ48L3q3msDGvFa8RyhvGxVc4JFSKFe0+3xxZR+Q9b84x2eWKExj9YC
 HSkO0ydYpsFJvv42YyAvfpgPtNGW5HhD2bTQZn4UVfkDPzGCDaOREAoCBRKe1pfoMaN+1FyM
 lX/rQsdCpVUIDEYrxUmET6ULU04aqlnJy3zJOVpvz04uSRQXLyc9+7Js8WgPqDCay/o/uqg0
 N5OJFhzQHwgAE8+yqkdrpmRCovKeQaK++Y3xsEpAZ3oHzek2EVFmQ10Q==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 1/2] runqemu: support .tar.zst, .tar,xz, .tar rootfs archives
Date: Tue, 20 Jan 2026 06:54:05 +0100
Message-ID: <20260120055500.1749670-2-adrian.freihofer@siemens.com>
In-Reply-To: <20260120055500.1749670-1-adrian.freihofer@siemens.com>
References: <20260120055500.1749670-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 05:55:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18809

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Split the tar types into a separate list and use it where needed.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 scripts/runqemu | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/scripts/runqemu b/scripts/runqemu
index 370b455781..32a3d6296a 100755
--- a/scripts/runqemu
+++ b/scripts/runqemu
@@ -198,9 +198,9 @@ class BaseConfig(object):
         self.bitbake_e = ''
         self.snapshot = False
         self.wictypes = ('wic.zst', 'wic', 'wic.vmdk', 'wic.qcow2', 'wic.vdi', "wic.vhd", "wic.vhdx")
+        self.tartypes = ('tar.zst', 'tar.bz2', 'tar.gz', 'tar.xz', 'tar')
         self.fstypes = ('ext2', 'ext3', 'ext4', 'ext2.zst', 'ext3.zst', 'ext4.zst',
                         'jffs2', 'nfs', 'btrfs', 'cpio.gz', 'cpio', 'ramfs',
-                        'tar.bz2', 'tar.gz', 'tar.zst',
                         'squashfs', 'squashfs-xz', 'squashfs-lzo',
                         'squashfs-lz4', 'squashfs-zst',
                         'erofs', 'erofs-lz4', 'erofs-lz4hc')
@@ -335,12 +335,12 @@ class BaseConfig(object):
 
     def check_arg_fstype(self, fst):
         """Check and set FSTYPE"""
-        if fst not in self.fstypes + self.vmtypes + self.wictypes:
+        if fst not in self.fstypes + self.vmtypes + self.wictypes + self.tartypes:
             logger.warning("Maybe unsupported FSTYPE: %s" % fst)
         if not self.fstype or self.fstype == fst:
             if fst == 'ramfs':
                 fst = 'cpio.gz'
-            if fst in ('tar.bz2', 'tar.gz'):
+            if fst in self.tartypes:
                 fst = 'nfs'
             self.fstype = fst
         else:
@@ -383,7 +383,7 @@ class BaseConfig(object):
             # Check filename against self.fstypes can handle <file>.cpio.gz,
             # otherwise, its type would be "gz", which is incorrect.
             fst = ""
-            for t in self.fstypes + self.vmtypes + self.wictypes:
+            for t in self.fstypes + self.vmtypes + self.wictypes + self.tartypes:
                 if p.endswith(t):
                     fst = t
                     break
@@ -543,7 +543,7 @@ to your build configuration.
 
         unknown_arg = ""
         for arg in sys.argv[1:]:
-            if arg in self.fstypes + self.vmtypes + self.wictypes:
+            if arg in self.fstypes + self.vmtypes + self.wictypes + self.tartypes:
                 self.check_arg_fstype(arg)
             elif arg == 'nographic':
                 self.nographic = True
@@ -1074,7 +1074,7 @@ to your build configuration.
 
         self.unfs_opts="nfsvers=3,port=%s,tcp,mountport=%s%s" % (nfsd_port, mountd_port, qb_nfsrootfs_extra_opt)
 
-        # Extract .tar.bz2 or .tar.bz if no nfs dir
+        # Extract .tar* if no nfs dir
         if not (self.rootfs and os.path.isdir(self.rootfs)):
             src_prefix = '%s/%s' % (self.get('DEPLOY_DIR_IMAGE'), self.get('IMAGE_LINK_NAME'))
             dest = "%s-nfsroot" % src_prefix
@@ -1083,14 +1083,13 @@ to your build configuration.
                 self.rootfs = dest
             else:
                 src = ""
-                src1 = '%s.tar.bz2' % src_prefix
-                src2 = '%s.tar.gz' % src_prefix
-                if os.path.exists(src1):
-                    src = src1
-                elif os.path.exists(src2):
-                    src = src2
+                for s in self.tartypes:
+                    candidate = '%s.%s' % (src_prefix, s)
+                    if os.path.exists(candidate):
+                        src = candidate
+                        break
                 if not src:
-                    raise RunQemuError("No NFS_DIR is set, and can't find %s or %s to extract" % (src1, src2))
+                    raise RunQemuError("No NFS_DIR is set, and can't find %s.[%s] to extract" % (src_prefix, '|'.join(self.tartypes)))
                 logger.info('NFS_DIR not found, extracting %s to %s' % (src, dest))
                 cmd = ('runqemu-extract-sdk', src, dest)
                 logger.info('Running %s...' % str(cmd))
-- 
2.52.0


