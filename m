Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9272DCCD1AB
	for <webhook@archiver.kernel.org>; Wed, 22 Oct 2025 13:12:55 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web10.9028.1761138768262286458
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Oct 2025 06:12:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=U88XEqP8;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1E0EC1A15C8
	for <bitbake-devel@lists.openembedded.org>; Wed, 22 Oct 2025 13:12:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E973C606DC;
	Wed, 22 Oct 2025 13:12:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B11E102F2430;
	Wed, 22 Oct 2025 15:12:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761138765; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fyUhlobe/yYMkF1jdL1TCaQWIcY8nG6eivXYpq5a/YY=;
	b=U88XEqP8yqH2LJEyq3ufdhZbrhAxbITkSx2SAfciTo0ZIaVeUMuwoYS1QMMsj78/ZEad9a
	q4aCLxgAyaI7kNyw88JOW+5MBW+Y4p7phrL3diwDgeU+3UhjIpzN5H33MaklFvFLZDHD5Z
	GVaFsQrFTJrhfyuLojq//t0KL5qGL7D1ZoOUrGZmbcA/jx4BCKzjzV3Da55DjfpX71F//y
	PTnPe2rflP0KkOy8bGzQB25nCSHyrnqUmjrG+29qNF33xxA1pGfBhkOMdXSWXLs/qG0Eae
	D/YDy072vZJkL01NOU4VUf6TFa3sPvQpWt80bjjMis5odTQeJnJHlrFeYO7vkg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 15:12:44 +0200
Message-Id: <DDOVL7DW8DJ1.2NL8I5FT9OZUH@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <adam.blank.g@gmail.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 2/3] doc: bitbake-user-manual: AUTOREV
 and SRCREV_FORMAT roles in fetching
References: <20251021182834.11403-1-adam.blank.g@gmail.com>
 <20251021182834.11403-3-adam.blank.g@gmail.com>
In-Reply-To: <20251021182834.11403-3-adam.blank.g@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Oct 2025 13:12:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18209

