Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0BAC433EF
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 16:11:20 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web11.7813.1636128679079017786
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 09:11:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com
 header.s=axis-central1 header.b=ZkH7yjMZ;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1636128679;
  x=1667664679;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6GMMDaK/DwPstw9vI8jcuaL/3R5o3E6M95z+4p7/2zw=;
  b=ZkH7yjMZE2DhAHZYsZ90mbvtWL2JVNAbO/C+Fo7Za1N1LkKVdmbcxttb
   fEWnnDtwe88i1HETrzOWIoLKxoOBo3QHTrBBGUkMNvF2mzqrvMlboRV26
   qyCDi2HRg2BiWhP/n8cWkFtfolDTx+/EsQhFaBN8mCup85uLcxgnozAmK
   RG/1gfbXuiLo2MkIpVFgpgjZsNJMwgrDnLdnOh6hb1caaaEcOH51ce2al
   +4qn3W1BDc0PYMy6aVz30zn1z97FyyCWnWopyItxSwy+9NTJVyCB7MnV3
   Ad4l+g40lLtpO3ZmNbrd12cnQHHGH3YNzdSUfNaNE7aY9Lv1DyZeA7hVd
   g==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "jasper@fancydomain.eu" <jasper@fancydomain.eu>,
	"openembedded-core@lists.openembedded.org"
	<openembedded-core@lists.openembedded.org>
CC: "martin@mko.dev" <martin@mko.dev>, "Daniel.Baumgart@iris-sensing.com"
	<Daniel.Baumgart@iris-sensing.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Jasper Orschulko
	<Jasper.Orschulko@iris-sensing.com>
Subject: RE: [bitbake-devel] [oe-core][PATCH v2 1/2] devtools: Initial recipe
 for repo 2.17.3
Thread-Topic: [bitbake-devel] [oe-core][PATCH v2 1/2] devtools: Initial recipe
 for repo 2.17.3
Thread-Index: AQHX0lpRAkuEghAQsEel2yEQ1F7DYav1Fh8w
Date: Fri, 5 Nov 2021 16:11:16 +0000
Message-ID: <361859de452742cdbd666b45babcbf51@axis.com>
References: <20211105153135.26033-1-jasper@fancydomain.eu>
In-Reply-To: <20211105153135.26033-1-jasper@fancydomain.eu>
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
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 16:11:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12912

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Jasper Orschulko via lists.openembedded.org
> Sent: den 5 november 2021 16:32
> To: openembedded-core@lists.openembedded.org
> Cc: martin@mko.dev; Daniel.Baumgart@iris-sensing.com; bitbake-devel@lists=
.openembedded.org; Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> Subject: [bitbake-devel] [oe-core][PATCH v2 1/2] devtools: Initial recipe=
 for repo 2.17.3

Change the Git subject to:

repo: Add recipe for 2.17.3

>=20
> From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
>=20
> Add a recipe for repo, prerequisite for the repo fetcher.
>=20
> Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> ---
>  .../repo/files/0001-python3-shebang.patch     | 21 ++++++++++++
>  .../0001-Set-REPO_REV-to-v2.17.3.patch        | 33 +++++++++++++++++++
>  meta/recipes-devtools/repo/repo.inc           | 25 ++++++++++++++
>  meta/recipes-devtools/repo/repo_2.17.3.bb     |  7 ++++
>  4 files changed, 86 insertions(+)
>  create mode 100644 meta/recipes-devtools/repo/files/0001-python3-shebang=
.patch
>  create mode 100644 meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_=
REV-to-v2.17.3.patch
>  create mode 100644 meta/recipes-devtools/repo/repo.inc
>  create mode 100644 meta/recipes-devtools/repo/repo_2.17.3.bb
>=20
> diff --git a/meta/recipes-devtools/repo/files/0001-python3-shebang.patch =
> b/meta/recipes-devtools/repo/files/0001-python3-shebang.patch
> new file mode 100644
> index 0000000000..09ccf58264
> --- /dev/null
> +++ b/meta/recipes-devtools/repo/files/0001-python3-shebang.patch
> @@ -0,0 +1,21 @@
> +From b8e84b202cd302a7c99288d3835dc9c63071f8f2 Mon Sep 17 00:00:00 2001
> +From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> +Date: Tue, 14 Sep 2021 16:46:51 +0200
> +Subject: [PATCH] python3 shebang
> +
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
> diff --git a/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-=
v2.17.3.patch b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to=
-v2.17.3.patch
> new file mode 100644
> index 0000000000..4d76bfc5d2
> --- /dev/null
> +++ b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3=
.patch
> @@ -0,0 +1,33 @@
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
> +folders, we hardcode the REPO_REV variable to this recipes PV.

