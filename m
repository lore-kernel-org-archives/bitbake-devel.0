Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47411E68166
	for <webhook@archiver.kernel.org>; Tue, 17 Feb 2026 10:18:55 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9137.1771323528008408671
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Feb 2026 02:18:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Y4qN1RHZ;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E13E91A1030
	for <bitbake-devel@lists.openembedded.org>; Tue, 17 Feb 2026 10:18:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B6373606D1;
	Tue, 17 Feb 2026 10:18:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7AD4E1036894D;
	Tue, 17 Feb 2026 11:18:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771323525; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0HY6ky40/uv9KbJHhtZG3Z/QUCSuGLw2VnzApKK8Ojg=;
	b=Y4qN1RHZrCWFlykQk8+H6kUW+5FabHsT8PE29BRx5Nvi5oy8M+oU+gf1TZC61kUHi7EeDS
	Bfp1YZSBmD3At/ELHxI1ODVHdugWMi9QDJ6bIYJqETN4qk0VP7XV4AxcEfLnO3KCqh0XBi
	jmror/QY+JaZKXRU5VfqxznG7vt7fsAf2r7q0D3k01WYCgmxU3GQcIoEPKyOVJLOOuMLOT
	rN9JAtd3i1HmDf5ayeOWlLwJkjC79G8V44Wn5rJts9KIe5jvNrEZ28AI4aANeAHXslOn6r
	vNQaEt2GfC2JBneRaIzTWuSklTYIwa1y3e6wZfTmEBXMA5sumGwP9IEP2kTilA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Feb 2026 11:18:42 +0100
Message-Id: <DGH5S8O1WAJV.1GBNF55N3LGY2@bootlin.com>
Subject: Re: [docs] [PATCH v2 3/5] doc: bitbake-user-manual-ref-variables:
 expand and reorganize BBMASK explanations
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>,
 <docs@lists.yoctoproject.org>, "Quentin Schulz" <quentin.schulz@cherry.de>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <foss@0leil.net>, <bitbake-devel@lists.openembedded.org>
References: <20260216-bbmask-slashes-v2-0-b9bb52f5fd3d@cherry.de>
 <20260216-bbmask-slashes-v2-3-b9bb52f5fd3d@cherry.de>
In-Reply-To: <20260216-bbmask-slashes-v2-3-b9bb52f5fd3d@cherry.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Feb 2026 10:18:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19046

Hi,

On Mon Feb 16, 2026 at 11:36 AM CET, Quentin Schulz via lists.yoctoproject.=
org wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The documentation doesn't explain the side-effect of putting a leading
> slash, only the trailing slash.
>
> The leading slash is not for making the regular expression match an
> absolute path, but to force the match on the directory or file that
> exactly starts (and ends if there is a trailing slash) with the
> specified string. So let's explain that.
>
> This also explains that this doesn't prevent more than the intended path
> to be caught, specifically because it is NOT a regular expression
> matching an absolute path.
>
> Because any pattern not starting with a ^ character can match multiple
> directories from multiple directories, let's make the usage of
> BBFILE_PATTERN_my-layer the recommended one. Keep the rest as hints at
> what can happen when not using but reiterate what users should be using.
>
> Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  .../bitbake-user-manual-ref-variables.rst          | 87 ++++++++++++++++=
+++---
>  1 file changed, 78 insertions(+), 9 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index f20a9012c..06e1112b5 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -1052,24 +1052,93 @@ overview of their function and contents.
> =20
>        The following example uses a complete regular expression to tell
>        BitBake to ignore all recipe and recipe append files in
> -      ``meta-ti/recipes-misc/`` directories (and their subdirectories)::
> +      ``recipes-bsp`` directory (recursively) of ``meta-ti``::
> =20
> -         BBMASK =3D "/meta-ti/recipes-misc/"
> +         BBMASK =3D "${BBFILE_PATTERN_meta-ti}/recipes-bsp/"
> =20
>        If you want to mask out multiple directories or recipes, you can
>        specify multiple regular expression fragments. This next example
>        masks out multiple directories and individual recipes::
> =20
> -         BBMASK +=3D "/meta-ti/recipes-ti/packagegroup/"
> -         BBMASK +=3D "/meta-oe/recipes-support/"
> -         BBMASK +=3D "/meta-foo/.*/openldap"
> -         BBMASK +=3D "opencv.*\.bbappend"
> -         BBMASK +=3D "lzma"
> +         BBMASK +=3D "${BBFILE_PATTERN_meta-ti}/recipes-graphics/libgal/=
"
> +         BBMASK +=3D "${BBFILE_PATTERN_openembedded-layer}/recipes-suppo=
rt/"
> +         BBMASK +=3D "${BBFILE_PATTERN_openembedded-layer}/.*/openldap"
> +         BBMASK +=3D "${BBFILE_PATTERN_meta-ti}/.*/optee.*\.bbappend"
> +
> +      This masks the ``recipes-graphics/libgal/`` from ``meta-ti``, ever=
ything
> +      under ``recipes-support`` in ``meta-oe``, every directory or file =
whose
> +      name starts with ``openldap`` in ``meta-oe`` at any directory dept=
h > 1
> +      (e.g. in ``meta-oe``, ``recipes-foo/openldap-stuff/`` or
> +      ``recipes-bar/baz/openldap_0.1.bb`` but not ``openldap/``), every =
append
> +      file in ``meta-ti`` at any directory depth > 1 (e.g.

s/every append file/every append file starting with ``optee``/ ?

> +      ``optee/optee-examples_%.bbappend`` and
> +      ``recipes-security/optee/optee-client_%.bbappend``).
> =20
>        .. note::
> =20
> -         When specifying a directory name, use the trailing slash charac=
ter
> -         to ensure you match just that directory name.
> +         Because these are complete regular expressions, if you want to =
match a
> +         directory and not a file, you must end the expression with a tr=
ailing
> +         slash. That is::
> +
> +            BBMASK +=3D "${BBFILE_PATTERN_meta-ti}/recipes-graphics/libg=
al/"
> +
> +         Will match anything under ``recipes-graphics/ligbal/`` director=
y of
> +         ``meta-ti``. And::
> +
> +            BBMASK +=3D "${BBFILE_PATTERN_meta-ti}/recipes-graphics/libg=
al"
> +
> +         Will match in ``meta-ti`` any file prefixed with ``libgal`` in
> +         ``recipes-graphics/`` and any directory (recursively; and its
> +         recipes and recipe append files regardless how they are named) =
prefixed
> +         with ``libgal`` in ``recipes-graphics/``. That is, provided you=
r layers
> +         are available at ``/build/layers/``, it'll match::

s/build/builds/

Looks good otherwise, thanks for the reorganization!

Antonin

