Return-Path: <sven.schwermer@disruptive-technologies.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53453C25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 10:56:49 +0000 (UTC)
Subject: Pseudo errors in lib/bb/__pycache__ #bitbake
To: bitbake-devel@lists.openembedded.org
From: "Sven" <sven.schwermer@disruptive-technologies.com>
X-Originating-Location: Asker, Viken, NO (84.213.213.125)
X-Originating-Platform: Linux Chrome 125
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 29 May 2024 03:56:41 -0700
Message-ID: <8fJ7.1716980201481658392.yosx@lists.openembedded.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 May 2024 10:56:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16278

Hi,

I'm using Yocto 5.0 (scarthgap) which comes with bitbake 2.8. Since migrati=
ng from kirkstone (bitbake 2.0), I have started seeing pseudo abort errors =
like these:

NOTE: recipe IMAGE-1.0-r0: task do_rootfs: Failed
ERROR: Task (poky/../LAYER/recipes-core/images/IMAGE.bb:do_rootfs) failed w=
ith exit code '1'=20
Pseudo log:
path mismatch [1 link]: ino 1879965 db 'poky/bitbake/lib/bb/__pycache__/__i=
nit__.cpython-312.pyc' req 'build/tmp/work/MACHINE-poky-linux-gnueabi/IMAGE=
/1.0/rootfs/var/lib/opkg/info/jq.postinst'.
creat for 'build/tmp/work/MACHINE-poky-linux-gnueabi/IMAGE/1.0/rootfs/var/l=
ib/opkg/info/jq.control' replaces existing 1879952 ['build/tmp/work/MACHINE=
-poky-linux-gnueabi/IMAGE/1.0/data.ext4'].
symlink err : 1879909 ['build/tmp/work/MACHINE-poky-linux-gnueabi/IMAGE/1.0=
/rootfs/var/cache/opkg/volatile.211108/aae1283bc69272c07742f9861f12b8d8_jq_=
1.7.1-r0_cortexa7t2hf-neon-vfpv4.ipk'] (db 'build/tmp/work/MACHINE-poky-lin=
ux-gnueabi/IMAGE/1.0/boot.vfat') db mode 0100644, header mode 0120777 (unli=
nking db)


ERROR: Task (poky/../LAYER/recipes-core/images/IMAGE.bb:do_rootfs) failed w=
ith exit code '134'
Pseudo log:
path mismatch [1 link]: ino 1081932 db 'poky/bitbake/lib/bb/fetch2/__pycach=
e__/clearcase.cpython-312.pyc' req 'poky/meta/lib/oe/package_manager/ipk/__=
pycache__/__init__.cpython-311.pyc'.

This occurs both on Ubuntu 20.04 (former) and Debian Bookworm (latter). Wha=
t is this caused by and how can I resolve this issue?

Thanks,
Sven