On Tue Oct 21, 2025 at 8:28 PM CEST, Adam Blank via lists.openembedded.org =
wrote:
> Describe the roles of AUTOREV and SRCREV_FORMAT in the fetching step.
> Add their missing descriptions to the variable reference section.
>
> Fixes [YOCTO #14498]
>
> Signed-off-by: Adam Blank <adam.blank.g@gmail.com>
> ---
>  .../bitbake-user-manual-fetching.rst          | 46 ++++++++++++++++++-
>  .../bitbake-user-manual-ref-variables.rst     | 15 ++++--
>  2 files changed, 56 insertions(+), 5 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> index d10d2f611..dbb52e85a 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> @@ -173,6 +173,11 @@ govern the behavior of the unpack stage:
>  -  *subdir:* Unpacks the specific URL to the specified subdirectory
>     within the root directory.
> =20
> +-  *name:* Assigns a name to a given component of the :term:`SRC_URI`.
> +   This component is later referenced by this name when specifying its
> +   :term:`SRCREV` or :term:`SRC_URI` checksum, or to correctly place its
> +   revision in the package version string with aid of :term:`SRCREV_FORM=
AT`.
> +
>  The unpack call automatically decompresses and extracts files with ".Z",
>  ".z", ".gz", ".xz", ".zip", ".jar", ".ipk", ".rpm". ".srpm", ".deb" and
>  ".bz2" extensions as well as various combinations of tarball extensions.
> @@ -453,7 +458,7 @@ This fetcher supports the following parameters:
>     By default, the path is ``git/``.
> =20
>  -  *"usehead":* Enables local ``git://`` URLs to use the current branch
> -   HEAD as the revision for use with ``AUTOREV``. The "usehead"
> +   HEAD as the revision for use with :term:`AUTOREV`. The "usehead"
>     parameter implies no branch and only works when the transfer protocol
>     is ``file://``.
> =20
> @@ -845,4 +850,41 @@ submodules. However, you might find the code helpful=
 and readable.
>  Auto Revisions
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -We need to document ``AUTOREV`` and :term:`SRCREV_FORMAT` here.
> +For recipes which need to use the latest revision of their source code,
> +the way to achieve it is to use :term:`AUTOREV` as the value of the
> +source code repository's :term:`SRCREV`::
> +
> +   SRCREV =3D "${AUTOREV}"
> +
> +.. note::
> +
> +   With :term:`AUTOREV`, BitBake will always need to take the additional=
 step of
> +   querying the remote repository to retrieve the latest available revis=
ion.
> +
> +   Also, recipes using it don't benefit from the caching mechanism.
> +
> +Multiple Source Control Repositories
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +For some recipes it is necessary to make use of more than one
> +version controlled source code repository. In such case, the recipe
> +must provide BitBake with information about how it should include
> +the different SCM revisions in its package version string, instead of it=
s
> +usual approach with a single :term:`SRCREV`.
> +
> +For this purpose, the recipe must set the :term:`SRCREV_FORMAT`
> +variable. Consider the following example::
> +
> +   SRC_URI =3D " \
> +       git://git.some.example.com/source-tree.git;name=3Dmachine \
> +       git://git.some.example.com/metadata.git;name=3Dmeta \
> +       "
> +   SRCREV_machine =3D "3f9db490a81eeb0077be3c5a5aa1388a2372232f"
> +   SRCREV_meta =3D "1ac1d0ff730fe1dd1371823d562db8126750a98c"
> +   SRCREV_FORMAT ?=3D "meta_machine"
> +
> +The value given to :term:`SRCREV_FORMAT` references names, which were
> +assigned using the ``name`` parameter in the :term:`SRC_URI` definition,
> +and which represent the version controlled source code repositories.
> +In the above example, the :term:`SRC_URI` contained two URLs named
> +"meta" and "machine".
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index e50b71380..7c864b69a 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -36,6 +36,14 @@ overview of their function and contents.
>        when specified allows for the Git binary from the host to be used
>        rather than building ``git-native``.
> =20
> +   :term:`AUTOREV`
> +      This is a special variable used during fetching. When :term:`SRCRE=
V` is
> +      set to the value of this variable, the latest revision from the ve=
rsion
> +      controlled source code repository is used.
> +      It should be set as follows::
> +
> +         SRCREV =3D "${AUTOREV}"
> +
>     :term:`AZ_SAS`
>        Azure Storage Shared Access Signature, when using the
>        :ref:`Azure Storage fetcher <bitbake-user-manual/bitbake-user-manu=
al-fetching:fetchers>`
> @@ -1622,7 +1630,8 @@ overview of their function and contents.
> =20
>        -  ``name``: Specifies a name to be used for association with
>           :term:`SRC_URI` checksums or :term:`SRCREV` when you have more =
than one
> -         file or git repository specified in :term:`SRC_URI`. For exampl=
e::
> +         file or source control repository specified in :term:`SRC_URI`.
> +         For example::
> =20
>              SRC_URI =3D "git://example.com/foo.git;branch=3Dmain;name=3D=
first \
>                         git://example.com/bar.git;branch=3Dmain;name=3Dse=
cond \
> @@ -1657,11 +1666,11 @@ overview of their function and contents.
>        identifier and not just a tag.
> =20
>     :term:`SRCREV_FORMAT`
> -      Helps construct valid :term:`SRCREV` values when
> +      Helps construct a valid package version string when
>        multiple source controlled URLs are used in
>        :term:`SRC_URI`.
> =20
> -      The system needs help constructing these values under these
> +      The system needs help constructing this value under these
>        circumstances. Each component in the :term:`SRC_URI` is assigned a=
 name
>        and these are referenced in the :term:`SRCREV_FORMAT` variable. Co=
nsider
>        an example with URLs named "machine" and "meta". In this case,

Looks good to me, thanks.

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


