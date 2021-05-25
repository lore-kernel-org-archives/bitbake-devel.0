Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web08.4134.1621977352836348945
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 May 2021 14:15:53 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: 0leil.net, ip: 217.70.183.193, mailfrom: foss@0leil.net)
Received: (Authenticated sender: foss@0leil.net)
	by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E5DB2240002;
	Tue, 25 May 2021 21:15:49 +0000 (UTC)
Date: Tue, 25 May 2021 21:15:47 +0000
From: "Quentin Schulz" <foss@0leil.net>
To: docs@lists.yoctoproject.org, Richard Weinberger <richard@nod.at>,
 openembedded-core@lists.openembedded.org,
 bitbake-devel@lists.openembedded.org
Subject: Re: [docs] [OE-core][PATCH] Add support for erofs filesystems
In-Reply-To: <20210525110429.738-1-richard@nod.at>
References: <20210525110429.738-1-richard@nod.at>
Message-ID: <34B9CE63-084A-48A5-9386-862E48760070@0leil.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On May 25, 2021 11:04:27 AM UTC, Richard Weinberger <richard@nod=2Eat> wro=
te:
>Since Linux 5=2E4 a new read-only filesystem is available, erofs=2E
>Compared to squashfs it offers much better read performance with and
>without compression enabled=2E
>It suppports two optional compressors, lz4 and lz4hc=2E
>
>>From the mkfs=2Eerofs man page:
>EROFS is a new enhanced lightweight linux read-only filesystem with
>modern designs (eg=2E no buffer head, reduced metadata, inline
>xattrs/data, etc=2E) for scenarios which need high-performance read-only
>requirements, e=2Eg=2E Android OS for smartphones and LIVECDs=2E
>It also provides fixed-sized output compression support, which improves
>storage density, keeps relatively higher compression ratios, which is
>more useful to achieve high performance for embedded devices with
>limited  memory since it has unnoticable memory overhead and page cache
>thrashing=2E
>
>This commit adds support for three new filesystem targets:
>erofs: erofs without compression
>erofs-lz4: erofs with lz4 compresssion enabled
>erofs-lz4hc: erofs with lz4hc compression enabled
>
>Signed-off-by: Richard Weinberger <richard@nod=2Eat>
>---
> meta/classes/image_types=2Ebbclass               |  9 +++++++++
> =2E=2E=2E/erofs-utils/erofs-utils_git=2Ebb             | 18 ++++++++++++=
++++++
> scripts/lib/wic/help=2Epy                        |  1 +
> scripts/lib/wic/ksparser=2Epy                    |  7 ++++++-
> scripts/lib/wic/partition=2Epy                   | 16 +++++++++++++---
> scripts/lib/wic/plugins/source/rawcopy=2Epy      |  6 +++---
> 6 files changed, 50 insertions(+), 7 deletions(-)
> create mode 100644 meta/recipes-devtools/erofs-utils/erofs-utils_git=2Eb=
b
>
>diff --git a/meta/classes/image_types=2Ebbclass b/meta/classes/image_type=
s=2Ebbclass
>index 8028691405a7=2E=2E4e95e0e2935e 100644
>--- a/meta/classes/image_types=2Ebbclass
>+++ b/meta/classes/image_types=2Ebbclass
>@@ -108,6 +108,11 @@ IMAGE_CMD_squashfs-xz =3D "mksquashfs ${IMAGE_ROOTFS=
} ${IMGDEPLOYDIR}/${IMAGE_NAME
> IMAGE_CMD_squashfs-lzo =3D "mksquashfs ${IMAGE_ROOTFS} ${IMGDEPLOYDIR}/$=
{IMAGE_NAME}${IMAGE_NAME_SUFFIX}=2Esquashfs-lzo ${EXTRA_IMAGECMD} -noappend=
 -comp lzo"
> IMAGE_CMD_squashfs-lz4 =3D "mksquashfs ${IMAGE_ROOTFS} ${IMGDEPLOYDIR}/$=
{IMAGE_NAME}${IMAGE_NAME_SUFFIX}=2Esquashfs-lz4 ${EXTRA_IMAGECMD} -noappend=
 -comp lz4"
>=20
>+IMAGE_CMD_erofs =3D "mkfs=2Eerofs ${EXTRA_IMAGECMD} ${IMGDEPLOYDIR}/${IM=
AGE_NAME}${IMAGE_NAME_SUFFIX}=2Eerofs ${IMAGE_ROOTFS}"
>+IMAGE_CMD_erofs-lz4 =3D "mkfs=2Eerofs -zlz4 ${EXTRA_IMAGECMD} ${IMGDEPLO=
YDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}=2Eerofs-lz4 ${IMAGE_ROOTFS}"
>+IMAGE_CMD_erofs-lz4hc =3D "mkfs=2Eerofs -zlz4hc ${EXTRA_IMAGECMD} ${IMGD=
EPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}=2Eerofs-lz4hc ${IMAGE_ROOTFS}"
>+
>+
> IMAGE_CMD_TAR ?=3D "tar"
> # ignore return code 1 "file changed as we read it" as other tasks(e=2Eg=
=2E do_image_wic) may be hardlinking rootfs
> IMAGE_CMD_tar =3D "${IMAGE_CMD_TAR} --sort=3Dname --format=3Dposix --num=
eric-owner -cf ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}=2Etar -C $=
{IMAGE_ROOTFS} =2E || [ $? -eq 1 ]"
>@@ -243,6 +248,9 @@ do_image_ubi[depends] +=3D "mtd-utils-native:do_popul=
ate_sysroot"
> do_image_ubifs[depends] +=3D "mtd-utils-native:do_populate_sysroot"
> do_image_multiubi[depends] +=3D "mtd-utils-native:do_populate_sysroot"
> do_image_f2fs[depends] +=3D "f2fs-tools-native:do_populate_sysroot"
>+do_image_erofs[depends] +=3D "erofs-utils-native:do_populate_sysroot"
>+do_image_erofs_lz4[depends] +=3D "erofs-utils-native:do_populate_sysroot=
"
>+do_image_erofs_lz4hc[depends] +=3D "erofs-utils-native:do_populate_sysro=
ot"
>=20
> # This variable is available to request which values are suitable for IM=
AGE_FSTYPES
> IMAGE_TYPES =3D " \
>@@ -261,6 +269,7 @@ IMAGE_TYPES =3D " \
>     wic wic=2Egz wic=2Ebz2 wic=2Elzma wic=2Ezst \
>     container \
>     f2fs \
>+    erofs \

