Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39288C433FE
	for <webhook@archiver.kernel.org>; Thu,  7 Oct 2021 16:15:36 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web08.634.1633623334599008977
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 09:15:35 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=permanent DNS error (domain: 0leil.net, ip: 217.70.183.201,
 mailfrom: foss@0leil.net)
Received: (Authenticated sender: foss@0leil.net)
	by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id AAE9D1BF20C;
	Thu,  7 Oct 2021 16:15:30 +0000 (UTC)
Date: Thu, 07 Oct 2021 18:15:28 +0200
From: Quentin Schulz <foss@0leil.net>
To: docs@lists.yoctoproject.org, Jon Mason <jdmason@kudzu.us>,
 openembedded-core@lists.openembedded.org,
 bitbake-devel@lists.openembedded.org
Subject: Re: [docs] [PATCH 1/8] oeqa/manual: Fix no longer valid URLs
In-Reply-To: <20211007150630.22138-2-jdmason@kudzu.us>
References: <20211007150630.22138-1-jdmason@kudzu.us>
 <20211007150630.22138-2-jdmason@kudzu.us>
Message-ID: <B0A9ED6D-F661-4C4D-8FA4-C5FF536A915E@0leil.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Oct 2021 16:15:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12750

Hi Jon,

On October 7, 2021 5:06:23 PM GMT+02:00, Jon Mason <jdmason@kudzu=2Eus> wr=
ote:
>autobuilder=2Eyoctoproject=2Eorg URLS no longer work=2E  Update them to a
>working location=2E
>
>Signed-off-by: Jon Mason <jdmason@kudzu=2Eus>
>---
> meta/lib/oeqa/manual/eclipse-plugin=2Ejson | 6 +++---

We don't support the eclipse plugin anymore, I guess this is a file we for=
got to remove?

Cheers,
Quentin

> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/meta/lib/oeqa/manual/eclipse-plugin=2Ejson b/meta/lib/oeqa/m=
anual/eclipse-plugin=2Ejson
>index d77d0e673b8b=2E=2E6c110d0656ec 100644
>--- a/meta/lib/oeqa/manual/eclipse-plugin=2Ejson
>+++ b/meta/lib/oeqa/manual/eclipse-plugin=2Ejson
>@@ -44,7 +44,7 @@
>                     "expected_results": ""
>                 },
>                 "2": {
>-                    "action": "wget  autobuilder=2Eyoctoproject=2Eorg/pu=
b/releases//machines/qemu/qemux86/qemu (ex:core-image-sato-sdk-qemux86-date=
-rootfs-tar-bz2) \nsource /opt/poky/version/environment-setup-i585-poky-lin=
ux  \n\nExtract qemu with runqemu-extract-sdk /home/user/file(ex=2Ecore-ima=
ge-sato-sdk-qemux86=2Ebz2) \n/home/user/qemux86-sato-sdk  \n\n",
>+                    "action": "wget  https://downloads=2Eyoctoproject=2E=
org/releases/yocto/yocto-$VERSION/machines/qemu/qemux86/ (ex:core-image-sat=
o-sdk-qemux86-date-rootfs-tar-bz2) \nsource /opt/poky/version/environment-s=
etup-i585-poky-linux  \n\nExtract qemu with runqemu-extract-sdk /home/user/=
file(ex=2Ecore-image-sato-sdk-qemux86=2Ebz2) \n/home/user/qemux86-sato-sdk =
 \n\n",
>                     "expected_results": " Qemu can be lauched normally=
=2E"
>                 },
>                 "3": {
>@@ -60,7 +60,7 @@
>                     "expected_results": ""
>                 },
>                 "6": {
>-                    "action": "(d) QEMU: \nSelect this option if you wil=
l be using the QEMU emulator=2E Specify the Kernel matching the QEMU archit=
ecture you are using=2E \n      wget  autobuilder=2Eyoctoproject=2Eorg/pub/=
releases//machines/qemu/qemux86/bzImage-qemux86=2Ebin \n      e=2Eg: /home/=
$USER/yocto/adt-installer/download_image/bzImage-qemux86=2Ebin  \n\n",
>+                    "action": "(d) QEMU: \nSelect this option if you wil=
l be using the QEMU emulator=2E Specify the Kernel matching the QEMU archit=
ecture you are using=2E \n      wget  https://downloads=2Eyoctoproject=2Eor=
g/releases/yocto/yocto-$VERSION/machines/qemu/qemux86/bzImage-qemux86=2Ebin=
 \n      e=2Eg: /home/$USER/yocto/adt-installer/download_image/bzImage-qemu=
x86=2Ebin  \n\n",
>                     "expected_results": ""
>                 },=09
>                 "7": {
>@@ -247,7 +247,7 @@
>             "execution": {
>                 "1": {
>                     "action": "Clone eclipse-poky source=2E   \n    \n  =
  - git clone git://git=2Eyoctoproject=2Eorg/eclipse-poky  \n\n",
>-                    "expected_results": "Eclipse plugin is successfully =
installed  \n\nDocumentation is there=2E For example if you have release yo=
cto-2=2E0=2E1 you will found on   http://autobuilder=2Eyoctoproject=2Eorg/p=
ub/releases/yocto-2=2E0=2E1/eclipse-plugin/mars/  archive with documentatio=
n like org=2Eyocto=2Edoc-development-$date=2Ezip  \n  \n"
>+                    "expected_results": "Eclipse plugin is successfully =
installed  \n\nDocumentation is there=2E For example if you have release yo=
cto-2=2E0=2E1 you will found on   https://downloads=2Eyoctoproject=2Eorg/re=
leases/yocto/yocto-2=2E0=2E1/eclipse-plugin/mars/  archive with documentati=
on like org=2Eyocto=2Edoc-development-$date=2Ezip  \n  \n"
>                 },
>                 "2": {
>                     "action": "Checkout correct tag=2E  \n\n    - git ch=
eckout <eclipse-version>/<yocto-version> \n\n",

