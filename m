Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2865E7719A
	for <webhook@archiver.kernel.org>; Mon,  6 Jan 2025 09:37:10 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web10.56164.1736156223917783029
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Jan 2025 01:37:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=J8u+aPsA;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 35E68C000E;
	Mon,  6 Jan 2025 09:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736156221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8w/CkDYVLHAdlcpL+riks7fMskQ20s8/Ua3tyO1Pmw=;
	b=J8u+aPsALji1oxGGuL54EufDB7SanGLeMp756r+iHPmIUT90nMcXBSEogluFey3AF9EfA0
	X0Ez79G5ogXOJDx9sC/Ut2qYC0BDAblyPeksBPi4GdqPfzzYjdIOR/3dViswa1KrByYWe3
	MnJ1gMuTnJec/pATFxMyOAuQE2mWO8x6LaCG88dK2mc1B/rUK7JPf9jl/cyRsqA4cdTVc8
	BCc1aIBNK4H5MFNn5lqFlFcusVhh19U33UNkDxVx646Aw2R0j2K/itj0ZGAZZB+4MeDkBo
	4bWZ14Z7cx1PdCnTocKwlS3jhlqXbXOOoRaTGhhflICf/EzuUHgpDwtwoSeqEQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jan 2025 10:37:00 +0100
Message-Id: <D6UW0L5UHG5P.1JGNQ7WKC2N6@bootlin.com>
Subject: Re: [docs] [PATCH 1/2] doc/logging: small clean-up and name
 environment
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <joerg.sommer@navimatix.de>, <bitbake-devel@lists.openembedded.org>,
 <docs@lists.yoctoproject.org>
X-Mailer: aerc 0.18.2-100-gc2048ef30452-dirty
References: <2bf2a340cbf86391ae6722739f750f9d44f550b3.1735852948.git.joerg.sommer@navimatix.de>
In-Reply-To: <2bf2a340cbf86391ae6722739f750f9d44f550b3.1735852948.git.joerg.sommer@navimatix.de>
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Jan 2025 09:37:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16964

Hi J=C3=B6rg,

On Thu Jan 2, 2025 at 10:23 PM CET, J=C3=B6rg Sommer via lists.yoctoproject=
.org wrote:
> From: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
>
> The variable *BB_LOGCONFIG* is part of *BB_ENV_PASSTHROUGH_ADDITIONS* in
> /scripts/oe-buildenv-internal and can therefore be passed as environment
> variable.
>
> Signed-off-by: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
> ---
>  .../bitbake-user-manual-execution.rst                 | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/=
doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> index d58fbb32e..0e20d5933 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> @@ -671,7 +671,7 @@ logging configuration is merged using the following r=
ules:
> =20
>  -  Any keys defined in the ``handlers``, ``formatters``, or ``filters``,
>     will be merged into the same section in the default configuration,
> -   with the user specified keys taking replacing a default one if there
> +   with the user specified keys replacing a default one if there
>     is a conflict. In practice, this means that if both the default
>     configuration and user configuration specify a handler named
>     ``myhandler``, the user defined one will replace the default. To
> @@ -707,9 +707,9 @@ or higher priority to a file called ``hashequiv.log``=
::
>             }
>         },
>         "formatters": {
> -               "logfileFormatter": {
> -                   "format": "%(name)s: %(levelname)s: %(message)s"
> -               }
> +           "logfileFormatter": {
> +               "format": "%(name)s: %(levelname)s: %(message)s"
> +           }
>         },
>         "loggers": {
>             "BitBake.SigGen.HashEquiv": {
> @@ -723,7 +723,8 @@ or higher priority to a file called ``hashequiv.log``=
::
>         }
>     }
> =20
> -Then set the :term:`BB_LOGCONFIG` variable in ``conf/local.conf``::
> +Then set :term:`BB_LOGCONFIG` as an environment variable when running
> +bitbake, or set it in ``conf/local.conf``::

Like in the rest of the document: s/bitbake/BitBake/

>
>     BB_LOGCONFIG =3D "hashequiv.json"
> =20


Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