Change "this recipes PV" to "a SHA1 that corresponds to the version=20
of the recipe."

> +
> +Upstream-Status: Inappropriate [configuration]
> +Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> +---
> + repo | 2 +-
> + 1 file changed, 1 insertion(+), 1 deletion(-)
> +
> +diff --git a/repo b/repo
> +index 4cddbf1..cf5f6b1 100755
> +--- a/repo
> ++++ b/repo
> +@@ -142,7 +142,7 @@ if __name__ =3D=3D '__main__':
> + REPO_URL =3D os.environ.get('REPO_URL', None)
> + if not REPO_URL:
> +   REPO_URL =3D 'https://gerrit.googlesource.com/git-repo'
> +-REPO_REV =3D os.environ.get('REPO_REV')
> ++REPO_REV =3D '11b30b91df1f0e03b53da970ec2588e85817bacc'
> + if not REPO_REV:
> +   REPO_REV =3D 'stable'
> + # URL to file bug reports for repo tool issues.
> +--
> +2.33.1
> diff --git a/meta/recipes-devtools/repo/repo.inc b/meta/recipes-devtools/=
repo/repo.inc
> new file mode 100644
> index 0000000000..60b32e4d74
> --- /dev/null
> +++ b/meta/recipes-devtools/repo/repo.inc
> @@ -0,0 +1,25 @@
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
> +
> +SRC_URI =3D "git://git@gerrit.googlesource.com/git-repo.git;protocol=3Dh=
ttps;branch=3Dmain"

I do not think you need to specify "git@" for this URL.

> +MIRRORS =3D "git://git@gerrit.googlesource.com/git-repo.git git://github=
.com/GerritCodeReview/git-repo.git \n"

It is probably better to use +=3D and add to MIRRORS.

> +
> +SRC_URI +=3D "file://0001-python3-shebang.patch"

I would rewrite the above lines as:

SRC_URI =3D "git://gerrit.googlesource.com/git-repo.git;protocol=3Dhttps;br=
anch=3Dmain"
SRC_URI +=3D "file://0001-python3-shebang.patch"

MIRRORS +=3D "git://gerrit.googlesource.com/git-repo.git git://github.com/G=
erritCodeReview/git-repo.git \n"

> +
> +S =3D "${WORKDIR}/git"
> +
> +RDEPENDS_${PN} =3D "python3"

Change to RDEPENDS:${PN} and move it to between do_install() and=20
BBCLASSEXTEND.

> +
> +do_install() {
> +    install -d ${D}${bindir}
> +    install -m 755 ${WORKDIR}/git/repo ${D}${bindir}

Use tabs to indent shell code in OE-Core. You can also remove "-m 755"=20
as that is the default for install.

> +}
> +
> +BBCLASSEXTEND =3D "native nativesdk"
> diff --git a/meta/recipes-devtools/repo/repo_2.17.3.bb b/meta/recipes-dev=
tools/repo/repo_2.17.3.bb
> new file mode 100644
> index 0000000000..c26264b9e9
> --- /dev/null
> +++ b/meta/recipes-devtools/repo/repo_2.17.3.bb
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: MIT
> +# Copyright (C) 2021 iris-GmbH infrared & intelligent sensors
> +
> +require recipes-devtools/repo/repo.inc

Merge the repo.inc with the recipe as there is only one user of it.

> +
> +SRCREV =3D "11b30b91df1f0e03b53da970ec2588e85817bacc"
> +LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D3b83ef96387f14655fc854ddc3c6b=
d57"
> --
> 2.33.1

//Peter


