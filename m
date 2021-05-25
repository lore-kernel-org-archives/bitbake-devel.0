Received: from lilium.sigma-star.at (lilium.sigma-star.at [109.75.188.150])
 by mx.groups.io with SMTP id smtpd.web08.8241.1621940703399573549
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 May 2021 04:05:04 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=permerror, err=syntax error for token:  (domain: nod.at, ip: 109.75.188.150, mailfrom: richard@nod.at)
Received: from localhost (localhost [127.0.0.1])
	by lilium.sigma-star.at (Postfix) with ESMTP id BF8E81817A0D5;
	Tue, 25 May 2021 13:04:51 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
	by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 72H_4T5Dd4uG; Tue, 25 May 2021 13:04:51 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
	by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dqKnh9vnpXHN; Tue, 25 May 2021 13:04:50 +0200 (CEST)
From: "Richard Weinberger" <richard@nod.at>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org,
	docs@lists.yoctoproject.org
Cc: Richard Weinberger <richard@nod.at>
Subject: [OE-core][PATCH] Add support for erofs filesystems
Date: Tue, 25 May 2021 13:04:27 +0200
Message-Id: <20210525110429.738-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since Linux 5.4 a new read-only filesystem is available, erofs.
Compared to squashfs it offers much better read performance with and
without compression enabled.
It suppports two optional compressors, lz4 and lz4hc.

From the mkfs.erofs man page:
EROFS is a new enhanced lightweight linux read-only filesystem with
modern designs (eg. no buffer head, reduced metadata, inline
xattrs/data, etc.) for scenarios which need high-performance read-only
requirements, e.g. Android OS for smartphones and LIVECDs.
It also provides fixed-sized output compression support, which improves
storage density, keeps relatively higher compression ratios, which is
more useful to achieve high performance for embedded devices with
limited  memory since it has unnoticable memory overhead and page cache
thrashing.

This commit adds support for three new filesystem targets:
erofs: erofs without compression
erofs-lz4: erofs with lz4 compresssion enabled
erofs-lz4hc: erofs with lz4hc compression enabled

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 meta/classes/image_types.bbclass               |  9 +++++++++
 .../erofs-utils/erofs-utils_git.bb             | 18 ++++++++++++++++++
 scripts/lib/wic/help.py                        |  1 +
 scripts/lib/wic/ksparser.py                    |  7 ++++++-
 scripts/lib/wic/partition.py                   | 16 +++++++++++++---
 scripts/lib/wic/plugins/source/rawcopy.py      |  6 +++---
 6 files changed, 50 insertions(+), 7 deletions(-)
 create mode 100644 meta/recipes-devtools/erofs-utils/erofs-utils_git.bb

diff --git a/meta/classes/image_types.bbclass b/meta/classes/image_types.=
bbclass
index 8028691405a7..4e95e0e2935e 100644
--- a/meta/classes/image_types.bbclass
+++ b/meta/classes/image_types.bbclass
@@ -108,6 +108,11 @@ IMAGE_CMD_squashfs-xz =3D "mksquashfs ${IMAGE_ROOTFS=
} ${IMGDEPLOYDIR}/${IMAGE_NAME
 IMAGE_CMD_squashfs-lzo =3D "mksquashfs ${IMAGE_ROOTFS} ${IMGDEPLOYDIR}/$=
{IMAGE_NAME}${IMAGE_NAME_SUFFIX}.squashfs-lzo ${EXTRA_IMAGECMD} -noappend=
 -comp lzo"
 IMAGE_CMD_squashfs-lz4 =3D "mksquashfs ${IMAGE_ROOTFS} ${IMGDEPLOYDIR}/$=
{IMAGE_NAME}${IMAGE_NAME_SUFFIX}.squashfs-lz4 ${EXTRA_IMAGECMD} -noappend=
 -comp lz4"
=20
+IMAGE_CMD_erofs =3D "mkfs.erofs ${EXTRA_IMAGECMD} ${IMGDEPLOYDIR}/${IMAG=
E_NAME}${IMAGE_NAME_SUFFIX}.erofs ${IMAGE_ROOTFS}"
+IMAGE_CMD_erofs-lz4 =3D "mkfs.erofs -zlz4 ${EXTRA_IMAGECMD} ${IMGDEPLOYD=
IR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.erofs-lz4 ${IMAGE_ROOTFS}"
+IMAGE_CMD_erofs-lz4hc =3D "mkfs.erofs -zlz4hc ${EXTRA_IMAGECMD} ${IMGDEP=
LOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.erofs-lz4hc ${IMAGE_ROOTFS}"
+
+
 IMAGE_CMD_TAR ?=3D "tar"
 # ignore return code 1 "file changed as we read it" as other tasks(e.g. =
