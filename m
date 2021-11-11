Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42503C433F5
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 11:20:31 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web08.9133.1636629629986694408
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Nov 2021 03:20:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=UHUy677L;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1636629630;
  x=1668165630;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v9vHnM0dixyLuc51lVFVEpajHu2REoCzkRJCTMGGkJ8=;
  b=UHUy677LqCoE7onj4JPPk8zF3H6J8jjLux3hQILZ6o3TGBKyjOe53TkA
   zPvWhu356dqvSIxxjyjZjFcViYh8LnYbKXimoZJBQ5nVI5A3VClwCyNuD
   AViwi9yiLqdVCh5djLY/4FyajeA60RKqNzr/ncVzxXFlfGrMgeXyf5rYO
   z3jgDlMEWU6JnCjiYDjfehFTh+47AKgpVRhemworBdIgWy2ozG5Ai+ZDe
   WRT90dheMopYRU+plQEJIRxAq0+X9T/3GcNEf63J1t5wNi5c/Lo3q2SFX
   NBf3gfWp7BtZPEvT6CjTgk0vqGJL9V3fXSWSZewYXdNm4N1SNS6Hs7nhc
   g==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "jasper@fancydomain.eu" <jasper@fancydomain.eu>,
	"openembedded-core@lists.openembedded.org"
	<openembedded-core@lists.openembedded.org>
CC: "martin@mko.dev" <martin@mko.dev>, "Daniel.Baumgart@iris-sensing.com"
	<Daniel.Baumgart@iris-sensing.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Jasper Orschulko
	<Jasper.Orschulko@iris-sensing.com>
Subject: RE: [oe-core][PATCH v5 1/2] repo: Add recipe for 2.17.3
Thread-Topic: [oe-core][PATCH v5 1/2] repo: Add recipe for 2.17.3
Thread-Index: AQHX1u0tv7/AT1LEC0CQcRzZqDfwJ6v+LSkA
Date: Thu, 11 Nov 2021 11:20:28 +0000
Message-ID: <4a5e17ecbc0641598b144094f60945c0@axis.com>
References: <20211111102124.7661-1-jasper@fancydomain.eu>
In-Reply-To: <20211111102124.7661-1-jasper@fancydomain.eu>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Nov 2021 11:20:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13010

