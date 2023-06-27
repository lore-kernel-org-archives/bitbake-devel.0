Return-Path: <ari.parkkila@qt.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9DBEB64D9
	for <webhook@archiver.kernel.org>; Tue, 27 Jun 2023 12:44:47 +0000 (UTC)
Subject: Re: Bitbake race failure with BBMULTICONFIG and setscene
To: bitbake-devel@lists.openembedded.org
From: "Ari Parkkila" <ari.parkkila@qt.io>
X-Originating-Location: Oulu, North Ostrobothnia, FI (78.27.70.251)
X-Originating-Platform: Linux Firefox 112
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 27 Jun 2023 05:44:41 -0700
References: <CANPvuRmbE+cYJmuXE=Rtg6O9wYxO762WcUqFwauftCKMY1to6Q@mail.gmail.com>
In-Reply-To: <CANPvuRmbE+cYJmuXE=Rtg6O9wYxO762WcUqFwauftCKMY1to6Q@mail.gmail.com>
Message-ID: <21003.1687869881720533934@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="rv3T0wOz3TjbggKP13Fm"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jun 2023 12:44:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14863

--rv3T0wOz3TjbggKP13Fm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Richard,

The "bitbake XXX -S none" spell creates locked-sigs.inc which has four iden=
tical glibc:do_populate_lic checksums: Once in "SIGGEN_LOCKEDSIGS_t-aarch64=
" and three times in "SIGGEN_LOCKEDSIGS_t-armv7at2hf-vfp". The checksums ar=
e for the packages "gcc-runtime, glibc, libgcc, libgcc-initial, linux-libc-=
headers" which are the ones causing this failure so maybe there's something=
 fishy?

My repro steps above should have been:
- repo init -u git://code.qt.io/yocto/boot2qt-manifest -m ti/6.6.xml && rep=
o sync
- git -C sources/meta-ti checkout 1b313bcd
- export MACHINE=3Dam62xx-evm && source ./setup-environment.sh
- bitbake b2qt-embedded-qt6-image

Jos=C3=A9,

Patch https://lists.yoctoproject.org/g/meta-ti/message/14767 solves this li=
cense "race" problem. It seems meta-ti bootloader still needs some changes =
to handle separate tmp-folders but that looks like another story.

--rv3T0wOz3TjbggKP13Fm
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Richard,<br /><br />The "bitbake XXX -S none" spell creates locked-sigs.inc=
 which has four identical glibc:do_populate_lic checksums: Once in "SIGGEN_=
LOCKEDSIGS_t-aarch64" and three times in "SIGGEN_LOCKEDSIGS_t-armv7at2hf-vf=
p". The checksums are for the packages "gcc-runtime, glibc, libgcc, libgcc-=
initial, linux-libc-headers" which are the ones causing this failure so may=
be there's something fishy?<br /><br />My repro steps above should have bee=
n:<br />- repo init -u git://code.qt.io/yocto/boot2qt-manifest -m ti/6.6.xm=
l &amp;&amp; repo sync<br />- git -C sources/meta-ti checkout 1b313bcd<br /=
>- export MACHINE=3Dam62xx-evm &amp;&amp; source ./setup-environment.sh<br =
/>- bitbake b2qt-embedded-qt6-image<br /><br />Jos&eacute;,<br /><br />Patc=
h https://lists.yoctoproject.org/g/meta-ti/message/14767 solves this licens=
e "race" problem. It seems meta-ti bootloader still needs some changes to h=
andle separate tmp-folders but that looks like another story.

--rv3T0wOz3TjbggKP13Fm--

