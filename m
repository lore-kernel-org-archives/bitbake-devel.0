Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0258C4332F
	for <webhook@archiver.kernel.org>; Thu,  7 Oct 2021 16:27:20 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web08.807.1633624038957413388
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 09:27:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=permanent DNS error (domain: 0leil.net, ip: 217.70.183.199,
 mailfrom: foss@0leil.net)
Received: (Authenticated sender: foss@0leil.net)
	by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 3E396FF804;
	Thu,  7 Oct 2021 16:27:15 +0000 (UTC)
Date: Thu, 07 Oct 2021 18:27:13 +0200
From: Quentin Schulz <foss@0leil.net>
To: docs@lists.yoctoproject.org, Jon Mason <jdmason@kudzu.us>,
 openembedded-core@lists.openembedded.org,
 bitbake-devel@lists.openembedded.org
Subject: =?US-ASCII?Q?Re=3A_=5Bdocs=5D_=5BPATCH_4/8=5D_yocto-bsp/po?=
 =?US-ASCII?Q?ky=3A_replace_http_with_https_for_URLs?=
In-Reply-To: <20211007150630.22138-5-jdmason@kudzu.us>
References: <20211007150630.22138-1-jdmason@kudzu.us>
 <20211007150630.22138-5-jdmason@kudzu.us>
Message-ID: <69BB3614-372F-4495-92FD-961261E955E0@0leil.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Oct 2021 16:27:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12752

Hi Jon,

On October 7, 2021 5:06:26 PM GMT+02:00, Jon Mason <jdmason@kudzu=2Eus> wr=
ote:
>https has been the preferred way to access websites for many years now=2E
>Change all of the URLs with a _working_ https server/certificate to use
>that URL=2E
>
>Signed-off-by: Jon Mason <jdmason@kudzu=2Eus>
>---

Reviewed-by: Quentin Schulz <foss@0leil=2Enet>

Thanks,
Quentin