do_image_wic) may be hardlinking rootfs
 IMAGE_CMD_tar =3D "${IMAGE_CMD_TAR} --sort=3Dname --format=3Dposix --num=
eric-owner -cf ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.tar -C $=
{IMAGE_ROOTFS} . || [ $? -eq 1 ]"
@@ -243,6 +248,9 @@ do_image_ubi[depends] +=3D "mtd-utils-native:do_popul=
ate_sysroot"
 do_image_ubifs[depends] +=3D "mtd-utils-native:do_populate_sysroot"
 do_image_multiubi[depends] +=3D "mtd-utils-native:do_populate_sysroot"
 do_image_f2fs[depends] +=3D "f2fs-tools-native:do_populate_sysroot"
+do_image_erofs[depends] +=3D "erofs-utils-native:do_populate_sysroot"
+do_image_erofs_lz4[depends] +=3D "erofs-utils-native:do_populate_sysroot=
"
+do_image_erofs_lz4hc[depends] +=3D "erofs-utils-native:do_populate_sysro=
ot"
=20
 # This variable is available to request which values are suitable for IM=
AGE_FSTYPES
 IMAGE_TYPES =3D " \
@@ -261,6 +269,7 @@ IMAGE_TYPES =3D " \
     wic wic.gz wic.bz2 wic.lzma wic.zst \
     container \
     f2fs \
+    erofs \
 "
=20
 # Compression is a special case of conversion. The old variable
diff --git a/meta/recipes-devtools/erofs-utils/erofs-utils_git.bb b/meta/=
recipes-devtools/erofs-utils/erofs-utils_git.bb
new file mode 100644
index 000000000000..6d35d3f2fa6d
--- /dev/null
+++ b/meta/recipes-devtools/erofs-utils/erofs-utils_git.bb
@@ -0,0 +1,18 @@
+SUMMARY =3D "Tools for erofs filesystems"
+LICENSE =3D "GPLv2"
+SECTION =3D "base"
+LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D94fa01670a2a8f2d3ab2de15004e0=
848"
+
+PV =3D "1.2.1"
+SRCREV =3D "d1f4953edfcf4f51c71ba91586e21fc6ce9f6db9"
+SRC_URI =3D "git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-u=
tils.git"
+
+S =3D "${WORKDIR}/git"
+
+DEPENDS =3D "util-linux-libuuid lz4"
+
+inherit pkgconfig autotools
+
+EXTRA_OECONF =3D "--enable-lz4 --disable-fuse"
+
+BBCLASSEXTEND =3D "native nativesdk"
diff --git a/scripts/lib/wic/help.py b/scripts/lib/wic/help.py
index bd3a2b97dfaf..991e5094bb84 100644
--- a/scripts/lib/wic/help.py
+++ b/scripts/lib/wic/help.py
@@ -930,6 +930,7 @@ DESCRIPTION
              ext4
              btrfs
              squashfs
+             erofs
              swap
=20
          --fsoptions: Specifies a free-form string of options to be
diff --git a/scripts/lib/wic/ksparser.py b/scripts/lib/wic/ksparser.py
index 3eb669da39ca..7a4cc83af556 100644
--- a/scripts/lib/wic/ksparser.py
+++ b/scripts/lib/wic/ksparser.py
@@ -157,7 +157,8 @@ class KickStart():
         part.add_argument('--fsoptions', dest=3D'fsopts')
         part.add_argument('--fstype', default=3D'vfat',
                           choices=3D('ext2', 'ext3', 'ext4', 'btrfs',
-                                   'squashfs', 'vfat', 'msdos', 'swap'))
+                                   'squashfs', 'vfat', 'msdos', 'erofs',
+                                   'swap'))
         part.add_argument('--mkfs-extraopts', default=3D'')
         part.add_argument('--label')
         part.add_argument('--use-label', action=3D'store_true')
