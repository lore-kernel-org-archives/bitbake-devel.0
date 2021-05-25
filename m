Received: from EUR06-VI1-obe.outbound.protection.outlook.com (EUR06-VI1-obe.outbound.protection.outlook.com [40.92.17.74])
 by mx.groups.io with SMTP id smtpd.web08.8300.1621941079323768461
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 May 2021 04:11:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=qKzvBt38;
 spf=pass (domain: outlook.com, ip: 40.92.17.74, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=El/1/GHDo2RQgUgFi+KPGZRdiKhSL/YKFZrrz0LXUlEqZ8VrgNYHnfMIa2IOmt0+Z6QiWi/nZZp6T1TfBASgYQObI1nHQDIZeKTh1oEIB5EQg5WVQx4B7I6q+VRiDUhxdbevI6HrkOFhQ6TIt2BxzYbN37X/cI17wNvWjDaHP89Ge5y+xLcksIABYBZ0DSYaTYhOM4/mOeS5puKIRG3OhUdFN57iayaXvZuklEbTN2DzpMMREtW6N9/UgaAZ3xsqxW39dP0TKng/9avPCyIoiCnFwKy1abFdISMbOasg26ZNFOszNbhpk3LsyC3Y4hbu0wpi3oM2p+f3yaC299UNQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwTi6WtD12CuK/M8sylUSvZUPj242ZEnphK3252SaFM=;
 b=V41eqcwh11i99FXRKYGEidW4S/lzuqp9NQS/Pm9ZjYRlhUiUDUwqM+OrLfRu4e8iGj70cQwwaQDJyEAvpga0xhw7Omp2FZci9x4XorFOuwhBj8OBLPTau2bYp7y9XThfX+cpu18t4iExdgDxunmNTEXhamX/fljfqkbrHj53ABxEA2wn2UyhtDj0yBKn150M/c9GtME6mlhhKsGGJrkHyvtsew6FpEjV3Cr5OtmsuGxFK8UkcK50a8TBGtNNVo/cgwVzgJlodi5ToqqMjKsy54CmUMMnM2sNvWTKJkzM+BKcP88PGUa2rphw6HlbrKLyZrmSHK5LB+IFUjRHT0NSCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwTi6WtD12CuK/M8sylUSvZUPj242ZEnphK3252SaFM=;
 b=qKzvBt38pkKY77zNtOsNhaHnBwnCBqc74iaSDEK2dFQV85PFIJZ2kvtCbG884piQr+tbmzJzv8jjd2yDaJ1iodhoEJEi3bkq7vfp2Begf6fj7q35E0/mfXtlz/rxw6h2VvpOWHdNuI8KNDpb9E5LjGUqJh+K5j611Wkc7kKUxtV18ze0QaJO6f0LH29Ruu+hHIUx3xQ2+8YMlAnrBCBBK48A0cAt8/YYSQShSXU9jPUlBpG/y6+YVUk2qAxA1L6yJ0c1cOk41brAdSCgzekvMyHIt1nnP+ADdI9nN2FtWLcA2t/LRqL8dq5/iyd7cckqd8cYdpefc6sSwVq0gD97mA==
Received: from DB8EUR06FT008.eop-eur06.prod.protection.outlook.com
 (2a01:111:e400:fc35::4c) by
 DB8EUR06HT149.eop-eur06.prod.protection.outlook.com (2a01:111:e400:fc35::158)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 25 May
 2021 11:11:17 +0000
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com
 (2a01:111:e400:fc35::44) by DB8EUR06FT008.mail.protection.outlook.com
 (2a01:111:e400:fc35::95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend
 Transport; Tue, 25 May 2021 11:11:17 +0000
X-IncomingTopHeaderMarker: 
 OriginalChecksum:4D164FE06A49CC4E4301224CD89E80EEBDDB920EF2E5BD5C7049630598C7A7CC;UpperCasedChecksum:B62D9B35103E2F33FEC3BDF2AA7228D330A46E42DEA8AFC1818A00D4E6518AE0;SizeAsReceived:8737;Count:47
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::9c9b:9858:17df:de84]) by AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::9c9b:9858:17df:de84%6]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 11:11:17 +0000
Subject: Re: [bitbake-devel] [OE-core][PATCH] Add support for erofs filesystems
To: Richard Weinberger <richard@nod.at>,
 openembedded-core@lists.openembedded.org,
 bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
References: <20210525110429.738-1-richard@nod.at>
From: "Konrad Weihmann" <kweihmann@outlook.com>
Message-ID: 
 <AM9PR09MB46426BCB13C172A8FBB3DF94A8259@AM9PR09MB4642.eurprd09.prod.outlook.com>