> meta-poky/README=2Epoky=2Emd          | 12 ++++++------
> meta-poky/conf/distro/poky=2Econf   | 16 ++++++++--------
> meta-yocto-bsp/README=2Ehardware=2Emd |  2 +-
> 3 files changed, 15 insertions(+), 15 deletions(-)
>
>diff --git a/meta-poky/README=2Epoky=2Emd b/meta-poky/README=2Epoky=2Emd
>index 289373f94411=2E=2Ea99c75ed5cb8 100644
>--- a/meta-poky/README=2Epoky=2Emd
>+++ b/meta-poky/README=2Epoky=2Emd
>@@ -3,7 +3,7 @@ Poky
>=20
> Poky is an integration of various components to form a pre-packaged
> build system and development environment which is used as a development =
and
>-validation tool by the [Yocto Project](http://www=2Eyoctoproject=2Eorg/)=
=2E It
>+validation tool by the [Yocto Project](https://www=2Eyoctoproject=2Eorg/=
)=2E It
> features support for building customised embedded style device images
> and custom containers=2E There are reference demo images ranging from X1=
1/GTK+
>  to Weston, commandline and more=2E The system supports cross-architectu=
re
>@@ -19,8 +19,8 @@ Many layers are available and can be found through the
> As an integration layer Poky consists of several upstream projects such =
as=20
> [BitBake](https://git=2Eopenembedded=2Eorg/bitbake/),
> [OpenEmbedded-Core](https://git=2Eopenembedded=2Eorg/openembedded-core/)=
,
>-[Yocto documentation](http://git=2Eyoctoproject=2Eorg/cgit=2Ecgi/yocto-d=
ocs/),
>-the '[meta-yocto](http://git=2Eyoctoproject=2Eorg/cgit=2Ecgi/meta-yocto/=
)' layer
>+[Yocto documentation](https://git=2Eyoctoproject=2Eorg/cgit=2Ecgi/yocto-=
docs/),
>+the '[meta-yocto](https://git=2Eyoctoproject=2Eorg/cgit=2Ecgi/meta-yocto=
/)' layer
> which has configuration and hardware support components=2E These compone=
nts
> are all part of the Yocto Project and OpenEmbedded ecosystems=2E
>=20
>@@ -29,7 +29,7 @@ reference manual which can be found at <https://docs=2E=
yoctoproject=2Eorg/>
>=20
> OpenEmbedded is the build architecture used by Poky and the Yocto projec=
t=2E
> For information about OpenEmbedded, see the=20
>-[OpenEmbedded website](http://www=2Eopenembedded=2Eorg/)=2E
>+[OpenEmbedded website](https://www=2Eopenembedded=2Eorg/)=2E
>=20
> Contribution Guidelines
> -----------------------
>@@ -42,7 +42,7 @@ who the maintainers are and where bugs should be report=
ed=2E
>=20
> A guide to submitting patches to OpenEmbedded is available at:
>=20
>-<http://www=2Eopenembedded=2Eorg/wiki/How_to_submit_a_patch_to_OpenEmbed=
ded>
>+<https://www=2Eopenembedded=2Eorg/wiki/How_to_submit_a_patch_to_OpenEmbe=
dded>
>=20
> There is good documentation on how to write/format patches at:
>=20
>@@ -72,7 +72,7 @@ Documentation (files in documentation/):
>=20
> meta-yocto (files in meta-poky/, meta-yocto-bsp/):
>=20
>-- Git repository: <http://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/meta-=
yocto>
>+- Git repository: <https://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/meta=
-yocto>
> - Mailing list: poky@lists=2Eyoctoproject=2Eorg
>=20
> If in doubt, check the openembedded-core git repository for the content =
you
>diff --git a/meta-poky/conf/distro/poky=2Econf b/meta-poky/conf/distro/po=
ky=2Econf
>index e161e4943a38=2E=2Eb0793de21cea 100644
>--- a/meta-poky/conf/distro/poky=2Econf
>+++ b/meta-poky/conf/distro/poky=2Econf
>@@ -31,14 +31,14 @@ DISTRO_EXTRA_RRECOMMENDS +=3D "${POKY_DEFAULT_EXTRA_R=
RECOMMENDS}"
> TCLIBCAPPEND =3D ""
>=20
> PREMIRRORS ??=3D "\
>-bzr://=2E*/=2E*   http://downloads=2Eyoctoproject=2Eorg/mirror/sources/ =
\n \
>-cvs://=2E*/=2E*   http://downloads=2Eyoctoproject=2Eorg/mirror/sources/ =
\n \
>-git://=2E*/=2E*   http://downloads=2Eyoctoproject=2Eorg/mirror/sources/ =
\n \
>-gitsm://=2E*/=2E* http://downloads=2Eyoctoproject=2Eorg/mirror/sources/ =
\n \
>-hg://=2E*/=2E*    http://downloads=2Eyoctoproject=2Eorg/mirror/sources/ =
\n \
>-osc://=2E*/=2E*   http://downloads=2Eyoctoproject=2Eorg/mirror/sources/ =
\n \
>-p4://=2E*/=2E*    http://downloads=2Eyoctoproject=2Eorg/mirror/sources/ =
\n \
>-svn://=2E*/=2E*   http://downloads=2Eyoctoproject=2Eorg/mirror/sources/ =
\n"
>+bzr://=2E*/=2E*   https://downloads=2Eyoctoproject=2Eorg/mirror/sources/=
 \n \
>+cvs://=2E*/=2E*   https://downloads=2Eyoctoproject=2Eorg/mirror/sources/=
 \n \
>+git://=2E*/=2E*   https://downloads=2Eyoctoproject=2Eorg/mirror/sources/=
 \n \
>+gitsm://=2E*/=2E* https://downloads=2Eyoctoproject=2Eorg/mirror/sources/=
 \n \
>+hg://=2E*/=2E*    https://downloads=2Eyoctoproject=2Eorg/mirror/sources/=
 \n \
>+osc://=2E*/=2E*   https://downloads=2Eyoctoproject=2Eorg/mirror/sources/=
 \n \
>+p4://=2E*/=2E*    https://downloads=2Eyoctoproject=2Eorg/mirror/sources/=
 \n \
>+svn://=2E*/=2E*   https://downloads=2Eyoctoproject=2Eorg/mirror/sources/=
 \n"
>=20
> SANITY_TESTED_DISTROS ?=3D " \
>             poky-3=2E2 \n \
>diff --git a/meta-yocto-bsp/README=2Ehardware=2Emd b/meta-yocto-bsp/READM=
E=2Ehardware=2Emd
>index f00f167d3ba2=2E=2E9151d641d5b7 100644
>--- a/meta-yocto-bsp/README=2Ehardware=2Emd
>+++ b/meta-yocto-bsp/README=2Ehardware=2Emd
>@@ -15,7 +15,7 @@ configuration=2E For more information please see the Yo=
cto Board Support Package
> (BSP) Developer's Guide - documentation source is in documentation/bspgu=
ide or=20
> download the PDF from:
>=20
>-   http://yoctoproject=2Eorg/documentation
>+   https://docs=2Eyoctoproject=2Eorg/
>=20
> Note that these reference BSPs use the linux-yocto kernel and in general=
 don't
> pull in binary module support for the platforms=2E This means some devic=
e functionality