@@ -229,6 +230,10 @@ class KickStart():
                                 err =3D "%s:%d: SquashFS does not suppor=
t LABEL" \
                                        % (confpath, lineno)
                                 raise KickStartError(err)
+                        # erofs does not support filesystem labels
+                        if parsed.fstype =3D=3D 'erofs' and parsed.label=
:
+                            err =3D "%s:%d: erofs does not support LABEL=
" % (confpath, lineno)
+                            raise KickStartError(err)
                         if parsed.fstype =3D=3D 'msdos' or parsed.fstype=
 =3D=3D 'vfat':
                             if parsed.fsuuid:
                                 if parsed.fsuuid.upper().startswith('0X'=
):
diff --git a/scripts/lib/wic/partition.py b/scripts/lib/wic/partition.py
index 76d144d12d30..e0b2c5bdf29b 100644
--- a/scripts/lib/wic/partition.py
+++ b/scripts/lib/wic/partition.py
@@ -141,9 +141,9 @@ class Partition():
                                             native_sysroot)
                 self.source_file =3D "%s/fs.%s" % (cr_workdir, self.fsty=
pe)
             else:
-                if self.fstype =3D=3D 'squashfs':
-                    raise WicError("It's not possible to create empty sq=
uashfs "
-                                   "partition '%s'" % (self.mountpoint))
+                if self.fstype in ('squashfs', 'erofs'):
+                    raise WicError("It's not possible to create empty %s=
 "
+                                   "partition '%s'" % (self.fstype, self=
.mountpoint))
=20
                 rootfs =3D "%s/fs_%s.%s.%s" % (cr_workdir, self.label,
                                              self.lineno, self.fstype)
@@ -369,6 +369,16 @@ class Partition():
                        (rootfs_dir, rootfs, extraopts)
         exec_native_cmd(squashfs_cmd, native_sysroot, pseudo=3Dpseudo)
=20
+    def prepare_rootfs_erofs(self, rootfs, cr_workdir, oe_builddir, root=
fs_dir,
+                             native_sysroot, pseudo):
+        """
+        Prepare content for a erofs rootfs partition.
+        """
+        extraopts =3D self.mkfs_extraopts or ''
+        erofs_cmd =3D "mkfs.erofs %s -U %s %s %s" % \
+                       (extraopts, self.fsuuid, rootfs, rootfs_dir)
+        exec_native_cmd(erofs_cmd, native_sysroot, pseudo=3Dpseudo)
+
     def prepare_empty_partition_ext(self, rootfs, oe_builddir,
                                     native_sysroot):
         """
diff --git a/scripts/lib/wic/plugins/source/rawcopy.py b/scripts/lib/wic/=
plugins/source/rawcopy.py
index 3c4997d8ba5e..fa7b1eb8ac75 100644
--- a/scripts/lib/wic/plugins/source/rawcopy.py
+++ b/scripts/lib/wic/plugins/source/rawcopy.py
@@ -29,9 +29,9 @@ class RawCopyPlugin(SourcePlugin):
             cmd =3D 'btrfs filesystem label %s %s' % (dst, label)
         elif fstype =3D=3D 'swap':
             cmd =3D 'mkswap -L %s %s' % (label, dst)
-        elif fstype =3D=3D 'squashfs':
-            raise WicError("It's not possible to update a squashfs "
-                           "filesystem label '%s'" % (label))
+        elif fstype in ('squashfs', 'erofs'):
+            raise WicError("It's not possible to update a %s "
+                           "filesystem label '%s'" % (fstype, label))
         else:
             raise WicError("Cannot update filesystem label: "
                            "Unknown fstype: '%s'" % (fstype))
--=20
2.26.2