Date: Tue, 25 May 2021 13:11:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210525110429.738-1-richard@nod.at>
X-TMN: [wn9Zlq8n6u3zidXOA2xg+2bTKt5K4XNl]
X-ClientProxiedBy: AM5PR0701CA0015.eurprd07.prod.outlook.com
 (2603:10a6:203:51::25) To AM9PR09MB4642.eurprd09.prod.outlook.com
 (2603:10a6:20b:284::24)
Return-Path: kweihmann@outlook.com
X-Microsoft-Original-Message-ID: 
 <8938fa81-73b6-f5d6-54e9-728e4cf24297@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.188.23] (87.141.92.163) by AM5PR0701CA0015.eurprd07.prod.outlook.com (2603:10a6:203:51::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend Transport; Tue, 25 May 2021 11:11:16 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 6a9a0e52-ebbf-4358-a829-08d91f6dd0f6
X-MS-TrafficTypeDiagnostic: DB8EUR06HT149:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	muqio7wMfkzaA3UxadlGBALqy91D8QlcEIa2PFV5Cvv0zLGCgIUyYbqfOPyRHDmTP/48K0Klz7BRPckellAHNg7afqFRikwknjSgtSm2RYpv/zHF+hZWyAQd3QH5WzAypd4BjWb4R26SdvdnddbL94CQWxOW1Jw9na5tGkZEC6Rk/YiUVjdXMni0EfLstaqVoI9i8A3Rzh+PVusQBqCNRpzT5TZTnotxudB1B4e1J5AfG7ys5o4/XPPvZX+ZJNnhZLQSP5kccdpsflR9gsHVj6e7q0kalNQ7bTGK2p49dWkrFB2rJk9z46vhBxTqEuFlIFNKZ3lr2SrAlJfe+HpwmEzffEYc9rC2L0EpDcbcULFqLZ4BGOn7ufnY+SxrrBDyxfLm9xxHpDjjrW3mJ5yGqcoO7J+LYTl/v/y1+XIuM3KObvMNR2eipzgJjjBkPTolnKEjPbFyo8157L4kKXaTRw==
X-MS-Exchange-AntiSpam-MessageData: 
	b4Oek+5b9DL+Ri1me3/EViav3/tSBQJ0hwOO5N/zlstuh2H1IieuHftGngWIwl0ahGc1r/8mnC23Wa579r0PafBtWTBprNA4eu+zJQc6xUCCGl69+RG5Xnbc/4nlKttEGTrdmQ05hSPCuLGSPUTwLQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9a0e52-ebbf-4358-a829-08d91f6dd0f6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 11:11:16.9448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: 
	DB8EUR06FT008.eop-eur06.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8EUR06HT149
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 25.05.21 13:04, Richard Weinberger wrote:
> Since Linux 5.4 a new read-only filesystem is available, erofs.
> Compared to squashfs it offers much better read performance with and
> without compression enabled.
> It suppports two optional compressors, lz4 and lz4hc.
> 
>  From the mkfs.erofs man page:
> EROFS is a new enhanced lightweight linux read-only filesystem with
> modern designs (eg. no buffer head, reduced metadata, inline
> xattrs/data, etc.) for scenarios which need high-performance read-only
> requirements, e.g. Android OS for smartphones and LIVECDs.
> It also provides fixed-sized output compression support, which improves
> storage density, keeps relatively higher compression ratios, which is
> more useful to achieve high performance for embedded devices with
> limited  memory since it has unnoticable memory overhead and page cache
> thrashing.
> 
> This commit adds support for three new filesystem targets:
> erofs: erofs without compression
> erofs-lz4: erofs with lz4 compresssion enabled
> erofs-lz4hc: erofs with lz4hc compression enabled
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>   meta/classes/image_types.bbclass               |  9 +++++++++
>   .../erofs-utils/erofs-utils_git.bb             | 18 ++++++++++++++++++
>   scripts/lib/wic/help.py                        |  1 +
>   scripts/lib/wic/ksparser.py                    |  7 ++++++-
>   scripts/lib/wic/partition.py                   | 16 +++++++++++++---
>   scripts/lib/wic/plugins/source/rawcopy.py      |  6 +++---
>   6 files changed, 50 insertions(+), 7 deletions(-)
>   create mode 100644 meta/recipes-devtools/erofs-utils/erofs-utils_git.bb
> 
> diff --git a/meta/classes/image_types.bbclass b/meta/classes/image_types.bbclass
> index 8028691405a7..4e95e0e2935e 100644
> --- a/meta/classes/image_types.bbclass
> +++ b/meta/classes/image_types.bbclass
> @@ -108,6 +108,11 @@ IMAGE_CMD_squashfs-xz = "mksquashfs ${IMAGE_ROOTFS} ${IMGDEPLOYDIR}/${IMAGE_NAME
>   IMAGE_CMD_squashfs-lzo = "mksquashfs ${IMAGE_ROOTFS} ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.squashfs-lzo ${EXTRA_IMAGECMD} -noappend -comp lzo"
>   IMAGE_CMD_squashfs-lz4 = "mksquashfs ${IMAGE_ROOTFS} ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.squashfs-lz4 ${EXTRA_IMAGECMD} -noappend -comp lz4"
>   
> +IMAGE_CMD_erofs = "mkfs.erofs ${EXTRA_IMAGECMD} ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.erofs ${IMAGE_ROOTFS}"
> +IMAGE_CMD_erofs-lz4 = "mkfs.erofs -zlz4 ${EXTRA_IMAGECMD} ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.erofs-lz4 ${IMAGE_ROOTFS}"
> +IMAGE_CMD_erofs-lz4hc = "mkfs.erofs -zlz4hc ${EXTRA_IMAGECMD} ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.erofs-lz4hc ${IMAGE_ROOTFS}"
> +
> +
>   IMAGE_CMD_TAR ?= "tar"
>   # ignore return code 1 "file changed as we read it" as other tasks(e.g. do_image_wic) may be hardlinking rootfs
>   IMAGE_CMD_tar = "${IMAGE_CMD_TAR} --sort=name --format=posix --numeric-owner -cf ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.tar -C ${IMAGE_ROOTFS} . || [ $? -eq 1 ]"
> @@ -243,6 +248,9 @@ do_image_ubi[depends] += "mtd-utils-native:do_populate_sysroot"
>   do_image_ubifs[depends] += "mtd-utils-native:do_populate_sysroot"
>   do_image_multiubi[depends] += "mtd-utils-native:do_populate_sysroot"
>   do_image_f2fs[depends] += "f2fs-tools-native:do_populate_sysroot"
> +do_image_erofs[depends] += "erofs-utils-native:do_populate_sysroot"
> +do_image_erofs_lz4[depends] += "erofs-utils-native:do_populate_sysroot"
> +do_image_erofs_lz4hc[depends] += "erofs-utils-native:do_populate_sysroot"
>   
>   # This variable is available to request which values are suitable for IMAGE_FSTYPES
>   IMAGE_TYPES = " \
> @@ -261,6 +269,7 @@ IMAGE_TYPES = " \
>       wic wic.gz wic.bz2 wic.lzma wic.zst \
>       container \
>       f2fs \
> +    erofs \
>   "
>   
>   # Compression is a special case of conversion. The old variable
> diff --git a/meta/recipes-devtools/erofs-utils/erofs-utils_git.bb b/meta/recipes-devtools/erofs-utils/erofs-utils_git.bb
> new file mode 100644
> index 000000000000..6d35d3f2fa6d
> --- /dev/null
> +++ b/meta/recipes-devtools/erofs-utils/erofs-utils_git.bb
> @@ -0,0 +1,18 @@
> +SUMMARY = "Tools for erofs filesystems"
> +LICENSE = "GPLv2"
> +SECTION = "base"
> +LIC_FILES_CHKSUM = "file://COPYING;md5=94fa01670a2a8f2d3ab2de15004e0848"
> +
> +PV = "1.2.1"
> +SRCREV = "d1f4953edfcf4f51c71ba91586e21fc6ce9f6db9"
> +SRC_URI = "git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git"
> +
> +S = "${WORKDIR}/git"
> +
> +DEPENDS = "util-linux-libuuid lz4"
> +
> +inherit pkgconfig autotools
> +
> +EXTRA_OECONF = "--enable-lz4 --disable-fuse"

In the commit message it's mentioned that compression is optional, still 
here lz4 is enabled by default - I would rather see these compression 
switches configurable via PACKAGECONFIG

> +
> +BBCLASSEXTEND = "native nativesdk"
> diff --git a/scripts/lib/wic/help.py b/scripts/lib/wic/help.py
> index bd3a2b97dfaf..991e5094bb84 100644
> --- a/scripts/lib/wic/help.py
> +++ b/scripts/lib/wic/help.py
> @@ -930,6 +930,7 @@ DESCRIPTION
>                ext4
>                btrfs
>                squashfs
> +             erofs
>                swap
>   
>            --fsoptions: Specifies a free-form string of options to be
> diff --git a/scripts/lib/wic/ksparser.py b/scripts/lib/wic/ksparser.py
> index 3eb669da39ca..7a4cc83af556 100644
> --- a/scripts/lib/wic/ksparser.py
> +++ b/scripts/lib/wic/ksparser.py
> @@ -157,7 +157,8 @@ class KickStart():
>           part.add_argument('--fsoptions', dest='fsopts')
>           part.add_argument('--fstype', default='vfat',
>                             choices=('ext2', 'ext3', 'ext4', 'btrfs',
> -                                   'squashfs', 'vfat', 'msdos', 'swap'))
> +                                   'squashfs', 'vfat', 'msdos', 'erofs',
> +                                   'swap'))
>           part.add_argument('--mkfs-extraopts', default='')
>           part.add_argument('--label')
>           part.add_argument('--use-label', action='store_true')
> @@ -229,6 +230,10 @@ class KickStart():
>                                   err = "%s:%d: SquashFS does not support LABEL" \
>                                          % (confpath, lineno)
>                                   raise KickStartError(err)
> +                        # erofs does not support filesystem labels
> +                        if parsed.fstype == 'erofs' and parsed.label:
> +                            err = "%s:%d: erofs does not support LABEL" % (confpath, lineno)
> +                            raise KickStartError(err)
>                           if parsed.fstype == 'msdos' or parsed.fstype == 'vfat':
>                               if parsed.fsuuid:
>                                   if parsed.fsuuid.upper().startswith('0X'):
> diff --git a/scripts/lib/wic/partition.py b/scripts/lib/wic/partition.py
> index 76d144d12d30..e0b2c5bdf29b 100644
> --- a/scripts/lib/wic/partition.py
> +++ b/scripts/lib/wic/partition.py
> @@ -141,9 +141,9 @@ class Partition():
>                                               native_sysroot)
>                   self.source_file = "%s/fs.%s" % (cr_workdir, self.fstype)
>               else:
> -                if self.fstype == 'squashfs':
> -                    raise WicError("It's not possible to create empty squashfs "
> -                                   "partition '%s'" % (self.mountpoint))
> +                if self.fstype in ('squashfs', 'erofs'):
> +                    raise WicError("It's not possible to create empty %s "
> +                                   "partition '%s'" % (self.fstype, self.mountpoint))
>   
>                   rootfs = "%s/fs_%s.%s.%s" % (cr_workdir, self.label,
>                                                self.lineno, self.fstype)
> @@ -369,6 +369,16 @@ class Partition():
>                          (rootfs_dir, rootfs, extraopts)
>           exec_native_cmd(squashfs_cmd, native_sysroot, pseudo=pseudo)
>   
> +    def prepare_rootfs_erofs(self, rootfs, cr_workdir, oe_builddir, rootfs_dir,
> +                             native_sysroot, pseudo):
> +        """
> +        Prepare content for a erofs rootfs partition.
> +        """
> +        extraopts = self.mkfs_extraopts or ''
> +        erofs_cmd = "mkfs.erofs %s -U %s %s %s" % \
> +                       (extraopts, self.fsuuid, rootfs, rootfs_dir)
> +        exec_native_cmd(erofs_cmd, native_sysroot, pseudo=pseudo)
> +
>       def prepare_empty_partition_ext(self, rootfs, oe_builddir,
>                                       native_sysroot):
>           """
> diff --git a/scripts/lib/wic/plugins/source/rawcopy.py b/scripts/lib/wic/plugins/source/rawcopy.py
> index 3c4997d8ba5e..fa7b1eb8ac75 100644
> --- a/scripts/lib/wic/plugins/source/rawcopy.py
> +++ b/scripts/lib/wic/plugins/source/rawcopy.py
> @@ -29,9 +29,9 @@ class RawCopyPlugin(SourcePlugin):
>               cmd = 'btrfs filesystem label %s %s' % (dst, label)
>           elif fstype == 'swap':
>               cmd = 'mkswap -L %s %s' % (label, dst)
> -        elif fstype == 'squashfs':
> -            raise WicError("It's not possible to update a squashfs "
> -                           "filesystem label '%s'" % (label))
> +        elif fstype in ('squashfs', 'erofs'):
> +            raise WicError("It's not possible to update a %s "
> +                           "filesystem label '%s'" % (fstype, label))
>           else:
>               raise WicError("Cannot update filesystem label: "
>                              "Unknown fstype: '%s'" % (fstype))
> 
> 
> 
> 
> 