I think you're supposed to have erofs erofs-lz4 erofs-lz4hc here=2E

> "
>=20
> # Compression is a special case of conversion=2E The old variable
>diff --git a/meta/recipes-devtools/erofs-utils/erofs-utils_git=2Ebb b/met=
a/recipes-devtools/erofs-utils/erofs-utils_git=2Ebb
>new file mode 100644
>index 000000000000=2E=2E6d35d3f2fa6d
>--- /dev/null
>+++ b/meta/recipes-devtools/erofs-utils/erofs-utils_git=2Ebb

Any reason for using _git over _1=2E2=2E1?

>@@ -0,0 +1,18 @@
>+SUMMARY =3D "Tools for erofs filesystems"
>+LICENSE =3D "GPLv2"

GPL-2=2E0-or-later actually=2E

Thanks for the patch,
Cheers,
Quentin

>+SECTION =3D "base"
>+LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D94fa01670a2a8f2d3ab2de15004e0=
848"
>+
>+PV =3D "1=2E2=2E1"
>+SRCREV =3D "d1f4953edfcf4f51c71ba91586e21fc6ce9f6db9"
>+SRC_URI =3D "git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/xiang/ero=
fs-utils=2Egit"
>+
>+S =3D "${WORKDIR}/git"
>+
>+DEPENDS =3D "util-linux-libuuid lz4"
>+
>+inherit pkgconfig autotools
>+
>+EXTRA_OECONF =3D "--enable-lz4 --disable-fuse"
>+
>+BBCLASSEXTEND =3D "native nativesdk"
>diff --git a/scripts/lib/wic/help=2Epy b/scripts/lib/wic/help=2Epy
>index bd3a2b97dfaf=2E=2E991e5094bb84 100644
>--- a/scripts/lib/wic/help=2Epy
>+++ b/scripts/lib/wic/help=2Epy
>@@ -930,6 +930,7 @@ DESCRIPTION
>              ext4
>              btrfs
>              squashfs
>+             erofs
>              swap
>=20
>          --fsoptions: Specifies a free-form string of options to be
>diff --git a/scripts/lib/wic/ksparser=2Epy b/scripts/lib/wic/ksparser=2Ep=
y
>index 3eb669da39ca=2E=2E7a4cc83af556 100644
>--- a/scripts/lib/wic/ksparser=2Epy
>+++ b/scripts/lib/wic/ksparser=2Epy
>@@ -157,7 +157,8 @@ class KickStart():
>         part=2Eadd_argument('--fsoptions', dest=3D'fsopts')
>         part=2Eadd_argument('--fstype', default=3D'vfat',
>                           choices=3D('ext2', 'ext3', 'ext4', 'btrfs',
>-                                   'squashfs', 'vfat', 'msdos', 'swap'))
>+                                   'squashfs', 'vfat', 'msdos', 'erofs',
>+                                   'swap'))
>         part=2Eadd_argument('--mkfs-extraopts', default=3D'')
>         part=2Eadd_argument('--label')
>         part=2Eadd_argument('--use-label', action=3D'store_true')
>@@ -229,6 +230,10 @@ class KickStart():
>                                 err =3D "%s:%d: SquashFS does not suppor=
t LABEL" \
>                                        % (confpath, lineno)
>                                 raise KickStartError(err)
>+                        # erofs does not support filesystem labels
>+                        if parsed=2Efstype =3D=3D 'erofs' and parsed=2El=
abel:
>+                            err =3D "%s:%d: erofs does not support LABEL=
" % (confpath, lineno)
>+                            raise KickStartError(err)
>                         if parsed=2Efstype =3D=3D 'msdos' or parsed=2Efs=
type =3D=3D 'vfat':
>                             if parsed=2Efsuuid:
>                                 if parsed=2Efsuuid=2Eupper()=2Estartswit=
h('0X'):
>diff --git a/scripts/lib/wic/partition=2Epy b/scripts/lib/wic/partition=
=2Epy
>index 76d144d12d30=2E=2Ee0b2c5bdf29b 100644
>--- a/scripts/lib/wic/partition=2Epy
>+++ b/scripts/lib/wic/partition=2Epy
>@@ -141,9 +141,9 @@ class Partition():
>                                             native_sysroot)
>                 self=2Esource_file =3D "%s/fs=2E%s" % (cr_workdir, self=
=2Efstype)
>             else:
>-                if self=2Efstype =3D=3D 'squashfs':
>-                    raise WicError("It's not possible to create empty sq=
uashfs "
>-                                   "partition '%s'" % (self=2Emountpoint=
))
>+                if self=2Efstype in ('squashfs', 'erofs'):
>+                    raise WicError("It's not possible to create empty %s=
 "
>+                                   "partition '%s'" % (self=2Efstype, se=
lf=2Emountpoint))
>=20
>                 rootfs =3D "%s/fs_%s=2E%s=2E%s" % (cr_workdir, self=2Ela=
bel,
>                                              self=2Elineno, self=2Efstyp=
e)
>@@ -369,6 +369,16 @@ class Partition():
>                        (rootfs_dir, rootfs, extraopts)
>         exec_native_cmd(squashfs_cmd, native_sysroot, pseudo=3Dpseudo)
>=20
>+    def prepare_rootfs_erofs(self, rootfs, cr_workdir, oe_builddir, root=
fs_dir,
>+                             native_sysroot, pseudo):
>+        """
>+        Prepare content for a erofs rootfs partition=2E
>+        """
>+        extraopts =3D self=2Emkfs_extraopts or ''
>+        erofs_cmd =3D "mkfs=2Eerofs %s -U %s %s %s" % \
>+                       (extraopts, self=2Efsuuid, rootfs, rootfs_dir)
>+        exec_native_cmd(erofs_cmd, native_sysroot, pseudo=3Dpseudo)
>+
>     def prepare_empty_partition_ext(self, rootfs, oe_builddir,
>                                     native_sysroot):
>         """
>diff --git a/scripts/lib/wic/plugins/source/rawcopy=2Epy b/scripts/lib/wi=
c/plugins/source/rawcopy=2Epy
>index 3c4997d8ba5e=2E=2Efa7b1eb8ac75 100644
>--- a/scripts/lib/wic/plugins/source/rawcopy=2Epy
>+++ b/scripts/lib/wic/plugins/source/rawcopy=2Epy
>@@ -29,9 +29,9 @@ class RawCopyPlugin(SourcePlugin):
>             cmd =3D 'btrfs filesystem label %s %s' % (dst, label)
>         elif fstype =3D=3D 'swap':
>             cmd =3D 'mkswap -L %s %s' % (label, dst)
>-        elif fstype =3D=3D 'squashfs':
>-            raise WicError("It's not possible to update a squashfs "
>-                           "filesystem label '%s'" % (label))
>+        elif fstype in ('squashfs', 'erofs'):
>+            raise WicError("It's not possible to update a %s "
>+                           "filesystem label '%s'" % (fstype, label))
>         else:
>             raise WicError("Cannot update filesystem label: "
>                            "Unknown fstype: '%s'" % (fstype))
>--=20
>2=2E26=2E2
>

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