> -----Original Message-----
> From: openembedded-core@lists.openembedded.org <openembedded-core@lists.o=
penembedded.org> On Behalf Of Jasper Orschulko via lists.openembedded.org
> Sent: den 11 november 2021 11:21
> To: openembedded-core@lists.openembedded.org
> Cc: martin@mko.dev; Daniel.Baumgart@iris-sensing.com; bitbake-devel@lists=
.openembedded.org; Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> Subject: [oe-core][PATCH v5 1/2] repo: Add recipe for 2.17.3
>=20
> From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
>=20
> Add a recipe for repo 2.17.3, prerequisite for the repo fetcher.
>=20
> Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> ---
>  meta/conf/distro/include/maintainers.inc      |  1 +
>  .../0001-Set-REPO_REV-to-v2.17.3.patch        | 35 +++++++++++++++++++
>  .../repo/repo/0001-python3-shebang.patch      | 26 ++++++++++++++
>  meta/recipes-devtools/repo/repo_2.17.3.bb     | 28 +++++++++++++++
>  4 files changed, 90 insertions(+)
>  create mode 100644 meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_=
REV-to-v2.17.3.patch
>  create mode 100644 meta/recipes-devtools/repo/repo/0001-python3-shebang.=
patch
>  create mode 100644 meta/recipes-devtools/repo/repo_2.17.3.bb
>=20
> diff --git a/meta/conf/distro/include/maintainers.inc b/meta/conf/distro/=
include/maintainers.inc
> index f3e0a75d56..58a0a9615f 100644
> --- a/meta/conf/distro/include/maintainers.inc
> +++ b/meta/conf/distro/include/maintainers.inc
> @@ -652,6 +652,7 @@ RECIPE_MAINTAINER:pn-quilt-native =3D "Robert Yang <l=
iezhi.yang@windriver.com>"
>  RECIPE_MAINTAINER:pn-quota =3D "Anuj Mittal <anuj.mittal@intel.com>"
>  RECIPE_MAINTAINER:pn-re2c =3D "Khem Raj <raj.khem@gmail.com>"
>  RECIPE_MAINTAINER:pn-readline =3D "Hongxu Jia <hongxu.jia@windriver.com>=
"
> +RECIPE_MAINTAINER:pn-repo =3D "Jasper Orschulko <Jasper.Orschulko@iris-s=
ensing.com>"
>  RECIPE_MAINTAINER:pn-resolvconf =3D "Chen Qi <Qi.Chen@windriver.com>"
>  RECIPE_MAINTAINER:pn-rgb =3D "Unassigned <unassigned@yoctoproject.org>"
>  RECIPE_MAINTAINER:pn-rpcbind =3D "Hongxu Jia <hongxu.jia@windriver.com>"
> diff --git a/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-=
v2.17.3.patch b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to=
-v2.17.3.patch
> new file mode 100644
> index 0000000000..285b1d3129
> --- /dev/null
> +++ b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-
> v2.17.3.patch
> @@ -0,0 +1,35 @@
> +From bdd2a528da59c28db8ae2986834926de7cebf3ab Mon Sep 17 00:00:00 2001
> +From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> +Date: Thu, 4 Nov 2021 16:55:12 +0100
> +Subject: [PATCH] Set REPO_REV to v2.17.3
> +
> +repo is an unusual tool because it downloads all of its own Python modul=
es
> +using GPG-signed git tags, and stores those files as part of the project
> +that it is working with.
> +
> +So in order to have a reproducible repo installation within the project
> +folders, we hardcode the default REPO_REV to a SHA1 that corresponds to
> +the version of the recipe. REPO_REV can still be overwriten by the user,
> +by specifying the REPO_REV environment variable.
> +
> +Upstream-Status: Inappropriate [configuration]
> +Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> +---
> + repo | 2 +-
> + 1 file changed, 1 insertion(+), 1 deletion(-)
> +
> +diff --git a/repo b/repo
> +index b13e34c..31130e9 100755
> +--- a/repo
> ++++ b/repo
> +@@ -130,7 +130,7 @@ if not REPO_URL:
> +   REPO_URL =3D 'https://gerrit.googlesource.com/git-repo'
> + REPO_REV =3D os.environ.get('REPO_REV')
> + if not REPO_REV:
> +-  REPO_REV =3D 'stable'
> ++  REPO_REV =3D '11b30b91df1f0e03b53da970ec2588e85817bacc'
> +
> + # increment this whenever we make important changes to this script
> + VERSION =3D (2, 8)
> +--
> +2.33.1
> diff --git a/meta/recipes-devtools/repo/repo/0001-python3-shebang.patch b=
/meta/recipes-devtools/repo/repo/0001-python3-shebang.patch
> new file mode 100644
> index 0000000000..d3888c8bb2
> --- /dev/null
> +++ b/meta/recipes-devtools/repo/repo/0001-python3-shebang.patch
> @@ -0,0 +1,26 @@
> +From b8e84b202cd302a7c99288d3835dc9c63071f8f2 Mon Sep 17 00:00:00 2001
> +From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> +Date: Tue, 14 Sep 2021 16:46:51 +0200
> +Subject: [PATCH] python3 shebang
> +
> +Yocto does not symlink from python to python3, thus change the shebang f=
rom
> +python to python3.
> +
> +Upstream-Status: Inappropriate [configuration]
> +Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> +---
> + repo | 2 +-
> + 1 file changed, 1 insertion(+), 1 deletion(-)
> +
> +diff --git a/repo b/repo
> +index b13e34c..205e0e5 100755
> +--- a/repo
> ++++ b/repo
> +@@ -1,4 +1,4 @@
> +-#!/usr/bin/env python
> ++#!/usr/bin/env python3
> + # -*- coding:utf-8 -*-
> + #
> + # Copyright (C) 2008 The Android Open Source Project
> +--
> +2.33.0
> diff --git a/meta/recipes-devtools/repo/repo_2.17.3.bb b/meta/recipes-dev=
tools/repo/repo_2.17.3.bb
> new file mode 100644
> index 0000000000..cb0af89c09
> --- /dev/null
> +++ b/meta/recipes-devtools/repo/repo_2.17.3.bb
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: MIT
> +# Copyright (C) 2021 iris-GmbH infrared & intelligent sensors
> +
> +SUMMARY =3D "Tool for managing many Git repositories"
> +DESCRIPTION =3D "Repo is a tool built on top of Git. Repo helps manage m=
any Git repositories, does the uploads to revision control systems, and aut=
omates parts of the development workflow."
> +HOMEPAGE =3D "https://android.googlesource.com/tools/repo"
> +SECTION =3D "console/utils"
> +
> +LICENSE =3D "Apache-2.0"
> +LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D3b83ef96387f14655fc854ddc3c6b=
d57"
> +
> +SRC_URI =3D "git://gerrit.googlesource.com/git-repo.git;protocol=3Dhttps=
;branch=3Dmain"
> +SRCREV =3D "11b30b91df1f0e03b53da970ec2588e85817bacc"
> +
> +SRC_URI +=3D "file://0001-python3-shebang.patch \
> +            file://0001-Set-REPO_REV-to-v2.17.3.patch"
> +
> +MIRRORS +=3D "git://gerrit.googlesource.com/git-repo.git git://github.co=
m/GerritCodeReview/git-repo.git \n"

Remove " \n".

> +
> +S =3D "${WORKDIR}/git"
> +
> +do_install() {
> +	install -Dm 0755 ${WORKDIR}/git/repo ${D}${bindir}/repo

You can remove "m 0755" as that is the default for install.

> +}
> +
> +RDEPENDS:${PN} =3D "python3"
> +
> +BBCLASSEXTEND =3D "native nativesdk"
> --
> 2.33.1

//Peter


