Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E58D2068A
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 13:17:06 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43478.1764854221600713328
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Dec 2025 05:17:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=xd22hoet;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B49244E41A26;
	Thu,  4 Dec 2025 13:16:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 843A16068C;
	Thu,  4 Dec 2025 13:16:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B2DA1192257A;
	Thu,  4 Dec 2025 14:16:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764854218; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=T3z5n4EAfWwjjCHuEAbG6Yuhumc5+ep/l1Fa2ZzwU8s=;
	b=xd22hoetbxc8OsqRQ8dJvZ0UNq66a9ZyNw7vtqLFNLE5MJTgSUb8o0atn3FfYyxcWagPlt
	mJXSWZ0qRfOtuKpq/bSXwZ0zhD+50abHYEYUDljsEyQNmvu2w8TaHNufss6k6gFI/0Ejcd
	YoRhgr+MTbkyNPPRmuSU/h+7x2eSLtYn6c0ZOBzFVNv1pQVDrW1mFqgmJMmjbaz/u7PsX6
	nH4I2YLFQEqgMptVcD1NRHs+fgwSpvzr0itVYxMv/ikAgEXHMMV1Hm4pWnIalxYXhNy6Ml
	Z43A9OCU64w54XZ8Jzs4hjX8O+h9GO5WcGnMn+nkFNYCN42MiNeOe3uEVPxH3Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Dec 2025 14:16:56 +0100
Message-Id: <DEPGLUHKFVDU.65FX6MWV8NWY@bootlin.com>
Cc: <docs@lists.yoctoproject.org>, "Quentin Schulz"
 <quentin.schulz@cherry.de>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Quentin Schulz" <foss@0leil.net>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [PATCH 1/3] doc: fix a few typos
X-Mailer: aerc 0.21.0-30-g0177c1d31447
References: <20251203-doc-file-include-require-v1-0-fc708832b475@cherry.de>
 <20251203-doc-file-include-require-v1-1-fc708832b475@cherry.de>
In-Reply-To: <20251203-doc-file-include-require-v1-1-fc708832b475@cherry.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Dec 2025 13:17:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18542

On Wed Dec 3, 2025 at 6:06 PM CET, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Some spurious whitespaces, bad grammar and typo are fixed here.
>
> Fixes: 7bd36f6c6d33 ("doc: extend classes and include/require documentati=
on")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-intro.rst    | 4 ++--
>  doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/=
bitbake-user-manual/bitbake-user-manual-intro.rst
> index 9837b009e..2875e18f3 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> @@ -213,7 +213,7 @@ BitBake supports class files installed in three diffe=
rent directories:
> =20
>  -  ``classes-global/``: these classes must be inherited globally through=
 the
>     :term:`INHERIT` variable in a :ref:`configuration file
> -   <bitbake-user-manual/bitbake-user-manual-intro:Configuration Files>`.=
  These
> +   <bitbake-user-manual/bitbake-user-manual-intro:Configuration Files>`.=
 These
>     classes are included for every recipe being built. For example, you w=
ould use
>     the global class named ``myclass`` like so::
> =20
> @@ -227,7 +227,7 @@ BitBake supports class files installed in three diffe=
rent directories:
>        inherit myclass
> =20
>  -  ``classes/``: this final directory is meant for classes that can be u=
sed in
> -   the two contexts explain above. In other words, they can be inherit e=
ither
> +   the two contexts explain above. In other words, they can be inherited=
 either
>     globally or in a recipe.
> =20
>  For details on how BitBake locates class files, see the
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index e5075a346..ef8ab024d 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -1060,7 +1060,7 @@ Additionally, BitBake searches the current director=
y for :ref:`include
> =20
>  .. note::
> =20
> -   The BBPATH variable is analogous to the environment variable PATH .
> +   The BBPATH variable is analogous to the environment variable PATH.
> =20
>  For these two directives, BitBake includes the first file it finds.
> =20
> @@ -1135,7 +1135,7 @@ would be searched in this order::
> =20
>  .. note::
> =20
> -   Note that the order of the list above does not depend on where the cl=
ass in
> +   Note that the order of the list above does not depend on where the cl=
ass is
>     inherited from.
> =20
>  Likewise, for classes inherited with the :term:`INHERIT` variable, the

Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>

Thank you!
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


